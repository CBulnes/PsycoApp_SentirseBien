var path = ruta;

var whatsapp_icon = path + "/images/wsp.png";

$('#WAButton').floatingWhatsApp({
    phone: whatsapp, //Número de WhatsApp Business
    headerTitle: 'Chatea cono nosotros', //Titulo del popup
    popupMessage: 'Hola, ¿cómo podemos ayudarte?', //Mensaje por defecto del popup
    showPopup: false, //Habilitar o no el popup
    buttonImage: '<img src="' + whatsapp_icon + '" />', //Imagen del boton
    //headerColor: 'crimson', //Color de cabecera del popup
    //backgroundColor: 'crimson', //Color del boton (no aplica - se sustituyo por una imagen)
    position: "right" //Posicion del boton (right | left)
});
