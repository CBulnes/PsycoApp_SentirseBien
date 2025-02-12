using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.DA.Interfaces;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.entities.DTO.DtoRequest;
using PsycoApp.utilities;

namespace PsycoApp.BL
{
    public class UsuarioBL : IUsuarioLogin
    {
        private readonly IMapper _mapper;
        private readonly IUsuarioDA _usuarioDA;
        private readonly string _key = "PsycoAppSuperSecureKey2024!!$$%%@@";
        public UsuarioBL(IMapper mapper, IUsuarioDA usuarioDA)
        {
            _mapper = mapper;
            _usuarioDA = usuarioDA;
        }


        public Usuario validar_usuario(UsuarioLoginDto usuarioDTO)
        {
            
            var usuario = _usuarioDA.validar_usuario(usuarioDTO);
            var token = ValidarUsuarioYGenerarToken(usuario);
            usuario.token = token;
            return usuario;
        }

        public string ValidarUsuarioYGenerarToken(Usuario usuario)
        {
            // Claims (datos del usuario dentro del token)
            var claims = new[]
            {
        new Claim(JwtRegisteredClaimNames.Sub, usuario.id_usuario.ToString()),
        new Claim(JwtRegisteredClaimNames.Email, usuario.email),
        new Claim("rol", usuario.tipousuario), // Puedes agregar roles personalizados
        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
    };

            // Clave de seguridad (mínimo 32 caracteres)
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_key));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            // Crear el token
            var token = new JwtSecurityToken(
                issuer: "www.sentirsebien.com",
                audience: "www.sentirsebien.com",
                claims: claims,
                expires: DateTime.UtcNow.AddHours(1), // Expira en 1 hora
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token); // Devuelve el token
        }

        public Usuario actualizar_contraseña(Usuario usuario)
        {
            return _usuarioDA.actualizar_contraseña(usuario);
        }

    }
}
