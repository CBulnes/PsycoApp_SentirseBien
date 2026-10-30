# Integración MCP

Fecha: 2026-10-29. Evidencia: Program.cs y referencias de ambos proyectos.

Hay dos ejecutables MCP. Ambos configuran AddMcpServer, WithStdioServerTransport y descubrimiento de herramientas desde el assembly de CitasMcpTool. No se observó un host HTTP MCP activo en los Program revisados; los ejemplos comentados no cuentan como configuración ejecutable.

PsycoApp.mcp registra CitasMcpService, PacienteBL, PsicologoBL y CitaBL. PsycoMCPServer registra esas clases BL y PlanServices, carga appsettings opcional y variables de entorno, y configura logging. Ambos proyectos referencian BL, DA y entities.

No se ha comparado el catálogo completo de herramientas ni demostrado cuál host se usa. Tampoco se ha comprobado que reproduzcan las autorizaciones de la API. No asumir que una herramienta pasa por JWT solo porque la API lo utiliza.

Fuentes: [Program mcp](../../PsycoApp.mcp/Program.cs), [proyecto mcp](../../PsycoApp.mcp/PsycoApp.mcp.csproj), [Program PsycoMCPServer](../../PsycoMCPServer/Program.cs), [proyecto PsycoMCPServer](../../PsycoMCPServer/PsycoMCPServer.csproj).

Relacionados: [Arquitectura](arquitectura.md), [Acceso](acceso.md), [Citas](citas.md), [Preguntas abiertas](preguntas-abiertas.md).
