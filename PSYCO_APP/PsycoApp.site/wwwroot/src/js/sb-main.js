
window.addEventListener("load", function (event) {

    const btn_colapse = document.querySelector('.sb-aside-compress');
    const abrir_pop = document.querySelector('.sb-aside-logoff');
    const cerrar_pop1 = document.querySelector('.sb-alert-off-button-no');
    const cerrar_pop2 = document.querySelector('.sb-alert-off-block-cross');

    abrir_pop.addEventListener('click', () => {
        document.querySelector('.sb-alert-off').style.display = 'flex';
    });

    cerrar_pop1.addEventListener('click', () => {
        document.querySelector('.sb-alert-off').style.display = 'none';
    });

    cerrar_pop2.addEventListener('click', () => {
        document.querySelector('.sb-alert-off').style.display = 'none';
    });

    btn_colapse.addEventListener('click', (e) => {
        var aside_active = $('.sb-aside');
        var admin_active = $('.sb-admninistrator');

        if (!aside_active.hasClass('displayed')) {
            aside_active.addClass("displayed");
            admin_active.addClass("displayed");
        }
        else {
            aside_active.removeClass("displayed");
            admin_active.removeClass("displayed");
        }

    });
});
