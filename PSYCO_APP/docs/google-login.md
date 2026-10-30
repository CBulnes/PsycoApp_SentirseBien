# Activar el acceso con Google

Google Identity Services: popup y callback JavaScript, con verificación criptográfica en la API. No usa Client Secret ni permisos del buzón Gmail. El login actual sigue disponible.

## Obtener el Client ID

1. En [Google Cloud Console](https://console.cloud.google.com/), crea o selecciona un proyecto.
2. En Google Auth Platform configura la marca y audiencia de la aplicación; para un SaaS público, usa audiencia externa y completa los datos que solicite Google.
3. Crea un cliente OAuth de tipo **Aplicación web**.
4. En **Orígenes autorizados de JavaScript**, añade `https://localhost:44384`: esquema, host y puerto exactos del sitio, sin `/Login`. Añade por separado el dominio HTTPS real cuando despliegues.
5. Si la configuración de pruebas de Google exige usuarios de prueba, añade las cuentas que utilizarás.
6. Copia el Client ID público, con terminación `.apps.googleusercontent.com`.

Esta implementación usa popup y callback JavaScript; no requiere `/signin-google` ni la URL de retorno de un middleware OAuth ASP.NET. No coloques un Client Secret en JavaScript ni en el chat.

## Preparar SQL y configurar ambos proyectos

Aplicar [Patch_google_identity.sql](../PsycoApp.DA/SQLScripts/Patch_google_identity.sql) en la base del entorno correspondiente:

```powershell
sqlcmd -S . -E -d PsycoApp -b -i PsycoApp.DA/SQLScripts/Patch_google_identity.sql
```

El script crea solo la tabla de asociación y sus restricciones; no cambia cuentas existentes. El alta utiliza las tablas existentes de empresas, sedes, usuarios y `tbl_empresa_acceso`, además de `fn_EncriptarPassword`.

En [configuración del sitio](../PsycoApp.site/appsettings.Google.json) y [configuración API](../PsycoApp.api/appsettings.Google.json), usa el **mismo Client ID**:

```json
{
  "Authentication": {
    "Google": {
      "Enabled": true,
      "ClientId": "TU_CLIENT_ID.apps.googleusercontent.com"
    }
  }
}
```

También se admiten `Authentication__Google__Enabled` y `Authentication__Google__ClientId` como variables de entorno, con prioridad sobre el archivo. Compila y reinicia sitio y API: las instancias IIS Express ya abiertas no incorporan automáticamente el código nuevo. Si hay binarios bloqueados, detén la depuración en Visual Studio antes de recompilar.

Sin configuración, Google aparece como próximamente disponible y la API responde 503. No se pide una identidad a Google en ese estado.

## Probar el flujo real

- **Nuevo titular:** pulsa «Continuar con Google» en Login o registro SaaS. Completa empresa, sede y nombre del administrador. Se crea una organización nueva y se abre la sesión.
- **Cuenta existente:** entra con tu usuario habitual, abre **Vincular Google** en el menú y confirma tu cuenta Google. Cierra sesión y prueba el botón Google. Conserva empresa, sede y rol.
- Esta versión admite una cuenta Google por usuario interno y un usuario interno por cuenta Google; no incluye varias membresías ni desvinculación. El tipo 20 (administrador global) queda fuera de este flujo.
- Una cuenta deshabilitada, empresa/sede inactiva o acceso SaaS suspendido/vencido impiden iniciar sesión. Se usa `sub` como identidad, sin vinculación automática por correo.

## Reproducir pruebas

Desde la raíz:

```powershell
dotnet build PsycoApp.site/PsycoApp.site.csproj -m:1 -v quiet -p:BaseOutputPath=bin/Functional/
dotnet build PsycoApp.api/PsycoApp.api.csproj -m:1 -v quiet -p:BaseOutputPath=bin/Functional/
dotnet run --project tests/GoogleAccess.SecurityTests/GoogleAccess.SecurityTests.csproj -p:BaseOutputPath=bin/Functional/ -p:BuildInParallel=false
& ./tests/functional/run.ps1
& ./tests/functional/run.ps1 -GoogleEnabled
```

Para persistencia aislada, añade `-- --sql` al comando de pruebas criptográficas. Crea y elimina una base `PsycoGoogleTests_<guid>` con datos sintéticos; requiere permisos locales para esas operaciones. No usa la conexión de la aplicación.

Las pruebas criptográficas inyectan claves y metadatos sintéticos exclusivamente en su proceso. El servidor confía solo en metadatos HTTPS oficiales de Google. Las pruebas HTTP no autentican una cuenta Google real: falta esa comprobación cuando exista un Client ID válido.

Fuentes: [configuración Google](https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid), [botón oficial](https://developers.google.com/identity/gsi/web/guides/display-button), [validación de identidad](https://developers.google.com/identity/gsi/web/guides/verify-google-id-token).
