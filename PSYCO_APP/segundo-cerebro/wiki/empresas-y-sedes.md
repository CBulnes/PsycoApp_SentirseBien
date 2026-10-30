# Empresas y sedes

Fecha: 2026-10-29. Evidencia: lectura de EmpresaSedeBL; estructura SQL y controladores.

EmpresaSedeBL permite listar y crear empresas y sedes, comprobar empresa activa y pertenencia de una sede a una empresa activa, crear usuarios y registrar empresas de prueba.

Reglas comprobadas en BL:

- Crear empresa requiere nombre no vacío y lo recorta.
- Crear sede requiere nombre e IdEmpresa positivo; activa la sede y usa su nombre como Centro si Centro viene vacío.
- Crear usuario exige nombres, apellidos, usuario y contraseña, tipos 1 o 3 y empresa/sede positivas. Esto no sustituye verificar pertenencia real en las capas siguientes.
- RegistrarEmpresaPrueba exige empresa, sede y administrador; normaliza el usuario a mayúsculas y exige que contenga solo letras. Aplica límites de longitud.

El sitio incluye SaaSController y Administración/EmpresasController. El esquema contiene tbl_empresa y tbl_sede. El soporte de varias empresas no demuestra que todas las consultas estén aisladas entre empresas.

Fuentes: [EmpresaSedeBL](../../PsycoApp.BL/EmpresaSedeBL.cs), [EmpresaSedeDA](../../PsycoApp.DA/EmpresaSedeDA.cs), [SaaSController](../../PsycoApp.site/Controllers/SaaSController.cs), [EmpresasController](../../PsycoApp.site/Controllers/Administracion/EmpresasController.cs), [esquema](../../SQL/SchemaSQL.sql).

Relacionados: [Acceso](acceso.md), [Citas](citas.md), [Preguntas abiertas](preguntas-abiertas.md).

## Investigación de altas por sede — 2026-10-29

Ver [hallazgos y pendientes](altas-por-empresa.md): consulta local de solo lectura, paciente no presente en la sede indicada, un especialista existente vinculado y un vínculo huérfano. La validación de documento del paciente es global; no se confirmó que explique el incidente.
