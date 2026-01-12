using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using PsycoApp.BL;
using PsycoApp.mcp.Mcp.Tools;
using PsycoApp.mcp.Services;

// Crear host para aplicación de consola (NO WebApplication)
var builder = Host.CreateApplicationBuilder(args);

// 🔹 Configurar MCP Server con transporte stdio
builder.Services
    .AddMcpServer()
    .WithStdioServerTransport()   // Para MCP stdio
    .WithToolsFromAssembly(typeof(CitasMcpTool).Assembly);

// 🔹 Registrar tus servicios
builder.Services.AddScoped<CitasMcpService>();
builder.Services.AddScoped<PacienteBL>();
builder.Services.AddScoped<PsicologoBL>();
builder.Services.AddScoped<CitaBL>();
builder.Services.AddSingleton<string>(builder.Environment.ContentRootPath);

// 🔹 CONSTRUIR Y EJECUTAR - ¡ESTO ES TODO!
// El MCP Server se inicia automáticamente
await builder.Build().RunAsync();

//using PsycoApp.BL;
//using PsycoApp.mcp.Mcp.Tools;
//using PsycoApp.mcp.Services;

//var builder = WebApplication.CreateBuilder(args);

//// Add services to the container.

//builder.Services.AddControllers();
//// ?? MCP
//// 🔹 MCP Server
//builder.Services
//    .AddMcpServer()
//    .WithStdioServerTransport()   // obligatorio en tu versión
//    .WithToolsFromAssembly(typeof(CitasMcpTool).Assembly);
//// Tus servicios
//builder.Services.AddScoped<CitasMcpService>();
//builder.Services.AddScoped<PacienteBL>();
//builder.Services.AddScoped<PsicologoBL>();
//builder.Services.AddScoped<CitaBL>();
//builder.Services.AddScoped<CitasMcpService>();
//builder.Services.AddSingleton<string>(builder.Environment.ContentRootPath);

//await builder.Build().RunAsync();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
//builder.Services.AddOpenApi();



//var app = builder.Build();
//app.MapMcp();
//app.MapGet("/", () => "PsycoApp MCP Server running");
//// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
//    app.MapOpenApi();
//}

//app.UseHttpsRedirection();

//app.UseAuthorization();

//app.MapControllers();

//app.Run();
