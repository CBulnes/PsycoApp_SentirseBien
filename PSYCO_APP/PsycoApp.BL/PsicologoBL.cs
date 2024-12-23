using PsycoApp.DA;
using PsycoApp.entities;
using System;
using System.Collections.Generic;
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
            return _psicologoDA.ListarPsicologos(pagina, tamanoPagina);
        }

        public void AgregarPsicologo(Psicologo psicologo)
        {
            _psicologoDA.AgregarPsicologo(psicologo);
        }
        public List<Psicologo> BuscarPsicologo(string nombre)
        {
           return _psicologoDA.BuscarPsicologo(nombre);
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

        public List<entities.Sede> listar_sedes_x_usuario_combo(int id_usuario)
        {
            return _psicologoDA.listar_sedes_x_usuario_combo(id_usuario);
        }

        public List<entities.Sede> listar_sedes_combo()
        {
            return _psicologoDA.listar_sedes_combo();
        }

        public List<entities.Horario> horarios_psicologo(int id_psicologo, string inicio, string fin)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            try
            {
                lista = _psicologoDA.horarios_psicologo(id_psicologo, inicio, fin);
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
    }
}
