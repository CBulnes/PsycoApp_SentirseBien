var path = ruta;

var correo = false, cont = false, iguales = false, mayusc = false, minusc = false, numeros = false, especial = false;

function redireccionar(ir_a) {
    window.location.href = path + '/' + ir_a;
}

function validar_registro() {
    var email = $('#txtEmail').val().trim();
    var pass = $('#txtPassword').val().trim();
    var nueva_pass1 = $('#txtNuevaPassword').val().trim();
    var nueva_pass2 = $('#txtNuevaPassword2').val().trim();
    
    //if (email == '') {
    //    alerta('Ingrese su email', 'warning');
    //    return;
    //}
    //if (pass == '') {
    //    alerta('Ingrese su contraseña actual', 'warning');
    //    return;
    //}
    //if (nueva_pass1 == '') {
    //    alerta('Ingrese su nueva contraseña', 'warning');
    //    return;
    //}
    //if (nueva_pass2 == '') {
    //    alerta('Repita su nueva contraseña', 'warning');
    //    return;
    //}

    $.ajax({
        type: "POST",
        url: path + "/RecuperarContraseña/cambiar_contraseña",
        data: { "email": email, "password": pass, "nuevo_pass1": nueva_pass1, "nuevo_pass2": nueva_pass2 },
        accept: 'application/json',
        beforeSend: function () {
            $('.preloader').removeClass('hide-element');
        },
        success: function (response) {
            $('.preloader').addClass('hide-element');
            if (response.estado) {
                alerta('Contraseña actualizada, redireccionando...', 'success');
                setTimeout(function () {
                    window.location.href = path + '/Login';
                }, 3000);
                //show_toast('warning', response.descripcion);
            } else {
                alerta(response.descripcion, 'info');
            }
        }
    });
}

$('#txtNuevaPassword, #txtNuevaPassword2').on('input paste', function () {
    var nueva_pass1 = $('#txtNuevaPassword').val().trim();
    var nueva_pass2 = $('#txtNuevaPassword2').val().trim();

    $.ajax({
        type: "POST",
        url: path + "/RecuperarContraseña/validar_requisitos_contraseña",
        data: { "nuevo_pass1": nueva_pass1, "nuevo_pass2": nueva_pass2 },
        accept: 'application/json',
        beforeSend: function () {
            $('#div_requisitos').removeClass('hide-element');
            $('#spnIguales, #spnMayusc, #spnMinusc, #spnNumeros, #spnEspeciales').removeClass('req-pass-ok');

            mayusc = false;
            minusc = false;
            numeros = false;
            especial = false;
        },
        success: function (response) {
            if (response.iguales) {
                if (nueva_pass1 != '' && nueva_pass2 != '') {
                    $('#spnIguales').addClass('req-pass-ok');
                    iguales = true;
                }
            }
            if (response.mayusc) {
                $('#spnMayusc').addClass('req-pass-ok');
                mayusc = true;
            }
            if (response.minusc) {
                $('#spnMinusc').addClass('req-pass-ok');
                minusc = true;
            }
            if (response.numeros) {
                $('#spnNumeros').addClass('req-pass-ok');
                numeros = true;
            }
            if (response.especial) {
                $('#spnEspeciales').addClass('req-pass-ok');
                especial = true;
            }
        },
        complete: function () {
            validar_formulario()
        }
    });
})

$('#txtEmail, #txtPassword').on('input paste', function () {
    var email = $('#txtEmail').val().trim();
    var pass = $('#txtPassword').val().trim();

    $.ajax({
        type: "POST",
        url: path + "/RecuperarContraseña/validar_credenciales",
        data: { "email": email, "password": pass },
        accept: 'application/json',
        beforeSend: function () {
            correo = false;
            cont = false;
        },
        success: function (response) {
            if (response.estado) {
                correo = true;
                cont = true;
            } else {
                correo = false;
                cont = false;
            }
        },
        complete: function () {
            validar_formulario()
        }
    });
})

function validar_formulario() {
    if (correo && cont && iguales && mayusc && minusc && numeros && especial) {
        $('#btn_ing').removeAttr('disabled');
    } else {
        $('#btn_ing').attr('disabled', true);
    }
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
    $('#txtEmail').focus();
    $('#btn_ing').attr('disabled', true);

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