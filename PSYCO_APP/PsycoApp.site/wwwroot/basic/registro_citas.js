var path = ruta;

var lista_citas = [];
var id_cita_ = 0;
var estado_ = '';

var person_img = path + '/images/user.png';
var recargar_pagos_pendientes = false;


document.addEventListener('DOMContentLoaded', function () {
    const element = document.querySelector('#cboDoctorFiltro');
    const choices = new Choices(element, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
    const elementT = document.querySelector('#cboPacienteFiltro');
    const choicesT = new Choices(elementT, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
});
$(document).ready(function () {
    const element = document.querySelector('#cboDoctorFiltro');
    const choices = new Choices(element, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
    const elementT = document.querySelector('#cboPacienteFiltro');
    const choicesT = new Choices(elementT, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
});
function recargar_citas() {
    $('.calendar-container').html('<div id="my-calendar"></div>');
    cargar_citas();
}

function cargar_citas() {
    $("#txtMontoPactado, #txtMontoPagado, #txtMontoPendiente").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });

    var filtroPaciente = $('#cboPacienteFiltro').val();
    var filtroDoctor = $('#cboDoctorFiltro').val();

    $.ajax({
        url: '/RegistroCitas/CitasUsuario?idPaciente=' + filtroPaciente + '&idDoctor=' + filtroDoctor,
        type: "GET",
        data: {},
        success: function (data) {
            lista_citas = data;
        },
        error: function (response) {
            //alertSecondary("Mensaje", "Ocurrió un error al obtener su registro de citas.");
            //alert("Ocurrió un error al obtener su registro de citas.");
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Ocurrió un error al obtener el registro de citas.",
            });
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
    var id_servicio = $(e).attr('data-id-servicio');

    cargar_datos_cita(id_cita, id_especialista, id_paciente, fecha_cita, hora_Cita, estado, telefono, moneda, formatDecimal(monto_pactado), formatDecimal(monto_pagado), formatDecimal(monto_pendiente), id_servicio);
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
            //alert('El cuestionario seleccionado ya se ha aperturado');
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "El cuestionario seleccionado ya se ha aperturado.",
            });
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
                //alert("Ocurrió un error atendiendo su solicitud.");
                Swal.fire({
                    icon: "Error",
                    title: "Oops...",
                    text: "Ocurrió un error atendiendo su solicitud.",
                });
                //$("#load_data").hide();
            },
            complete: function () {
            }
        });
    //}
}

function GetFechaActual() {
    var d = new Date(), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
}

function form_pago() {
    $('#mdl_cita').modal('hide');
    var fechaActual = GetFechaActual();
    var nombrePaciente = $("#cboPaciente option:selected").text();
    var pendiente = $('#txtMontoPendiente').val();

    if (pendiente == '0.00') {
        setTimeout(() => {
            listar_pagos_pendientes($('#cboPaciente').val());
            $('#mdl_otros_pagos_pendientes').modal('show');
        }, 250);
        return;
    }

    setTimeout(() => {
        $('#mdl_pago').modal('show');
    }, 250);

    $('#txtIdCita').val(id_cita_);
    $('#txtFechaPago').val(fecha_formato_ddmmyyyy(fechaActual));
    $('#txtPaciente').val(nombrePaciente);
    $('#cboFormaPago').val(-1);
    validarSiEsTransferencia();

    $("#txtMonto1, #txtMonto2, #txtMonto3").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });
    $('#txtMonto1').val('0.00');    //importe pago
    $('#txtMonto2').val(pendiente); //pendiente
    $('#txtMonto3').val(pendiente); //diferencia
    recargar_pagos_pendientes = false;
}

function listar_pagos_pendientes(id_paciente) {
    var pendientes = [];
    $('#headPagosPendientes').hide();

    $.ajax({
        url: '/Caja/ListarPagosPendientes?idPaciente=' + id_paciente,
        type: "GET",
        data: {},
        success: function (data) {
            pendientes = data;
        },
        error: function (response) {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Ocurrió un error al obtener el registro de pagos pendientes.",
            });
            pendientes = [];
        },
        complete: function () {
            var html = '';
            if (pendientes.length > 0) {
                for (var item of pendientes) {
                    html += '<tr>';
                    html += '<td>' + item.servicio + '</td>';
                    html += '<td>' + fecha_formato_ddmmyyyy(item.fecha_cita) + '</td>';
                    html += '<td>' + item.estado_cita + '</td>';
                    html += '<td>' + item.usuario_registra + '</td>';
                    html += '<td>' + fecha_formato_ddmmyyyy(item.fecha_registra) + '</td>';
                    html += '<td>' + item.monto_pactado + '</td>';
                    html += '<td>' + item.monto_pagado + '</td>';
                    html += '<td>' + item.monto_pendiente + '</td>';
                    html += '<td><button type="button" class="btn btn-primary main_color sb-reg-citas-popup-button" id="' + item.id_cita + '" pactado="' + item.monto_pactado + '" pagado="' + item.monto_pagado + '" pendiente="' + item.monto_pendiente + '" onclick="ver_datos_pago_pendiente(this)">Pagar</button></td>';
                    html += '</tr>';
                }
                $('#headPagosPendientes').show();
            } else {
                html += '<tr>';
                html += '<td>No registra pagos pendientes.</td>';
                html += '</tr>';
            }
            
            $('#bodyPagosPendientes').html(html);
        }
    });
}

function ver_datos_pago_pendiente(e) {
    var id_cita = $(e).attr('id');
    var pactado = $(e).attr('pactado').replace('S/.', '');
    var pagado = $(e).attr('pagado').replace('S/.', '');
    var pendiente = $(e).attr('pendiente').replace('S/.', '');

    $('#mdl_otros_pagos_pendientes').modal('hide');
    var fechaActual = GetFechaActual();
    var nombrePaciente = $("#cboPaciente option:selected").text();

    setTimeout(() => {
        $('#mdl_pago').modal('show');
    }, 250);

    $('#txtIdCita').val(id_cita);
    $('#txtFechaPago').val(fecha_formato_ddmmyyyy(fechaActual));
    $('#txtPaciente').val(nombrePaciente);
    $('#cboFormaPago').val(-1);
    validarSiEsTransferencia();

    $("#txtMonto1, #txtMonto2, #txtMonto3").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });
    $('#txtMonto1').val('0.00');    //importe pago
    $('#txtMonto2').val(pendiente); //pendiente
    $('#txtMonto3').val(pendiente); //diferencia
    recargar_pagos_pendientes = true;
}

function cerrar_modal_pagos_pendientes(){
    $('#mdl_otros_pagos_pendientes').modal('hide');
    setTimeout(() => {
        $('#mdl_cita').modal('show');
    }, 250);
}

function guardar_pago() {
    var id_forma_pago = $('#cboFormaPago').val();
    var id_detalle_transferencia = $('#cboDetalleTransferencia').val();
    var importe = $('#txtMonto1').val();

    if (id_forma_pago == -1) {
        alert('Seleccione una forma de pago.');
        return;
    }

    if (id_forma_pago == 1 && id_detalle_transferencia == -1) {
        alert('Seleccione el detalle de transferencia.');
        return;
    }

    if (importe == '0.00' || (importe != '' && !isPrecise(importe))) {
        alert('Para registrar el pago debe ingresar un importe de pago válido.');
        return;
    }

    var data_ = {
        id_cita: $('#txtIdCita').val(),
        id_forma_pago: id_forma_pago,
        id_detalle_transferencia: id_detalle_transferencia,
        importe: importe.replace('.', ',')
    };

    $.ajax({
        url: "/Caja/RegistrarPago",
        type: "POST",
        data: data_,
        success: function (data) {
            if (data.estado) {
                Swal.fire({
                    icon: "success",
                    text: "Pago registrado exitosamente.",
                });

                if (!recargar_pagos_pendientes) {
                    cerrar_modal_pago();

                    var pactado = $('#txtMontoPactado').val();
                    var pagado = $('#txtMontoPagado').val();

                    $('#txtMontoPagado').val(formatDecimal(parseFloat(pagado) + parseFloat(importe)));
                    $('#txtMontoPendiente').val(formatDecimal(parseFloat(pactado) - (parseFloat(pagado) + parseFloat(importe))));
                } else {
                    cerrar_modal_pago2();
                    listar_pagos_pendientes($('#cboPaciente').val());
                }
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Oops...",
                    text: data.descripcion,
                });
            }
        },
        error: function (response) {
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al guardar la cita.",
            });
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function validarDiferenciaPago() {
    var importe = $('#txtMonto1').val();
    var pendiente = $('#txtMonto2').val();
    var diferencia;

    if (parseFloat(importe) > parseFloat(pendiente)) {
        alert('El importe de pago no puede ser mayor al monto pendiente.');
        $('#txtMonto1').val(pendiente);
        diferencia = formatDecimal('0.00');
    } else {
        diferencia = pendiente - importe;
    }

    $('#txtMonto3').val(formatDecimal(diferencia));
}

function validarSiEsTransferencia() {
    var formaPago = $('#cboFormaPago').val();
    if (formaPago == 1) {
        $('#cboDetalleTransferencia').val(-1);
        $('#divDetalleTransferencia').show();
    } else {
        $('#divDetalleTransferencia').hide();
    }
}

function cerrar_modal_pago() {
    $('#mdl_pago').modal('hide');
    setTimeout(() => {
        $('#mdl_cita').modal('show');
    }, 250);
}

function cerrar_modal_pago2() {
    $('#mdl_pago').modal('hide');
    setTimeout(() => {
        $('#mdl_otros_pagos_pendientes').modal('show');
    }, 250);
}

function cargar_datos_cita(id_cita, id_doctor, id_paciente, fecha, hora, estado, telefono, moneda, monto_pactado, monto_pagado, monto_pendiente, id_servicio) {
    $('#btnResumen').trigger('click');
    $('#ulTabs').hide();

    $('#txtFecha').attr('data-fecha', fecha).val(fecha_formato_ddmmyyyy(fecha));
    $('#txtHora').val(hora).attr('data-hora', hora);
    $('#cboDoctor').val(id_doctor).attr('data-id-doctor', id_doctor);
    $('#cboPaciente').val(id_paciente).attr('data-id-paciente', id_paciente);
    $('#txtTelefono').val(telefono).attr('data-telefono', telefono);
    $('#txtMontoPactado').val(monto_pactado).attr('data-monto-pactado', monto_pactado);
    $('#txtMontoPagado').val(monto_pagado).attr('data-monto-pagado', monto_pagado);
    $('#txtMontoPendiente').val(monto_pendiente).attr('data-monto-pendiente', monto_pendiente);
    $('#cboServicio').val(id_servicio);
    $('#btnEstado').html(estado == '-' ? 'POR CITAR' : estado);

    $('#btnEstado').attr('class', 'evento_' + (estado == '-' ? 'CITADO' : estado).toLowerCase().replace(' ', '_'));
    $('#spnPactado').html('Monto pactado (' + moneda + ')');
    $('#spnPagado').html('Monto pagado (' + moneda + ')');
    var btnAbonar = (estado == 'EN PROCESO' ? '&nbsp;<img id="PagoPendiente" src="../images/warning.jpg" style="height: 15px; width: auto; cursor: pointer;" title="Verificar pagos" onclick="form_pago()" />' : '');
    $('#spnPendiente').html('Monto pendiente (' + moneda + ')' + btnAbonar);
    
    $('#cboDoctor, #cboPaciente, #txtHora, #cboServicio').removeAttr('disabled');

    $('.divMonto').hide();
    if (id_cita == 0) {
        $('#txtFechaReasignar').val('');
        $('#divHorarios, .divConfirmar').show();
        $('#divReprogramar, #btnConfirmar, #divProcesar, #divAtender, #divEstado, #btnCancelar').hide();
    } else {
        $('#ulTabs').show();
        $('#txtFechaReasignar').val(fecha);
        $('#divEstado').show();

        if (estado == 'CITADO') {
            $('#divReprogramar, #divHorarios, #divConfirmar, #btnConfirmar, #btnCancelar').show();
            $('#divProcesar, #divAtender').hide();
        } else if (estado == 'CONFIRMADO') {
            $('#divProcesar, #btnCancelar').show();
            $('#divReprogramar, #divHorarios, .divConfirmar, #divAtender').hide();
        } else if (estado == 'EN PROCESO') {
            $('#divAtender, #btnCancelar').show();
            $('#divReprogramar, #divHorarios, .divConfirmar, #divProcesar').hide();
        } else if (estado == 'ATENDIDO') {
            $('#divReprogramar, #divHorarios, .divConfirmar, #divProcesar, #divAtender, #btnCancelar').hide();
        }
    }

    estado_ = estado;
    id_cita_ = id_cita;

    verificar_si_es_psicologo();
    verificar_disponibilidad();
    mostrar_historial(id_cita);
}

function mostrar_historial(id_cita) {
    var historial = lista_citas.filter(x => x.id_cita == parseInt(id_cita))[0].historial;
    var html = '';
    for (var item of historial) {
        html += '<div class="sb-reg-citas-popup-tab-historial-block"><div class="sb-reg-citas-popup-tab-historial-block-item">';
        html += '<p>' + item.fecha + '</p>';
        html += '</div>';
        html += '<div class="sb-reg-citas-popup-tab-historial-block-item-2">';
        html += '<button type="button" class="evento_' + item.evento.toLowerCase().replace(' ', '_') + '">' + item.evento + '</button>';
        html += '<div class="sb-reg-citas-historial-user" ><p>Usuario: </p><span>' + item.usuario +'</span></div>';
        html += '</div></div>';
    }
    $('#divHistorial').html(html);
}

function cargar_lista_pacientes() {
    var html = '';
    $.ajax({
        url: "/RegistroCitas/listar_pacientes",
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
            $('#cboPaciente').html(html);
            $('#cboPacienteFiltro').html(html);
        }
    });
}
cargar_lista_pacientes();
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
            $('#cboDoctorFiltro').html(html);

            verificar_si_es_psicologo();
        }
    });
}
cargar_lista_doctores();

function verificar_si_es_psicologo() {
    if (id_tipousuario == 4) {
        $('#cboDoctorFiltro, #cboDoctor').attr('disabled', true);
        $('#cboDoctorFiltro, #cboDoctor').val(id_psicologo);
    }
}

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
    var id_servicio = $('#cboServicio').val();

    if (doctor == '-1') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        //alert("Seleccione el especialista.");
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el especialista.",
        });
        return;
    }

    if (hora == '') {
        /*alertSecondary("Mensaje", "Seleccione la hora para el registro de la cita.");*/
        //alerta("Seleccione la hora para el registro de la cita.", 'info');
        //alert("Seleccione la hora para el registro de la cita.");
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione la hora para el registro de la cita.",
        });
        return;
    }

    if (paciente == '-1') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        //alert("Seleccione el paciente.");
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el paciente.",
        });
        return;
    }

    if (id_servicio == '-1') {
        /*alertSecondary("Mensaje", "Seleccione el especialista.");*/
        //alerta("Seleccione el especialista.", 'info');
        //alert("Seleccione el paciente.");
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el servicio.",
        });
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
        monto_pactado: '0,00',
        id_servicio: id_servicio
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
                //alert("Cita guardada exitosamente.");
                Swal.fire({
                    icon: "success",
                    text: "Cita guardada exitosamente.",
                });

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
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
            //alert("Ocurrió un error al guardar la cita.");
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al guardar la cita.",
            });
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
                //alert("Cita confirmada exitosamente.");
                Swal.fire({
                    icon: "success",
                    text: "Cita confirmada exitosamente.",
                });

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
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
            //alert("Ocurrió un error al confirmar la cita.");
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al confirmar la cita.",
            });
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
                //alert("Cita procesada exitosamente.");
                Swal.fire({
                    icon: "success",
                    text: "Cita procesada exitosamente.",
                });

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
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
            //alert("Ocurrió un error al procesar la cita.");
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al procesar la cita.",
            });
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function atender_cita() {
    $.ajax({
        url: "/RegistroCitas/AtenderCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                //alerta("Cita guardada exitosamente.", 'info');
                //alert("Cita atendida exitosamente.");
                Swal.fire({
                    icon: "success",
                    text: "Cita atendida exitosamente.",
                });

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
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
            //alert("Ocurrió un error al atender la cita.");
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al atender la cita.",
            });
            //$("#load_data").hide();
        },
        complete: function () {
        }
    });
}

function cancelar_cita() {
    $.ajax({
        url: "/RegistroCitas/CancelarCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
                /*alertSuccess("Muy bien", "Cita guardada exitosamente.");*/
                //alerta("Cita guardada exitosamente.", 'info');
                //alert("Cita atendida exitosamente.");
                Swal.fire({
                    icon: "success",
                    text: "Cita cancelada exitosamente.",
                });

                //$("#load_data").hide();
                //recargarInstruccion();
                $('#txtHora').val('');
                $('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
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
            //alert("Ocurrió un error al atender la cita.");
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al cancelar la cita.",
            });
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
        //alert("El formato de hora ingresada es incorrecto.");
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "El formato de hora ingresada es incorrecto.",
        });
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
                $('#cboDoctor, #txtHora, #btnGuardarCita, #cboPaciente, #cboServicio').attr('disabled', true);
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
    if (estado_ != '-' && estado_ != 'CITADO') {
        $('#cboDoctor, #cboPaciente, #cboServicio').attr('disabled', true);
    }
    if (estado_ == 'CONFIRMADO') {
        $('#cboDoctor, #cboPaciente, #txtHora, #cboServicio').attr('disabled', true);
    }
}

function seleccionar_hora_disponible(e) {
    var hora = $(e).attr('data-hora');

    if (hora == '') {
        //alerta("Ya hay una cita registrada en el horario seleccionado.", 'info');
        //alert("Ya hay una cita registrada en el horario seleccionado.");
        Swal.fire({
            icon: "Error",
            title: "Oops...",
            text: "Ya hay una cita registrada en el horario seleccionado.",
        });
        $('#txtHora').val('');
        return;
    } else {
        hora = hora.replace(' am', ' AM');
        hora = hora.replace(' pm', ' PM');
        $('#txtHora').val(hora);
    }
}