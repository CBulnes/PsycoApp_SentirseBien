using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL.Interfaces
{
    public interface ICitaBL
    {
        RespuestaUsuario registrar_cita(Cita oCita, string main_path, string random_str);
        RespuestaUsuario confirmar_cita(Cita oCita, string main_path, string random_str);
        RespuestaUsuario atender_cita(Cita oCita, string main_path, string random_str);
        RespuestaUsuario cancelar_cita(Cita oCita, string main_path, string random_str);
        RespuestaUsuario actualizar_servicio(int id_cita, int id_servicio);
        RespuestaUsuario pago_gratuito(int id_cita);
        RespuestaUsuario registrar_cuestionario(Cita oCita, string main_path, string random_str);
        List<Cita> disponibilidad_doctor(int id_doctor, string fecha, string main_path, string random_str);
        List<Cita> citas_usuario(int id_usuario, int id_paciente, int id_doctor, int id_sede, string main_path, string random_str);
        List<HistorialCita> historial_cita(int id_cita);
        List<HistorialPaciente> historial_paciente(int id_paciente);
        List<Cita> horarios_doctor(string inicio, string fin, int id_doctor);
        List<Cita> citas_doctor(string usuario, string inicio, string fin, int id_estado, int id_doctor, int ver_sin_reserva);
        List<entities.Semana> dias_x_semana_mes(int semana, int mes, int año);
    }
}