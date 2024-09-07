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
    public class PuntoVisitadoDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;

        public List<PuntoVisitado> listar_puntos_visitados(int año, int mes, string main_path, string random_str)
        {
            List<PuntoVisitado> lista_output = new List<PuntoVisitado>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_puntos_visitados, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;
                cmd.Parameters.Add("@mes", SqlDbType.Int).Value = mes;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ta = new DataTable();
                da.Fill(ta);

                foreach (DataRow row in ta.Rows)
                {
                    PuntoVisitado ent_output = new PuntoVisitado();
                    ent_output.orden = Convert.ToInt32(row["orden"]);
                    ent_output.num_mes = Convert.ToInt32(row["num_mes"]);
                    ent_output.mes = Convert.ToString(row["mes"]);
                    ent_output.tipo = Convert.ToString(row["tipo"]);
                    ent_output.visitante = Convert.ToString(row["visitante"]);
                    ent_output.total = Convert.ToInt32(row["total"]);
                    lista_output.Add(ent_output);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[PuntoVisitadoConnection.cs / listar_puntos_visitados <> " + e.Message.ToString(), "ERROR", main_path);

                PuntoVisitado ent_error = new PuntoVisitado();
                ent_error.validacion = e.Message.ToString();
                lista_output.Add(ent_error);
            }
            cn.Close();
            return lista_output;
        }

        public List<PuntoVisitado> listar_visitas(int año, int mes, string main_path, string random_str)
        {
            List<PuntoVisitado> lista_output = new List<PuntoVisitado>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_visitas, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;
                cmd.Parameters.Add("@mes", SqlDbType.Int).Value = mes;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ta = new DataTable();
                da.Fill(ta);

                foreach (DataRow row in ta.Rows)
                {
                    PuntoVisitado ent_output = new PuntoVisitado();
                    ent_output.orden = Convert.ToInt32(row["orden"]);
                    ent_output.num_mes = Convert.ToInt32(row["num_mes"]);
                    ent_output.mes = Convert.ToString(row["mes"]);
                    ent_output.tipo = Convert.ToString(row["tipo"]);
                    ent_output.visitante = Convert.ToString(row["visitante"]);
                    ent_output.total = Convert.ToInt32(row["total"]);
                    lista_output.Add(ent_output);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[PuntoVisitadoConnection.cs / listar_visitas <> " + e.Message.ToString(), "ERROR", main_path);

                PuntoVisitado ent_error = new PuntoVisitado();
                ent_error.validacion = e.Message.ToString();
                lista_output.Add(ent_error);
            }
            cn.Close();
            return lista_output;
        }

        public List<PuntoVisitado> listar_encuestas(int año, int mes, string main_path, string random_str)
        {
            List<PuntoVisitado> lista_output = new List<PuntoVisitado>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_encuesta, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;
                cmd.Parameters.Add("@mes", SqlDbType.Int).Value = mes;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ta = new DataTable();
                da.Fill(ta);

                foreach (DataRow row in ta.Rows)
                {
                    PuntoVisitado ent_output = new PuntoVisitado();
                    ent_output.orden = Convert.ToInt32(row["orden"]);
                    ent_output.num_mes = Convert.ToInt32(row["num_mes"]);
                    ent_output.mes = Convert.ToString(row["mes"]);
                    ent_output.tipo = Convert.ToString(row["tipo"]);
                    ent_output.visitante = Convert.ToString(row["visitante"]);
                    ent_output.total = Convert.ToInt32(row["total"]);
                    lista_output.Add(ent_output);
                }
            }
            catch (Exception e)
            {
                LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[PuntoVisitadoConnection.cs / listar_visitas <> " + e.Message.ToString(), "ERROR", main_path);

                PuntoVisitado ent_error = new PuntoVisitado();
                ent_error.validacion = e.Message.ToString();
                lista_output.Add(ent_error);
            }
            cn.Close();
            return lista_output;
        }
    }
}
