-- ============================================
-- CRUDNOOK - CASOS INCORRECTOS USANDO PAQUETES
-- ============================================
SET SERVEROUTPUT ON;

-- ============================================
-- pkg_usuario
-- ============================================
-- Email sin arroba (error -20101)
EXEC pkg_usuario.crear_usuario(6000, 'Sin Arroba', 'correosinaformato', 'PersonaComun');

-- TipoUsuario inválido (error -20102)
EXEC pkg_usuario.crear_usuario(6001, 'Tipo Raro', 'tipo@raro.com', 'Visitante');

-- Nombre NULL (error -20100)
EXEC pkg_usuario.crear_usuario(6002, NULL, 'nulo@test.com', 'PersonaComun');

-- Leer usuario inexistente (error -20103)
EXEC pkg_usuario.leer_usuario(99999);

-- Actualizar usuario inexistente (error -20104)
EXEC pkg_usuario.actualizar_usuario(99999, 'Nadie', NULL, NULL);

-- Eliminar usuario inexistente (error -20106)
EXEC pkg_usuario.eliminar_usuario(99999);

-- ============================================
-- pkg_tour
-- ============================================
-- Cupo en cero (error -20111)
EXEC pkg_tour.crear_tour(6010, DATE '2025-08-01', '05:00', 0, 'Guia', 10000, 1);

-- Longitud negativa (error -20112)
EXEC pkg_tour.crear_tour(6011, DATE '2025-08-01', '05:00', 10, 'Guia', -500, 1);

-- Leer tour inexistente (error -20113)
EXEC pkg_tour.leer_tour(99999);

-- Actualizar cupo a negativo (error -20115)
EXEC pkg_tour.actualizar_tour(1, NULL, -5, NULL, NULL);

-- ============================================
-- pkg_reserva
-- ============================================
-- Personas en cero (error -20121)
EXEC pkg_reserva.crear_reserva(6020, 1, DATE '2025-08-01', 0, 'Pendiente');

-- Estado inválido (error -20122)
EXEC pkg_reserva.crear_reserva(6021, 1, DATE '2025-08-01', 2, 'En espera');

-- Actualizar estado inválido (error -20126)
EXEC pkg_reserva.actualizar_reserva(1, NULL, 'Bloqueada');

-- Eliminar reserva inexistente (error -20127)
EXEC pkg_reserva.eliminar_reserva(99999);

-- ============================================
-- pkg_pago
-- ============================================
-- XOR: ambos Tour y Asesoria (error -20131)
EXEC pkg_pago.crear_pago(6030, 1, 1, 1, 50000, DATE '2025-08-01', 'Pendiente');

-- XOR: ninguno (error -20131)
EXEC pkg_pago.crear_pago(6031, 1, NULL, NULL, 50000, DATE '2025-08-01', 'Pendiente');

-- Monto en cero (error -20132)
EXEC pkg_pago.crear_pago(6032, 1, 1, NULL, 0, DATE '2025-08-01', 'Pendiente');

-- Estado inválido (error -20133)
EXEC pkg_pago.crear_pago(6033, 1, 1, NULL, 50000, DATE '2025-08-01', 'Pagado');

-- Actualizar monto negativo (error -20136)
EXEC pkg_pago.actualizar_pago(1, -1000, NULL);

-- Leer pago inexistente (error -20134)
EXEC pkg_pago.leer_pago(99999);

-- ============================================
-- pkg_avistamiento
-- ============================================
-- Cantidad en cero (error -20141)
EXEC pkg_avistamiento.crear_avistamiento(6040, 1, 1, NULL, DATE '2025-08-01', 0, '/fotos/nok.jpg', 'NoOK');

-- Cantidad negativa (error -20141)
EXEC pkg_avistamiento.crear_avistamiento(6041, 1, 1, NULL, DATE '2025-08-01', -3, '/fotos/nok.jpg', 'NoOK');

-- Actualizar avistamiento ya validado (usa IdAvistamiento=1 que tiene IdAdministrador=1, error -20144)
EXEC pkg_avistamiento.actualizar_avistamiento(1, 10, NULL, NULL);

-- Leer avistamiento inexistente (error -20142)
EXEC pkg_avistamiento.leer_avistamiento(99999);

-- ============================================
-- pkg_especie
-- ============================================
-- NombreComun NULL (error -20150)
EXEC pkg_especie.crear_especie(6050, NULL, 'Especie sin nombre');

-- Leer especie inexistente (error -20151)
EXEC pkg_especie.leer_especie(99999);

-- Eliminar especie inexistente (error -20153)
EXEC pkg_especie.eliminar_especie(99999);

-- ============================================
-- pkg_asesoria
-- ============================================
-- Estado inválido (error -20161)
EXEC pkg_asesoria.crear_asesoria(6060, DATE '2025-01-01', NULL, 'Activa');

-- Fecha fin anterior a inicio (error -20162)
EXEC pkg_asesoria.crear_asesoria(6061, DATE '2025-06-01', DATE '2025-01-01', 'Finalizada');

-- En curso con fecha fin (error -20163)
EXEC pkg_asesoria.crear_asesoria(6062, DATE '2025-01-01', DATE '2025-06-01', 'En curso');

-- Finalizada sin fecha fin (error -20164)
EXEC pkg_asesoria.crear_asesoria(6063, DATE '2025-01-01', NULL, 'Finalizada');

-- Leer asesoria inexistente (error -20165)
EXEC pkg_asesoria.leer_asesoria(99999);

-- ============================================
-- pkg_proyecto
-- ============================================
-- Estado inválido (error -20171)
EXEC pkg_proyecto.crear_proyecto(6070, 1, 1, 'Proyecto Malo', DATE '2025-01-01', NULL, 'Suspendido');

-- Fecha fin anterior a inicio (error -20172)
EXEC pkg_proyecto.crear_proyecto(6071, 1, 1, 'Proyecto Fechas', DATE '2025-06-01', DATE '2025-01-01', 'Finalizado');

-- En curso con fecha fin (error -20173)
EXEC pkg_proyecto.crear_proyecto(6072, 1, 1, 'Proyecto EnCurso', DATE '2025-01-01', DATE '2025-12-31', 'En curso');

-- Finalizado sin fecha fin (error -20174)
EXEC pkg_proyecto.crear_proyecto(6073, 1, 1, 'Proyecto SinFin', DATE '2025-01-01', NULL, 'Finalizado');

-- Leer proyecto inexistente (error -20175)
EXEC pkg_proyecto.leer_proyecto(99999);
