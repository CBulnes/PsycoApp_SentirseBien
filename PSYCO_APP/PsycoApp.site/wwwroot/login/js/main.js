//(function ($) {
//    "use strict";


/*==================================================================
[ Validate ]*/

var path = ruta;

$(document).ready(function () {
    var n1 = Math.round(Math.random() * 10 + 1);
    var n2 = Math.round(Math.random() * 10 + 1);
    $('#a').val(n1 + ' + ' + n2);

    $('#btn_captcha').on('click', function () {
        if (eval($('#a').val()) == $('#b').val()) {
            alert('Ok! You are human!');
        } else {
            alert('error');
        }
    });

    $('#txtEmail').focus();
    $('#btn_ing').attr('disabled', true);
});

var input = $('.validate-input .input100');

$('#btn_ing').on('click', function () {
    var email = $('#txtEmail').val().trim();
    var pass = $('#txtPassword').val().trim();
    var check = true;

    if (check) {

        setTimeout(function () {
            $.ajax({
                type: "POST",
                url: path + "/Login/validar_usuario",
                data: { "email": email, "password": pass },
                accept: 'application/json',
                beforeSend: function () {
                    $('.preloader').removeClass('hide-element');
                },
                success: function (response) {
                    $('.preloader').addClass('hide-element');
                    if (response.estado) {
                        window.location.href = path + '/Home';
                        //show_toast('warning', response.descripcion);
                    } else {
                        alerta(response.descripcion, 'info');
                    }
                }
            });
        }, 2000);
    }
});

$('#txtEmail, #txtPassword').on('input', function (e) {
    var email = $('#txtEmail').val().trim();
    var pass = $('#txtPassword').val().trim();

    $.ajax({
        type: "POST",
        url: path + "/Login/validar_credenciales",
        data: { "email": email, "password": pass },
        accept: 'application/json',
        beforeSend: function () {
        },
        success: function (response) {
            if (response.estado) {
                $('#btn_ing').removeAttr('disabled');
            } else {
                $('#btn_ing').attr('disabled', true);
            }
        }
    });
})

function reset_captcha() {
    var n1 = Math.round(Math.random() * 10 + 1);
    var n2 = Math.round(Math.random() * 10 + 1);
    $('#a').val(n1 + " + " + n2);
    $('#b').val('');
}

//$('.validate-form').on('submit',function(){
//    var check = true;

//    for(var i=0; i<input.length; i++) {
//        if(validate(input[i]) == false){
//            showValidate(input[i]);
//            check=false;
//        }
//    }

//    return check;
//});


$('.validate-form .input100').each(function () {
    $(this).focus(function () {
        hideValidate(this);
    });
});

function validate(input) {
    if ($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
        if ($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
            return false;
        }
    }
    else {
        if ($(input).val().trim() == '') {
            return false;
        }
    }
}

function showValidate(input) {
    var thisAlert = $(input).parent();

    $(thisAlert).addClass('alert-validate');
}

function hideValidate(input) {
    var thisAlert = $(input).parent();

    $(thisAlert).removeClass('alert-validate');
}



//})(jQuery);

function redireccionar(ir_a, tipo_redireccion) {
    //if (tipo_redireccion == 1) {
    window.location.href = path + '/' + ir_a;
    //} else if (tipo_redireccion == 2) {
    //    window.open(path + '/' + ir_a, '_blank');
    //}
}