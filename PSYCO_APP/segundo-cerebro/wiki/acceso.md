# Acceso, JWT y sesión

Fecha: 2026-10-29. Evidencia: Startup de sitio/API y atributos de UsuarioController; no es una auditoría de seguridad.

La API aplica un AuthorizeFilter global que requiere autenticación. Configura Bearer JWT con validación de firma, emisor, audiencia y expiración, y RoleClaimType. Define dos políticas CORS y activa SoloSentirseBien con el origen obtenido de Helper.GetUrlSite.

La autorización global admite excepciones: UsuarioController marca `validar_usuario` y `actualizar_contraseña` como AllowAnonymous. Esta segunda acción requiere revisar su cuerpo y controles específicos antes de evaluar su protección. Un atributo anónimo aislado no demuestra una vulnerabilidad ni un flujo seguro.

El sitio usa sesión con inactividad de dos horas. Su middleware lee la clave de sesión `jwt`, la entrega a ApiCaller y la limpia al finalizar la solicitud mediante finally. Configura antiforgery con cabecera RequestVerificationToken; esto no demuestra que cada acción lo valide.

Mantener separados: autenticación del usuario, permisos por operación y pertenencia a empresa/sede. Un JWT válido no prueba autorización sobre cualquier recurso.

Fuentes: [Startup API](../../PsycoApp.api/Startup.cs), [Startup sitio](../../PsycoApp.site/Startup.cs), [UsuarioController](../../PsycoApp.api/Controllers/UsuarioController.cs), [ApiCaller](../../PsycoApp.utilities/ApiCaller.cs).

Relacionados: [Empresas y sedes](empresas-y-sedes.md), [MCP](mcp.md), [Preguntas abiertas](preguntas-abiertas.md).

## Propuesta: login Google — 2026-10-29

Estado: propuesta sin implementación. Skills.sh distribuye instrucciones para agentes, no un servicio de login para la aplicación. Google admite OpenID Connect y requiere cliente OAuth y retorno registrado. Flujo propuesto: validar identidad Google, asociar usuario interno y completar empresa/sede para nuevas altas SaaS; empleados mediante invitación o asociación autorizada. Conservar permisos y JWT internos. Identificar la cuenta por emisor y sub verificados, sin vinculación automática solo por correo. Alcance: identidad, sin acceso al buzón Gmail. Faltan decisiones de vinculación y configuración OAuth para pruebas.

Fuentes: [Skills.sh](https://www.skills.sh/), [Google OpenID Connect](https://developers.google.com/identity/openid-connect/openid-connect).

## Implementación Google — 2026-10-29
La propuesta anterior fue implementada. Ver [Acceso con Google](login-google.md). Está desactivada hasta configurar Client ID; el flujo real queda pendiente.

Actualización 2026-10-29: Client ID recibido y configurado en sitio/API; Google habilitado en archivos. Pendiente prueba interactiva tras reiniciar. Ver [estado actual](login-google.md).
