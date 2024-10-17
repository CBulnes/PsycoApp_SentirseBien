var path = ruta;

var lista_citas = [];
var id_cita_ = 0;
var estado_ = '';

var person_img = path + '/images/user.png';

function cargar_citas() {
    $("#txtMontoPactado, #txtMontoPagado, #txtMontoPendiente").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });

    $.ajax({
        url: '/RegistroCitas/CitasUsuario',
        type: "GET",
        data: {},
        success: function (data) {
            lista_citas = data;
        },
        error: function (response) {
            //alertSecondary("Mensaje", "Ocurrió un error al obtener su registro de citas.");
            alert("Ocurrió un error al obtener su registro de citas.");
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
    var id_paciente = $(e).attr('data-id-paciente');
    var hora_Cita = $(e).attr('data-hora-cita');
    var estado = $(e).attr('data-estado');
    var fecha_cita = $(e).attr('data-fecha-cita');
    var telefono = $(e).attr('data-telefono');
    var moneda = $(e).attr('data-moneda');
    var monto_pactado = $(e).attr('data-monto-pactado');
    var monto_pagado = $(e).attr('data-monto-pagado');
    var monto_pendiente = $(e).attr('data-monto-pendiente');

    cargar_datos_cita(id_cita, id_especialista, id_paciente, fecha_cita, hora_Cita, estado, telefono, moneda, formatDecimal(monto_pactado), formatDecimal(monto_pagado), formatDecimal(monto_pendiente));
}

function formatDecimal(num) {
    return (Math.round(num * 100) / 100).toFixed(2);
}

function ver_cuestionario(e) {
    var cuestionario = $(e).attr('data-id-cuestionario');
    var idCita = $(e).attr('data-id-cita');
    var estado = $(e).attr('data-estado');

    //if (cuestionario == 2) {

        if (estado == 'ATENDIDO') {
            //alerta('El cuestionario seleccionado ya se ha aperturado', 'info');
            alert('El cuestionario seleccionado ya se ha aperturado');
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
                    //alerta(data.descripcion, 'info');
                    alert(data.descripcion);
                    //$("#load_data").hide();
                }
            },
            error: function (response) {
                /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
                //alerta("Ocurrió un error atendiendo su solicitud.", 'info');
                alert("Ocurrió un error atendiendo su solicitud.");
                //$("#load_data").hide();
            },
            complete: function () {
            }
        });
    //}
}

function confirmarAbono(e) {
    $(e).hide();
    var pendiente = $('#txtMontoPendiente').val();
    $('#txtMontoPagado').val(pendiente);
    $('#txtMontoPendiente').val('0.00');
}

function cargar_datos_cita(id_cita, id_doctor, id_paciente, fecha, hora, estado, telefono, moneda, monto_pactado, monto_pagado, monto_pendiente) {
    $('#txtFecha').attr('data-fecha', fecha);
    $('#txtFecha').val(fecha_formato_ddmmyyyy(fecha));
    $('#txtHora').val(hora).attr('data-hora', hora);
    $('#cboDoctor').val(id_doctor).attr('data-id-doctor', id_doctor);//.change();
    $('#cboPaciente').val(id_paciente).attr('data-id-paciente', id_paciente);//.change();
    $('#txtTelefono').val(telefono).attr('data-telefono', telefono);
    //$('#txtMoneda').val(moneda).attr('data-moneda', moneda);
    $('#txtMontoPactado').val(monto_pactado).attr('data-monto-pactado', monto_pactado);
    $('#txtMontoPagado').val(monto_pagado).attr('data-monto-pagado', monto_pagado);
    $('#txtMontoPendiente').val(monto_pendiente).attr('data-monto-pendiente', monto_pendiente);
    $('#btnEstado').html(estado == '-' ? 'POR CITAR' : estado);

    $('#btnEstado').attr('class', 'evento_' + (estado == '-' ? 'CITADO' : estado).toLowerCase().replace(' ', '_'));
    $('#spnPactado').html('Monto pactado (' + moneda + ')');
    $('#spnPagado').html('Monto pagado (' + moneda + ')');
    var btnAbonar = (estado == 'EN PROCESO' ? '&nbsp;<img id="PagoPendiente" src="../images/warning.jpg" style="height: 15px; width: auto; cursor: pointer;" title="Confirmar abono" onclick="confirmarAbono(this)" />' : '');
    $('#spnPendiente').html('Monto pendiente (' + moneda + ')' + btnAbonar);
    
    $('#cboDoctor, #cboPaciente, #txtHora, #txtMontoPactado').removeAttr('disabled');

    if (id_cita == 0) {
        $('#txtFechaReasignar').val('');
        $('#divHorarios, .divConfirmar').show();
        $('#divReprogramar, #btnConfirmar, #divProcesar, #divAtender, #divEstado').hide();
    } else {
        $('#txtFechaReasignar').val(fecha);
        $('#divEstado').show();

        if (estado == 'CITADO') {
            $('#divReprogramar, #divHorarios, #divConfirmar, #btnConfirmar').show();
            $('#divProcesar, #divAtender').hide();
        } else if (estado == 'CONFIRMADO') {
            $('#divProcesar').show();
            $('#divReprogramar, #divHorarios, .divConfirmar, #divAtender').hide();
        } else if (estado == 'EN PROCESO') {
            $('#divAtender').show();
            $('#divReprogramar, #divHorarios, .divConfirmar, #divProcesar').hide();
        } else if (estado == 'ATENDIDO') {
            $('#divReprogramar, #divHorarios, .divConfirmar, #divProcesar, #divAtender').hide();
        }
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
                html += '<option value="' + item.id + '">' + item.nombre + '</option>';
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

function isPrecise(num) {
    return String(num).split(".")[1]?.length == 2;
}

function guardar_cita() {
    var fecha = $('#txtFecha').attr('data-fecha');
    var fecha_r = $('#txtFechaReasignar').val();
    if (fecha_r != '') {
        fecha = fecha_r;
    }
    var hora = $('#txtHora').val();
    var doctor = $('#cboDoctor').val();
    var paciente = $('#cboPaciente').val();
    var monto_pactado = $('#txtMontoPactado').val();

    if (doctor == '-1') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        alert("Seleccione el especialista.");
        return;
    }

    if (hora == '') {
        /*alertSecondary("Mensaje", "Seleccione la hora para el registro de la cita.");*/
        //alerta("Seleccione la hora para el registro de la cita.", 'info');
        alert("Seleccione la hora para el registro de la cita.");
        return;
    }

    if (paciente == '-1') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        alert("Seleccione el paciente.");
        return;
    }

    if (monto_pactado == '') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        alert("Ingrese el monto pactado.");
        return;
    }

    if (monto_pactado == '0.00' || (monto_pactado != '' && !isPrecise(monto_pactado))) {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        alert("Ingrese un monto válido.");
        return;
    }

    var data_ = {
        id_cita: id_cita_,
        id_usuario: 0,
        estado_cita: 0,
        fecha_cita: fecha,
        hora_cita: hora,
        id_doctor_asignado: doctor,
        id_paciente: paciente,
        monto_pactado: monto_pactado.replace('.', ',')
    };

    $.ajax({
        url: "/RegistroCitas/RegistrarCita",
        type: "POST", //(idRegistro > 0 ? "PUT" : "POST"),
        data: data_,
        success: function (data) {
            console.log(data);
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                //alerta("Cita guardada exitosamente.", 'info');
                alert("Cita guardada exitosamente.");

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor').val('-1');
                $('#mdl_cita').modal('hide');

                $('.calendar-container').html('<div id="my-calendar"></div>');
                cargar_citas();
            } else {
                /*alertWarning("Atención", data.message);*/
                //alerta(data.descripcion, 'info');
                alert(data.descripcion);
                //$("#load_data").hide();
            }
        },
        error: function (response) {
            /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
            //alerta("Ocurrió un error al guardar la cita.", 'info');
            alert("Ocurrió un error al guardar la cita.");
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function confirmar_cita() {
    $.ajax({
        url: "/RegistroCitas/ConfirmarCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                //alerta("Cita guardada exitosamente.", 'info');
                alert("Cita confirmada exitosamente.");

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor').val('-1');
                $('#mdl_cita').modal('hide');

                $('.calendar-container').html('<div id="my-calendar"></div>');
                cargar_citas();
            } else {
                /*alertWarning("Atención", data.message);*/
                //alerta(data.descripcion, 'info');
                alert(data.descripcion);
                //$("#load_data").hide();
            }
        },
        error: function (response) {
            /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
            //alerta("Ocurrió un error al guardar la cita.", 'info');
            alert("Ocurrió un error al confirmar la cita.");
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function procesar_cita() {
    $.ajax({
        url: "/RegistroCitas/ProcesarCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                //alerta("Cita guardada exitosamente.", 'info');
                alert("Cita procesada exitosamente.");

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor').val('-1');
                $('#mdl_cita').modal('hide');

                $('.calendar-container').html('<div id="my-calendar"></div>');
                cargar_citas();
            } else {
                /*alertWarning("Atención", data.message);*/
                //alerta(data.descripcion, 'info');
                alert(data.descripcion);
                //$("#load_data").hide();
            }
        },
        error: function (response) {
            /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
            //alerta("Ocurrió un error al guardar la cita.", 'info');
            alert("Ocurrió un error al procesar la cita.");
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function atender_cita() {
    var pagado = $('#txtMontoPagado').val();
    if (pagado == '0.00') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        alert("Primero debe confirmar el abono del monto pendiente.");
        return;
    }

    $.ajax({
        url: "/RegistroCitas/AtenderCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                //alerta("Cita guardada exitosamente.", 'info');
                alert("Cita atendida exitosamente.");

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor').val('-1');
                $('#mdl_cita').modal('hide');

                $('.calendar-container').html('<div id="my-calendar"></div>');
                cargar_citas();
            } else {
                /*alertWarning("Atención", data.message);*/
                //alerta(data.descripcion, 'info');
                alert(data.descripcion);
                //$("#load_data").hide();
            }
        },
        error: function (response) {
            /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
            //alerta("Ocurrió un error al guardar la cita.", 'info');
            alert("Ocurrió un error al atender la cita.");
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
        //alerta("El formato de hora ingresada es incorrecto.", 'info');
        alert("El formato de hora ingresada es incorrecto.");
    }
}

function verificar_disponibilidad() {
    if ($('#divReprogramar').is(':visible')) {
        disponibilidad_reasignar_doctor();
    } else {
        disponibilidad_doctor();
    }

    var id_doc = $('#cboDoctor').val();
    var id_doc_ant = $('#cboDoctor').attr('data-id-doctor');

    if ((id_doc != id_doc_ant && $('#divReprogramar').is(':visible')) || id_cita_ == 0) {
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
            $('#cboDoctor, #txtHora, #btnGuardarCita, #cboPaciente').removeAttr('disabled');
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
                $('#cboDoctor, #txtHora, #btnGuardarCita,#cboPaciente').attr('disabled', true);
                $('#txtFechaReasignar').val('');
                $('#divReprogramar').hide();
            } else {
                if (doctor != '-1') {
                    $('#divDisponibilidad').html(html);
                }
            }
            $('#mdl_cita').modal('show');
            deshabilitar_campos();
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
            deshabilitar_campos();
        }
    });
}

function deshabilitar_campos() {
    if (estado_ != '-') {
        $('#txtMontoPactado').attr('disabled', true);
    }
    if (estado_ == 'CONFIRMADO') {
        $('#cboDoctor, #cboPaciente, #txtHora').attr('disabled', true);
    }
}

function seleccionar_hora_disponible(e) {
    var hora = $(e).attr('data-hora');

    if (hora == '') {
        //alerta("Ya hay una cita registrada en el horario seleccionado.", 'info');
        alert("Ya hay una cita registrada en el horario seleccionado.");
        $('#txtHora').val('');
        return;
    } else {
        hora = hora.replace(' am', ' AM');
        hora = hora.replace(' pm', ' PM');
        $('#txtHora').val(hora);
    }
}