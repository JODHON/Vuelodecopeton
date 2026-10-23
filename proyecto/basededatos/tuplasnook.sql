-- RST 1: XOR - Tour Y Asesoria al mismo tiempo
INSERT INTO Pagos VALUES (93, 1, 1, 1, 50000, DATE '2025-01-01', 'Pendiente');
-- RST 1: XOR - ninguno de los dos
INSERT INTO Pagos VALUES (94, 1, NULL, NULL, 50000, DATE '2025-01-01', 'Pendiente');

-- RST 2: FechaFinalizacion igual al inicio
INSERT INTO Asesorias VALUES (94, DATE '2025-01-01', DATE '2025-01-01', 'Finalizada');
-- RST 2: FechaFinalizacion anterior al inicio
INSERT INTO Asesorias VALUES (95, DATE '2025-06-01', DATE '2025-01-01', 'Finalizada');

-- RST 3: FechaFinalizacion anterior al inicio en Proyecto
INSERT INTO ProyectosInvestigacion VALUES (94, 4, 2, 'Proyecto NoOK', DATE '2025-06-01', DATE '2025-01-01', 'Finalizado');

-- RST 4: Estado no permitido
INSERT INTO Reservas VALUES (95, 1, DATE '2025-08-01', 2, 'En proceso');

-- RST 5: Monto en cero
INSERT INTO Pagos VALUES (95, 1, 1, NULL, 0, DATE '2025-01-01', 'Pendiente');
-- RST 5: Monto negativo
INSERT INTO Pagos VALUES (96, 1, 1, NULL, -1000, DATE '2025-01-01', 'Pendiente');

-- RST 7: En curso con fecha de finalización
INSERT INTO Asesorias VALUES (96, DATE '2025-01-01', DATE '2025-06-01', 'En curso');
-- RST 7: Finalizada sin fecha de finalización
INSERT INTO Asesorias VALUES (97, DATE '2025-01-01', NULL, 'Finalizada');

-- RST 8: Finalizado sin fecha de finalización
INSERT INTO ProyectosInvestigacion VALUES (95, 4, 2, 'P NoOK', DATE '2025-01-01', NULL, 'Finalizado');
-- RST 8: En curso con fecha de finalización
INSERT INTO ProyectosInvestigacion VALUES (96, 4, 2, 'P NoOK2', DATE '2025-01-01', DATE '2025-12-31', 'En curso');

-- RST 9: Cantidad en cero
INSERT INTO Avistamientos VALUES (91, 1, 4, 5, DATE '2025-01-01', 0, '/fotos/nok.jpg', 'NoOK');
-- RST 9: Cantidad negativa
INSERT INTO Avistamientos VALUES (92, 1, 4, 5, DATE '2025-01-01', -1, '/fotos/nok2.jpg', 'NoOK');

-- RST 10: Personas en cero
INSERT INTO Reservas VALUES (96, 1, DATE '2025-09-01', 0, 'Pendiente');
