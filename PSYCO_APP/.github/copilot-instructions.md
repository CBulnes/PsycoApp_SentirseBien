# Copilot Instructions

## General Guidelines
- Follow strict adherence to existing project standards and patterns when implementing functionalities.

## Project-Specific Rules
- En PsycoApp.API, seguir la convención de los controladores existentes: usar `[Route("api/[controller]")]` y evitar constructor (cto) cuando no sea necesario; mantener la estructura coherente con los demás controladores.
- En PsycoApp, los controladores API deben seguir el patrón existente y llamar directamente al BL; no añadir claves internas/env vars como autorización provisional. La autenticación/autorización de API se implementará en una fase posterior.
- El diseño de mantenimiento de productos y terapias debe seguir el patrón visual existente en los mantenimientos de especialistas y pacientes.