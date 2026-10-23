-- ============================================
-- XPOBLAR - ELIMINACIÓN DE DATOS
-- ============================================

DELETE FROM ProyectosInvestigacion_Reporte;
DELETE FROM ProyectosInvestigacion;
DELETE FROM Reportes;
DELETE FROM Asesorias;
DELETE FROM Avistamientos_Ubicacion;
DELETE FROM Avistamientos;
DELETE FROM Especies;
DELETE FROM Tours_Ubicacion;
DELETE FROM Tours;
DELETE FROM Ubicaciones;
DELETE FROM Pagos;
DELETE FROM Reservas;
DELETE FROM Administradores;
DELETE FROM PersonasAcademicas;
DELETE FROM EntidadesCorporativas;
DELETE FROM EntidadesEducativas;
DELETE FROM PersonasComunes;
DELETE FROM Usuarios;

COMMIT;