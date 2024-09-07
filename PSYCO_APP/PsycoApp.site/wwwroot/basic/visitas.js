var path = ruta;

function cargar_data_graficos(año, tipo, id_grafico) {
    $.ajax({
        type: "GET",
        url: path + '/Home/listar_puntos_visitados',
        data: { 'año': año, 'mes': 0, 'tipo': tipo },
        accept: 'application/json',
        beforeSend: function () {
            $('#preloader').removeAttr('style');
            $('#preloader').removeClass('hide-element');
        },
        success: function (response) {

            generar_grafico(id_grafico, response.data);
            $('#preloader').addClass('hide-element');

        },
        error: function (xhr, status, error) {
            var error_especifico = eval("(" + xhr.responseText + ")");
            var error_mostrar = '';
            if (xhr.status === 0) {
                error_mostrar = ('Verificar conexión a internet - ' + error_especifico.Message);
            } else if (xhr.status == 404) {
                error_mostrar = ('URL solicitada no encontrada [Error 404] - ' + error_especifico.Message);
            } else if (xhr.status == 500) {
                error_mostrar = ('Error interno del servidor [Error 500] - ' + error_especifico.Message);
            } else if (status === 'parsererror') {
                error_mostrar = ('JSON solicitado falló - ' + error_especifico.Message);
            } else if (status === 'timeout') {
                error_mostrar = ('Error en tiempo de espera - ' + error_especifico.Message);
            } else if (status === 'abort') {
                error_mostrar = ('Solicitud Ajax abortada - ' + error_especifico.Message);
            } else {
                error_mostrar = ('Error desconocido: - ' + error_especifico.Message);
            }
            //show_toast('error', error_mostrar);
            $('#preloader').addClass('hide-element');
            console.log(error_mostrar);
        }
    });
}

$('#cboAño').on('change', function () {
    var año = $(this).val();
    funciones_graficos(año);
})

function funciones_graficos(año) {
    cargar_data_graficos(año, 'encuestas', 'encuestas');
    /*cargar_data_graficos(año, 'visitas', 'visitas');*/
    //cargar_data_graficos(año, 'puntos_visitados', 'puntos-visitados');

    $('.preloader').addClass('hide-element');
}

if (id_tipousuario == 1) {
    $('.preloader').removeAttr('style');
    $('.preloader').removeClass('hide-element');

    funciones_graficos($('#cboAño').val());
}

function generar_grafico(id_grafico, array_data) {
    var myChart01 = echarts.init(document.getElementById(id_grafico));

    var tipos = [];
    var meses = [];
    var colecciones = [];
    var colors_prev = ["#55ce63", "#009efb", "#ffd91d", "#ff2323", "#46ccff", "#5c4eb3"];
    var colors = [];
    var item_agregar;

    for (var item of array_data) {
        item_agregar = item.tipo == '' ? item.visitante : item.tipo + '/' + item.visitante;

        if (!tipos.includes(item_agregar)) {
            tipos.push(item_agregar);
        }

        if (!meses.includes(item.mes)) {
            meses.push(item.mes);
        }
    }

    for (var i = 0; i < tipos.length; i++) {
        colors.push(colors_prev[i]);
    }

    var i = 0;
    for (var item1 of tipos) {
        var obj = new Object;
        obj.name = item1;
        obj.type = 'bar';
        var data = [];

        for (var item2 of array_data) {
            item_agregar = item2.tipo == '' ? item2.visitante : item2.tipo + '/' + item2.visitante;
            if (obj.name == item_agregar) {
                data.push(item2.total);
            }
        }

        obj.data = data;
        colecciones.push(obj);
    }

    option = {
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: tipos
        },
        toolbox: {
            show: true,
            feature: {

                magicType: { show: true, type: ['line', 'bar'] },
                restore: { show: true },
                saveAsImage: { show: true }
            }
        },
        color: colors,
        calculable: true,
        xAxis: [
            {
                type: 'category',
                data: meses
            }
        ],
        yAxis: [ { type: 'value' } ],
        series: colecciones
    };


    // use configuration item and data specified to show chart
    myChart01.setOption(option, true), $(function () {
        function resize() {
            setTimeout(function () {
                myChart01.resize()
            }, 100)
        }
        $(window).on("resize", resize), $(".sidebartoggler").on("click", resize)
    });

    $('#preloader').addClass('hide-element');
}