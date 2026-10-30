-- Asociación explícita Google sub -> usuario interno. No vincular por correo.
IF OBJECT_ID('dbo.tbl_google_identity','U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_google_identity
    (
        Subject varchar(255) COLLATE Latin1_General_100_BIN2 NOT NULL PRIMARY KEY,
        IdUsuario int NOT NULL UNIQUE,
        CreatedUtc datetime2(0) NOT NULL CONSTRAINT DF_google_identity_created DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_google_identity_usuario FOREIGN KEY(IdUsuario) REFERENCES dbo.tbl_usuario(id_usuario)
    );
END;
GO
