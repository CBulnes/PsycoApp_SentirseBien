var path = ruta;

$(document).ready(function () {
    $('#img_call').attr('src', path + '/images/call.jpg');
})

function callNumber(call_center) {
    if (detectMob()) {
        $("#templink").attr("href", "tel:" + call_center);

        fakeClick(event, document.getElementById("templink"));

        setTimeout(function () {
            $('[data-role=popup]').popup('close');
        }, 1);

        registrar_punto_visitado('CALL-CENTER');
    } else {
        alerta('Esta opción solo se encuentra disponible desde la versión mobile', 'info');
    }
}

function fakeClick(event, anchorObj) {
    if (anchorObj.click) {
        anchorObj.click()
    } else if (document.createEvent) {
        if (event.target !== anchorObj) {
            var evt = document.createEvent("MouseEvents");
            evt.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
            var allowDefault = anchorObj.dispatchEvent(evt);
        }
    }
}