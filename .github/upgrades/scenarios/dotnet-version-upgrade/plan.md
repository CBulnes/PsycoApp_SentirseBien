# .NET Version Upgrade Plan

## Overview

**Target**: Move `PsycoApp.api`, `PsycoApp.site`, `PsycoApp.BL`, `PsycoApp.DA`, and `PsycoApp.Entities` from `netcoreapp3.1` to `net10.0`.
**Scope**: Two ASP.NET Core applications and three shared libraries. MCP projects and `PsycoApp.utilities` remain unchanged; the user accepts that the net9.0 MCP consumer may no longer build against net10.0 libraries.

### Selected Strategy
**All-at-Once** — Upgrade both applications and the three authorized shared libraries; execute library retargeting in dependency order.
**Rationale**: The user expanded scope to include BL, DA, and Entities, and explicitly accepted that the unchanged net9.0 MCP project may not compile.

**Projects in scope**: `PsycoApp.api`, `PsycoApp.site`, `PsycoApp.BL`, `PsycoApp.DA`, `PsycoApp.Entities`.

## Tasks

### 01-prerequisites: Verify .NET 10 upgrade prerequisites

Confirm the .NET 10 SDK and repository build configuration can restore and build the two selected applications. Review the current project targets and test availability before changing either application; retain the agreed scope, with shared libraries and MCP projects unchanged.

**Done when**: The .NET 10 SDK/build prerequisites are verified, the selected project references and tests are understood, and no unresolved environmental blocker remains.

---

### 02-web-apps: Upgrade API and site to .NET 10

Update `PsycoApp.api` and `PsycoApp.site` together to target `net10.0`, align their direct package references with that target, and resolve the API/runtime incompatibilities found for those applications. The assessment reports 12 API issues for the API and 32 for the site, plus package upgrade, deprecation, and vulnerability findings. It also reports extensive `System.Data.SqlClient` API differences in `PsycoApp.DA`; that library and the other shared libraries are explicitly outside scope, so do not edit them. If an in-scope fix requires changing an excluded dependency, stop and ask before proceeding.

**Done when**: Both selected project files target `net10.0`, in-scope package and API changes are resolved, and both applications build without errors while excluded project files remain unchanged.

---

### 03-solution-validation: Validate the solution and tests

Retarget the newly authorized shared libraries `PsycoApp.Entities`, `PsycoApp.DA`, and `PsycoApp.BL` to `net10.0` in dependency order, then validate the API/site and all five authorized projects. Run available tests and a full-solution build to record the accepted incompatibility in unchanged MCP projects.

**Done when**: API, site, Entities, DA, and BL target `net10.0` and build without errors or warnings; available tests pass; the full solution has no unexpected errors, with only the explicitly accepted net9.0 MCP-to-net10.0 library incompatibility remaining; no MCP or utilities project is modified.
