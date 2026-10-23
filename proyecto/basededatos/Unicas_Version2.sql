-- ============================================
-- ÚNICAS - DEFINICIÓN DE CLAVES ÚNICAS
-- ============================================

ALTER TABLE Usuarios
ADD CONSTRAINT UQ_Usuario_Email UNIQUE (Email);

ALTER TABLE PersonasComunes
ADD CONSTRAINT UQ_PersonaComun_Documento UNIQUE (DocumentoIdentidad);

ALTER TABLE EntidadesCorporativas
ADD CONSTRAINT UQ_EntidadCorporativa_NIT UNIQUE (NIT);

ALTER TABLE Especies
ADD CONSTRAINT UQ_Especie_NombreCientifico UNIQUE (NombreCientifico);

ALTER TABLE Ubicaciones
ADD CONSTRAINT UQ_Ubicacion_Nombre UNIQUE (Nombre);

COMMIT;