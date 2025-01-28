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

        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina, int tamanoPagina, int mes, int anio, int sede)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.listar_cuadre_caja(usuario, pagina, tamanoPagina, mes, anio, sede);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<CuadreCaja> resumen_caja_x_usuario(string usuario, int mes, int año, int sede)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.resumen_caja_x_usuario(usuario, mes, año, sede);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<CuadreCaja> resumen_caja_x_forma_pago(string usuario, int mes, int año, int sede)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            try
            {
                lista = cajaDA.resumen_caja_x_forma_pago(usuario, mes, año, sede);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
