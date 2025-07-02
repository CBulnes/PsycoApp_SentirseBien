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
    public class ConfigBL
    {
        ConfigDA configDA = new ConfigDA();

        public List<Configuracion> obtener_configuracion()
        {
            List<Configuracion> lista = new List<Configuracion>();
            try
            {
                lista = configDA.obtener_configuracion();
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public void actualizar_valor(string key, string value)
        {
            configDA.actualizar_valor(key, value);
        }

    }
}
