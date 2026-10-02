using System;
using System.Collections.Generic;
using PsycoApp.DA;
using PsycoApp.entities;

namespace PsycoApp.BL
{
    public class EmpresaSedeBL
    {
        private readonly EmpresaSedeDA _empresaSedeDA = new EmpresaSedeDA();

        public List<Empresa> ListarEmpresas()
        {
            return _empresaSedeDA.ListarEmpresas();
        }

        public int CrearEmpresa(Empresa empresa)
        {
            if (empresa == null || string.IsNullOrWhiteSpace(empresa.Nombre))
                throw new ArgumentException("El nombre de la empresa es obligatorio.");

            empresa.Nombre = empresa.Nombre.Trim();
            return _empresaSedeDA.CrearEmpresa(empresa);
        }

        public List<Sede> ListarSedes(int idEmpresa)
        {
            if (idEmpresa <= 0)
                throw new ArgumentException("La empresa seleccionada no es válida.");

            return _empresaSedeDA.ListarSedes(idEmpresa);
        }

        public int CrearSede(Sede sede)
        {
            if (sede == null || string.IsNullOrWhiteSpace(sede.Nombre))
                throw new ArgumentException("El nombre de la sede es obligatorio.");
            if (sede.IdEmpresa <= 0)
                throw new ArgumentException("La empresa seleccionada no es válida.");

            sede.Nombre = sede.Nombre.Trim();
            sede.Centro = string.IsNullOrWhiteSpace(sede.Centro) ? sede.Nombre : sede.Centro.Trim();
            sede.Estado = true;
            return _empresaSedeDA.CrearSede(sede);
        }

        public int CrearUsuario(UsuarioEmpresa usuario)
        {
            if (usuario == null || string.IsNullOrWhiteSpace(usuario.Nombres)
                || string.IsNullOrWhiteSpace(usuario.Apellidos)
                || string.IsNullOrWhiteSpace(usuario.Usuario)
                || string.IsNullOrWhiteSpace(usuario.Password))
                throw new ArgumentException("Completa nombres, apellidos, usuario y contraseña.");
            if (usuario.IdTipoUsuario != 1 && usuario.IdTipoUsuario != 3)
                throw new ArgumentException("Solo se permiten los roles Administrador y Counter.");
            if (usuario.IdEmpresa <= 0 || usuario.IdSede <= 0)
                throw new ArgumentException("Selecciona una empresa y una sede válidas.");
            if (usuario.Password.Length > 50)
                throw new ArgumentException("La contraseña no puede superar los 50 caracteres.");

            usuario.Nombres = usuario.Nombres.Trim();
            usuario.Apellidos = usuario.Apellidos.Trim();
            usuario.Usuario = usuario.Usuario.Trim();
            usuario.Password = usuario.Password.Trim();
            return _empresaSedeDA.CrearUsuario(usuario);
        }
    }
}
