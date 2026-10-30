# Correo de bienvenida
El alta Google intenta enviar una bienvenida al correo verificado después de confirmar el registro SQL. Login y vinculación no envían bienvenida. El registro tradicional no dispone de un campo de correo y queda fuera de este envío.

La cuenta se conserva si SMTP falla. El envío tiene un límite de 10 segundos, sin reintentos ni cola persistente; un fallo requiere atención manual. Los logs omiten destinatario, contenido y credenciales. No se acredita entrega hasta probar con el proveedor real.

## Gmail personal para pruebas
Activa verificación en dos pasos y crea una contraseña de aplicación si tu cuenta ofrece esa opción. No utilices la contraseña habitual ni el secreto OAuth del login Google.

Configura estas claves en la API mediante variables de entorno o el administrador de secretos de usuario de Visual Studio (clic derecho en el proyecto API, Administrar secretos de usuario):
- Email:Enabled = true
- Email:Host = smtp.gmail.com
- Email:Port = 587
- Email:From = tu dirección Gmail
- Email:Username = la misma dirección Gmail
- Email:Password = contraseña de aplicación

En variables de entorno reemplaza los dos puntos por doble guion bajo, por ejemplo Email__Password. No guardes credenciales en archivos versionados ni en el chat. Reinicia la API después de configurar.

Hasta entonces el envío queda desactivado por defecto. Para probarlo, registra una cuenta Google nueva y revisa su bandeja y spam. Una cuenta existente no vuelve a recibir bienvenida al iniciar sesión.

Fuentes: [contraseñas de aplicación Google](https://support.google.com/accounts/answer/185833), [SMTP Gmail](https://developers.google.com/workspace/gmail/imap/imap-smtp), [envío asíncrono .NET](https://learn.microsoft.com/en-us/dotnet/api/system.net.mail.smtpclient.sendmailasync?view=net-10.0).
