using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.BL
{
    public class HistorialBL : IHistorialBL
    {
        HistorialDA historialDA = new HistorialDA();

        public RespuestaUsuario registrar_historial(HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = historialDA.registrar_historial(oHistorial);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la información.";
            }
            return res_;
        }
        public RespuestaUsuario registrar_estado_cuestionario(HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = historialDA.registrar_estado_cuestionario(oHistorial);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error atendiendo su solicitud.";
            }
            return res_;
        }

        public List<HistorialPaciente> listar_historial(int id_usuario)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            try
            {
                lista = historialDA.listar_historial(id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        #region "version react"
        public async Task<Respuesta<DataCitas>> HistorialCitas(ListHistorialCitasDto request)
        {
            var dataCitas = new DataCitas();
            var respuesta = await historialDA.HistorialCitas(request);
            request.pagina = 0;
            request.tamanoPagina = 0;
            var respuestaTotal = await historialDA.GetTotalHistorialCitas(request);
            if ((respuesta != null && respuesta.Codigo == 0) && (respuestaTotal != null && respuestaTotal.Codigo == 0))
            {
                dataCitas.TotalRegistros = respuestaTotal.Data;
                dataCitas.Registros = respuesta.Data;
                return new Respuesta<DataCitas>(0, "", dataCitas);
            }
            else
            {
                return new Respuesta<DataCitas>(-1, "Ocurrió un error al listar el historial de citas.", null);
            }
        }
        #endregion

    }
}
