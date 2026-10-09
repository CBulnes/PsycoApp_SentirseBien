using PsycoApp.DA;
using PsycoApp.entities;
using System;

namespace PsycoApp.BL
{
    public class DashboardBL
    {
        private readonly DashboardDA dashboardDA = new DashboardDA();

        public DashboardData Obtener(DateTime inicioSemana, DateTime finSemana, DateTime ahoraLocal, int idSede, int idUsuario, int idDoctor, int tipoUsuario, string login)
        {
            if (idSede <= 0 || idUsuario <= 0 || tipoUsuario != 1 && tipoUsuario != 3 && tipoUsuario != 4)
                throw new ArgumentException("El contexto de usuario o sede del dashboard no es válido.");

            var data = dashboardDA.Obtener(inicioSemana, finSemana, ahoraLocal, idSede, idUsuario, idDoctor, tipoUsuario, login);
            if (tipoUsuario == 4)
            {
                data.CajaAbierta = false;
                data.EstadoCaja = string.Empty;
            }
            if (tipoUsuario == 4)
            {
                data.IngresosHoy = 0;
                data.IngresosPorFormaPago.Clear();
                data.ActividadReciente.Clear();
            }
            if (tipoUsuario == 3)
            {
                data.EstadoCaja = data.CajaAbierta ? "Abierta" : "Cerrada";
            }
            return data;
        }
    }
}
