using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.DA
{
    public class CentroAtencionDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;

        public List<CentroAtencion> listar_centros_atencion(string latitud, string longitud, string main_path, string random_str)
        {
            List<CentroAtencion> lista_output = new List<CentroAtencion>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_centros_atencion, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@latitud", SqlDbType.VarChar).Value = latitud;
                cmd.Parameters.Add("@longitud", SqlDbType.VarChar).Value = longitud;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ta = new DataTable();
                da.Fill(ta);

                foreach (DataRow row in ta.Rows)
                {
                    CentroAtencion ent_output = new CentroAtencion();
                    ent_output.id_centro_atencion = Convert.ToInt32(row["id_centro_atencion"]);
                    ent_output.centro_atencion = Convert.ToString(row["centro_atencion"]);
                    ent_output.direccion = Convert.ToString(row["direccion"]);
                    ent_output.horario = Convert.ToString(row["horario"]);
                    ent_output.validacion = Convert.ToString(row["validacion"]);
                    lista_output.Add(ent_output);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CentroAtencionConnection.cs / listar_centros_atencion <> " + e.Message.ToString(), "ERROR", main_path);

                CentroAtencion ent_error = new CentroAtencion();
                ent_error.validacion = e.Message.ToString();
                lista_output.Add(ent_error);
            }
            cn.Close();
            return lista_output;
        }
    }
}
