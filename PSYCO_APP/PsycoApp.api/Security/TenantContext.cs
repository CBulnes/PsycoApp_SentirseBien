using System.Security.Claims;

namespace PsycoApp.api.Security
{
    public static class TenantContext
    {
        public static bool IsGlobalAdministrator(ClaimsPrincipal user)
        {
            return user.IsInRole("20");
        }

        public static bool IsCompanyAdministrator(ClaimsPrincipal user)
        {
            return user.IsInRole("1");
        }

        public static bool TryGetIntClaim(ClaimsPrincipal user, string claimType, out int value)
        {
            return int.TryParse(user.FindFirst(claimType)?.Value, out value);
        }

        public static bool CanAccessCompany(ClaimsPrincipal user, int companyId)
        {
            return IsGlobalAdministrator(user) ||
                (IsCompanyAdministrator(user) && TryGetIntClaim(user, "id_empresa", out var tokenCompanyId) && tokenCompanyId > 0 && tokenCompanyId == companyId);
        }
    }
}
