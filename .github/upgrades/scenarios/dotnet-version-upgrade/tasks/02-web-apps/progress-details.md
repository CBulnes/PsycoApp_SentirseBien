# Progress details — 02-web-apps

## Cambios realizados
- `PSYCO_APP/PsycoApp.api/PsycoApp.api.csproj`: actualizado a `net10.0`; paquetes directos migrados a las versiones compatibles seleccionadas, incluidos Application Insights 3.1.2, JwtBearer 10.0.12, IdentityModel.Tokens 8.23.0, Newtonsoft.Json 13.0.4 y System.Data.SqlClient 4.9.1.
- `PSYCO_APP/PsycoApp.api/Startup.cs`: actualizado el registro de Application Insights para asignar `ConnectionString` mediante opciones; retirados `using` no utilizados.
- `PSYCO_APP/PsycoApp.site/PsycoApp.site.csproj`: actualizado a `net10.0`; RuntimeCompilation, Newtonsoft.Json, System.Drawing.Common y WebEssentials PWA actualizados; eliminada referencia redundante a Microsoft.AspNetCore.Session.
- `PSYCO_APP/PsycoApp.site/Startup.cs`: se mantiene la configuración de MVC/Razor y sesión con timeout, retirando registros duplicados y la llamada encadenada PWA incompatible; quitados `using` sin uso.
- `PSYCO_APP/PsycoApp.site/Controllers/HomeController.cs`: reemplazado `IHostingEnvironment` por `IWebHostEnvironment`.
- `PSYCO_APP/PsycoApp.DA/CitaDA.cs`: por autorización expresa del usuario, retirados solamente los `using Microsoft.VisualBasic` y `using System.Linq`, reportados como no utilizados.

## Validación
- Build dirigido de `PsycoApp.api.csproj`: correcto.
- Build dirigido de `PsycoApp.site.csproj`: correcto.
- La compilación completa de la solución elimina los avisos IDE0005 en CitaDA y Startup, pero permanece bloqueada por CS1501 en `PsycoApp.mcp/Services/CitasMcpService.cs:53` y `PsycoMCPServer/Services/PlanServices.cs:55`: ambos llaman a `disponibilidad_doctor` con cuatro argumentos. No se modificaron esos proyectos ni las bibliotecas compartidas.
- No se encontraron proyectos de prueba asociados al API; el descubrimiento previo del escenario tampoco identificó proyectos de pruebas.
- `git diff --check`: sin errores de whitespace.

## Incidencias / límites
- Se respetó el alcance API/sitio. La única excepción a shared/out-of-scope fue la autorización explícita y limitada para quitar dos `using` sin uso en `CitaDA.cs`.
- Para compilar solución completa hace falta investigar si las llamadas MCP a `disponibilidad_doctor` ya estaban desfasadas respecto a la firma del BL. No se amplió el arreglo a esos proyectos, porque el usuario solo autorizó la limpieza puntual de `CitaDA.cs`.