-- ============================================
-- XSEGURIDAD - ELIMINACIÓN DE PAQUETES, ROLES Y PERMISOS
-- ============================================

-- Revocar permisos sobre vistas
REVOKE SELECT ON vw_tours_disponibles FROM c##rol_persona_comun;
REVOKE SELECT ON vw_estado_reserva    FROM c##rol_persona_comun;
REVOKE SELECT ON vw_info_usuario      FROM c##rol_persona_comun;
REVOKE SELECT ON vw_avistamientos     FROM c##rol_persona_academica;
REVOKE SELECT ON vw_especies          FROM c##rol_persona_academica;
REVOKE SELECT ON vw_proyectos         FROM c##rol_persona_academica;
REVOKE SELECT ON vw_asesorias         FROM c##rol_persona_academica;
REVOKE SELECT ON vw_usuarios          FROM c##rol_administrador;
REVOKE SELECT ON vw_tours_admin       FROM c##rol_administrador;

-- Revocar permisos DML
REVOKE INSERT, UPDATE ON Reservas      FROM c##rol_persona_comun;
REVOKE INSERT         ON Pagos         FROM c##rol_persona_comun;
REVOKE INSERT         ON Avistamientos FROM c##rol_persona_comun;
REVOKE UPDATE         ON Usuarios      FROM c##rol_persona_comun;

REVOKE INSERT, UPDATE, DELETE ON ProyectosInvestigacion FROM c##rol_persona_academica;
REVOKE UPDATE                 ON Asesorias              FROM c##rol_persona_academica;
REVOKE INSERT                 ON Reportes               FROM c##rol_persona_academica;

REVOKE INSERT, UPDATE, DELETE ON Usuarios      FROM c##rol_administrador;
REVOKE INSERT, UPDATE, DELETE ON Tours         FROM c##rol_administrador;
REVOKE INSERT, UPDATE, DELETE ON Especies      FROM c##rol_administrador;
REVOKE UPDATE                 ON Avistamientos FROM c##rol_administrador;

REVOKE INSERT, DELETE ON EntidadesEducativas FROM c##rol_admin_institucional;
REVOKE SELECT         ON Usuarios            FROM c##rol_admin_institucional;

-- Revocar EXECUTE sobre paquetes de actores
REVOKE EXECUTE ON pkg_persona_comun       FROM c##rol_persona_comun;
REVOKE EXECUTE ON pkg_persona_academica   FROM c##rol_persona_academica;
REVOKE EXECUTE ON pkg_administrador       FROM c##rol_administrador;
REVOKE EXECUTE ON pkg_admin_institucional FROM c##rol_admin_institucional;

-- Eliminar roles
DROP ROLE c##rol_persona_comun;
DROP ROLE c##rol_persona_academica;
DROP ROLE c##rol_administrador;
DROP ROLE c##rol_admin_institucional;

-- Eliminar paquetes de actores (body + spec)
DROP PACKAGE BODY pkg_persona_comun;
DROP PACKAGE      pkg_persona_comun;

DROP PACKAGE BODY pkg_persona_academica;
DROP PACKAGE      pkg_persona_academica;

DROP PACKAGE BODY pkg_administrador;
DROP PACKAGE      pkg_administrador;

DROP PACKAGE BODY pkg_admin_institucional;
DROP PACKAGE      pkg_admin_institucional;

COMMIT;
