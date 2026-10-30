# Preguntas abiertas y discrepancias

Fecha: 2026-10-29. Evidencia: pendientes derivados de la revisión; no constituyen defectos confirmados ni decisiones aprobadas.

| ID | Pregunta | Evidencia y siguiente comprobación |
|---|---|---|
| P01 | ¿Qué módulos funcionan actualmente? | Hay pruebas HTTP iniciales: 19/19 y login con navegación consultiva. Falta ciclo completo con persistencia; ver [informe](pruebas-funcionales.md). |
| P02 | ¿Por qué utilities conserva netcoreapp3.1? | Diferencia comprobada en csproj. Compilar solución y revisar compatibilidad antes de proponer migración. |
| P03 | ¿Qué host MCP se usa y qué controles aplica? | Dos Program con stdio. Comparar herramientas, configuración y despliegue. |
| P04 | ¿Cuál es el esquema SQL vigente? | Esquema y parches descritos. Contrastar orden de cambios con una base autorizada. |
| P05 | ¿Hay aislamiento completo por empresa y sede? | Existen validaciones de pertenencia, pero falta recorrer todos los consumidores. |
| P06 | ¿Cómo se comportan pagos masivos ante un fallo intermedio? | BL recorre pagos y reemplaza la respuesta. Revisar DA/SQL y verificar resultados parciales. |
| P07 | ¿Son atómicos y seguros ante concurrencia los paquetes y reservas? | Registro con varias llamadas. Revisar transacciones, bloqueos y restricciones SQL. |
| P08 | ¿Qué protección tiene el cambio de contraseña anónimo? | Atributo AllowAnonymous observado. Leer flujo completo y validaciones. |
| P09 | ¿Dónde están las pruebas de caja? | Carpeta IntegrationTests vacía en esta revisión. Buscar suites externas o pendientes. |

## Discrepancias resueltas en esta ingesta

- Una explicación anterior mencionó la carpeta de pruebas de caja como algo a considerar. La lectura posterior la encontró vacía; se documenta la existencia de la carpeta, sin atribuirle pruebas.
- El texto aportado menciona configuración de «sesión de errores» en API. El Startup leído acredita Application Insights, autenticación y autorización; no se confirmó esa expresión como capacidad concreta.
- El texto usa PsycoApp.Entities; la carpeta real se lista como PsycoApp.entities. Usar las rutas reales del repositorio.

No se registraron decisiones arquitectónicas históricas: no hay evidencia suficiente para reconstruir sus motivos.

Fuentes: [Fuentes](fuentes.md), [Caja](caja.md), [Citas](citas.md), [Acceso](acceso.md), [Arquitectura](arquitectura.md).

## Investigación de altas por sede — 2026-10-29

Ver [hallazgos y pendientes](altas-por-empresa.md): consulta local de solo lectura, paciente no presente en la sede indicada, un especialista existente vinculado y un vínculo huérfano. La validación de documento del paciente es global; no se confirmó que explique el incidente.
