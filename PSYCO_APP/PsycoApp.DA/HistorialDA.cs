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
    public class HistorialDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public RespuestaUsuario registrar_historial(HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_historial_paciente, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = oHistorial.id_paciente;
                cmd.Parameters.Add("@nota", SqlDbType.VarChar).Value = oHistorial.nota;
                cmd.Parameters.Add("@recomendacion", SqlDbType.VarChar).Value = oHistorial.recomendacion;
                cmd.Parameters.Add("@medicina", SqlDbType.VarChar).Value = oHistorial.medicina;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = oHistorial.id_doctor;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oHistorial.id_cita;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    res_.descripcion = Convert.ToString(row["rpta"]);
                }
                res_.estado = res_.descripcion == "OK" ? true : false;
            }
            catch (Exception e)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la información.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario registrar_estado_cuestionario(HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_estado_cuestionario, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oHistorial.id_cita;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    res_.descripcion = Convert.ToString(row["rpta"]);
                }
                res_.estado = res_.descripcion == "OK" ? true : false;
            }
            catch (Exception e)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error atendiendo su solicitud.";
            }
            cn.Close();
            return res_;
        }

        public List<HistorialPaciente> listar_historial(int id_usuario)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_historial_paciente, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    HistorialPaciente historial = new HistorialPaciente();
                    historial.id_historial = Convert.ToInt32(row["id_historial"]);
                    historial.nota = Convert.ToString(row["nota"]);
                    historial.recomendacion = Convert.ToString(row["recomendacion"]);
                    historial.medicina = Convert.ToString(row["medicina"]);
                    historial.doctor = Convert.ToString(row["doctor"]);
                    historial.fecha_registro = Convert.ToString(row["fecha_registro"]);
                    historial.hora_registro = Convert.ToString(row["hora_registro"]);
                    historial.cuestionarios = Convert.ToString(row["cuestionarios"]);
                    lista.Add(historial);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            cn.Close();
            return lista;
        }


    }
}
