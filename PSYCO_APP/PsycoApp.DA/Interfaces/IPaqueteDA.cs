using PsycoApp.entities.DTO.DtoResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.DA.Interfaces
{
    public interface IPaqueteDA
    {
        public List<PaqueteDTO> Listar(int pagina, int tamanoPagina);
    }
}
