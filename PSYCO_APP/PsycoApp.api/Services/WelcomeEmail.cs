using System;
using System.Net;
using System.Net.Mail;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace PsycoApp.api.Services
{
    public class WelcomeEmail
    {
        private readonly IConfiguration config;
        private readonly ILogger<WelcomeEmail> logger;
        public WelcomeEmail(IConfiguration config, ILogger<WelcomeEmail> logger)
        { this.config = config; this.logger = logger; }

        // Best effort after registration commits; a mail failure must not undo signup.
        public async Task<bool> Send(string email, string name)
        {
            try
            {
                if (!config.GetValue<bool>("Email:Enabled")) return false;
                var host = config["Email:Host"];
                var from = config["Email:From"];
                var user = config["Email:Username"];
                var password = config["Email:Password"];
                if (string.IsNullOrWhiteSpace(host) || string.IsNullOrWhiteSpace(from) ||
                    string.IsNullOrWhiteSpace(user) || string.IsNullOrWhiteSpace(password))
                {
                    logger.LogWarning("WelcomeEmail: configuración incompleta; envío omitido.");
                    return false;
                }
                using var message = new MailMessage
                {
                    From = new MailAddress(from, "ScheLink"),
                    Subject = "Bienvenido a ScheLink",
                    Body = $"Hola {name},\n\nTu cuenta se creó correctamente. Ya puedes organizar tu centro en ScheLink.\n\nPara volver a ingresar, utiliza Continuar con Google con esta misma cuenta.\n\nEl equipo de ScheLink",
                    IsBodyHtml = false
                };
                message.To.Add(new MailAddress(email));
                using var smtp = new SmtpClient(host, config.GetValue<int?>("Email:Port") ?? 587)
                {
                    EnableSsl = true,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(user, password)
                };
                using var timeout = new CancellationTokenSource(TimeSpan.FromSeconds(10));
                await smtp.SendMailAsync(message, timeout.Token);
                return true;
            }
            catch (Exception ex) when (ex is SmtpException || ex is OperationCanceledException ||
                ex is ArgumentException || ex is InvalidOperationException || ex is FormatException)
            {
                // No recipient, body, credentials or provider response in application logs.
                logger.LogWarning("WelcomeEmail: envío no completado ({ErrorType}).", ex.GetType().Name);
                return false;
            }
        }
    }
}
