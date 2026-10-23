-- ============================================
-- SEGURIDAD - DEFINICIÓN DE ROLES Y PERMISOS
-- ============================================

CREATE ROLE c##rol_persona_comun;
CREATE ROLE c##rol_persona_academica;
CREATE ROLE c##rol_administrador;
CREATE ROLE c##rol_admin_institucional;

-- ── PERMISOS: rol_persona_comun ──
GRANT EXECUTE ON pkg_persona_comun    TO c##rol_persona_comun;
GRANT SELECT  ON vw_tours_disponibles TO c##rol_persona_comun;
GRANT SELECT  ON vw_estado_reserva    TO c##rol_persona_comun;
GRANT SELECT  ON vw_info_usuario      TO c##rol_persona_comun;
GRANT INSERT, UPDATE ON Reservas      TO c##rol_persona_comun;
GRANT INSERT         ON Pagos         TO c##rol_persona_comun;
GRANT INSERT         ON Avistamientos TO c##rol_persona_comun;
GRANT UPDATE         ON Usuarios      TO c##rol_persona_comun;

-- ── PERMISOS: rol_persona_academica ──
GRANT c##rol_persona_comun             TO c##rol_persona_academica;
GRANT EXECUTE ON pkg_persona_academica TO c##rol_persona_academica;
GRANT SELECT  ON vw_avistamientos      TO c##rol_persona_academica;
GRANT SELECT  ON vw_especies           TO c##rol_persona_academica;
GRANT SELECT  ON vw_proyectos          TO c##rol_persona_academica;
GRANT SELECT  ON vw_asesorias          TO c##rol_persona_academica;
GRANT INSERT, UPDATE, DELETE ON ProyectosInvestigacion TO c##rol_persona_academica;
GRANT UPDATE                 ON Asesorias              TO c##rol_persona_academica;
GRANT INSERT                 ON Reportes               TO c##rol_persona_academica;

-- ── PERMISOS: rol_administrador ──
GRANT EXECUTE ON pkg_administrador     TO c##rol_administrador;
GRANT SELECT  ON vw_usuarios           TO c##rol_administrador;
GRANT SELECT  ON vw_tours_admin        TO c##rol_administrador;
GRANT INSERT, UPDATE, DELETE ON Usuarios      TO c##rol_administrador;
GRANT INSERT, UPDATE, DELETE ON Tours         TO c##rol_administrador;
GRANT INSERT, UPDATE, DELETE ON Especies      TO c##rol_administrador;
GRANT UPDATE                 ON Avistamientos TO c##rol_administrador;

-- ── PERMISOS: rol_admin_institucional ──
GRANT EXECUTE    ON pkg_admin_institucional  TO c##rol_admin_institucional;
GRANT INSERT, DELETE ON EntidadesEducativas  TO c##rol_admin_institucional;
GRANT SELECT         ON Usuarios             TO c##rol_admin_institucional;

COMMIT;
