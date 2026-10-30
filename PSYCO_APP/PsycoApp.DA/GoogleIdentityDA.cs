using System;
using System.Data;
using System.Security.Cryptography;
using Microsoft.Data.SqlClient;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;

namespace PsycoApp.DA
{
    public class GoogleIdentityDA
    {
        public (Usuario User, string Sede)? Find(string subject)
        {
            using var cn = new SqlConnector().cadConnection_psyco;
            using var cmd = new SqlCommand(@"
SELECT u.id_usuario, u.nombres, u.apellidos, u.email, u.login, u.id_tipousuario,
       u.id_sede, s.Id_empresa, s.Nombre AS SedeNombre, u.tipo_documento,
       u.num_documento, ISNULL(u.test_actual,0) AS test_actual,
       ISNULL((SELECT MIN(p.Id) FROM dbo.tbl_psicologo p
          WHERE u.id_tipousuario=4 AND p.DocumentoNumero=u.num_documento
          AND EXISTS (SELECT 1 FROM dbo.tbl_sede_usuario su
                      WHERE su.Id_psicologo=p.Id AND su.Id_sede=u.id_sede)),0) AS PsicologoId
FROM dbo.tbl_google_identity g
JOIN dbo.tbl_usuario u ON u.id_usuario=g.IdUsuario
JOIN dbo.tbl_sede s ON s.Id=u.id_sede AND s.Estado=1
JOIN dbo.tbl_empresa e ON e.Id=s.Id_empresa AND e.Estado=1
LEFT JOIN dbo.tbl_empresa_acceso a ON a.Id_empresa=e.Id
WHERE g.Subject=@Subject AND u.habilitado=1 AND u.id_tipousuario IN (1,3,4)
AND (a.Id_empresa IS NULL OR (a.Estado IN ('Prueba','Activa')
     AND (a.Fecha_fin_utc IS NULL OR a.Fecha_fin_utc>=SYSUTCDATETIME())))", cn);
            cmd.Parameters.Add("@Subject", SqlDbType.VarChar, 255).Value = subject;
            cn.Open();
            using var r = cmd.ExecuteReader();
            if (!r.Read()) return null;
            var user = new Usuario
            {
                id_usuario = Convert.ToInt32(r["id_usuario"]),
                nombres = Convert.ToString(r["nombres"]), apellidos = Convert.ToString(r["apellidos"]),
                email = Convert.ToString(r["email"]), login = Convert.ToString(r["login"]),
                id_tipousuario = Convert.ToInt32(r["id_tipousuario"]),
                id_sede = Convert.ToInt32(r["id_sede"]), id_empresa = Convert.ToInt32(r["Id_empresa"]),
                id_psicologo = Convert.ToInt32(r["PsicologoId"]),
                tipo_documento = Convert.ToString(r["tipo_documento"]), num_documento = Convert.ToString(r["num_documento"]),
                test_actual = Convert.ToInt32(r["test_actual"]), validacion = "OK"
            };
            user.tipousuario = user.id_tipousuario == 1 ? "Administrador" : user.id_tipousuario == 3 ? "Counter" : "Psicólogo";
            return (user, Convert.ToString(r["SedeNombre"]));
        }

        public void UpdateEmail(string subject, string email)
        {
            using var cn = new SqlConnector().cadConnection_psyco;
            using var cmd = new SqlCommand(@"UPDATE u SET email=@Email
FROM dbo.tbl_usuario u JOIN dbo.tbl_google_identity g ON g.IdUsuario=u.id_usuario
WHERE g.Subject=@Subject", cn);
            cmd.Parameters.Add("@Subject", SqlDbType.VarChar, 255).Value = subject;
            cmd.Parameters.Add("@Email", SqlDbType.VarChar, 100).Value = email;
            cn.Open();
            cmd.ExecuteNonQuery();
        }

        public bool Exists(string subject)
        {
            using var cn = new SqlConnector().cadConnection_psyco;
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.tbl_google_identity WHERE Subject=@Subject", cn);
            cmd.Parameters.Add("@Subject", SqlDbType.VarChar, 255).Value = subject;
            cn.Open();
            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }

        public void Link(string subject, int userId, string email)
        {
            using var cn = new SqlConnector().cadConnection_psyco;
            cn.Open();
            using var tx = cn.BeginTransaction(IsolationLevel.Serializable);
            using var cmd = new SqlCommand(@"
IF NOT EXISTS(SELECT 1 FROM dbo.tbl_usuario u JOIN dbo.tbl_sede s ON s.Id=u.id_sede
 JOIN dbo.tbl_empresa e ON e.Id=s.Id_empresa
 WHERE u.id_usuario=@Id AND u.habilitado=1 AND u.id_tipousuario IN (1,3,4) AND s.Estado=1 AND e.Estado=1)
 THROW 50201, 'La cuenta no está habilitada para vincular Google.', 1;
IF EXISTS(SELECT 1 FROM dbo.tbl_google_identity WITH (UPDLOCK,HOLDLOCK)
 WHERE (Subject=@Subject AND IdUsuario<>@Id) OR (IdUsuario=@Id AND Subject<>@Subject))
 THROW 50202, 'La identidad o la cuenta ya tiene otra vinculación.', 1;
IF NOT EXISTS(SELECT 1 FROM dbo.tbl_google_identity WITH (UPDLOCK,HOLDLOCK) WHERE Subject=@Subject)
 INSERT INTO dbo.tbl_google_identity(Subject,IdUsuario) VALUES(@Subject,@Id);
UPDATE dbo.tbl_usuario SET email=@Email WHERE id_usuario=@Id;", cn, tx);
            cmd.Parameters.Add("@Subject", SqlDbType.VarChar, 255).Value = subject;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = userId;
            cmd.Parameters.Add("@Email", SqlDbType.VarChar, 100).Value = email;
            cmd.ExecuteNonQuery();
            tx.Commit();
        }

        public void Register(string subject, GoogleRegistration registration, string email)
        {
            using var cn = new SqlConnector().cadConnection_psyco;
            cn.Open();
            using var tx = cn.BeginTransaction(IsolationLevel.Serializable);
            using (var check = new SqlCommand("SELECT COUNT(*) FROM dbo.tbl_google_identity WITH (UPDLOCK,HOLDLOCK) WHERE Subject=@Subject", cn, tx))
            {
                check.Parameters.Add("@Subject", SqlDbType.VarChar, 255).Value = subject;
                if (Convert.ToInt32(check.ExecuteScalar()) != 0)
                    throw new InvalidOperationException("Esta cuenta Google ya está registrada.");
            }
            var letters = new char[30];
            for (var i=0; i<letters.Length; i++) letters[i] = (char)('A' + RandomNumberGenerator.GetInt32(26));
            // Keep company, site, user and external identity in one transaction.
            // A company administrator is not a psychologist and needs no tbl_sede_usuario row.
            using var cmd = new SqlCommand(@"
INSERT INTO dbo.tbl_empresa(Nombre,Estado) VALUES(@Empresa,1);
DECLARE @Company int=CONVERT(int,SCOPE_IDENTITY());
INSERT INTO dbo.tbl_sede(Nombre,Estado,Centro,Id_empresa) VALUES(@Sede,1,@Sede,@Company);
DECLARE @Site int=CONVERT(int,SCOPE_IDENTITY());
INSERT INTO dbo.tbl_usuario(nombres,apellidos,id_tipousuario,password,habilitado,tipo_documento,
 num_documento,email,test_actual,login,id_sede)
VALUES(@Nombres,@Apellidos,1,dbo.fn_EncriptarPassword(@Password),1,'','',@Email,0,@Usuario,@Site);
DECLARE @User int=CONVERT(int,SCOPE_IDENTITY());
INSERT INTO dbo.tbl_empresa_acceso(Id_empresa,Estado,Fecha_inicio_utc,Fecha_fin_utc)
VALUES(@Company,'Prueba',SYSUTCDATETIME(),NULL);
SELECT @User;", cn, tx);
            cmd.Parameters.Add("@Email", SqlDbType.VarChar, 100).Value = email;
            cmd.Parameters.Add("@Empresa", SqlDbType.VarChar, 200).Value = registration.Empresa.Trim();
            cmd.Parameters.Add("@Sede", SqlDbType.VarChar, 200).Value = registration.Sede.Trim();
            cmd.Parameters.Add("@Nombres", SqlDbType.VarChar, 100).Value = registration.Nombres.Trim();
            cmd.Parameters.Add("@Apellidos", SqlDbType.VarChar, 100).Value = registration.Apellidos.Trim();
            cmd.Parameters.Add("@Usuario", SqlDbType.VarChar, 100).Value = "GOOGLE" + new string(letters);
            cmd.Parameters.Add("@Password", SqlDbType.VarChar, 50).Value = Convert.ToBase64String(RandomNumberGenerator.GetBytes(32));
            var id = Convert.ToInt32(cmd.ExecuteScalar());
            using var link = new SqlCommand("INSERT INTO dbo.tbl_google_identity(Subject,IdUsuario) VALUES(@Subject,@Id)", cn, tx);
            link.Parameters.Add("@Subject", SqlDbType.VarChar, 255).Value = subject;
            link.Parameters.Add("@Id", SqlDbType.Int).Value = id;
            link.ExecuteNonQuery();
            tx.Commit();
        }
    }
}
