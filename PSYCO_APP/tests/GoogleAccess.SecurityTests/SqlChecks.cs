using System.Text.Json;
using System.Text.RegularExpressions;
using Microsoft.Data.SqlClient;
using PsycoApp.DA;
using PsycoApp.entities;

static class SqlChecks
{
    public static void Run(string repo)
    {
        // Entirely disposable database; never uses the application's connection string.
        var database = "PsycoGoogleTests_" + Guid.NewGuid().ToString("N");
        var connection = new SqlConnectionStringBuilder
        {
            DataSource = ".", IntegratedSecurity = true, TrustServerCertificate = true,
            InitialCatalog = "master", ConnectTimeout = 5, Pooling = false
        };
        var originalDirectory = Environment.CurrentDirectory;
        var folder = Path.Combine(repo, ".functional-artifacts", database);
        Directory.CreateDirectory(folder);
        var created = false;
        var passed = 0;
        void Sql(string text, bool master = false)
        {
            var cs = new SqlConnectionStringBuilder(connection.ConnectionString) { InitialCatalog = master ? "master" : database };
            using var cn = new SqlConnection(cs.ConnectionString); cn.Open();
            using var cmd = new SqlCommand(text, cn); cmd.ExecuteNonQuery();
        }
        int Count(string table)
        {
            using var cn = new SqlConnection(connection.ConnectionString); cn.Open();
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo." + table, cn);
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
        void Check(string label, bool ok)
        {
            if (!ok) throw new Exception("SQL check failed: " + label);
            Console.WriteLine("PASS SQL " + label); passed++;
        }
        try
        {
            Sql("CREATE DATABASE [" + database + "]", master:true); created = true;
            connection.InitialCatalog = database;
            Sql(@"
CREATE TABLE dbo.tbl_empresa(Id int IDENTITY PRIMARY KEY,Nombre varchar(200),Estado bit);
CREATE TABLE dbo.tbl_sede(Id int IDENTITY PRIMARY KEY,Nombre varchar(200),Estado bit,Centro varchar(100),Id_empresa int REFERENCES dbo.tbl_empresa(Id));
CREATE TABLE dbo.tbl_usuario(id_usuario int IDENTITY PRIMARY KEY,nombres varchar(100),apellidos varchar(100),id_tipousuario int,
 password varbinary(300),habilitado int,tipo_documento varchar(50),num_documento varchar(50),email varchar(100) UNIQUE,
 test_actual int,login varchar(50),id_sede int REFERENCES dbo.tbl_sede(Id));
CREATE TABLE dbo.tbl_empresa_acceso(Id_empresa int PRIMARY KEY REFERENCES dbo.tbl_empresa(Id),Estado varchar(20),Fecha_inicio_utc datetime2,Fecha_fin_utc datetime2 NULL);
CREATE TABLE dbo.tbl_psicologo(Id int PRIMARY KEY,DocumentoNumero varchar(50));
CREATE TABLE dbo.tbl_sede_usuario(Id_sede int,Id_psicologo int);");
            // Fake encryption only in this scratch DB, to avoid importing any production secret.
            Sql("CREATE FUNCTION dbo.fn_EncriptarPassword(@value varchar(50)) RETURNS varbinary(300) AS BEGIN RETURN CONVERT(varbinary(300),@value); END");
            var migration = File.ReadAllText(Path.Combine(repo,"PsycoApp.DA/SQLScripts/Patch_google_identity.sql"));
            foreach (var batch in Regex.Split(migration,@"^GO\s*$",RegexOptions.Multiline|RegexOptions.IgnoreCase))
                if (!string.IsNullOrWhiteSpace(batch)) Sql(batch);
            File.WriteAllText(Path.Combine(folder,"appsettings.json"), JsonSerializer.Serialize(new
            {
                ConnectionStrings = new { db_psycoContext = connection.ConnectionString }
            }));
            Environment.CurrentDirectory = folder;
            var da = new GoogleIdentityDA();
            GoogleRegistration Registration() => new()
            { Empresa="QA scratch company", Sede="QA scratch site", Nombres="QA", Apellidos="Synthetic" };
            da.Register("qa-subject",Registration(),"qa@example.com");
            var account = da.Find("qa-subject");
            Check("registered account has company/site",account.HasValue && account.Value.User.id_empresa>0 && account.Value.User.id_sede>0);
            Check("verified email stored separately from login",account.Value.User.email=="qa@example.com" && account.Value.User.login.StartsWith("GOOGLE"));
            da.UpdateEmail("qa-subject","updated@example.com");
            Check("existing Google account email refreshed",da.Find("qa-subject").Value.User.email=="updated@example.com");
            Check("signup only grants company administrator",account.Value.User.id_tipousuario==1);
            Check("no psychologist link for administrator",Count("tbl_sede_usuario")==0);
            Check("only one company created",Count("tbl_empresa")==1);
            Check("new trial access exists",Count("tbl_empresa_acceso")==1);
            var duplicateRejected=false;
            try { da.Register("qa-subject",Registration(),"qa@example.com"); } catch(InvalidOperationException) { duplicateRejected=true; }
            Check("duplicate identity rejected without another company",duplicateRejected && Count("tbl_empresa")==1);
            da.Link("qa-subject",account.Value.User.id_usuario,"qa@example.com");
            Check("link is idempotent",Count("tbl_google_identity")==1);
            Sql("INSERT dbo.tbl_usuario(nombres,apellidos,id_tipousuario,habilitado,email,login,id_sede) VALUES('QA','Other',3,1,'QAOTHER','QAOTHER',1)");
            var conflict=false;
            try { da.Link("qa-subject",2,"qa@example.com"); } catch(SqlException e) when(e.Number==50202){conflict=true;}
            Check("cannot steal another user's identity",conflict && da.Find("qa-subject").Value.User.id_usuario==1);
            conflict=false;
            try { da.Link("different-subject",1,"qa@example.com"); } catch(SqlException e) when(e.Number==50202){conflict=true;}
            Check("cannot replace linked identity",conflict && Count("tbl_google_identity")==1);
            da.Link("qa-other-subject",2,"other@example.com");
            Check("explicit linking preserves internal role and tenant",da.Find("qa-other-subject").Value.User.id_tipousuario==3 && da.Find("qa-other-subject").Value.User.id_empresa==1);
            Sql("UPDATE dbo.tbl_usuario SET habilitado=0 WHERE id_usuario=1");
            Check("disabled account cannot login or re-register",da.Find("qa-subject")==null && da.Exists("qa-subject"));
            Sql("UPDATE dbo.tbl_usuario SET habilitado=1; UPDATE dbo.tbl_empresa_acceso SET Estado='Suspendida'");
            Check("suspended subscription cannot login",da.Find("qa-subject")==null);
            Sql("UPDATE dbo.tbl_empresa_acceso SET Estado='Prueba',Fecha_fin_utc=DATEADD(day,-1,SYSUTCDATETIME())");
            Check("expired subscription cannot login",da.Find("qa-subject")==null);
            Sql("UPDATE dbo.tbl_empresa_acceso SET Fecha_fin_utc=NULL; UPDATE dbo.tbl_empresa SET Estado=0");
            Check("inactive company cannot login",da.Find("qa-subject")==null);
            Sql("UPDATE dbo.tbl_empresa SET Estado=1; UPDATE dbo.tbl_sede SET Estado=0");
            Check("inactive site cannot login",da.Find("qa-subject")==null);
            Sql("UPDATE dbo.tbl_sede SET Estado=1");
            Sql("CREATE TRIGGER dbo.qa_fail_link ON dbo.tbl_google_identity AFTER INSERT AS BEGIN IF EXISTS(SELECT 1 FROM inserted WHERE Subject='qa-rollback') THROW 50999,'Synthetic failure',1; END");
            var rolledBack=false;
            try { da.Register("qa-rollback",Registration(),"rollback@example.com"); } catch(SqlException e) when(e.Number==50999){rolledBack=true;}
            Check("failed link rolls back company/site/user/access",rolledBack && Count("tbl_empresa")==1 && Count("tbl_sede")==1 && Count("tbl_usuario")==2 && Count("tbl_empresa_acceso")==1 && !da.Exists("qa-rollback"));
            Console.WriteLine($"{passed} SQL checks passed in disposable database.");
        }
        finally
        {
            Environment.CurrentDirectory = originalDirectory;
            if (created && Regex.IsMatch(database,@"^PsycoGoogleTests_[a-f0-9]{32}$"))
                Sql("ALTER DATABASE ["+database+"] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE ["+database+"]",master:true);
        }
    }
}
