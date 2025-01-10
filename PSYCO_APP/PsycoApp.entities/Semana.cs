using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Semana
    {
        public int Id { get; set; }
        public int NumeroSemana { get; set; }
        public string Fecha { get; set; }
        public string NombreDia { get; set; }
        public int NumeroDia { get; set; }
    }
    public class Horario
    {
        public int IdPsicologo { get; set; }
        public int Orden { get; set; }
        public int Id { get; set; }
        public string Fecha { get; set; }
        public string NombreDia { get; set; }
        public string Inicio { get; set; }
        public string Refrigerio { get; set; }
        public string Fin { get; set; }
    }
}