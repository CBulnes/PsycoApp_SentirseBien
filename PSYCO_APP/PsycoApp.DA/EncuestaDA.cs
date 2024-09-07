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
    public class EncuestaDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public string registrar_puntuacion(Puntuacion oPuntuacion, string main_path, string random_str)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_puntuacion, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = oPuntuacion.id_usuario;
                cmd.Parameters.Add("@puntuacion", SqlDbType.VarChar).Value = oPuntuacion.puntuacion;

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
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[EncuestaConnection.cs / registrar_puntuacion <> " + e.Message.ToString(), "ERROR", main_path);
                rpta = "Ocurrió un error al registrar la encuesta";
            }
            cn.Close();
            return rpta;
        }
    }
}
