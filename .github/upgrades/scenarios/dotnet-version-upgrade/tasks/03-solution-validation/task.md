# 03-solution-validation: Validate the solution and tests

Retarget the newly authorized shared libraries `PsycoApp.Entities`, `PsycoApp.DA`, and `PsycoApp.BL` to `net10.0` in dependency order, then validate all five authorized projects. Following the user's subsequent scope expansion, retarget `PsycoApp.mcp` to `net10.0`, correct both MCP call sites to the BL method signature, and validate the full solution.

**Done when**: API, site, Entities, DA, BL, and `PsycoApp.mcp` target `net10.0` and the full solution builds without errors or warnings; available tests pass; `PsycoApp.utilities` remains unchanged.

## Validation findings
- Targeted builds of `PsycoApp.api.csproj` and `PsycoApp.site.csproj` succeed after the net10.0 migration; the app projects produce no build errors. Rebuild the three newly authorized libraries after retargeting.
- Full-solution build reports CS1501 in `PsycoApp.mcp/Services/CitasMcpService.cs:53` and `PsycoMCPServer/Services/PlanServices.cs:55`. Both invoke `CitaBL.disponibilidad_doctor` with four arguments, while the existing signature in excluded `PsycoApp.BL/CitaBL.cs:304` accepts three (`int id_doctor, string fecha, int servicio`). No MCP or BL files have been modified.
- Earlier solution build also reported IDE0005 unused directives in `PsycoApp.DA/CitaDA.cs`; the user explicitly authorized removing only `Microsoft.VisualBasic` and `System.Linq`. Subsequent full-solution build no longer reported those warnings.
- Test Explorer found no projects/tests for PsycoApp.api or PsycoApp.site; prior scenario discovery found no test projects in the solution.
- The user later authorized retargeting `PsycoApp.mcp` to `net10.0` and fixing both MCP call sites; follow-up targeted builds for MCP consumers and the full solution build succeeded while keeping `PsycoApp.utilities` unchanged.
