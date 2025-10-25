using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL.Interfaces
{
    public interface IHistorialBL
    {
        RespuestaUsuario registrar_historial(HistorialPaciente oHistorial);
        RespuestaUsuario registrar_estado_cuestionario(HistorialPaciente oHistorial);
        List<HistorialPaciente> listar_historial(int id_usuario);

        #region "version react"
        Task<Respuesta<DataCitas>> HistorialCitas(ListHistorialCitasDto request);
        #endregion
    }
}