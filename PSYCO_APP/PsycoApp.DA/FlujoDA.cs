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
    public class FlujoDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public List<Flujo> validar_flujo_actual(int id_usuario, string main_path, string random_str)
        {
            List<Flujo> listaFlujo = new List<Flujo>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_validar_flujo_actual, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ta = new DataTable();
                da.Fill(ta);

                foreach (DataRow row in ta.Rows)
                {
                    Flujo oFlujo = new Flujo();
                    oFlujo.id_flujo = Convert.ToInt32(row["id_flujo"]);
                    oFlujo.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    oFlujo.tipo = Convert.ToString(row["tipo"]);
                    oFlujo.remitente = Convert.ToString(row["remitente"]);
                    oFlujo.contenido_texto = Convert.ToString(row["contenido_texto"]);
                    oFlujo.contenido_html = Convert.ToString(row["contenido_html"]);
                    oFlujo.habilitado = Convert.ToInt32(row["habilitado"]);
                    listaFlujo.Add(oFlujo);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[FlujoConnection.cs / validar_flujo_actual <> " + e.Message.ToString(), "ERROR", main_path);
                rpta = "Ocurrió un error al validar el flujo";
            }
            cn.Close();
            return listaFlujo;
        }

        public string registrar_flujo(Flujo oFlujo, string main_path, string random_str)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_flujo, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = oFlujo.id_usuario;
                cmd.Parameters.Add("@tipo", SqlDbType.VarChar).Value = oFlujo.tipo;
                cmd.Parameters.Add("@remitente", SqlDbType.VarChar).Value = oFlujo.remitente;
                cmd.Parameters.Add("@contenido_texto", SqlDbType.VarChar).Value = oFlujo.contenido_texto;
                cmd.Parameters.Add("@contenido_html", SqlDbType.VarChar).Value = oFlujo.contenido_html;

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
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[FlujoConnection.cs / registrar_flujo <> " + e.Message.ToString(), "ERROR", main_path);
                rpta = "Ocurrió un error al registrar el flujo";
            }
            cn.Close();
            return rpta;
        }

    }
}
