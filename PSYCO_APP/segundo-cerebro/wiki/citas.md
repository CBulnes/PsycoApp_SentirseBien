# Citas y atención

Fecha: 2026-10-29. Evidencia: lectura de CitaBL y atributos de rutas de CitaController.

CitaBL ofrece registro, confirmación, atención y cancelación; consultas de disponibilidad, citas por usuario/profesional/paquete e historiales; actualización de servicio, cuestionario e informe.

## Registro observado

`registrar_cita` reúne errores de validación antes de persistir. Cuando hay fechas adicionales, recorre sesiones y utiliza DA para validarlas; registra la cita inicial y después las adicionales usando el identificador de paquete. El método modifica fecha, hora y profesional del objeto recibido durante los recorridos. La regla exacta de solapamientos reside en DA/SQL y no se ha documentado por completo.

No se ha demostrado atomicidad del registro completo de un paquete ni protección frente a reservas concurrentes. No inventar estados numéricos a partir de los nombres de acciones.

## Puntos de entrada HTTP observados

- POST `api/Cita/registrar_cita`
- POST `api/Cita/actualizar_citas_paquete`
- POST `api/Cita/confirmar_cita`
- POST `api/Cita/atender_cita`
- POST `api/Cita/cancelar_cita`
- GET `api/Cita/disponibilidad_doctor/{id_doctor}/{fecha}/{servicio}`

Este listado es parcial y no describe cuerpos ni respuestas completas. CitaBL también expone comprobaciones de pertenencia a sede para cita, paquete, paciente y doctor; su existencia no prueba que todas las operaciones las apliquen.

Fuentes: [CitaController](../../PsycoApp.api/Controllers/CitaController.cs), [CitaBL](../../PsycoApp.BL/CitaBL.cs), [CitaDA](../../PsycoApp.DA/CitaDA.cs).

Relacionados: [Caja](caja.md), [Empresas y sedes](empresas-y-sedes.md), [Datos](datos.md), [Preguntas abiertas](preguntas-abiertas.md).
