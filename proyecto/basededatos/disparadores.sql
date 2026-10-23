-- DISPARADOR 1: Validar Fechas Asesoria
-- Tabla: Asesorias | Operación: INSERT | Momento: BEFORE
CREATE OR REPLACE TRIGGER trg_validar_fechas_asesoria
BEFORE INSERT ON Asesorias
FOR EACH ROW
BEGIN
    IF :NEW.FechaFinalizacion IS NOT NULL AND :NEW.FechaFinalizacion <= :NEW.FechaInicio THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de finalizacion debe ser posterior a la fecha de inicio en Asesoria.');
    END IF;
END;
/

-- DISPARADOR 2: Validar Fechas Proyecto
-- Tabla: ProyectosInvestigacion | Operación: INSERT | Momento: BEFORE
CREATE OR REPLACE TRIGGER trg_validar_fechas_proyecto
BEFORE INSERT ON ProyectosInvestigacion
FOR EACH ROW
BEGIN
    IF :NEW.FechaFinalizacion IS NOT NULL AND :NEW.FechaFinalizacion <= :NEW.FechaInicio THEN
        RAISE_APPLICATION_ERROR(-20002, 'La fecha de finalizacion debe ser posterior a la fecha de inicio en ProyectosInvestigacion.');
    END IF;
END;
/

-- DISPARADOR 3: Proteger Avistamientos Validados
-- Tabla: Avistamientos | Operación: UPDATE | Momento: BEFORE
CREATE OR REPLACE TRIGGER trg_proteger_avistamiento_validado
BEFORE UPDATE ON Avistamientos
FOR EACH ROW
BEGIN
    IF :OLD.IdAdministrador IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'El avistamiento con ID ' || :OLD.IdAvistamiento || ' ya fue validado y no puede ser modificado.');
    END IF;
END;
/

-- DISPARADOR 4: Generar ID Consecutivo - Usuarios
-- Tabla: Usuarios | Operación: INSERT | Momento: BEFORE
CREATE SEQUENCE seq_usuario START WITH 100 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER trg_id_usuario
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF :NEW.IdUsuario IS NULL THEN
        :NEW.IdUsuario := seq_usuario.NEXTVAL;
    END IF;
END;
/

-- DISPARADOR 5: Validar Formato NIT
-- Tabla: EntidadesCorporativas | Operación: INSERT, UPDATE | Momento: BEFORE
CREATE OR REPLACE TRIGGER trg_validar_formato_nit
BEFORE INSERT OR UPDATE OF NIT ON EntidadesCorporativas
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.NIT, '^\d{3}-\d{7,8}-\d$') THEN
        RAISE_APPLICATION_ERROR(-20004,
            'NIT invalido: ' || :NEW.NIT ||
            '. Formato requerido: NNN-NNNNNNN-N o NNN-NNNNNNNN-N');
    END IF;
END;
/

-- DISPARADOR 6: Finalizar Asesoria al completar su Pago
-- Tabla: Pagos | Operación: UPDATE | Momento: AFTER
CREATE OR REPLACE TRIGGER trg_finalizar_asesoria_pago
AFTER UPDATE OF Estado ON Pagos
FOR EACH ROW
WHEN (NEW.Estado = 'Completado' AND NEW.IdAsesoria IS NOT NULL)
BEGIN
    UPDATE Asesorias
    SET Estado = 'Finalizada', FechaFinalizacion = SYSDATE
    WHERE IdAsesoria = :NEW.IdAsesoria;
END;
/
