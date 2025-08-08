var path = ruta;

var lista_citas = [];
var lista_horarios = [];
var id_cita_ = 0;
var id_paciente_ = 0;
var estado_ = '';
var sesiones = 0;
var adicionales = [];
let choicesT; // Variable global
var person_img = path + '/images/user.png';
var recargar_pagos_pendientes = false;
let currentPage = 1;
const pageSize = 10; // Tamaño de la página fijo
let searchTerm = '';
let debounceTimer;
let pago_gratis_;

$('#cboPaciente').on('change', function () {
    var idPaciente = $(this).val();

    $.ajax({
        url: "/Mantenimiento/Paciente/Get/" + idPaciente,
        type: "GET",
        async: false,
        beforeSend: function () {
            $('#txtTelefono, #txtDniPaciente').val('--');
        },
        success: function (data) {
            if (data == null) {
                $('#txtTelefono, #txtDniPaciente').val('--');
            } else {
                $('#txtTelefono').val(data.telefono);
                $('#txtDniPaciente').val(data.documentoNumero);
            }
        },
        error: function (response) {
            $('#txtTelefono, #txtDniPaciente').val('--');
        }
    });
})
document.addEventListener('DOMContentLoaded', function () {
  
    const element = document.querySelector('#cboDoctorFiltro');
    const choices = new Choices(element, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
    const elementT = document.querySelector('#cboPacienteFiltro');
    choicesT = new Choices(elementT, {
        placeholder: true,
        searchPlaceholderValue: "Buscar...",
        itemSelectText: "Todos",
    });
 
    // Código de eventos y carga de pacientes

    elementT.addEventListener('search', function (event) {
        const inputValue = event.detail.value;
        clearTimeout(debounceTimer); // Limpiar el timer anterior

        if (inputValue.length >= 4) { // Solo realizar la búsqueda si el filtro tiene 4 o más caracteres
            debounceTimer = setTimeout(() => {
                searchTerm = inputValue;
                currentPage = 1; // Resetear a la primera página cuando se realiza una nueva búsqueda
                choicesT.clearChoices(); // Limpiar las opciones actuales
                searchPatients(searchTerm, currentPage); // Cargar los pacientes con el filtro
            }, 300); // 300ms de debounce
        }

    });

    // Evento para cargar más pacientes cuando el usuario llega al final de la lista
    elementT.addEventListener('choices:add', function () {
        const isNearEnd = elementT.scrollHeight - elementT.scrollTop === elementT.clientHeight;
        if (isNearEnd && searchTerm.length >= 4) {
            currentPage++; // Aumentar el número de página
            
            searchPatients(searchTerm, currentPage); // Cargar la siguiente página
        }
    });

    // Inicializar con los primeros pacientes (vacío al principio o con un filtro inicial)
    loadPatients('', currentPage);
});
$(document).ready(function () {

    $('#cboDoctorFiltro').change(function () {
        console.log('prueba32');
        var doctorSeleccionado = parseInt($(this).val(), 10);  // O usa parseFloat si el valor es decimal

        // Asignar ese valor numérico al cboDoctor
        // Asignar ese valor al campo oculto
        $('#hiddenDoctor').val(doctorSeleccionado);

    });
    var idSede = document.getElementById("hiddenIdSede").value;

    // Establece el valor seleccionado en el <select>
    var select = document.getElementById("cboSedeFiltro");
 
    select.value = idSede;

    console.log('prueba3');
    $('#cboServicio').on('change', function () {
        $('.fechasAdicionales').addClass('hide-element');
        sesiones = $(this).find(':selected').attr('data-sesiones');
        if (sesiones > 0) {
            $('.fechasAdicionales').removeClass('hide-element');
            $('#divHorarios').addClass('hide-element');
        } else {
            $('#divHorarios').removeClass('hide-element');
        }

        var fechaInicial = $('#txtFecha').val();
        var html = '';
        var disabled = id_cita_ > 0 ? 'disabled="disabled"' : '';

        for (var i = 0; i < sesiones; i++) {
            var fecha = addDays(parseDate(fecha_yyyyMMdd(fechaInicial)), i*7);
            html += '<tr>';
            html += '<td><input class="form-control fechaAd active-input-modulo" type="date" id="txtFecha' + i + '" autocomplete="off" max="2050-12-31" min="2022-08-01" value="' + formatDateISO(fecha) + '" onkeydown="return false" ' + disabled + ' /></td>';

            html += '<td><select class="form-control horarioAd active-select-modulo" id="cboHorario' + i + '">' + obtener_horarios_fecha(formatDateISO(fecha)) + '</select></td>';

            html += '</tr>';
        }
        $('#bdFechas').html(html);
    })
   
});

var obtener_horarios_fecha = function (fecha) {
    var doctor = $('#cboDoctor').val();
    var html = '';

    $.ajax({
        url: "/RegistroCitas/DisponibilidadDoctor?id_doctor=" + doctor + "&fecha=" + fecha,
        type: "GET",
        async: false,
        beforeSend: function () {
            html = '<option value="-1">Seleccionar horario</option>';
        },
        success: function (data) {
            if (data.length > 0) {
                for (item of data) {
                    html += '<option value="' + (item.estado == 'DISPONIBLE' ? item.hora_cita : item.estado) + '">' + (item.estado == 'DISPONIBLE' ? item.hora_cita : item.estado) + '</option>';
                }
            }
        },
        error: function (response) {
            html = '<option value="-1">Seleccionar horario</option>';
        }
    });
    return html;
}

function searchPatientsModal(filtro) {
    console.log("Buscando pacientes con filtro:", filtro);

    // Llamada AJAX para búsqueda dinámica
    $.ajax({
        url: `/RegistroCitas/listar_pacientes_dinamico?filtro=${filtro}&page=1&pageSize=10`,
        type: "GET",
        beforeSend: function () {
           
            if (choicesT) {
                choicesT.destroy();
            }

            const selectElement = document.querySelector('#cboPacienteFiltro');
            choicesT = new Choices(selectElement, {
                searchEnabled: true, // Habilita la barra de búsqueda dentro del combo
                itemSelectText: "",
            });

            choicesT.setChoices([
                { value: "-1", label: "Buscando...", disabled: true },
            ]);
        },
        success: function (res) {
            if (res && res.length > 0) {
                const pacientes = res.map((item) => ({
                    value: item.id,
                    label: item.nombre,
                }));

                // Actualizar combo con resultados de búsqueda
                choicesT.setChoices(pacientes, "value", "label", true);
                choicesT.setChoiceByValue(parseInt(filtro));
            } else {
                // Sin resultados
                choicesT.setChoices([
                    { value: "-1", label: "No se encontraron pacientes", disabled: true },
                ]);
            }
        },
        error: function () {
            // Error en la búsqueda
            choicesT.setChoices([
                { value: "-1", label: "Error al buscar pacientes", disabled: true },
            ]);
        },
    });
}
function searchPatients(filtro) {
    console.log("Buscando pacientes con filtro:", filtro);

    // Llamada AJAX para búsqueda dinámica
    $.ajax({
        url: `/RegistroCitas/listar_pacientes_dinamico?filtro=${filtro}&page=1&pageSize=10`,
        type: "GET",
        beforeSend: function () {
            // Limpiar opciones actuales antes de mostrar resultados de búsqueda
            choicesT.clearChoices();
            choicesT.setChoices([
                { value: "-1", label: "Buscando...", disabled: true },
            ]);
        },
        success: function (res) {
            if (res && res.length > 0) {
                const pacientes = res.map((item) => ({
                    value: item.id,
                    label: item.nombre,
                }));

                // Actualizar combo con resultados de búsqueda
                choicesT.setChoices(pacientes, "value", "label", true);
            } else {
                choicesT.setChoices([
                    { value: "-1", label: "No se encontraron pacientes", disabled: true },
                ]);
            }
        },
        error: function () {
            choicesT.setChoices([
                { value: "-1", label: "Error al buscar pacientes", disabled: true },
            ]);
        },
    });
}
function loadPatients(filtro= "", page) {
    console.log('pacientes');

    var html = '';
    $.ajax({
        url: `/RegistroCitas/listar_pacientes_dinamico?filtro=${filtro}&page=${page}&pageSize=10`,
        type: "GET",
        data: {},
        async: false,
        beforeSend: function () {
            html += '<option value="-1">Seleccionar</option>';
        },
        success: function (res) {
            for (var item of res) {
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

function seleccionarPaciente(id) {
    console.log('choices');    
    
    debounceTimer = setTimeout(() => {
        currentPage = 1; // Resetear a la primera página cuando se realiza una nueva búsqueda
        choicesT.clearChoices(); // Limpiar las opciones actuales
        searchPatientsModal(String(id), currentPage); // Cargar los pacientes con el filtro
        choicesT.setChoiceByValue(id);
        /*recargar_citas_dinamico(String(id));*/
        recargar_citas();
    }, 300); // 300ms de debounce

    //var pac = $("#cboPacienteFiltro option[value='" + id + "']").text();
    //alert(pac);

    $('#pacientesModal').modal('hide');
}
function addDays(date, days) {
    const newDate = new Date(date);
    newDate.setDate(date.getDate() + days);
    return newDate;
}

function formatDateISO(date) {
    const isoString = date.toISOString();
    const formattedDate = isoString.split("T")[0];
    return formattedDate;
};

function verFechasAdicionales() {
    $('#mdl_adicionales_').modal('show');
}

function recargar_citas() {
    var tipoVista = TipoVista();
    if (tipoVista == 'MENSUAL') {
        $('.calendar-container').html('<div id="my-calendar"></div>');
    }
    cargar_citas();
}
function recargar_citas_dinamico(id) {
    var tipoVista = TipoVista();
    if (tipoVista == 'MENSUAL') {
        $('.calendar-container').html('<div id="my-calendar"></div>');
    }
    cargar_citas_dinamico(id);
}
function TipoVista() {
    var tipoVista = $('.btn-vista.active').attr('data-tipo');
    return tipoVista;
}
function cargar_citas_dinamico(id) {
    $("#txtMontoPactado, #txtMontoPagado, #txtMontoPendiente").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });

    var filtroPaciente = id;
    var filtroDoctor = $('#cboDoctorFiltro').val();
    var filtroSede = $('#cboSedeFiltro').val();
    var tipoVista = TipoVista();

    $.ajax({
        url: '/RegistroCitas/CitasUsuario?idPaciente=' + filtroPaciente + '&idDoctor=' + filtroDoctor + '&idSede=' + filtroSede + '&tipoVista=' + tipoVista,
        type: "GET",
        data: {},
        beforeSend: function () {
            $('.preloader').removeAttr('style');
            $('.preloader').removeClass('hide-element');
        },
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
            $('.preloader').removeAttr('style');
            $('.preloader').removeClass('hide-element');

            if (tipoVista == 'MENSUAL') {
                $("#my-calendar").zabuto_calendar({
                    legend: []
                });
            } else if (tipoVista == 'SEMANAL') {
                recargar_vista_semanal()
            }
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
function cargar_citas() {
    $("#txtMontoPactado, #txtMontoPagado, #txtMontoPendiente").inputmask({ 'alias': 'numeric', allowMinus: false, digits: 2, max: 999.99 });

    var filtroPaciente = $('#cboPacienteFiltro').val();
    var filtroDoctor = $('#cboDoctorFiltro').val();
    var filtroSede = $('#cboSedeFiltro').val();
    var tipoVista = TipoVista();

    $.ajax({
        url: '/RegistroCitas/CitasUsuario?idPaciente=' + filtroPaciente + '&idDoctor=' + filtroDoctor + '&idSede=' + filtroSede + '&tipoVista=' + tipoVista,
        type: "GET",
        data: {},
        beforeSend: function () {
            $('.preloader').removeAttr('style');
            $('.preloader').removeClass('hide-element');
        },
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
            $('.preloader').addClass('hide-element');
            if (tipoVista == 'MENSUAL') {
                $("#my-calendar").zabuto_calendar({
                    legend: []
                });
            } else if (tipoVista == 'SEMANAL') {
                recargar_vista_semanal()
            }
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
function copiarOpciones() {
    let cboOrigen = document.getElementById("cboPacienteFiltro");
    let cboDestino = document.getElementById("cboPaciente");

    if (cboOrigen.value.toString() != '-1') {
        // Limpiar opciones previas en el destino
        cboDestino.innerHTML = "";

        // Copiar todas las opciones
        cboOrigen.querySelectorAll("option").forEach(option => {
            let nuevaOpcion = document.createElement("option");
            nuevaOpcion.value = option.value;
            nuevaOpcion.textContent = option.textContent;
            cboDestino.appendChild(nuevaOpcion);
        });

        // Mantener el atributo `data-id-paciente`
        cboDestino.setAttribute("data-id-paciente", cboOrigen.value);

        // Seleccionar en el destino el mismo valor que está seleccionado en el origen
        cboDestino.value = cboOrigen.value;
        console.log('cambiado');
    }
}


function ver_cita(e) {
    console.log('ver cita');
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
    var id_sede = $(e).attr('data-id-sede');
    var feedback = $(e).attr('data-feedback');
    var comentario = $(e).attr('data-comentario');
    var pago_gratis = $(e).attr('data-pago-gratis');
    var dni_paciente = $(e).attr('data-dni-paciente');
    if (id_especialista == -1) {
        if ($('#hiddenDoctor').val() != null && $('#hiddenDoctor').val() != '') {
            id_especialista = $('#hiddenDoctor').val();
        }
    }
    
    cargar_datos_cita(id_cita, id_especialista, id_paciente, fecha_cita, hora_Cita, estado, telefono, moneda, formatDecimal(monto_pactado), formatDecimal(monto_pagado), formatDecimal(monto_pendiente), id_servicio, id_sede, feedback, comentario, pago_gratis, dni_paciente);

    setTimeout(() => {
        copiarOpciones();
    }, 1000);
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

function cerrar_modal_fechas_adicionales() {
    $('#mdl_adicionales_').modal('hide');
}

function validar_modal_fechas_adicionales() {
    adicionales = [];
    var error = '';

    if (sesiones > 0) {
        for (var i = 0; i <= sesiones; i++) {
            if (error == '') {
                var fecha = $('#txtFecha' + i).val();
                var hora = $('#cboHorario' + i).val();
                if (hora == '-1' || hora == 'REFRIGERIO') {
                    error = 'ERROR';
                } else {
                    adicionales.push({ fecha: fecha, hora: hora });
                }
            }
        }
    }

    if (error == '') {
        Swal.fire({
            icon: "success",
            text: "Horarios validados correctamente.",
        });
    } else {
        adicionales = [];
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione horarios válidos para las citas.",
        });
    }
    
}

function guardar_pago() {
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
        importe: importe.replace('.', ','),
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

                if (!recargar_pagos_pendientes) {
                    cerrar_modal_pago();

                    var pactado = $('#txtMontoPactado').val();
                    var pagado = $('#txtMontoPagado').val();

                    $('#txtMontoPagado').val(formatDecimal(parseFloat(pagado) + parseFloat(importe)));
                    $('#txtMontoPendiente').val(formatDecimal(parseFloat(pactado) - (parseFloat(pagado) + parseFloat(importe))));

                    //$('#cita' + id_cita_).attr('data-monto-pactado', '');
                    $('#cita' + id_cita_).attr('data-monto-pagado', formatDecimal(parseFloat(pagado) + parseFloat(importe)));
                    $('#cita' + id_cita_).attr('data-monto-pendiente', formatDecimal(parseFloat(pactado) - (parseFloat(pagado) + parseFloat(importe))));
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

function setDecimalValue() {
    setTimeout(() => {
        var monto1 = $('#txtMonto1').val();
        $('#txtMonto1').val(formatDecimal(monto1));
    }, 200);
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

function cargar_datos_cita(id_cita, id_doctor, id_paciente, fecha, hora, estado, telefono, moneda, monto_pactado, monto_pagado, monto_pendiente, id_servicio, id_sede, feedback, comentario, pago_gratis, dni_paciente) {
    $('#btnResumen').trigger('click');
    $('#ulTabs').hide();
    $('.fechasAdicionales').addClass('hide-element');

    $('#txtFecha').attr('data-fecha', fecha).val(fecha_formato_ddmmyyyy(fecha));
    $('#txtHora').val(hora).attr('data-hora', hora);
    $('#cboDoctor').val(id_doctor).attr('data-id-doctor', id_doctor);
    $('#cboPaciente').val(id_paciente).attr('data-id-paciente', id_paciente);
    $('#txtTelefono').val(telefono).attr('data-telefono', telefono);
    $('#txtDniPaciente').val(dni_paciente).attr('data-dni-paciente', dni_paciente);
    $('#txtMontoPactado').val(monto_pactado).attr('data-monto-pactado', monto_pactado);
    $('#txtMontoPagado').val(monto_pagado).attr('data-monto-pagado', monto_pagado);
    $('#txtMontoPendiente').val(monto_pendiente).attr('data-monto-pendiente', monto_pendiente);
    $('#cboServicio, #cboServicioActualizar').val(id_servicio);
    $('#btnEstado').html(estado == '-' ? 'POR CITAR' : estado);

    $('#btnEstado').attr('class', 'evento_' + (estado == '-' ? 'CITADO' : estado).toLowerCase().replace(' ', '_'));
    $('#spnPactado').html('Monto pactado (' + moneda + ')');
    $('#spnPagado').html('Monto pagado (' + moneda + ')');
    var btnAbonar = (estado == 'EN PROCESO' ? '&nbsp;<img id="PagoPendiente" src="../images/warning.jpg" style="height: 15px; width: auto; cursor: pointer;" title="Verificar pagos" onclick="form_pago()" />' : '');
    $('#spnPendiente').html('Monto pendiente (' + moneda + ')' + btnAbonar);
    pago_gratis_ = pago_gratis;
    
    $('#cboDoctor, #cboPaciente, #txtHora, #cboServicio, #cboSedeChange, #cboTipoCita').removeAttr('disabled');
    // Asignar el feedback
    if (feedback) { // Si feedback es true, es "sad"
        $('#sad').prop('checked', true);
        toggleComment(true); // Mostrar el área de comentarios
    } else { // Si feedback es false, es "happy"
        $('#happy').prop('checked', true);
        toggleComment(false); // Ocultar el área de comentarios
    }
    $('#comment').val(comentario);
    $('.divMonto').hide();

    $('#divPagoGratis').hide();
    $('#ImgActualizarServicio').hide();

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
            $('#divAtender, #btnCancelar, #divPagoPendiente, #ImgActualizarServicio').show();
            $('#divReprogramar, #divHorarios, .divConfirmar').hide();
            
            if (pago_gratis == 'false' || pago_gratis == false || !pago_gratis) {
                $('#divPagoGratis').show();
            }
        } else if (estado == 'ATENDIDO') {
            $('#divReprogramar, #divHorarios, .divConfirmar, #divAtender, #btnCancelar, #divPagoPendiente').hide();
        }
    }

    estado_ = estado;
    id_cita_ = id_cita;
    id_paciente_ = id_paciente;

    verificar_si_es_psicologo();
    verificar_disponibilidad();
    mostrar_historial(id_cita, id_paciente);
    validar_sede_usuario(id_doctor, id_sede);
}

function mostrar_historial(id_cita, id_paciente) {
    var html = '';
    var html2 = '';

    var historial = [];
    var historial2 = [];

    $.ajax({
        url: "/RegistroCitas/Historial?idCita=" + id_cita + "&idPaciente=" + id_paciente,
        type: "GET",
        async: false,
        beforeSend: function () {
            historial = [];
            historial2 = [];
        },
        success: function (data) {
            historial = data.historial1;
            historial2 = data.historial2;
        },
        error: function (response) {
            historial = [];
            historial2 = [];
        },
        complete: function () {
            try {
                for (var item of historial) {
                    html += '<div class="sb-reg-citas-popup-tab-historial-block"><div class="sb-reg-citas-popup-tab-historial-block-item">';
                    html += '<p>' + item.fecha + '</p>';
                    html += '</div>';
                    html += '<div class="sb-reg-citas-popup-tab-historial-block-item-2">';
                    html += '<button type="button" class="evento_' + item.evento.toLowerCase().replace(' ', '_') + '">' + item.evento + '</button>';
                    html += '<div class="sb-reg-citas-historial-user" ><p>Usuario: </p><span>' + item.usuario + '</span></div>';
                    html += '</div></div>';
                }

                if (historial2.length > 0) {
                    for (var item of historial2) {
                        html2 += '<tr>';
                        html2 += '<td>' + item.doctor + '</td>';
                        html2 += '<td>' + item.fecha_registro + '</td>';
                        html2 += '</tr>';
                    }
                } else {
                    html2 += '<tr style="text-align: center;">';
                    html2 += '<td colspan="2">Sin registros</td>';
                    html2 += '</tr>';
                }
            } catch (e) {
                html = '';
                html2 = '';
            }
            $('#divHistorial').html(html);
            $('#divHistorial2').html(html2);
        }
    });

    //try {
    //    var historial = lista_citas.filter(x => x.id_cita == parseInt(id_cita))[0].historial;
    //    var historial2 = lista_citas.filter(x => x.id_cita == parseInt(id_cita))[0].historial2;
    //    for (var item of historial) {
    //        html += '<div class="sb-reg-citas-popup-tab-historial-block"><div class="sb-reg-citas-popup-tab-historial-block-item">';
    //        html += '<p>' + item.fecha + '</p>';
    //        html += '</div>';
    //        html += '<div class="sb-reg-citas-popup-tab-historial-block-item-2">';
    //        html += '<button type="button" class="evento_' + item.evento.toLowerCase().replace(' ', '_') + '">' + item.evento + '</button>';
    //        html += '<div class="sb-reg-citas-historial-user" ><p>Usuario: </p><span>' + item.usuario + '</span></div>';
    //        html += '</div></div>';
    //    }

    //    for (var item of historial2) {
    //        html2 += '<tr>'
    //        html2 += '<td>' + item.doctor + '</td>'
    //        html2 += '<td>' + item.fecha_registro + '</td>'
    //        html2 += '</tr>'
    //    }
    //} catch (e) {
    //    html = '';
    //    html2 = '';
    //}
    //$('#divHistorial').html(html);
    //$('#divHistorial2').html(html2);
}

function modal_historial_pago(mostrar) {
    alert(id_cita_);
    if (mostrar) {
        $('#mdl_cita').modal('hide');
        $('#mdl_historial_pago').modal('show');
    } else {
        $('#mdl_cita').modal('show');
        $('#mdl_historial_pago').modal('hide');
    }
    mostrar_historial_pago(id_cita_);
}

function mostrar_historial_pago(id_cita) {
    var html = '';
    var historial = [];

    if (id_cita > 0) {
        $.ajax({
            url: "/RegistroCitas/HistorialPago?id_cita=" + id_cita,
            type: "GET",
            async: false,
            beforeSend: function () {
                historial = [];
            },
            success: function (data) {
                historial = data;
            },
            error: function (response) {
                historial = [];
            },
            complete: function () {
                try {
                    if (historial.length > 0) {
                        for (var item of historial) {
                            html += '<tr>';
                            html += '<td>' + item.paciente + '</td>';
                            html += '<td>' + item.sede + '</td>';
                            html += '<td>' + item.fecha_transaccion + '</td>';
                            html += '<td>' + item.estado_cita + '</td>';
                            html += '<td>' + item.servicio + '</td>';
                            html += '<td>' + item.forma_pago + '</td>';
                            html += '<td>' + item.detalle_transferencia + '</td>';
                            html += '<td>' + item.importe + '</td>';
                            html += '<td>' + item.usuario + '</td>';
                            html += '<td>' + item.estado_orden + '</td>';
                            html += '</tr>';
                        }
                    } else {
                        html += '<tr style="text-align: center;">';
                        html += '<td colspan="10">Sin registros</td>';
                        html += '</tr>';
                    }
                } catch (e) {
                    html = '';
                }
                $('#divHistorial3').html(html);
            }
        });
    } else {
        html += '<tr style="text-align: center;">';
        html += '<td colspan="10">Sin registros</td>';
        html += '</tr>';
        $('#divHistorial3').html(html);
    }
}
function guardarPacienteCitas() {
    console.log('prueba');
    let paciente = {
        Id: parseInt($('#hdnPacienteId').val()) || 0,
        Nombre: $('#txtNombre').val(),
        Apellido: $('#txtApellido').val(),
        FechaNacimiento: $('#txtFechaModalPaci').val(),
        Estado: $('#cboEstado').val(),
        DocumentoTipo: $('#cboDocumento').val(),
        DocumentoNumero: $('#txtDocumentoModalPaci').val(),
        Telefono: $('#txtTelefonoModalPaci').val(),
        EstadoCivil: $('#cboEstadoCivil').val(),
        Sexo: $('#cboSexo').val(),
    };

    searchPatients(String(paciente.Id), currentPage);
    let url = paciente.Id ? '/Mantenimiento/Paciente/Editar' : '/Mantenimiento/Paciente/Agregar';
    $.ajax({
        type: 'POST',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(paciente), // Aquí no envías dentro de un objeto
        success: function (response) {
            Swal.fire({
                icon: "success",
                title: "Registro completo.",
            });
            $('#containerFormulario').hide();
            $(".sb-admninistrator").css('overflow', 'auto');
            buscarPaciente(); // Actualiza la lista después de guardar
            cargar_lista_pacientes_modal();

        },
        error: function (xhr) {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Debe rellenar todos los campos!",
            });
        }
    });
}

function guardarPaciente() {
    console.log('prueba');
    let paciente = {
        Id: parseInt($('#hdnPacienteId').val()) || 0,
        Nombre: $('#txtNombre').val(),
        Apellido: $('#txtApellido').val(),
        FechaNacimiento: $('#txtFechaModalPaci').val(),
        Estado: $('#cboEstado').val(),
        DocumentoTipo: $('#cboDocumento').val(),
        DocumentoNumero: $('#txtDocumentoModalPaci').val(),
        Telefono: $('#txtTelefonoModalPaci').val(),
        EstadoCivil: $('#cboEstadoCivil').val(),
        Sexo: $('#cboSexo').val(),
    };

    let url = paciente.Id ? '/Mantenimiento/Paciente/Editar' : '/Mantenimiento/Paciente/Agregar';
    $.ajax({
        type: 'POST',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(paciente), // Aquí no envías dentro de un objeto
        success: function (response) {
            Swal.fire({
                icon: "success",
                title: "Registro completo.",
            });
            $('#containerFormulario').hide();
            $(".sb-admninistrator").css('overflow', 'auto');
            buscarPaciente(); // Actualiza la lista después de guardar
        },
        error: function (xhr) {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Debe rellenar todos los campos!",
            });
        }
    });
}
function cargar_lista_pacientes_modal() {
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
            // Reemplaza el contenido del select
            $('#cboPaciente').html(html);
            $('#cboPacienteFiltro').html(html);

            // Reinicializa Choices.js
            if (typeof choicesT !== 'undefined') {
                choicesT.destroy(); // Destruye la instancia existente
            }

            const elementT = document.querySelector('#cboPacienteFiltro');
            choicesT = new Choices(elementT, {
                placeholder: true,
                searchPlaceholderValue: "Buscar...",
                itemSelectText: "Todos",
            });


        }
    });
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
loadPatients();
/*cargar_lista_pacientes();*/
function cargar_lista_doctores() {
    var html = '';
    $.ajax({
        url: "/RegistroCitas/listar_doctores",
        type: "GET",
        data: {},
        async: false,
        beforeSend: function () {
            html += '<option value="-1">Todos</option>';
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
        $('#divTelefono').hide();
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

function registrarPagoGratis() {
    $.ajax({
        url: "/RegistroCitas/RegistrarPagoGratuito?id_cita=" + id_cita_,
        type: "GET",
        success: function (data) {
            if (data.estado) {
                Swal.fire({
                    icon: "success",
                    text: "Pago gratuito registrado exitosamente.",
                });
                $('#mdl_cita').modal('hide');

                var tipoVista = TipoVista();
                if (tipoVista == 'MENSUAL') {
                    $('.calendar-container').html('<div id="my-calendar"></div>');
                }
                cargar_citas();
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
                icon: "error",
                title: "Oops...",
                text: "Ocurrió un error al registrar el pago gratuito.",
            });
        },
        complete: function () {
        }
    });
}

function modalActualizarServicio() {
    $('#mdlActualizarServicio').modal('show');
}

function cerrarModalActualizarServicio() {
    $('#mdlActualizarServicio').modal('hide');
}

function actualizar_servicio() {
    debugger;
    var servicioOg = parseInt($('#cboServicio').val());
    var servicioNew = parseInt($('#cboServicioActualizar').val());

    if (servicioOg == servicioNew) {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "El nuevo servicio debe ser uno diferente.",
        });
        return;
    }
    $.get(`/RegistroCitas/ActualizarServicio?id_cita=${id_cita_}&id_servicio=${servicioNew}`, function (data) {
        if (data.estado) {
            Swal.fire({
                icon: "success",
                text: "Servicio actualizado.",
            });
            cerrarModalActualizarServicio();
            $('#mdl_cita').modal('hide');

            var tipoVista = TipoVista();
            if (tipoVista == 'MENSUAL') {
                $('.calendar-container').html('<div id="my-calendar"></div>');
            }
            cargar_citas();
        } else {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: data.descripcion,
            });
        }
    });
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
    var id_sede = $('#cboSedeChange').val();
    var tipo_cita = $('#cboTipoCita').val();

    if (doctor == '-1') {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione el especialista.",
        });
        return;
    }

    if (hora == '' && sesiones == 0) {
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

    if (id_sede == '-1') {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione la sede.",
        });
        return;
    }

    if (sesiones > 0 && adicionales.length == 0) {
        Swal.fire({
            icon: "warning",
            title: "Oops...",
            text: "Seleccione las fechas adicionales.",
        });
        return;
    }
    // Obtener el feedback
    var feedback = $('input[name="feedback"]:checked').val(); // 'happy' o 'sad'
    var comentario = $('#comment').val(); // Comentario adicional si es cara triste

    var data_ = {
        id_cita: id_cita_,
        id_usuario: 0,
        estado_cita: 0,
        fecha_cita: fecha,
        hora_cita: hora,
        id_doctor_asignado: doctor,
        id_paciente: paciente,
        monto_pactado: '0,00',
        id_servicio: id_servicio,
        id_sede: id_sede,
        tipo_cita: tipo_cita,
        fechas_adicionales: adicionales
    };
    if (feedback === 'sad') {
        data_.feedback = true; // Enviar true si es triste
        data_.comentario = comentario || ''; // Enviar comentario adicional si existe
    }
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
                $('#cboTipoCita').val('P');
                $('#mdl_cita').modal('hide');

                var tipoVista = TipoVista();
                if (tipoVista == 'MENSUAL') {
                    $('.calendar-container').html('<div id="my-calendar"></div>');
                }
                cargar_citas();
                adicionales = [];
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

                //$('#txtHora').val('');
                //$('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
                //$('#mdl_cita').modal('hide');

                //BEGIN: acciones cuando la cita se confirma
                $('#divAtender, #btnCancelar, #divPagoPendiente, #ImgActualizarServicio').show();
                $('#divReprogramar, #divHorarios, .divConfirmar').hide();
                if (pago_gratis_ == 'false' || pago_gratis_ == false || !pago_gratis_) {
                    $('#divPagoGratis').show();
                } else {
                    $('#divPagoGratis').hide();
                }
                $('#btnEstado').html('CONFIRMADO').removeClass('evento_citado').addClass('evento_confirmado');
                $('#cboDoctor, #cboPaciente, #txtHora, #cboServicio, #cboSedeChange, #cboTipoCita').attr('disabled', true);
                verificar_si_es_psicologo();
                mostrar_historial(id_cita_, id_paciente_);
                mostrar_historial_pago(id_cita_);
                //END: acciones cuando la cita se confirma

                var tipoVista = TipoVista();
                if (tipoVista == 'MENSUAL') {
                    $('.calendar-container').html('<div id="my-calendar"></div>');
                }
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

                //$('#txtHora').val('');
                //$('#cboDoctor, #cboPaciente, #cboServicio').val('-1');
                //$('#mdl_cita').modal('hide');

                //BEGIN: acciones cuando la cita se atiende
                $('#divReprogramar, #divHorarios, .divConfirmar, #divAtender, #btnCancelar, #divPagoPendiente, #divPagoGratis').hide();
                $('#btnEstado').html('ATENDIDO').removeClass('evento_confirmado').addClass('evento_atendido');
                $('#cboDoctor, #cboPaciente, #txtHora, #cboServicio, #cboSedeChange, #cboTipoCita').attr('disabled', true);
                verificar_si_es_psicologo();
                mostrar_historial(id_cita_, id_paciente_);
                mostrar_historial_pago(id_cita_);
                //END: acciones cuando la cita se atiende

                var tipoVista = TipoVista();
                if (tipoVista == 'MENSUAL') {
                    $('.calendar-container').html('<div id="my-calendar"></div>');
                }
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

                var tipoVista = TipoVista();
                if (tipoVista == 'MENSUAL') {
                    $('.calendar-container').html('<div id="my-calendar"></div>');
                }
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

    var sedes = $("#cboDoctor option:selected").data("sedes");;
    if (sedes != undefined) {
        var listaSedes = sedes.split('/');
        var valorDefault = listaSedes[0];

        validar_sede_usuario(id_doc, valorDefault);
    } else {
        validar_sede_usuario(id_doc, null);
    }
}

function validar_sede_usuario(id_doc, id_selected) {
    var html = '';
    var data_ = '';
    $.ajax({
        url: "/RegistroCitas/listar_sedes_x_usuario?id_doc=" + id_doc,
        type: "GET",
        data: {},
        async: false,
        beforeSend: function () {
            html += '<option value="-1">Seleccionar</option>';
        },
        success: function (data) {
            data_ = data;
            for (var item of data_) {
                html += '<option value="' + item.id + '">' + item.nombre + '</option>';
            }
        },
        error: function (response) {
            html = '<option value="-1">Seleccionar</option>';
        },
        complete: function () {
            $('#cboSedeChange').html(html);
            if (id_selected != null) {
                $('#cboSedeChange').val(id_selected);
            }
        }
    });
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
            var i = 0;
            if (data.length > 0) {
                for (item of data) {
                    var clase = item.estado == 'DISPONIBLE' ? 'item_disponible item_clase' + i.toString() : 'item_reservado';
                    var hora = item.estado == 'DISPONIBLE' ? item.hora_cita : '';
                    var accion = ' onclick="seleccionar_hora_disponible(this)" data-hora="' + hora + '"';
                    html += '<tr data-option="item_clase' + i.toString() + '" class="' + clase + '"' + accion + '><td class="text-center">' + item.hora_cita + '</td><td class="text-center">' + item.estado + '</td></tr>';
                    i++;
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
                    var clase = item.estado == 'DISPONIBLE' ? 'item_disponible item_clase' + i.toString() : 'item_reservado';
                    var hora = item.estado == 'DISPONIBLE' ? item.hora_cita : '';
                    var accion = ' onclick="seleccionar_hora_disponible(this)" data-hora="' + hora + '"';
                    html += '<tr data-option="item_clase' + i.toString() + '" class="' + clase + '"' + accion + '><td class="text-center">' + item.hora_cita + '</td><td class="text-center">' + item.estado + '</td></tr>';
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
function toggleComment(show) {
    const commentSection = document.getElementById('comment-section');
    commentSection.style.display = show ? 'block' : 'none';
}
function seleccionar_hora_disponible(e) {
    var hora = $(e).attr('data-hora');
    var option = $(e).attr('data-option');

    $('.item_disponible').removeClass('item_separado');
    $('.' + option).addClass('item_separado');

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


            // Detectar el año dinámicamente según el sistema
            const fechaActual = new Date();
            let anioActivo = fechaActual.getFullYear(); // Cambié 'añoSeleccionado' por 'anioActivo'

            // Detectar si hay un cambio de año en los meses seleccionados
            const comboMes = document.getElementById("trigger_seleccion_mes");

            // Detectar cambio de mes y actualizar las semanas dinámicamente
            comboMes.addEventListener("change", function () {
                const mesSeleccionado = parseInt(this.value, 10);

                // Cambiar el año si se selecciona diciembre y pasa a enero (u otros saltos de año)
                if (mesSeleccionado === 11 && fechaActual.getMonth() === 0) {
                    anioActivo--;
                } else if (mesSeleccionado === 0 && fechaActual.getMonth() === 11) {
                    anioActivo++;
                }

                actualizarComboSemanas(mesSeleccionado, anioActivo);
            });
            // Cargar semanas al iniciar la página
            const mesInicial = parseInt(comboMes.value, 10);
            actualizarComboSemanas(mesInicial, anioActivo);


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
        '06:00 AM',
        '07:00 AM',
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

    var html_hd = ''; //'<th style="width: 12.5%;"></th>';
    var html_bd = '';
    var i = 0;
    var lista = [];

    if (filtroDoctor == -1) {
        Swal.fire({
            icon: "Error",
            title: "Oops...",
            text: "Seleccione un especialista para realizar la búsqueda.",
        });
    }

    var fechasVacaciones = [];

    $.ajax({
        url: '/RegistroCitas/ListarHorariosDoctor?inicio=' + inicio + '&fin=' + fin + '&id_doctor=' + filtroDoctor,
        type: "GET",
        data: {},
        beforeSend: function () {
            //$('.div_horario_refrigero').remove();
            $('#hdTblSemanal > tr').html('');
            $('#bdTblSemanal').html('');
        },
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
            var año = parseInt($('#cbo_seleccion_mes').attr('data-año'));
            var inicio = año + '-01-01';
            var fin = año + '-12-31';
            $.get(`/Mantenimiento/Psicologo/vacaciones_psicologo/${filtroDoctor}/${inicio}/${fin}/${año}`, function (data) {
                for (var item of data) {
                    fechasVacaciones.push(item.fecha);
                }

                console.log('response2',response2);

                for (var dia of response2) {
                    html_hd += '<th style="width: 14.2%;" class="' + (dia.fecha == '' ? 'header-semanal dia_inhabilitado' : 'header-semanal') + '">';
                    html_hd += (dia.fecha == '' ? dias[i] : dias[i] + ' ' + fecha_formato_ddmmyyyy(dia.fecha) + '&nbsp;');
                    html_hd += ver_btn_nueva_cita(dia.fecha);
                    html_hd += '</th>';
                    i++;
                }
                $('#hdTblSemanal > tr').html(html_hd);

                for (var hora of data_horas) {
                    html_bd += '<tr>';
                    /*html_bd += '<td>' + hora + '</td>';*/
                    html_bd += '<td style="padding: 5px;" class="' + (response2[0].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[0].fecha) ? 'diaVacaciones' : '') + '">' + (response2[0].fecha == '' ? '' : (enviar_datos_zabuto(response2[0].fecha, hora)) + agregarHoraLibre(response2[0].fecha, hora, lista)) + '</td>';
                    html_bd += '<td style="padding: 5px;" class="' + (response2[1].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[1].fecha) ? 'diaVacaciones' : '') + '">' + (response2[1].fecha == '' ? '' : (enviar_datos_zabuto(response2[1].fecha, hora)) + agregarHoraLibre(response2[1].fecha, hora, lista)) + '</td>';
                    html_bd += '<td style="padding: 5px;" class="' + (response2[2].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[2].fecha) ? 'diaVacaciones' : '') + '">' + (response2[2].fecha == '' ? '' : (enviar_datos_zabuto(response2[2].fecha, hora)) + agregarHoraLibre(response2[2].fecha, hora, lista)) + '</td>';
                    html_bd += '<td style="padding: 5px;" class="' + (response2[3].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[3].fecha) ? 'diaVacaciones' : '') + '">' + (response2[3].fecha == '' ? '' : (enviar_datos_zabuto(response2[3].fecha, hora)) + agregarHoraLibre(response2[3].fecha, hora, lista)) + '</td>';
                    html_bd += '<td style="padding: 5px;" class="' + (response2[4].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[4].fecha) ? 'diaVacaciones' : '') + '">' + (response2[4].fecha == '' ? '' : (enviar_datos_zabuto(response2[4].fecha, hora)) + agregarHoraLibre(response2[4].fecha, hora, lista)) + '</td>';
                    html_bd += '<td style="padding: 5px;" class="' + (response2[5].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[5].fecha) ? 'diaVacaciones' : '') + '">' + (response2[5].fecha == '' ? '' : (enviar_datos_zabuto(response2[5].fecha, hora)) + agregarHoraLibre(response2[5].fecha, hora, lista)) + '</td>';
                    html_bd += '<td style="padding: 5px;" class="' + (response2[6].fecha == '' ? 'dia_inhabilitado' : '') + ' ' + (fechasVacaciones.includes(response2[6].fecha) ? 'diaVacaciones' : '') + '">' + (response2[6].fecha == '' ? '' : (enviar_datos_zabuto(response2[6].fecha, hora)) + agregarHoraLibre(response2[6].fecha, hora, lista)) + '</td>';
                    html_bd += '</tr>';
                }
                $('#bdTblSemanal').html(html_bd);

            });
        }
    });

    return lista;
}

function agregarHoraLibre(fecha, hora, libres) {
    var html = '';
    if (libres.length > 0) {
        var libre = libres.filter(x => x.fecha_cita == fecha && x.hora_cita == hora);
        if (libre.length == 1) {
            if (libre[0].tipo == 'REFRIGERIO') {
                html = '<div class="div_refrigero" style="background-color: #797c7c; color: #FFFFFF; padding: 5px; font-size: 12px; border-radius: 5px;">' + libre[0].tipo + '<br>' + libre[0].hora_cita + '</div>';
            } else {
                html = '<div class="div_horario" style="background-color: #5c9d9d; color: #FFFFFF; padding: 5px; font-size: 12px; border-radius: 5px; cursor: pointer;"';
                if (parseDate(fecha) >= parseDate(fecha_actual())) {
                    html += ' data-id-cita="0" data-id-especialista="-1" data-id-paciente="-1" data-fecha-cita="' + fecha + '" data-pago-gratis="0" data-hora-cita="" data-estado="-" data-telefono="--" data-moneda="S/." data-monto-pactado="0.00" data-monto-pagado="0.00" data-monto-pendiente="0.00" data-id-servicio="-1" data-id-sede="-1" data-dni-paciente="" onclick="ver_cita(this)" ';
                }
                html +='>' + libre[0].tipo + ' <br> ' + libre[0].hora_cita + '</div> ';
            }
            
        }
    }
    return html;
}

function ver_btn_nueva_cita(fecha) {
    var dia_ = parseInt(fecha.slice(-2));
    var mes_ = parseInt(fecha.substring(0, 7).slice(-2));
    var año_ = parseInt(fecha.substring(0, 4));

    mes_--;

    var html = contenido_cita(dia_, mes_, año_, null, true);
    html = html.includes('btn_nueva_cita') ? html : '';
    return html;
}

function enviar_datos_zabuto(fecha, hora) {
    var dia_ = parseInt(fecha.slice(-2));
    var mes_ = parseInt(fecha.substring(0, 7).slice(-2));
    var año_ = parseInt(fecha.substring(0, 4));
    
    mes_--;

    var html = contenido_cita(dia_, mes_, año_, hora, false);
    html = (html == '-' ? '' : (html.includes('btn_nueva_cita') ? '' : html));
    return html;
}
// Genera las semanas de un mes específico
function generarSemanasDelMes(mes, año) {
    const semanas = [];
    let fechaInicio = new Date(año, mes, 1); // Primer día del mes
    const fechaFin = new Date(año, mes + 1, 0); // Último día del mes

    // Ajustar para que la semana comience en lunes
    if (fechaInicio.getDay() !== 1) {
        fechaInicio.setDate(fechaInicio.getDate() - (fechaInicio.getDay() === 0 ? 6 : fechaInicio.getDay() - 1));
    }

    let semanaContador = 1;
    while (fechaInicio <= fechaFin) {
        const inicioSemana = new Date(fechaInicio);
        const finSemana = new Date(inicioSemana);
        finSemana.setDate(inicioSemana.getDate() + 6);

        if (finSemana > fechaFin) {
            finSemana.setDate(fechaFin.getDate());
        }

        semanas.push({
            label: `Semana ${semanaContador} (${inicioSemana.getDate()} ${obtenerNombreMes(inicioSemana.getMonth())} - ${finSemana.getDate()} ${obtenerNombreMes(finSemana.getMonth())})`,
            value: `${semanaContador}`, // Valor de la semana
        });

        fechaInicio.setDate(fechaInicio.getDate() + 7);
        semanaContador++;
    }

    return semanas;
}

// Obtiene el nombre del mes en español
function obtenerNombreMes(mes) {
    const nombresMeses = [
        "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
    ];
    return nombresMeses[mes];
}

// Actualiza las opciones del combo de semanas
function actualizarComboSemanas(mes, año) {
    const combo = document.getElementById("cboSemanaFiltro");
    combo.innerHTML = ""; // Limpiar las opciones existentes

    const semanas = generarSemanasDelMes(mes, año);

    // Crear opciones dinámicas para el combo
    semanas.forEach((semana) => {
        const option = document.createElement("option");
        option.value = semana.value;
        option.textContent = semana.label;
        combo.appendChild(option);
    });
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