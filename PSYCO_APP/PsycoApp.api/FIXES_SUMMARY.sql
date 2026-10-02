-- ==================================================================
-- Resumen de fixes aplicados / parches disponibles
-- Archivo de respaldo y guía rápida para ejecutar los parches
-- Generado: 2026-05-17
-- Mantener este archivo en la raíz del proyecto API (PsycoApp.api)
-- ==================================================================

-- 1) Objetivo
-- Documentar de forma centralizada los cambios y parches SQL aplicados
-- y proporcionar instrucciones mínimas para su despliegue en PostgreSQL.

-- 2) Archivos de parche creados (ubicación relativa: PsycoApp.api/)
-- - Patch_sp_listar_psicologos_paginado.sql
--   => Corrige tipos y columnas devueltas por sp_listar_psicologos_paginado
-- - Patch_sp_listar_ubigeos.sql
--   => Crea la función dbo.sp_listar_ubigeos() esperada por la API
-- - Patch_sp_obtener_psicologo.sql
--   => Crea/normaliza dbo.sp_obtener_psicologo(integer)
-- - Patch_sp_listar_estudios_psicologo.sql
--   => Crea/normaliza dbo.sp_listar_estudios_psicologo(integer)
-- - Patch_sp_agregar_psicologo.sql
--   => Nueva: crea dbo.sp_agregar_psicologo(...) que acepta estudios en jsonb

-- 3) Otros cambios relevantes en el repositorio
-- - PsycoApp.api/SchemaPostgres.sql
--   => Contiene versión actualizada de sp_listar_psicologos_paginado (fuente de verdad)
-- - PSYCO_APP/PsycoApp.DA/PsicologoDA.cs
--   => Helpers robustos para leer columnas y evitar conversiones/IndexOutOfRange

-- 4) Orden recomendado para aplicar parches (psql)
-- Recomendado ejecutar en este orden mínimo:
-- 1) Patch_sp_listar_ubigeos.sql
-- 2) Patch_sp_obtener_psicologo.sql
-- 3) Patch_sp_listar_estudios_psicologo.sql
-- 4) Patch_sp_listar_psicologos_paginado.sql
-- 5) Patch_sp_agregar_psicologo.sql

-- Ejemplo de comando psql (reemplazar valores):
-- psql "host=HOST port=PORT dbname=DB user=USER password=PW" -f "PsycoApp.api/Patch_sp_listar_ubigeos.sql"

-- 5) Verificaciones rápidas en PostgreSQL
-- Comprobar que las funciones existen (desde psql):
-- SELECT proname, proargtypes FROM pg_proc WHERE proname LIKE 'sp_%' ORDER BY proname;

-- Comprobar una función concreta (ej. sp_obtener_psicologo):
-- SELECT n.nspname as schema, p.proname, pg_get_function_identity_arguments(p.oid) as args
-- FROM pg_proc p JOIN pg_namespace n ON p.pronamespace = n.oid
-- WHERE p.proname = 'sp_obtener_psicologo';

-- 6) Notas sobre firmas y compatibilidad
-- - La API (capa .NET) invoca funciones con nombre schema 'dbo' (p. ej. dbo.sp_obtener_psicologo).
--   En PostgreSQL es conveniente crear el schema dbo (si no existe) y crear las funciones ahí,
--   o ajustar el search_path. Los parches incluidos crean/usan schema dbo.
-- - Algunas funciones aceptan o devuelven JSON/JSONB para simplificar la inserción de colecciones
--   (por ejemplo, estudios). La capa .NET debe serializar ese parámetro apropiadamente.

-- 7) Pistas para debugging de la API después de aplicar parches
-- - Reiniciar la API y reproducir los endpoints:
--   GET /api/psicologo/listar/1/100
--   GET /Mantenimiento/Psicologo/Get/{id}
--   POST/PUT para guardar psicólogo
-- - Revisar PsycoApp.api/LOG_ERRORES/log-YYYYMMDD.log para nuevas entradas.

-- 8) Proximos pasos/pendientes
-- - Verificar si existen en la BD las funciones dbo.sp_actualizar_psicologo y dbo.sp_agregar_psicologo
--   con las firmas exactas que la API espera. Si faltan, crear parches equivalentes (T-SQL->PL/pgSQL).
-- - Si tras aplicar los parches hay errores nuevos, copiar las últimas 30-50 líneas del log
--   y añadirlas a este repositorio (por ejemplo en PsycoApp.api/LOG_ERRORES/) para seguimiento.

-- 9) Referencias en el repo
-- - T-SQL originales (para portar a Postgres) se encuentran en:
--   PSYCO_APP/PsycoApp.DA/SQLScripts/SCRIPT DATABASE.sql
-- - Parches SQL actuales: revisar PsycoApp.api/*.sql

-- ==================================================================
-- Fin del resumen
-- ==================================================================
