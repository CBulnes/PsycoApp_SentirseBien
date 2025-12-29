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

        public List<entities.CuadreCaja> historial_pago_cita(int id_cita, int id_sede)
        {
            List<entities.CuadreCaja> lista = new List<entities.CuadreCaja>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_LISTAR_CAJA_MES_FORMA_PAGO_CITA", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = id_cita;
                cmd.Parameters.Add("@sede", SqlDbType.Int).Value = id_sede;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.CuadreCaja historial = new entities.CuadreCaja();
                    historial.cantidad = Convert.ToInt32(row["cantidad"]);
                    historial.importe = Convert.ToString(row["importe"]);
                    historial.forma_pago = Convert.ToString(row["forma_pago"]);
                    historial.detalle_transferencia = Convert.ToString(row["detalle_transferencia"]);
                    historial.mes = Convert.ToInt32(row["mes"]);
                    historial.anho = Convert.ToInt32(row["anho"]);
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

        public async Task<List<HistorialCita>> listar_historial_cita(int id_cita)
        {
            List<HistorialCita> lista = new List<HistorialCita>();

            try
            {
                await cn.OpenAsync();

                using (SqlCommand cmd = new SqlCommand(Procedures.sp_listar_historial_cita, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = id_cita;

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            HistorialCita historial = new HistorialCita
                            {
                                evento = reader["evento"].ToString(),
                                usuario = reader["usuario"].ToString(),
                                fecha = reader["fecha"].ToString()
                            };

                            lista.Add(historial);
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


        public async Task<List<HistorialPaciente>> listar_historial_paciente(int id_paciente)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();

            try
            {
                await cn.OpenAsync();

                using (SqlCommand cmd = new SqlCommand(Procedures.sp_listar_historial_paciente, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = id_paciente;

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            HistorialPaciente historial = new HistorialPaciente
                            {
                                doctor = reader["doctor"].ToString(),
                                fecha_registro = reader["fecha_registro"].ToString()
                            };

                            lista.Add(historial);
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


    }
}
