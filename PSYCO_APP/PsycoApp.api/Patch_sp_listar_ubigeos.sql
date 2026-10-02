-- Idempotent patch to ensure dbo.sp_listar_ubigeos exists
-- Run this file with psql or pgAdmin against your Postgres database.

CREATE SCHEMA IF NOT EXISTS dbo;
SET search_path TO dbo, public;

DROP FUNCTION IF EXISTS dbo.sp_listar_ubigeos();
CREATE OR REPLACE FUNCTION dbo.sp_listar_ubigeos()
RETURNS TABLE (id integer, codubigeo varchar, departamento varchar, provincia varchar, distrito varchar)
LANGUAGE sql
AS $$
    SELECT id, codubigeo, departamento, provincia, distrito
    FROM dbo.tbl_ubigeo
    ORDER BY departamento, provincia, distrito;
$$;

-- End of patch
