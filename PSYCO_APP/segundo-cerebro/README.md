# Segundo cerebro de PSYCO_APP

Base de conocimiento persistente del proyecto. Fecha de revisión inicial: 2026-10-29 (America/Lima).

Empieza por [el índice](wiki/index.md). Para entender el producto, lee [visión](wiki/vision.md); para modificarlo, [arquitectura](wiki/arquitectura.md) y [guía de cambios](wiki/guia-de-cambios.md).

## Cómo usarlo

Abre esta carpeta como bóveda en Obsidian, o navega por los enlaces Markdown desde tu editor. No requiere plugins, cuenta ni base de datos adicional.

Puedes pedir al agente:

- «Consulta segundo-cerebro/wiki/index.md y explícame cómo se registra una cita, citando las fuentes».
- «Ingiere este documento en segundo-cerebro: conserva el original, actualiza las páginas relacionadas y registra contradicciones».
- «Actualicé CajaController y CajaDA; reconcilia la wiki con esos cambios».
- «Revisa enlaces, afirmaciones desactualizadas y preguntas abiertas del segundo cerebro».
- «Guarda esta respuesta como una nueva nota y enlázala desde el índice».

## Las tres capas

- `raw/`: copias de las fuentes aportadas por el usuario; se conservan sin edición. El código sigue en el repositorio, no se duplica.
- `wiki/`: conocimiento sintetizado, conexiones, evidencia y preguntas pendientes.
- [AGENTS.md](AGENTS.md): instrucciones de mantenimiento para agentes que trabajen dentro de esta carpeta.

El agente debe mantener las notas como parte del trabajo en el proyecto: al completar cambios relevantes o investigaciones con hallazgos duraderos, actualizará páginas, conexiones y bitácora sin una petición adicional. La regla está en [AGENTS.md del proyecto](../AGENTS.md). Obsidian refleja los archivos actualizados. No hay monitor en segundo plano ni detección automática de cambios externos. La revisión inicial fue estática: no acredita compilación, pruebas, despliegue ni estado de la base real.
