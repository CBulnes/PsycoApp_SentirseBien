(function () {
    'use strict';
    let started = false;
    window.startGoogleAccess = async function () {
        const button = document.getElementById('google-access-button');
        const form = document.getElementById('google-access-form');
        const status = document.getElementById('google-access-status');
        if (started || !button || !form || !window.google?.accounts?.id) return;
        started = true;
        try {
            const csrf = form.querySelector('input[name="__RequestVerificationToken"]').value;
            const nonceResponse = await fetch('/Google/ChallengeNonce', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'RequestVerificationToken': csrf }
            });
            if (!nonceResponse.ok) throw new Error();
            const { nonce } = await nonceResponse.json();
            google.accounts.id.initialize({
                client_id: button.dataset.clientId, nonce,
                auto_select: false,
                callback: async function (response) {
                    status.textContent = 'Comprobando tu cuenta…';
                    document.getElementById('google-credential').value = response.credential;
                    try {
                        const result = await fetch(form.action, {
                            method: 'POST', credentials: 'same-origin', body: new FormData(form)
                        });
                        if (!result.ok) throw new Error();
                        const data = await result.json();
                        if (typeof data.redirect !== 'string' || !data.redirect.startsWith('/') || data.redirect.startsWith('//')) throw new Error();
                        window.location.assign(data.redirect);
                    } catch {
                        status.textContent = 'No se pudo completar el acceso. Recarga la página e inténtalo nuevamente.';
                    } finally {
                        document.getElementById('google-credential').value = '';
                    }
                }
            });
            google.accounts.id.renderButton(button, {
                theme: 'outline', size: 'large', text: 'continue_with', locale: 'es', shape: 'rectangular'
            });
        } catch {
            status.textContent = 'Google no está disponible en este momento. Puedes usar tu usuario y contraseña.';
        }
    };
    window.addEventListener('load', window.startGoogleAccess);
    window.startGoogleAccess();
})();
