using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.BL
{
    public class CajaBL : ICajaBL
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

        public List<ResumenCajaUsuario> resumen_caja_x_usuario(string usuario, string fecha, int buscar_por, int sede, int id_usuario)
        {
            List<ResumenCajaUsuario> lista = new List<ResumenCajaUsuario>();
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

        public List<ResumenCajaFormaPago> resumen_caja_x_forma_pago(string usuario, string fecha, int buscar_por, int sede, int id_usuario)
        {
            List<ResumenCajaFormaPago> lista = new List<ResumenCajaFormaPago>();
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

        #region "version react"
        public async Task<Respuesta<DataCaja>> GetList(ListCajaDto request)
        {
            var dataCaja = new DataCaja();
            var respuesta1 = await cajaDA.ListarCuadreCaja(request);
            var respuesta2 = await cajaDA.ListarResumenUsuario(request);
            var respuesta3 = await cajaDA.ListarResumenFormaPago(request);
            request.pagina = 0;
            request.tamanoPagina = 0;
            var respuestaTotal = await cajaDA.GetTotalCuadreCaja(request);
            if ((respuesta1 != null && respuesta1.Codigo == 0) && (respuesta2 != null && respuesta2.Codigo == 0) && (respuesta3 != null && respuesta3.Codigo == 0) && (respuestaTotal != null && respuestaTotal.Codigo == 0))
            {
                dataCaja.Registros1 = respuesta1.Data;
                dataCaja.Registros2 = respuesta2.Data;
                dataCaja.Registros3 = respuesta3.Data;
                dataCaja.TotalRegistros = respuestaTotal.Data;
                return new Respuesta<DataCaja>(0, "", dataCaja);
            }
            else
            {
                return new Respuesta<DataCaja>(-1, "Ocurrió un error al listar el detalle de caja.", null);
            }
        }
        #endregion

    }
}
