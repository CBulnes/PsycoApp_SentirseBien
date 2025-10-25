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
    public class CajaDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public CajaDA()
        {
            _connection = cn;
        }

        public RespuestaUsuario registrar_caja(Pago oPago, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_pago, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oPago.id_cita;
                cmd.Parameters.Add("@id_forma_pago", SqlDbType.Int).Value = oPago.id_forma_pago;
                cmd.Parameters.Add("@id_detalle_transferencia", SqlDbType.Int).Value = oPago.id_detalle_transferencia;
                cmd.Parameters.Add("@importe", SqlDbType.Decimal).Value = oPago.importe;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oPago.usuario;
                cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = oPago.comentario;

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
                res_.descripcion = "Ocurrió un error al registrar el pago.";
            }
            _connection.Close();
            return res_;
        }

        public List<PagosPendientes> listar_pagos_pendientes(int id_paciente)
        {
            List<PagosPendientes> lista = new List<PagosPendientes>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_pagos_pendientes, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_paciente", SqlDbType.Int).Value = id_paciente;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    PagosPendientes item = new PagosPendientes();
                    item.id_cita = Convert.ToInt32(row["id_cita"]);
                    item.servicio = Convert.ToString(row["servicio"]);
                    item.fecha_cita = Convert.ToString(row["fecha_cita"]);
                    item.usuario_registra = Convert.ToString(row["usuario_registra"]);
                    item.fecha_registra = Convert.ToString(row["fecha_registra"]);
                    item.estado_cita = Convert.ToString(row["estado_cita"]);
                    item.monto_pactado = Convert.ToString(row["monto_pactado"]);
                    item.monto_pagado = Convert.ToString(row["monto_pagado"]);
                    item.monto_pendiente = Convert.ToString(row["monto_pendiente"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            _connection.Close();
            return lista;
        }

        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina, int tamanoPagina, string fecha, int buscar_por, int sede, int id_usuario, int id_cita = 0)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_cuadre_caja, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                cmd.Parameters.Add("@pagina", SqlDbType.Int).Value = pagina;
                cmd.Parameters.Add("@tamanoPagina", SqlDbType.Int).Value = tamanoPagina;
                cmd.Parameters.Add("@fecha", SqlDbType.VarChar).Value = fecha;
                cmd.Parameters.Add("@buscar_por", SqlDbType.Int).Value = buscar_por;
                cmd.Parameters.Add("@sede", SqlDbType.Int).Value = sede;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = id_cita;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    CuadreCaja item = new CuadreCaja();
                    item.paciente = Convert.ToString(row["paciente"]);
                    item.fecha_transaccion = Convert.ToString(row["fecha_transaccion"]);
                    item.estado_cita = Convert.ToString(row["estado_cita"]);
                    item.servicio = Convert.ToString(row["servicio"]);
                    item.forma_pago = Convert.ToString(row["forma_pago"]);
                    item.detalle_transferencia = Convert.ToString(row["detalle_transferencia"]);
                    item.importe = Convert.ToString(row["importe"]);
                    item.usuario = Convert.ToString(row["usuario"]);
                    item.estado_orden = Convert.ToString(row["estado_orden"]);
                    item.sede = Convert.ToString(row["Sede"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            _connection.Close();
            return lista;
        }

        public List<ResumenCajaUsuario> resumen_caja_x_usuario(string usuario, string fecha, int buscar_por, int sede, int id_usuario)
        {
            List<ResumenCajaUsuario> lista = new List<ResumenCajaUsuario>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_resumen_caja_x_usuario, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                cmd.Parameters.Add("@fecha", SqlDbType.VarChar).Value = fecha;
                cmd.Parameters.Add("@buscar_por", SqlDbType.Int).Value = buscar_por;
                cmd.Parameters.Add("@sede", SqlDbType.Int).Value = sede;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    ResumenCajaUsuario item = new ResumenCajaUsuario();
                    item.usuario = Convert.ToString(row["usuario"]);
                    item.importe = Convert.ToString(row["importe"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            _connection.Close();
            return lista;
        }

        public List<ResumenCajaFormaPago> resumen_caja_x_forma_pago(string usuario, string fecha, int buscar_por, int sede, int id_usuario)
        {
            List<ResumenCajaFormaPago> lista = new List<ResumenCajaFormaPago>();
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_resumen_caja_x_forma_pago, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                cmd.Parameters.Add("@fecha", SqlDbType.VarChar).Value = fecha;
                cmd.Parameters.Add("@buscar_por", SqlDbType.Int).Value = buscar_por;
                cmd.Parameters.Add("@sede", SqlDbType.Int).Value = sede;
                cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value = id_usuario;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    ResumenCajaFormaPago item = new ResumenCajaFormaPago();
                    item.cantidad = Convert.ToInt32(row["cantidad"]);
                    item.importe = Convert.ToString(row["importe"]);
                    item.forma_pago = Convert.ToString(row["forma_pago"]);
                    item.detalle_transferencia = Convert.ToString(row["detalle_transferencia"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            _connection.Close();
            return lista;
        }

        #region "version react"
        public async Task<Respuesta<List<CuadreCaja>>> ListarCuadreCaja(ListCajaDto request)
        {
            var respuesta = new Respuesta<List<CuadreCaja>>(-1, "No se encontraron registros o error al listar.");
            var citas = new List<CuadreCaja>();

            try
            {
                await _connection.OpenAsync();
                using (var command = new SqlCommand(Procedures.listar_cuadre_caja_v2, _connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usuario", request.usuario);
                    command.Parameters.AddWithValue("@fecha", request.fecha);
                    command.Parameters.AddWithValue("@buscar_por", request.buscar_por);
                    command.Parameters.AddWithValue("@sede", request.sede);
                    command.Parameters.AddWithValue("@id_usuario", request.id_usuario);
                    command.Parameters.AddWithValue("@id_cita", request.id_cita);
                    command.Parameters.AddWithValue("@pagina", request.pagina);
                    command.Parameters.AddWithValue("@tamanoPagina", request.tamanoPagina);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            citas.Add(new CuadreCaja
                            {
                                Fila = reader.GetInt64(0),
                                paciente = reader.GetString(1),
                                fecha_transaccion = reader.GetString(2),
                                estado_cita = reader.GetString(3),
                                servicio = reader.GetString(4),
                                forma_pago = reader.GetString(5),
                                detalle_transferencia = reader.GetString(6),
                                importe = reader.GetString(7),
                                estado_orden = reader.GetString(8),
                                usuario = reader.GetString(9),
                                sede = reader.GetString(10)
                            });
                        }

                        respuesta = new Respuesta<List<CuadreCaja>>(0, "Cuadre de caja obtenido correctamente.", citas);
                    }
                    _connection.Close();
                }
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta<List<CuadreCaja>>(-1, "Error al listar cuadre de caja: " + ex.Message);
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return respuesta;
        }
        public async Task<Respuesta<int>> GetTotalCuadreCaja(ListCajaDto request)
        {
            var respuesta = new Respuesta<int>(-1, "No se encontraron datos de la caja o error al contar.");
            try
            {
                await _connection.OpenAsync();
                using (var command = new SqlCommand(Procedures.listar_cuadre_caja_v2, _connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usuario", request.usuario);
                    command.Parameters.AddWithValue("@fecha", request.fecha);
                    command.Parameters.AddWithValue("@buscar_por", request.buscar_por);
                    command.Parameters.AddWithValue("@sede", request.sede);
                    command.Parameters.AddWithValue("@id_usuario", request.id_usuario);
                    command.Parameters.AddWithValue("@id_cita", request.id_cita);
                    command.Parameters.AddWithValue("@pagina", request.pagina);
                    command.Parameters.AddWithValue("@tamanoPagina", request.tamanoPagina);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            int total = reader.GetInt32(0);
                            respuesta = new Respuesta<int>(0, "Total de datos de la caja obtenido correctamente.", total);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta<int>(-1, "Error al obtener el total de datos de la caja: " + ex.Message);
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return respuesta;
        }
        public async Task<Respuesta<List<ResumenCajaUsuario>>> ListarResumenUsuario(ListCajaDto request)
        {
            var respuesta = new Respuesta<List<ResumenCajaUsuario>>(-1, "No se encontraron registros o error al listar.");
            var citas = new List<ResumenCajaUsuario>();

            try
            {
                await _connection.OpenAsync();
                using (var command = new SqlCommand(Procedures.listar_resumen_caja_x_usuario_v2, _connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usuario", request.usuario);
                    command.Parameters.AddWithValue("@fecha", request.fecha);
                    command.Parameters.AddWithValue("@buscar_por", request.buscar_por);
                    command.Parameters.AddWithValue("@sede", request.sede);
                    command.Parameters.AddWithValue("@id_usuario", request.id_usuario);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            citas.Add(new ResumenCajaUsuario
                            {
                                Fila = reader.GetInt64(0),
                                importe = reader.GetString(1),
                                usuario = reader.GetString(2),
                                mes = reader.GetInt32(3),
                                anho = reader.GetInt32(4)
                            });
                        }

                        respuesta = new Respuesta<List<ResumenCajaUsuario>>(0, "Resumen de caja por usuario obtenido correctamente.", citas);
                    }
                    _connection.Close();
                }
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta<List<ResumenCajaUsuario>>(-1, "Error al listar resumen de caja por usuario: " + ex.Message);
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return respuesta;
        }
        public async Task<Respuesta<List<ResumenCajaFormaPago>>> ListarResumenFormaPago(ListCajaDto request)
        {
            var respuesta = new Respuesta<List<ResumenCajaFormaPago>>(-1, "No se encontraron registros o error al listar.");
            var citas = new List<ResumenCajaFormaPago>();

            try
            {
                await _connection.OpenAsync();
                using (var command = new SqlCommand(Procedures.listar_resumen_caja_x_forma_pago_v2, _connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usuario", request.usuario);
                    command.Parameters.AddWithValue("@fecha", request.fecha);
                    command.Parameters.AddWithValue("@buscar_por", request.buscar_por);
                    command.Parameters.AddWithValue("@sede", request.sede);
                    command.Parameters.AddWithValue("@id_usuario", request.id_usuario);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            citas.Add(new ResumenCajaFormaPago
                            {
                                Fila = reader.GetInt64(0),
                                cantidad = reader.GetInt32(1),
                                importe = reader.GetString(2),
                                forma_pago = reader.GetString(3),
                                detalle_transferencia = reader.GetString(4),
                                mes = reader.GetInt32(5),
                                anho = reader.GetInt32(6)
                            });
                        }

                        respuesta = new Respuesta<List<ResumenCajaFormaPago>>(0, "Resumen de caja por forma de pago obtenido correctamente.", citas);
                    }
                    _connection.Close();
                }
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta<List<ResumenCajaFormaPago>>(-1, "Error al listar resumen de caja por forma de pago: " + ex.Message);
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
