# Copilot Instructions

## Directrices del proyecto
- Para esta migración .NET 10, el usuario autorizó una excepción puntual al límite de alcance para eliminar exclusivamente directivas using sin uso reportadas por la compilación en PsycoApp.DA/CitaDA.cs; no implica autorización para otros cambios en DA ni en bibliotecas compartidas.
- El usuario amplió el alcance de esta migración para que PsycoApp.BL, PsycoApp.DA y PsycoApp.Entities también apunten a net10.0. Mantener MCP fuera del alcance por ahora; antes de retargetear esas bibliotecas, resolver cómo compatibilizar PsycoApp.mcp, que apunta a net9.0 y las consume.
- El usuario autorizó actualizar PsycoApp.mcp a net10.0 para que pueda referenciar las bibliotecas actualizadas, y también autorizó corregir las llamadas con aridad incorrecta a disponibilidad_doctor en ambos proyectos MCP.
- El usuario pide no ejecutar pruebas para esta incidencia; prefiere que se revise el código SQL de apertura/cierre de caja directamente.