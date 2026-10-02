-- Patch to create dbo.sp_agregar_psicologo accepting estudios as jsonb
-- Safe to run multiple times

CREATE SCHEMA IF NOT EXISTS dbo;
SET search_path TO dbo, public;

DROP FUNCTION IF EXISTS dbo.sp_agregar_psicologo(varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, integer, integer, integer, integer, varchar, varchar, varchar, jsonb);
CREATE OR REPLACE FUNCTION dbo.sp_agregar_psicologo(
    p_nombre varchar,
    p_apellido varchar,
    p_fechaNacimiento varchar,
    p_documentotipo varchar,
    p_documentonumero varchar,
    p_telefono varchar,
    p_refrigerio varchar,
    p_inicioLabores varchar,
    p_finLabores varchar,
    p_idSedePrincipal integer,
    p_idSedeSecundaria integer,
    p_idSedeTerciaria integer,
    p_especialidad integer,
    p_direccion varchar,
    p_distrito varchar,
    p_estado varchar,
    p_estudios jsonb DEFAULT '[]'
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_id integer;
    e jsonb;
BEGIN
    INSERT INTO dbo.tbl_psicologo (nombre, apellido, fechanacimiento, documentotipo, documentonumero, telefono, refrigerio, iniciolabores, finlabores, especialidad, direccion, distrito, estado)
    VALUES (p_nombre, p_apellido, p_fechaNacimiento::date, p_documentotipo, p_documentonumero, p_telefono, p_refrigerio, p_inicioLabores, p_finLabores, p_especialidad, p_direccion, p_distrito, p_estado)
    RETURNING id INTO v_id;

    -- Insert sede usuario entries
    IF p_idSedePrincipal IS NOT NULL THEN
        INSERT INTO dbo.tbl_sede_usuario (id_sede, id_psicologo, fecha, principal)
        VALUES (p_idSedePrincipal, v_id, dbo.get_date()::date, true);
    END IF;

    IF p_idSedeSecundaria IS NOT NULL AND p_idSedeSecundaria <> -1 THEN
        INSERT INTO dbo.tbl_sede_usuario (id_sede, id_psicologo, fecha, principal)
        VALUES (p_idSedeSecundaria, v_id, dbo.get_date()::date, false);
    END IF;

    IF p_idSedeTerciaria IS NOT NULL AND p_idSedeTerciaria <> -1 THEN
        INSERT INTO dbo.tbl_sede_usuario (id_sede, id_psicologo, fecha, principal)
        VALUES (p_idSedeTerciaria, v_id, dbo.get_date()::date, false);
    END IF;

    -- Insert estudios if provided (expects array of objects with properties IdPsicologo/GradoAcademico/Institucion/Carrera or similar)
    IF jsonb_array_length(p_estudios) > 0 THEN
        FOR e IN SELECT * FROM jsonb_array_elements(p_estudios)
        LOOP
            -- try to read fields, fallback to null
            INSERT INTO dbo.tbl_estudios_psicologo (idpsicologo, gradoacademico, institucion, carrera)
            VALUES (
                COALESCE((e->>'idPsicologo')::integer, v_id),
                COALESCE((e->>'gradoAcademico')::integer, NULL),
                COALESCE((e->>'institucion')::integer, NULL),
                COALESCE((e->>'carrera')::integer, NULL)
            );
        END LOOP;
    END IF;
END;
$$;

-- End patch
