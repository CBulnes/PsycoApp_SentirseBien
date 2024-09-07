var path = ruta;

var lista_citas = [];
var lista_historial = [];
var idPaciente = 0;
var idCita = 0;
var estado = "";
var fecha = "";

function cargar_historial() {
    var html = '';

    var fecha = $('#txtFecha').val();
    var id_estado = $('#cboEstado').val();
    var i = 1;

    $.ajax({
        url: '/HistorialCitas/CitasDoctor?fecha=' + (fecha == '' ? '-' : fecha) + '&id_estado=' + id_estado,
        type: "GET",
        data: {},
        beforeSend: function () {
            html = '';
        },
        success: function (data) {
            lista_citas = data;
        },
        error: function (response) {
            alertSecondary("Mensaje", "Ocurrió un error al obtener su historial de citas.");
            lista_citas = [];
        },
        complete: function () {
            if (lista_citas.length > 0) {
                for (var item of lista_citas) {
                    html += '<tr>';
                    html += '<td class="text-center text-tbl">' + i + '</td>';
                    html += '<td class="text-center text-tbl">' + item.usuario + '</td>';
                    html += '<td class="text-center text-tbl">' + fecha_formato_ddmmyyyy(item.fecha_cita) + '</td>';
                    html += '<td class="text-center text-tbl">' + item.hora_cita + '</td>';
                    html += '<td class="text-center text-tbl">' + accion_estado(item.estado) + '</td>';
                    html += '<td class="text-center text-tbl">' + accion_cita(item.estado, item.id_usuario, item.fecha_cita, item.id_cita) + '</td>';
                    html += '</tr>';
                    i++;
                }
            } else {
                html = '<tr><td colspan="6" class="text-center">No se encontraron resultados</td></tr>';
            }
            $('#bdCitas').html(html);
        }
    });
}
cargar_historial();

function accion_estado(estado) {
    var html_estado = '';
    var clase = (estado == 'REGISTRADO' ? 'btn_pendiente' : 'btn_atendido');

    html_estado += '<button type="button" class="btn btn-doc ' + clase + '">';
    html_estado += estado;
    html_estado += '</button>';

    return html_estado;
}

function accion_cita(estado, id_usuario, fecha, id_cita) {
    var html_accion = '';

    html_accion += '<button type="button" class="btn btn-doc second_color" style="color: #FFF; font-size: 12px;" data-id-cita="' + id_cita + '" data-fecha="' + fecha + '" data-estado="' + estado + '" data-id-usuario="' + id_usuario + '" title="Ver registro" onclick="ver_detalle(this)">';
    html_accion += '<i class="fa fa-edit"></i>';
    html_accion += '</button>';

    return html_accion;
}

function ver_detalle(e) {
    idPaciente = $(e).attr('data-id-usuario');
    estado = $(e).attr('data-estado');
    fecha = $(e).attr('data-fecha');
    idCita = $(e).attr('data-id-cita');

    var html = '';
    var i = 1;
    var fecha_actual = fechaActualYYYYMMDD();

    $.ajax({
        url: '/HistorialCitas/HistorialPaciente?id_usuario=' + idPaciente,
        type: "GET",
        data: {},
        beforeSend: function () {
            html = '';

            if (estado == 'REGISTRADO' && fecha != fecha_actual) {
                $('#txtNota, #txtRecomendacion, #txtMedicina').attr('disabled', true);
                $('#btnGuardarCita').hide();
            } else if (estado == 'REGISTRADO' && fecha == fecha_actual) {
                $('#txtNota, #txtRecomendacion, #txtMedicina').removeAttr('disabled');
                $('#btnGuardarCita, #divDatos').show();
            } else if (estado == 'ATENDIDO' && fecha != fecha_actual) {
                $('#btnGuardarCita, #divDatos').hide();
            } else if (estado == 'ATENDIDO' && fecha == fecha_actual) {
                $('#btnGuardarCita, #divDatos').hide();
            }
        },
        success: function (data) {
            lista_historial = data;
        },
        error: function (response) {
            alertSecondary("Mensaje", "Ocurrió un error al obtener el historial del usuario.");
            lista_historial = [];
        },
        complete: function () {
            if (lista_historial.length > 0) {
                for (var item of lista_historial) {
                    html += '<tr>';
                    html += '<td class="text-center text-tbl">' + i + '</td>';
                    html += '<td class="text-center text-tbl">' + item.nota + '</td>';
                    html += '<td class="text-center text-tbl">' + item.recomendacion + '</td>';
                    html += '<td class="text-center text-tbl">' + item.medicina + '</td>';
                    html += '<td class="text-center text-tbl">' + item.doctor + '</td>';
                    html += '<td class="text-center text-tbl">' + fecha_formato_ddmmyyyy(item.fecha_registro) + '</td>';
                    html += '<td class="text-center text-tbl">' + item.hora_registro + '</td>';
                    html += '</tr>';
                    i++;
                }

                var validacion = lista_historial[0].cuestionarios;
                if (validacion == '') {
                    $('#spnSinCuestionarios').show();
                    $('#spnCuestionario01, #spnCuestionario02, #spnCuestionario03, #spnCuestionario04').hide();
                } else {
                    $('#spnSinCuestionarios, #spnCuestionario01, #spnCuestionario02, #spnCuestionario03, #spnCuestionario04').hide();

                    if (validacion.includes('C1')) {
                        $('#spnCuestionario01').show();
                    }
                    if (validacion.includes('C2')) {
                        $('#spnCuestionario02').show();
                    }
                    if (validacion.includes('C3')) {
                        $('#spnCuestionario03').show();
                    }
                    if (validacion.includes('C4')) {
                        $('#spnCuestionario04').show();
                    }
                }
            } else {
                html = '<tr><td colspan="7" class="text-center">No se encontraron resultados</td></tr>';
            }
            $('#bdHistorial').html(html);
            $('#mdl_historial').modal('show');
        }
    });
}

function cerrar_modal_historial() {
    $('#mdl_historial').modal('hide');
}

function fecha_formato_ddmmyyyy(fecha) {
    var dd = fecha.slice(-2);
    var mm = (fecha.slice(-5)).substring(0, 2);
    var yyyy = fecha.substring(0, 4);

    return dd + '/' + mm + '/' + yyyy;
}

function fechaActualDDMMYYYY() {
    var today = new Date();
    var yyyy = today.getFullYear();
    var mm = today.getMonth() + 1; // Months start at 0!
    var dd = today.getDate();

    if (dd < 10) dd = '0' + dd;
    if (mm < 10) mm = '0' + mm;

    var formattedToday = dd + '/' + mm + '/' + yyyy;
    return formattedToday;
}

function fechaActualYYYYMMDD() {
    var today = new Date();
    var yyyy = today.getFullYear();
    var mm = today.getMonth() + 1; // Months start at 0!
    var dd = today.getDate();

    if (dd < 10) dd = '0' + dd;
    if (mm < 10) mm = '0' + mm;

    var formattedToday = yyyy + '-' + mm + '-' + dd;
    return formattedToday;
}

//$('#dtpicker1').datetimepicker({
//    format: 'hh:00 A'
//});

function guardar_cita() {
    var nota = $('#txtNota').val().trim();
    var recomendacion = $('#txtRecomendacion').val().trim();
    var medicina = $('#txtMedicina').val().trim();

    if (nota == '') {
        /*alertSecondary("Mensaje", "Seleccione la hora para el registro de la cita.");*/
        alerta("Ingrese una nota.", 'info');
        return;
    }

    if (recomendacion == '') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        alerta("Ingrese una recomendación.", 'info');
        return;
    }

    if (medicina == '') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        alerta("Ingrese la(s) medicina(s).", 'info');
        return;
    }

    var data_ = {
        id_historial: 0,
        id_paciente: idPaciente,
        nota: nota,
        recomendacion: recomendacion,
        medicina: medicina,
        id_doctor: 0,
        doctor: '',
        fecha_registro: '',
        hora_registro: '',
        id_cita: idCita
    };

    $.ajax({
        url: "/HistorialCitas/RegistrarHistorial",
        type: "POST",
        data: data_,
        success: function (data) {
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                alerta("Información guardada exitosamente.", 'info');
                //$("#load_data").hide();

                $('#txtNota, #txtRecomendacion, #txtMedicina').val('');
                cargar_historial();

                $('#mdl_historial').modal('hide');
            } else {
                /*alertWarning("Atención", data.message);*/
                alerta(data.descripcion, 'info');
                //$("#load_data").hide();
            }
        },
        error: function (response) {
            /*alertWarning("Atención", "Ocurrió un error al guardar la cita.");*/
            alerta("Ocurrió un error al guardar la información.", 'info');
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