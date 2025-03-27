using PsycoApp.entities.DTO.DtoResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL.Interfaces
{
    public interface IPaquete
    {
        public List<PaqueteDTO> Listar(int pagina, int tamanoPagina,ref int vartotalReg);
        Task<PaqueteDTO> Grabar(PaqueteDTO paquete);

        Task<PaqueteDTO> Actualizar(PaqueteDTO paquete);

        Task<int> Eliminar(int id);

    }
}
