using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using static PsycoApp.utilities.Endpoints;

namespace PsycoApp.BL.Interfaces
{
    public interface ICajaBL
    {
        RespuestaUsuario registrar_pago(Pago oPago, string main_path, string random_str);
        List<PagosPendientes> listar_pagos_pendientes(int id_paciente);
        List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina, int tamanoPagina, string fecha, int buscar_por, int sede, int id_usuario, int id_cita = 0);
        List<ResumenCajaUsuario> resumen_caja_x_usuario(string usuario, string fecha, int buscar_por, int sede, int id_usuario);
        List<ResumenCajaFormaPago> resumen_caja_x_forma_pago(string usuario, string fecha, int buscar_por, int sede, int id_usuario);
        #region "version react"
        Task<Respuesta<DataCaja>> GetList(ListCajaDto request);
        #endregion
    }
}