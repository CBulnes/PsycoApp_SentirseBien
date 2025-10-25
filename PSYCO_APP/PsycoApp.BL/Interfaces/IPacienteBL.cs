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
    public interface IPacienteBL
    {
        List<Paciente> ListarPacientes(int pagina, int tamanoPagina);
        void AgregarPaciente(Paciente paciente);
        List<Paciente> BuscarPaciente(string nombre, int pageNumber = 1, int pageSize = 10);
        Paciente BuscarPacienteId(int id);
        void ActualizarPaciente(Paciente paciente);
        void EliminarPaciente(int id);
        List<entities.Paciente> listar_pacientes_combo();
        List<entities.Paciente> listar_pacientes_combo_dinamico(int page, int pageSize, string search, int sede);

        #region "version react"
        Task<Respuesta<DataPacientes>> GetList(ListPacientesDto request);
        #endregion
    }
}