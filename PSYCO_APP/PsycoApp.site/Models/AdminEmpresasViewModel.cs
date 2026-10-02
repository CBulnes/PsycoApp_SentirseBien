using System.Collections.Generic;
using PsycoApp.entities;

namespace PsycoApp.site.Models
{
    public class AdminEmpresasViewModel
    {
        public List<Empresa> Empresas { get; set; } = new List<Empresa>();
        public dynamic DynamicData { get; set; }
    }
}
