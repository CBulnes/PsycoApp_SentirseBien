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
    public class FlujoBL
    {
        FlujoDA flujoDA = new FlujoDA();

        public List<Flujo> validar_flujo_actual(int id_usuario, string main_path, string random_str)
        {
            return flujoDA.validar_flujo_actual(id_usuario, main_path, random_str);
        }

        public string registrar_flujo(Flujo oFlujo, string main_path, string random_str)
        {
            return flujoDA.registrar_flujo(oFlujo, main_path, random_str);
        }

    }
}
