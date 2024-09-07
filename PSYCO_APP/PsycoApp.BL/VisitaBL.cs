using PsycoApp.entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;

namespace PsycoApp.BL
{
    public class VisitaBL
    {
        VisitaDA visitaDa = new VisitaDA();

        public string registrar_visita(Visita oVisita, string main_path, string random_str)
        {
            return visitaDa.registrar_visita(oVisita, main_path, random_str);
        }

        public string registrar_punto_visitado(Visita oVisita, string main_path, string random_str)
        {
            return visitaDa.registrar_punto_visitado(oVisita, main_path, random_str);
        }
    }
}
