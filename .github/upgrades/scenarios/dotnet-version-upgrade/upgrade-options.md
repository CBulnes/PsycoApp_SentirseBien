# Upgrade Options — PsycoApp.api y PsycoApp.site

Assessment: 2 aplicaciones seleccionadas, ambas en `netcoreapp3.1`, con 4 bibliotecas compartidas analizadas como dependencias y excluidas del alcance de cambios; hay incompatibilidades de API, actualizaciones recomendadas, obsolescencias y vulnerabilidades en los paquetes.

## Strategy

### Upgrade Strategy
La evaluación cubre dos aplicaciones seleccionadas y sus dependencias; la estrategia se limita a actualizar ambas aplicaciones conjuntamente.

| Value | Description |
|-------|-------------|
| **All-at-Once** (selected) | Actualizar todos los proyectos en una única pasada; la solución podría no compilar temporalmente hasta completar los cambios. |
| Top-Down | Actualizar primero las aplicaciones y multi-targetear temporalmente las bibliotecas compartidas para mantenerlas compilables; consolidar las bibliotecas después. |

## Compatibility

### Unsupported API Handling
La evaluación señala incompatibilidades binarias y de origen en las dos aplicaciones seleccionadas; la mayor parte de los 2.870 cambios de origen aparece en `PsycoApp.DA`, fuera del alcance.

| Value | Description |
|-------|-------------|
| **Fix Inline** (selected) | Resolver todos los cambios de API en las tareas de actualización, incluidos los complejos. |
| Defer Complex Changes | Aplicar cambios simples y dejar stubs compilables para las migraciones complejas, que se resolverán en tareas posteriores. |
