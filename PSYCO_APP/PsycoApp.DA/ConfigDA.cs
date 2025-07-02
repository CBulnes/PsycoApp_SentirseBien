using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.DA
{
    public class ConfigDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        
        public List<Configuracion> obtener_configuracion()
        {
            List<Configuracion> lista = new List<Configuracion>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("dbo.SP_OBTENER_CONFIGURACION", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Configuracion item = new Configuracion() {
                        Id = Convert.ToInt32(row["Id"]),
                        ConfigKey = Convert.ToString(row["ConfigKey"]),
                        ConfigValue = Convert.ToString(row["ConfigValue"])
                    };
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

        public void actualizar_valor(string key, string value)
        {
            using (var command = new SqlCommand("dbo.SP_ACTUALIZAR_CONFIGURACION", cn))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Key", key);
                command.Parameters.AddWithValue("@Value", value);
                cn.Open();
                command.ExecuteNonQuery();
                cn.Close();
            }
        }

    }
}
