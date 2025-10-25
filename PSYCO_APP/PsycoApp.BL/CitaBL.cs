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
using PsycoApp.BL.Interfaces;

namespace PsycoApp.BL
{
    public class CitaBL : ICitaBL
    {
        CitaDA citaDA = new CitaDA();
        HistorialDA historialDA = new HistorialDA();

        public RespuestaUsuario registrar_cita(Cita oCita, string main_path, string random_str)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            List<string> errores = new List<string>();
            string error = "";
            try
            {
                if (oCita.fechas_adicionales != null)
                {
                    if (oCita.fechas_adicionales.Count > 0)
                    {
                        oCita.hora_cita = oCita.fechas_adicionales[0].hora;
                        oCita.fecha_cita = oCita.fechas_adicionales[0].fecha;
                    }

                    res_ = citaDA.validar_cita(oCita, "NO", (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0 ? 1 : 0), main_path, random_str);
                    if (!res_.estado)
                    {
                        error = res_.descripcion.Replace(".", ":") + " " + oCita.fecha_cita + " " + oCita.hora_cita;
                        errores.Add(error);
                    }

                    if (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0)
                    {
                        int orden = 1;
                        foreach (var adicional in oCita.fechas_adicionales)
                        {
                            if (orden > 1)
                            {
                                oCita.fecha_cita = adicional.fecha;
                                oCita.hora_cita = adicional.hora;
                                var res2 = citaDA.validar_cita(oCita, "SI", orden, main_path, random_str);
                                if (!res2.estado)
                                {
                                    error = res2.descripcion.Replace(".", ":") + " " + oCita.fecha_cita + " " + oCita.hora_cita;
                                    errores.Add(error);
                                }
                            }
                            orden++;
                        }
                    }
                }

                if (errores.Count == 0)
                {
                    if (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0)
                    {
                        oCita.hora_cita = oCita.fechas_adicionales[0].hora;
                        oCita.fecha_cita = oCita.fechas_adicionales[0].fecha;
                    }

                    res_ = citaDA.registrar_cita(oCita, "NO", (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0 ? 1 : 0), main_path, random_str);
                    //Cuando no hay fechas adicionales estaba arrojando error
                    if (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0)
                    {
                        int orden = 1;
                        foreach (var adicional in oCita.fechas_adicionales)
                        {
                            if (orden > 1)
                            {
                                oCita.fecha_cita = adicional.fecha;
                                oCita.hora_cita = adicional.hora;
                                var res2 = citaDA.registrar_cita(oCita, "SI", orden, main_path, random_str);
                            }
                            orden++;
                        }
                    }
                } else
                {
                    res_.estado = false;
                    res_.descripcion = "";
                    foreach (var item in errores)
                    {
                        res_.descripcion += item + "\n";
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

        public RespuestaUsuario actualizar_servicio(int id_cita, int id_servicio)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.actualizar_servicio(id_cita, id_servicio);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al actualizar el servicio.";
            }
            return res_;
        }

        public RespuestaUsuario pago_gratuito(int id_cita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaDA.pago_gratuito(id_cita);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el pago gratuito.";
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
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<HistorialCita> historial_cita(int id_cita)
        {
            List<HistorialCita> lista = new List<HistorialCita>();
            try
            {
                lista = historialDA.listar_historial_cita(id_cita);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        public List<HistorialPaciente> historial_paciente(int id_paciente)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            try
            {
                lista = historialDA.listar_historial_paciente(id_paciente);
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

        public List<Cita> citas_doctor(string usuario, string inicio, string fin, int id_estado, int id_doctor, int ver_sin_reserva)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaDA.citas_doctor(usuario, inicio, fin, id_estado, id_doctor, ver_sin_reserva);
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
