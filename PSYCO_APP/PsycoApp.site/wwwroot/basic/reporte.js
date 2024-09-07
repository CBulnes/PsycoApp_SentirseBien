var colors = ["#a09b9b", "#6788d2", "#ff8128", "#4f5467", "#7460ee", "#26c6da", "#009efb"];

function obtener_data_nps(año) {
    data_nps = [];
    $.ajax({
        type: "GET",
        url: path + '/Reportes/reporte_nps',
        accept: 'application/json',
        data: { 'año': año, 'mes': 0, 'tipo': '-' },
        beforeSend: function () {
            $('#div_graficos').addClass('hide-element');
            $('.preloader').removeAttr('style');
            $('.preloader').removeClass('hide-element');
        },
        success: function (response) {

            if (response.length > 0) {
                $('#div_graficos').removeClass('hide-element');
                var data_nps = response;
                pie_nps(data_nps);
            } else {
                alerta('No hay datos para mostrar', 'info');
                $('#div_graficos').addClass('hide-element');
                $('.preloader').addClass('hide-element');
            }

        }
    });
}

$('#cboAño').on('change', function () {
    var año = $(this).val();
    obtener_data_nps(año);
})

if (id_tipousuario == 1) {
    var año = $('#cboAño').val()
    obtener_data_nps(año);
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
        if (item.resultado == 'Nulo' || item.resultado == 'Promotor' || item.resultado == 'Detractor') {
            i++;
            var item_ = {
                label: item.resultado,
                data: parseInt(item.total_entero),
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
    bar_nps(data_nps);
}
//});



//$(function () {
function bar_nps(data_nps) {
    "use strict";
    // Morris bar chart
    $('#indicador_nps').empty();

    var data_nps_barras = [];

    for (var item of data_nps) {
        if (item.resultado == 'NPS Objetivo' || item.resultado == 'NPS Real') {
            var item_ = { indicador: item.resultado, valor: item.total_porcentaje + '%' };
            data_nps_barras.push(item_);
        }
    }

    Morris.Bar({
        element: 'indicador_nps',
        data: data_nps_barras,
        xkey: 'indicador',
        ykeys: ['valor'],
        labels: ['VALOR (%)'],
        barColors: ['#55ce63', '#2f3d4a', '#009efb'],
        hideHover: 'auto',
        gridLineColor: '#eef0f2',
        resize: true
    });

    resultados_nps(data_nps);
}
//});

function resultados_nps(data_nps) {
    var _html = '';
    _html += '<table class="tablesaw table-striped table-hover table-bordered table tablesaw-columntoggle">';
    _html += '<thead><tr><th>Resultado</th><th>(%)</th></tr></thead>';
    _html += '<tbody>';
    for (var item of data_nps) {
        if (item.resultado == 'Detractor') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    for (var item of data_nps) {
        if (item.resultado == 'Promotor') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    for (var item of data_nps) {
        if (item.resultado == 'Nulo') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    for (var item of data_nps) {
        if (item.resultado == 'Total general') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    _html += '</tbody>';
    _html += '</table>';

    /*******/
    _html += '<br/>';

    _html += '<table class="tablesaw table-striped table-hover table-bordered table tablesaw-columntoggle">';
    _html += '<thead><tr><th>Indicador</th><th>(%)</th></tr></thead>';
    _html += '<tbody>';
    for (var item of data_nps) {
        if (item.resultado == 'NPS Real') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    for (var item of data_nps) {
        if (item.resultado == 'NPS Objetivo') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    _html += '</tbody>';
    _html += '</table>';

    $('#tabla_nps').html('').append(_html);

    resultados_flujo(data_nps);
}

function resultados_flujo(data_nps) {
    return;
    var _html = '';
    _html += '<table class="tablesaw table-striped table-hover table-bordered table tablesaw-columntoggle">';
    _html += '<thead><tr><th colspan="3">FLUJOS GENERAL</th></tr></thead>';
    _html += '<tbody>';
    _html += '<tr><td>Tipo</td><td>Cantidad</td><td>(%)</td></tr>';
    for (var item of data_nps) {
        if (item.resultado == 'TICKET' || item.resultado == 'GRACIAS' || item.resultado == 'CALL CENTER') {
            _html += '<tr><td>' + item.resultado + '</td><td>' + item.total_entero + '</td><td>' + item.total_porcentaje + '%' + '</td></tr>';
        }
    }
    _html += '</tbody>';
    _html += '</table>';

    $('#tabla_resultados_flujo').html('').append(_html);
    $('.preloader').addClass('hide-element');
}