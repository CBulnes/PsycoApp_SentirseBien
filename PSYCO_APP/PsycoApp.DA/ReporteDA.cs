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
    public class ReporteDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;

        public List<ReporteNPS> reporte_nps(int año, int mes, string main_path, string random_str)
        {
            List<ReporteNPS> listaReporte = new List<ReporteNPS>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_resultados_nps, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;
                cmd.Parameters.Add("@mes", SqlDbType.Int).Value = mes;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ta = new DataTable();
                da.Fill(ta);

                foreach (DataRow row in ta.Rows)
                {
                    ReporteNPS oReporteNPS = new ReporteNPS();
                    oReporteNPS.total_entero = Convert.ToInt32(row["total_entero"]);
                    oReporteNPS.total_porcentaje = Convert.ToString(row["total_porcentaje"]);
                    oReporteNPS.resultado = Convert.ToString(row["resultado"]);
                    listaReporte.Add(oReporteNPS);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[ReporteConnection.cs / reporte_nps <> " + e.Message.ToString(), "ERROR", main_path);
                //rpta = "Ocurrió un error generar el reporte";
            }
            cn.Close();
            return listaReporte;
        }
    }
}
