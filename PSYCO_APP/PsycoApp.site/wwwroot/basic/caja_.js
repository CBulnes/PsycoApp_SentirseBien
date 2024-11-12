var colors = ["#a09b9b", "#6788d2", "#ff8128", "#4f5467", "#7460ee", "#26c6da", "#009efb"];

function buscarPago(pageNumber = 1) {
    let pageSize = 10; // Número de registros por página
    $.post('/Caja/Buscar', { pageNumber: pageNumber, pageSize: pageSize })
        .done(function (data) {
            // Actualizar solo el contenido de la tabla
            $('#containerTabla').html(data);
        })
        .fail(function () {
            alert('Error en la búsqueda de registros.');
        });
}

function verResumenUsuario(recargar) {
    if (recargar) {
        $('#cboMes').val(-1);
        $('#cboAnio').val(-1);
    }

    var mes = $('#cboMes').val();
    var anio = $('#cboAnio').val();
    var html = '';
    var contador = 1;

    $('#div_graficos').addClass('hide-element');
    $('.preloader').removeAttr('style');
    $('.preloader').removeClass('hide-element');

    $.get('/Caja/ListarResumenCajaPorUsuario?mes=' + mes + "&anio=" + anio)
        .done(function (data) {
            for (var item of data) {
                html += '<tr>';
                html += '<td>' + contador + '</td>';
                html += '<td>' + item.importe + '</td>';
                html += '<td>' + item.usuario + '</td>';
                html += '</tr>';
                contador++;
            }
            $('#bdResumen').html(html);
            getResumenTipoPago(mes, anio);
        })
        .fail(function () {
            alert('Error en la búsqueda de registros.');
        });
}

function getResumenTipoPago(mes, anio) {
    $.get('/Caja/ListarResumenCajaPorFormaPago?mes=' + mes + "&anio=" + anio)
        .done(function (data) {
            debugger;
            $('#div_graficos').addClass('hide-element');
            $('.preloader').addClass('hide-element');

            if (data.length > 0) {
                $('#div_graficos').removeClass('hide-element');
                var data_nps = data;
                pie_nps(data_nps);
            } else {
                alert('No hay datos para mostrar');
            }

            $('#mdl_resumen_caja').modal('show');
        })
        .fail(function () {
            alert('Error en la búsqueda de registros.');
        });
}

function cerrarModalResumen() {
    $('#mdl_resumen_caja').modal('hide')
}

var data = []
    , totalPoints = 300;

function getRandomData() {
    if (data.length > 0) data = data.slice(1);
    // Do a random walk
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
    // Zip the generated y values with the x values
    var res = [];
    for (var i = 0; i < data.length; ++i) {
        res.push([i, data[i]])
    }
    return res;
}
// Set up the control widget
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
    // Since the axes don't change, we don't need to call plot.setupGrid()
    plot.draw();
    setTimeout(update, updateInterval);
}
update();

//Flot Pie Chart
//$(function () {
function pie_nps(data_nps) {
    var data_nps_dona = [];
    var i = 0;
    for (var item of data_nps) {
        i++;
        var item_ = {
            label: item.forma_pago + (item.detalle_transferencia == '' ? '' : ' - ' + item.detalle_transferencia),
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
    //bar_nps(data_nps);
}
//});