-- Idempotent patch to create dbo.sp_listar_estudios_psicologo(integer)
-- Returns rows with columns: Id, IdPsicologo, GradoAcademico, Institucion, Carrera
-- Run with psql or pgAdmin against your Postgres database.

CREATE SCHEMA IF NOT EXISTS dbo;
SET search_path TO dbo, public;

DROP FUNCTION IF EXISTS dbo.sp_listar_estudios_psicologo(integer);
CREATE OR REPLACE FUNCTION dbo.sp_listar_estudios_psicologo(p_idpsicologo integer)
RETURNS TABLE (
    id integer,
    idpsicologo integer,
    gradoacademico integer,
    institucion integer,
    carrera integer
)
LANGUAGE sql
AS $$
    SELECT id, idpsicologo, gradoacademico, institucion, carrera
    FROM dbo.tbl_estudios_psicologo
    WHERE idpsicologo = p_idpsicologo
    ORDER BY id;
$$;

-- End of patch
