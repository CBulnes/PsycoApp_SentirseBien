# Visión del sistema

Fecha: 2026-10-29. Evidencia: verificado en estructura y métodos; recorrido inferido.

PSYCO_APP administra centros de atención psicológica. El código contempla pacientes, profesionales, agenda, atenciones, caja y organización por empresas y sedes.

El recorrido de negocio inferido es: registrar paciente → consultar profesional y horario → registrar cita o sesiones de paquete → confirmar y atender → registrar cobro → consultar historial y reportes. No es una máquina de estados verificada ni un orden obligatorio: falta contrastar reglas y operación real.

Los perfiles funcionales sugeridos son administración, recepción/counter y profesionales. EmpresaSedeBL permite crear usuarios de tipos 1 y 3, nombrados Administrador y Counter en su mensaje de validación; esto no enumera todos los roles del sistema.

Existen un sitio MVC para usuarios, una API HTTP y dos hosts MCP. La presencia de registro SaaS indica una capacidad de alta de empresas; no demuestra facturación de suscripciones ni aislamiento completo entre clientes.

Fuentes: [EmpresaSedeBL](../../PsycoApp.BL/EmpresaSedeBL.cs), [CitaBL](../../PsycoApp.BL/CitaBL.cs), [CajaBL](../../PsycoApp.BL/CajaBL.cs), [catálogo de fuentes](fuentes.md).

Relacionados: [Módulos](modulos.md), [Arquitectura](arquitectura.md), [Preguntas abiertas](preguntas-abiertas.md).
