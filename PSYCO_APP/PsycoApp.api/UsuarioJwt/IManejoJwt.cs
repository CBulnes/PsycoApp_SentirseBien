namespace PsycoApp.api
{
    public interface IManejoJwt
    {
        public string GenerarToken(string Email, string Fullname);

    }
}
