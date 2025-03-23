using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.entities.DTO.DtoResponse
{
   public class PaquetePageDTO
    {
        public List<PaqueteDTO> Paquetes { get; set; }
        public int totalReg { get; set; }
    }
}
