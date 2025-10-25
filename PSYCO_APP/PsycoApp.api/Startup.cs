using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using PsycoApp.BL;
using PsycoApp.BL.Interfaces;
using PsycoApp.utilities;

namespace PsycoApp.api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }
        private string url_site = Helper.GetUrlSite();

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddApplicationInsightsTelemetry(Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]);

            #region "inyeccion de dependencias"
            services.AddScoped<IUsuarioBL, UsuarioBL>();
            services.AddScoped<IPsicologoBL, PsicologoBL>();
            services.AddScoped<IPacienteBL, PacienteBL>();
            services.AddScoped<ICitaBL, CitaBL>();
            services.AddScoped<IHistorialBL, HistorialBL>();
            #endregion

            services.AddControllers();

            string semilla = "PsycoApp2024";
            byte[] semillarByte = Encoding.UTF8.GetBytes(semilla);
            SymmetricSecurityKey key = new SymmetricSecurityKey(semillarByte);

            services.AddAuthentication
                (JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(option =>
                {
                    option.TokenValidationParameters = new TokenValidationParameters
                    {
                        IssuerSigningKey = key,
                        ValidateLifetime = true,
                        ValidIssuer = "www.sentirsebien.com",
                        ValidAudience = "www.sentirsebien.com",
                        ValidateIssuer = true
                    };
                });

            services.AddCors(opt =>
            {
                opt.AddPolicy("Todos", det =>
                {
                    det.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
                });
                opt.AddPolicy("SoloSentirseBien", det =>
                {
                    det.WithOrigins(url_site).WithMethods(new string[] { "Get", "Post", "Put", "Delete" }).AllowAnyHeader();
                });
            });

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "Mi API",
                    Version = "v1",
                    Description = "Una descripción de mi API"
                });
            });
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger();

            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "Mi API v1");
                c.RoutePrefix = "swagger";
            });

            //app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors("SoloSentirseBien");

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
