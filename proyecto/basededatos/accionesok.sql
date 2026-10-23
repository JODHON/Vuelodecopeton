-- AR 1 y 2: Borrado en cascada (Pagos)
INSERT INTO Tours VALUES (1000, DATE '2025-01-01', '04:00', 10, 'Guía Test', 5000, 5);
INSERT INTO Pagos VALUES (1000, 1, 1000, NULL, 50000, DATE '2025-01-01', 'Pendiente');
DELETE FROM Tours WHERE IdTour = 1000;

-- AR 4: SET NULL en Administrador (Tour)
INSERT INTO Usuarios VALUES (1003, 'Admin T1', 't1@test.com', 'Administrador');
INSERT INTO Administradores VALUES (1003, 'crear_tours');
INSERT INTO Tours VALUES (1004, DATE '2025-02-01', '06:00', 15, 'Guía', 8000, 1003);
DELETE FROM Administradores WHERE IdUsuario = 1003;

-- AR 5: SET NULL en Administrador (Avistamiento)
-- AJUSTE: El avistamiento no debe estar validado para que el disparador lo permita.
INSERT INTO Usuarios VALUES (1005, 'Admin T2', 't2@test.com', 'Administrador');
INSERT INTO Administradores VALUES (1005, 'validar_avistamientos');
INSERT INTO Avistamientos VALUES (1006, 1, 4, 1005, DATE '2025-02-01', 2, '/fotos/x.jpg', 'Sin validar');
