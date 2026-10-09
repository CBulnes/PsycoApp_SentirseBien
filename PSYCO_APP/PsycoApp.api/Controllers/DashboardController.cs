using Microsoft.AspNetCore.Mvc;
using PsycoApp.api.Security;
using PsycoApp.BL;
using PsycoApp.entities;
using System;
using System.Security.Claims;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DashboardController : ControllerBase
    {
        private readonly DashboardBL dashboardBL = new DashboardBL();

        [HttpGet("resumen")]
        public ActionResult<DashboardData> Resumen()
        {
            var rol = User.FindFirst(ClaimTypes.Role)?.Value;
            if (!int.TryParse(rol, out var tipoUsuario) || (tipoUsuario != 1 && tipoUsuario != 3 && tipoUsuario != 4))
                return Forbid();
            if (!TenantContext.TryGetIntClaim(User, ClaimTypes.NameIdentifier, out var idUsuario) || idUsuario <= 0 ||
                !TenantContext.TryGetIntClaim(User, "id_sede", out var idSede) || idSede <= 0)
                return Forbid();

            var idDoctor = tipoUsuario == 4 && TenantContext.TryGetIntClaim(User, "id_psicologo", out var doctorClaim) ? doctorClaim : -1;

            // The dashboard and caja use the Peru business clock (SQL dbo.Get_date()).
            // Convert UTC to the Windows timezone so DST rules are applied correctly.
            var zonaPeru = TimeZoneInfo.FindSystemTimeZoneById("SA Pacific Standard Time");
            var ahoraLocal = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, zonaPeru);
            var hoy = ahoraLocal.Date;
            var diasDesdeLunes = ((int)hoy.DayOfWeek + 6) % 7;
            var inicioSemana = hoy.AddDays(-diasDesdeLunes);
            var finSemana = inicioSemana.AddDays(6);
            var login = User.FindFirst("login")?.Value ?? User.FindFirst(ClaimTypes.Name)?.Value ?? string.Empty;

            try
            {
                return Ok(dashboardBL.Obtener(inicioSemana, finSemana, ahoraLocal, idSede, idUsuario, idDoctor, tipoUsuario, login));
            }
            catch (ArgumentException)
            {
                return Forbid();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "No fue posible cargar el dashboard.", detail = ex.Message });
            }
        }
    }
}