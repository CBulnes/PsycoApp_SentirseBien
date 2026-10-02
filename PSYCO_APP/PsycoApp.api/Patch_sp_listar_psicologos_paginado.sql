-- Idempotent patch to replace sp_listar_psicologos_paginado with a version
-- compatible with the .NET data access layer (returns IdSedePrincipal, Sedes, etc.)
-- Run this file directly in your Postgres instance (psql or pgAdmin).

DROP FUNCTION IF EXISTS dbo.sp_listar_psicologos_paginado(integer, integer);
CREATE OR REPLACE FUNCTION dbo.sp_listar_psicologos_paginado(p_page integer, p_pagesize integer)
RETURNS TABLE (
    id integer,
    nombre varchar,
    apellido varchar,
    fechanacimiento date,
    documentotipo varchar,
    documentonumero varchar,
    telefono varchar,
    refrigerio varchar,
    especialidad integer,
    direccion varchar,
    distrito varchar,
    estado varchar,
    IdSedePrincipal integer,
    IdSedeSecundaria1 integer,
    IdSedeSecundaria2 integer,
    Sedes varchar
)
LANGUAGE sql
AS $$
    SELECT
        p.id,
        p.nombre,
        p.apellido,
        p.fechanacimiento,
        td.descripcion AS documentotipo,
        p.documentonumero,
        p.telefono,
        p.refrigerio,
        p.especialidad,
        p.direccion,
        p.distrito,
        p.estado,
        COALESCE((SELECT su.id_sede FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id AND su.principal = TRUE LIMIT 1), -1) AS IdSedePrincipal,
        COALESCE((SELECT su.id_sede FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id AND (su.principal = FALSE OR su.principal IS NULL) ORDER BY su.id_sede LIMIT 1 OFFSET 0), -1) AS IdSedeSecundaria1,
        COALESCE((SELECT su.id_sede FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id AND (su.principal = FALSE OR su.principal IS NULL) ORDER BY su.id_sede LIMIT 1 OFFSET 1), -1) AS IdSedeSecundaria2,
        COALESCE((SELECT string_agg(su.id_sede::text, ',' ORDER BY su.id_sede) FROM dbo.tbl_sede_usuario su WHERE su.id_psicologo = p.id), '') AS Sedes
    FROM dbo.tbl_psicologo p
    LEFT JOIN dbo.tbl_tipo_documento td ON td.id::text = p.documentotipo
    ORDER BY p.apellido, p.nombre
    LIMIT p_pagesize OFFSET GREATEST(p_page - 1, 0) * p_pagesize;
$$;

-- End of patch
