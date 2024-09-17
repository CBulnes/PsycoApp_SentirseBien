using System;

namespace PsycoApp.site.Models
{
    public class Psicologo
    {
        public int? Id { get; set; }
        public string Nombre { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public string DocumentoTipo { get; set; }
        public string DocumentoNumero { get; set; }
        public string Telefono { get; set; }
        public int Especialidad { get; set; }
        public string Direccion { get; set; }
        public string Distrito { get; set; }
        public string Estado { get; set; }
    }
}