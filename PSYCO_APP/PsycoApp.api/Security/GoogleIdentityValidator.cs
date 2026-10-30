using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using Microsoft.IdentityModel.Tokens;

namespace PsycoApp.api.Security
{
    public class GoogleIdentityValidator
    {
        private readonly IConfiguration configuration;
        private readonly IConfigurationManager<OpenIdConnectConfiguration> metadata;

        public GoogleIdentityValidator(IConfiguration configuration,
            IConfigurationManager<OpenIdConnectConfiguration> metadata = null)
        {
            this.configuration = configuration;
            this.metadata = metadata ?? new ConfigurationManager<OpenIdConnectConfiguration>(
                "https://accounts.google.com/.well-known/openid-configuration",
                new OpenIdConnectConfigurationRetriever());
        }

        public bool Enabled => configuration.GetValue<bool>("Authentication:Google:Enabled") &&
            !string.IsNullOrWhiteSpace(configuration["Authentication:Google:ClientId"]);

        public async Task<ClaimsPrincipal> Validate(string credential, CancellationToken cancellationToken)
        {
            if (!Enabled) throw new InvalidOperationException("Google no está configurado.");
            if (string.IsNullOrWhiteSpace(credential) || credential.Length > 12000)
                throw new SecurityTokenValidationException("Credencial no válida.");
            if (!new JwtSecurityTokenHandler().CanReadToken(credential))
                throw new SecurityTokenValidationException("Credencial no válida.");
            for (var attempt = 0; ; attempt++)
            {
                var config = await metadata.GetConfigurationAsync(cancellationToken);
                try
                {
                    var handler = new JwtSecurityTokenHandler { MapInboundClaims = false };
                    var principal = handler.ValidateToken(credential, new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidIssuers = new[] { "https://accounts.google.com", "accounts.google.com" },
                        ValidateAudience = true,
                        ValidAudience = configuration["Authentication:Google:ClientId"],
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKeys = config.SigningKeys,
                        RequireSignedTokens = true,
                        RequireExpirationTime = true,
                        ValidateLifetime = true,
                        ClockSkew = TimeSpan.FromMinutes(1),
                        ValidAlgorithms = new[] { SecurityAlgorithms.RsaSha256 }
                    }, out _);
                    var subject = principal.FindFirst("sub")?.Value;
                    var email = principal.FindFirst("email")?.Value;
                    if (string.IsNullOrWhiteSpace(email) || email.Length > 100 ||
                        !System.Net.Mail.MailAddress.TryCreate(email, out var address) || address.Address != email)
                        throw new SecurityTokenValidationException("Correo no válido.");
                    if (string.IsNullOrWhiteSpace(subject) || subject.Length > 255 ||
                        !string.Equals(principal.FindFirst("email_verified")?.Value, "true", StringComparison.OrdinalIgnoreCase))
                        throw new SecurityTokenValidationException("Identidad no válida.");
                    return principal;
                }
                catch (SecurityTokenSignatureKeyNotFoundException) when (attempt == 0)
                {
                    metadata.RequestRefresh();
                }
            }
        }
    }
}
