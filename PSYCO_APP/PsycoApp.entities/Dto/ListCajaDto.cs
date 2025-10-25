using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities.Dto
{
    public class ListCajaDto
    {
        public string usuario { get; set; }
        public string fecha { get; set; }
        public int buscar_por { get; set; }
        public int sede { get; set; }
        public int id_usuario { get; set; }        
        public int id_cita { get; set; } /* EXCLUSIVO PARA "LISTAR CUADRE CAJA", LOS DEMÁS SON PARA "RESUMEN CAJA x USUARIO" Y "RESUMEN x FORMA PAGO" */
        public int pagina { get; set; }
        public int tamanoPagina { get; set; }
    }
}