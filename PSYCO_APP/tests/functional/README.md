# Pruebas funcionales HTTP

Requisitos: Windows, Windows PowerShell 5.1 y SDK .NET 10 con dependencias ya restauradas. Ejecutar desde la raíz del repositorio:

```powershell
dotnet build PsycoApp.site/PsycoApp.site.csproj --no-restore -m:1 -v quiet -p:BaseOutputPath=bin/Functional/
dotnet build PsycoApp.api/PsycoApp.api.csproj --no-restore -m:1 -v quiet -p:BaseOutputPath=bin/Functional/
& ./tests/functional/run.ps1
```

Continuar con las pruebas solo si ambas compilaciones terminan correctamente. Si faltan paquetes, restaurar dependencias antes de compilar. La suite no restaura ni compila automáticamente. Sale con código 1 ante fallos y guarda resultados locales en `.functional-artifacts/results.json`.

El ejecutor usa configuración sintética y una conexión SQL no disponible. Comprueba pantallas públicas renderizadas, recursos estáticos, validación de formularios, antiforgery, acceso HTTP y fallo controlado de dependencia. No requiere una cuenta, no crea datos ni utiliza la configuración de base del proyecto. No es una suite de navegador ni prueba el ciclo completo con persistencia.

Se crean procesos temporales en localhost y se cierran al terminar mediante finally. Las vistas y logs sintéticos quedan en .functional-artifacts para diagnóstico. No incluir configuraciones reales ni credenciales en esa carpeta.

El login autenticado descrito en el informe fue una comprobación adicional manual por HTTP, no forma parte de esta suite reproducible. No se guardaron sus credenciales.

[Informe y límites](../../segundo-cerebro/wiki/pruebas-funcionales.md).

## Google
Ejecutar también con `-GoogleEnabled` para validar la configuración sintética habilitada (30 casos; 28 desactivada). Pruebas criptográficas y SQL reproducibles en [guía Google](../../docs/google-login.md). No se prueba el consentimiento real de Google.
