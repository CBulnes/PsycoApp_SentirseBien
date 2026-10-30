# Mapa de módulos

Fecha: 2026-10-29. Evidencia: archivos y métodos observados; cobertura funcional completa pendiente.

| Área | Responsabilidad identificada | Entrada al código |
|---|---|---|
| Pacientes | Datos e historial | [PacienteBL](../../PsycoApp.BL/PacienteBL.cs) |
| Psicólogos | Profesionales, con áreas de horarios y vacaciones descritas en el esquema | [PsicologoBL](../../PsycoApp.BL/PsicologoBL.cs) |
| Citas | Agenda, confirmación, atención, cancelación, paquetes | [CitaBL](../../PsycoApp.BL/CitaBL.cs) · [nota](citas.md) |
| Caja | Pagos, descuentos, efectivo y cuadre | [CajaBL](../../PsycoApp.BL/CajaBL.cs) · [nota](caja.md) |
| Productos | Catálogo de productos | [ProductoBL](../../PsycoApp.BL/ProductoBL.cs) |
| Empresas y sedes | Organización y registro SaaS | [EmpresaSedeBL](../../PsycoApp.BL/EmpresaSedeBL.cs) · [nota](empresas-y-sedes.md) |
| Usuarios y menú | Acceso y opciones | [UsuarioBL](../../PsycoApp.BL/UsuarioBL.cs) · [MenuBL](../../PsycoApp.BL/MenuBL.cs) |
| Reportes y paneles | Consultas de gestión | [ReporteBL](../../PsycoApp.BL/ReporteBL.cs) · [DashboardBL](../../PsycoApp.BL/DashboardBL.cs) |
| Flujos, encuestas y visitas | Otras operaciones de seguimiento | [FlujoBL](../../PsycoApp.BL/FlujoBL.cs) · [EncuestaBL](../../PsycoApp.BL/EncuestaBL.cs) · [VisitaBL](../../PsycoApp.BL/VisitaBL.cs) |
| Tickets | Controlador web identificado; alcance por investigar | [TicketController](../../PsycoApp.site/Controllers/TicketController.cs) |

Los nombres identifican áreas del producto. No equivalen a una aceptación funcional ni a un inventario exhaustivo de pantallas.

Fuentes adicionales: [texto descriptivo original](../raw/descripcion-proyecto.txt).

Relacionados: [Visión](vision.md), [Datos](datos.md), [Guía de cambios](guia-de-cambios.md).
