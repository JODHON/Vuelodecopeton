-- ============================================
-- VISTAS - DEFINICIÓN DE VISTAS
-- ============================================

-- ── VISTAS PARA PERSONA COMÚN ──

-- VW_TOURS_DISPONIBLES
CREATE OR REPLACE VIEW vw_tours_disponibles AS
SELECT
    t.IdTour,
    t.Fecha,
    t.Duracion,
    t.Cupo,
    t.Guia,
    t.Longitud,
    LISTAGG(u.Nombre, ', ') WITHIN GROUP (ORDER BY u.Nombre) AS Ubicaciones
FROM Tours t
JOIN Tours_Ubicacion tu ON t.IdTour = tu.IdTour
JOIN Ubicaciones u      ON tu.IdUbicacion = u.IdUbicacion
WHERE t.Fecha >= SYSDATE
  AND t.Cupo > 0
GROUP BY t.IdTour, t.Fecha, t.Duracion, t.Cupo, t.Guia, t.Longitud;

-- VW_ESTADO_RESERVA
CREATE OR REPLACE VIEW vw_estado_reserva AS
SELECT
    r.IdReserva,
    r.IdUsuario,
    r.Fecha        AS FechaReserva,
    r.Personas,
    r.Estado       AS EstadoReserva,
    p.Monto,
    p.Estado       AS EstadoPago,
    p.FechaPago
FROM Reservas r
LEFT JOIN Pagos p ON p.IdReserva = r.IdReserva;

-- VW_INFO_USUARIO
CREATE OR REPLACE VIEW vw_info_usuario AS
SELECT
    u.IdUsuario,
    u.Nombre,
    u.Email,
    u.TipoUsuario,
    pc.DocumentoIdentidad,
    pc.NumeroCelular
FROM Usuarios u
LEFT JOIN PersonasComunes pc ON u.IdUsuario = pc.IdUsuario;


-- ── VISTAS PARA PERSONA ACADÉMICA ──

-- VW_AVISTAMIENTOS
CREATE OR REPLACE VIEW vw_avistamientos AS
SELECT
    a.IdAvistamiento,
    a.IdPersonaAcademica,
    a.Fecha,
    a.Cantidad,
    a.Foto,
    a.Observaciones,
    e.NombreComun,
    e.NombreCientifico,
    LISTAGG(ub.Nombre, ', ') WITHIN GROUP (ORDER BY ub.Nombre) AS Ubicaciones,
    CASE WHEN a.IdAdministrador IS NOT NULL THEN 'Validado' ELSE 'Pendiente' END AS EstadoValidacion
FROM Avistamientos a
JOIN Especies e                  ON a.IdEspecie = e.IdEspecie
JOIN Avistamientos_Ubicacion au  ON a.IdAvistamiento = au.IdAvistamiento
JOIN Ubicaciones ub              ON au.IdUbicacion = ub.IdUbicacion
GROUP BY a.IdAvistamiento, a.IdPersonaAcademica, a.Fecha, a.Cantidad, a.Foto,
         a.Observaciones, e.NombreComun, e.NombreCientifico, a.IdAdministrador;

-- VW_ESPECIES
CREATE OR REPLACE VIEW vw_especies AS
SELECT
    IdEspecie,
    NombreComun,
    NombreCientifico
FROM Especies
ORDER BY NombreComun;

-- VW_PROYECTOS
CREATE OR REPLACE VIEW vw_proyectos AS
SELECT
    pi.IdProyecto,
    pi.IdPersonaAcademica,
    pi.Nombre,
    pi.FechaInicio,
    pi.FechaFinalizacion,
    pi.Estado,
    ee.NombreInstitucion AS Institucion
FROM ProyectosInvestigacion pi
JOIN EntidadesEducativas ee ON pi.IdEntidadEducativa = ee.IdUsuario;

-- VW_ASESORIAS
CREATE OR REPLACE VIEW vw_asesorias AS
SELECT
    a.IdAsesoria,
    a.FechaInicio,
    a.FechaFinalizacion,
    a.Estado,
    r.IdReporte,
    r.Fecha AS FechaReporte
FROM Asesorias a
LEFT JOIN Reportes r ON r.IdAsesoria = a.IdAsesoria;


-- ── VISTAS PARA ADMINISTRADOR ──

-- VW_USUARIOS
CREATE OR REPLACE VIEW vw_usuarios AS
SELECT
    u.IdUsuario,
    u.Nombre,
    u.Email,
    u.TipoUsuario,
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
LEFT JOIN Administradores      adm ON u.IdUsuario = adm.IdUsuario;

-- VW_TOURS_ADMIN
CREATE OR REPLACE VIEW vw_tours_admin AS
SELECT
    t.IdTour,
    t.Fecha,
    t.Duracion,
    t.Cupo,
    t.Guia,
    t.Longitud,
    u.Nombre AS NombreAdministrador,
    LISTAGG(ub.Nombre, ', ') WITHIN GROUP (ORDER BY ub.Nombre) AS Ubicaciones
FROM Tours t
LEFT JOIN Administradores adm ON t.IdAdministrador = adm.IdUsuario
LEFT JOIN Usuarios u          ON adm.IdUsuario = u.IdUsuario
JOIN Tours_Ubicacion tu       ON t.IdTour = tu.IdTour
JOIN Ubicaciones ub           ON tu.IdUbicacion = ub.IdUbicacion
GROUP BY t.IdTour, t.Fecha, t.Duracion, t.Cupo, t.Guia, t.Longitud, u.Nombre;

COMMIT;
