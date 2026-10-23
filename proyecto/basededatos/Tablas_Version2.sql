-- ============================================
-- TABLAS - CREACIÓN DE TABLAS
-- ============================================

-- TABLA PADRE: Usuario (Joined Table Inheritance)
CREATE TABLE Usuarios (
    IdUsuario NUMBER(10),
    Nombre VARCHAR2(100),
    Email VARCHAR2(100),
    TipoUsuario VARCHAR2(20)
);

-- SUBTIPOS DE USUARIO (PK = IdUsuario, sin ID propio)
CREATE TABLE PersonasComunes (
    IdUsuario NUMBER(10),
    NumeroCelular VARCHAR2(15),
    DocumentoIdentidad VARCHAR2(50)
);

CREATE TABLE EntidadesEducativas (
    IdUsuario NUMBER(10),
    Institucion VARCHAR2(30),
    NombreInstitucion VARCHAR2(100)
);

CREATE TABLE EntidadesCorporativas (
    IdUsuario NUMBER(10),
    RazonSocial VARCHAR2(100),
    NIT VARCHAR2(16)
);

CREATE TABLE PersonasAcademicas (
    IdUsuario NUMBER(10),
    Profesion VARCHAR2(50),
    Certificacion VARCHAR2(500)
);

CREATE TABLE Administradores (
    IdUsuario NUMBER(10),
    Permisos VARCHAR2(500)
);

-- TABLA: Reserva
CREATE TABLE Reservas (
    IdReserva NUMBER(10),
    IdUsuario NUMBER(10),
    Fecha DATE,
    Personas NUMBER(3),
    Estado VARCHAR2(20)
);

-- TABLA: Pago
CREATE TABLE Pagos (
    IdPago NUMBER(10),
    IdReserva NUMBER(10),
    IdTour NUMBER(10),
    IdAsesoria NUMBER(10),
    Monto NUMBER(12,2),
    FechaPago DATE,
    Estado VARCHAR2(20)
);

-- TABLA: Tour
CREATE TABLE Tours (
    IdTour NUMBER(10),
    Fecha DATE,
    Duracion VARCHAR2(5),
    Cupo NUMBER(3),
    Guia VARCHAR2(100),
    Longitud NUMBER(10,2),
    IdAdministrador NUMBER(10)
);

-- TABLA: Ubicacion
CREATE TABLE Ubicaciones (
    IdUbicacion NUMBER(10),
    Nombre VARCHAR2(100),
    Descripcion VARCHAR2(500)
);

-- TABLA JUNCTION: Tour_Ubicacion (1..* a 1..*)
CREATE TABLE Tours_Ubicacion (
    IdTour NUMBER(10),
    IdUbicacion NUMBER(10)
);

-- TABLA: Especie
CREATE TABLE Especies (
    IdEspecie NUMBER(10),
    NombreComun VARCHAR2(100),
    NombreCientifico VARCHAR2(100)
);

-- TABLA: Avistamiento
CREATE TABLE Avistamientos (
    IdAvistamiento NUMBER(10),
    IdEspecie NUMBER(10),
    IdPersonaAcademica NUMBER(10),
    IdAdministrador NUMBER(10),
    Fecha DATE,
    Cantidad NUMBER(5),
    Foto VARCHAR2(500),
    Observaciones VARCHAR2(1000)
);

-- TABLA JUNCTION: Avistamiento_Ubicacion (* a *)
CREATE TABLE Avistamientos_Ubicacion (
    IdAvistamiento NUMBER(10),
    IdUbicacion NUMBER(10)
);

-- TABLA: Asesoria
CREATE TABLE Asesorias (
    IdAsesoria NUMBER(10),
    FechaInicio DATE,
    FechaFinalizacion DATE,
    Estado VARCHAR2(20)
);

-- TABLA: Reporte
CREATE TABLE Reportes (
    IdReporte NUMBER(10),
    IdAsesoria NUMBER(10),
    Fecha DATE
);

-- TABLA JUNCTION: ProyectosInvestigacion_Reporte (* a *)
CREATE TABLE ProyectosInvestigacion_Reporte (
    IdProyecto NUMBER(10),
    IdReporte NUMBER(10)
);

-- TABLA: ProyectosInvestigacion
CREATE TABLE ProyectosInvestigacion (
    IdProyecto NUMBER(10),
    IdPersonaAcademica NUMBER(10),
    IdEntidadEducativa NUMBER(10),
    Nombre VARCHAR2(100),
    FechaInicio DATE,
    FechaFinalizacion DATE,
    Estado VARCHAR2(20)
);

CREATE TABLE Observaciones(
    IdAvistamiento NUMBER(10),
    Observacion VARCHAR(50)
);

COMMIT;
