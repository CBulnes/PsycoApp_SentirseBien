using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
  public class Paciente
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string DocumentoTipo { get; set; }
        public string DocumentoNumero { get; set; }
        public string Telefono { get; set; }
        public string EstadoCivil { get; set; }
        public string Sexo { get; set; }
        public string Estado { get; set; }
    }
}
