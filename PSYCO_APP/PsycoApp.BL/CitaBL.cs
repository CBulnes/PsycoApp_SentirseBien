using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;

namespace PsycoApp.BL
{
    public class CitaBL
    {
        CitaDA citaDA = new CitaDA();
        HistorialDA historialDA = new HistorialDA();

        public RespuestaUsuario registrar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.registrar_cita(oCita, "NO", main_path, random_str);
                //Cuando no hay fechas adicionales estaba arrojando error
                if (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0)
                {
                    foreach (var fecha in oCita.fechas_adicionales)
                    {
                        oCita.fecha_cita = fecha;
                        var res2 = citaDA.registrar_cita(oCita, "SI", main_path, random_str);
                    }
                }
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            return res_;
        }

        public RespuestaUsuario confirmar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.confirmar_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al confirmar la cita.";
            }
            return res_;
        }

        public RespuestaUsuario atender_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.atender_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al atender la cita.";
            }
            return res_;
        }

        public RespuestaUsuario cancelar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.cancelar_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al cancelar la cita.";
            }
            return res_;
        }

        public RespuestaUsuario registrar_cuestionario(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.registrar_cuestionario(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            return res_;
        }

        public List<Cita> disponibilidad_doctor(int id_doctor, string fecha, string main_path, string random_str)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaDA.disponibilidad_doctor(id_doctor, fecha, main_path, random_str);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<Cita> citas_usuario(int id_usuario, int id_paciente, int id_doctor, int id_sede, string main_path, string random_str)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaDA.citas_usuario(id_usuario, id_paciente, id_doctor, id_sede, main_path, random_str);
                lista.ForEach(item =>
                {
                    item.historial = historialDA.listar_historial_cita(item.id_cita);
                });
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<Cita> horarios_doctor(string inicio, string fin, int id_doctor)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaDA.horarios_doctor(inicio, fin, id_doctor);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<Cita> citas_doctor(string usuario, string fecha, int id_estado, int ver_sin_reserva)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaDA.citas_doctor(usuario, fecha, id_estado, ver_sin_reserva);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<entities.Semana> dias_x_semana_mes(int semana, int mes, int año)
        {
            List<entities.Semana> lista = new List<entities.Semana>();
            try
            {
                lista = citaDA.dias_x_semana_mes(semana, mes, año);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
