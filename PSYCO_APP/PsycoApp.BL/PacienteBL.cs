using PsycoApp.DA;
using PsycoApp.entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.BL
{
    public class PacienteBL
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

        public List<Paciente> ListarPacientesSede(int pagina, int tamanoPagina, int sede)
        {
            return _pacienteDA.ListarPacientesSede(pagina, tamanoPagina,sede);
        }



        public void AgregarPaciente(Paciente paciente)
        {
            _pacienteDA.AgregarPaciente(paciente);
        }
        public List<Paciente> BuscarPaciente(string nombre, int pageNumber = 1, int pageSize = 10,int sede = 0)
        {
           return _pacienteDA.BuscarPaciente(nombre,pageNumber,pageSize,sede);
        }
        
        public Paciente BuscarPacienteId(int id, int idSede = 0)
        {
            return _pacienteDA.BuscarPacienteId(id, idSede);
        }

        public bool PacientePerteneceASede(int idPaciente, int idSede)
        {
            return _pacienteDA.PacientePerteneceASede(idPaciente, idSede);
        }

        public void ActualizarPaciente(Paciente paciente)
        {
            _pacienteDA.ActualizarPaciente(paciente);
        }

        public void EliminarPaciente(int id, int idSede = 0)
        {
            _pacienteDA.EliminarPaciente(id, idSede);
        }

        public List<entities.Paciente> listar_pacientes_combo(int idSede = 0)
        {
            return _pacienteDA.listar_pacientes_combo(idSede);
        }
        public List<entities.Paciente> listar_pacientes_combo_dinamico(int page, int pageSize, string search, int sede)
        {
            return _pacienteDA.listar_pacientes_combo_dinamico(page, pageSize, search, sede); // Llamada a la capa de datos
        }


    }
}
