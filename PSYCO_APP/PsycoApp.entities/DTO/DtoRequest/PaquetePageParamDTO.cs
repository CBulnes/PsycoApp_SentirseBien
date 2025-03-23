using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.entities.DTO.DtoRequest
{
   public class PaquetePageParamDTO
    {
        public string filtro { get; set; }
        public string order { get; set; }
        public int tamanoPagina { get; set; }
        public int pagina { get; set; }
        public int total { get; set; }  

            
    }
}
