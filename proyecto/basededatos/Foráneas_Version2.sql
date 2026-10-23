-- ============================================
-- FORÁNEAS - DEFINICIÓN DE CLAVES FORÁNEAS
-- ============================================

-- JOINED TABLE INHERITANCE: Subtipos referenciando a Usuario
ALTER TABLE PersonasComunes
ADD CONSTRAINT FK_PersonaComun_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario);

ALTER TABLE EntidadesEducativas
ADD CONSTRAINT FK_EntidadEducativa_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario);

ALTER TABLE EntidadesCorporativas
ADD CONSTRAINT FK_EntidadCorporativa_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario);

ALTER TABLE PersonasAcademicas
ADD CONSTRAINT FK_PersonaAcademica_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario);

ALTER TABLE Administradores
ADD CONSTRAINT FK_Administrador_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario);

-- RESERVA
ALTER TABLE Reservas
ADD CONSTRAINT FK_Reserva_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario);

-- PAGO
ALTER TABLE Pagos
ADD CONSTRAINT FK_Pago_Reserva
FOREIGN KEY (IdReserva) REFERENCES Reservas(IdReserva);

ALTER TABLE Pagos
ADD CONSTRAINT FK_Pago_Tour
FOREIGN KEY (IdTour) REFERENCES Tours(IdTour);

ALTER TABLE Pagos
ADD CONSTRAINT FK_Pago_Asesoria
FOREIGN KEY (IdAsesoria) REFERENCES Asesorias(IdAsesoria);

-- TOUR
ALTER TABLE Tours
ADD CONSTRAINT FK_Tour_Administrador
FOREIGN KEY (IdAdministrador) REFERENCES Administradores(IdUsuario);

-- TOUR_UBICACION (Junction Table)
ALTER TABLE Tours_Ubicacion
ADD CONSTRAINT FK_Tour_Ubicacion_Tour
FOREIGN KEY (IdTour) REFERENCES Tours(IdTour);

ALTER TABLE Tours_Ubicacion
ADD CONSTRAINT FK_Tour_Ubicacion_Ubicacion
FOREIGN KEY (IdUbicacion) REFERENCES Ubicaciones(IdUbicacion);

-- AVISTAMIENTO
ALTER TABLE Avistamientos
ADD CONSTRAINT FK_Avistamiento_Especie
FOREIGN KEY (IdEspecie) REFERENCES Especies(IdEspecie);

ALTER TABLE Avistamientos
ADD CONSTRAINT FK_Avistamiento_PersonaAcademica
FOREIGN KEY (IdPersonaAcademica) REFERENCES PersonasAcademicas(IdUsuario);

ALTER TABLE Avistamientos
ADD CONSTRAINT FK_Avistamiento_Administrador
FOREIGN KEY (IdAdministrador) REFERENCES Administradores(IdUsuario);

-- AVISTAMIENTO_UBICACION (Junction Table)
ALTER TABLE Avistamientos_Ubicacion
ADD CONSTRAINT FK_Avistamiento_Ubicacion_Avistamiento
FOREIGN KEY (IdAvistamiento) REFERENCES Avistamientos(IdAvistamiento);

ALTER TABLE Avistamientos_Ubicacion
ADD CONSTRAINT FK_Avistamiento_Ubicacion_Ubicacion
FOREIGN KEY (IdUbicacion) REFERENCES Ubicaciones(IdUbicacion);

-- REPORTE
ALTER TABLE Reportes
ADD CONSTRAINT FK_Reporte_Asesoria
FOREIGN KEY (IdAsesoria) REFERENCES Asesorias(IdAsesoria);

-- PROYECTOS_INVESTIGACION
ALTER TABLE ProyectosInvestigacion
ADD CONSTRAINT FK_ProyectosInvestigacion_PersonaAcademica
FOREIGN KEY (IdPersonaAcademica) REFERENCES PersonasAcademicas(IdUsuario);

ALTER TABLE ProyectosInvestigacion
ADD CONSTRAINT FK_ProyectosInvestigacion_EntidadEducativa
FOREIGN KEY (IdEntidadEducativa) REFERENCES EntidadesEducativas(IdUsuario);

-- PROYECTOS_INVESTIGACION_REPORTE (Junction Table)
ALTER TABLE ProyectosInvestigacion_Reporte
ADD CONSTRAINT FK_ProyectosInvestigacion_Reporte_Proyecto
FOREIGN KEY (IdProyecto) REFERENCES ProyectosInvestigacion(IdProyecto);

ALTER TABLE ProyectosInvestigacion_Reporte
ADD CONSTRAINT FK_ProyectosInvestigacion_Reporte_Reporte
FOREIGN KEY (IdReporte) REFERENCES Reportes(IdReporte);

ALTER TABLE Observaciones
ADD CONSTRAINT FK_Observaciones_Avistamiento
FOREIGN KEY (IdAvistamiento) REFERENCES Avistamientos(IdAvistamiento);

COMMIT;