using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities.Dto
{
    public class LoginDto
    {
        public string usuario { get; set; }
        public string password { get; set; }
        public int idCentro { get; set; }
    }
}