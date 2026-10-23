-- RST 1: XOR - solo Tour
INSERT INTO Pagos VALUES (2000, 1, 1, NULL, 50000, DATE '2025-01-01', 'Pendiente');

-- RST 1: XOR - solo Asesoria
INSERT INTO Pagos VALUES (2001, 2, NULL, 1, 80000, DATE '2025-01-01', 'Pendiente');

-- RST 2: Asesoría Finalizada con fecha fin
INSERT INTO Asesorias VALUES (2002, DATE '2025-01-01', DATE '2025-06-01', 'Finalizada');
INSERT INTO Asesorias VALUES (2003, DATE '2025-01-01', NULL, 'En curso');

-- RST 3: Coherencia en Proyectos
INSERT INTO ProyectosInvestigacion VALUES (2004, 4, 2, 'Proyecto OK', DATE '2025-01-01', DATE '2025-12-31', 'Finalizado');
INSERT INTO ProyectosInvestigacion VALUES (2005, 4, 2, 'Proyecto En Curso', DATE '2025-01-01', NULL, 'En curso');

-- RST 4, 5 y 8
INSERT INTO Reservas VALUES (2006, 1, DATE '2025-08-01', 2, 'Pendiente');
INSERT INTO Pagos VALUES (2009, 1, 1, NULL, 10000, DATE '2025-01-01', 'Pendiente');
INSERT INTO ProyectosInvestigacion VALUES (2010, 4, 2, 'P Bio', DATE '2025-01-01', NULL, 'En curso');

-- RST 9: Cantidad positiva
INSERT INTO Avistamientos VALUES (2012, 1, 4, 5, DATE '2025-01-01', 3, '/fotos/ok.jpg', 'Sin validar');

-- RST 10: Personas positivas
INSERT INTO Reservas VALUES (2013, 1, DATE '2025-09-01', 3, 'Pendiente');
