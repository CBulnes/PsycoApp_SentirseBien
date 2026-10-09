IF OBJECT_ID('dbo.tbl_empresa_acceso', 'U') IS NULL
BEGIN
	CREATE TABLE dbo.tbl_empresa_acceso
	(
		Id_empresa int NOT NULL PRIMARY KEY,
		Estado varchar(20) NOT NULL,
		Fecha_inicio_utc datetime2(0) NOT NULL,
		Fecha_fin_utc datetime2(0) NULL,
		CONSTRAINT FK_tbl_empresa_acceso_tbl_empresa FOREIGN KEY (Id_empresa) REFERENCES dbo.tbl_empresa(Id),
		CONSTRAINT CK_tbl_empresa_acceso_Estado CHECK (Estado IN ('Prueba', 'Activa', 'Suspendida'))
	);
END;
GO
CREATE OR ALTER PROCEDURE dbo.SP_SAAS_REGISTRAR_EMPRESA_PRUEBA
	@Empresa varchar(200),
	@Sede varchar(200),
	@Nombres varchar(100),
	@Apellidos varchar(100),
	@Usuario varchar(100),
	@Password varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SET @Empresa = LTRIM(RTRIM(@Empresa));
	SET @Sede = LTRIM(RTRIM(@Sede));
	SET @Nombres = LTRIM(RTRIM(@Nombres));
	SET @Apellidos = LTRIM(RTRIM(@Apellidos));
	SET @Usuario = UPPER(LTRIM(RTRIM(@Usuario)));
	SET @Password = UPPER(LTRIM(RTRIM(@Password)));

	IF @Empresa = '' OR @Sede = '' OR @Nombres = '' OR @Apellidos = '' OR @Usuario = '' OR @Password = ''
		THROW 50101, 'Completa los datos de empresa, sede y administrador.', 1;

	IF LEN(@Empresa) > 200 OR LEN(@Sede) > 200 OR LEN(@Nombres) > 100 OR LEN(@Apellidos) > 100 OR LEN(@Usuario) > 50 OR LEN(@Password) > 50
		THROW 50102, 'Uno o más campos superan el máximo permitido.', 1;

	IF @Usuario LIKE '%[^A-ZÁÉÍÓÚÜÑ]%'
		THROW 50103, 'El usuario debe contener solo letras, sin espacios.', 1;

	BEGIN TRY
		BEGIN TRANSACTION;

		IF EXISTS (SELECT 1 FROM dbo.tbl_usuario WITH (TABLOCKX, HOLDLOCK) WHERE email = @Usuario)
			THROW 50104, 'El nombre de usuario ya está registrado.', 1;

		INSERT INTO dbo.tbl_empresa (Nombre, Estado) VALUES (@Empresa, 1);
		DECLARE @IdEmpresa int = CONVERT(int, SCOPE_IDENTITY());

		INSERT INTO dbo.tbl_sede (Nombre, Estado, Centro, Id_empresa) VALUES (@Sede, 1, @Sede, @IdEmpresa);
		DECLARE @IdSede int = CONVERT(int, SCOPE_IDENTITY());

		INSERT INTO dbo.tbl_usuario
			(nombres, apellidos, id_tipousuario, password, habilitado, tipo_documento, num_documento, email, test_actual, login, id_sede)
		VALUES
			(@Nombres, @Apellidos, 1, dbo.fn_EncriptarPassword(@Password), 1, '', '', @Usuario, 0, @Usuario, @IdSede);
		DECLARE @IdUsuario int = CONVERT(int, SCOPE_IDENTITY());

		INSERT INTO dbo.tbl_sede_usuario (Id_sede, Id_psicologo, Fecha, Principal)
		VALUES (@IdSede, @IdUsuario, CONVERT(date, dbo.Get_date()), 1);

		INSERT INTO dbo.tbl_empresa_acceso (Id_empresa, Estado, Fecha_inicio_utc, Fecha_fin_utc)
		VALUES (@IdEmpresa, 'Prueba', SYSUTCDATETIME(), NULL);

		COMMIT TRANSACTION;
		SELECT @IdEmpresa AS IdEmpresa, @IdSede AS IdSede, @IdUsuario AS IdUsuario;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
		THROW;
	END CATCH;
END;
GO
CREATE OR ALTER PROCEDURE dbo.SP_SAAS_VALIDAR_ACCESO_EMPRESA
	@IdEmpresa int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT CAST(CASE
		WHEN a.Id_empresa IS NULL THEN 1
		WHEN a.Estado IN ('Prueba', 'Activa') AND (a.Fecha_fin_utc IS NULL OR a.Fecha_fin_utc >= SYSUTCDATETIME()) THEN 1
		ELSE 0
	END AS bit) AS AccesoPermitido,
		ISNULL(a.Estado, 'Legacy') AS Estado
	FROM (SELECT @IdEmpresa AS IdEmpresa) e
	LEFT JOIN dbo.tbl_empresa_acceso a ON a.Id_empresa = e.IdEmpresa;
END;
GO
