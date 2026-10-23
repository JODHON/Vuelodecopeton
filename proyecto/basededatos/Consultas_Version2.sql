-- ============================================
-- CONSULTAS - CONSULTAS SQL
-- ============================================

-- 1. Mostrar todos los tours con sus ubicaciones
SELECT t.IdTour, t.Guia, t.Duracion, u.Nombre
FROM Tours t
JOIN Tours_Ubicacion tu ON t.IdTour = tu.IdTour
JOIN Ubicaciones u ON tu.IdUbicacion = u.IdUbicacion
ORDER BY t.IdTour;

-- 2. Mostrar avistamientos registrados por PersonaAcademica
SELECT a.IdAvistamiento, a.Fecha, e.NombreComun, us.Nombre as Usuario
FROM Avistamientos a
JOIN Especies e ON a.IdEspecie = e.IdEspecie
JOIN PersonasAcademicas pa ON a.IdPersonaAcademica = pa.IdUsuario
JOIN Usuarios us ON pa.IdUsuario = us.IdUsuario
ORDER BY a.Fecha DESC;

-- 3. Mostrar pagos mayores a $200,000
SELECT p.IdPago, r.IdReserva, p.Monto, p.FechaPago, p.Estado
FROM Pagos p
JOIN Reservas r ON p.IdReserva = r.IdReserva
WHERE p.Monto > 200000
ORDER BY p.Monto DESC;

-- 4. Mostrar reservas confirmadas de usuarios
SELECT r.IdReserva, u.Nombre, r.Fecha, r.Personas, r.Estado
FROM Reservas r
JOIN Usuarios u ON r.IdUsuario = u.IdUsuario
WHERE r.Estado = 'Confirmada'
ORDER BY r.Fecha;

-- 5. Mostrar especies en peligro (por nombre)
SELECT e.IdEspecie, e.NombreComun, e.NombreCientifico
FROM Especies e
WHERE e.NombreComun LIKE '%Águila%' OR e.NombreComun LIKE '%Cóndor%'
ORDER BY e.NombreComun;

-- 6. Mostrar asesorías activas
SELECT a.IdAsesoria, a.FechaInicio, a.Estado
FROM Asesorias a
WHERE a.Estado = 'En curso'
ORDER BY a.FechaInicio;

-- 7. Mostrar proyectos de investigación finalizados
SELECT p.IdProyecto, p.Nombre, p.FechaInicio, p.FechaFinalizacion, p.Estado
FROM ProyectosInvestigacion p
WHERE p.Estado = 'Finalizado'
ORDER BY p.FechaFinalizacion DESC;

-- 8. Mostrar avistamientos por ubicación
SELECT u.Nombre as Ubicacion, COUNT(au.IdAvistamiento) as TotalAvistamientos
FROM Ubicaciones u
LEFT JOIN Avistamientos_Ubicacion au ON u.IdUbicacion = au.IdUbicacion
GROUP BY u.IdUbicacion, u.Nombre
ORDER BY TotalAvistamientos DESC;

-- 9. Mostrar detalle completo de pagos
SELECT p.IdPago, u.Nombre as Usuario, p.Monto, p.FechaPago, p.Estado,
       CASE
           WHEN p.IdTour IS NOT NULL THEN 'Tour'
           WHEN p.IdAsesoria IS NOT NULL THEN 'Asesoria'
           ELSE 'Ninguno'
       END as TipoPago
FROM Pagos p
JOIN Reservas r ON p.IdReserva = r.IdReserva
JOIN Usuarios u ON r.IdUsuario = u.IdUsuario
ORDER BY p.FechaPago DESC;

-- 10. Mostrar total de ingresos por estado de pago
SELECT p.Estado, SUM(p.Monto) as TotalIngresos, COUNT(*) as CantidadPagos
FROM Pagos p
GROUP BY p.Estado
ORDER BY TotalIngresos DESC;

-- 11. Mostrar tours gestionados por administrador
SELECT adm.IdUsuario AS IdAdministrador, u.Nombre as Administrador, COUNT(t.IdTour) as TotalTours
FROM Administradores adm
JOIN Usuarios u ON adm.IdUsuario = u.IdUsuario
LEFT JOIN Tours t ON adm.IdUsuario = t.IdAdministrador
GROUP BY adm.IdUsuario, u.Nombre
ORDER BY TotalTours DESC;

-- 12. Mostrar avistamientos validados por administrador
SELECT adm.IdUsuario AS IdAdministrador, u.Nombre as Administrador, COUNT(av.IdAvistamiento) as TotalValidados
FROM Administradores adm
JOIN Usuarios u ON adm.IdUsuario = u.IdUsuario
LEFT JOIN Avistamientos av ON adm.IdUsuario = av.IdAdministrador
GROUP BY adm.IdUsuario, u.Nombre
ORDER BY TotalValidados DESC;

-- 13. Mostrar reportes generados por asesorías
SELECT r.IdReporte, r.Fecha, a.IdAsesoria, a.Estado as EstadoAsesoria
FROM Reportes r
LEFT JOIN Asesorias a ON r.IdAsesoria = a.IdAsesoria
ORDER BY r.Fecha DESC;

-- 14. Mostrar proyectos con sus reportes
SELECT p.IdProyecto, p.Nombre, COUNT(pr.IdReporte) as TotalReportes
FROM ProyectosInvestigacion p
LEFT JOIN ProyectosInvestigacion_Reporte pr ON p.IdProyecto = pr.IdProyecto
GROUP BY p.IdProyecto, p.Nombre
ORDER BY TotalReportes DESC;

-- 15. Mostrar usuarios y su tipo
SELECT u.IdUsuario, u.Nombre, u.Email, u.TipoUsuario
FROM Usuarios u
ORDER BY u.TipoUsuario, u.Nombre;

COMMIT;
