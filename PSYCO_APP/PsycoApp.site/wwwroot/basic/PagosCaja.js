//var path = ruta;

var citas_seleccionadas = [];
var lista_citas = [];
var lista_historial = [];
var idPaciente = 0;
var idCita = 0;
var estado = "";
var fecha = "";

$(document).ready(function () {
    console.log("Documento listo");

    cargar_lista_doctores();

    const element = document.querySelector('#cboDoctor');
    const choices = new Choices(element, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const element = document.querySelector('#cboDoctor');
    const choices = new Choices(element, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
});

function cargar_lista_doctores() {
    console.log(1);
    var html = '';
    $.ajax({
        url: "/RegistroCitas/listar_doctores",
        type: "GET",
        data: {},
        async: false,
        beforeSend: function () {
            html += '<option value="-1">Todos</option>';

            $('#txtInicio, #txtFin').val(fechaActualYYYYMMDD());
        },
        success: function (data) {
            for (var item of data) {
                html += '<option value="' + item.id + '" data-sedes="' + item.sedes + '">' + item.nombre + '</option>';
            }
        },
        error: function (response) {
            html = '<option value="-1">Todos</option>';
        },
        complete: function () {
            $('#cboDoctor').html(html);
            cargar_historial();
        }
    });
}

cargar_lista_doctores();

function cargar_historial() {
    citas_seleccionadas = [];
    var html = '';

    var inicio = $('#txtInicio').val();
    var fin = $('#txtFin').val();
    var id_doctor = $('#cboDoctor').val();
    var id_estado = $('#cboEstado').val();
    var ver_sin_reserva = $('#cboVerSinReserva').val();
    var i = 1;
    var idPaciente = $('#cboPacientesPago').val();

    $.ajax({
        url: '/HistorialCitas/CitasDoctor?inicio=' + (inicio == '' ? '-' : inicio) + '&fin=' + (fin == '' ? '-' : fin) + '&id_doctor=' + id_doctor + '&id_estado=' + id_estado + '&ver_sin_reserva=' + ver_sin_reserva + '&idPaciente=' + idPaciente,
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
                    html += '<td class="text-center text-tbl">' + item.servicio + '</td>';
                    html += '<td class="text-center text-tbl">' + fecha_formato_ddmmyyyy(item.fecha_cita) + '</td>';
                    html += '<td class="text-center text-tbl">' + item.hora_cita + '</td>';
                    html += '<td class="text-center text-tbl">' + item.monto_pendiente_ + '</td>';
                    html += '<td class="text-center text-tbl">' + accion_estado(item.estado) + '</td>';
                    html += '<td class="text-center text-tbl">' + (item.monto_pendiente_ == 'S/.0.00' ? 'Pagado' : 'Pendiente') + '</td>';
                    //html += '<td class="text-center text-tbl">' + 'accion' + '</td>';
                    html += '<td class="text-center text-tbl">' + (item.monto_pendiente_ == 'S/.0.00' ? '' : '<button type="button" data-pendiente="' + item.monto_pendiente_.replace('S/.', '') + '" class="btn btn-doc cita-unselected btn-cita' + item.id_cita + '" onclick="accion_cita_pago(' + item.id_cita + ')"></button>') + '</td>';
                    html += '</tr>';
                    i++;
                }
            } else {
                html = '<tr><td colspan="10" class="text-center">No se encontraron resultados</td></tr>';
            }
            $('#bdCitasHist').html(html);
        }
    });
}

function accion_cita_pago(id_cita) {
    var cita = $('.btn-cita' + id_cita);
    var pendiente = cita.data('pendiente');

    if (cita.hasClass('cita-selected')) {
        cita.removeClass('cita-selected');
        citas_seleccionadas = citas_seleccionadas.filter(item => item.id_cita !== id_cita);
    } else {
        cita.addClass('cita-selected');
        citas_seleccionadas.push({ id_cita: id_cita, monto_pendiente: pendiente });
    }
}

function realizar_pago() {
    if (citas_seleccionadas.length == 0) {
        Swal.fire({
            icon: "Error",
            title: "Oops...",
            text: "Seleccione un pago para continuar.",
        });
        return;
    }

    const tbody = document.getElementById('tbodyCitas');
    tbody.innerHTML = "";

    citas_seleccionadas.forEach(item => {
        const tr = document.createElement("tr");

        tr.innerHTML = `<td class="tdMonto" data-id="${item.id_cita}">
                            <input class="form-control txtPendiente${item.id_cita}" type="text" value="${item.monto_pendiente}"
                            autocomplete="off" disabled="disabled" />
                        </td>
                        <td class="tdMonto">
                            <input class="form-control txtPagar${item.id_cita}" type="text" value="${item.monto_pendiente}"
                            autocomplete="off" />
                        </td>`;
        tbody.appendChild(tr);
    });
    $("[class*='txtPagar']").inputmask({
        alias: "numeric",
        allowMinus: false,
        digits: 2,
        max: 999.99,
        rightAlign: false
    });

    $(document).on("focusout", "[class*='txtPagar']", function () {
        console.log("focusout ejecutado:", this);
        setDecimalValue2(this);
    });

    $('#cboFormaPago_').val('-1').change();
    $('#mdl_pago_masivo').modal('show');
}

function validarSiEsTransferencia_() {
    var formaPago = $('#cboFormaPago_').val();
    if (formaPago == 1) {
        $('#cboDetalleTransferencia_').val(-1);
        $('#divDetalleTransferencia_').show();
    } else {
        $('#divDetalleTransferencia_').hide();
    }
}

function enviarPagos() {
    var pagosEnviar = [];
    if (!validarMontos()) {
        return;
    }

    $("#tbodyCitas tr").each(function () {
        const idCita = $(this).find("td").data('id');
        const inputPagar = $(this).find("input[class*='txtPagar']");
        let pagar = parseFloat(inputPagar.inputmask("unmaskedvalue")) || 0;
        pagosEnviar.push({idCita: idCita, totalPagar: pagar });
    });

    var id_forma_pago = $('#cboFormaPago_').val();
    var id_detalle_transferencia = $('#cboDetalleTransferencia_').val();
    var comentario = $('#txtComentario__').val() ? $('#txtComentario__').val().trim() : '';

    if (id_forma_pago == -1) {
        Swal.fire({icon: "warning", title: "Oops...", text: "Seleccione una forma de pago."});
        return;
    }

    if (id_forma_pago == 1 && id_detalle_transferencia == -1) {
        Swal.fire({icon: "warning", title: "Oops...", text: "Seleccione el detalle de transferencia."});
        return;
    }

    var data_ = {
        pagosEnviar: pagosEnviar,
        id_forma_pago: id_forma_pago,
        id_detalle_transferencia: id_detalle_transferencia,
        comentario: comentario
    };

    $.ajax({
        url: "/Caja/RegistrarPagoMasivo",
        type: "POST",
        data: data_,
        success: function (data) {
            if (data.estado) {
                Swal.fire({icon: "success", text: "Pago(s) registrado(s) exitosamente."});
                $('#mdl_pago_masivo').modal('hide');
                cargar_historial();
            } else {
                Swal.fire({icon: "error", title: "Oops...", text: data.descripcion});
            }
        },
        error: function (response) {
            Swal.fire({icon: "error", title: "Oops...", text: "Ocurrió un error al guardar los pagos."});
        },
        complete: function () { }
    });
}
function validarMontos() {
    let error = false;

    $("#tbodyCitas tr").each(function () {
        const inputPendiente = $(this).find("input[class*='txtPendiente']");
        const inputPagar = $(this).find("input[class*='txtPagar']");

        let pendiente = parseFloat(inputPendiente.inputmask("unmaskedvalue")) || 0;
        let pagar = parseFloat(inputPagar.inputmask("unmaskedvalue")) || 0;

        if (pagar === 0) {
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "El monto a pagar no puede ser 0.",
            });
            error = true;
            return false;
        }

        if (pagar > pendiente) {
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Los montos a pagar no pueden ser mayores a los montos pendientes.",
            });
            error = true;
            return false;
        }
    });
    return !error;
}

function accion_estado(estado) {
    var html_estado = '';
    var clase = (estado == 'REGISTRADO' ? 'btn_pendiente' : 'btn_atendido');

    html_estado += '<button type="button" class="btn btn-doc ' + clase + '">';
    html_estado += estado;
    html_estado += '</button>';

    return html_estado;
}

function accion_cita(esEvaluacion, paciente, monto_pendiente, id_paciente, id_cita, id_paquete, informe_adicional, dni, telefono) {
    var pendiente = monto_pendiente.replace('S/.', '');
    var html_accion = '';
    html_accion += '<span class="input-group-text" style="height: 100%; display: inline-block;">';
    html_accion += `<a href="#" title="Verificar pagos" onclick="form_pago('${paciente}','${pendiente}',${id_paciente},${id_cita}); return false;" style="cursor: pointer;">💳</a>`;
    html_accion += '</span>';
    console.log('esEvaluacion', esEvaluacion);
    if (esEvaluacion) {
        html_accion += '<span class="input-group-text" style="height: 100%; display: inline-block;">';
        html_accion += `<a href="#" title="Entrega de informe" onclick="form_informe(${id_paquete},'${informe_adicional}'); return false;" style="cursor: pointer;">📋</a>`;
        html_accion += '</span>';

        html_accion += '<span class="input-group-text" style="height: 100%; display: inline-block;">';
        html_accion += `<a href="#" title="Cita adicional" onclick="form_cita_adicional(${id_paquete},${id_paciente},'${paciente}','${dni}','${telefono}'); return false;" style="cursor: pointer;">📅</a>`;
        html_accion += '</span>';
    }
    return html_accion;
}
function GetFechaActual() {
    var d = new Date(), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
}

var idPaquete_ = 0;
function form_informe(id_paquete, informe_adicional) {
    if (informe_adicional == 'SI') {
        Swal.fire({
            icon: "Error",
            title: "Oops...",
            text: "El paquete ya tiene una entrega de informe asociada.",
        });
        return;
    }
    idPaquete_ = id_paquete;
    $('#mdl_informe').modal('show');
}

function agregarInformeAdicional() {
    var idInforme = $('#cboInformeAdicional').val();
    if (idInforme == '-1') {
        Swal.fire({
            icon: "Error",
            title: "Oops...",
            text: "Seleccione el informe que se asociará al paquete.",
        });
        return;
    }

    var obj = {
        id_cita: idInforme,
        id_paquete: idPaquete_
    };

    $.ajax({
        url: "/RegistroCitas/AgregarInforme",
        type: "POST",
        data: obj,
        success: function (data) {
            if (data.estado) {
                Swal.fire({
                    icon: "success",
                    text: "Registrado exitosamente.",
                });

                cerrar_form_informe();
                cargar_historial();
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
                text: "Ocurrió un error."
            });
        }
    });
}

function cerrar_form_informe() {
    $('#mdl_informe').modal('hide');
}

var nombrePaciente_ = '';
var mostrarPagosPendientes = false;
var idPaciente_ = 0;
function form_pago(nombrePaciente, pendiente, idPaciente, id_cita_) {
    nombrePaciente_ = nombrePaciente;
    idPaciente_ = idPaciente;
    mostrarPagosPendientes = false;

    $.ajax({
        url: "/Home/ObtenerConfiguracion",
        type: "GET",
        async: false,
        success: function (data) {
            if (data.length > 0) {
                for (var item of data) {
                    if (item.configKey == 'CAJA') {
                        if (item.configValue == '0') {
                            Swal.fire({
                                icon: "Error",
                                title: "Oops...",
                                text: "El registro de caja se encuentra deshabilitado, comunicarse con el administrador.",
                            });
                        } else {

                            var fechaActual = GetFechaActual();

                            if (pendiente == '0.00') {
                                setTimeout(() => {
                                    mostrarPagosPendientes = true;
                                    listar_pagos_pendientes(idPaciente);
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
                            $('#txtComentario').val('');
                            validarSiEsTransferencia();

                            $("#txtMonto1, #txtMonto2, #txtMonto3").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });
                            $('#txtMonto1').val('0.00');    //importe pago
                            $('#txtMonto2').val(pendiente); //pendiente
                            $('#txtMonto3').val(pendiente); //diferencia

                        }
                    }
                }
            }
        },
        error: function (response) {
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al obtener la información."
            });
        }
    });
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

function cerrar_modal_pagos_pendientes() {
    $('#mdl_otros_pagos_pendientes').modal('hide');
}

function ver_datos_pago_pendiente(e) {
    var id_cita = $(e).attr('id');
    var pactado = $(e).attr('pactado').replace('S/.', '');
    var pagado = $(e).attr('pagado').replace('S/.', '');
    var pendiente = $(e).attr('pendiente').replace('S/.', '');

    $('#mdl_otros_pagos_pendientes').modal('hide');
    var fechaActual = GetFechaActual();

    setTimeout(() => {
        $('#mdl_pago').modal('show');
    }, 250);

    $('#txtIdCita').val(id_cita);
    $('#txtFechaPago').val(fecha_formato_ddmmyyyy(fechaActual));
    $('#txtPaciente').val(nombrePaciente_);
    $('#cboFormaPago').val(-1);
    validarSiEsTransferencia();

    $("#txtMonto1, #txtMonto2, #txtMonto3").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });
    $('#txtMonto1').val('0.00');    //importe pago
    $('#txtMonto2').val(pendiente); //pendiente
    $('#txtMonto3').val(pendiente); //diferencia
}

function setDecimalValue2(input) {
    let valor = $(input).inputmask("unmaskedvalue") || 0;
    valor = parseFloat(valor);
    $(input).val(formatDecimal(valor));
}

function setDecimalValue() {
    setTimeout(() => {
        var monto1 = $('#txtMonto1').val();
        $('#txtMonto1').val(formatDecimal(monto1));
    }, 200);
}

function formatDecimal(num) {
    return (Math.round(num * 100) / 100).toFixed(2);
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
    if (mostrarPagosPendientes) {
        setTimeout(() => {
            $('#mdl_otros_pagos_pendientes').modal('show');
        }, 250);
    }
}

function guardar_pago() {
    setTimeout(() => {
        var id_forma_pago = $('#cboFormaPago').val();
        var id_detalle_transferencia = $('#cboDetalleTransferencia').val();
        var importe = $('#txtMonto1').val();
        var comentario = null;

        if ($('#txtComentario').val()) {
            comentario = $('#txtComentario').val().trim();
        } else {
            comentario = '';
        }

        if (id_forma_pago == -1) {
            Swal.fire({ icon: "warning", title: "Oops...", text: "Seleccione una forma de pago.", });
            return;
        }

        if (id_forma_pago == 1 && id_detalle_transferencia == -1) {
            Swal.fire({ icon: "warning", title: "Oops...", text: "Seleccione el detalle de transferencia.", });
            return;
        }

        if (importe == '0.00' || (importe != '' && !isPrecise(importe))) {
            Swal.fire({ icon: "warning", title: "Oops...", text: "Para registrar el pago debe ingresar un importe de pago válido.", });
            return;
        }

        var data_ = {
            id_cita: $('#txtIdCita').val(),
            id_forma_pago: id_forma_pago,
            id_detalle_transferencia: id_detalle_transferencia,
            importe: importe,
            comentario: comentario
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

                    cerrar_modal_pago();
                    listar_pagos_pendientes(idPaciente_);
                    cargar_historial();
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
            },
            complete: function () {
            }
        });

    }, 500);
}

function isPrecise(num) {
    return String(num).split(".")[1]?.length == 2;
}

//function accion_cita(estado, id_usuario, fecha, id_cita) {
//    var html_accion = '';

//    html_accion += '<button type="button" class="btn btn-doc second_color" style="color: #FFF; font-size: 12px;" data-id-cita="' + id_cita + '" data-fecha="' + fecha + '" data-estado="' + estado + '" data-id-usuario="' + id_usuario + '" title="Ver registro" onclick="ver_detalle(this)">';
//    html_accion += '<i class="fa fa-edit"></i>';
//    html_accion += '</button>';

//    return html_accion;
//}

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
    console.log(12);
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
                    html += '<tr class="' + clase + '"' + accion + '><td class="text-center">' + item.hora_cita_mostrar + '</td><td class="text-center">' + item.estado + '</td></tr>';
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
    console.log(12);
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
                    html += '<tr class="' + clase + '"' + accion + '><td class="text-center">' + item.hora_cita_mostrar + '</td><td class="text-center">' + item.estado + '</td></tr>';
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
        Swal.fire({
            icon: "Error",
            title: "Oops...",
            text: "Ya hay una cita registrada en el horario seleccionado.",
        });
        //alerta("Ya hay una cita registrada en el horario seleccionado.", 'info');
        $('#txtHora').val('');
        return;
    } else {
        hora = hora.replace(' am', ' AM');
        hora = hora.replace(' pm', ' PM');
        $('#txtHora').val(hora);
    }
}

let currentPage = 1;
let searchTerm = '';
let debounceTimer;
let choicesT;
document.addEventListener('DOMContentLoaded', function () {
    const elementT = document.querySelector('#cboPacientesPago');

    if (elementT != null) {
        choicesT = new Choices(elementT, {
            placeholder: true,
            searchPlaceholderValue: "Buscar...",
            itemSelectText: "",
        });

        elementT.addEventListener('search', function (event) {
            const inputValue = event.detail.value;

            clearTimeout(debounceTimer);
            if (inputValue.length >= 4) {
                debounceTimer = setTimeout(() => {
                    searchPatients(inputValue);
                }, 300);
            }
            if (inputValue.length === 0) {
                loadPatients('', currentPage);
                return;
            }
        });

        loadPatients('', currentPage);
    }
});

function searchPatients(filtro) {
    $.ajax({
        url: `/RegistroCitas/listar_pacientes_dinamico?filtro=${filtro}&page=1&pageSize=10&IdBusqueda=false`,
        type: "GET",
        beforeSend: function () {
            choicesT.clearChoices();
            choicesT.setChoices([
                { value: "-1", label: "Buscando...", disabled: true }
            ]);
        },
        success: function (res) {

            if (res && res.length > 0) {

                const pacientes = res.map(item => ({
                    value: item.id,
                    label: item.nombre
                }));

                choicesT.clearChoices();
                choicesT.setChoices(pacientes, "value", "label", true);

            } else {

                choicesT.clearChoices();
                choicesT.setChoices([
                    { value: "-1", label: "No se encontraron pacientes", disabled: true }
                ]);

            }
        },
        error: function () {
            choicesT.clearChoices();
            choicesT.setChoices([
                { value: "-1", label: "Error al buscar pacientes", disabled: true }
            ]);
        }
    });
}

function loadPatients(filtro = "", page) {
    $.ajax({
        url: `/RegistroCitas/listar_pacientes_dinamico?filtro=${filtro}&page=${page}&pageSize=10&IdBusqueda=false`,
        type: "GET",
        beforeSend: function () {
            choicesT.clearChoices();
            choicesT.setChoices([
                { value: "-1", label: "Cargando...", disabled: true }
            ]);
        },
        success: function (res) {

            const pacientes = res.map(item => ({
                value: item.id,
                label: item.nombre
            }));

            choicesT.clearChoices();
            choicesT.setChoices(pacientes, "value", "label", true);
        },
        error: function () {
            choicesT.clearChoices();
            choicesT.setChoices([
                { value: "-1", label: "Error al cargar", disabled: true }
            ]);
        }
    });
}