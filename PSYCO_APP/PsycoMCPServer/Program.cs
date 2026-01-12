using System;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PsycoApp.BL;
using PsycoMCPServer.Mcp.Tools;
using PsycoMCPServer.Services;
using Microsoft.Extensions.Logging;

Console.SetOut(Console.Error);
AppDomain.CurrentDomain.UnhandledException += (_, e) =>
{
    Console.Error.WriteLine("UnhandledException: " + (e.ExceptionObject as Exception)?.ToString() ?? e.ExceptionObject?.ToString());
};

TaskScheduler.UnobservedTaskException += (_, e) =>
{
    Console.Error.WriteLine("UnobservedTaskException: " + e.Exception?.ToString());
    e.SetObserved();
};


var builder = Host.CreateApplicationBuilder(args);

// Evitar providers que escriban por stdout
builder.Logging.ClearProviders();
builder.Logging.AddSimpleConsole(options =>
{
    options.SingleLine = true;
    options.TimestampFormat = "HH:mm:ss ";
});

builder.Logging.SetMinimumLevel(LogLevel.Debug);
builder.Configuration.Sources.Clear();
builder.Configuration
    .SetBasePath(AppContext.BaseDirectory)
    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
    .AddEnvironmentVariables();

builder.Services.AddHttpClient();
builder.Services.AddHttpClient();
builder.Services.AddScoped<PacienteBL>();
builder.Services.AddScoped<PsicologoBL>();
builder.Services.AddScoped<CitaBL>();
builder.Services.AddScoped<PlanServices>(sp =>
    new PlanServices(
        sp.GetRequiredService<PacienteBL>(),
        sp.GetRequiredService<PsicologoBL>(),
        sp.GetRequiredService<CitaBL>(),
        AppContext.BaseDirectory
    )
);

builder.Services
    .AddMcpServer()
    .WithStdioServerTransport()
    .WithToolsFromAssembly(typeof(CitasMcpTool).Assembly);

await builder.Build().RunAsync();