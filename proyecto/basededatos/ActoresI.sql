-- ============================================
-- ACTORES I - IMPLEMENTACIÓN DE PAQUETES DE ACTORES
-- ============================================

-- ============================================
-- IMPLEMENTACIÓN: pkg_persona_comun
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_persona_comun AS

    PROCEDURE registrar_avistamiento(
        p_id_avistamiento  NUMBER,
        p_id_especie       NUMBER,
        p_id_persona_acad  NUMBER,
        p_fecha            DATE,
        p_cantidad         NUMBER,
        p_foto             VARCHAR2,
        p_observaciones    VARCHAR2
    ) IS
    BEGIN
        IF p_id_especie IS NULL OR p_fecha IS NULL THEN
            RAISE_APPLICATION_ERROR(-20200, 'registrar_avistamiento: IdEspecie y Fecha son obligatorios.');
        END IF;
        IF p_cantidad <= 0 THEN
            RAISE_APPLICATION_ERROR(-20201, 'registrar_avistamiento: La cantidad debe ser mayor a 0.');
        END IF;
        INSERT INTO Avistamientos(IdAvistamiento, IdEspecie, IdPersonaAcademica, IdAdministrador, Fecha, Cantidad, Foto, Observaciones)
        VALUES (p_id_avistamiento, p_id_especie, p_id_persona_acad, NULL, p_fecha, p_cantidad, p_foto, p_observaciones);
        COMMIT;
    END registrar_avistamiento;

    PROCEDURE crear_reserva(
        p_id_reserva  NUMBER,
        p_id_usuario  NUMBER,
        p_fecha       DATE,
        p_personas    NUMBER
    ) IS
    BEGIN
        IF p_id_usuario IS NULL OR p_fecha IS NULL THEN
            RAISE_APPLICATION_ERROR(-20202, 'crear_reserva: IdUsuario y Fecha son obligatorios.');
        END IF;
        IF p_personas <= 0 THEN
            RAISE_APPLICATION_ERROR(-20203, 'crear_reserva: El numero de personas debe ser mayor a 0.');
        END IF;
        INSERT INTO Reservas(IdReserva, IdUsuario, Fecha, Personas, Estado)
        VALUES (p_id_reserva, p_id_usuario, p_fecha, p_personas, 'Pendiente');
        COMMIT;
    END crear_reserva;

    PROCEDURE modificar_reserva(
        p_id_reserva  NUMBER,
        p_personas    NUMBER,
        p_estado      VARCHAR2
    ) IS
        v_count  NUMBER;
        v_estado Reservas.Estado%TYPE;
    BEGIN
        SELECT COUNT(*), MAX(Estado) INTO v_count, v_estado
        FROM Reservas WHERE IdReserva = p_id_reserva;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20204, 'modificar_reserva: No existe reserva con ID ' || p_id_reserva);
        END IF;
        IF v_estado = 'Cancelada' THEN
            RAISE_APPLICATION_ERROR(-20205, 'modificar_reserva: No se puede modificar una reserva cancelada.');
        END IF;
        IF p_personas IS NOT NULL AND p_personas <= 0 THEN
            RAISE_APPLICATION_ERROR(-20206, 'modificar_reserva: El numero de personas debe ser mayor a 0.');
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('Pendiente','Confirmada','Cancelada') THEN
            RAISE_APPLICATION_ERROR(-20207, 'modificar_reserva: Estado invalido: ' || p_estado);
        END IF;
        UPDATE Reservas
        SET Personas = NVL(p_personas, Personas),
            Estado   = NVL(p_estado,   Estado)
        WHERE IdReserva = p_id_reserva;
        COMMIT;
    END modificar_reserva;

    PROCEDURE cancelar_reserva(
        p_id_reserva  NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Reservas WHERE IdReserva = p_id_reserva;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20208, 'cancelar_reserva: No existe reserva con ID ' || p_id_reserva);
        END IF;
        UPDATE Reservas SET Estado = 'Cancelada'
        WHERE IdReserva = p_id_reserva;
        COMMIT;
    END cancelar_reserva;

    PROCEDURE registrar_pago(
        p_id_pago     NUMBER,
        p_id_reserva  NUMBER,
        p_id_tour     NUMBER,
        p_id_asesoria NUMBER,
        p_monto       NUMBER,
        p_fecha_pago  DATE
    ) IS
    BEGIN
        IF p_monto <= 0 THEN
            RAISE_APPLICATION_ERROR(-20209, 'registrar_pago: El monto debe ser mayor a 0.');
        END IF;
        IF (p_id_tour IS NOT NULL AND p_id_asesoria IS NOT NULL) OR
           (p_id_tour IS NULL     AND p_id_asesoria IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20210, 'registrar_pago: El pago debe estar asociado a un Tour O a una Asesoria, no ambos ni ninguno.');
        END IF;
        INSERT INTO Pagos(IdPago, IdReserva, IdTour, IdAsesoria, Monto, FechaPago, Estado)
        VALUES (p_id_pago, p_id_reserva, p_id_tour, p_id_asesoria, p_monto, p_fecha_pago, 'Pendiente');
        COMMIT;
    END registrar_pago;

    PROCEDURE consultar_tours_disponibles IS
    BEGIN
        FOR r IN (
            SELECT t.IdTour, t.Fecha, t.Duracion, t.Cupo, t.Guia, t.Longitud,
                   LISTAGG(u.Nombre, ', ') WITHIN GROUP (ORDER BY u.Nombre) AS Ubicaciones
            FROM Tours t
            JOIN Tours_Ubicacion tu ON t.IdTour = tu.IdTour
            JOIN Ubicaciones u       ON tu.IdUbicacion = u.IdUbicacion
            WHERE t.Fecha >= SYSDATE AND t.Cupo > 0
            GROUP BY t.IdTour, t.Fecha, t.Duracion, t.Cupo, t.Guia, t.Longitud
            ORDER BY t.Fecha
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Tour: '       || r.IdTour    ||
                                 ' | Fecha: '   || r.Fecha     ||
                                 ' | Cupo: '    || r.Cupo      ||
                                 ' | Guia: '    || r.Guia      ||
                                 ' | Lugares: ' || r.Ubicaciones);
        END LOOP;
    END consultar_tours_disponibles;

    PROCEDURE consultar_estado_reserva(p_id_usuario NUMBER) IS
    BEGIN
        FOR r IN (
            SELECT r.IdReserva, r.IdUsuario, r.Fecha AS FechaReserva,
                   r.Personas, r.Estado AS EstadoReserva,
                   p.Monto, p.Estado AS EstadoPago, p.FechaPago
            FROM Reservas r
            LEFT JOIN Pagos p ON p.IdReserva = r.IdReserva
            WHERE r.IdUsuario = p_id_usuario
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Reserva: '      || r.IdReserva    ||
                                 ' | Estado: '    || r.EstadoReserva ||
                                 ' | Monto: '     || r.Monto         ||
                                 ' | Pago: '      || r.EstadoPago);
        END LOOP;
    END consultar_estado_reserva;

    PROCEDURE consultar_perfil(p_id_usuario NUMBER) IS
    BEGIN
        FOR r IN (
            SELECT u.IdUsuario, u.Nombre, u.Email, u.TipoUsuario,
                   pc.DocumentoIdentidad, pc.NumeroCelular
            FROM Usuarios u
            LEFT JOIN PersonasComunes pc ON u.IdUsuario = pc.IdUsuario
            WHERE u.IdUsuario = p_id_usuario
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre: '   || r.Nombre           ||
                                 ' | Email: ' || r.Email             ||
                                 ' | Tipo: '  || r.TipoUsuario       ||
                                 ' | Doc: '   || r.DocumentoIdentidad);
        END LOOP;
    END consultar_perfil;

    PROCEDURE actualizar_perfil(
        p_id_usuario  NUMBER,
        p_nombre      VARCHAR2,
        p_email       VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Usuarios WHERE IdUsuario = p_id_usuario;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20211, 'actualizar_perfil: No existe usuario con ID ' || p_id_usuario);
        END IF;
        IF p_email IS NOT NULL AND p_email NOT LIKE '%@%' THEN
            RAISE_APPLICATION_ERROR(-20212, 'actualizar_perfil: Email invalido.');
        END IF;
        UPDATE Usuarios
        SET Nombre = NVL(p_nombre, Nombre),
            Email  = NVL(p_email,  Email)
        WHERE IdUsuario = p_id_usuario;
        COMMIT;
    END actualizar_perfil;

END pkg_persona_comun;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_persona_academica
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_persona_academica AS

    PROCEDURE crear_proyecto(
        p_id_proyecto      NUMBER,
        p_id_persona_acad  NUMBER,
        p_id_entidad_ed    NUMBER,
        p_nombre           VARCHAR2,
        p_fecha_inicio     DATE,
        p_fecha_fin        DATE,
        p_estado           VARCHAR2
    ) IS
    BEGIN
        IF p_nombre IS NULL OR p_fecha_inicio IS NULL OR p_estado IS NULL THEN
            RAISE_APPLICATION_ERROR(-20220, 'crear_proyecto: Nombre, FechaInicio y Estado son obligatorios.');
        END IF;
        IF p_estado NOT IN ('En curso','Finalizado','Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20221, 'crear_proyecto: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= p_fecha_inicio THEN
            RAISE_APPLICATION_ERROR(-20222, 'crear_proyecto: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        IF p_estado = 'En curso' AND p_fecha_fin IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20223, 'crear_proyecto: Un proyecto En curso no puede tener fecha de finalizacion.');
        END IF;
        IF p_estado IN ('Finalizado','Cancelado') AND p_fecha_fin IS NULL THEN
            RAISE_APPLICATION_ERROR(-20224, 'crear_proyecto: Un proyecto ' || p_estado || ' debe tener fecha de finalizacion.');
        END IF;
        INSERT INTO ProyectosInvestigacion(IdProyecto, IdPersonaAcademica, IdEntidadEducativa, Nombre, FechaInicio, FechaFinalizacion, Estado)
        VALUES (p_id_proyecto, p_id_persona_acad, p_id_entidad_ed, p_nombre, p_fecha_inicio, p_fecha_fin, p_estado);
        COMMIT;
    END crear_proyecto;

    PROCEDURE actualizar_proyecto(
        p_id_proyecto  NUMBER,
        p_nombre       VARCHAR2,
        p_fecha_fin    DATE,
        p_estado       VARCHAR2
    ) IS
        v_count  NUMBER;
        v_inicio ProyectosInvestigacion.FechaInicio%TYPE;
    BEGIN
        SELECT COUNT(*), MAX(FechaInicio) INTO v_count, v_inicio
        FROM ProyectosInvestigacion WHERE IdProyecto = p_id_proyecto;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20225, 'actualizar_proyecto: No existe proyecto con ID ' || p_id_proyecto);
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('En curso','Finalizado','Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20226, 'actualizar_proyecto: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= v_inicio THEN
            RAISE_APPLICATION_ERROR(-20227, 'actualizar_proyecto: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        UPDATE ProyectosInvestigacion
        SET Nombre            = NVL(p_nombre,    Nombre),
            FechaFinalizacion = NVL(p_fecha_fin, FechaFinalizacion),
            Estado            = NVL(p_estado,    Estado)
        WHERE IdProyecto = p_id_proyecto;
        COMMIT;
    END actualizar_proyecto;

    PROCEDURE eliminar_proyecto(
        p_id_proyecto  NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM ProyectosInvestigacion WHERE IdProyecto = p_id_proyecto;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20228, 'eliminar_proyecto: No existe proyecto con ID ' || p_id_proyecto);
        END IF;
        DELETE FROM ProyectosInvestigacion WHERE IdProyecto = p_id_proyecto;
        COMMIT;
    END eliminar_proyecto;

    PROCEDURE actualizar_asesoria(
        p_id_asesoria  NUMBER,
        p_fecha_fin    DATE,
        p_estado       VARCHAR2
    ) IS
        v_count  NUMBER;
        v_inicio Asesorias.FechaInicio%TYPE;
    BEGIN
        SELECT COUNT(*), MAX(FechaInicio) INTO v_count, v_inicio
        FROM Asesorias WHERE IdAsesoria = p_id_asesoria;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20229, 'actualizar_asesoria: No existe asesoria con ID ' || p_id_asesoria);
        END IF;
        IF p_estado IS NOT NULL AND p_estado NOT IN ('En curso','Finalizada','Cancelada') THEN
            RAISE_APPLICATION_ERROR(-20230, 'actualizar_asesoria: Estado invalido: ' || p_estado);
        END IF;
        IF p_fecha_fin IS NOT NULL AND p_fecha_fin <= v_inicio THEN
            RAISE_APPLICATION_ERROR(-20231, 'actualizar_asesoria: FechaFinalizacion debe ser posterior a FechaInicio.');
        END IF;
        UPDATE Asesorias
        SET FechaFinalizacion = NVL(p_fecha_fin, FechaFinalizacion),
            Estado            = NVL(p_estado,    Estado)
        WHERE IdAsesoria = p_id_asesoria;
        COMMIT;
    END actualizar_asesoria;

    PROCEDURE generar_reporte(
        p_id_reporte   NUMBER,
        p_id_asesoria  NUMBER,
        p_fecha        DATE
    ) IS
        v_count NUMBER;
    BEGIN
        IF p_fecha IS NULL THEN
            RAISE_APPLICATION_ERROR(-20232, 'generar_reporte: La fecha es obligatoria.');
        END IF;
        IF p_id_asesoria IS NOT NULL THEN
            SELECT COUNT(*) INTO v_count FROM Asesorias WHERE IdAsesoria = p_id_asesoria;
            IF v_count = 0 THEN
                RAISE_APPLICATION_ERROR(-20233, 'generar_reporte: No existe asesoria con ID ' || p_id_asesoria);
            END IF;
        END IF;
        INSERT INTO Reportes(IdReporte, IdAsesoria, Fecha)
        VALUES (p_id_reporte, p_id_asesoria, p_fecha);
        COMMIT;
    END generar_reporte;

    PROCEDURE consultar_avistamientos(p_id_persona_acad NUMBER) IS
    BEGIN
        FOR r IN (
            SELECT a.IdAvistamiento, a.Fecha, a.Cantidad,
                   e.NombreComun, e.NombreCientifico,
                   CASE WHEN a.IdAdministrador IS NOT NULL THEN 'Validado' ELSE 'Pendiente' END AS EstadoValidacion
            FROM Avistamientos a
            JOIN Especies e ON a.IdEspecie = e.IdEspecie
            WHERE a.IdPersonaAcademica = p_id_persona_acad
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Avistamiento: ' || r.IdAvistamiento  ||
                                 ' | Especie: '   || r.NombreComun      ||
                                 ' | Fecha: '     || r.Fecha            ||
                                 ' | Estado: '    || r.EstadoValidacion);
        END LOOP;
    END consultar_avistamientos;

    PROCEDURE consultar_especies IS
    BEGIN
        FOR r IN (
            SELECT IdEspecie, NombreComun, NombreCientifico
            FROM Especies
            ORDER BY NombreComun
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID: '            || r.IdEspecie        ||
                                 ' | Comun: '      || r.NombreComun      ||
                                 ' | Cientifico: ' || r.NombreCientifico);
        END LOOP;
    END consultar_especies;

    PROCEDURE consultar_proyectos(p_id_persona_acad NUMBER) IS
    BEGIN
        FOR r IN (
            SELECT pi.IdProyecto, pi.Nombre, pi.FechaInicio, pi.FechaFinalizacion,
                   pi.Estado, ee.NombreInstitucion AS Institucion
            FROM ProyectosInvestigacion pi
            JOIN EntidadesEducativas ee ON pi.IdEntidadEducativa = ee.IdUsuario
            WHERE pi.IdPersonaAcademica = p_id_persona_acad
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Proyecto: '       || r.Nombre      ||
                                 ' | Estado: '      || r.Estado       ||
                                 ' | Institucion: ' || r.Institucion);
        END LOOP;
    END consultar_proyectos;

    PROCEDURE consultar_asesorias IS
    BEGIN
        FOR r IN (
            SELECT a.IdAsesoria, a.FechaInicio, a.FechaFinalizacion, a.Estado,
                   rep.IdReporte, rep.Fecha AS FechaReporte
            FROM Asesorias a
            LEFT JOIN Reportes rep ON rep.IdAsesoria = a.IdAsesoria
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Asesoria: ' || r.IdAsesoria   ||
                                 ' | Estado: ' || r.Estado       ||
                                 ' | Inicio: ' || r.FechaInicio);
        END LOOP;
    END consultar_asesorias;

END pkg_persona_academica;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_administrador
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_administrador AS

    PROCEDURE crear_usuario(
        p_id_usuario  NUMBER,
        p_nombre      VARCHAR2,
        p_email       VARCHAR2,
        p_tipo        VARCHAR2
    ) IS
    BEGIN
        IF p_nombre IS NULL OR p_email IS NULL OR p_tipo IS NULL THEN
            RAISE_APPLICATION_ERROR(-20240, 'crear_usuario: Nombre, Email y TipoUsuario son obligatorios.');
        END IF;
        IF p_email NOT LIKE '%@%' THEN
            RAISE_APPLICATION_ERROR(-20241, 'crear_usuario: Email invalido.');
        END IF;
        IF p_tipo NOT IN ('PersonaComun','EntidadEducativa','EntidadCorporativa','PersonaAcademica','Administrador') THEN
            RAISE_APPLICATION_ERROR(-20242, 'crear_usuario: TipoUsuario invalido: ' || p_tipo);
        END IF;
        INSERT INTO Usuarios(IdUsuario, Nombre, Email, TipoUsuario)
        VALUES (p_id_usuario, p_nombre, p_email, p_tipo);
        COMMIT;
    END crear_usuario;

    PROCEDURE actualizar_usuario(
        p_id_usuario  NUMBER,
        p_nombre      VARCHAR2,
        p_email       VARCHAR2,
        p_tipo        VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Usuarios WHERE IdUsuario = p_id_usuario;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20243, 'actualizar_usuario: No existe usuario con ID ' || p_id_usuario);
        END IF;
        IF p_email IS NOT NULL AND p_email NOT LIKE '%@%' THEN
            RAISE_APPLICATION_ERROR(-20244, 'actualizar_usuario: Email invalido.');
        END IF;
        UPDATE Usuarios
        SET Nombre      = NVL(p_nombre, Nombre),
            Email       = NVL(p_email,  Email),
            TipoUsuario = NVL(p_tipo,   TipoUsuario)
        WHERE IdUsuario = p_id_usuario;
        COMMIT;
    END actualizar_usuario;

    PROCEDURE eliminar_usuario(
        p_id_usuario  NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Usuarios WHERE IdUsuario = p_id_usuario;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20245, 'eliminar_usuario: No existe usuario con ID ' || p_id_usuario);
        END IF;
        DELETE FROM Usuarios WHERE IdUsuario = p_id_usuario;
        COMMIT;
    END eliminar_usuario;

    PROCEDURE crear_tour(
        p_id_tour    NUMBER,
        p_fecha      DATE,
        p_duracion   VARCHAR2,
        p_cupo       NUMBER,
        p_guia       VARCHAR2,
        p_longitud   NUMBER,
        p_id_admin   NUMBER
    ) IS
    BEGIN
        IF p_fecha IS NULL OR p_duracion IS NULL OR p_guia IS NULL THEN
            RAISE_APPLICATION_ERROR(-20246, 'crear_tour: Fecha, Duracion y Guia son obligatorios.');
        END IF;
        IF p_cupo <= 0 THEN
            RAISE_APPLICATION_ERROR(-20247, 'crear_tour: El cupo debe ser mayor a 0.');
        END IF;
        IF p_longitud <= 0 THEN
            RAISE_APPLICATION_ERROR(-20248, 'crear_tour: La longitud debe ser mayor a 0.');
        END IF;
        -- p_id_admin es IdUsuario del Administrador
        INSERT INTO Tours(IdTour, Fecha, Duracion, Cupo, Guia, Longitud, IdAdministrador)
        VALUES (p_id_tour, p_fecha, p_duracion, p_cupo, p_guia, p_longitud, p_id_admin);
        COMMIT;
    END crear_tour;

    PROCEDURE actualizar_tour(
        p_id_tour   NUMBER,
        p_fecha     DATE,
        p_cupo      NUMBER,
        p_guia      VARCHAR2,
        p_longitud  NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Tours WHERE IdTour = p_id_tour;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20249, 'actualizar_tour: No existe tour con ID ' || p_id_tour);
        END IF;
        IF p_cupo IS NOT NULL AND p_cupo <= 0 THEN
            RAISE_APPLICATION_ERROR(-20250, 'actualizar_tour: El cupo debe ser mayor a 0.');
        END IF;
        UPDATE Tours
        SET Fecha    = NVL(p_fecha,    Fecha),
            Cupo     = NVL(p_cupo,     Cupo),
            Guia     = NVL(p_guia,     Guia),
            Longitud = NVL(p_longitud, Longitud)
        WHERE IdTour = p_id_tour;
        COMMIT;
    END actualizar_tour;

    PROCEDURE eliminar_tour(
        p_id_tour  NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Tours WHERE IdTour = p_id_tour;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20251, 'eliminar_tour: No existe tour con ID ' || p_id_tour);
        END IF;
        DELETE FROM Tours WHERE IdTour = p_id_tour;
        COMMIT;
    END eliminar_tour;

    PROCEDURE registrar_especie(
        p_id_especie        NUMBER,
        p_nombre_comun      VARCHAR2,
        p_nombre_cientifico VARCHAR2
    ) IS
    BEGIN
        IF p_nombre_comun IS NULL OR p_nombre_cientifico IS NULL THEN
            RAISE_APPLICATION_ERROR(-20252, 'registrar_especie: NombreComun y NombreCientifico son obligatorios.');
        END IF;
        INSERT INTO Especies(IdEspecie, NombreComun, NombreCientifico)
        VALUES (p_id_especie, p_nombre_comun, p_nombre_cientifico);
        COMMIT;
    END registrar_especie;

    PROCEDURE validar_avistamiento(
        p_id_avistamiento  NUMBER,
        p_id_administrador NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Avistamientos WHERE IdAvistamiento = p_id_avistamiento;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20253, 'validar_avistamiento: No existe avistamiento con ID ' || p_id_avistamiento);
        END IF;
        -- p_id_administrador es IdUsuario del Administrador
        UPDATE Avistamientos
        SET IdAdministrador = p_id_administrador
        WHERE IdAvistamiento = p_id_avistamiento;
        COMMIT;
    END validar_avistamiento;

    PROCEDURE consultar_usuarios IS
    BEGIN
        FOR r IN (
            SELECT u.IdUsuario, u.Nombre, u.Email, u.TipoUsuario,
                   CASE u.TipoUsuario
                       WHEN 'PersonaComun'       THEN pc.DocumentoIdentidad
                       WHEN 'EntidadCorporativa' THEN ec.NIT
                       WHEN 'EntidadEducativa'   THEN ee.NombreInstitucion
                       WHEN 'PersonaAcademica'   THEN pa.Profesion
                       WHEN 'Administrador'      THEN adm.Permisos
                       ELSE NULL
                   END AS DetalleSubtipo
            FROM Usuarios u
            LEFT JOIN PersonasComunes       pc  ON u.IdUsuario = pc.IdUsuario
            LEFT JOIN EntidadesCorporativas ec  ON u.IdUsuario = ec.IdUsuario
            LEFT JOIN EntidadesEducativas   ee  ON u.IdUsuario = ee.IdUsuario
            LEFT JOIN PersonasAcademicas    pa  ON u.IdUsuario = pa.IdUsuario
            LEFT JOIN Administradores      adm ON u.IdUsuario = adm.IdUsuario
            ORDER BY u.TipoUsuario
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID: '        || r.IdUsuario     ||
                                 ' | Nombre: ' || r.Nombre         ||
                                 ' | Tipo: '   || r.TipoUsuario    ||
                                 ' | Detalle: '|| r.DetalleSubtipo);
        END LOOP;
    END consultar_usuarios;

    PROCEDURE consultar_tours IS
    BEGIN
        FOR r IN (
            SELECT t.IdTour, t.Fecha, t.Duracion, t.Cupo, t.Guia, t.Longitud,
                   u.Nombre AS NombreAdministrador,
                   LISTAGG(ub.Nombre, ', ') WITHIN GROUP (ORDER BY ub.Nombre) AS Ubicaciones
            FROM Tours t
            LEFT JOIN Administradores adm ON t.IdAdministrador = adm.IdUsuario
            LEFT JOIN Usuarios u         ON adm.IdUsuario = u.IdUsuario
            JOIN Tours_Ubicacion tu      ON t.IdTour = tu.IdTour
            JOIN Ubicaciones ub           ON tu.IdUbicacion = ub.IdUbicacion
            GROUP BY t.IdTour, t.Fecha, t.Duracion, t.Cupo, t.Guia, t.Longitud, u.Nombre
            ORDER BY t.Fecha
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Tour: '      || r.IdTour             ||
                                 ' | Fecha: '  || r.Fecha              ||
                                 ' | Cupo: '   || r.Cupo               ||
                                 ' | Admin: '  || r.NombreAdministrador);
        END LOOP;
    END consultar_tours;

END pkg_administrador;
/

-- ============================================
-- IMPLEMENTACIÓN: pkg_admin_institucional
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_admin_institucional AS

    -- Vincula un nuevo usuario como EntidadEducativa.
    -- p_id_usuario_nuevo: IdUsuario ya existente en Usuarios que se quiere vincular.
    PROCEDURE vincular_usuario_institucion(
        p_id_usuario_nuevo   NUMBER,
        p_institucion        VARCHAR2,
        p_nombre_institucion VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        IF p_id_usuario_nuevo IS NULL OR p_institucion IS NULL OR p_nombre_institucion IS NULL THEN
            RAISE_APPLICATION_ERROR(-20260, 'vincular_usuario_institucion: IdUsuario, Institucion y NombreInstitucion son obligatorios.');
        END IF;
        SELECT COUNT(*) INTO v_count FROM Usuarios WHERE IdUsuario = p_id_usuario_nuevo;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20261, 'vincular_usuario_institucion: No existe usuario con ID ' || p_id_usuario_nuevo);
        END IF;
        INSERT INTO EntidadesEducativas(IdUsuario, Institucion, NombreInstitucion)
        VALUES (p_id_usuario_nuevo, p_institucion, p_nombre_institucion);
        COMMIT;
    END vincular_usuario_institucion;

    -- Desvincula una EntidadEducativa por IdUsuario
    PROCEDURE desvincular_usuario_institucion(
        p_id_entidad_educativa  NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM EntidadesEducativas WHERE IdUsuario = p_id_entidad_educativa;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20262, 'desvincular_usuario_institucion: No existe entidad educativa con IdUsuario ' || p_id_entidad_educativa);
        END IF;
        DELETE FROM EntidadesEducativas WHERE IdUsuario = p_id_entidad_educativa;
        COMMIT;
    END desvincular_usuario_institucion;

END pkg_admin_institucional;
/
