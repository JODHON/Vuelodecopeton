-- ============================================
-- INDICES - DEFINICIÓN DE ÍNDICES
-- ============================================

-- Índice sobre Usuario.Email+Nombre (búsquedas combinadas; Email solo ya está indexado por UNIQUE)
CREATE INDEX idx_usuario_email_nombre
ON Usuarios(Email, Nombre);

-- Índice sobre Usuarios.TipoUsuario (filtrar por tipo de actor)
CREATE INDEX idx_usuario_tipo
ON Usuarios(TipoUsuario);

-- Índice sobre Reservas.IdUsuario (reservas por usuario)
CREATE INDEX idx_reserva_usuario
ON Reservas(IdUsuario);

-- Índice sobre Reservas.Estado (consultar estado de reserva)
CREATE INDEX idx_reserva_estado
ON Reservas(Estado);

-- Índice sobre Tours.Fecha (consultar tours disponibles por fecha)
CREATE INDEX idx_tour_fecha
ON Tours(Fecha);

-- Índice sobre Tours.Cupo (filtrar tours con cupo disponible)
CREATE INDEX idx_tour_cupo
ON Tours(Cupo);

-- Índice sobre Avistamientos.IdEspecie (avistamientos por especie)
CREATE INDEX idx_avistamiento_especie
ON Avistamientos(IdEspecie);

-- Índice sobre Avistamientos.IdPersonaAcademica (avistamientos por académica)
CREATE INDEX idx_avistamiento_persona_academica
ON Avistamientos(IdPersonaAcademica);

-- Índice sobre Avistamientos.IdAdministrador (avistamientos validados)
CREATE INDEX idx_avistamiento_administrador
ON Avistamientos(IdAdministrador);

-- Índice sobre Asesorias.Estado (consultar asesorías activas)
CREATE INDEX idx_asesoria_estado
ON Asesorias(Estado);

-- Índice sobre ProyectosInvestigacion.IdPersonaAcademica (proyectos por académica)
CREATE INDEX idx_proyecto_persona_academica
ON ProyectosInvestigacion(IdPersonaAcademica);

-- Índice sobre ProyectosInvestigacion.Estado (proyectos activos)
CREATE INDEX idx_proyecto_estado
ON ProyectosInvestigacion(Estado);

-- Índice sobre Pagos.IdReserva (pagos por reserva)
CREATE INDEX idx_pago_reserva
ON Pagos(IdReserva);

-- Índice sobre Pagos.Estado (pagos pendientes o completados)
CREATE INDEX idx_pago_estado
ON Pagos(Estado);

-- Índice sobre Especie.NombreCientifico+NombreComun (NombreCientifico solo ya está indexado por UNIQUE)
CREATE INDEX idx_especie_nombres
ON Especies(NombreCientifico, NombreComun);

COMMIT;
