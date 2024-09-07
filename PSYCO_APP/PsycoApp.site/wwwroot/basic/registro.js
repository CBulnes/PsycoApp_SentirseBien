var path = ruta;

function redireccionar(ir_a) {
    window.location.href = path + '/' + ir_a;
}

function validar_registro() {
    var nombres = $('#txtNombres').val().trim();
    var apellidos = $('#txtApellidos').val().trim();
    var id_tipousuario = 2;
    var tipo_documento = $('#cboTipoDocumento').val().trim();
    var num_documento = $('#txtNumDocumento').val().trim();
    var id_tipolinea = $('#cboTipoLinea').val().trim();
    var linea = $('#txtLinea').val().trim();
    
    if (nombres == '') {
        alerta('Ingrese sus nombres', 'warning');
        return;
    }
    if (apellidos == '') {
        alerta('Ingrese sus apellidos', 'warning');
        return;
    }
    if (tipo_documento == '') {
        alerta('Seleccione el tipo de documento', 'warning');
        return;
    }
    if (num_documento == '') {
        alerta('Ingrese su número de documento', 'warning');
        return;
    }
    if (id_tipolinea == '') {
        alerta('Seleccione el tipo de línea', 'warning');
        return;
    }
    if (linea == '') {
        alerta('Ingrese la línea', 'warning');
        return;
    }
    if (id_tipolinea == 1) {
        if (linea.length != 9) {
            alerta('La linea debe tener 9 digitos', 'warning');
            return;
        }
    }
    if (id_tipolinea == 2) {
        if (linea.length != 8) {
            alerta('La linea debe tener 8 digitos', 'warning');
            return;
        }
    }
    if (tipo_documento == 'DNI') {
        if (num_documento.length != 8) {
            alerta('El n° de documento debe tener 8 digitos', 'warning');
            return;
        }
    }
    if (tipo_documento == 'CARNET DE EXTRANJERÍA') {
        if (num_documento.length != 11) {
            alerta('El n° de documento debe tener 11 digitos', 'warning');
            return;
        }
    }

    $.ajax({
        type: "POST",
        url: path + "/Registro/registrar_usuario",
        data: {
            'linea': linea,
            'tipolinea': id_tipolinea,
            'id_usuario': 0,
            'id_tipousuario': id_tipousuario,
            'nombres': nombres,
            'apellidos': apellidos,
            'usuario': '',
            'tipo_documento': tipo_documento,
            'num_documento': num_documento,
            'validacion': ''
        },
        accept: 'application/json',
        beforeSend: function () {
            $('.preloader').removeAttr('style');
            $('.preloader').removeClass('hide-element');
        },
        success: function (response) {
            var response_ = response.split('"').join('')
            if (response_ != 'OK') {
                alerta(response_, 'info');
                $('.preloader').addClass('hide-element');
                return;
            }

            reset_formulario_registro();

            alerta('Registro correcto', 'success');
            $('.preloader').addClass('hide-element');
        }
    });
}

function reset_formulario_registro() {
    $('#txtNombres').val('');
    $('#txtApellidos').val('');
    $('#cboTipoDocumento').val('');
    $('#txtNumDocumento').val('');
    $('#cboTipoLinea').val('');
    $('#txtLinea').val('');
}

$(document).ready(function () {
    $('#txtNombres').focus();

    $('#cboTipoLinea').on('change', function () {
        var tipol = $(this).val();
        var ml = 0;

        if (tipol == 1) {
            ml = 9;
        } else if (tipol == 2) {
            ml = 8;
            $('#txtLinea').val(($('#txtLinea').val().substring(0, 8)));
        } else {
            ml = 0;
            $('#txtLinea').val('');
        }

        $('#txtLinea').attr('maxlength', ml);
    })

    $('#cboTipoDocumento').on('change', function () {
        var tipod = $(this).val();
        var ml = 0;

        if (tipod == 'DNI') {
            ml = 8;
            $('#txtNumDocumento').val(($('#txtNumDocumento').val().substring(0, 8)));
        } else if (tipod == 'CARNET DE EXTRANJERÍA') {
            ml = 11;
        } else {
            ml = 0;
            $('#txtNumDocumento').val('');
        }

        $('#txtNumDocumento').attr('maxlength', ml);
    })
})