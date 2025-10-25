using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL
{
    public class PacienteBL : IPacienteBL
    {
        private readonly PacienteDA _pacienteDA;

        public PacienteBL()
        {
            _pacienteDA = new PacienteDA();
        }

        public List<Paciente> ListarPacientes(int pagina, int tamanoPagina)
        {
            return _pacienteDA.ListarPacientes(pagina, tamanoPagina);
        }

        public void AgregarPaciente(Paciente paciente)
        {
            _pacienteDA.AgregarPaciente(paciente);
        }
        public List<Paciente> BuscarPaciente(string nombre, int pageNumber = 1, int pageSize = 10)
        {
           return _pacienteDA.BuscarPaciente(nombre,pageNumber,pageSize);
        }
        
        public Paciente BuscarPacienteId(int id)
        {
            return _pacienteDA.BuscarPacienteId(id);
        }

        public void ActualizarPaciente(Paciente paciente)
        {
            _pacienteDA.ActualizarPaciente(paciente);
        }

        public void EliminarPaciente(int id)
        {
            _pacienteDA.EliminarPaciente(id);
        }

        public List<entities.Paciente> listar_pacientes_combo()
        {
            return _pacienteDA.listar_pacientes_combo();
        }
        public List<entities.Paciente> listar_pacientes_combo_dinamico(int page, int pageSize, string search, int sede)
        {
            return _pacienteDA.listar_pacientes_combo_dinamico(page, pageSize, search, sede); // Llamada a la capa de datos
        }

        #region "version react"
        public async Task<Respuesta<DataPacientes>> GetList(ListPacientesDto request)
        {
            var dataPacientes = new DataPacientes();
            var respuesta = await _pacienteDA.GetList(request);
            var respuestaTotal = await _pacienteDA.GetTotalList(new ListPacientesDto() { pagina = 0, tamanoPagina = 0 });
            if ((respuesta != null && respuesta.Codigo == 0) && (respuestaTotal != null && respuestaTotal.Codigo == 0))
            {
                dataPacientes.TotalRegistros = respuestaTotal.Data;
                dataPacientes.Registros = respuesta.Data;
                return new Respuesta<DataPacientes>(0, "", dataPacientes);
            }
            else
            {
                return new Respuesta<DataPacientes>(-1, "Ocurrió un error al listar los pacientes.", null);
            }
        }

        #endregion

    }
}
