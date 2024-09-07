using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.DA
{
    public class VisitaDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public string registrar_visita(Visita oVisita, string main_path, string random_str)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_visita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_tipousuario", SqlDbType.Int).Value = oVisita.id_tipousuario;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    rpta = Convert.ToString(row["rpta"]);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[VisitaConnection.cs / registrar_visita <> " + e.Message.ToString(), "ERROR", main_path);
                rpta = "Ocurrió un error al registrar la visita";
            }
            cn.Close();
            return rpta;
        }

        public string registrar_punto_visitado(Visita oVisita, string main_path, string random_str)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_punto_visitado, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_tipousuario", SqlDbType.Int).Value = oVisita.id_tipousuario;
                cmd.Parameters.Add("@punto_visitado", SqlDbType.VarChar).Value = oVisita.punto_visitado;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    rpta = Convert.ToString(row["rpta"]);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[VisitaConnection.cs / registrar_punto_visitado <> " + e.Message.ToString(), "ERROR", main_path);
                rpta = "Ocurrió un error al registrar el punto visitado";
            }
            cn.Close();
            return rpta;
        }
    }
}
