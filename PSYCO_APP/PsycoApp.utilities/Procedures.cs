using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.utilities
{
    public class Procedures
    {
        public const string sp_validar_usuario = "SP_VALIDAR_USUARIO";
        public const string sp_actualizar_contraseña = "SP_ACTUALIZAR_CONTRASEÑA";
        public const string sp_listar_psicologos_combo = "SP_LISTAR_PSICOLOGOS_COMBO";
        public const string sp_listar_pacientes_combo = "SP_LISTAR_PACIENTES_COMBO";
        public const string sp_listar_pacientes_combo_dinamico = "SP_LISTAR_PACIENTES_COMBO_DINAMICO";
        
        public const string sp_listar_productos_combo = "SP_LISTAR_PRODUCTOS_COMBO";



        public const string sp_registrar_visita = "SP_REGISTRAR_VISITA";
        public const string sp_listar_menu = "SP_LISTAR_MENU";
        public const string sp_listar_centros_atencion = "SP_LISTAR_CENTROS_ATENCION";

        public const string sp_registrar_punto_visitado = "SP_REGISTRAR_PUNTO_VISITADO";

        public const string sp_puntos_visitados = "SP_PUNTOS_VISITADOS";
        public const string sp_visitas = "SP_VISITAS";

        public const string sp_registrar_ticket = "SP_REGISTRAR_TICKET";
        public const string sp_generar_ticket = "SP_GENERAR_TICKET";

        public const string sp_validar_flujo_actual = "SP_VALIDAR_FLUJO_ACTUAL";
        public const string sp_registrar_flujo = "SP_REGISTRAR_FLUJO";

        public const string sp_registrar_puntuacion = "SP_REGISTRAR_PUNTUACION";

        public const string sp_resultados_nps = "SP_RESULTADOS_NPS";

        public const string sp_registrar_usuario = "SP_REGISTRAR_USUARIO";
        public const string sp_registrar_invitado = "SP_REGISTRAR_INVITADO";

        public const string sp_listar_encuesta = "SP_LISTAR_ENCUESTAS";
        public const string sp_registrar_historial_paciente = "SP_REGISTRAR_HISTORIAL_PACIENTE";
        public const string sp_registrar_estado_cuestionario = "SP_REGISTRAR_ESTADO_CUESTIONARIO";
        public const string sp_listar_historial_paciente = "SP_LISTAR_HISTORIAL_PACIENTE";
        public const string sp_listar_historial_cita = "SP_LISTAR_HISTORIAL_CITA";
        public const string sp_validar_cita = "SP_VALIDAR_CITA";
        public const string sp_confirmar_cita = "SP_CONFIRMAR_CITA";
        public const string sp_atender_cita = "SP_ATENDER_CITA";
        public const string sp_cancelar_cita = "SP_CANCELAR_CITA";
        public const string sp_actualizar_servicio = "SP_ACTUALIZAR_SERVICIO_CITA";
        public const string sp_pago_gratis = "SP_CITA_PAGO_GRATIS";
        public const string sp_registrar_cuestionario = "SP_REGISTRAR_CUESTIONARIO";
        public const string sp_listar_disponibilidad_doctor = "SP_LISTAR_DISPONIBILIDAD_DOCTOR";
        public const string sp_listar_citas_usuario = "SP_LISTAR_CITAS_USUARIO";
        public const string sp_listar_citas_paquete = "SP_LISTAR_CITAS_PAQUETE";
        public const string sp_listar_citas_doctor = "SP_LISTAR_CITAS_DOCTOR";
        public const string sp_listar_dias_semana_mes = "SP_LISTAR_DIAS_X_SEMANA_MES";
        public const string sp_listar_horario_psicologo = "SP_LISTAR_HORARIO_PSICOLOGO";
        public const string sp_listar_vacaciones_psicologo = "SP_LISTAR_VACACIONES_PSICOLOGO";
        public const string sp_guardar_horario_psicologo = "SP_GUARDAR_HORARIO_PSICOLOGO";
        public const string sp_guardar_horario_psicologo_v2 = "SP_GUARDAR_HORARIO_PSICOLOGO_V2";
        public const string sp_guardar_vacaciones_psicologo = "SP_GUARDAR_VACACIONES_PSICOLOGO";

        #region "psicologos"
        public const string listar_sedes_x_usuario = "dbo.SP_LISTAR_SEDES_X_USUARIO";
        public const string listar_sedes_combo = "dbo.SP_LISTAR_SEDES_COMBO";
        #endregion

        #region "psicologos"
        public const string obtener_psicologo = "dbo.sp_obtener_psicologo";
        public const string buscar_psicologo = "dbo.sp_buscar_psicologo";
        public const string listar_psicologos = "dbo.sp_listar_psicologos";                         //posiblemente deprecado
        public const string listar_psicologos_paginado = "dbo.sp_listar_psicologos_paginado";
        public const string agregar_psicologo = "dbo.sp_agregar_psicologo";
        public const string actualizar_psicologo = "dbo.sp_actualizar_psicologo";
        public const string eliminar_psicologo = "dbo.sp_eliminar_psicologo";

        public const string listar_estudios_psicologo = "dbo.sp_listar_estudios_psicologo";
        #endregion

        #region "ubigeo"
        public const string listar_ubigeos = "dbo.sp_listar_ubigeos";
        #endregion

        #region "caja"

        public const string sp_registrar_pago = "SP_REGISTRAR_PAGO";
        public const string sp_registrar_efectivo = "SP_REGISTRAR_EFECTIVO";
        public const string sp_pagos_pendientes = "SP_LISTAR_PAGOS_PENDIENTES";
        public const string sp_lista_caja = "sp_ListarCaja";

        public const string sp_cuadre_caja = "SP_LISTAR_CUADRE_CAJA";
        public const string sp_resumen_caja_x_usuario = "SP_LISTAR_CAJA_MES_USUARIO_EFECTIVO";
        public const string sp_resumen_caja_x_forma_pago = "SP_LISTAR_CAJA_MES_FORMA_PAGO";
        public const string listar_efectivo_diario = "dbo.SP_LISTAR_EFECTIVO_DIARIO";
        #endregion
    }

    public class Endpoints
    {
        public static string apiUrl = Helper.GetUrlApi();

        public class Caja
        {
            public const string url_registrar_pago = "/caja/registrar_pago";
            public const string url_listar_pagos_pendientes = "/caja/listar_pagos_pendientes";
            public const string url_resumen_caja_x_usuario = "/caja/resumen_caja_x_usuario";
            public const string url_listar_efectivo_diario = "/caja/listar_efectivo_diario";
            public const string url_resumen_caja_x_forma_pago = "/caja/resumen_caja_x_forma_pago";
        }

        public class Paciente
        {
            public const string url_base = "/paciente";
        }
    }
}
