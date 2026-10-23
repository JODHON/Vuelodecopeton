-- ============================================
-- CRUDOK - CASOS CORRECTOS USANDO PAQUETES
-- ============================================
SET SERVEROUTPUT ON;

-- ============================================
-- pkg_usuario
-- ============================================
-- Crear
EXEC pkg_usuario.crear_usuario(5000, 'Laura Gomez', 'laura@gmail.com', 'PersonaComun');
-- Leer
EXEC pkg_usuario.leer_usuario(5000);
-- Actualizar (email y nombre, tipo intacto)
EXEC pkg_usuario.actualizar_usuario(5000, 'Laura Gomez V.', 'laurav@gmail.com', NULL);
-- Verificar actualización
EXEC pkg_usuario.leer_usuario(5000);
-- Eliminar
EXEC pkg_usuario.eliminar_usuario(5000);

-- ============================================
-- pkg_especie
-- ============================================
EXEC pkg_especie.crear_especie(5001, 'Colibrí Pico Espada', 'Ensifera ensifera');
EXEC pkg_especie.leer_especie(5001);
EXEC pkg_especie.actualizar_especie(5001, 'Colibrí Pico de Espada', NULL);
EXEC pkg_especie.leer_especie(5001);
EXEC pkg_especie.eliminar_especie(5001);

-- ============================================
-- pkg_asesoria
-- ============================================
-- Crear en curso (sin fecha fin)
EXEC pkg_asesoria.crear_asesoria(5002, DATE '2025-03-01', NULL, 'En curso');
EXEC pkg_asesoria.leer_asesoria(5002);
-- Actualizar a finalizada con fecha fin
EXEC pkg_asesoria.actualizar_asesoria(5002, DATE '2025-06-01', 'Finalizada');
EXEC pkg_asesoria.leer_asesoria(5002);
EXEC pkg_asesoria.eliminar_asesoria(5002);

-- ============================================
-- pkg_tour
-- ============================================
EXEC pkg_tour.crear_tour(5003, DATE '2025-07-01', '06:00', 20, 'Carlos Aves', 12000, 1);
EXEC pkg_tour.leer_tour(5003);
EXEC pkg_tour.actualizar_tour(5003, NULL, 25, 'Carlos Aves Senior', NULL);
EXEC pkg_tour.leer_tour(5003);
EXEC pkg_tour.eliminar_tour(5003);

-- ============================================
-- pkg_reserva
-- ============================================
EXEC pkg_reserva.crear_reserva(5004, 1, DATE '2025-07-10', 3, 'Pendiente');
EXEC pkg_reserva.leer_reserva(5004);
EXEC pkg_reserva.actualizar_reserva(5004, 5, 'Confirmada');
EXEC pkg_reserva.leer_reserva(5004);
EXEC pkg_reserva.eliminar_reserva(5004);

-- ============================================
-- pkg_pago (requiere reserva y tour existentes)
-- ============================================
-- Usamos datos de PoblarOK: Reserva 1, Tour 1
EXEC pkg_pago.crear_pago(5005, 1, 1, NULL, 75000, DATE '2025-07-11', 'Pendiente');
EXEC pkg_pago.leer_pago(5005);
EXEC pkg_pago.actualizar_pago(5005, 80000, 'Completado');
EXEC pkg_pago.leer_pago(5005);
EXEC pkg_pago.eliminar_pago(5005);

-- ============================================
-- pkg_avistamiento (requiere especie y persona académica existentes)
-- ============================================
-- Usamos IdEspecie=1, IdPersonaAcademica=1 de PoblarOK
EXEC pkg_avistamiento.crear_avistamiento(5006, 1, 1, NULL, DATE '2025-07-15', 4, '/fotos/ok_crud.jpg', 'Observado en bosque');
EXEC pkg_avistamiento.leer_avistamiento(5006);
EXEC pkg_avistamiento.actualizar_avistamiento(5006, 6, '/fotos/ok_crud_v2.jpg', 'Observado en bosque - actualizado');
EXEC pkg_avistamiento.leer_avistamiento(5006);
EXEC pkg_avistamiento.eliminar_avistamiento(5006);

-- ============================================
-- pkg_proyecto (requiere persona académica y entidad educativa)
-- ============================================
EXEC pkg_proyecto.crear_proyecto(5007, 1, 1, 'Estudio de Fragatas', DATE '2025-01-01', NULL, 'En curso');
EXEC pkg_proyecto.leer_proyecto(5007);
EXEC pkg_proyecto.actualizar_proyecto(5007, 'Estudio de Fragatas Colombianas', NULL, NULL);
EXEC pkg_proyecto.leer_proyecto(5007);
EXEC pkg_proyecto.eliminar_proyecto(5007);
