# .NET Version Upgrade

## Preferences
- **Flow Mode**: Automatic
- **Target Framework**: `net10.0` (.NET 10 LTS)
- **Project Scope**: All projects in `PSYCO_APP` are authorized for .NET 10 where needed to maintain compatible project references; `PsycoApp.utilities` remains at its existing target unless a build requires changing it.

## Source Control
- **Source Branch**: `MainAI`
- **Working Branch**: `upgrade-dotnet-10`
**Commit Strategy**: Single Commit at End
- **Branch Sync**: Auto (Merge)
- **Pending Changes**: Committed before scenario initialization as `113ca0f` (`Save pending work before .NET 10 upgrade`), per user confirmation.

## Decisions
- Upgrade `PsycoApp.api`, `PsycoApp.site`, `PsycoApp.BL`, `PsycoApp.DA`, `PsycoApp.Entities`, and `PsycoApp.mcp` to `net10.0`. Keep `PsycoApp.utilities` unchanged.
- User later authorized upgrading `PsycoApp.mcp` to `net10.0` and fixing both MCP call sites to `disponibilidad_doctor` so the full solution compiles again.

## Upgrade Options
**Source**: .github/upgrades/scenarios/dotnet-version-upgrade/upgrade-options.md

### Strategy
- Upgrade Strategy: All-at-Once

### Compatibility
- Unsupported API Handling: Fix Inline

## Strategy
**Selected**: All-at-Once
**Rationale**: Two ASP.NET Core applications and the authorized shared libraries move to `net10.0` together. MCP projects remain outside scope by user decision.

### Execution Constraints
- Upgrade `PsycoApp.api`, `PsycoApp.site`, `PsycoApp.BL`, `PsycoApp.DA`, `PsycoApp.Entities`, and `PsycoApp.mcp` to `net10.0`; keep `PsycoApp.utilities` unchanged.
- Resolve package and API issues inline in authorized projects, including MCP call sites to match BL method signatures.
- Validate the entire solution and run available tests.

### Scoped Exception
- User authorized removing only the two unused `using` directives reported by the full-solution build in `PSYCO_APP/PsycoApp.DA/CitaDA.cs` (`Microsoft.VisualBasic` and `System.Linq`). This does not authorize other edits to DA or other excluded shared projects.
- User later expanded scope again to include `PsycoApp.mcp` migration to `net10.0` and repairs for both MCP call sites after the initial library-only upgrade introduced TFM and method-arity build errors.
