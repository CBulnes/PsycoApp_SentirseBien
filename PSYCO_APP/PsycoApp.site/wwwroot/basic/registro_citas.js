var path = ruta;

var lista_citas = [];
var lista_horarios = [];
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
    var tipoVista = $('.btn-vista.active').attr('data-tipo');

    $.ajax({
        url: '/RegistroCitas/CitasUsuario?idPaciente=' + filtroPaciente + '&idDoctor=' + filtroDoctor + '&tipoVista=' + tipoVista,
        type: "GET",
        data: {},
        success: function (data) {
            lista_citas = data;
        },
        error: function (response) {
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
                    Swal.fire({
                        icon: "Error",
                        title: "Oops...",
                        text: data.descripcion,
                    });
                }
            },
            error: function (response) {
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
                    html += '<td><div class="sb-reg-citas-tb-td"><button type="button" class="btn btn-primary main_color sb-reg-citas-popup-button" id="' + item.id_cita + '" pactado="' + item.monto_pactado + '" pagado="' + item.monto_pagado + '" pendiente="' + item.monto_pendiente + '" onclick="ver_datos_pago_pendiente(this)">Pagar</button></div></td>';
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
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione una forma de pago.",
        });
        return;
    }

    if (id_forma_pago == 1 && id_detalle_transferencia == -1) {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el detalle de transferencia.",
        });
        return;
    }

    if (importe == '0.00' || (importe != '' && !isPrecise(importe))) {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Para registrar el pago debe ingresar un importe de pago válido.",
        });
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
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "El importe de pago no puede ser mayor al monto pendiente.",
        });
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
        $('#divReprogramar, #btnConfirmar, #divAtender, #divEstado, #btnCancelar, #divPagoPendiente').hide();
    } else {
        $('#ulTabs').show();
        $('#txtFechaReasignar').val(fecha);
        $('#divEstado').show();

        if (estado == 'CITADO') {
            $('#divReprogramar, #divHorarios, #divConfirmar, #btnConfirmar, #btnCancelar, #divPagoPendiente').show();
            $('#divAtender').hide();
        } else if (estado == 'CONFIRMADO') {
        //    $('#btnCancelar, #divPagoPendiente').show();
        //    $('#divReprogramar, #divHorarios, .divConfirmar, #divAtender').hide();
        //} else if (estado == 'EN PROCESO') {
            $('#divAtender, #btnCancelar, #divPagoPendiente').show();
            $('#divReprogramar, #divHorarios, .divConfirmar').hide();
        } else if (estado == 'ATENDIDO') {
            $('#divReprogramar, #divHorarios, .divConfirmar, #divAtender, #btnCancelar, #divPagoPendiente').hide();
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
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el especialista.",
        });
        return;
    }

    if (hora == '') {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione la hora para el registro de la cita.",
        });
        return;
    }

    if (paciente == '-1') {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el paciente.",
        });
        return;
    }

    if (id_servicio == '-1') {
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
            if (data.estado) {
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
                Swal.fire({
                    icon: "Error",
                    title: "Oops...",
                    text: data.descripcion,
                });
                //$("#load_data").hide();
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

function confirmar_cita() {
    $.ajax({
        url: "/RegistroCitas/ConfirmarCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
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
                Swal.fire({
                    icon: "Error",
                    title: "Oops...",
                    text: data.descripcion,
                });
                //$("#load_data").hide();
            }
        },
        error: function (response) {
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

function atender_cita() {
    $.ajax({
        url: "/RegistroCitas/AtenderCita",
        type: "POST",
        data: { id_cita: id_cita_ },
        success: function (data) {
            if (data.estado) {
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
                Swal.fire({
                    icon: "Error",
                    title: "Oops...",
                    text: data.descripcion,
                });
                //$("#load_data").hide();
            }
        },
        error: function (response) {
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
                Swal.fire({
                    icon: "Error",
                    title: "Oops...",
                    text: data.descripcion,
                });
                //$("#load_data").hide();
            }
        },
        error: function (response) {
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

/* funciones vista semanal */
var mes_ = '';
var año_ = '';
var semanasMes = [];

var weeksCount = function (year, month_number) {
    var firstOfMonth = new Date(year, month_number - 1, 1);
    var day = firstOfMonth.getDay() || 6;
    day = day === 1 ? 0 : day;
    if (day) { day-- }
    var diff = 7 - day;
    var lastOfMonth = new Date(year, month_number, 0);
    var lastDate = lastOfMonth.getDate();
    if (lastOfMonth.getDay() === 1) {
        diff--;
    }
    var result = Math.ceil((lastDate - diff) / 7);
    return result + 1;
};

$('.btn-vista').on('click', function () {
    var tipo = '';
    if (!$(this).hasClass('active')) {
        $('.btn-vista').removeClass('active');
        $(this).addClass('active');
        tipo = $(this).attr('data-tipo');

        if (tipo == 'MENSUAL') {
            $(".my-calendar").removeClass('hide-element');
            $(".my-calendar2").addClass('hide-element');
        } else if (tipo == 'SEMANAL') {
            $(".my-calendar").addClass('hide-element');
            $(".my-calendar2").removeClass('hide-element');

            mes_ = parseInt($('#cbo_seleccion_mes').val()) + 1;
            año_ = $('#cbo_seleccion_mes').attr('data-año');

            semanasMes = [];

            var html_ = '';
            for (let i = 1; i < weeksCount(año_, mes_) + 1; i++) {
                semanasMes.push({ texto: 'semana ' + i, valor: i });
                html_ += '<option value="' + i + '">' + 'Semana ' + i + '</option>';
            }
            $('#cboSemanaFiltro').html(html_);

            listar_vista_semanal(mes_, año_, 1);
        }
    }
})

function recargar_vista_semanal() {
    mes_ = parseInt($('#cbo_seleccion_mes').val()) + 1;
    año_ = $('#cbo_seleccion_mes').attr('data-año');
    var semana = $('#cboSemanaFiltro').val();
    listar_vista_semanal(mes_, año_, semana);
}

function listar_vista_semanal(mes, año, semana) {
    var filtroDoctor = $('#cboDoctorFiltro').val();
    var primerDia;
    var ultimoDia;
    var response_;

    $.ajax({
        url: "/RegistroCitas/ver_fechas_por_semana?mes=" + mes + "&año=" + año + "&semana=" + semana,
        type: "GET",
        data: null,
        beforeSend: function () {
            $('#trigger_seleccion_mes').html($('#cbo_seleccion_mes').html());
        },
        success: function (response) {
            var listaFiltrada = response.filter(x => x.fecha != '');
            primerDia = listaFiltrada[0].fecha;
            ultimoDia = listaFiltrada[listaFiltrada.length - 1].fecha;
            response_ = response;
        },
        error: function (response) {
            
        },
        complete: function () {
            listarHorariosAdicionales(primerDia, ultimoDia, filtroDoctor, response_);
        }
    });
}

function listarHorariosAdicionales(inicio, fin, filtroDoctor, response2) {
    var data_horas = [
        '08:00 AM',
        '09:00 AM',
        '10:00 AM',
        '11:00 AM',
        '12:00 PM',
        '01:00 PM',
        '02:00 PM',
        '03:00 PM',
        '04:00 PM',
        '05:00 PM',
        '06:00 PM',
        '07:00 PM',
        '08:00 PM',
        '09:00 PM',
        '10:00 PM'
    ];

    var dias = [
        'Lun',
        'Mar',
        'Mier',
        'Jue',
        'Vie',
        'Sáb',
        'Dom'
    ];

    var html_hd = '<th style="width: 12.5%;"></th>';
    var html_bd = '';
    var i = 0;
    var lista = [];

    filtroDoctor = 11;

    $.ajax({
        url: '/RegistroCitas/ListarHorariosDoctor?inicio=' + inicio + '&fin=' + fin + '&id_doctor=' + filtroDoctor,
        type: "GET",
        data: {},
        success: function (data) {
            lista = data;
        },
        error: function (response) {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Ocurrió un error al obtener algunos registros.",
            });
            lista = [];
        },
        complete: function () {

            for (var dia of response2) {
                html_hd += '<th style="width: 12.5%;" class="' + (dia.fecha == '' ? 'header-semanal dia_inhabilitado' : 'header-semanal') + '">';
                html_hd += (dia.fecha == '' ? dias[i] : dias[i] + ' ' + fecha_formato_ddmmyyyy(dia.fecha) + '&nbsp;');
                html_hd += ver_btn_nueva_cita(dia.fecha);
                html_hd += '</th>';
                i++;
            }
            $('#hdTblSemanal > tr').html(html_hd);

            for (var hora of data_horas) {
                html_bd += '<tr>';
                html_bd += '<td>' + hora + '</td>';
                html_bd += '<td class="' + (response2[0].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[0].fecha == '' ? '' : (enviar_datos_zabuto(response2[0].fecha, hora)) + agregarHoraLibre(response2[0].fecha, hora, lista)) + '</td>';
                html_bd += '<td class="' + (response2[1].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[1].fecha == '' ? '' : (enviar_datos_zabuto(response2[1].fecha, hora)) + agregarHoraLibre(response2[1].fecha, hora, lista)) + '</td>';
                html_bd += '<td class="' + (response2[2].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[2].fecha == '' ? '' : (enviar_datos_zabuto(response2[2].fecha, hora)) + agregarHoraLibre(response2[2].fecha, hora, lista)) + '</td>';
                html_bd += '<td class="' + (response2[3].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[3].fecha == '' ? '' : (enviar_datos_zabuto(response2[3].fecha, hora)) + agregarHoraLibre(response2[3].fecha, hora, lista)) + '</td>';
                html_bd += '<td class="' + (response2[4].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[4].fecha == '' ? '' : (enviar_datos_zabuto(response2[4].fecha, hora)) + agregarHoraLibre(response2[4].fecha, hora, lista)) + '</td>';
                html_bd += '<td class="' + (response2[5].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[5].fecha == '' ? '' : (enviar_datos_zabuto(response2[5].fecha, hora)) + agregarHoraLibre(response2[5].fecha, hora, lista)) + '</td>';
                html_bd += '<td class="' + (response2[6].fecha == '' ? 'dia_inhabilitado' : '') + '">' + (response2[6].fecha == '' ? '' : (enviar_datos_zabuto(response2[6].fecha, hora)) + agregarHoraLibre(response2[6].fecha, hora, lista)) + '</td>';
                html_bd += '</tr>';
            }
            $('#bdTblSemanal').html(html_bd);
        }
    });

    return lista;
}

function agregarHoraLibre(fecha, hora, libres) {
    var html = '';
    if (libres.length > 0) {
        var libre = libres.filter(x => x.fecha_cita == fecha && x.hora_cita == hora);
        if (libre.length == 1) {
            html = '<div style="background-color: ' + (libre[0].tipo == 'REFRIGERIO' ? '#797c7c' : '#5c9d9d') + '; color: #FFFFFF; padding: 5px; font-size: 12px; border-radius: 5px;">' + libre[0].tipo + '<br>' + libre[0].hora_cita + '</div>';
        }
    }
    return html;
}

function ver_btn_nueva_cita(fecha){
    var dia_ = parseInt(fecha.slice(-2));
    var mes_ = parseInt(fecha.substring(0, 7).slice(-2));
    var año_ = parseInt(fecha.substring(0, 4));

    if (mes_ == 12) {
        mes_--;
    }

    var html = contenido_cita(dia_, mes_, año_, null);
    html = html.includes('btn_nueva_cita') ? html : '';
    return html;
}

function enviar_datos_zabuto(fecha, hora) {
    var dia_ = parseInt(fecha.slice(-2));
    var mes_ = parseInt(fecha.substring(0, 7).slice(-2));
    var año_ = parseInt(fecha.substring(0, 4));

    if (mes_ == 12) {
        mes_--;
    }

    var html = contenido_cita(dia_, mes_, año_, hora);
    html = (html == '-' ? '' : (html.includes('btn_nueva_cita') ? '' : html));
    return html;
}

$('.trigger_mes_anterior').on('click', function () {
    $('.nav_mes_anterior').trigger('click');
    $('#trigger_seleccion_mes').html($('#cbo_seleccion_mes').html());
    $('.btn-vista').trigger('click');
})

$('.trigger_mes_siguiente').on('click', function () {
    $('.nav_mes_siguiente').trigger('click');
    $('#trigger_seleccion_mes').html($('#cbo_seleccion_mes').html());
    $('.btn-vista').trigger('click');
})