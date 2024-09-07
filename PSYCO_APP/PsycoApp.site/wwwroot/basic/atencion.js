var path = ruta;

var c_a_img = path + "/images/location.jpg";
var position_;

function solicitar_permiso_localizacion() {
    cargar_centros_atencion('0', '0');

    navigator.geolocation.getCurrentPosition(funcionSiTodoVaBien, function (error) {
        // El segundo parámetro es la función de error
        switch (error.code) {
            case error.PERMISSION_DENIED:
                // El usuario denegó el permiso para la Geolocalización.
                alerta('Usted ha denegado el permisos para acceder a su ubicación', 'info');
                break;
            case error.POSITION_UNAVAILABLE:
                // La ubicación no está disponible.
                alerta('La ubicación no se encuentra disponible', 'info');
                break;
            case error.TIMEOUT:
                // Se ha excedido el tiempo para obtener la ubicación.
                alerta('El tiempo para obtener su ubicación ha excedido el límite', 'info');
                break;
            case error.UNKNOWN_ERROR:
                // Un error desconocido.
                alerta('Se produjo un error en su petición','info');
                break;
            }
        }
    );
}

solicitar_permiso_localizacion();

function funcionSiTodoVaBien() {
    if("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(function (position) {
            cargar_centros_atencion(position.coords.latitude, position.coords.longitude);
        });
    }else {
        //alert('El navegador no puede obtener su ubicación');
        cargar_centros_atencion('0', '0');
    }
}

function cargar_centros_atencion(lat, long) {

    var centros_atencion = '';

    $.ajax({
        type: "POST",
        url: path + '/Atencion/listar_centros_atencion',
        data: { 'latitud': lat, 'longitud': long },
        accept: 'application/json',
        success: function (response) {

            if (response.estado != 'OK') { //&& response.data[0].validacion != "OK") {
                //show_toast('warning', response_json.descripcion);
                alerta(response.descripcion, 'info');
                return;
            }

            for (var ca of response.data) {
                centros_atencion += '<div class="col-xs-2 col-sm-12 col-md-6 col-lg-4 col-xlg-4" style="margin-bottom: 10px !important;">';
                centros_atencion += '<div class="card card-body" style="background-color: #4d5c69; margin-bottom: 0px;">';
                centros_atencion += '<div class="row">';
                centros_atencion += '<div class="col-xs-2 col-sm-4 col-md-4 col-lg-3 text-center">';
                centros_atencion += '<a href="#"><img src="' + c_a_img +'" class="img_atencion img-circle img-responsive"></a>';
                centros_atencion += '</div>';
                centros_atencion += '<div class="col-xs-10 col-sm-8 col-md-8 col-lg-9">';
                centros_atencion += '<h3 class="box-title m-b-0" style="color: #FFF;">' + ca.centro_atencion + '</h3>';
                centros_atencion += '<small class="hide-element">Web Designer</small>';
                centros_atencion += '<address style="margin-bottom: 0;">';
                centros_atencion += ca.direccion;
                centros_atencion += '<br />';
                centros_atencion += '<abbr title="Horario de atención">H.A.:</abbr> ' + ca.horario;
                centros_atencion += '</address>';
                centros_atencion += '</div>';
                centros_atencion += '</div>';
                centros_atencion += '</div>';
                centros_atencion += '</div>';
            }

            $('#div_c_a').html('').append(centros_atencion);
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
            //alert(error_mostrar);
        }
    });
}