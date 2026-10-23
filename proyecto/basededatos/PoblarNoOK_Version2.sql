-- ============================================
-- POBLARNO OK - INSERCIÓN DE DATOS INCORRECTOS
-- ============================================

-- EMAIL SIN ARROBA (Violación de CHECK)
INSERT INTO Usuarios VALUES (101, 'Persona Inválida', 'correosinarmoba', 'PersonaComun');

-- RESERVA CON PERSONAS NEGATIVAS (Violación de CHECK)
INSERT INTO Reservas VALUES (101, 1, DATE '2024-06-10', -5, 'Confirmada');

-- PAGO CON MONTO NEGATIVO (Violación de CHECK)
INSERT INTO Pagos VALUES (101, 1, 1, NULL, -50000, DATE '2024-06-11', 'Completado');

-- ESTADO DE RESERVA INVÁLIDO (Violación de CHECK)
INSERT INTO Reservas VALUES (102, 1, DATE '2024-06-10', 3, 'EstadoInvalido');

-- NIT CON FORMATO INCORRECTO (Violación de CHECK - sin guiones)
INSERT INTO Usuarios VALUES (102, 'Empresa Inválida', 'empresa@correo.com', 'EntidadCorporativa');
INSERT INTO EntidadesCorporativas VALUES (102, 'Empresa Sin Formato', '12345678901234');

-- TOUR SIN CUPO (NULL en NOT NULL)
INSERT INTO Tours VALUES (101, DATE '2024-06-15', '08:00', NULL, 'Guía', 15000, 5);

-- CUPO NEGATIVO O CERO (Violación de CHECK)
INSERT INTO Tours VALUES (102, DATE '2024-06-15', '08:00', 0, 'Guía', 15000, 5);

-- CANTIDAD DE AVISTAMIENTO NEGATIVA (Violación de CHECK)
INSERT INTO Avistamientos VALUES (101, 1, 4, 5, DATE '2024-06-15', -5, '/fotos/test.jpg', 'Observación');

-- ESTADO DE ASESORIA INVÁLIDO (Violación de CHECK)
INSERT INTO Asesorias VALUES (101, DATE '2024-05-01', DATE '2024-06-01', 'EstadoInvalido');

-- ESTADO DE PROYECTO INVÁLIDO (Violación de CHECK)
INSERT INTO ProyectosInvestigacion VALUES (101, 4, 2, 'Proyecto Inválido', DATE '2024-01-15', DATE '2024-12-31', 'EstadoInvalido');

-- LONGITUD NEGATIVA (Violación de CHECK)
INSERT INTO Tours VALUES (103, DATE '2024-06-15', '08:00', 20, 'Guía', -5000, 5);

-- ESTADO DE PAGO INVÁLIDO (Violación de CHECK)
INSERT INTO Pagos VALUES (102, 1, 1, NULL, 150000, DATE '2024-06-11', 'EstadoInvalido');

-- DOCUMENTO DUPLICADO (Violación de UNIQUE)
INSERT INTO PersonasComunes VALUES (1, '3001234567', 'CC-1234567890');

-- EMAIL DUPLICADO (Violación de UNIQUE)
INSERT INTO Usuarios VALUES (103, 'Otro Usuario', 'juan@gmail.com', 'PersonaComun');

-- NIT DUPLICADO (Violación de UNIQUE)
INSERT INTO EntidadesCorporativas VALUES (8, 'Otra Empresa', '860-00001234-5');
