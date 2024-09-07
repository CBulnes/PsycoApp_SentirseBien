var path = ruta;

// timeout session
var timeoutInMiliseconds = 600000; //5 minutos = 300000
var timeoutId;

function startTimer() {
    // window.setTimeout returns an Id that can be used to start and stop a timer
    timeoutId = window.setTimeout(doInactive, timeoutInMiliseconds);
}

function resetTimer() {
    window.clearTimeout(timeoutId)
    startTimer();
}

function doInactive() {
    //console.log('inactivo');

    $.ajax({
        type: "POST",
        url: path + "/Home/inactivar_sesion",
        accept: 'application/json',
        beforeSend: function () {
            
        },
        success: function (data) {
            if (data == 'OK') {
                console.log('sesion inactiva');
            } else {
                //console.log(data);
            }
        }
    });
}

function setupTimers() {
    document.addEventListener("mousemove", resetTimer, false);
    document.addEventListener("mousedown", resetTimer, false);
    document.addEventListener("keypress", resetTimer, false);
    document.addEventListener("touchmove", resetTimer, false);

    startTimer();
}

setupTimers();