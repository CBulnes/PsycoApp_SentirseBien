# Datos y persistencia

Fecha: 2026-10-29. Evidencia: inventario CREATE TABLE del esquema y llamadas DA; relaciones detalladas aún pendientes.

DA utiliza Microsoft.Data.SqlClient y procedimientos almacenados en los archivos de citas y caja revisados. Parte de las reglas puede estar en SQL; revisar solo BL es insuficiente.

| Dominio | Tablas encontradas en SQL/SchemaSQL.sql |
|---|---|
| Organización | tbl_empresa, tbl_sede, tbl_sede_usuario |
| Identidad | tbl_usuario, tbl_tipousuario, tbl_menu, tbl_opciones_usuario, token |
| Profesionales | tbl_psicologo, tbl_estudios_psicologo, tbl_horarios_psicologo, tbl_vacaciones_psicologo |
| Atención | tbl_paciente, tbl_cita, tbl_estados_cita, tbl_historial_cita, tbl_historial_paciente |
| Oferta | Productos, tbl_paquete |
| Cobros | tbl_caja, tbl_pago, tbl_forma_pago, tbl_detalle_transferencia, tbl_efectivo_diario, pagos_old |
| Otros | tbl_encuesta, tbl_flujos, tbl_visitas, tbl_tickets, tbl_configuracion |

Este mapa no es un diagrama de claves foráneas. Los identificadores sugieren relaciones, pero cada FK y cardinalidad debe comprobarse antes de afirmarla. El nombre pagos_old sugiere legado; no acredita que esté en desuso.

El texto aportado describe scripts históricos y parches en otras carpetas. No se ha determinado un orden canónico de aplicación ni equivalencia entre el esquema versionado y la base desplegada. Nunca ejecutar parches solo porque aparezcan citados aquí.

Fuentes: [SchemaSQL.sql](../../SQL/SchemaSQL.sql), [CitaDA](../../PsycoApp.DA/CitaDA.cs), [CajaDA](../../PsycoApp.DA/CajaDA.cs), [descripción aportada](../raw/descripcion-proyecto.txt).

Relacionados: [Arquitectura](arquitectura.md), [Citas](citas.md), [Caja](caja.md), [Preguntas abiertas](preguntas-abiertas.md).
