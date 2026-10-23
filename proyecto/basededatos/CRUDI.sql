-- ============================================
-- CRUDI - IMPLEMENTACIÓN DE PAQUETES CRUD
-- ============================================

-- ============================================
-- IMPLEMENTACIÓN: pkg_usuario
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_usuario AS

    PROCEDURE crear_usuario(p_id NUMBER, p_nombre VARCHAR2, p_email VARCHAR2, p_tipo VARCHAR2) IS
    BEGIN
        IF p_nombre IS NULL OR p_email IS NULL OR p_tipo IS NULL THEN
            RAISE_APPLICATION_ERROR(-20100, 'crear_usuario: Nombre, Email y TipoUsuario son obligatorios.');
        END IF;
        IF p_email NOT LIKE '%@%' THEN
            RAISE_APPLICATION_ERROR(-20101, 'crear_usuario: Email invalido, debe contener @.');
        END IF;
        IF p_tipo NOT IN ('PersonaComun','EntidadEducativa','EntidadCorporativa','PersonaAcademica','Administrador') THEN
            RAISE_APPLICATION_ERROR(-20102, 'crear_usuario: TipoUsuario invalido: ' || p_tipo);
        END IF;
        INSERT INTO Usuarios VALUES (p_id, p_nombre, p_email, p_tipo);
        COMMIT;
    END crear_usuario;

    PROCEDURE leer_usuario(p_id NUMBER) IS
        v_nombre  Usuarios.Nombre%TYPE;
        v_email   Usuarios.Email%TYPE;
        v_tipo    Usuarios.TipoUsuario%TYPE;
    BEGIN
        SELECT Nombre, Email, TipoUsuario
        INTO v_nombre, v_email, v_tipo
        FROM Usuarios WHERE IdUsuario = p_id;
        DBMS_OUTPUT.PUT_LINE('Usuario [' || p_id || ']: ' || v_nombre || ' | ' || v_email || ' | ' || v_tipo);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20103, 'leer_usuario: No existe usuario con ID ' || p_id);
    END leer_usuario;

    PROCEDURE actualizar_usuario(p_id NUMBER, p_nombre VARCHAR2, p_email VARCHAR2, p_tipo VARCHAR2) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Usuarios WHERE IdUsuario = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20104, 'actualizar_usuario: No existe usuario con ID ' || p_id);
        END IF;
        IF p_email IS NOT NULL AND p_email NOT LIKE '%@%' THEN
            RAISE_APPLICATION_ERROR(-20105, 'actualizar_usuario: Email invalido.');
        END IF;
        UPDATE Usuarios
        SET Nombre      = NVL(p_nombre, Nombre),
            Email       = NVL(p_email,  Email),
            TipoUsuario = NVL(p_tipo,   TipoUsuario)
        WHERE IdUsuario = p_id;
        COMMIT;
    END actualizar_usuario;

    PROCEDURE eliminar_usuario(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Usuarios WHERE IdUsuario = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20106, 'eliminar_usuario: No existe usuario con ID ' || p_id);
        END IF;
        DELETE FROM Usuarios WHERE IdUsuario = p_id;
        COMMIT;
    END eliminar_usuario;

END pkg_usuario;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_tour
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_tour AS

    PROCEDURE crear_tour(p_id NUMBER, p_fecha DATE, p_duracion VARCHAR2, p_cupo NUMBER, p_guia VARCHAR2, p_longitud NUMBER, p_id_admin NUMBER) IS
    BEGIN
        IF p_fecha IS NULL OR p_duracion IS NULL OR p_guia IS NULL THEN
            RAISE_APPLICATION_ERROR(-20110, 'crear_tour: Fecha, Duracion y Guia son obligatorios.');
        END IF;
        IF p_cupo <= 0 THEN
            RAISE_APPLICATION_ERROR(-20111, 'crear_tour: El cupo debe ser mayor a 0.');
        END IF;
        IF p_longitud <= 0 THEN
            RAISE_APPLICATION_ERROR(-20112, 'crear_tour: La longitud debe ser mayor a 0.');
        END IF;
        -- p_id_admin es IdUsuario del Administrador
        INSERT INTO Tours VALUES (p_id, p_fecha, p_duracion, p_cupo, p_guia, p_longitud, p_id_admin);
        COMMIT;
    END crear_tour;

    PROCEDURE leer_tour(p_id NUMBER) IS
        v_fecha    Tours.Fecha%TYPE;
        v_cupo     Tours.Cupo%TYPE;
        v_guia     Tours.Guia%TYPE;
        v_longitud Tours.Longitud%TYPE;
    BEGIN
        SELECT Fecha, Cupo, Guia, Longitud
        INTO v_fecha, v_cupo, v_guia, v_longitud
        FROM Tours WHERE IdTour = p_id;
        DBMS_OUTPUT.PUT_LINE('Tour [' || p_id || ']: ' || v_fecha || ' | Cupo: ' || v_cupo || ' | Guia: ' || v_guia || ' | Long: ' || v_longitud);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20113, 'leer_tour: No existe tour con ID ' || p_id);
    END leer_tour;

    PROCEDURE actualizar_tour(p_id NUMBER, p_fecha DATE, p_cupo NUMBER, p_guia VARCHAR2, p_longitud NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Tours WHERE IdTour = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20114, 'actualizar_tour: No existe tour con ID ' || p_id);
        END IF;
        IF p_cupo IS NOT NULL AND p_cupo <= 0 THEN
            RAISE_APPLICATION_ERROR(-20115, 'actualizar_tour: El cupo debe ser mayor a 0.');
        END IF;
        IF p_longitud IS NOT NULL AND p_longitud <= 0 THEN
            RAISE_APPLICATION_ERROR(-20116, 'actualizar_tour: La longitud debe ser mayor a 0.');
        END IF;
        UPDATE Tours
        SET Fecha    = NVL(p_fecha,    Fecha),
            Cupo     = NVL(p_cupo,     Cupo),
            Guia     = NVL(p_guia,     Guia),
            Longitud = NVL(p_longitud, Longitud)
        WHERE IdTour = p_id;
        COMMIT;
    END actualizar_tour;

    PROCEDURE eliminar_tour(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Tours WHERE IdTour = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20117, 'eliminar_tour: No existe tour con ID ' || p_id);
        END IF;
        DELETE FROM Tours WHERE IdTour = p_id;
        COMMIT;
    END eliminar_tour;

END pkg_tour;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_reserva
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_reserva AS

    PROCEDURE crear_reserva(p_id NUMBER, p_id_usuario NUMBER, p_fecha DATE, p_personas NUMBER, p_estado VARCHAR2) IS
    BEGIN
        IF p_fecha IS NULL OR p_id_usuario IS NULL THEN
            RAISE_APPLICATION_ERROR(-20120, 'crear_reserva: Fecha e IdUsuario son obligatorios.');
        END IF;
        IF p_personas <= 0 THEN
            RAISE_APPLICATION_ERROR(-20121, 'crear_reserva: El numero de personas debe ser mayor a 0.');
        END IF;
        IF p_estado NOT IN ('Pendiente','Confirmada','Cancelada') THEN
            RAISE_APPLICATION_ERROR(-20122, 'crear_reserva: Estado invalido: ' || p_estado);
        END IF;
        INSERT INTO Reservas VALUES (p_id, p_id_usuario, p_fecha, p_personas, p_estado);
        COMMIT;
    END crear_reserva;

    PROCEDURE leer_reserva(p_id NUMBER) IS
        v_usuario  Reservas.IdUsuario%TYPE;
        v_fecha    Reservas.Fecha%TYPE;
        v_personas Reservas.Personas%TYPE;
        v_estado   Reservas.Estado%TYPE;
    BEGIN
        SELECT IdUsuario, Fecha, Personas, Estado
        INTO v_usuario, v_fecha, v_personas, v_estado
        FROM Reservas WHERE IdReserva = p_id;
        DBMS_OUTPUT.PUT_LINE('Reserva [' || p_id || ']: Usuario ' || v_usuario || ' | ' || v_fecha || ' | Personas: ' || v_personas || ' | ' || v_estado);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20123, 'leer_reserva: No existe reserva con ID ' || p_id);
    END leer_reserva;

    PROCEDURE actualizar_reserva(p_id NUMBER, p_personas NUMBER, p_estado VARCHAR2) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Reservas WHERE IdReserva = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20124, 'actualizar_reserva: No existe reserva con ID ' || p_id);
        END IF;
        IF p_personas IS NOT NULL AND p_personas <= 0 THEN
            RAISE_APPLICATION_ERROR(-20125, 'actualizar_reserva: El numero de personas debe ser mayor a 0.');
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('Pendiente','Confirmada','Cancelada') THEN
            RAISE_APPLICATION_ERROR(-20126, 'actualizar_reserva: Estado invalido: ' || p_estado);
        END IF;
        UPDATE Reservas
        SET Personas = NVL(p_personas, Personas),
            Estado   = NVL(p_estado,   Estado)
        WHERE IdReserva = p_id;
        COMMIT;
    END actualizar_reserva;

    PROCEDURE eliminar_reserva(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Reservas WHERE IdReserva = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20127, 'eliminar_reserva: No existe reserva con ID ' || p_id);
        END IF;
        DELETE FROM Reservas WHERE IdReserva = p_id;
        COMMIT;
    END eliminar_reserva;

END pkg_reserva;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_pago
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_pago AS

    PROCEDURE crear_pago(p_id NUMBER, p_id_reserva NUMBER, p_id_tour NUMBER, p_id_asesoria NUMBER, p_monto NUMBER, p_fecha DATE, p_estado VARCHAR2) IS
    BEGIN
        IF p_id_reserva IS NULL OR p_fecha IS NULL THEN
            RAISE_APPLICATION_ERROR(-20130, 'crear_pago: IdReserva y FechaPago son obligatorios.');
        END IF;
        IF (p_id_tour IS NOT NULL AND p_id_asesoria IS NOT NULL) OR
           (p_id_tour IS NULL AND p_id_asesoria IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20131, 'crear_pago: El pago debe estar asociado a Tour O Asesoria, no ambos ni ninguno (XOR).');
        END IF;
        IF p_monto <= 0 THEN
            RAISE_APPLICATION_ERROR(-20132, 'crear_pago: El monto debe ser mayor a 0.');
        END IF;
        IF p_estado NOT IN ('Pendiente','Completado','Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20133, 'crear_pago: Estado invalido: ' || p_estado);
        END IF;
        INSERT INTO Pagos VALUES (p_id, p_id_reserva, p_id_tour, p_id_asesoria, p_monto, p_fecha, p_estado);
        COMMIT;
    END crear_pago;

    PROCEDURE leer_pago(p_id NUMBER) IS
        v_reserva  Pagos.IdReserva%TYPE;
        v_monto    Pagos.Monto%TYPE;
        v_fecha    Pagos.FechaPago%TYPE;
        v_estado   Pagos.Estado%TYPE;
    BEGIN
        SELECT IdReserva, Monto, FechaPago, Estado
        INTO v_reserva, v_monto, v_fecha, v_estado
        FROM Pagos WHERE IdPago = p_id;
        DBMS_OUTPUT.PUT_LINE('Pago [' || p_id || ']: Reserva ' || v_reserva || ' | Monto: ' || v_monto || ' | ' || v_fecha || ' | ' || v_estado);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20134, 'leer_pago: No existe pago con ID ' || p_id);
    END leer_pago;

    PROCEDURE actualizar_pago(p_id NUMBER, p_monto NUMBER, p_estado VARCHAR2) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Pagos WHERE IdPago = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20135, 'actualizar_pago: No existe pago con ID ' || p_id);
        END IF;
        IF p_monto IS NOT NULL AND p_monto <= 0 THEN
            RAISE_APPLICATION_ERROR(-20136, 'actualizar_pago: El monto debe ser mayor a 0.');
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('Pendiente','Completado','Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20137, 'actualizar_pago: Estado invalido: ' || p_estado);
        END IF;
        UPDATE Pagos
        SET Monto  = NVL(p_monto,  Monto),
            Estado = NVL(p_estado, Estado)
        WHERE IdPago = p_id;
        COMMIT;
    END actualizar_pago;

    PROCEDURE eliminar_pago(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Pagos WHERE IdPago = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20138, 'eliminar_pago: No existe pago con ID ' || p_id);
        END IF;
        DELETE FROM Pagos WHERE IdPago = p_id;
        COMMIT;
    END eliminar_pago;

END pkg_pago;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_avistamiento
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_avistamiento AS

    PROCEDURE crear_avistamiento(p_id NUMBER, p_id_especie NUMBER, p_id_persona_acad NUMBER, p_id_admin NUMBER, p_fecha DATE, p_cantidad NUMBER, p_foto VARCHAR2, p_observaciones VARCHAR2) IS
    BEGIN
        IF p_id_especie IS NULL OR p_fecha IS NULL THEN
            RAISE_APPLICATION_ERROR(-20140, 'crear_avistamiento: IdEspecie y Fecha son obligatorios.');
        END IF;
        IF p_cantidad <= 0 THEN
            RAISE_APPLICATION_ERROR(-20141, 'crear_avistamiento: La cantidad debe ser mayor a 0.');
        END IF;
        -- p_id_persona_acad y p_id_admin son IdUsuario de los respectivos subtipos
        INSERT INTO Avistamientos VALUES (p_id, p_id_especie, p_id_persona_acad, p_id_admin, p_fecha, p_cantidad, p_foto, p_observaciones);
        COMMIT;
    END crear_avistamiento;

    PROCEDURE leer_avistamiento(p_id NUMBER) IS
        v_especie  Avistamientos.IdEspecie%TYPE;
        v_fecha    Avistamientos.Fecha%TYPE;
        v_cantidad Avistamientos.Cantidad%TYPE;
        v_obs      Avistamientos.Observaciones%TYPE;
    BEGIN
        SELECT IdEspecie, Fecha, Cantidad, Observaciones
        INTO v_especie, v_fecha, v_cantidad, v_obs
        FROM Avistamientos WHERE IdAvistamiento = p_id;
        DBMS_OUTPUT.PUT_LINE('Avistamiento [' || p_id || ']: Especie ' || v_especie || ' | ' || v_fecha || ' | Cantidad: ' || v_cantidad || ' | ' || v_obs);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20142, 'leer_avistamiento: No existe avistamiento con ID ' || p_id);
    END leer_avistamiento;

    PROCEDURE actualizar_avistamiento(p_id NUMBER, p_cantidad NUMBER, p_foto VARCHAR2, p_observaciones VARCHAR2) IS
        v_count  NUMBER;
        v_admin  Avistamientos.IdAdministrador%TYPE;
    BEGIN
        SELECT COUNT(*), MAX(IdAdministrador)
        INTO v_count, v_admin
        FROM Avistamientos WHERE IdAvistamiento = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20143, 'actualizar_avistamiento: No existe avistamiento con ID ' || p_id);
        END IF;
        IF v_admin IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20144, 'actualizar_avistamiento: El avistamiento ' || p_id || ' ya fue validado y no puede modificarse.');
        END IF;
        IF p_cantidad IS NOT NULL AND p_cantidad <= 0 THEN
            RAISE_APPLICATION_ERROR(-20145, 'actualizar_avistamiento: La cantidad debe ser mayor a 0.');
        END IF;
        UPDATE Avistamientos
        SET Cantidad      = NVL(p_cantidad,      Cantidad),
            Foto          = NVL(p_foto,          Foto),
            Observaciones = NVL(p_observaciones, Observaciones)
        WHERE IdAvistamiento = p_id;
        COMMIT;
    END actualizar_avistamiento;

    PROCEDURE eliminar_avistamiento(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Avistamientos WHERE IdAvistamiento = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20146, 'eliminar_avistamiento: No existe avistamiento con ID ' || p_id);
        END IF;
        DELETE FROM Avistamientos WHERE IdAvistamiento = p_id;
        COMMIT;
    END eliminar_avistamiento;

END pkg_avistamiento;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_especie
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_especie AS

    PROCEDURE crear_especie(p_id NUMBER, p_nombre_comun VARCHAR2, p_nombre_cientifico VARCHAR2) IS
    BEGIN
        IF p_nombre_comun IS NULL OR p_nombre_cientifico IS NULL THEN
            RAISE_APPLICATION_ERROR(-20150, 'crear_especie: NombreComun y NombreCientifico son obligatorios.');
        END IF;
        INSERT INTO Especies VALUES (p_id, p_nombre_comun, p_nombre_cientifico);
        COMMIT;
    END crear_especie;

    PROCEDURE leer_especie(p_id NUMBER) IS
        v_comun      Especies.NombreComun%TYPE;
        v_cientifico Especies.NombreCientifico%TYPE;
    BEGIN
        SELECT NombreComun, NombreCientifico
        INTO v_comun, v_cientifico
        FROM Especies WHERE IdEspecie = p_id;
        DBMS_OUTPUT.PUT_LINE('Especie [' || p_id || ']: ' || v_comun || ' (' || v_cientifico || ')');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20151, 'leer_especie: No existe especie con ID ' || p_id);
    END leer_especie;

    PROCEDURE actualizar_especie(p_id NUMBER, p_nombre_comun VARCHAR2, p_nombre_cientifico VARCHAR2) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Especies WHERE IdEspecie = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20152, 'actualizar_especie: No existe especie con ID ' || p_id);
        END IF;
        UPDATE Especies
        SET NombreComun      = NVL(p_nombre_comun,      NombreComun),
            NombreCientifico = NVL(p_nombre_cientifico, NombreCientifico)
        WHERE IdEspecie = p_id;
        COMMIT;
    END actualizar_especie;

    PROCEDURE eliminar_especie(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Especies WHERE IdEspecie = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20153, 'eliminar_especie: No existe especie con ID ' || p_id);
        END IF;
        DELETE FROM Especies WHERE IdEspecie = p_id;
        COMMIT;
    END eliminar_especie;

END pkg_especie;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_asesoria
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_asesoria AS

    PROCEDURE crear_asesoria(p_id NUMBER, p_fecha_inicio DATE, p_fecha_fin DATE, p_estado VARCHAR2) IS
    BEGIN
        IF p_fecha_inicio IS NULL OR p_estado IS NULL THEN
            RAISE_APPLICATION_ERROR(-20160, 'crear_asesoria: FechaInicio y Estado son obligatorios.');
        END IF;
        IF p_estado NOT IN ('En curso','Finalizada','Cancelada') THEN
            RAISE_APPLICATION_ERROR(-20161, 'crear_asesoria: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= p_fecha_inicio THEN
            RAISE_APPLICATION_ERROR(-20162, 'crear_asesoria: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        IF p_estado = 'En curso' AND p_fecha_fin IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20163, 'crear_asesoria: Una asesoria En curso no puede tener fecha de finalizacion.');
        END IF;
        IF p_estado IN ('Finalizada','Cancelada') AND p_fecha_fin IS NULL THEN
            RAISE_APPLICATION_ERROR(-20164, 'crear_asesoria: Una asesoria ' || p_estado || ' debe tener fecha de finalizacion.');
        END IF;
        INSERT INTO Asesorias VALUES (p_id, p_fecha_inicio, p_fecha_fin, p_estado);
        COMMIT;
    END crear_asesoria;

    PROCEDURE leer_asesoria(p_id NUMBER) IS
        v_inicio Asesorias.FechaInicio%TYPE;
        v_fin    Asesorias.FechaFinalizacion%TYPE;
        v_estado Asesorias.Estado%TYPE;
    BEGIN
        SELECT FechaInicio, FechaFinalizacion, Estado
        INTO v_inicio, v_fin, v_estado
        FROM Asesorias WHERE IdAsesoria = p_id;
        DBMS_OUTPUT.PUT_LINE('Asesoria [' || p_id || ']: Inicio: ' || v_inicio || ' | Fin: ' || NVL(TO_CHAR(v_fin), 'En curso') || ' | ' || v_estado);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20165, 'leer_asesoria: No existe asesoria con ID ' || p_id);
    END leer_asesoria;

    PROCEDURE actualizar_asesoria(p_id NUMBER, p_fecha_fin DATE, p_estado VARCHAR2) IS
        v_count  NUMBER;
        v_inicio Asesorias.FechaInicio%TYPE;
    BEGIN
        SELECT COUNT(*), MAX(FechaInicio)
        INTO v_count, v_inicio
        FROM Asesorias WHERE IdAsesoria = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20166, 'actualizar_asesoria: No existe asesoria con ID ' || p_id);
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('En curso','Finalizada','Cancelada') THEN
            RAISE_APPLICATION_ERROR(-20167, 'actualizar_asesoria: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= v_inicio THEN
            RAISE_APPLICATION_ERROR(-20168, 'actualizar_asesoria: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        UPDATE Asesorias
        SET FechaFinalizacion = NVL(p_fecha_fin, FechaFinalizacion),
            Estado            = NVL(p_estado,    Estado)
        WHERE IdAsesoria = p_id;
        COMMIT;
    END actualizar_asesoria;

    PROCEDURE eliminar_asesoria(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Asesorias WHERE IdAsesoria = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20169, 'eliminar_asesoria: No existe asesoria con ID ' || p_id);
        END IF;
        DELETE FROM Asesorias WHERE IdAsesoria = p_id;
        COMMIT;
    END eliminar_asesoria;

END pkg_asesoria;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_proyecto
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_proyecto AS

    PROCEDURE crear_proyecto(p_id NUMBER, p_id_persona_acad NUMBER, p_id_entidad_ed NUMBER, p_nombre VARCHAR2, p_fecha_inicio DATE, p_fecha_fin DATE, p_estado VARCHAR2) IS
    BEGIN
        IF p_nombre IS NULL OR p_fecha_inicio IS NULL OR p_estado IS NULL THEN
            RAISE_APPLICATION_ERROR(-20170, 'crear_proyecto: Nombre, FechaInicio y Estado son obligatorios.');
        END IF;
        IF p_estado NOT IN ('En curso','Finalizado','Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20171, 'crear_proyecto: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= p_fecha_inicio THEN
            RAISE_APPLICATION_ERROR(-20172, 'crear_proyecto: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        IF p_estado = 'En curso' AND p_fecha_fin IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20173, 'crear_proyecto: Un proyecto En curso no puede tener fecha de finalizacion.');
        END IF;
        IF p_estado IN ('Finalizado','Cancelado') AND p_fecha_fin IS NULL THEN
            RAISE_APPLICATION_ERROR(-20174, 'crear_proyecto: Un proyecto ' || p_estado || ' debe tener fecha de finalizacion.');
        END IF;
        -- p_id_persona_acad y p_id_entidad_ed son IdUsuario de los subtipos
        INSERT INTO ProyectosInvestigacion VALUES (p_id, p_id_persona_acad, p_id_entidad_ed, p_nombre, p_fecha_inicio, p_fecha_fin, p_estado);
        COMMIT;
    END crear_proyecto;

    PROCEDURE leer_proyecto(p_id NUMBER) IS
        v_nombre  ProyectosInvestigacion.Nombre%TYPE;
        v_inicio  ProyectosInvestigacion.FechaInicio%TYPE;
        v_fin     ProyectosInvestigacion.FechaFinalizacion%TYPE;
        v_estado  ProyectosInvestigacion.Estado%TYPE;
    BEGIN
        SELECT Nombre, FechaInicio, FechaFinalizacion, Estado
        INTO v_nombre, v_inicio, v_fin, v_estado
        FROM ProyectosInvestigacion WHERE IdProyecto = p_id;
        DBMS_OUTPUT.PUT_LINE('Proyecto [' || p_id || ']: ' || v_nombre || ' | Inicio: ' || v_inicio || ' | Fin: ' || NVL(TO_CHAR(v_fin), 'En curso') || ' | ' || v_estado);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20175, 'leer_proyecto: No existe proyecto con ID ' || p_id);
    END leer_proyecto;

    PROCEDURE actualizar_proyecto(p_id NUMBER, p_nombre VARCHAR2, p_fecha_fin DATE, p_estado VARCHAR2) IS
        v_count  NUMBER;
        v_inicio ProyectosInvestigacion.FechaInicio%TYPE;
    BEGIN
        SELECT COUNT(*), MAX(FechaInicio)
        INTO v_count, v_inicio
        FROM ProyectosInvestigacion WHERE IdProyecto = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20176, 'actualizar_proyecto: No existe proyecto con ID ' || p_id);
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('En curso','Finalizado','Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20177, 'actualizar_proyecto: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= v_inicio THEN
            RAISE_APPLICATION_ERROR(-20178, 'actualizar_proyecto: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        UPDATE ProyectosInvestigacion
        SET Nombre            = NVL(p_nombre,    Nombre),
            FechaFinalizacion = NVL(p_fecha_fin, FechaFinalizacion),
            Estado            = NVL(p_estado,    Estado)
        WHERE IdProyecto = p_id;
        COMMIT;
    END actualizar_proyecto;

    PROCEDURE eliminar_proyecto(p_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM ProyectosInvestigacion WHERE IdProyecto = p_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20179, 'eliminar_proyecto: No existe proyecto con ID ' || p_id);
        END IF;
        DELETE FROM ProyectosInvestigacion WHERE IdProyecto = p_id;
        COMMIT;
    END eliminar_proyecto;

END pkg_proyecto;
/
