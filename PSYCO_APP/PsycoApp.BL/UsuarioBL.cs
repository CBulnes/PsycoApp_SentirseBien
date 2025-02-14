using System;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using AutoMapper;
using Microsoft.Extensions.Configuration;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA.Interfaces;
using PsycoApp.entities;
using PsycoApp.entities.DTO.DtoRequest;

namespace PsycoApp.BL
{
    public class UsuarioBL : IUsuarioLogin
    {
        private readonly IMapper _mapper;
        private readonly IUsuarioDA _usuarioDA;
        private readonly string _key = "PsycoAppSuperSecureKey2024!!$$%%@@";
        public IConfiguration _configuration;
    
        public UsuarioBL(IConfiguration configuration, IMapper mapper, IUsuarioDA usuarioDA)
        {
            _mapper = mapper;
            _usuarioDA = usuarioDA;
            _configuration = configuration;
        }


        public Usuario validar_usuario(UsuarioLoginDto usuarioDTO)
        {
 
        var usuario = _usuarioDA.validar_usuario(usuarioDTO);
            var token = GenerarToken(usuario.email,usuario.nombres);

            usuario.token = token;

         
            return usuario;
        }


        public string GenerarToken(string Email, string Fullname)
        {

            var claims = new[]
            {
                new Claim("email", Email),
                new Claim("fullName", Fullname)
            };
            var llave = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes("MiSuperClaveSeguraDeAlMenos32Caracteres!"));


            var credentials = new SigningCredentials(llave, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: null,
                audience: null,
                claims,
                   expires: DateTime.Now.AddHours(10),
                signingCredentials: credentials
                );

            return new JwtSecurityTokenHandler().WriteToken(token);

        }
        public string ValidarUsuarioYGenerarToken(Usuario usuario)
        {
            
            var tokenHandler = new JwtSecurityTokenHandler(); // Generalmente, issuer y audience son iguales
            var bitkey =Encoding.UTF8.GetBytes(_key);
            var tokenDes = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, usuario.email),
                    new Claim(ClaimTypes.Role, usuario.tipousuario),
                    new Claim(ClaimTypes.NameIdentifier, usuario.id_usuario.ToString())
                }),
                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(bitkey),
                                                            SecurityAlgorithms.HmacSha256Signature)

            };

            var token = tokenHandler.CreateToken(tokenDes);


            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public Usuario actualizar_contraseña(Usuario usuario)
        {
            return _usuarioDA.actualizar_contraseña(usuario);
        }

    }
}
