# Mantenimiento del segundo cerebro

Alcance: esta carpeta. Idioma: español. Lee primero `wiki/index.md`, `wiki/fuentes.md` y las entradas recientes de `wiki/log.md`.

## Evidencia

Distingue explícitamente: **Verificado en código**, **Fuente aportada**, **Inferencia** y **Pendiente**. Una clase o método existente no demuestra que funcione en producción. No inventes roles, estados, reglas, decisiones históricas ni resultados de pruebas. Cita archivos mediante enlaces Markdown relativos. Antes de afirmar una regla detallada, lee su implementación completa y el procedimiento SQL correspondiente.

No copies contraseñas, tokens, cadenas de conexión, datos personales ni información clínica. Las fuentes raw iniciales son textos descriptivos revisados; ante nuevas fuentes con datos sensibles, conserva una versión redactada identificada como tal y no incorpores el original sensible a esta carpeta.

## Ingesta

1. Identifica fuente, fecha, alcance y si sustituye conocimiento previo.
2. Conserva una copia de fuentes documentales seguras en raw, sin alterarla después. El código es una fuente viva externa a raw; registra archivos y fecha de revisión.
3. Lee y resume. Actualiza todas las páginas afectadas, enlaces y registro de fuentes.
4. Si hay conflicto, registra las dos versiones y evidencia en preguntas-abiertas; no resuelvas por intuición.
5. Actualiza index y añade una entrada al final de log con fecha local, tipo, páginas afectadas y verificaciones.

## Consulta

Busca primero en el índice; lee las páginas relevantes y cita fuentes. Si la respuesta depende del estado actual, contrasta el código. Guarda síntesis nuevas útiles como páginas enlazadas, distinguiendo propuesta de decisión aprobada. No conviertas una respuesta del agente en evidencia independiente del código.

## Revisión

Comprueba enlaces internos y a código, páginas sin enlaces entrantes, cobertura del índice, contradicciones, hechos caducos y preguntas resueltas. Registra alcance y resultado en log. No sobreescribas entradas históricas del log: añade correcciones posteriores.

## Convenciones

Usa nombres de archivo en minúsculas con guiones. Cada página temática debe contener título, estado de evidencia, fecha, fuentes y enlaces relacionados. Mantén el catálogo del índice completo. No modifiques código ni ejecutes scripts SQL por mantener documentación. No agregues dependencias ni automatizaciones sin necesidad.
