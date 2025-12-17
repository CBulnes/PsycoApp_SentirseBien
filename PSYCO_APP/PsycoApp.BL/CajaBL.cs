using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;

namespace PsycoApp.BL
{
    public class CajaBL
    {
        CajaDA cajaDA = new CajaDA();

        public RespuestaUsuario registrar_pago_masivo(PagoMasivo oPago, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                foreach (var item in oPago.pagosEnviar)
                {
                    Pago pago = new Pago()
                    {
                        id_cita = item.idCita,
                        importe = item.totalPagar,
                        id_detalle_transferencia = oPago.id_detalle_transferencia,
                        id_forma_pago = oPago.id_forma_pago,
                        comentario = oPago.comentario,
                        usuario = oPago.usuario,
                        idSede = oPago.idSede
                    };
                    res_ = cajaDA.registrar_caja(pago, main_path, random_str);
                }
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar los pagos.";
            }
            return res_;
        }

        public RespuestaUsuario registrar_pago(Pago oPago, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = cajaDA.registrar_caja(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el pago.";
            }
            return res_;
        }

        public async Task<RespuestaUsuario> DeshacerPago(Pago request)
        {
            return await cajaDA.DeshacerPago(request);
        }

        public RespuestaUsuario registrar_descuento(Pago oPago, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = cajaDA.registrar_descuento(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el descuento.";
            }
            return res_;
        }

        public RespuestaUsuario registrar_efectivo(EfectivoDiario oPago, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = cajaDA.registrar_efectivo(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el efectivo.";
            }
            return res_;
        }

        public List<PagosPendientes> listar_pagos_pendientes(int id_paciente)
        {
            List<PagosPendientes> lista = new List<PagosPendientes>();
            try
            {
                lista = cajaDA.listar_pagos_pendientes(id_paciente);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<CajasUsuario> listar_cajas(string usuario, DateTime date)
        {
            List<CajasUsuario> lista = new List<CajasUsuario>();
            try
            {
                lista = cajaDA.listar_cajas(usuario, date);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }


        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina, int tamanoPagina, string fecha, int buscar_por, int sede, int id_usuario, int id_cita = 0, int id_caja = 0)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.listar_cuadre_caja(usuario, pagina, tamanoPagina, fecha, buscar_por, sede, id_usuario, id_cita, id_caja);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<CuadreCaja> resumen_caja_x_usuario(string usuario, string fecha, int buscar_por, int sede, int id_usuario)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.resumen_caja_x_usuario(usuario, fecha, buscar_por, sede, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<CuadreCaja> resumen_caja_x_forma_pago(string usuario, string fecha, int buscar_por, int sede, int id_usuario)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.resumen_caja_x_forma_pago(usuario, fecha, buscar_por, sede, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<ListaEfectivoDiario> listar_efectivo_diario(string usuario, DateTime fecha, int idSede)
        {
            List<ListaEfectivoDiario> lista = new List<ListaEfectivoDiario>();
            try
            {
                lista = cajaDA.listar_efectivo_diario(usuario, 
                    fecha, idSede);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        #region caja_nuevo
        public async Task<RespuestaUsuario> aperturar_caja(CajaNuevo request)
        {
            return await cajaDA.aperturar_caja(request);
        }
        public async Task<RespuestaUsuario> cerrar_caja(CajaNuevo request)
        {
            return await cajaDA.cerrar_caja(request);
        }
        #endregion

    }
}
