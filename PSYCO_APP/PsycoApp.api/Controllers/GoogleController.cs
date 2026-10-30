using System;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using PsycoApp.api.Security;
using PsycoApp.DA;
using PsycoApp.entities;

namespace PsycoApp.api.Controllers
{
    [ApiController, Route("api/google")]
    public class GoogleController : ControllerBase
    {
        private readonly GoogleIdentityValidator validator;
        private readonly IConfiguration configuration;
        private readonly PsycoApp.api.Services.WelcomeEmail welcomeEmail;
        private readonly GoogleIdentityDA identities = new();
        public GoogleController(GoogleIdentityValidator validator, IConfiguration configuration, PsycoApp.api.Services.WelcomeEmail welcomeEmail)
        { this.validator = validator; this.configuration = configuration; this.welcomeEmail = welcomeEmail; }

        [AllowAnonymous, HttpPost("login")]
        public Task<IActionResult> Login(GoogleCredential request, CancellationToken ct) => Execute(request, async (subject, email) =>
        {
            await Task.CompletedTask;
            var found = identities.Find(subject);
            if (found.HasValue) {
                identities.UpdateEmail(subject, email);
                found.Value.User.email = email;
                return Access(found.Value);
            }
            if (identities.Exists(subject)) return StatusCode(403, "La cuenta o su empresa no están habilitadas.");
            return Ok(new GoogleAccessResult { NeedsRegistration = true });
        }, ct);

        [AllowAnonymous, HttpPost("register")]
        public Task<IActionResult> Register(GoogleRegistration request, CancellationToken ct) => Execute(request, async (subject, email) =>
        {
            await Task.CompletedTask;
            if (string.IsNullOrWhiteSpace(request.Empresa) || string.IsNullOrWhiteSpace(request.Sede) ||
                string.IsNullOrWhiteSpace(request.Nombres) || string.IsNullOrWhiteSpace(request.Apellidos))
                return BadRequest("Completa empresa, sede, nombres y apellidos.");
            identities.Register(subject, request, email);
            await welcomeEmail.Send(email, request.Nombres);
            var found = identities.Find(subject);
            return found.HasValue ? Access(found.Value) : StatusCode(403, "No se pudo habilitar el acceso.");
        }, ct);

        [HttpPost("link")]
        public Task<IActionResult> Link(GoogleCredential request, CancellationToken ct) => Execute(request, async (subject, email) =>
        {
            await Task.CompletedTask;
            if (!int.TryParse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value, out var userId) || userId <= 0)
                return Forbid();
            identities.Link(subject, userId, email);
            return Ok(new { linked = true });
        }, ct);

        private IActionResult Access((Usuario User, string Sede) found) => Ok(new GoogleAccessResult
        {
            User = found.User, Sede = found.Sede,
            Token = JwtTokenIssuer.Create(found.User, configuration)
        });

        private async Task<IActionResult> Execute(GoogleCredential request, Func<string, string, Task<IActionResult>> action, CancellationToken ct)
        {
            if (!validator.Enabled) return StatusCode(503, "El acceso con Google todavía no está disponible.");
            try
            {
                var identity = await validator.Validate(request?.Credential, ct);
                return await action(identity.FindFirst("sub").Value, identity.FindFirst("email").Value);
            }
            catch (SecurityTokenException) { return Unauthorized("No se pudo validar la identidad de Google."); }
            catch (ArgumentException) { return Unauthorized("No se pudo validar la identidad de Google."); }
            catch (SqlException ex) when (ex.Number == 2601 || ex.Number == 2627 || ex.Number == 50202)
            { return Conflict("La identidad o la cuenta ya están vinculadas."); }
            catch (SqlException ex) when (ex.Number == 50201)
            { return StatusCode(403, "La cuenta no está habilitada para vincular Google."); }
            catch (InvalidOperationException) { return StatusCode(503, "No se pudo completar el acceso con Google. Inténtalo nuevamente."); }
            catch (SqlException) { return StatusCode(503, "El acceso con Google no está disponible en este momento."); }
        }
    }
}
