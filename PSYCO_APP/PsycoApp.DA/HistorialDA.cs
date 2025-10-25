using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.DA
{
    public class HistorialDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public HistorialDA()
        {
            _connection = cn;
        }

        public RespuestaUsuario registrar_historial(HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_historial_paciente, _connection);
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
            _connection.Close();
            return res_;
        }

        public RespuestaUsuario registrar_estado_cuestionario(HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_estado_cuestionario, _connection);
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
            _connection.Close();
            return res_;
        }

        public List<HistorialPaciente> listar_historial(int id_usuario)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_historial_paciente, _connection);
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
            _connection.Close();
            return lista;
        }

        public List<HistorialCita> listar_historial_cita(int id_cita)
        {
            List<HistorialCita> lista = new List<HistorialCita>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_historial_cita, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = id_cita;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    HistorialCita historial = new HistorialCita();
                    historial.evento = Convert.ToString(row["evento"]);
                    historial.usuario = Convert.ToString(row["usuario"]);
                    historial.fecha = Convert.ToString(row["fecha"]);
                    lista.Add(historial);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            _connection.Close();
            return lista;
        }

        public List<HistorialPaciente> listar_historial_paciente(int id_paciente)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_historial_paciente, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = id_paciente;

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
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
            catch (Exception e)
            {
                // Aquí puedes manejar mejor el error si es necesario
                lista.Clear();
            }
            finally
            {
                _connection.Close();
            }
            return lista;
        }

        #region "version react"
        public async Task<Respuesta<List<Cita>>> HistorialCitas(ListHistorialCitasDto request)
        {
            var respuesta = new Respuesta<List<Cita>>(-1, "No se encontraron citas o error al listar.");
            var citas = new List<Cita>();

            try
            {
                await _connection.OpenAsync();
                using (var command = new SqlCommand(Procedures.listar_historial_citas_v2, _connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Inicio", request.inicio);
                    command.Parameters.AddWithValue("@Fin", request.fin);
                    command.Parameters.AddWithValue("@IdEstado", request.id_estado);
                    command.Parameters.AddWithValue("@IdDoctor", request.id_doctor);
                    command.Parameters.AddWithValue("@VerSinReserva", request.ver_sin_reserva);
                    command.Parameters.AddWithValue("@Pagina", request.pagina);
                    command.Parameters.AddWithValue("@TamanoPagina", request.tamanoPagina);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            citas.Add(new Cita
                            {
                                Fila = reader.GetInt64(0),
                                id_cita = reader.GetInt32(1),
                                id_estado_cita = reader.GetInt32(2),
                                estado = reader.GetString(3),
                                fecha_cita = reader.GetString(4),
                                hora_cita = reader.GetString(5),
                                id_paciente = reader.GetInt32(6),
                                usuario = reader.GetString(7),
                                id_usuario = reader.GetInt32(8),
                                tipo = reader.GetString(9)
                            });
                        }
                        
                        respuesta = new Respuesta<List<Cita>>(0, "Historial de citas obtenido correctamente.", citas);
                    }
                    _connection.Close();
                }
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta<List<Cita>>(-1, "Error al listar historial: " + ex.Message);
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return respuesta;
        }

        public async Task<Respuesta<int>> GetTotalHistorialCitas(ListHistorialCitasDto request)
        {
            var respuesta = new Respuesta<int>(-1, "No se encontraron citas o error al contar.");
            try
            {
                await _connection.OpenAsync();
                using (var command = new SqlCommand(Procedures.listar_historial_citas_v2, _connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Inicio", request.inicio);
                    command.Parameters.AddWithValue("@Fin", request.fin);
                    command.Parameters.AddWithValue("@IdEstado", request.id_estado);
                    command.Parameters.AddWithValue("@IdDoctor", request.id_doctor);
                    command.Parameters.AddWithValue("@VerSinReserva", request.ver_sin_reserva);
                    command.Parameters.AddWithValue("@Pagina", request.pagina);
                    command.Parameters.AddWithValue("@TamanoPagina", request.tamanoPagina);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            int total = reader.GetInt32(0);
                            respuesta = new Respuesta<int>(0, "Total de citas obtenido correctamente.", total);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta<int>(-1, "Error al obtener el historial de citas: " + ex.Message);
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return respuesta;
        }
        #endregion
    }
}
