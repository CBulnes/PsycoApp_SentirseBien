# Acceso con Google

Fecha: 2026-10-29. **Verificado en código y pruebas locales**; autenticación con Google real **pendiente** de prueba interactiva.

Se implementó Google Identity Services con validación de firma RS256, emisor, audiencia, vencimiento e identidad verificada en la API. El sitio correlaciona un nonce de un solo uso y exige antiforgery. La identidad estable es sub; no se asocian cuentas automáticamente por correo.

El registro nuevo crea empresa, sede, administrador y acceso de prueba en una transacción. La vinculación existente exige sesión autenticada y conserva empresa, sede y rol. Admite roles 1, 3 y 4; una identidad por usuario. No incluye desvinculación ni múltiples membresías.

La tabla de asociación se creó en la base local; quedó sin vinculaciones. Google está habilitado en los archivos de configuración del sitio y API con el mismo Client ID público aportado por el usuario. No se almacenó el secreto del cliente. Las instancias abiertas necesitan recompilarse y reiniciarse.

Validación: compilaciones sitio/API sin errores ni advertencias; 16 comprobaciones criptográficas y 16 de persistencia en base desechable aprobadas. HTTP: 28 casos con función desactivada y 30 habilitada con configuración sintética aprobados. No son pruebas de navegador ni acreditan el popup real de Google.

Fuentes: [guía y configuración](../../docs/google-login.md), [validador](../../PsycoApp.api/Security/GoogleIdentityValidator.cs), [API](../../PsycoApp.api/Controllers/GoogleController.cs), [sitio](../../PsycoApp.site/Controllers/GoogleController.cs), [persistencia](../../PsycoApp.DA/GoogleIdentityDA.cs), [migración](../../PsycoApp.DA/SQLScripts/Patch_google_identity.sql), [pruebas](../../tests/GoogleAccess.SecurityTests/Program.cs).

Relacionados: [Índice](index.md), [Acceso](acceso.md), [Empresas y sedes](empresas-y-sedes.md), [Pruebas funcionales](pruebas-funcionales.md).

## Correo verificado — 2026-10-29
El alta guarda el claim email validado en tbl_usuario.email; login conserva el identificador interno. Login Google actualiza el correo de una cuenta vinculada y permite completar cuentas anteriores al volver a ingresar. La vinculación también guarda el correo dentro de su transacción. No se asocian usuarios por coincidencia de correo. Se rechazan correos ausentes, inválidos o mayores a 100 caracteres (límite del esquema actual).

## Acceso desde portada — 2026-10-29
La [portada SaaS](../../PsycoApp.site/Views/SaaS/Index.cshtml) incluye el [componente Google](../../PsycoApp.site/Views/Shared/_GoogleAccess.cshtml) debajo del botón Crear mi espacio de prueba, centrado y separado por «o». Reutiliza el flujo de login/registro y antiforgery existentes; conserva Ingresar en la cabecera.

## Bienvenida por correo — 2026-10-29
Después del alta Google confirmada se intenta enviar bienvenida al correo verificado mediante [WelcomeEmail](../../PsycoApp.api/Services/WelcomeEmail.cs). Desactivado por defecto hasta configurar remitente y SMTP. Fallos no anulan el registro; límite de 10 segundos, sin cola ni reintentos. Login y vinculación no envían. Registro tradicional fuera de alcance por no tener correo. Ver [configuración](../../docs/correo-bienvenida.md).
