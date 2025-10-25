using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL.Interfaces
{
    public interface IPsicologoBL
    {
        List<Psicologo> ListarPsicologos(int pagina, int tamanoPagina);
        void AgregarPsicologo(Psicologo psicologo);
        List<Psicologo> BuscarPsicologo(string nombre);
        Psicologo BuscarPsicologoId(int id);
        void ActualizarPsicologo(Psicologo psicologo);
        void EliminarPsicologo(int id);
        List<entities.Psicologo> listar_psicologos_combo();
        List<entities.Usuario> listar_usuarios_caja_combo();
        List<entities.Sede> listar_sedes_x_usuario_combo(int id_usuario);
        List<entities.Sede> listar_sedes_combo();
        List<entities.Horario> horarios_psicologo(int id_psicologo, string inicio, string fin, string dias);
        List<entities.Horario> vacaciones_psicologo(int id_psicologo, string inicio, string fin, int año);
        RespuestaUsuario guardar_horarios_psicologo(List<entities.Horario> lista);
        RespuestaUsuario guardar_vacaciones_psicologo(List<entities.Horario> lista);

        #region "version react"
        Task<Respuesta<DataPsicologos>> GetList(ListPsicologosDto request);
        #endregion
    }
}