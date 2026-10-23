-- ============================================
-- PRUEBAS - HISTORIAS COMPLEMENTARIAS
-- Proyecto: VueloCopeton
-- ============================================

 
-- ============================================================
-- HISTORIA 1
-- Una academica descubre una especie nueva y lidera un proyecto
-- Maria Rodriguez (IdUsuario=4) registra un avistamiento de una
-- especie nueva, crea un proyecto de investigacion y genera reporte.
-- ============================================================
 
EXEC pkg_administrador.registrar_especie(20, 'Tucan Esmeralda', 'Aulacorhynchus prasinus');
 
EXEC pkg_persona_comun.registrar_avistamiento(50, 20, 4, SYSDATE, 2, '/fotos/tucan_esmeralda_01.jpg', 'Avistado en dosel del Bosque de Choco');
 
EXEC pkg_administrador.validar_avistamiento(50, 5);
 
EXEC pkg_persona_academica.crear_proyecto(20, 4, 2, 'Estudio del Tucan Esmeralda en el Choco', DATE '2025-06-01', NULL, 'En curso');
 
EXEC pkg_persona_academica.generar_reporte(20, NULL, SYSDATE);
 
EXEC pkg_persona_academica.consultar_avistamientos(4);
 
EXEC pkg_persona_academica.consultar_proyectos(4);
 
DELETE FROM Reportes WHERE IdReporte = 20;
DELETE FROM ProyectosInvestigacion WHERE IdProyecto = 20;
DELETE FROM Avistamientos WHERE IdAvistamiento = 50;
DELETE FROM Especies WHERE IdEspecie = 20;
COMMIT;
 
 
-- ============================================================
-- HISTORIA 2
-- Un turista reserva un tour, paga y cancela
-- Juan Perez (IdUsuario=1) busca tours, reserva, paga y cancela.
-- El administrador crea y gestiona el tour.
-- ============================================================
 
EXEC pkg_administrador.crear_tour(30, DATE '2025-12-01', '07:00', 10, 'Guia Especializado', 20000, 5);
 
EXEC pkg_persona_comun.consultar_tours_disponibles;
 
EXEC pkg_persona_comun.crear_reserva(30, 1, DATE '2025-12-01', 3);
 
EXEC pkg_persona_comun.registrar_pago(30, 30, 30, NULL, 60000, SYSDATE);
 
EXEC pkg_persona_comun.consultar_estado_reserva(1);
 
EXEC pkg_persona_comun.cancelar_reserva(30);
 
EXEC pkg_persona_comun.consultar_estado_reserva(1);
 
DELETE FROM Pagos WHERE IdPago = 30;
DELETE FROM Reservas WHERE IdReserva = 30;
DELETE FROM Tours WHERE IdTour = 30;
COMMIT;