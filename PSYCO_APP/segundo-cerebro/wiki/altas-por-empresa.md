# Investigación de altas por empresa y sede

Fecha: 2026-10-29. Evidencia: lectura de controladores, DA y consultas SELECT de definiciones y conteos en la base local. No se modificaron registros.

## Incidente informado

El usuario informó que, tras crear una empresa, uno de los registros de paciente o especialista no apareció dentro de ella. No recordó cuál ni el mensaje recibido. Facilitó identificadores organizativos para localizarla; no se guardaron datos personales ni material de credenciales en esta nota.

## Hallazgos verificados

En la empresa y sede indicadas, ambas activas, el usuario administrador está asignado a esa sede. El conteo actual muestra cero pacientes. Hay vínculos a dos identificadores distintos de especialista, pero solo uno corresponde a un registro existente en tbl_psicologo: existe al menos un vínculo huérfano. Además hay tres especialistas sin ningún vínculo en el conjunto de la base; no se ha establecido que correspondan al incidente.

La definición real de sp_agregar_paciente rechaza DocumentoNumero si existe en cualquier sede o empresa. La inserción usa id_sede; el sitio toma la sede de sesión y la API resuelve la autorizada. Los listados de pacientes se filtran por sede. Por tanto, reutilizar un documento ya existente en otra empresa explica un rechazo posible, pero no se confirmó el documento del intento ni la respuesta del alta. No se cambió esta regla sin definir si la identidad de paciente debe ser global, por empresa o por sede.

Los especialistas se asocian mediante tbl_sede_usuario. Su procedimiento local de alta inserta varias tablas sin transacción explícita dentro del procedimiento y usa @@IDENTITY. Existe riesgo de datos parciales si una sentencia posterior falla, salvo una transacción externa; no se reprodujo un fallo ni se atribuyó el vínculo huérfano a esa causa.

## Pendiente

Confirmar si se reutilizó el documento de un paciente existente y qué respuesta se recibió. Identificar el registro concreto mediante un canal local que evite copiar datos clínicos al chat o documentación. Comprobar el listado del especialista existente en la sede y su sede principal, y explicar el origen de los vínculos huérfanos antes de reparar datos. No borrar ni reasignar registros por inferencia.

Las pruebas HTTP iniciales no cubrían altas con persistencia y no descartan este incidente.

Fuentes: [Paciente sitio](../../PsycoApp.site/Controllers/Mantenimiento/PacienteController.cs), [Paciente API](../../PsycoApp.api/Controllers/PacienteController.cs), [Paciente DA](../../PsycoApp.DA/PacienteDA.cs), [Psicologo DA](../../PsycoApp.DA/PsicologoDA.cs), [esquema versionado](../../SQL/SchemaSQL.sql). Las definiciones locales se contrastaron mediante sys.sql_modules; los conteos no constituyen una copia de datos personales.

Relacionados: [Empresas y sedes](empresas-y-sedes.md), [Preguntas abiertas](preguntas-abiertas.md), [Pruebas funcionales](pruebas-funcionales.md).

## Prueba de altas autorizada — 2026-10-29

Se crearon por HTTP, con autorización expresa, un paciente y un especialista enteramente ficticios en empresa 1004, sede 2003. Ambos devolvieron HTTP 200 y mensaje de guardado, aparecieron en los listados y se verificó la asociación mediante SELECT.

- Paciente ficticio QA PACIENTE SGO / PRUEBA CODEX: ID 75065, sede 2003, empresa 1004.
- Especialista ficticio QA ESPECIALISTA SGO / PRUEBA CODEX: ID 8003, vínculo principal a sede 2003, empresa 1004. Se creó además un vínculo inválido con sede 0.

El formulario envía IdSedeTerciaria, pero el modelo Psicologo del sitio no declara esa propiedad. La entidad API usa 0 por defecto y SQL inserta el vínculo opcional cuando es distinto de -1. Esta cadena explica el vínculo 0 observado; queda pendiente corregirla. No se modificó código ni se limpiaron asociaciones.

Un primer intento de prueba omitió Id y fue rechazado sin insertar; al enviar Id=0, como el formulario, ambas altas funcionaron. Esto no prueba la causa del incidente anterior. Los registros QA permanecen para revisión. No se crearon citas ni pagos; el alta de especialista crea automáticamente su usuario y horarios en SQL. Las cookies temporales se eliminaron.

### Corrección posterior de acceso — 2026-10-29

El usuario corrigió las credenciales del administrador después de las altas. Se verificó una sola vez la nueva combinación en sgo/san borja: el login devolvió estado falso. No se crearon más registros ni se repitieron intentos. Las altas anteriores sí habían sido aceptadas con las credenciales previamente confirmadas; no se modificó la contraseña. No se guardan contraseñas en la wiki. Queda pendiente que el usuario compruebe el acceso actual desde el navegador.
