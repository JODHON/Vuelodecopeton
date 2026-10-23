-- ============================================
-- POBLAROK - INSERCIÓN DE DATOS CORRECTOS
-- ============================================

-- USUARIOS BASE
INSERT INTO Usuarios VALUES (1, 'Juan Pérez', 'juan@gmail.com', 'PersonaComun');
INSERT INTO Usuarios VALUES (2, 'Ana García', 'ana@escuelaing.edu.co', 'EntidadEducativa');
INSERT INTO Usuarios VALUES (3, 'Carlos López', 'carlos@empresa.com', 'EntidadCorporativa');
INSERT INTO Usuarios VALUES (4, 'María Rodríguez', 'maria@investigacion.com', 'PersonaAcademica');
INSERT INTO Usuarios VALUES (5, 'Luis Martínez', 'luis@plataforma.com', 'Administrador');
INSERT INTO Usuarios VALUES (6, 'Sofia Torres', 'sofia@gmail.com', 'PersonaComun');
INSERT INTO Usuarios VALUES (7, 'Diego Ramírez', 'diego@unal.edu.co', 'EntidadEducativa');
INSERT INTO Usuarios VALUES (8, 'Camila Soto', 'camila@biotours.com', 'EntidadCorporativa');
INSERT INTO Usuarios VALUES (9, 'Pedro Vargas', 'pedro@investigacion.org', 'PersonaAcademica');
INSERT INTO Usuarios VALUES (10, 'Andrea Moreno', 'andrea@admin.com', 'Administrador');

-- PERSONAS COMUNES (IdUsuario, NumeroCelular, DocumentoIdentidad)
INSERT INTO PersonasComunes VALUES (1, '3001234567', 'CC-1234567890');
INSERT INTO PersonasComunes VALUES (6, '3009876543', 'CC-9876543210');

-- ENTIDADES EDUCATIVAS (IdUsuario, Institucion, NombreInstitucion)
INSERT INTO EntidadesEducativas VALUES (2, 'Universidad', 'Escuela Colombiana de Ingeniería');
INSERT INTO EntidadesEducativas VALUES (7, 'Universidad', 'Universidad Nacional de Colombia');

-- ENTIDADES CORPORATIVAS (IdUsuario, RazonSocial, NIT)
-- NIT formato NNN-NNNNNNNN-N (14 chars)
INSERT INTO EntidadesCorporativas VALUES (3, 'EcoTours Colombia S.A.S.', '860-00001234-5');
INSERT INTO EntidadesCorporativas VALUES (8, 'BioTours Ltda', '860-00005678-9');

-- PERSONAS ACADÉMICAS (IdUsuario, Profesion, Certificacion)
INSERT INTO PersonasAcademicas VALUES (4, 'Bióloga', '/certificados/maria_biologia.pdf');
INSERT INTO PersonasAcademicas VALUES (9, 'Ingeniero Ambiental', '/certificados/pedro_ambiental.pdf');

-- ADMINISTRADORES (IdUsuario, Permisos)
INSERT INTO Administradores VALUES (5, 'crear_tours,gestionar_usuarios,validar_avistamientos,generar_reportes');
INSERT INTO Administradores VALUES (10, 'crear_tours,gestionar_usuarios,validar_avistamientos');

-- UBICACIONES
INSERT INTO Ubicaciones VALUES (1, 'Bosque de Chocó', 'Bosque tropical húmedo en el departamento de Chocó');
INSERT INTO Ubicaciones VALUES (2, 'Páramo de Sumapaz', 'Páramo alto en Cundinamarca');
INSERT INTO Ubicaciones VALUES (3, 'Laguna de Tota', 'Laguna en Boyacá');
INSERT INTO Ubicaciones VALUES (4, 'Selva Amazónica', 'Selva tropical en Amazonas');
INSERT INTO Ubicaciones VALUES (5, 'Humedal El Sonso', 'Humedal en Valle del Cauca');

-- TOURS (IdAdministrador = IdUsuario del Administrador)
INSERT INTO Tours VALUES (1, DATE '2024-06-15', '08:00', 20, 'Guía Experto', 15000, 5);
INSERT INTO Tours VALUES (2, DATE '2024-06-22', '06:30', 15, 'Carlos Arias', 25000, 5);
INSERT INTO Tours VALUES (3, DATE '2024-07-01', '07:00', 25, 'Mónica Ruiz', 18000, 10);
INSERT INTO Tours VALUES (4, DATE '2024-07-10', '09:00', 30, 'José Quintero', 20000, 10);

-- TOUR_UBICACION
INSERT INTO Tours_Ubicacion VALUES (1, 1);
INSERT INTO Tours_Ubicacion VALUES (1, 5);
INSERT INTO Tours_Ubicacion VALUES (2, 2);
INSERT INTO Tours_Ubicacion VALUES (3, 3);
INSERT INTO Tours_Ubicacion VALUES (3, 4);
INSERT INTO Tours_Ubicacion VALUES (4, 4);

-- ESPECIES
INSERT INTO Especies VALUES (1, 'Colibrí Esmeralda', 'Amazilia tzacatl');
INSERT INTO Especies VALUES (2, 'Águila Arpía', 'Harpia harpyja');
INSERT INTO Especies VALUES (3, 'Tucán Pico Iris', 'Ramphastos sulfuratus');
INSERT INTO Especies VALUES (4, 'Cóndor Andino', 'Vultur gryphus');
INSERT INTO Especies VALUES (5, 'Loro Amazónico', 'Amazona amazonica');
INSERT INTO Especies VALUES (6, 'Garza Real', 'Ardea alba');
INSERT INTO Especies VALUES (7, 'Pato Silbador', 'Dendrocygna autumnalis');
INSERT INTO Especies VALUES (8, 'Flamenco Andino', 'Phoenicoparrus andinus');

-- ASESORÍAS
INSERT INTO Asesorias VALUES (1, DATE '2024-05-01', DATE '2024-06-01', 'Finalizada');
INSERT INTO Asesorias VALUES (2, DATE '2024-06-01', DATE '2024-07-01', 'En curso');
INSERT INTO Asesorias VALUES (3, DATE '2024-07-01', NULL, 'En curso');

-- RESERVAS
INSERT INTO Reservas VALUES (1, 1, DATE '2024-06-10', 5, 'Confirmada');
INSERT INTO Reservas VALUES (2, 6, DATE '2024-06-20', 3, 'Confirmada');
INSERT INTO Reservas VALUES (3, 1, DATE '2024-07-05', 8, 'Pendiente');
INSERT INTO Reservas VALUES (4, 6, DATE '2024-07-08', 4, 'Confirmada');

-- PAGOS
INSERT INTO Pagos VALUES (1, 1, 1, NULL, 150000, DATE '2024-06-11', 'Completado');
INSERT INTO Pagos VALUES (2, 2, 2, NULL, 120000, DATE '2024-06-21', 'Completado');
INSERT INTO Pagos VALUES (3, 3, 3, NULL, 250000, DATE '2024-07-06', 'Pendiente');
INSERT INTO Pagos VALUES (4, 4, NULL, 2, 500000, DATE '2024-07-09', 'Completado');
INSERT INTO Pagos VALUES (5, 1, NULL, 3, 300000, DATE '2024-07-15', 'Completado');

-- AVISTAMIENTOS (IdPersonaAcademica e IdAdministrador = IdUsuario de cada subtipo)
INSERT INTO Avistamientos VALUES (1, 1, 4, 5, DATE '2024-06-15', 3, '/fotos/colibrí_01.jpg', 'Avistados en flores de sombrilla');
INSERT INTO Avistamientos VALUES (2, 2, 9, 5, DATE '2024-06-22', 1, '/fotos/aguila_01.jpg', 'Sobrevolando la montaña');
INSERT INTO Avistamientos VALUES (3, 3, 4, 5, DATE '2024-07-01', 2, '/fotos/tucan_01.jpg', 'En rama de árbol frondoso');
INSERT INTO Avistamientos VALUES (4, 4, 9, 10, DATE '2024-07-10', 1, '/fotos/condor_01.jpg', 'En páramo a 4000m');
INSERT INTO Avistamientos VALUES (5, 5, 9, 10, DATE '2024-07-12', 4, '/fotos/loro_01.jpg', 'En grupo sobre dosel');
INSERT INTO Avistamientos VALUES (6, 6, 4, 5, DATE '2024-06-16', 5, '/fotos/garza_01.jpg', 'En humedal al atardecer');

-- AVISTAMIENTO_UBICACION
INSERT INTO Avistamientos_Ubicacion VALUES (1, 1);
INSERT INTO Avistamientos_Ubicacion VALUES (2, 2);
INSERT INTO Avistamientos_Ubicacion VALUES (3, 3);
INSERT INTO Avistamientos_Ubicacion VALUES (4, 4);
INSERT INTO Avistamientos_Ubicacion VALUES (5, 4);
INSERT INTO Avistamientos_Ubicacion VALUES (6, 5);

-- PROYECTOS DE INVESTIGACIÓN (IdPersonaAcademica e IdEntidadEducativa = IdUsuario del subtipo)
INSERT INTO ProyectosInvestigacion VALUES (1, 4, 2, 'Conservación de Colibríes', DATE '2024-01-15', DATE '2024-12-31', 'En curso');
INSERT INTO ProyectosInvestigacion VALUES (2, 9, 7, 'Monitoreo de Águilas Arpía', DATE '2024-02-01', DATE '2025-01-31', 'En curso');
INSERT INTO ProyectosInvestigacion VALUES (3, 4, 2, 'Comportamiento de Tucanes', DATE '2023-06-01', DATE '2024-05-31', 'Finalizado');

-- REPORTES
INSERT INTO Reportes VALUES (1, 1, DATE '2024-06-01');
INSERT INTO Reportes VALUES (2, 2, DATE '2024-07-01');
INSERT INTO Reportes VALUES (3, 3, DATE '2024-06-15');
INSERT INTO Reportes VALUES (4, NULL, DATE '2024-07-20');

-- PROYECTOS_INVESTIGACION_REPORTE
INSERT INTO ProyectosInvestigacion_Reporte VALUES (1, 1);
INSERT INTO ProyectosInvestigacion_Reporte VALUES (1, 3);
INSERT INTO ProyectosInvestigacion_Reporte VALUES (2, 2);
INSERT INTO ProyectosInvestigacion_Reporte VALUES (3, 4);

COMMIT;
