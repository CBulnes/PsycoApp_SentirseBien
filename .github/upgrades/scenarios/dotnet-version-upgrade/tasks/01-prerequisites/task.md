# 01-prerequisites: Verify .NET 10 upgrade prerequisites

Confirm the .NET 10 SDK and repository build configuration can restore and build the two selected applications. Review the current project targets and test availability before changing either application; retain the agreed scope, with shared libraries and MCP projects unchanged.

**Done when**: The .NET 10 SDK/build prerequisites are verified, the selected project references and tests are understood, and no unresolved environmental blocker remains.

## Research Findings
- **SDK/configuration**: A compatible .NET 10 SDK is installed; no `global.json` exists to constrain SDK resolution.
- **Selected projects**: `PsycoApp.api` and `PsycoApp.site` are SDK-style web projects currently targeting `netcoreapp3.1`. Their direct project references point to shared SDK-style libraries (`PsycoApp.BL`, `PsycoApp.DA`, `PsycoApp.Entities`, and `PsycoApp.utilities`); those library projects remain out of scope unless validation proves they must change.
- **Other consumers**: `PsycoApp.mcp` targets `net9.0` and `PsycoMCPServer` targets `net10.0`; both consume some shared libraries and remain out of scope.
- **Tests**: Test-project discovery returned no test projects in the solution, so validation will rely on builds unless tests are added or found later.
