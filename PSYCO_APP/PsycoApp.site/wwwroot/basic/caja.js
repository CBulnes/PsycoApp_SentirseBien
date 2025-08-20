var colors = ["#a09b9b", "#6788d2", "#ff8128", "#4f5467", "#7460ee", "#26c6da", "#009efb"];
$(document).ready(function () {
    var idSede = document.getElementById("hiddenIdSede").value;
    // Establece el valor seleccionado en el <select>
    var select = document.getElementById("cboSede");
    select.value = idSede;
});

function buscarPago(pageNumber = 1) {
    let pageSize = 10;
    var fecha = $('#txtFecha').val();
    var buscar_por = parseInt($('#cboBuscarPor').val());
    var sede = $('#cboSede').val();
    var id_usuario = parseInt($('#cboUsuario').val());

    $.post('/Caja/Buscar', { pageNumber: pageNumber, pageSize: pageSize, fecha: fecha, buscar_por: buscar_por, sede: sede, id_usuario: id_usuario })
        .done(function (data) {
            $('#containerTabla').html(data);
            verResumenUsuario(false);
        })
        .fail(function () {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Ocurrió un error al obtener los registros.",
            });
        });
}
verResumenUsuario(true);

function formatDecimal(num) {
    return (Math.round(num * 100) / 100).toFixed(2);
}

function verResumenUsuario(recargar) {
    //if (recargar) {
    //    $('#cboMes').val(-1);
    //    $('#cboAnio').val(-1);
    //    $('#cboSede').val(-1);
    //}

    var fecha = $('#txtFecha').val();
    var buscar_por = parseInt($('#cboBuscarPor').val());
    var sede = $('#cboSede').val();
    var id_usuario = parseInt($('#cboUsuario').val());
    var html = '';
    var contador = 1;

    $('.preloader').removeAttr('style');
    $('.preloader').removeClass('hide-element');

    $.get('/Caja/ListarResumenCajaPorUsuario?fecha=' + fecha + "&buscar_por=" + buscar_por + "&sede=" + sede + "&id_usuario=" + id_usuario)
        .done(function (data) {
            var total = data.find(x => x.usuario == 'TOTAL');

            if (data.length - 1 > 0) {
                for (var item of data) {
                    if (item.usuario != 'TOTAL') {
                        html += '<tr>';
                        html += '<td class="text-center">' + contador + '</td>';
                        html += '<td class="text-center">' + item.usuario + '</td>';
                        html += '<td style="text-align: right;">' + item.importe + '</td>';
                        html += '</tr>';
                        contador++;
                    }
                }

                html += '<tr>';
                html += '<td class="text-center" style="background-color: #FFFFFF !important;">&nbsp;</td>';
                html += '<td class="text-center" style="background-color: #FFFFFF !important;">&nbsp;</td>';
                html += '<td style="text-align: right;">' + total.importe + '</td>';
                html += '</tr>';
            } else {
                html += '<tr>';
                html += '<td style="text-align: center;" colspan="3">No hay datos para mostrar</td>';
                html += '</tr>';
            }
            $('#bdResumen').html(html);
            
            getResumenTipoPago(fecha, buscar_por, sede, id_usuario);
        })
        .fail(function () {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Ocurrió un error al obtener los registros.",
            });
            getResumenTipoPago(fecha, buscar_por, sede, id_usuario);
        });
}

function getResumenTipoPago(fecha, buscar_por, sede, id_usuario) {
    data_resumen = [];
    var html = '';
    var contador = 1;

    $.get('/Caja/ListarResumenCajaPorFormaPago?fecha=' + fecha + "&buscar_por=" + buscar_por + "&sede=" + sede + "&id_usuario=" + id_usuario)
        .done(function (data) {
            var total = data.find(x => x.forma_pago == 'TOTAL' && x.detalle_transferencia == 'TOTAL');
            var data_resumen = [];

            if (data.length - 1 > 0) {
                data_resumen = data;

                for (var item of data_resumen) {
                    if (item.forma_pago != 'TOTAL' && item.detalle_transferencia != 'TOTAL') {
                        html += '<tr>';
                        html += '<td class="text-center">' + contador + '</td>';
                        html += '<td class="text-center">' + item.cantidad + '</td>';
                        html += '<td class="text-center">' + item.forma_pago + '</td>';
                        html += '<td class="text-center">' + item.detalle_transferencia + '</td>';
                        html += '<td style="text-align: right;">' + item.importe + '</td>';
                        html += '</tr>';
                        contador++;
                    }
                }

                html += '<tr>';
                html += '<td class="text-center" style="background-color: #FFFFFF !important;">&nbsp;</td>';
                html += '<td class="text-center" style="background-color: #FFFFFF !important;">&nbsp;</td>';
                html += '<td class="text-center" style="background-color: #FFFFFF !important;">&nbsp;</td>';
                html += '<td class="text-center" style="background-color: #FFFFFF !important;">&nbsp;</td>';
                html += '<td style="text-align: right;">' + total.importe + '</td>';
                html += '</tr>';
            } else {
                data_resumen = [{ 'cantidad': 1, 'forma_pago': 'Sin registros', 'detalle_transferencia': '' }];

                html += '<tr>';
                html += '<td style="text-align: center;" colspan="5">No hay datos para mostrar</td>';
                html += '</tr>';
            }
            $('#bdResumen2').html(html);
            generar_grafico(data_resumen);
        })
        .fail(function () {
            Swal.fire({
                icon: "Error",
                title: "Oops...",
                text: "Ocurrió un error al obtener los registros.",
            });
            $('.preloader').addClass('hide-element');
        });
}

var data = [] , totalPoints = 300;

function getRandomData() {
    if (data.length > 0) data = data.slice(1);
    while (data.length < totalPoints) {
        var prev = data.length > 0 ? data[data.length - 1] : 50
            , y = prev + Math.random() * 10 - 5;
        if (y < 0) {
            y = 0;
        }
        else if (y > 100) {
            y = 100;
        }
        data.push(y);
    }
    var res = [];
    for (var i = 0; i < data.length; ++i) {
        res.push([i, data[i]])
    }
    return res;
}

var updateInterval = 30;
$("#updateInterval").val(updateInterval).change(function () {
    var v = $(this).val();
    if (v && !isNaN(+v)) {
        updateInterval = +v;
        if (updateInterval < 1) {
            updateInterval = 1;
        }
        else if (updateInterval > 3000) {
            updateInterval = 3000;
        }
        $(this).val("" + updateInterval);
    }
});
var plot = $.plot("#placeholder", [getRandomData()], {
    series: {
        shadowSize: 0 // Drawing is faster without shadows
    }
    , yaxis: {
        min: 0
        , max: 100
    }
    , xaxis: {
        show: false
    }
    , colors: ["#26c6da"]
    , grid: {
        color: "#AFAFAF"
        , hoverable: true
        , borderWidth: 0
        , backgroundColor: '#FFF'
    }
    , tooltip: true
    , tooltipOpts: {
        content: "Y: %y"
        , defaultTheme: false
    }
});

function update() {
    plot.setData([getRandomData()]);
    plot.draw();
    setTimeout(update, updateInterval);
}
update();

function generar_grafico(data_nps) {
    $('#reporte_nps').empty();
    var data_nps_dona = [];
    var i = 0;
    data_nps.forEach(item => {
        if (item.detalle_transferencia) {
            console.log(item.detalle_transferencia);
            item.detalle_transferencia = item.detalle_transferencia.replace(/^S\//, ' ');
            item.detalle_transferencia = item.detalle_transferencia.replace(/S\/\./g, ' ').trim();
        }
    });
    for (var item of data_nps) {
        if (item.detalle_transferencia != 'TOTAL' && item.forma_pago != 'TOTAL') {
            i++;
            var item_ = {
                label: item.forma_pago + (item.detalle_transferencia == '' ? '' : (' - ') + item.detalle_transferencia) + ' - ' + item.importe,
                data: parseInt(item.cantidad),
                color: colors[i]
            };
            data_nps_dona.push(item_);
        }
    }

    var data = data_nps_dona;
    var plotObj = $.plot($("#reporte_nps"), data, {
        series: {
            pie: {
                innerRadius: 0.5
                , show: true
            }
        }
        , grid: {
            hoverable: true
        }
        , color: null
        , tooltip: true
        , tooltipOpts: {
            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
            shifts: {
                x: 20
                , y: 0
            }
            , defaultTheme: false
        }
    });
    $('.preloader').addClass('hide-element');
}