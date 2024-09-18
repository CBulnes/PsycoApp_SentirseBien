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

        public List<Psicologo> ListarPsicologos()
        {
            return _psicologoDA.ListarPsicologos();
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
    }
}
