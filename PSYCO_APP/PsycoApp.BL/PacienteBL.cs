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


    }
}
