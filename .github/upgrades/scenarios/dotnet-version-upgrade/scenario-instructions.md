# .NET Version Upgrade

## Preferences
- **Flow Mode**: Automatic
- **Target Framework**: `net10.0` (.NET 10 LTS)
- **Project Scope**: `PSYCO_APP/PsycoApp.api`, `PSYCO_APP/PsycoApp.site`, `PSYCO_APP/PsycoApp.BL`, `PSYCO_APP/PsycoApp.DA`, and `PSYCO_APP/PsycoApp.Entities` are authorized for the .NET 10 upgrade. MCP projects remain excluded pending a decision on compatibility with the net9.0 MCP app.

## Source Control
- **Source Branch**: `MainAI`
- **Working Branch**: `upgrade-dotnet-10`
**Commit Strategy**: Single Commit at End
- **Branch Sync**: Auto (Merge)
- **Pending Changes**: Committed before scenario initialization as `113ca0f` (`Save pending work before .NET 10 upgrade`), per user confirmation.

## Decisions
- Upgrade `PsycoApp.api`, `PsycoApp.site`, `PsycoApp.BL`, `PsycoApp.DA`, and `PsycoApp.Entities` to `net10.0`. Keep MCP applications and `PsycoApp.utilities` unchanged.
- User explicitly chose `net10.0` only for BL/DA/Entities and accepts that the `net9.0` `PsycoApp.mcp` project will no longer compile against them. Do not retarget or edit MCP projects.

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
- Upgrade `PsycoApp.api`, `PsycoApp.site`, and the authorized shared libraries BL/DA/Entities to `net10.0`; do not retarget or edit MCP projects or `PsycoApp.utilities`.
- Resolve package and API issues inline only within those five authorized projects.
- Validate all five authorized projects and run available tests. Also build the solution to document any expected MCP compatibility failure; do not repair MCP.

### Scoped Exception
- User authorized removing only the two unused `using` directives reported by the full-solution build in `PSYCO_APP/PsycoApp.DA/CitaDA.cs` (`Microsoft.VisualBasic` and `System.Linq`). This does not authorize other edits to DA or other excluded shared projects.
- User expanded scope to include `PsycoApp.BL`, `PsycoApp.DA`, and `PsycoApp.Entities` as .NET 10 projects; they explicitly accepted that the unchanged net9.0 `PsycoApp.mcp` may fail to build as a result.
