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

        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina, int tamanoPagina, string fecha, int buscar_por, int sede, int id_usuario, int id_cita = 0)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.listar_cuadre_caja(usuario, pagina, tamanoPagina, fecha, buscar_por, sede, id_usuario, id_cita);
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

        public List<ListaEfectivoDiario> listar_efectivo_diario(string usuario)
        {
            List<ListaEfectivoDiario> lista = new List<ListaEfectivoDiario>();
            try
            {
                lista = cajaDA.listar_efectivo_diario(usuario);
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
