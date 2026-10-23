-- ============================================
-- SEGURIDADOK - INGRESO DE DATOS CORRECTOS USANDO LOS PAQUETES DE ACTORES
-- ============================================

-- ── PERSONA COMÚN ──
EXEC pkg_persona_comun.crear_reserva(10, 1, DATE '2025-08-01', 3);
EXEC pkg_persona_comun.modificar_reserva(10, 5, 'Confirmada');
EXEC pkg_persona_comun.registrar_pago(20, 10, 1, NULL, 150000, SYSDATE);
EXEC pkg_persona_comun.registrar_pago(21, 10, NULL, 1, 300000, SYSDATE);
EXEC pkg_persona_comun.registrar_avistamiento(20, 2, 4, SYSDATE, 2, '/fotos/test.jpg', 'Observado en zona norte');
EXEC pkg_persona_comun.consultar_tours_disponibles;
EXEC pkg_persona_comun.consultar_estado_reserva(1);
EXEC pkg_persona_comun.consultar_perfil(1);
EXEC pkg_persona_comun.actualizar_perfil(1, 'Juan Pablo Pérez', 'juanpablo@gmail.com');
EXEC pkg_persona_comun.cancelar_reserva(10);


-- ── PERSONA ACADÉMICA ──
EXEC pkg_persona_academica.crear_proyecto(10, 4, 2, 'Estudio de Cóndores', DATE '2025-01-01', NULL, 'En curso');
EXEC pkg_persona_academica.actualizar_proyecto(10, 'Estudio Avanzado de Cóndores', DATE '2025-12-31', 'Finalizado');
EXEC pkg_persona_academica.actualizar_asesoria(2, DATE '2025-07-15', 'Finalizada');
EXEC pkg_persona_academica.generar_reporte(10, 2, SYSDATE);
EXEC pkg_persona_academica.generar_reporte(11, NULL, SYSDATE);
EXEC pkg_persona_academica.consultar_avistamientos(4);
EXEC pkg_persona_academica.consultar_especies;
EXEC pkg_persona_academica.consultar_proyectos(4);
EXEC pkg_persona_academica.consultar_asesorias;
EXEC pkg_persona_academica.eliminar_proyecto(10);


-- ── ADMINISTRADOR ──
EXEC pkg_administrador.crear_usuario(20, 'Laura Jiménez', 'laura@biotours.com', 'PersonaComun');
EXEC pkg_administrador.actualizar_usuario(20, 'Laura María Jiménez', 'lauramaria@biotours.com', 'PersonaComun');
EXEC pkg_administrador.crear_tour(10, DATE '2025-09-01', '06:00', 20, 'Guía Norte', 12000, 5);
EXEC pkg_administrador.actualizar_tour(10, DATE '2025-09-05', 15, 'Guía Sur', 14000);
EXEC pkg_administrador.registrar_especie(10, 'Pato Andino', 'Anas andium');
EXEC pkg_administrador.validar_avistamiento(20, 5);
EXEC pkg_administrador.consultar_usuarios;
EXEC pkg_administrador.consultar_tours;
EXEC pkg_administrador.eliminar_tour(10);
EXEC pkg_administrador.eliminar_usuario(20);


-- ── ADMINISTRADOR INSTITUCIONAL ──
-- Primero crear el usuario que se va a vincular como EntidadEducativa
INSERT INTO Usuarios VALUES (50, 'Instituto Prueba', 'instituto@test.com', 'EntidadEducativa');
COMMIT;
-- Vincular usando el IdUsuario recién creado
EXEC pkg_admin_institucional.vincular_usuario_institucion(50, 'Universidad', 'Universidad Distrital');
-- Desvincular usando el mismo IdUsuario
EXEC pkg_admin_institucional.desvincular_usuario_institucion(50);
-- Limpiar
DELETE FROM Usuarios WHERE IdUsuario = 50;
COMMIT;
