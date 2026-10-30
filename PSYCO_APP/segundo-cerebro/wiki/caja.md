# Caja y pagos

Fecha: 2026-10-29. Evidencia: métodos BL, rutas API y uso de procedimientos en DA.

El módulo contempla registrar pagos individuales y masivos, deshacer pagos, descuentos, efectivo diario, pagos pendientes, listados y resúmenes de cuadre por usuario y forma de pago, apertura y cierre.

Rutas POST observadas bajo `api/Caja`: `registrar_pago`, `registrar_pago_masivo`, `deshacer_pago`, `registrar_descuento`, `registrar_efectivo`, `aperturar_caja`, `cerrar_caja`.

En BL, `registrar_pago` delega en `CajaDA.registrar_caja`. El registro masivo recorre `pagosEnviar`, construye cada Pago y guarda el resultado de cada llamada en la misma variable, que devuelve al terminar. Esto justifica investigar resultados parciales y tratamiento de fallos por elemento. No demuestra por sí solo qué transacciones existen en SQL.

`DeshacerPago`, `aperturar_caja` y `cerrar_caja` delegan en métodos asíncronos de DA. DA utiliza SqlConnection y procedimientos almacenados.

La carpeta `PsycoApp.Caja.IntegrationTests` se encontró vacía en esta revisión. No se verificó una suite de pruebas de caja ni se ejecutaron cobros.

Fuentes: [CajaController](../../PsycoApp.api/Controllers/CajaController.cs), [CajaBL](../../PsycoApp.BL/CajaBL.cs), [CajaDA](../../PsycoApp.DA/CajaDA.cs).

Relacionados: [Citas](citas.md), [Datos](datos.md), [Preguntas abiertas](preguntas-abiertas.md).
