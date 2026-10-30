# Guía para investigar y cambiar el sistema

Fecha: 2026-10-29. Evidencia: síntesis propuesta a partir de la arquitectura; no es un procedimiento de despliegue validado.

1. Identifica la pantalla/controlador de site y la llamada mediante ApiCaller.
2. Localiza la ruta en Controllers de api y revisa autenticación, permisos y contexto de sede/empresa.
3. Sigue el método a BL, DA y al procedimiento SQL. Lee reglas en todas las capas.
4. Revisa entidades/DTO y consumidores afectados, incluyendo MCP cuando corresponda.
5. Define el comportamiento esperado y verifica escenarios relevantes antes de afirmar que funciona.
6. Actualiza la wiki y su bitácora con evidencia y límites.

## Rutas de investigación

| Si quieres cambiar… | Empieza por… |
|---|---|
| Agenda o paquetes | [Citas](citas.md) |
| Cobros o cuadre | [Caja](caja.md) |
| Alta de empresa | [Empresas y sedes](empresas-y-sedes.md) |
| Inicio de sesión o permisos | [Acceso](acceso.md) |
| Integración con asistentes | [MCP](mcp.md) |
| Persistencia o parches | [Datos](datos.md) |

Para validación futura, prioriza escenarios observables: una reserva concurrente, fallo intermedio en un paquete, fallo en un pago masivo y acceso a un recurso de otra sede. Son casos propuestos, no pruebas ejecutadas ni defectos confirmados.

No hay instrucciones de arranque verificadas en esta wiki. Antes de ejecutarlo, revisar SDK, configuración local, dependencias, base de prueba y proyecto de inicio, sin publicar secretos.

Fuentes: [Arquitectura](arquitectura.md), [solución](../../PSYCO_APP.sln).

Relacionados: [Preguntas abiertas](preguntas-abiertas.md), [Fuentes](fuentes.md).

## Verificación ejecutada

Ya existe una [batería HTTP reproducible](pruebas-funcionales.md). Revisa su alcance antes de atribuirle cobertura de citas o pagos con persistencia.
