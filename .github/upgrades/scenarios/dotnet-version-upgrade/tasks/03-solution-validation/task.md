# 03-solution-validation: Validate the solution and tests

Retarget the newly authorized shared libraries `PsycoApp.Entities`, `PsycoApp.DA`, and `PsycoApp.BL` to `net10.0` in dependency order, then validate all five authorized projects. Run available tests and a full-solution build to document the accepted incompatibility in unchanged MCP projects.

**Done when**: API, site, Entities, DA, and BL target `net10.0` and build without errors or warnings; available tests pass; full-solution build documents only the explicitly accepted MCP incompatibility; no MCP or utilities project is modified.

## Validation findings
- Targeted builds of `PsycoApp.api.csproj` and `PsycoApp.site.csproj` succeed after the net10.0 migration; the app projects produce no build errors. Rebuild the three newly authorized libraries after retargeting.
- Full-solution build reports CS1501 in `PsycoApp.mcp/Services/CitasMcpService.cs:53` and `PsycoMCPServer/Services/PlanServices.cs:55`. Both invoke `CitaBL.disponibilidad_doctor` with four arguments, while the existing signature in excluded `PsycoApp.BL/CitaBL.cs:304` accepts three (`int id_doctor, string fecha, int servicio`). No MCP or BL files have been modified.
- Earlier solution build also reported IDE0005 unused directives in `PsycoApp.DA/CitaDA.cs`; the user explicitly authorized removing only `Microsoft.VisualBasic` and `System.Linq`. Subsequent full-solution build no longer reported those warnings.
- Test Explorer found no projects/tests for PsycoApp.api or PsycoApp.site; prior scenario discovery found no test projects in the solution.
- The user subsequently authorized retargeting `PsycoApp.BL`, `PsycoApp.DA`, and `PsycoApp.Entities` and explicitly accepts the resulting MCP incompatibility. Keep MCP and `PsycoApp.utilities` unchanged.
- After retargeting, targeted builds succeed for `PsycoApp.Entities`, `PsycoApp.DA`, `PsycoApp.BL`, `PsycoApp.api`, and `PsycoApp.site`. The full-solution build now also reports expected NU1201 incompatibility for `PsycoApp.mcp` (net9.0 referencing net10.0 BL/DA/Entities); `PsycoMCPServer` (net10.0) still has the independent CS1501 call with four args to the three-arg BL method. These consumer errors are accepted by the user's scope choice; no MCP files were edited.
