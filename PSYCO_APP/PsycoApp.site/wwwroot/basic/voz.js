var recognition;

var recognizing = false;
if (!('webkitSpeechRecognition' in window)) {
	alerta("Reconocimiento de voz no disponible", 'info');
} else {

	recognition = new webkitSpeechRecognition();
	recognition.lang = "es-VE";
	recognition.continuous = true;
	recognition.interimResults = true;

	recognition.onstart = function () {
		recognizing = true;
		console.log("empezando a escuchar");
	}
	recognition.onresult = function (event) {

		for (var i = event.resultIndex; i < event.results.length; i++) {
			if (event.results[i].isFinal)
				document.getElementById("txtMessage").value = event.results[i][0].transcript;
				$('#txtMessage').focus();
		}

		//texto
	}
	recognition.onerror = function (event) {
	}
	recognition.onend = function () {
		recognizing = false;
		document.getElementById("btn_speak").innerHTML = '<i class="fa fa-microphone"></i>';
		console.log("terminó de escuchar, llegó a su fin");
	}

}

function procesar() {
	if (recognizing == false) {
		recognition.start();
		recognizing = true;
		document.getElementById("btn_speak").innerHTML = '<i class="fa fa-stop" style="font-size: 20px;"></i>';
	} else {
		recognition.stop();
		recognizing = false;
		document.getElementById("btn_speak").innerHTML = '<i class="fa fa-microphone"></i>';
	}
}