using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;

namespace PsycoApp.BL
{
    public class EncuestaBL
    {
        EncuestaDA encuestaDA = new EncuestaDA();

        public string registrar_puntuacion(Puntuacion oPuntuacion, string main_path, string random_str)
        {
            return encuestaDA.registrar_puntuacion(oPuntuacion, main_path, random_str);
        }
    }
}
