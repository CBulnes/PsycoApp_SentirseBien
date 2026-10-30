using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using Microsoft.IdentityModel.Tokens;
using PsycoApp.api.Security;

// Offline cryptographic tests. Synthetic keys are never trusted by the app host.
using var rsa = RSA.Create(2048);
using var otherRsa = RSA.Create(2048);
var key = new RsaSecurityKey(rsa) { KeyId = "test-key" };
var otherKey = new RsaSecurityKey(otherRsa) { KeyId = "other-key" };
var config = new ConfigurationBuilder().AddInMemoryCollection(new Dictionary<string,string>
{
    ["Authentication:Google:Enabled"] = "true",
    ["Authentication:Google:ClientId"] = "test-client"
}).Build();
var validator = new GoogleIdentityValidator(config, new TestMetadata(key));
var passed = 0;
string Token(string audience = "test-client", string issuer = "https://accounts.google.com",
    string subject = "test-subject", string verified = "true", int minutes = 5,
    SigningCredentials signing = null, bool unsigned = false, bool expiry = true, string email = "qa@example.com")
{
    var claims = new List<Claim>();
    if(email != null) claims.Add(new Claim("email", email));
    if (subject != null) claims.Add(new Claim("sub", subject));
    if (verified != null) claims.Add(new Claim("email_verified", verified, ClaimValueTypes.Boolean));
    return new JwtSecurityTokenHandler().WriteToken(new JwtSecurityToken(issuer, audience, claims,
        notBefore: DateTime.UtcNow.AddMinutes(-30), expires: expiry ? DateTime.UtcNow.AddMinutes(minutes) : null,
        signingCredentials: unsigned ? null : signing ?? new SigningCredentials(key, SecurityAlgorithms.RsaSha256)));
}
async Task Accept(string label, string token)
{
    var identity = await validator.Validate(token, CancellationToken.None);
    if (identity.FindFirst("sub")?.Value != "test-subject") throw new Exception(label);
    Console.WriteLine("PASS " + label); passed++;
}
async Task Reject(string label, string token)
{
    try { await validator.Validate(token, CancellationToken.None); }
    catch (SecurityTokenException) { Console.WriteLine("PASS " + label); passed++; return; }
    throw new Exception("Accepted invalid credential: " + label);
}
await Accept("valid signed identity", Token());
await Accept("alternate Google issuer", Token(issuer:"accounts.google.com"));
await Reject("wrong audience", Token(audience:"attacker-client"));
await Reject("wrong issuer", Token(issuer:"https://attacker.invalid"));
await Reject("expired", Token(minutes:-10));
await Reject("unverified email", Token(verified:"false"));
await Reject("missing email", Token(email:null));
await Reject("invalid email", Token(email:"invalid"));
await Reject("oversized email", Token(email:new string('a',100)+"@example.com"));
await Reject("missing subject", Token(subject:null));
await Reject("missing expiration", Token(expiry:false));
await Reject("unsigned", Token(unsigned:true));
await Reject("wrong signing key", Token(signing:new SigningCredentials(otherKey,SecurityAlgorithms.RsaSha256)));
await Reject("algorithm confusion", Token(signing:new SigningCredentials(new SymmetricSecurityKey(RandomNumberGenerator.GetBytes(32)),SecurityAlgorithms.HmacSha256)));
await Reject("malformed", "not-a-token");
await Reject("empty", "");
await Reject("oversized", new string('x',12001));
var disabled = new GoogleIdentityValidator(new ConfigurationBuilder().Build(), new TestMetadata(key));
try { await disabled.Validate(Token(),CancellationToken.None); throw new Exception("Disabled accepted"); }
catch(InvalidOperationException) { Console.WriteLine("PASS disabled provider"); passed++; }
var rotation = new TestMetadata(otherKey, key);
await new GoogleIdentityValidator(config, rotation).Validate(Token(), CancellationToken.None);
if (rotation.Refreshes != 1) throw new Exception("Key refresh was not requested");
Console.WriteLine("PASS signing key rotation"); passed++;
Console.WriteLine($"{passed} security checks passed.");
var mailLogger = Microsoft.Extensions.Logging.Abstractions.NullLogger<PsycoApp.api.Services.WelcomeEmail>.Instance;
var mailDisabled = new PsycoApp.api.Services.WelcomeEmail(new ConfigurationBuilder().Build(), mailLogger);
if (await mailDisabled.Send("qa@example.com", "QA")) throw new Exception("Disabled mail sent");
var mailConfig = new ConfigurationBuilder().AddInMemoryCollection(new Dictionary<string,string> {
    ["Email:Enabled"]="true", ["Email:Host"]="127.0.0.1", ["Email:Port"]="1",
    ["Email:From"]="sender@example.com", ["Email:Username"]="test", ["Email:Password"]="synthetic"
}).Build();
if (await new PsycoApp.api.Services.WelcomeEmail(mailConfig, mailLogger).Send("qa@example.com", "QA"))
    throw new Exception("Unavailable SMTP accepted");
Console.WriteLine("PASS mail disabled and SMTP failure contained");
if (args.Contains("--sql")) SqlChecks.Run(Environment.CurrentDirectory);

sealed class TestMetadata(SecurityKey initial, SecurityKey replacement = null) : IConfigurationManager<OpenIdConnectConfiguration>
{
    public int Refreshes { get; private set; }
    public Task<OpenIdConnectConfiguration> GetConfigurationAsync(CancellationToken cancel)
    {
        var value = new OpenIdConnectConfiguration();
        value.SigningKeys.Add(Refreshes > 0 && replacement != null ? replacement : initial);
        return Task.FromResult(value);
    }
    public void RequestRefresh() { Refreshes++; }
}
