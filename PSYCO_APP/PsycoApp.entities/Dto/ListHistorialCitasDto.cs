using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities.Dto
{
    public class ListHistorialCitasDto
    {
        public string inicio { get; set; }
        public string fin { get; set; }
        public int id_estado { get; set; }
        public int id_doctor { get; set; }
        public int ver_sin_reserva { get; set; }
        public int pagina { get; set; }
        public int tamanoPagina { get; set; }
    }
}