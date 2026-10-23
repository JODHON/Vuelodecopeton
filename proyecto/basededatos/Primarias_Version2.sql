-- ============================================
-- PRIMARIAS - DEFINICIÓN DE CLAVES PRIMARIAS
-- ============================================

ALTER TABLE Usuarios
ADD CONSTRAINT PK_Usuario PRIMARY KEY (IdUsuario);

-- Subtipos: PK es IdUsuario (no hay ID propio)
ALTER TABLE PersonasComunes
ADD CONSTRAINT PK_PersonaComun PRIMARY KEY (IdUsuario);

ALTER TABLE EntidadesEducativas
ADD CONSTRAINT PK_EntidadEducativa PRIMARY KEY (IdUsuario);

ALTER TABLE EntidadesCorporativas
ADD CONSTRAINT PK_EntidadCorporativa PRIMARY KEY (IdUsuario);

ALTER TABLE PersonasAcademicas
ADD CONSTRAINT PK_PersonaAcademica PRIMARY KEY (IdUsuario);

ALTER TABLE Administradores
ADD CONSTRAINT PK_Administrador PRIMARY KEY (IdUsuario);

ALTER TABLE Reservas
ADD CONSTRAINT PK_Reserva PRIMARY KEY (IdReserva);

ALTER TABLE Pagos
ADD CONSTRAINT PK_Pago PRIMARY KEY (IdPago);

ALTER TABLE Tours
ADD CONSTRAINT PK_Tour PRIMARY KEY (IdTour);

ALTER TABLE Ubicaciones
ADD CONSTRAINT PK_Ubicacion PRIMARY KEY (IdUbicacion);

ALTER TABLE Tours_Ubicacion
ADD CONSTRAINT PK_Tour_Ubicacion PRIMARY KEY (IdTour, IdUbicacion);

ALTER TABLE Especies
ADD CONSTRAINT PK_Especie PRIMARY KEY (IdEspecie);

ALTER TABLE Avistamientos
ADD CONSTRAINT PK_Avistamiento PRIMARY KEY (IdAvistamiento);

ALTER TABLE Avistamientos_Ubicacion
ADD CONSTRAINT PK_Avistamiento_Ubicacion PRIMARY KEY (IdAvistamiento, IdUbicacion);

ALTER TABLE Asesorias
ADD CONSTRAINT PK_Asesoria PRIMARY KEY (IdAsesoria);

ALTER TABLE Reportes
ADD CONSTRAINT PK_Reporte PRIMARY KEY (IdReporte);

ALTER TABLE ProyectosInvestigacion_Reporte
ADD CONSTRAINT PK_ProyectosInvestigacion_Reporte PRIMARY KEY (IdProyecto, IdReporte);

ALTER TABLE ProyectosInvestigacion
ADD CONSTRAINT PK_ProyectosInvestigacion PRIMARY KEY (IdProyecto);

ALTER TABLE Observaciones
ADD CONSTRAINT PK_Observaciones PRIMARY KEY (IdAvistamiento, Observacion);

COMMIT;
