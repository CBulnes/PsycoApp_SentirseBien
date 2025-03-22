using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.entities.DTO.DtoResponse
{
    public class PaqueteDTO
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public decimal Precio { get; set; }
        public string? Color { get; set; }
        public bool? EsEvaluacion { get; set; }
        public int? NumSesiones { get; set; }
        public string? Siglas { get; set; }
    }
}
