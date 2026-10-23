-- TRG 1: Fechas Asesoria - fecha igual al inicio (error -20001)
INSERT INTO Asesorias VALUES (93, DATE '2025-01-01', DATE '2025-01-01', 'Finalizada');
-- TRG 1: Fechas Asesoria - fecha anterior al inicio (error -20001)
INSERT INTO Asesorias VALUES (94, DATE '2025-06-01', DATE '2025-01-01', 'Finalizada');

-- TRG 2: Fechas Proyecto - fecha anterior al inicio (error -20002)
INSERT INTO ProyectosInvestigacion VALUES (92, 4, 2, 'Proyecto NoOK', DATE '2025-06-01', DATE '2025-01-01', 'Finalizado');

-- TRG 3: Proteger avistamiento - modificar uno ya validado (error -20003)
INSERT INTO Avistamientos VALUES (91, 1, 4, 5, DATE '2025-01-01', 2, '/fotos/val.jpg', 'Validado');
UPDATE Avistamientos SET Cantidad = 10 WHERE IdAvistamiento = 91;

-- TRG 5: NIT sin guiones (error -20004)
INSERT INTO Usuarios VALUES (93, 'Empresa NoOK', 'empresanok@test.com', 'EntidadCorporativa');
INSERT INTO EntidadesCorporativas VALUES (93, 'Empresa Sin Guiones', '123456789012');
-- TRG 5: NIT con segmento incorrecto (error -20004)
INSERT INTO EntidadesCorporativas VALUES (93, 'Empresa Corta', '860-001234-5');
-- TRG 5: UPDATE con NIT inválido (error -20004)
INSERT INTO Usuarios VALUES (94, 'Empresa OK2', 'empresaok2@test.com', 'EntidadCorporativa');
INSERT INTO EntidadesCorporativas VALUES (94, 'Empresa OK2', '123-45678901-2');
UPDATE EntidadesCorporativas SET NIT = '860ABC-5' WHERE IdUsuario = 94;

-- TRG 6: Cupo tour excedido (error -20005, si aplica disparador de cupo)
INSERT INTO Tours VALUES (91, DATE '2025-03-01', '08:00', 3, 'Guía Test', 10000, 5);
INSERT INTO Reservas VALUES (92, 1, DATE '2025-03-01', 2, 'Pendiente');
INSERT INTO Pagos VALUES (96, 92, 91, NULL, 50000, DATE '2025-03-01', 'Pendiente');
UPDATE Reservas SET Estado = 'Confirmada' WHERE IdReserva = 92;
INSERT INTO Reservas VALUES (93, 6, DATE '2025-03-01', 2, 'Pendiente');
INSERT INTO Pagos VALUES (97, 93, 91, NULL, 50000, DATE '2025-03-01', 'Pendiente');
UPDATE Reservas SET Estado = 'Confirmada' WHERE IdReserva = 93;
