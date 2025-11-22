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

        public RespuestaUsuario validar_cita(Cita oCita, string adicional, int orden, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_validar_cita, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = oCita.id_paciente;
                cmd.Parameters.Add("@fecha_cita", SqlDbType.VarChar).Value = oCita.fecha_cita;
                cmd.Parameters.Add("@hora_cita", SqlDbType.VarChar).Value = oCita.hora_cita;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = oCita.id_doctor_asignado;
                cmd.Parameters.Add("@monto_pactado", SqlDbType.Decimal).Value = oCita.monto_pactado;
                cmd.Parameters.Add("@id_servicio", SqlDbType.Int).Value = oCita.id_servicio;
                cmd.Parameters.Add("@id_sede", SqlDbType.Int).Value = oCita.id_sede;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;
                cmd.Parameters.Add("@adicional", SqlDbType.VarChar).Value = adicional;
                cmd.Parameters.Add("@feedback", SqlDbType.Bit).Value = oCita.feedback;
                cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = oCita.comentario;
                cmd.Parameters.Add("@orden", SqlDbType.Int).Value = orden;

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
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario validar_cita_adicional(Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_VALIDAR_CITA_ADICIONAL", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@fecha_cita", SqlDbType.VarChar).Value = oCita.fecha_cita;
                cmd.Parameters.Add("@hora_cita", SqlDbType.VarChar).Value = oCita.hora_cita;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = oCita.id_doctor_asignado;

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
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario registrar_informe(Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_INSERTAR_INFORME_ADICIONAL", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@id_paquete", SqlDbType.Int).Value = oCita.id_paquete;
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
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el informe.";
            }
            finally
            {
                cn.Close();
            }
            return res_;
        }

        public RespuestaUsuario registrar_cita(Cita oCita, string adicional, int orden, int? id_paquete)
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
                cmd.Parameters.Add("@id_sede", SqlDbType.Int).Value = oCita.id_sede;
                cmd.Parameters.Add("@tipo_cita", SqlDbType.VarChar).Value = oCita.tipo_cita;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oCita.usuario;
                cmd.Parameters.Add("@adicional", SqlDbType.VarChar).Value = adicional;
                cmd.Parameters.Add("@feedback", SqlDbType.Bit).Value = oCita.feedback;
                cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = oCita.comentario;
                cmd.Parameters.Add("@orden", SqlDbType.Int).Value = orden;

                SqlParameter paramIdPaquete = new SqlParameter("@id_paquete", SqlDbType.Int);
                paramIdPaquete.Direction = ParameterDirection.InputOutput;
                paramIdPaquete.Value = (oCita.id_paquete == null || oCita.id_paquete == 0) ? id_paquete : oCita.id_paquete;
                cmd.Parameters.Add(paramIdPaquete);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    res_.descripcion = Convert.ToString(row["rpta"]);
                }
                res_.estado = res_.descripcion == "OK";

                // Recuperar valor de salida
                if (paramIdPaquete.Value != DBNull.Value)
                {
                    res_.id_paquete = Convert.ToInt32(paramIdPaquete.Value);
                }
            }
            catch (Exception e)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            finally
            {
                cn.Close();
            }
            return res_;
        }


        public RespuestaUsuario actualizar_cita_adicional(Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_ACTUALIZAR_CITA_ADICIONAL", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oCita.id_cita;
                cmd.Parameters.Add("@fecha_cita", SqlDbType.VarChar).Value = oCita.fecha_cita;
                cmd.Parameters.Add("@hora_cita", SqlDbType.VarChar).Value = oCita.hora_cita;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = oCita.id_doctor_asignado;
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
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            finally
            {
                cn.Close();
            }
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

        public RespuestaUsuario actualizar_servicio(int id_cita, int id_servicio)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_actualizar_servicio, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = id_cita;
                cmd.Parameters.Add("@id_servicio", SqlDbType.VarChar).Value = id_servicio;
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
                res_.descripcion = "Ocurrió un error al actualizar el servicio.";
            }
            cn.Close();
            return res_;
        }

        public RespuestaUsuario pago_gratuito(int id_cita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_pago_gratis, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = id_cita;

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
                res_.descripcion = "Ocurrió un error al registrar el pago gratuito.";
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

        public async Task<List<Cita>> disponibilidad_doctor_async(
     int id_doctor,
     string fecha,
     string main_path,
     string random_str)
        {
            List<Cita> lista = new List<Cita>();

            try
            {
                await cn.OpenAsync();

                using (SqlCommand cmd = new SqlCommand(Procedures.sp_listar_disponibilidad_doctor, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = id_doctor;
                    cmd.Parameters.Add("@fecha", SqlDbType.VarChar).Value = fecha;

                    // El SqlDataReader async es mucho más rápido que SqlDataAdapter
                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Cita cita = new Cita
                            {
                                estado = reader["estado"].ToString()
                            };

                            // Conversión eficiente
                            TimeSpan hora = reader.GetTimeSpan(reader.GetOrdinal("hora_cita"));
                            cita.hora_cita_mostrar = DateTime.Today.Add(hora).ToString("hh:mm tt");
                            cita.hora_cita = hora.ToString(@"hh\:mm\:ss\.fffffff");

                            lista.Add(cita);
                        }
                    }
                }
            }
            catch
            {
                lista.Clear();
            }
            finally
            {
                await cn.CloseAsync();
            }

            return lista;
        }


        public List<Cita> citas_usuario(int id_usuario, int id_paciente, int id_doctor, int id_sede, string main_path, string random_str)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_citas_usuario, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = id_paciente;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = id_doctor;
                cmd.Parameters.Add("@id_sede", SqlDbType.Int).Value = id_sede;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Cita cita = new Cita();
                    cita.id_cita = Convert.ToInt32(row["id_cita"]);
                    cita.id_paquete = Convert.ToInt32(row["id_paquete"]);
                    cita.id_estado_cita = Convert.ToInt32(row["id_estado_cita"]);
                    cita.estado = Convert.ToString(row["estado"]);
                    cita.fecha_cita = Convert.ToString(row["fecha_cita"]);
                    cita.hora_cita = Convert.ToString(row["hora_cita"]);
                    cita.id_doctor_asignado = Convert.ToInt32(row["id_doctor_asignado"]);
                    cita.doctor_asignado = Convert.ToString(row["doctor_asignado"]);
                    cita.id_paciente = Convert.ToInt32(row["id_paciente"]);
                    cita.dni_paciente = Convert.ToString(row["dni_paciente"]);
                    cita.paciente = Convert.ToString(row["paciente"]);
                    cita.tipo = Convert.ToString(row["tipo"]);
                    cita.telefono = Convert.ToString(row["telefono"]);
                    cita.moneda = Convert.ToString(row["moneda"]);
                    cita.monto_pactado = Convert.ToDecimal(row["monto_pactado"]);
                    cita.monto_pagado = Convert.ToDecimal(row["monto_pagado"]);
                    cita.monto_pendiente = Convert.ToDecimal(row["monto_pendiente"]);
                    cita.id_servicio = Convert.ToInt32(row["id_servicio"]);
                    cita.nombre_servicio = Convert.ToString(row["nombre_servicio"]);
                    cita.id_sede = Convert.ToInt32(row["id_sede"]);
                    cita.tipo_cita = Convert.ToString(row["tipo_cita"]);
                    cita.esEvaluacion = Convert.ToBoolean(row["esEvaluacion"]);
                    cita.siglas = Convert.ToString(row["siglas"]);
                    cita.siglas = Convert.ToString(row["siglas"]);
                    cita.feedback = Convert.ToBoolean(row["feedback"]);
                    cita.comentario = Convert.ToString(row["comentario"]);
                    cita.pago_gratis = Convert.ToBoolean(row["pago_gratis"]);
                    cita.orden_cita = Convert.ToString(row["orden_cita"]);
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

        public async Task<List<Cita>> citas_por_paquete(int id_paquete)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                await cn.OpenAsync();

                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_citas_paquete, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_paquete", SqlDbType.Int).Value = id_paquete;

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        Cita cita = new Cita();
                        cita.id_cita = Convert.ToInt32(reader["id_cita"]);
                        cita.id_paquete = Convert.ToInt32(reader["id_paquete"]);
                        cita.id_estado_cita = Convert.ToInt32(reader["id_estado_cita"]);
                        cita.estado = Convert.ToString(reader["estado"]);
                        cita.fecha_cita = Convert.ToString(reader["fecha_cita"]);
                        cita.id_doctor_asignado = Convert.ToInt32(reader["id_doctor_asignado"]);
                        cita.doctor_asignado = Convert.ToString(reader["doctor_asignado"]);
                        cita.id_paciente = Convert.ToInt32(reader["id_paciente"]);
                        cita.dni_paciente = Convert.ToString(reader["dni_paciente"]);
                        cita.paciente = Convert.ToString(reader["paciente"]);
                        cita.tipo = Convert.ToString(reader["tipo"]);
                        cita.telefono = Convert.ToString(reader["telefono"]);
                        cita.moneda = Convert.ToString(reader["moneda"]);
                        cita.monto_pactado = Convert.ToDecimal(reader["monto_pactado"]);
                        cita.monto_pagado = Convert.ToDecimal(reader["monto_pagado"]);
                        cita.monto_pendiente = Convert.ToDecimal(reader["monto_pendiente"]);
                        cita.id_servicio = Convert.ToInt32(reader["id_servicio"]);
                        cita.nombre_servicio = Convert.ToString(reader["nombre_servicio"]);
                        cita.id_sede = Convert.ToInt32(reader["id_sede"]);
                        cita.tipo_cita = Convert.ToString(reader["tipo_cita"]);
                        cita.esEvaluacion = Convert.ToBoolean(reader["esEvaluacion"]);
                        cita.siglas = Convert.ToString(reader["siglas"]);
                        cita.feedback = Convert.ToBoolean(reader["feedback"]);
                        cita.comentario = Convert.ToString(reader["comentario"]);
                        cita.pago_gratis = Convert.ToBoolean(reader["pago_gratis"]);

                        TimeSpan hora = reader.GetTimeSpan(reader.GetOrdinal("hora_cita"));
                        cita.hora_cita_mostrar = DateTime.Today.Add(hora).ToString("hh:mm tt");
                        cita.hora_cita = hora.ToString(@"hh\:mm\:ss\.fffffff");
                        //cita.hora_cita = Convert.ToString(row["hora_cita"]);
                        lista.Add(cita);
                    }
                }
            }
            catch
            {
                lista.Clear();
            }
            finally
            {
                await cn.CloseAsync();
            }
            return lista;
        }

        public List<Cita> horarios_doctor(string inicio, string fin, int id_doctor)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_LISTAR_HORARIOS_SEMANA_PSICOLOGO", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@inicio_", SqlDbType.VarChar).Value = inicio;
                cmd.Parameters.Add("@fin_", SqlDbType.VarChar).Value = fin;
                cmd.Parameters.Add("@id_psicologo", SqlDbType.Int).Value = id_doctor;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Cita cita = new Cita();
                    cita.fecha_cita = Convert.ToString(row["fecha_cita"]);
                    cita.hora_cita = Convert.ToString(row["hora_cita"]);
                    cita.tipo = Convert.ToString(row["tipo"]);
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

        public List<Cita> citas_doctor(string usuario, string inicio, string fin, int id_estado, int id_doctor, int ver_sin_reserva)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_citas_doctor, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                cmd.Parameters.Add("@inicio", SqlDbType.VarChar).Value = inicio;
                cmd.Parameters.Add("@fin", SqlDbType.VarChar).Value = fin;
                cmd.Parameters.Add("@id_estado", SqlDbType.Int).Value = id_estado;
                cmd.Parameters.Add("@id_doctor", SqlDbType.Int).Value = id_doctor;
                cmd.Parameters.Add("@ver_sin_reserva", SqlDbType.Int).Value = ver_sin_reserva;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Cita cita = new Cita();
                    cita.id_cita = Convert.ToInt32(row["id_cita"]);
                    cita.id_paquete = Convert.ToInt32(row["id_paquete"]);
                    cita.informe_adicional = Convert.ToString(row["informe_adicional"]);
                    cita.id_estado_cita = Convert.ToInt32(row["id_estado_cita"]);
                    cita.estado = Convert.ToString(row["estado"]);
                    cita.fecha_cita = Convert.ToString(row["fecha_cita"]);
                    cita.hora_cita = Convert.ToString(row["hora_cita"]);
                    cita.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    cita.usuario = Convert.ToString(row["usuario"]);
                    cita.tipo = Convert.ToString(row["tipo"]);
                    cita.servicio = Convert.ToString(row["servicio"]);
                    cita.monto_pendiente_ = Convert.ToString(row["monto_pendiente"]);
                    cita.id_paciente = Convert.ToInt32(row["id_paciente"]);
                    cita.esEvaluacion = Convert.ToBoolean(row["esEvaluacion"]);
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

        public List<entities.Semana> dias_x_semana_mes(int semana, int mes, int año)
        {
            List<entities.Semana> lista = new List<entities.Semana>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_dias_semana_mes, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@numSemana", SqlDbType.Int).Value = semana;
                cmd.Parameters.Add("@mes", SqlDbType.Int).Value = mes;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Semana item = new entities.Semana();
                    item.Id = Convert.ToInt32(row["Id"]);
                    item.NumeroSemana = Convert.ToInt32(row["NumeroSemana"]);
                    item.Fecha = Convert.ToString(row["Fecha"]);
                    item.NombreDia = Convert.ToString(row["NombreDia"]);
                    item.NumeroDia = Convert.ToInt32(row["NumeroDia"]);
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

    }
}
