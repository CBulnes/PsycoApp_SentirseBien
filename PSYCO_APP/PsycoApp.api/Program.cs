using System.Linq;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using PsycoApp.BL;
using Newtonsoft.Json.Serialization;
using Microsoft.AspNetCore.Mvc.NewtonsoftJson;
using Newtonsoft.Json;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA.Interfaces;
using PsycoApp.DA;
using PsycoApp.utilities;
using Scalar.AspNetCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Authorization;
using PsycoApp.api;
using System;
using PsycoApp.api.UsuarioJwt;
var builder = WebApplication.CreateBuilder(args);

// Se le agrega la seguridad a los controladores para que se le envie el token valido
//builder.Services.AddControllers(opt =>
//{
//    var policy = new AuthorizationPolicyBuilder().RequireAuthenticatedUser().Build();
//    opt.Filters.Add(new AuthorizeFilter(policy));

//});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddOpenApi("v1", options => { options.AddDocumentTransformer<BearerSecuritySchemeTransformer>(); });

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


//configuracion de Swagger
builder.Services.AddSwaggerGen(c => {

    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Api Fasi", Version = "v1" });
    c.CustomSchemaIds(c => c.FullName); //Nombre completos api controllers

});
var IssuerSigningKeye = new SymmetricSecurityKey(
              Encoding.UTF8.GetBytes(builder.Configuration["ConfiguracionJwt:Llave"]));
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
                Encoding.UTF8.GetBytes(builder.Configuration["ConfiguracionJwt:Llave"] ?? string.Empty)
            )
        };
    });

// Registrar dependencias
builder.Services.AddOpenApi();
builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddScoped<IUsuarioLogin, UsuarioBL>();
builder.Services.AddScoped<IUsuarioDA, UsuarioDA>(); // Register UsuarioDA
builder.Services.AddScoped<IPaquete, PaqueteBL>();
builder.Services.AddScoped<IPaqueteDA, PaqueteDA>(); // Register PaqueteDA
builder.Services.AddScoped<IManejoJwt, ManejoJwt>();
builder.Services.AddControllers();

builder.Services.AddAuthorization();
var app = builder.Build();

app.UseCors("CorsPolicy");

app.UseCors("Todos");
app.UseCors("SoloSentirseBien");
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();

    //indica la ruta para generar la configuración de swagger
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Psyco App V1");
    });

}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

// Mapear controladores y OpenAPI
app.MapControllers();
app.MapOpenApi();

app.MapScalarApiReference(options =>

 {
     options.Title = "Scalar Api";
     options.Theme = ScalarTheme.BluePlanet;
     options.DefaultHttpClient = new(ScalarTarget.CSharp, ScalarClient.HttpClient);
     options.CustomCss = "";
     options.ShowSidebar = true;
 }
    );
app.Run();


