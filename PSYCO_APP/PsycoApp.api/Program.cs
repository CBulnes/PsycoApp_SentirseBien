using System.Linq;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using PsycoApp.BL;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA.Interfaces;
using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.utilities;
using Scalar.AspNetCore;
var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

// Agregar Application Insights
builder.Services.AddApplicationInsightsTelemetry(configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]);

// Agregar servicios
builder.Services.AddControllers();

// Configuración de autenticación con JWT
string semilla = "PsycoApp2024";
byte[] semillarByte = Encoding.UTF8.GetBytes(semilla);
SymmetricSecurityKey key = new SymmetricSecurityKey(semillarByte);

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            IssuerSigningKey = key,
            ValidateLifetime = true,
            ValidIssuer = "www.sentirsebien.com",
            ValidAudience = "www.sentirsebien.com",
            ValidateIssuer = true
        };
    });

// Configuración de CORS
string url_site = Helper.GetUrlSite();
builder.Services.AddCors(opt =>
{
    opt.AddPolicy("Todos", det =>
    {
        det.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
    opt.AddPolicy("SoloSentirseBien", det =>
    {
        det.WithOrigins(url_site).WithMethods("GET", "POST", "PUT", "DELETE").AllowAnyHeader();
    });
});
builder.Services.AddOpenApi();
builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddScoped<IUsuarioLogin, UsuarioBL>();
builder.Services.AddScoped<IUsuarioDA, UsuarioDA>(); // Register UsuarioDA
//// Configuración de Swagger
//builder.Services.AddSwaggerGen(c =>
//{
//    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Psyco App", Version = "1.0" });
//    c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
//});

var app = builder.Build();

// Configuración del middleware
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

//// Swagger
//app.UseSwagger();
//app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Psyco App V1"));

app.MapOpenApi();
app.MapScalarApiReference();

app.UseHttpsRedirection();

app.UseRouting();

app.UseCors("SoloSentirseBien");
app.UseCors("Todos");
app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
