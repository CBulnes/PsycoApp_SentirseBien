using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Psicologo
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string DocumentoTipo { get; set; }
        public string DocumentoNumero { get; set; }
        public string Telefono { get; set; }
        public string Refrigerio { get; set; }
        public string InicioLabores { get; set; }
        public string FinLabores { get; set; }
        public int IdSedePrincipal { get; set; }
        public int IdSedeSecundaria { get; set; }
        public int Especialidad { get; set; }
        public string Direccion { get; set; }
        public string Distrito { get; set; }
        public string Estado { get; set; }
        public List<Estudio> Estudios { get; set; }
    }

    public class Estudio
    {
        public int Id { get; set; }
        public int IdPsicologo { get; set; }
        public int GradoAcademico { get; set; }
        public int Institucion { get; set; }
        public int Carrera { get; set; }
    }
}