-- Idempotent patch to create dbo.sp_obtener_psicologo(integer)
-- Returns a single psychologist record with the columns expected by the .NET layer
-- Run with psql or pgAdmin against your Postgres database.

CREATE SCHEMA IF NOT EXISTS dbo;
SET search_path TO dbo, public;

DROP FUNCTION IF EXISTS dbo.sp_obtener_psicologo(integer);
CREATE OR REPLACE FUNCTION dbo.sp_obtener_psicologo(p_id integer)
RETURNS TABLE (
    Id integer,
    Nombre varchar,
    Apellido varchar,
    FechaNacimiento date,
    DocumentoTipo varchar,
    DocumentoNumero varchar,
    Telefono varchar,
    Especialidad integer,
    Distrito varchar,
    Direccion varchar,
    Estado varchar,
    Refrigerio varchar,
    InicioLabores varchar,
    FinLabores varchar,
    IdSedePrincipal integer,
    IdSedeSecundaria integer,
    IdSedeTerciaria integer
)
LANGUAGE sql
AS $$
    SELECT
        p.id AS Id,
        p.nombre AS Nombre,
        p.apellido AS Apellido,
        p.fechanacimiento::date AS FechaNacimiento,
        td.descripcion AS DocumentoTipo,
        p.documentonumero AS DocumentoNumero,
        p.telefono AS Telefono,
        p.especialidad AS Especialidad,
        p.distrito AS Distrito,
        p.direccion AS Direccion,
        p.estado AS Estado,
        p.refrigerio AS Refrigerio,
        p.iniciolabores AS InicioLabores,
        p.finlabores AS FinLabores,
        COALESCE((SELECT su.id_sede FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id AND su.principal = TRUE LIMIT 1), -1) AS IdSedePrincipal,
        COALESCE((SELECT su.id_sede FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id AND (su.principal = FALSE OR su.principal IS NULL) ORDER BY su.id_sede LIMIT 1 OFFSET 0), -1) AS IdSedeSecundaria,
        COALESCE((SELECT su.id_sede FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id AND (su.principal = FALSE OR su.principal IS NULL) ORDER BY su.id_sede LIMIT 1 OFFSET 1), -1) AS IdSedeTerciaria
    FROM dbo.tbl_psicologo p
    LEFT JOIN dbo.tbl_tipo_documento td ON td.id::text = p.documentotipo
    WHERE p.id = p_id
    LIMIT 1;
$$;

-- End of patch
