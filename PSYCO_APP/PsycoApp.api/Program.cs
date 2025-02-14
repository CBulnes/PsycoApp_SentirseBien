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
using PsycoApp.utilities;
using Scalar.AspNetCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Authorization;
using PsycoApp.api;
using System;

var builder = WebApplication.CreateBuilder(args);



// Agregar servicios
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
//builder.Services.AddOpenApi("v1", options => { options.AddDocumentTransformer<BearerSecuritySchemeTransformer>(); });

// Se le agrega la seguridad a los controladores para que se le envie el token valido
//builder.Services.AddControllers(opt =>
//{
//    var policy = new AuthorizationPolicyBuilder().RequireAuthenticatedUser().Build();
//    opt.Filters.Add(new AuthorizeFilter(policy));

//});

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

builder.Services.AddOptions();

// Configurar Swagger solo en desarrollo
//if (isDevelopment)
//{
//    builder.Services.AddSwaggerGen(c =>
//    {
//        c.SwaggerDoc("v1", new OpenApiInfo { Title = "Psyco App", Version = "1.0" });
//        c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
//    });
//}

//autenticacion jwt
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters()
        {
            ValidateIssuer = false,
            ValidateAudience = false,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes("MiSuperClaveSeguraDeAlMenos32Caracteres!")
            ),
             ClockSkew = TimeSpan.Zero // ? Evita la tolerancia de tiempo por defecto (5 min)
        };
    });



// Registrar dependencias
//builder.Services.AddOpenApi();
builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddScoped<IUsuarioLogin, UsuarioBL>();
builder.Services.AddScoped<IUsuarioDA, UsuarioDA>(); // Register UsuarioDA



var app = builder.Build();
app.UseCors("Todos");
// Configuración del middleware
//if (isDevelopment)
//{
//    app.UseDeveloperExceptionPage();
//    app.UseSwagger();
//    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Psyco App V1"));
//}

// Redirección HTTPS
app.UseHttpsRedirection();

//// Configuración de CORS
//app.UseCors("SoloSentirseBien");


// Autenticación y autorización
app.UseAuthentication();
app.UseAuthorization();

// Mapear controladores y OpenAPI
app.MapControllers();
//app.MapOpenApi();

//app.MapScalarApiReference(options =>
 
// {
//     options.Title = "Scalar Api";
//     options.Theme = ScalarTheme.BluePlanet;
//     options.DefaultHttpClient = new(ScalarTarget.CSharp, ScalarClient.HttpClient);
//     options.CustomCss = "";
//     options.ShowSidebar = true;
// }
//    );



app.Run();
