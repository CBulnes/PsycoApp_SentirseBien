# Bitácora

Registro cronológico; añadir entradas al final. Fechas en America/Lima.

## [2026-10-29] ingest | Base inicial de PSYCO_APP

Se incorporaron el patrón de wiki LLM y la descripción previa como fuentes raw. Se contrastaron proyectos, frameworks, Startup, hosts MCP, métodos de negocio, rutas de citas/caja/usuarios y tablas del esquema. Se crearon índice, visión, arquitectura, módulos, citas, caja, empresas/sedes, datos, acceso, MCP, guía de cambios, preguntas y fuentes.

Se separaron hechos, inferencias y pendientes. Se corrigió la posible interpretación de la carpeta de pruebas vacía como suite existente. No se ejecutaron aplicación, compilaciones, pruebas ni SQL. Se preservaron los archivos preexistentes del proyecto.

Relacionados: [Índice](index.md), [Fuentes](fuentes.md), [Preguntas abiertas](preguntas-abiertas.md).

## [2026-10-29] lint | Revisión inicial de enlaces y fuentes

Comprobados 140 enlaces locales en 16 documentos Markdown: todos sus destinos existen. Todas las páginas de wiki aparecen en el índice. Las dos copias raw coinciden por SHA-256 con los adjuntos originales. Esta validación comprueba estructura documental, no funcionamiento de la aplicación.


## [2026-10-29] decision | Mantenimiento automático durante tareas

El usuario solicitó actualización automática del segundo cerebro. Se creó AGENTS.md en la raíz para exigir mantener las notas al completar cambios relevantes y guardar hallazgos duraderos sin una petición adicional. Se actualizó README con el mecanismo y sus límites: no hay monitor de cambios externos ni servicio en segundo plano. No se modificó código de la aplicación.

Fuentes: [Regla del proyecto](../../AGENTS.md), [Guía de uso](../README.md).

## [2026-10-29] test | Primera batería funcional HTTP

19/19 casos aislados aprobados. Sitio y API compilados por separado sin errores ni advertencias. Login y cinco rutas autenticadas comprobados en las instancias locales existentes. No se crearon datos de negocio. Se documentaron bloqueos de compilación iniciales y limitaciones. Actualizados índice, fuentes, guía de cambios y pregunta P01; añadido [informe](pruebas-funcionales.md) y ejecutor reproducible. Los secretos y la cookie no se guardaron en documentación.

## [2026-10-29] investigate | Altas por empresa y sede

Leídos controladores y DA; consultadas definiciones SQL locales y conteos sin modificar registros. Documentados hallazgos y límites en [altas por empresa](altas-por-empresa.md). Actualizados índice, empresas/sedes, preguntas y fuentes. No se copiaron credenciales ni datos personales. El incidente no se considera resuelto.

## [2026-10-29] test | Resultado de altas y corrección de acceso

[Altas QA](altas-por-empresa.md) comprobadas por HTTP y SQL: paciente y especialista guardados en la sede solicitada y visibles. Detectada asociación adicional del especialista con sede 0. Posteriormente, el acceso con credenciales corregidas fue rechazado; no hubo más altas ni cambio de contraseña. No se almacenaron credenciales.

## [2026-10-29] research | Propuesta de acceso Google

Consultados Skills.sh y documentación oficial de Google. Añadida propuesta a [Acceso](acceso.md), diferenciando skills de integración OAuth y conservando empresa, sede y roles internos. No se instaló ni implementó autenticación externa.

## [2026-10-29] implement | Registro y acceso Google
Implementados alta y vinculación explícita, controles criptográficos y de sesión, configuración desactivada y guía. Migración local aplicada sin vinculaciones. Compilaciones correctas y suites 28/28, 30/30 HTTP, 16 criptográficas y 16 SQL aprobadas. Actualizados índice, acceso, fuentes, pruebas y nueva nota login-google. Falta Client ID para probar Google real.

## [2026-10-29] configure | Client ID Google
Habilitado Google con el ID público aportado en sitio y API. Verificados ambos JSON y coincidencia del ID. No se guardó secreto. Actualizadas acceso, login-google y fuentes. Pendiente reiniciar instancias y completar autenticación real.

## [2026-10-29] implement | Persistir correo Google
Email verificado guardado en alta y vinculación, refrescado al iniciar sesión para cuentas previas; login interno conservado. Validador exige correo válido dentro del límite de 100 caracteres. Pasaron 19 pruebas criptográficas y 18 SQL en base desechable; compilación de API incluida en la ejecución. Actualizadas login-google y fuentes. Pendiente reiniciar API y probar con cuenta real; no se modificaron correos reales directamente.

## [2026-10-29] UI | Google en portada
Agregado el componente oficial Google debajo del CTA principal de SaaS, con separación y ancho adaptable. Compilación sitio sin errores ni advertencias y 30/30 pruebas HTTP existentes aprobadas. Actualizadas login-google y fuentes. No se verificó visualmente en navegador ni se ejecutó autenticación real en esta tarea.

## [2026-10-29] implement | Bienvenida SMTP tras alta Google
Servicio SMTP configurado por variables/secretos, desactivado por defecto. Alta confirmada intenta envío sin revertir la cuenta ante fallo. Compilación API sin errores; 19 pruebas criptográficas y comprobaciones de envío desactivado/fallo SMTP aprobadas. Actualizadas login-google, fuentes y guía correo-bienvenida. Pendientes remitente, contraseña de aplicación local y prueba de entrega real. No se enviaron correos externos.
