# Registro de fuentes

Fecha: 2026-10-29. Las fuentes tienen distinto alcance y autoridad.

| ID | Fuente | Uso y límites |
|---|---|---|
| F01 | [Patrón de wiki LLM](../raw/patron-segundo-cerebro.txt) | Texto aportado por el usuario. Define el patrón, no hechos del producto. |
| F02 | [Descripción del proyecto](../raw/descripcion-proyecto.txt) | Texto aportado previamente. Contexto secundario; se conserva sin corregir. |
| F03 | [Solución](../../PSYCO_APP.sln) y csproj enlazados desde arquitectura | Referencias y frameworks inspeccionados; no compilados. |
| F04 | [Startup sitio](../../PsycoApp.site/Startup.cs) y [Startup API](../../PsycoApp.api/Startup.cs) | Configuración leída; no acredita valores desplegados. |
| F05 | [CitaBL](../../PsycoApp.BL/CitaBL.cs) y [CitaController](../../PsycoApp.api/Controllers/CitaController.cs) | Registro leído y métodos/rutas inventariados; SQL no revisado exhaustivamente. |
| F06 | [CajaBL](../../PsycoApp.BL/CajaBL.cs), [CajaDA](../../PsycoApp.DA/CajaDA.cs), [CajaController](../../PsycoApp.api/Controllers/CajaController.cs) | Registro individual/masivo leído en BL; otros métodos/rutas y uso de SP inventariados. |
| F07 | [EmpresaSedeBL](../../PsycoApp.BL/EmpresaSedeBL.cs) | Archivo leído para reglas de alta y normalización. |
| F08 | [SchemaSQL](../../SQL/SchemaSQL.sql) | Inventario de CREATE TABLE, no auditoría integral de procedimientos o FK. |
| F09 | [Program mcp](../../PsycoApp.mcp/Program.cs) y [Program servidor](../../PsycoMCPServer/Program.cs) | Hosts y servicios leídos; herramientas no ejecutadas. |
| F10 | [UsuarioController](../../PsycoApp.api/Controllers/UsuarioController.cs) | Atributos de rutas y anonimato inspeccionados; lógica de credenciales pendiente. |

El repositorio es una fuente viva. Las páginas reflejan lo observado el 2026-10-29 y pueden quedar obsoletas tras cambios. Las copias raw preservan los documentos iniciales; no son una instantánea del código. Esta ingesta no utilizó fuentes web ni datos de pacientes.

Relacionados: [Índice](index.md), [Preguntas abiertas](preguntas-abiertas.md), [Bitácora](log.md).

## F11 — Ejecución funcional inicial

Ver [informe](pruebas-funcionales.md) y [ejecutor](../../tests/functional/run.ps1): 19 casos HTTP aislados aprobados y comprobación adicional de login y cinco rutas con sesión. Fecha 2026-10-29. No acredita ciclo completo con persistencia ni pruebas visuales.

## Investigación de altas por sede — 2026-10-29

Ver [hallazgos y pendientes](altas-por-empresa.md): consulta local de solo lectura, paciente no presente en la sede indicada, un especialista existente vinculado y un vínculo huérfano. La validación de documento del paciente es global; no se confirmó que explique el incidente.

## Google — 2026-10-29
[Implementación y evidencia](login-google.md): fuentes de código, migración local y suites HTTP, criptográfica y SQL. Documentación oficial enlazada en la guía; pendiente autenticación externa real.

Configuración Google actualizada el 2026-10-29: [sitio](../../PsycoApp.site/appsettings.Google.json) y [API](../../PsycoApp.api/appsettings.Google.json). JSON releído y valores coincidentes verificados; sin secretos. Login real pendiente.

Correo Google: [validador](../../PsycoApp.api/Security/GoogleIdentityValidator.cs), [controlador](../../PsycoApp.api/Controllers/GoogleController.cs) y [persistencia](../../PsycoApp.DA/GoogleIdentityDA.cs), actualizados 2026-10-29 para guardar el correo verificado.

Portada Google: [vista SaaS](../../PsycoApp.site/Views/SaaS/Index.cshtml), revisada y modificada 2026-10-29; reutiliza el componente existente.

Bienvenida Google: [servicio SMTP](../../PsycoApp.api/Services/WelcomeEmail.cs), [guía](../../docs/correo-bienvenida.md) y [pruebas](../../tests/GoogleAccess.SecurityTests/Program.cs).
