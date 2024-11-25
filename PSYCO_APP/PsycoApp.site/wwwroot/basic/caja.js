var colors = ["#a09b9b", "#6788d2", "#ff8128", "#4f5467", "#7460ee", "#26c6da", "#009efb"];

function buscarPago(pageNumber = 1) {
    let pageSize = 10;
    var mes = $('#cboMes').val();
    var anio = $('#cboAnio').val();

    $.post('/Caja/Buscar', { pageNumber: pageNumber, pageSize: pageSize, mes: mes, anio: anio })
        .done(function (data) {
            $('#containerTabla').html(data);
            verResumenUsuario(false);
        })
        .fail(function () {
            alert('Error en la búsqueda de registros.');
        });
}
verResumenUsuario(true);

function verResumenUsuario(recargar) {
    if (recargar) {
        $('#cboMes').val(-1);
        $('#cboAnio').val(-1);
    }

    var mes = $('#cboMes').val();
    var anio = $('#cboAnio').val();
    var html = '';
    var contador = 1;

    $('.preloader').removeAttr('style');
    $('.preloader').removeClass('hide-element');

    $.get('/Caja/ListarResumenCajaPorUsuario?mes=' + mes + "&anio=" + anio)
        .done(function (data) {
            if (data.length > 0) {
                for (var item of data) {
                    html += '<tr>';
                    html += '<td class="text-center">' + contador + '</td>';
                    html += '<td>' + item.importe + '</td>';
                    html += '<td class="text-center">' + item.usuario + '</td>';
                    html += '</tr>';
                    contador++;
                }
            } else {
                html += '<tr>';
                html += '<td style="text-align: center;" colspan="3">No hay datos para mostrar</td>';
                html += '</tr>';
            }
            $('#bdResumen').html(html);
            getResumenTipoPago(mes, anio);
        })
        .fail(function () {
            alert('Error en la búsqueda de registros.');
            getResumenTipoPago(mes, anio);
        });
}

function getResumenTipoPago(mes, anio) {
    data_resumen = [];

    $.get('/Caja/ListarResumenCajaPorFormaPago?mes=' + mes + "&anio=" + anio)
        .done(function (data) {
            console.log('caja');
            var data_resumen = [];
            if (data.length > 0) {
                data_resumen = data;
            } else {
                data_resumen = [{'cantidad': 1, 'forma_pago': 'Sin registros', 'detalle_transferencia': ''}]
            }
            generar_grafico(data_resumen);
        })
        .fail(function () {
            alert('Error en la búsqueda de registros.');
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
        i++;
        var item_ = {
            label: item.forma_pago + (item.detalle_transferencia == '' ? '' : (' - ') + item.detalle_transferencia) + ' - ' + item.importe,
            data: parseInt(item.cantidad),
            color: colors[i]
        };
        data_nps_dona.push(item_);
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