-- ============================================
-- XINDICESVISTAS - ELIMINACIÓN DE VISTAS E ÍNDICES
-- ============================================

-- Eliminar vistas
DROP VIEW vw_tours_disponibles;
DROP VIEW vw_estado_reserva;
DROP VIEW vw_info_usuario;
DROP VIEW vw_avistamientos;
DROP VIEW vw_especies;
DROP VIEW vw_proyectos;
DROP VIEW vw_asesorias;
DROP VIEW vw_usuarios;
DROP VIEW vw_tours_admin;

-- Eliminar índices
DROP INDEX idx_usuario_email_nombre;
DROP INDEX idx_usuario_tipo;
DROP INDEX idx_reserva_usuario;
DROP INDEX idx_reserva_estado;
DROP INDEX idx_tour_fecha;
DROP INDEX idx_tour_cupo;
DROP INDEX idx_avistamiento_especie;
DROP INDEX idx_avistamiento_persona_academica;
DROP INDEX idx_avistamiento_administrador;
DROP INDEX idx_asesoria_estado;
DROP INDEX idx_proyecto_persona_academica;
DROP INDEX idx_proyecto_estado;
DROP INDEX idx_pago_reserva;
DROP INDEX idx_pago_estado;
DROP INDEX idx_especie_nombres;

COMMIT;
