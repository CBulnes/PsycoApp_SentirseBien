(function () {
    'use strict';

    function initSidebar() {
        const btn_colapse = document.querySelector('.sb-aside-compress');
        const abrir_pop = document.querySelector('.sb-aside-logoff');
        const cerrar_pop1 = document.querySelector('.sb-alert-off-button-no');
        const cerrar_pop2 = document.querySelector('.sb-alert-off-block-cross');

        // Verificar que los elementos existen
        if (!btn_colapse) {
            console.error('❌ No se encontró el botón .sb-aside-compress');
            return;
        }

        console.log('✅ Botón minimizar encontrado, configurando evento...');

        // 🔥 IMPORTANTE: Remover eventos previos para evitar duplicados
        btn_colapse.replaceWith(btn_colapse.cloneNode(true));
        const btn_colapse_new = document.querySelector('.sb-aside-compress');

        // Eventos de cerrar sesión
        if (abrir_pop) {
            abrir_pop.addEventListener('click', () => {
                const alertOff = document.querySelector('.sb-alert-off');
                if (alertOff) alertOff.style.display = 'flex';
            });
        }

        if (cerrar_pop1) {
            cerrar_pop1.addEventListener('click', () => {
                const alertOff = document.querySelector('.sb-alert-off');
                if (alertOff) alertOff.style.display = 'none';
            });
        }

        if (cerrar_pop2) {
            cerrar_pop2.addEventListener('click', () => {
                const alertOff = document.querySelector('.sb-alert-off');
                if (alertOff) alertOff.style.display = 'none';
            });
        }

        // Evento principal de colapsar/expandir sidebar
        btn_colapse_new.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();

            const aside_active = document.querySelector('.sb-aside');
            const admin_active = document.querySelector('.sb-admninistrator');

            console.log('🔘 Click en botón minimizar detectado');
            console.log('Sidebar tiene clase "displayed":', aside_active?.classList.contains('displayed'));

            if (!aside_active || !admin_active) {
                console.error('❌ No se encontraron elementos .sb-aside o .sb-admninistrator');
                return;
            }

            // Toggle de clases
            aside_active.classList.toggle('displayed');
            admin_active.classList.toggle('displayed');

            console.log('✅ Clases toggled correctamente');
        });

        console.log('✅ Sidebar inicializado correctamente');
    }

    // Ejecutar cuando el DOM esté listo
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initSidebar);
    } else {
        // DOM ya está listo, ejecutar inmediatamente
        initSidebar();
    }

    // 🔥 Re-inicializar después de que todos los scripts se carguen
    window.addEventListener('load', function () {
        console.log('🔄 Re-inicializando sidebar después de window.load...');
        setTimeout(initSidebar, 100);
    });

    // 🔥 Exponer función global para re-inicializar desde otros scripts
    window.reinitSidebar = initSidebar;
})();

//window.addEventListener("load", function (event) {

//    const btn_colapse = document.querySelector('.sb-aside-compress');
//    const abrir_pop = document.querySelector('.sb-aside-logoff');
//    const cerrar_pop1 = document.querySelector('.sb-alert-off-button-no');
//    const cerrar_pop2 = document.querySelector('.sb-alert-off-block-cross');

//    abrir_pop.addEventListener('click', () => {
//        document.querySelector('.sb-alert-off').style.display = 'flex';
//    });

//    cerrar_pop1.addEventListener('click', () => {
//        document.querySelector('.sb-alert-off').style.display = 'none';
//    });

//    cerrar_pop2.addEventListener('click', () => {
//        document.querySelector('.sb-alert-off').style.display = 'none';
//    });

//    btn_colapse.addEventListener('click', (e) => {
//        var aside_active = $('.sb-aside');
//        var admin_active = $('.sb-admninistrator');

//        if (!aside_active.hasClass('displayed')) {
//            aside_active.addClass("displayed");
//            admin_active.addClass("displayed");
//        }
//        else {
//            aside_active.removeClass("displayed");
//            admin_active.removeClass("displayed");
//        }

//    });
//});
