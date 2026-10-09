using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using PsycoApp.entities;
using PsycoApp.utilities;
using PsycoApp.api.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CajaController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public CajaController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        CajaBL cajaBL = new CajaBL();
        CitaBL citaBL = new CitaBL();
        RandomUtilities ru = new RandomUtilities();

        string res = "";
        string random_str = "";

        private bool TryGetTenantSede(out int idSede)
        {
            if (TenantContext.IsGlobalAdministrator(User))
            {
                idSede = 0;
                return true;
            }

            return TenantContext.TryGetIntClaim(User, "id_sede", out idSede) && idSede > 0;
        }

        private bool PuedeAccederCaja()
        {
            return TenantContext.IsGlobalAdministrator(User) ||
                TenantContext.IsCompanyAdministrator(User) || User.IsInRole("3");
        }

        private bool CitaAccesible(int? idCita, int idSede)
        {
            return idCita.HasValue && idCita.Value > 0 && citaBL.CitaPerteneceASede(idCita.Value, idSede);
        }

        private RespuestaUsuario ErrorTenant(string mensaje)
        {
            return new RespuestaUsuario { estado = false, descripcion = mensaje };
        }

        private int ObtenerFiltroUsuario(int usuarioSolicitado)
        {
            if (TenantContext.IsGlobalAdministrator(User) || !User.IsInRole("3"))
                return TenantContext.IsGlobalAdministrator(User) ? usuarioSolicitado : -1;

            return TenantContext.TryGetIntClaim(User, System.Security.Claims.ClaimTypes.NameIdentifier, out var usuarioId)
                ? usuarioId
                : -1;
        }

        [HttpPost("deshacer_pago")]
        public async Task<RespuestaUsuario> DeshacerPago([FromBody] Pago request)
        {
            if (request == null || !TenantContext.IsGlobalAdministrator(User))
                return ErrorTenant("Solo el administrador global puede anular pagos mientras no se valide la caja de origen.");
            return await cajaBL.DeshacerPago(request);
        }

        [HttpPost("registrar_pago")]
        public RespuestaUsuario RegistrarPago([FromBody] Pago oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            if (!PuedeAccederCaja() || oPago == null || !oPago.id_cita.HasValue || oPago.id_cita <= 0 ||
                !oPago.importe.HasValue || oPago.importe <= 0 || !oPago.id_forma_pago.HasValue || oPago.id_forma_pago <= 0 ||
                !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && (!CitaAccesible(oPago.id_cita, sede) || oPago.idSede.HasValue && oPago.idSede.Value > 0 && oPago.idSede.Value != sede))
                return ErrorTenant("La cita no pertenece a la sede autorizada.");
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                oPago.idSede = sede;
                oPago.usuario = User.Identity.Name;
            }
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = cajaBL.registrar_pago(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el pago";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("registrar_pago_masivo")]
        public RespuestaUsuario RegistrarPagoMasivo([FromBody] PagoMasivo oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            if (!PuedeAccederCaja() || oPago == null || oPago.pagosEnviar == null || oPago.pagosEnviar.Count == 0 ||
                !oPago.id_forma_pago.HasValue || oPago.id_forma_pago <= 0 ||
                oPago.pagosEnviar.Any(p => p == null || !p.idCita.HasValue || p.idCita <= 0 || !p.totalPagar.HasValue || p.totalPagar <= 0) ||
                !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && (oPago.idSede.HasValue && oPago.idSede.Value > 0 && oPago.idSede.Value != sede ||
                oPago.pagosEnviar.Any(p => p == null || !CitaAccesible(p.idCita, sede))))
                return ErrorTenant("Una o más citas no pertenecen a la sede autorizada.");
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                oPago.idSede = sede;
                oPago.usuario = User.Identity.Name;
            }
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = cajaBL.registrar_pago_masivo(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar los pagos";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("registrar_descuento")]
        public RespuestaUsuario RegistrarDescuento([FromBody] Pago oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            if (!PuedeAccederCaja() || oPago == null || !oPago.id_cita.HasValue || oPago.id_cita <= 0 ||
                !oPago.importe.HasValue || oPago.importe <= 0 || !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && !CitaAccesible(oPago.id_cita, sede))
                return ErrorTenant("La cita no pertenece a la sede autorizada.");
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = cajaBL.registrar_descuento(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el descuento";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("registrar_efectivo")]
        public RespuestaUsuario registrar_efectivo([FromBody] EfectivoDiario oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            if (!PuedeAccederCaja() || oPago == null || oPago.importe <= 0 ||
                !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && oPago.id_sede != sede)
                return ErrorTenant("La sede del movimiento no está autorizada.");
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                oPago.id_sede = sede;
                oPago.usuario = User.Identity.Name;
            }
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = cajaBL.registrar_efectivo(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el efectivo";
                res_.estado = false;
            }
            return res_;
        }

        [HttpGet("listar_pagos_pendientes/{id_paciente}")]
        public List<PagosPendientes> listar_pagos_pendientes(int id_paciente)
        {
            List<PagosPendientes> lista = new List<PagosPendientes>();
            if (!PuedeAccederCaja() || id_paciente <= 0 || !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && !citaBL.PacientePerteneceASede(id_paciente, sede))
                return lista;
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_pagos_pendientes(id_paciente);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_cuadre_caja/{usuario}/{pagina}/{tamanoPagina}/{fecha}/{buscar_por}/{sede}/{id_usuario}/{id_cita}/{id_caja}")]
        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina = 1, int tamanoPagina = 100, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1, int id_cita = 0, int id_caja = 0)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            if (!PuedeAccederCaja() || !TryGetTenantSede(out var tenantSede) || !TenantContext.IsGlobalAdministrator(User) &&
                (sede > 0 && sede != tenantSede || id_cita > 0 && !CitaAccesible(id_cita, tenantSede) || id_caja > 0))
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                sede = tenantSede;
                id_usuario = ObtenerFiltroUsuario(id_usuario);
                usuario = User.Identity.Name;
            }
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_cuadre_caja(usuario, pagina, tamanoPagina, fecha, buscar_por, sede, id_usuario, id_cita, id_caja);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("resumen_caja_x_usuario/{usuario}/{fecha}/{buscar_por}/{sede}/{id_usuario}")]
        public List<CuadreCaja> resumen_caja_x_usuario(string usuario, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            if (!PuedeAccederCaja() || !TryGetTenantSede(out var tenantSede) || !TenantContext.IsGlobalAdministrator(User) && sede > 0 && sede != tenantSede)
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                sede = tenantSede;
                id_usuario = ObtenerFiltroUsuario(id_usuario);
                usuario = User.Identity.Name;
            }
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.resumen_caja_x_usuario(usuario, fecha, buscar_por, sede, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("resumen_caja_x_forma_pago/{usuario}/{fecha}/{buscar_por}/{sede}/{id_usuario}")]
        public List<CuadreCaja> resumen_caja_x_forma_pago(string usuario, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            if (!PuedeAccederCaja() || !TryGetTenantSede(out var tenantSede) || !TenantContext.IsGlobalAdministrator(User) && sede > 0 && sede != tenantSede)
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                sede = tenantSede;
                id_usuario = ObtenerFiltroUsuario(id_usuario);
                usuario = User.Identity.Name;
            }
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.resumen_caja_x_forma_pago(usuario, fecha, buscar_por, sede, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_efectivo_diario/{usuario}/{fecha}/{idSede}/{buscarPor}/{id_usuario}")]
        public List<ListaEfectivoDiario> listar_efectivo_diario(string usuario, DateTime fecha, int idSede, int buscarPor, int id_usuario)
        {
            List<ListaEfectivoDiario> lista = new List<ListaEfectivoDiario>();
            if (!PuedeAccederCaja() || !TryGetTenantSede(out var tenantSede) || !TenantContext.IsGlobalAdministrator(User) && idSede > 0 && idSede != tenantSede)
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                idSede = tenantSede;
                id_usuario = ObtenerFiltroUsuario(id_usuario);
                usuario = User.Identity.Name;
            }
            try
            {
                lista = cajaBL.listar_efectivo_diario(usuario, fecha,  idSede, buscarPor, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        #region caja_nuevo
        [HttpPost("aperturar_caja")]
        public async Task<RespuestaUsuario> aperturar_caja([FromBody] CajaNuevo request)
        {
            if (!PuedeAccederCaja() || request == null || !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && request.idSede != sede)
                return ErrorTenant("La sede de la caja no está autorizada.");
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                request.idSede = sede;
                request.usuario = User.Identity.Name;
            }
            return await cajaBL.aperturar_caja(request);
        }
        [HttpPost("cerrar_caja")]
        public async Task<RespuestaUsuario> cerrar_caja([FromBody] CajaNuevo request)
        {
            if (!PuedeAccederCaja() || request == null || !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) && request.idSede != sede)
                return ErrorTenant("La sede de la caja no está autorizada.");
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                request.idSede = sede;
                request.usuario = User.Identity.Name;
            }
            return await cajaBL.cerrar_caja(request);
        }
        #endregion


        [HttpGet("listar_cajas/{usuario}/{fecha}")]
        public List<CajasUsuario> listar_cajas(string usuario, DateTime fecha)
        {
            List<CajasUsuario> lista = new List<CajasUsuario>();
            if (!TryGetTenantSede(out _) || !(TenantContext.IsGlobalAdministrator(User) || User.IsInRole("3")))
                return lista;
            if (User.IsInRole("3"))
                usuario = User.Identity.Name;
            if (string.IsNullOrWhiteSpace(usuario) && !TenantContext.IsCompanyAdministrator(User) && !TenantContext.IsGlobalAdministrator(User))
                return lista;
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_cajas(usuario, fecha);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
