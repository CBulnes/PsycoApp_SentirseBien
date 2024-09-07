var path = ruta;

var lista_citas = [];
var id_cita_ = 0;
var estado_ = '';

var person_img = path + '/images/user.png';

function cargar_citas() {
    $.ajax({
        url: '/RegistroCitas/CitasUsuario',
        type: "GET",
        data: {},
        success: function (data) {
            lista_citas = data;
        },
        error: function (response) {
            alertSecondary("Mensaje", "Ocurrió un error al obtener su registro de citas.");
            lista_citas = [];
        },
        complete: function () {
            $("#my-calendar").zabuto_calendar({
                legend: []
            });

            validar_cambio_fecha();
        }
    });

    //lista_citas = [
    //    { 'estado': 'PENDIENTE', 'fecha_cita': '2022-08-15', 'doctor_asignado': 'Doctor1', 'hora_cita': '13:00PM', 'id_doctor_asignado': 2, 'id_cita': 1 }
    //];

    //$("#my-calendar").zabuto_calendar({
    //    legend: []
    //});
}
cargar_citas();

function validar_cambio_fecha() {
    $('#txtFechaReasignar').on('change', function () {
        $('#txtHora').val('').attr('data-hora', '');
        disponibilidad_reasignar_doctor();
    })
}

function ver_cita(e) {
    var id_cita = $(e).attr('data-id-cita');
    var id_especialista = $(e).attr('data-id-especialista');
    var hora_Cita = $(e).attr('data-hora-cita');
    var estado = $(e).attr('data-estado');
    var fecha_cita = $(e).attr('data-fecha-cita');

    cargar_datos_cita(id_cita, id_especialista, fecha_cita, hora_Cita, estado);
}

function ver_cuestionario(e) {
    var cuestionario = $(e).attr('data-id-cuestionario');
    var idCita = $(e).attr('data-id-cita');
    var estado = $(e).attr('data-estado');

    //if (cuestionario == 2) {

        if (estado == 'ATENDIDO') {
            alerta('El cuestionario seleccionado ya se ha aperturado', 'info');
            return;
        }

        var data_ = {
            id_historial: 0,
            id_paciente: 0,
            nota: '',
            recomendacion: '',
            medicina: '',
            id_doctor: 0,
            doctor: '',
            fecha_registro: '',
            hora_registro: '',
            id_cita: idCita
        };

        $.ajax({
            url: "/HistorialCitas/RegistrarEstadoCuestionario",
            type: "POST",
            data: data_,
            success: function (data) {
                if (data.estado) {
                    cuestionario = 'Cuestionario2';

                    $(e).attr('data-estado', 'ATENDIDO');

                    $('#txtMessage').val(cuestionario);
                    enviar_consulta();

                    $('#ChatButton').trigger('click');
                } else {
                    /*alertWarning("Atención", data.message);*/
                    alerta(data.descripcion, 'info');
                    //$("#load_data").hide();
                }
            },
            error: function (response) {
                /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
                alerta("Ocurrió un error atendiendo su solicitud.", 'info');
                //$("#load_data").hide();
            },
            complete: function () {
            }
        });
    //}
}

function cargar_datos_cita(id_cita, id_doctor, fecha, hora, estado) {

    $('#txtFecha').attr('data-fecha', fecha);
    $('#txtFecha').val(fecha_formato_ddmmyyyy(fecha));
    $('#txtHora').val(hora).attr('data-hora', hora);
    $('#cboDoctor').val(id_doctor).attr('data-id-doctor', id_doctor);//.change();

    if (id_cita == 0) {
        $('#txtFechaReasignar').val('');
        $('#divReasignar').hide();
    } else {
        $('#txtFechaReasignar').val(fecha);
        $('#divReasignar').show();
    }

    estado_ = estado;
    id_cita_ = id_cita;

    verificar_disponibilidad();
}

function cargar_lista_doctores() {
    var html = '';
    $.ajax({
        url: "/RegistroCitas/listar_doctores",
        type: "GET",
        data: {},
        async: false,
        beforeSend: function () {
            html += '<option value="-1">Seleccionar</option>';
        },
        success: function (data) {
            for (var item of data) {
                html += '<option value="' + item.id_usuario + '">' + item.nombres + '</option>';
            }
        },
        error: function (response) {
            html = '<option value="-1">Seleccionar</option>';
        },
        complete: function () {
            $('#cboDoctor').html(html);
        }
    });
}
cargar_lista_doctores();

function cerrar_modal_cita() {
    $('#mdl_cita').modal('hide');
}

$('#dtpicker1').datetimepicker({
    format: 'hh:00 A'
});

function guardar_cita() {
    var fecha = $('#txtFecha').attr('data-fecha');
    var fecha_r = $('#txtFechaReasignar').val();
    if (fecha_r != '') {
        fecha = fecha_r;
    }
    var hora = $('#txtHora').val();
    var doctor = $('#cboDoctor').val();

    if (hora == '') {
        /*alertSecondary("Mensaje", "Seleccione la hora para el registro de la cita.");*/
        alerta("Seleccione la hora para el registro de la cita.", 'info');
        return;
    }

    if (doctor == '-1') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        alerta("Seleccione el especialista.", 'info');
        return;
    }

    var data_ = {
        id_cita: id_cita_,
        id_usuario: 0,
        estado_cita: 0,
        fecha_cita: fecha,
        hora_cita: hora,
        id_doctor_asignado: doctor
    };

    $.ajax({
        url: "/RegistroCitas/RegistrarCita",
        type: "POST", //(idRegistro > 0 ? "PUT" : "POST"),
        data: data_,
        success: function (data) {
            console.log(data);
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                alerta("Cita guardada exitosamente.", 'info');
                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor').val('-1');
                $('#mdl_cita').modal('hide');

                $('.calendar-container').html('<div id="my-calendar"></div>');
                cargar_citas();
            } else {
                /*alertWarning("Atención", data.message);*/
                alerta(data.descripcion, 'info');
                //$("#load_data").hide();
            }
        },
        error: function (response) {
            /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
            alerta("Ocurrió un error al guardar la cita.", 'info');
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function validateHhMm(e) {
    var isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test(e.value);

    if (isValid) {
    } else {
        alerta("El formato de hora ingresada es incorrecto.", 'info');
    }
}

function verificar_disponibilidad() {
    if ($('#divReasignar').is(':visible')) {
        disponibilidad_reasignar_doctor();
    } else {
        disponibilidad_doctor();
    }

    var id_doc = $('#cboDoctor').val();
    var id_doc_ant = $('#cboDoctor').attr('data-id-doctor');

    if ((id_doc != id_doc_ant && $('#divReasignar').is(':visible')) || id_cita_ == 0) {
        $('#txtHora').val('').attr('data-hora', '');
    }
}

function disponibilidad_doctor() {
    var fecha = $('#txtFecha').attr('data-fecha');
    var doctor = $('#cboDoctor').val();
    var html = '';

    $.ajax({
        url: "/RegistroCitas/DisponibilidadDoctor?id_doctor=" + doctor + "&fecha=" + fecha,
        type: "GET",
        data: null,
        beforeSend: function () {
            $('#cboDoctor, #txtHora, #btnGuardarCita').removeAttr('disabled');
            if (doctor == '-1') {
                $('#divDisponibilidad').html('<tr><td colspan="2" class="text-center">Seleccione un especialista</td></tr>');
            }
        },
        success: function (data) {
            if (data.length > 0) {
                for (item of data) {
                    var clase = item.estado == 'DISPONIBLE' ? 'item_disponible' : 'item_reservado';
                    var hora = item.estado == 'DISPONIBLE' ? item.hora_cita : '';
                    var accion = ' onclick="seleccionar_hora_disponible(this)" data-hora="' + hora + '"';
                    html += '<tr class="' + clase + '"' + accion + '><td class="text-center">' + item.hora_cita + '</td><td class="text-center">' + item.estado + '</td></tr>';
                }
            }
        },
        error: function (response) {
            $('#divDisponibilidad').html('<tr><td colspan="2" class="text-center">Seleccione un especialista</td></tr>');
        },
        complete: function () {
            if (estado_ == 'ATENDIDO') {
                $('#divDisponibilidad').html('<tr><td colspan="2" class="text-center">La cita ya ha sido atendida</td></tr>');
                $('#cboDoctor, #txtHora, #btnGuardarCita').attr('disabled', true);
                $('#txtFechaReasignar').val('');
                $('#divReasignar').hide();
            } else {
                if (doctor != '-1') {
                    $('#divDisponibilidad').html(html);
                }
            }
            $('#mdl_cita').modal('show');
        }
    });
}

function disponibilidad_reasignar_doctor() {
    var fecha = $('#txtFechaReasignar').val();
    var doctor = $('#cboDoctor').val();
    var html = '';

    $.ajax({
        url: "/RegistroCitas/DisponibilidadDoctor?id_doctor=" + doctor + "&fecha=" + fecha,
        type: "GET",
        data: null,
        beforeSend: function () {
            if (doctor == '-1') {
                $('#divDisponibilidad').html('<tr><td colspan="2" class="text-center">Seleccione un especialista</td></tr>');
            }
        },
        success: function (data) {
            if (data.length > 0) {
                for (item of data) {
                    var clase = item.estado == 'DISPONIBLE' ? 'item_disponible' : 'item_reservado';
                    var hora = item.estado == 'DISPONIBLE' ? item.hora_cita : '';
                    var accion = ' onclick="seleccionar_hora_disponible(this)" data-hora="' + hora + '"';
                    html += '<tr class="' + clase + '"' + accion + '><td class="text-center">' + item.hora_cita + '</td><td class="text-center">' + item.estado + '</td></tr>';
                }
            }
        },
        error: function (response) {
            $('#divDisponibilidad').html('<tr><td colspan="2" class="text-center">Seleccione un especialista</td></tr>');
        },
        complete: function () {
            if (doctor != '-1') {
                $('#divDisponibilidad').html(html);
            }

            $('#mdl_cita').modal('show');
        }
    });
}

function seleccionar_hora_disponible(e) {
    var hora = $(e).attr('data-hora');

    if (hora == '') {
        alerta("Ya hay una cita registrada en el horario seleccionado.", 'info');
        $('#txtHora').val('');
        return;
    } else {
        hora = hora.replace(' am', ' AM');
        hora = hora.replace(' pm', ' PM');
        $('#txtHora').val(hora);
    }
}