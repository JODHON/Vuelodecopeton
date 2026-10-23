-- ============================================
-- ACTORES E - ESPECIFICACIÓN DE PAQUETES DE ACTORES
-- ============================================

-- PAQUETE: pkg_persona_comun
CREATE OR REPLACE PACKAGE pkg_persona_comun AS
    PROCEDURE registrar_avistamiento(
        p_id_avistamiento  NUMBER,
        p_id_especie       NUMBER,
        p_id_persona_acad  NUMBER,
        p_fecha            DATE,
        p_cantidad         NUMBER,
        p_foto             VARCHAR2,
        p_observaciones    VARCHAR2
    );
    PROCEDURE crear_reserva(
        p_id_reserva  NUMBER,
        p_id_usuario  NUMBER,
        p_fecha       DATE,
        p_personas    NUMBER
    );
    PROCEDURE modificar_reserva(
        p_id_reserva  NUMBER,
        p_personas    NUMBER,
        p_estado      VARCHAR2
    );
    PROCEDURE cancelar_reserva(
        p_id_reserva  NUMBER
    );
    PROCEDURE registrar_pago(
        p_id_pago     NUMBER,
        p_id_reserva  NUMBER,
        p_id_tour     NUMBER,
        p_id_asesoria NUMBER,
        p_monto       NUMBER,
        p_fecha_pago  DATE
    );
    PROCEDURE consultar_tours_disponibles;
    PROCEDURE consultar_estado_reserva(p_id_usuario NUMBER);
    PROCEDURE consultar_perfil(p_id_usuario NUMBER);
    PROCEDURE actualizar_perfil(
        p_id_usuario  NUMBER,
        p_nombre      VARCHAR2,
        p_email       VARCHAR2
    );
END pkg_persona_comun;
/

-- PAQUETE: pkg_persona_academica
-- p_id_persona_acad y p_id_entidad_ed son IdUsuario de los respectivos subtipos
CREATE OR REPLACE PACKAGE pkg_persona_academica AS
    PROCEDURE crear_proyecto(
        p_id_proyecto      NUMBER,
        p_id_persona_acad  NUMBER,
        p_id_entidad_ed    NUMBER,
        p_nombre           VARCHAR2,
        p_fecha_inicio     DATE,
        p_fecha_fin        DATE,
        p_estado           VARCHAR2
    );
    PROCEDURE actualizar_proyecto(
        p_id_proyecto  NUMBER,
        p_nombre       VARCHAR2,
        p_fecha_fin    DATE,
        p_estado       VARCHAR2
    );
    PROCEDURE eliminar_proyecto(
        p_id_proyecto  NUMBER
    );
    PROCEDURE actualizar_asesoria(
        p_id_asesoria  NUMBER,
        p_fecha_fin    DATE,
        p_estado       VARCHAR2
    );
    PROCEDURE generar_reporte(
        p_id_reporte   NUMBER,
        p_id_asesoria  NUMBER,
        p_fecha        DATE
    );
    PROCEDURE consultar_avistamientos(p_id_persona_acad NUMBER);
    PROCEDURE consultar_especies;
    PROCEDURE consultar_proyectos(p_id_persona_acad NUMBER);
    PROCEDURE consultar_asesorias;
END pkg_persona_academica;
/

-- PAQUETE: pkg_administrador
-- p_id_admin es IdUsuario del Administrador
CREATE OR REPLACE PACKAGE pkg_administrador AS
    PROCEDURE crear_usuario(
        p_id_usuario  NUMBER,
        p_nombre      VARCHAR2,
        p_email       VARCHAR2,
        p_tipo        VARCHAR2
    );
    PROCEDURE actualizar_usuario(
        p_id_usuario  NUMBER,
        p_nombre      VARCHAR2,
        p_email       VARCHAR2,
        p_tipo        VARCHAR2
    );
    PROCEDURE eliminar_usuario(
        p_id_usuario  NUMBER
    );
    PROCEDURE crear_tour(
        p_id_tour    NUMBER,
        p_fecha      DATE,
        p_duracion   VARCHAR2,
        p_cupo       NUMBER,
        p_guia       VARCHAR2,
        p_longitud   NUMBER,
        p_id_admin   NUMBER
    );
    PROCEDURE actualizar_tour(
        p_id_tour   NUMBER,
        p_fecha     DATE,
        p_cupo      NUMBER,
        p_guia      VARCHAR2,
        p_longitud  NUMBER
    );
    PROCEDURE eliminar_tour(
        p_id_tour  NUMBER
    );
    PROCEDURE registrar_especie(
        p_id_especie        NUMBER,
        p_nombre_comun      VARCHAR2,
        p_nombre_cientifico VARCHAR2
    );
    PROCEDURE validar_avistamiento(
        p_id_avistamiento  NUMBER,
        p_id_administrador NUMBER
    );
    PROCEDURE consultar_usuarios;
    PROCEDURE consultar_tours;
END pkg_administrador;
/

-- PAQUETE: pkg_admin_institucional
-- p_id_usuario_nuevo: IdUsuario del nuevo registro en EntidadesEducativas
-- p_id_entidad_educativa: IdUsuario de la entidad a desvincular
CREATE OR REPLACE PACKAGE pkg_admin_institucional AS
    PROCEDURE vincular_usuario_institucion(
        p_id_usuario_nuevo   NUMBER,
        p_institucion        VARCHAR2,
        p_nombre_institucion VARCHAR2
    );
    PROCEDURE desvincular_usuario_institucion(
        p_id_entidad_educativa  NUMBER
    );
END pkg_admin_institucional;
/
