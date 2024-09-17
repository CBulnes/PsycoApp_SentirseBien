
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

        var aside_active = document.querySelector('.sb-aside');
        var admin_active = document.querySelector('.sb-admninistrator');
        var list_class = aside_active.classList[1];

        if (list_class === 'displayed') {
            aside_active.classList.remove("displayed");
            admin_active.classList.remove("displayed");
        }
        else {
            if (list_class !== 'displayed') {
                aside_active.classList.add("displayed");
                admin_active.classList.add("displayed");
            }
        }

    });
});
