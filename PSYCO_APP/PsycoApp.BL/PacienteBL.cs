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
        public List<Paciente> BuscarPaciente(string nombre)
        {
           return _pacienteDA.BuscarPaciente(nombre);
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
    }
}
