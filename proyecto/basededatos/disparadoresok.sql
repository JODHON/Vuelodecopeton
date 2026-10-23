-- TRG 1 y 2: Pruebas de estados
INSERT INTO Asesorias VALUES (3000, DATE '2025-01-01', NULL, 'En curso');
INSERT INTO ProyectosInvestigacion VALUES (3002, 4, 2, 'Investigacion A', DATE '2025-01-01', NULL, 'En curso');

-- TRG 3, 4
INSERT INTO Avistamientos VALUES (3004, 1, 4, NULL, DATE '2025-01-01', 3, '/fotos/ok.jpg', 'Sin validar');
INSERT INTO Usuarios (Nombre, Email, TipoUsuario) VALUES ('Auto User', 'auto@test.com', 'PersonaComun');

-- TRG 5: NIT válido (formato NNN-NNNNNNNN-N = 14 chars)
INSERT INTO Usuarios VALUES (3006, 'Empresa OK', 'empresaok@test.com', 'EntidadCorporativa');
INSERT INTO EntidadesCorporativas VALUES (3006, 'EcoTours prueba', '860-00001235-6');

-- TRG 6 y 7: Flujo de Reservas y Pagos
INSERT INTO Tours VALUES (3008, DATE '2025-03-01', '08:00', 3, 'Guía Test', 10000, 5);
INSERT INTO Reservas VALUES (3009, 1, DATE '2025-03-01', 2, 'Pendiente');
INSERT INTO Pagos VALUES (3010, 3009, 3008, NULL, 50000, DATE '2025-03-01', 'Pendiente');
UPDATE Reservas SET Estado = 'Confirmada' WHERE IdReserva = 3009;

-- Prueba de cierre automático de asesoría
INSERT INTO Asesorias VALUES (3011, DATE '2025-01-01', NULL, 'En curso');
INSERT INTO Reservas VALUES (3012, 1, DATE '2025-01-01', 1, 'Confirmada');
INSERT INTO Pagos VALUES (3013, 3012, NULL, 3011, 300000, DATE '2025-01-01', 'Pendiente');
UPDATE Pagos SET Estado = 'Completado' WHERE IdPago = 3013;

SELECT Estado, FechaFinalizacion FROM Asesorias WHERE IdAsesoria = 3011;
