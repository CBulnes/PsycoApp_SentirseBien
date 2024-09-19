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
        public const string sp_listar_doctores = "SP_LISTAR_DOCTORES";



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
        public const string sp_registrar_cita = "SP_REGISTRAR_CITA";
        public const string sp_registrar_cuestionario = "SP_REGISTRAR_CUESTIONARIO";
        public const string sp_listar_disponibilidad_doctor = "SP_LISTAR_DISPONIBILIDAD_DOCTOR";
        public const string sp_listar_citas_usuario = "SP_LISTAR_CITAS_USUARIO";
        public const string sp_listar_citas_doctor = "SP_LISTAR_CITAS_DOCTOR";

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

    }
}
