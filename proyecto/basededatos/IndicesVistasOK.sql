-- ============================================
-- INDICESVISTASOK - CONSULTAS QUE USAN LOS ÍNDICES Y VISTAS
-- ============================================

-- ── PERSONA COMÚN ──

-- Consultar tours disponibles (usa idx_tour_fecha, idx_tour_cupo, vw_tours_disponibles)
SELECT * FROM vw_tours_disponibles
ORDER BY Fecha;

-- Consultar estado de mis reservas (usa idx_reserva_usuario, idx_reserva_estado, vw_estado_reserva)
SELECT * FROM vw_estado_reserva
WHERE IdUsuario = 1;

-- Consultar mi perfil (usa idx_usuario_email, vw_info_usuario)
SELECT * FROM vw_info_usuario
WHERE IdUsuario = 1;


-- ── PERSONA ACADÉMICA ──

-- Consultar avistamientos propios (usa idx_avistamiento_persona_academica, vw_avistamientos)
SELECT * FROM vw_avistamientos
WHERE IdPersonaAcademica = 1;

-- Consultar especies por nombre científico (usa idx_especie_nombre_cientifico, vw_especies)
SELECT * FROM vw_especies
WHERE NombreCientifico LIKE 'A%';

-- Consultar mis proyectos de investigación (usa idx_proyecto_persona_academica, idx_proyecto_estado, vw_proyectos)
SELECT * FROM vw_proyectos
WHERE IdPersonaAcademica = 1
  AND Estado = 'En curso';

-- Consultar asesorías activas (usa idx_asesoria_estado, vw_asesorias)
SELECT * FROM vw_asesorias
WHERE Estado = 'En curso';


-- ── ADMINISTRADOR ──

-- Consultar todos los usuarios por tipo (usa idx_usuario_tipo, vw_usuarios)
SELECT * FROM vw_usuarios
ORDER BY TipoUsuario;

-- Consultar tours por fecha (usa idx_tour_fecha, vw_tours_admin)
SELECT * FROM vw_tours_admin
ORDER BY Fecha;

-- Consultar avistamientos pendientes de validación (usa idx_avistamiento_administrador, vw_avistamientos)
SELECT * FROM vw_avistamientos
WHERE EstadoValidacion = 'Pendiente';

-- Consultar pagos pendientes (usa idx_pago_estado, idx_pago_reserva)
SELECT p.IdPago, p.Monto, p.FechaPago, r.IdUsuario
FROM Pagos p
JOIN Reservas r ON p.IdReserva = r.IdReserva
WHERE p.Estado = 'Pendiente';
