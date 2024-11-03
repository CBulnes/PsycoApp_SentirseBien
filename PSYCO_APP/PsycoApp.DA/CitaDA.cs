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
    public class CitaDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public RespuestaUsuario registrar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_cita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = oCita.id_paciente;
                cmd.Parameters.Add("@fecha_cita", SqlDbType.VarChar).Value = oCita.fecha_cita;
                cmd.Parameters.Add("@hora_cita", SqlDbType.VarChar).Value = oCita.hora_cita;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = oCita.id_doctor_asignado;
                cmd.Parameters.Add("@monto_pactado", SqlDbType.Decimal).Value = oCita.monto_pactado;
                cmd.Parameters.Add("@id_servicio", SqlDbType.Int).Value = oCita.id_servicio;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;

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
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / registrar_cita <> " + e.Message.ToString(), "ERROR", main_path);
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario confirmar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_confirmar_cita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;
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
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / registrar_cita <> " + e.Message.ToString(), "ERROR", main_path);
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al confirmar la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario procesar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_procesar_cita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;
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
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / registrar_cita <> " + e.Message.ToString(), "ERROR", main_path);
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al procesar la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario atender_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_atender_cita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;
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
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / registrar_cita <> " + e.Message.ToString(), "ERROR", main_path);
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al atender la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario cancelar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_cancelar_cita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;
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
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / registrar_cita <> " + e.Message.ToString(), "ERROR", main_path);
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al cancelar la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario registrar_cuestionario(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_cuestionario, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = oCita.id_usuario;
                cmd.Parameters.Add("@fecha_cita", SqlDbType.VarChar).Value = oCita.fecha_cita;
                //cmd.Parameters.Add("@hora_cita", SqlDbType.VarChar).Value = oCita.hora_cita;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = oCita.id_doctor_asignado;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    res_.descripcion = Convert.ToString(row["rpta"]);
                }
                res_.estado = (res_.descripcion == "OK" || res_.descripcion == "Gracias por participar en el cuestionario") ? true : false;
            }
            catch (Exception e)
            {
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / registrar_cita <> " + e.Message.ToString(), "ERROR", main_path);
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el cuestionario.";
            }
            cn.Close();
            return res_;
        }

        public List<Cita> disponibilidad_doctor(int id_doctor, string fecha, string main_path, string random_str)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_disponibilidad_doctor, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = id_doctor;
                cmd.Parameters.Add("@fecha", SqlDbType.VarChar).Value = fecha;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Cita cita = new Cita();
                    cita.estado = Convert.ToString(row["estado"]);
                    cita.hora_cita = Convert.ToString(row["hora_cita"]);
                    lista.Add(cita);
                }
            }
            catch (Exception e)
            {
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / disponibilidad_doctor <> " + e.Message.ToString(), "ERROR", main_path);
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

        public List<Cita> citas_usuario(int id_usuario, int id_paciente, string main_path, string random_str)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_citas_usuario, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = id_paciente;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Cita cita = new Cita();
                    cita.id_cita = Convert.ToInt32(row["id_cita"]);
                    cita.id_estado_cita = Convert.ToInt32(row["id_estado_cita"]);
                    cita.estado = Convert.ToString(row["estado"]);
                    cita.fecha_cita = Convert.ToString(row["fecha_cita"]);
                    cita.hora_cita = Convert.ToString(row["hora_cita"]);
                    cita.id_doctor_asignado = Convert.ToInt32(row["id_doctor_asignado"]);
                    cita.doctor_asignado = Convert.ToString(row["doctor_asignado"]);
                    cita.id_paciente = Convert.ToInt32(row["id_paciente"]);
                    cita.paciente = Convert.ToString(row["paciente"]);
                    cita.tipo = Convert.ToString(row["tipo"]);
                    cita.telefono = Convert.ToString(row["telefono"]);
                    cita.moneda = Convert.ToString(row["moneda"]);
                    cita.monto_pactado = Convert.ToDecimal(row["monto_pactado"]);
                    cita.monto_pagado = Convert.ToDecimal(row["monto_pagado"]);
                    cita.monto_pendiente = Convert.ToDecimal(row["monto_pendiente"]);
                    cita.id_servicio = Convert.ToInt32(row["id_servicio"]);
                    lista.Add(cita);
                }
            }
            catch (Exception e)
            {
                //LOG.registrarLog("(Excepcion " + random_str + ")[ERROR]->[CitaDA.cs / disponibilidad_doctor <> " + e.Message.ToString(), "ERROR", main_path);
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

        public List<Cita> citas_doctor(int id_usuario, string fecha, int id_estado)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_citas_doctor, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;
                cmd.Parameters.Add("@fecha", SqlDbType.VarChar).Value = fecha;
                cmd.Parameters.Add("@id_estado", SqlDbType.Int).Value = id_estado;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Cita cita = new Cita();
                    cita.id_cita = Convert.ToInt32(row["id_cita"]);
                    cita.id_estado_cita = Convert.ToInt32(row["id_estado_cita"]);
                    cita.estado = Convert.ToString(row["estado"]);
                    cita.fecha_cita = Convert.ToString(row["fecha_cita"]);
                    cita.hora_cita = Convert.ToString(row["hora_cita"]);
                    cita.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    cita.usuario = Convert.ToString(row["usuario"]);
                    cita.tipo = Convert.ToString(row["tipo"]);
                    lista.Add(cita);
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
