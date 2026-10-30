# Pruebas funcionales iniciales

Fecha: 2026-10-29 (America/Lima). Evidencia: ejecución HTTP real; no pruebas visuales de navegador.

## Resultado

19/19 casos automatizados aprobados. Sitio y API compilados por separado con SDK 10.0.401: cero errores y cero advertencias en ambas compilaciones finales. La compilación inicial de la solución falló por archivos del sitio en uso (MSB3021/MSB3027); no se cerraron procesos ajenos. Un primer intento de salida compartida produjo conflictos entre proyectos; las compilaciones finales usan salidas separadas por proyecto y ejecución secuencial.

La instancia API aislada requirió una cadena sintética de Application Insights para arrancar. DisableTelemetry por sí solo no evitó el error de configuración ausente en el exportador. Se usaron endpoints de telemetría exclusivamente locales, sin credenciales reales.

## Entorno y límites

El ejecutor inicia sitio y API temporalmente en puertos loopback dinámicos, con configuración sintética. SQL apunta a 127.0.0.1:1, sin base accesible; el caso de dependencia no disponible comprueba el manejo de ese fallo intencionado. Se copian vistas para renderizarlas y se usa el wwwroot del sitio. Al terminar se cierran solo los procesos creados por el ejecutor. No se copiaron configuraciones originales ni credenciales.

Adicionalmente se comprobó en las instancias IIS Express locales existentes que la empresa y sede indicadas por el usuario se encuentran, que el login devuelve estado verdadero y que Home, RegistroCitas, Mantenimiento/Paciente, Caja y Reportes responden HTTP 200 con sesión. La cookie temporal se eliminó; las credenciales y cuerpos de respuesta no se incorporaron al informe. Un HTTP 200 no acredita ejecución JavaScript, corrección visual, resultados de negocio ni ausencia de una página de error renderizada.

No se crearon pacientes, citas, empresas ni pagos. No se probó confirmación/atención/cancelación, concurrencia, paquetes, aislamiento con dos cuentas, reversión de pagos ni apertura/cierre de caja. El login puede producir los registros técnicos habituales de la aplicación. No se afirmó que la base indicada sea una base de pruebas.

## Casos automatizados

| Caso | Esperado HTTP | Obtenido HTTP | Resultado |
|---|---|---|---|
| Landing pública | 200 | 200 | Aprobado |
| Pantalla de login | 200 | 200 | Aprobado |
| Formulario SaaS y antiforgery | 200 | 200 | Aprobado |
| CSS de pantalla pública | 200 | 200 | Aprobado |
| Home sin sesión redirige | 302 | 302 | Aprobado |
| Sede inválida en login | 400 | 400 | Aprobado |
| SaaS rechaza POST sin antiforgery | 400 | 400 | Aprobado |
| SaaS exige datos con token válido | 200 | 200 | Aprobado |
| SaaS valida usuario y confirmación | 200 | 200 | Aprobado |
| SaaS rechaza contraseñas diferentes | 200 | 200 | Aprobado |
| Citas rechaza anónimo | 401 | 401 | Aprobado |
| Caja rechaza anónimo | 401 | 401 | Aprobado |
| Alta empresa rechaza anónimo | 401 | 401 | Aprobado |
| Citas rechaza token inválido | 401 | 401 | Aprobado |
| Registro API exige datos | 400 | 400 | Aprobado |
| Registro API rechaza JSON malformado | 400 | 400 | Aprobado |
| Registro API rechaza usuario con números | 400 | 400 | Aprobado |
| Login no disponible informa 503 | 503 | 503 | Aprobado |
| Ruta inexistente conserva 404 | 404 | 404 | Aprobado |
Los casos de formulario comprueban contenido además del código HTTP cuando se especifica en el ejecutor. La redirección sin sesión y las rutas consultadas con sesión se comprueban a nivel de estado HTTP. No se utilizaron mocks del controlador: se enviaron solicitudes a procesos reales.

## Reproducir

Ver [instrucciones y ejecutor](../../tests/functional/README.md). Resultados detallados de la última ejecución en `.functional-artifacts/results.json` (artefacto local regenerable).

## Siguiente alcance

Confirmar un entorno destinado a pruebas y datos sintéticos para completar: alta de paciente → reserva y atención → cobro y cuadre. Preparar limpieza y comprobar importes, estados y persistencia. Las operaciones con la cuenta existente se limitaron a login y consultas.

Fuentes: [Ejecutor](../../tests/functional/run.ps1), [Citas](citas.md), [Caja](caja.md), [Acceso](acceso.md).

Relacionados: [Índice](index.md), [Preguntas abiertas](preguntas-abiertas.md), [Fuentes](fuentes.md), [Guía de cambios](guia-de-cambios.md).

## Ampliación Google — 2026-10-29
28/28 casos HTTP con Google desactivado y 30/30 con configuración sintética habilitada. Además, 16 comprobaciones criptográficas y 16 de persistencia aislada aprobadas. Ver [alcance y fuentes](login-google.md); no sustituye la prueba con Google real.
