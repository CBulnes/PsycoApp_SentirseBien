using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using PsycoApp.entities;

namespace PsycoApp.api.Security
{
    public static class JwtTokenIssuer
    {
        public static string Create(Usuario usuario, IConfiguration configuration)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, usuario.id_usuario.ToString()),
                new Claim(ClaimTypes.Name, usuario.email ?? string.Empty),
                new Claim("login", usuario.login ?? string.Empty),
                new Claim(ClaimTypes.Role, usuario.id_tipousuario.ToString()),
                new Claim("id_tipousuario", usuario.id_tipousuario.ToString()),
                new Claim("id_sede", usuario.id_sede.ToString()),
                new Claim("id_empresa", usuario.id_empresa.ToString())
            };
            var credentials = new SigningCredentials(
                new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"])), SecurityAlgorithms.HmacSha256);
            var minutes = int.TryParse(configuration["Jwt:ExpirationMinutes"], out var value) ? value : 120;
            return new JwtSecurityTokenHandler().WriteToken(new JwtSecurityToken(
                issuer: configuration["Jwt:Issuer"], audience: configuration["Jwt:Audience"],
                claims: claims, expires: DateTime.UtcNow.AddMinutes(minutes), signingCredentials: credentials));
        }
    }
}
