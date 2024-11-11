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
    public class CajaDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public RespuestaUsuario registrar_caja(Pago oPago, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_registrar_pago, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_cita", SqlDbType.Int).Value = oPago.id_cita;
                cmd.Parameters.Add("@id_forma_pago", SqlDbType.Int).Value = oPago.id_forma_pago;
                cmd.Parameters.Add("@id_detalle_transferencia", SqlDbType.Int).Value = oPago.id_detalle_transferencia;
                cmd.Parameters.Add("@importe", SqlDbType.Decimal).Value = oPago.importe;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = oPago.usuario;

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
            cn.Close();
            return res_;
        }

        public List<PagosPendientes> listar_pagos_pendientes(int id_paciente)
        {
            List<PagosPendientes> lista = new List<PagosPendientes>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_pagos_pendientes, cn);
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
            cn.Close();
            return lista;
        }

        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina, int tamanoPagina)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_cuadre_caja, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                cmd.Parameters.Add("@pagina", SqlDbType.Int).Value = pagina;
                cmd.Parameters.Add("@tamanoPagina", SqlDbType.Int).Value = tamanoPagina;

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
                    item.estado_orden = Convert.ToString(row["estado_orden"]);
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

        public List<CuadreCaja> listar_resumen_caja(string usuario, int mes, int año)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_resumen_caja, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                cmd.Parameters.Add("@mes", SqlDbType.Int).Value = mes;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    CuadreCaja item = new CuadreCaja();
                    item.usuario = Convert.ToString(row["usuario"]);
                    item.importe = Convert.ToString(row["importe"]);
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
