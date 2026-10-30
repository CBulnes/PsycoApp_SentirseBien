# Pruebas HTTP locales sin acceso a datos reales. Requiere compilación aislada previa.
param([switch]$GoogleEnabled)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Net.Http
$repo = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$artifacts = Join-Path $repo '.functional-artifacts'
$bin = Join-Path $artifacts 'bin/Debug/net10.0'
$results = [Collections.Generic.List[object]]::new()
$processes = [Collections.Generic.List[object]]::new()
$handler = [Net.Http.HttpClientHandler]::new()
$handler.AllowAutoRedirect = $false
$handler.UseCookies = $true
$http = [Net.Http.HttpClient]::new($handler)
$http.Timeout = [TimeSpan]::FromSeconds(12)
function Request($method, $url, $data = $null, $type = 'application/json', $bearer = $null) {
    $req = [Net.Http.HttpRequestMessage]::new([Net.Http.HttpMethod]::new($method), $url)
    if ($null -ne $data) { $req.Content = [Net.Http.StringContent]::new($data, [Text.Encoding]::UTF8, $type) }
    if ($bearer) { $req.Headers.Authorization = [Net.Http.Headers.AuthenticationHeaderValue]::new('Bearer', $bearer) }
    try {
        $res = $http.SendAsync($req).GetAwaiter().GetResult()
        try { return @{ Status = [int]$res.StatusCode; Body = $res.Content.ReadAsStringAsync().GetAwaiter().GetResult(); Location = [string]$res.Headers.Location } }
        finally { $res.Dispose() }
    } finally { $req.Dispose() }
}
function Check($name, $method, $url, $expected, $data = $null, $pattern = $null, $type = 'application/json', $bearer = $null) {
    try {
        $r = Request $method $url $data $type $bearer
        $ok = ($r.Status -eq $expected) -and (-not $pattern -or $r.Body -match $pattern)
        $results.Add([pscustomobject]@{ Case=$name; Expected=$expected; Actual=$r.Status; Passed=$ok; Detail= $(if ($pattern) {'Comprobación de contenido incluida'} else {''}) })
        return $r
    } catch {
        $results.Add([pscustomobject]@{ Case=$name; Expected=$expected; Actual=0; Passed=$false; Detail=$_.Exception.GetType().Name })
        return @{ Status=0; Body=''; Location='' }
    }
}
function FreePort {
    $listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
    $listener.Start()
    $port = $listener.LocalEndpoint.Port
    $listener.Stop()
    return $port
}
function StartApp($name, $url, $root) {
    $dll = Join-Path $repo ($name + '/bin/Functional/Debug/net10.0/' + $name + '.dll')
    if (-not (Test-Path -LiteralPath $dll)) { throw ('Falta compilación: ' + $name) }
    $args = '"' + $dll + '" --urls ' + $url + ' --environment Development --contentRoot "' + $root + '"'
    if ($name -eq 'PsycoApp.site') { $args += ' --webroot "' + (Join-Path $repo 'PsycoApp.site/wwwroot') + '"' }
    $p = Start-Process dotnet -ArgumentList $args -WorkingDirectory $root -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $artifacts ($name + '.stdout.log')) -RedirectStandardError (Join-Path $artifacts ($name + '.stderr.log'))
    $processes.Add($p)
    for ($i=0; $i -lt 50; $i++) {
        if ($p.HasExited) { throw ('No arrancó ' + $name + '; revisar logs locales.') }
        try { $null = Request 'GET' ($url + '/__ready'); return } catch { Start-Sleep -Milliseconds 300 }
    }
    throw ('Tiempo de arranque agotado: ' + $name)
}
try {
    $siteUrl = 'http://127.0.0.1:' + (FreePort)
    $apiUrl = 'http://127.0.0.1:' + (FreePort)
    $siteRoot = Join-Path $artifacts 'site'
    $apiRoot = Join-Path $artifacts 'api'
    foreach ($dir in @($siteRoot, $apiRoot)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    # Configuración sintética. SQL usa un puerto reservado no disponible; nunca una conexión del proyecto.
    $config = @{
        AppSettings=@{ API_URL=$apiUrl; SITE_URL=$siteUrl; NOMBRE_SITE='Functional tests' }
        Authentication=@{ Google=@{ Enabled=$GoogleEnabled.IsPresent; ClientId='functional-tests.apps.googleusercontent.com' } }
        ConnectionStrings=@{ db_psycoContext='Server=127.0.0.1,1;Database=FunctionalTests_NoDatabase;Integrated Security=true;Connect Timeout=1;Encrypt=false' }
        Jwt=@{ Key='functional-test-only-key-00000000000000000000000000000000'; Issuer='functional-tests'; Audience='functional-tests' }
        Configuration=@{ LOG_ERROR_ACTIVO='0'; LOG_TRANSAC_ACTIVO='0'; RUTA_LOG_ERROR=$artifacts; RUTA_LOG_TRANSAC=$artifacts }
        APPLICATIONINSIGHTS_CONNECTION_STRING='InstrumentationKey=00000000-0000-0000-0000-000000000000;IngestionEndpoint=http://127.0.0.1:1/;LiveEndpoint=http://127.0.0.1:1/'
        ApplicationInsights=@{ DisableTelemetry=$true }
        Logging=@{ LogLevel=@{ Default='Warning' } }
    } | ConvertTo-Json -Depth 6
    foreach ($dir in @($siteRoot, $apiRoot)) { [IO.File]::WriteAllText((Join-Path $dir 'appsettings.json'), $config) }
    Copy-Item -LiteralPath (Join-Path $repo 'PsycoApp.site/Views') -Destination $siteRoot -Recurse -Force
    StartApp 'PsycoApp.api' $apiUrl $apiRoot
    StartApp 'PsycoApp.site' $siteUrl $siteRoot
    $null = Check 'Landing pública' GET ($siteUrl+'/') 200 $null 'PsycoApp'
    $null = Check 'Pantalla de login' GET ($siteUrl+'/Login') 200 $null 'txtPassword'
    $form = Check 'Formulario SaaS y antiforgery' GET ($siteUrl+'/SaaS/Registro') 200 $null '__RequestVerificationToken'
    $null = Check 'CSS de pantalla pública' GET ($siteUrl+'/login/vendor/bootstrap/css/bootstrap.min.css') 200
    $null = Check 'Home sin sesión redirige' GET ($siteUrl+'/Home') 302
    $null = Check 'Sede inválida en login' GET ($siteUrl+'/Login/sedes?idEmpresa=0') 400
    $null = Check 'SaaS rechaza POST sin antiforgery' POST ($siteUrl+'/SaaS/Registro') 400 '' $null 'application/x-www-form-urlencoded'
    $token = [regex]::Match($form.Body, 'name="__RequestVerificationToken"[^>]*value="([^"]+)"').Groups[1].Value
    if ($token) {
        $encodedToken = [Uri]::EscapeDataString([Net.WebUtility]::HtmlDecode($token))
        $null = Check 'SaaS exige datos con token válido' POST ($siteUrl+'/SaaS/Registro') 200 ('__RequestVerificationToken='+$encodedToken) 'Indica el nombre de la empresa' 'application/x-www-form-urlencoded'
        $data = '__RequestVerificationToken='+$encodedToken+'&Empresa=EmpresaQA&Sede=SedeQA&Nombres=Prueba&Apellidos=Local&Usuario=usuario123&Password=Prueba123&ConfirmarPassword=Distinta123'
        $null = Check 'SaaS valida usuario y confirmación' POST ($siteUrl+'/SaaS/Registro') 200 $data 'El usuario debe contener solo letras' 'application/x-www-form-urlencoded'
        $mismatch = $data.Replace('Usuario=usuario123', 'Usuario=usuarioqa')
        $null = Check 'SaaS rechaza contraseñas diferentes' POST ($siteUrl+'/SaaS/Registro') 200 $mismatch 'Las contrase&#xF1;as no coinciden|Las contraseñas no coinciden' 'application/x-www-form-urlencoded'
    } else {
        $results.Add([pscustomobject]@{Case='Extracción antiforgery';Expected=1;Actual=0;Passed=$false;Detail='No se pudieron ejecutar casos con token'})
    }
    $null = Check 'Citas rechaza anónimo' POST ($apiUrl+'/api/Cita/registrar_cita') 401 '{}'
    $null = Check 'Caja rechaza anónimo' POST ($apiUrl+'/api/Caja/registrar_pago') 401 '{}'
    $null = Check 'Alta empresa rechaza anónimo' POST ($apiUrl+'/api/EmpresaSede/empresas') 401 '{}'
    $null = Check 'Citas rechaza token inválido' POST ($apiUrl+'/api/Cita/registrar_cita') 401 '{}' $null 'application/json' 'invalid.token.value'
    $null = Check 'Registro API exige datos' POST ($apiUrl+'/api/EmpresaSede/registro-prueba') 400 '{}'
    $null = Check 'Registro API rechaza JSON malformado' POST ($apiUrl+'/api/EmpresaSede/registro-prueba') 400 '{'
    $null = Check 'Registro API rechaza usuario con números' POST ($apiUrl+'/api/EmpresaSede/registro-prueba') 400 '{"empresa":"QA","sede":"QA","nombres":"Prueba","apellidos":"Local","usuario":"usuario123","password":"Prueba123"}'
    $null = Check 'Login no disponible informa 503' GET ($siteUrl+'/Login/empresas') 503
    $null = Check 'Ruta inexistente conserva 404' GET ($siteUrl+'/ruta-qa-inexistente') 404
    $null = Check 'Google no permite registro sin identidad' GET ($siteUrl+'/Google/Registro') 302
    $null = Check 'Google no permite vincular sin sesión' GET ($siteUrl+'/Google/Vincular') 302
    $null = Check 'Google exige antiforgery en login' POST ($siteUrl+'/Google/Login') 400 'credential=invalid' $null 'application/x-www-form-urlencoded'
    $null = Check 'Google exige antiforgery en nonce' POST ($siteUrl+'/Google/ChallengeNonce') 400 '' $null 'application/x-www-form-urlencoded'
    $null = Check 'API Google exige autenticación para vincular' POST ($apiUrl+'/api/google/link') 401 '{"credential":"invalid"}'
    $null = Check 'Google JS servido' GET ($siteUrl+'/js/google-access.js') 200
    if ($GoogleEnabled) {
        $null = Check 'API Google rechaza token malformado' POST ($apiUrl+'/api/google/login') 401 '{"credential":"not-a-token"}'
        $null = Check 'API Google rechaza registro sin token válido' POST ($apiUrl+'/api/google/register') 401 '{"credential":"not-a-token","empresa":"QA","sede":"QA","nombres":"QA","apellidos":"QA"}'
        $nonce = Check 'Nonce Google con antiforgery válido' POST ($siteUrl+'/Google/ChallengeNonce') 200 ('__RequestVerificationToken='+$encodedToken) 'nonce' 'application/x-www-form-urlencoded'
        $null = Check 'Login Google rechaza nonce ausente' POST ($siteUrl+'/Google/Login') 400 ('__RequestVerificationToken='+$encodedToken+'&credential=not-a-token') $null 'application/x-www-form-urlencoded'
        $null = Check 'Botón oficial Google configurado' GET ($siteUrl+'/Login') 200 $null 'accounts.google.com/gsi/client'
    } else {
        $null = Check 'API Google desactivado' POST ($apiUrl+'/api/google/login') 503 '{"credential":"not-a-token"}'
        $null = Check 'Registro Google desactivado' POST ($apiUrl+'/api/google/register') 503 '{"credential":"not-a-token","empresa":"QA","sede":"QA","nombres":"QA","apellidos":"QA"}'
        $null = Check 'Botón Google informa disponibilidad' GET ($siteUrl+'/Login') 200 $null 'disponible pronto'
    }
} finally {
    foreach ($p in $processes) { if (-not $p.HasExited) { Stop-Process -Id $p.Id -ErrorAction SilentlyContinue } }
    $http.Dispose()
    New-Item -ItemType Directory -Path $artifacts -Force | Out-Null
    $results | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath (Join-Path $artifacts 'results.json') -Encoding UTF8
    $results | Format-Table -AutoSize
}
if (@($results | Where-Object { -not $_.Passed }).Count -gt 0) { exit 1 }