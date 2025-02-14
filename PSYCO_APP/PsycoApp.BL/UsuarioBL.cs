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
         
            return usuario;
        }

        public Usuario actualizar_contraseña(Usuario usuario)
        {
            return _usuarioDA.actualizar_contraseña(usuario);
        }

    }
}
