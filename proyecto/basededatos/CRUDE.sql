-- ============================================
-- CRUDE - ESPECIFICACIÓN DE PAQUETES CRUD
-- ============================================

-- PAQUETE 1: pkg_usuario
CREATE OR REPLACE PACKAGE pkg_usuario AS
    PROCEDURE crear_usuario(p_id NUMBER, p_nombre VARCHAR2, p_email VARCHAR2, p_tipo VARCHAR2);
    PROCEDURE leer_usuario(p_id NUMBER);
    PROCEDURE actualizar_usuario(p_id NUMBER, p_nombre VARCHAR2, p_email VARCHAR2, p_tipo VARCHAR2);
    PROCEDURE eliminar_usuario(p_id NUMBER);
END pkg_usuario;
/

-- PAQUETE 2: pkg_tour
CREATE OR REPLACE PACKAGE pkg_tour AS
    PROCEDURE crear_tour(p_id NUMBER, p_fecha DATE, p_duracion VARCHAR2, p_cupo NUMBER, p_guia VARCHAR2, p_longitud NUMBER, p_id_admin NUMBER);
    PROCEDURE leer_tour(p_id NUMBER);
    PROCEDURE actualizar_tour(p_id NUMBER, p_fecha DATE, p_cupo NUMBER, p_guia VARCHAR2, p_longitud NUMBER);
    PROCEDURE eliminar_tour(p_id NUMBER);
END pkg_tour;
/

-- PAQUETE 3: pkg_reserva
CREATE OR REPLACE PACKAGE pkg_reserva AS
    PROCEDURE crear_reserva(p_id NUMBER, p_id_usuario NUMBER, p_fecha DATE, p_personas NUMBER, p_estado VARCHAR2);
    PROCEDURE leer_reserva(p_id NUMBER);
    PROCEDURE actualizar_reserva(p_id NUMBER, p_personas NUMBER, p_estado VARCHAR2);
    PROCEDURE eliminar_reserva(p_id NUMBER);
END pkg_reserva;
/

-- PAQUETE 4: pkg_pago
CREATE OR REPLACE PACKAGE pkg_pago AS
    PROCEDURE crear_pago(p_id NUMBER, p_id_reserva NUMBER, p_id_tour NUMBER, p_id_asesoria NUMBER, p_monto NUMBER, p_fecha DATE, p_estado VARCHAR2);
    PROCEDURE leer_pago(p_id NUMBER);
    PROCEDURE actualizar_pago(p_id NUMBER, p_monto NUMBER, p_estado VARCHAR2);
    PROCEDURE eliminar_pago(p_id NUMBER);
END pkg_pago;
/

-- PAQUETE 5: pkg_avistamiento
CREATE OR REPLACE PACKAGE pkg_avistamiento AS
    PROCEDURE crear_avistamiento(p_id NUMBER, p_id_especie NUMBER, p_id_persona_acad NUMBER, p_id_admin NUMBER, p_fecha DATE, p_cantidad NUMBER, p_foto VARCHAR2, p_observaciones VARCHAR2);
    PROCEDURE leer_avistamiento(p_id NUMBER);
    PROCEDURE actualizar_avistamiento(p_id NUMBER, p_cantidad NUMBER, p_foto VARCHAR2, p_observaciones VARCHAR2);
    PROCEDURE eliminar_avistamiento(p_id NUMBER);
END pkg_avistamiento;
/

-- PAQUETE 6: pkg_especie
CREATE OR REPLACE PACKAGE pkg_especie AS
    PROCEDURE crear_especie(p_id NUMBER, p_nombre_comun VARCHAR2, p_nombre_cientifico VARCHAR2);
    PROCEDURE leer_especie(p_id NUMBER);
    PROCEDURE actualizar_especie(p_id NUMBER, p_nombre_comun VARCHAR2, p_nombre_cientifico VARCHAR2);
    PROCEDURE eliminar_especie(p_id NUMBER);
END pkg_especie;
/

-- PAQUETE 7: pkg_asesoria
CREATE OR REPLACE PACKAGE pkg_asesoria AS
    PROCEDURE crear_asesoria(p_id NUMBER, p_fecha_inicio DATE, p_fecha_fin DATE, p_estado VARCHAR2);
    PROCEDURE leer_asesoria(p_id NUMBER);
    PROCEDURE actualizar_asesoria(p_id NUMBER, p_fecha_fin DATE, p_estado VARCHAR2);
    PROCEDURE eliminar_asesoria(p_id NUMBER);
END pkg_asesoria;
/

-- PAQUETE 8: pkg_proyecto
CREATE OR REPLACE PACKAGE pkg_proyecto AS
    PROCEDURE crear_proyecto(p_id NUMBER, p_id_persona_acad NUMBER, p_id_entidad_ed NUMBER, p_nombre VARCHAR2, p_fecha_inicio DATE, p_fecha_fin DATE, p_estado VARCHAR2);
    PROCEDURE leer_proyecto(p_id NUMBER);
    PROCEDURE actualizar_proyecto(p_id NUMBER, p_nombre VARCHAR2, p_fecha_fin DATE, p_estado VARCHAR2);
    PROCEDURE eliminar_proyecto(p_id NUMBER);
END pkg_proyecto;
/
