using PsycoApp.DA;
using PsycoApp.entities;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Text;

namespace PsycoApp.BL
{
    public class PsicologoBL
    {
        private readonly PsicologoDA _psicologoDA;

        public PsicologoBL()
        {
            _psicologoDA = new PsicologoDA();
        }

        public List<Psicologo> ListarPsicologos(int pagina, int tamanoPagina)
        {
            var list = _psicologoDA.ListarPsicologos(pagina, tamanoPagina);
            //list.ForEach(x => {
            //    var sedes = _psicologoDA.listar_sedes_x_usuario_combo(x.Id);
            //    x.Sedes = sedes.Count == 0 ? "---" : (sedes.Count == 1 ? sedes[0].Nombre : (string.Concat(sedes[0].Nombre, "/", sedes[1].Nombre)));
            //    if (sedes.Count >= 1)
            //    {
            //        x.IdSedePrincipal = sedes[0].Id;
            //        x.IdSedeSecundaria = sedes.Count == 2 ? sedes[1].Id : 0;
            //    }
            //});
            return list;
        }

        public List<Psicologo> ListarPsicologos(int pagina, int tamanoPagina, int idEmpresa)
        {
            if (idEmpresa <= 0)
                throw new ArgumentException("La empresa es obligatoria.", nameof(idEmpresa));

            return _psicologoDA.ListarPsicologosPorEmpresa(pagina, tamanoPagina, idEmpresa);
        }

        public List<Psicologo> ListarPsicologos(int pagina, int tamanoPagina, int idEmpresa, int idSede)
        {
            if (idEmpresa <= 0 || idSede <= 0)
                throw new ArgumentException("La empresa y la sede son obligatorias.");

            return _psicologoDA.ListarPsicologosPorEmpresa(pagina, tamanoPagina, idEmpresa, idSede);
        }

        public void AgregarPsicologo(Psicologo psicologo)
        {
            _psicologoDA.AgregarPsicologo(psicologo);
        }

        public void GuardarCredencialesPsicologo(int idPsicologo, int idSede, string email, string password)
        {
            if (idPsicologo <= 0 || idSede <= 0 || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
                throw new ArgumentException("Ingrese un usuario y contraseña válidos.");

            if (!System.Text.RegularExpressions.Regex.IsMatch(email.Trim(), @"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+$"))
                throw new ArgumentException("El usuario debe contener solo letras, sin @ ni espacios.");

            _psicologoDA.GuardarCredencialesPsicologo(idPsicologo, idSede, email.Trim(), password);
        }

        public Usuario ObtenerCredencialesPsicologo(int idPsicologo, int idSede)
        {
            if (idPsicologo <= 0 || idSede <= 0)
                throw new ArgumentException("El especialista seleccionado no es válido.");

            return _psicologoDA.ObtenerCredencialesPsicologo(idPsicologo, idSede);
        }

        public void ActualizarPasswordPsicologo(int idPsicologo, int idSede, string password)
        {
            if (idPsicologo <= 0 || idSede <= 0 || string.IsNullOrWhiteSpace(password))
                throw new ArgumentException("Ingrese una contraseña válida.");

            _psicologoDA.ActualizarPasswordPsicologo(idPsicologo, idSede, password);
        }

        public List<Psicologo> BuscarPsicologo(string nombre)
        {
            var list = _psicologoDA.BuscarPsicologo(nombre);
            //list.ForEach(x => {
            //    var sedes = _psicologoDA.listar_sedes_x_usuario_combo(x.Id);
            //    x.Sedes = sedes.Count == 0 ? "---" : (sedes.Count == 1 ? sedes[0].Nombre : (string.Concat(sedes[0].Nombre, "/", sedes[1].Nombre)));
            //    if (sedes.Count >= 1)
            //    {
            //        x.IdSedePrincipal = sedes[0].Id;
            //        x.IdSedeSecundaria = sedes.Count == 2 ? sedes[1].Id : 0;
            //    }
            //});
            return list;
        }

        public List<Psicologo> BuscarPsicologo(string nombre, int idEmpresa)
        {
            if (idEmpresa <= 0)
                throw new ArgumentException("La empresa es obligatoria.", nameof(idEmpresa));

            return _psicologoDA.BuscarPsicologoPorEmpresa(nombre, idEmpresa);
        }

        public List<Psicologo> BuscarPsicologo(string nombre, int idEmpresa, int idSede)
        {
            if (idEmpresa <= 0 || idSede <= 0)
                throw new ArgumentException("La empresa y la sede son obligatorias.");

            return _psicologoDA.BuscarPsicologoPorEmpresa(nombre, idEmpresa, idSede);
        }
        
        public Psicologo BuscarPsicologoId(int id)
        {
            Psicologo psicologo = _psicologoDA.BuscarPsicologoId(id);
            var estudios = _psicologoDA.BuscarEstudiosPsicologo(id);
            var emptyEstudios = new List<Estudio>() { new Estudio() { Id = 0, IdPsicologo = psicologo.Id, GradoAcademico = -1, Institucion = -1, Carrera = -1 } };
            psicologo.Estudios = estudios.Count > 0 ? estudios : emptyEstudios;
            return psicologo;
        }

        public void ActualizarPsicologo(Psicologo psicologo)
        {
            _psicologoDA.ActualizarPsicologo(psicologo);
        }

        public void EliminarPsicologo(int id)
        {
            _psicologoDA.EliminarPsicologo(id);
        }

        public List<entities.Psicologo> listar_psicologos_combo()
        {
            return _psicologoDA.listar_psicologos_combo();
        }

        public List<entities.Usuario> listar_usuarios_caja_combo(int idEmpresa, int idSede)
        {
            if (idEmpresa <= 0 || idSede == 0 || idSede < -1)
                throw new ArgumentException("La empresa o sede seleccionada no es válida.");

            return _psicologoDA.listar_usuarios_caja_combo(idEmpresa, idSede);
        }

        public List<entities.Sede> listar_sedes_x_usuario_combo(int id_usuario)
        {
            return _psicologoDA.listar_sedes_x_usuario_combo(id_usuario);
        }

        public List<entities.Sede> listar_sedes_combo()
        {
            return _psicologoDA.listar_sedes_combo();
        }

        public List<entities.Horario> horarios_psicologo(int id_psicologo, string inicio, string fin, string dias)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            try
            {
                lista = _psicologoDA.horarios_psicologo(id_psicologo, inicio, fin, dias);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<entities.Horario> vacaciones_psicologo(int id_psicologo, string inicio, string fin, int año)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            try
            {
                lista = _psicologoDA.vacaciones_psicologo(id_psicologo, inicio, fin, año);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public RespuestaUsuario guardar_horarios_psicologo(List<entities.Horario> lista)
        {
            var res = new RespuestaUsuario();
            try
            {
                foreach (var item in lista)
                {
                    res = _psicologoDA.guardar_horarios_psicologo_v2(item);
                }
            }
            catch (Exception)
            {
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar los horarios.";
            }
            return res;
        }

        public RespuestaUsuario guardar_vacaciones_psicologo(List<entities.Horario> lista)
        {
            var res = new RespuestaUsuario();
            try
            {
                int i = 0;
                foreach (var item in lista)
                {
                    res = _psicologoDA.guardar_vacaciones_psicologo(item, (i == 0 ? 0 : (lista.Where(x => x.Eliminar == 1).ToList().Count)));
                    i++;
                }
            }
            catch (Exception)
            {
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar las vacaciones.";
            }
            return res;
        }
    }
}
