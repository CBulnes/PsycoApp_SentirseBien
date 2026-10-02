CREATE OR ALTER PROCEDURE dbo.SP_ADMIN_CREAR_USUARIO_EMPRESA
	@Nombres VARCHAR(100),
	@Apellidos VARCHAR(100),
	@Usuario VARCHAR(100),
	@Password VARCHAR(50),
	@IdTipoUsuario INT,
	@IdEmpresa INT,
	@IdSede INT
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SET @Nombres = LTRIM(RTRIM(@Nombres));
	SET @Apellidos = LTRIM(RTRIM(@Apellidos));
	SET @Usuario = LTRIM(RTRIM(@Usuario));
	SET @Password = UPPER(LTRIM(RTRIM(@Password)));

	IF @Nombres = '' OR @Apellidos = '' OR @Usuario = '' OR @Password = ''
		THROW 50021, 'Completa nombres, apellidos, usuario y contraseña.', 1;

	IF LEN(@Password) > 50
		THROW 50027, 'La contraseña no puede superar los 50 caracteres.', 1;

	IF @IdTipoUsuario NOT IN (1, 3)
		THROW 50022, 'Solo se permiten usuarios Administrador (1) o Counter (3).', 1;

	IF @IdEmpresa <= 0 OR @IdSede <= 0
		THROW 50023, 'Selecciona una empresa y una sede válidas.', 1;

	IF @Usuario LIKE '%[^A-Za-zÁÉÍÓÚÜÑáéíóúüñ]%'
		THROW 50024, 'El usuario debe contener solo letras, sin arroba ni espacios.', 1;

	IF NOT EXISTS
	(
		SELECT 1
		FROM dbo.tbl_sede s
		INNER JOIN dbo.tbl_empresa e ON e.Id = s.Id_empresa
		WHERE s.Id = @IdSede
		  AND s.Id_empresa = @IdEmpresa
		  AND s.Estado = 1
		  AND e.Estado = 1
	)
		THROW 50025, 'La sede seleccionada no pertenece a una empresa activa o está inactiva.', 1;

	IF EXISTS (SELECT 1 FROM dbo.tbl_usuario WHERE email = @Usuario)
		THROW 50026, 'El usuario ya está registrado.', 1;

	BEGIN TRY
		BEGIN TRANSACTION;

		INSERT INTO dbo.tbl_usuario
			(nombres, apellidos, id_tipousuario, password, habilitado, tipo_documento,
			 num_documento, email, test_actual, login, id_sede)
		VALUES
			(@Nombres, @Apellidos, @IdTipoUsuario, dbo.fn_EncriptarPassword(@Password), 1,
			 '', '', @Usuario, 0, @Usuario, @IdSede);

		DECLARE @IdUsuario INT = CONVERT(INT, SCOPE_IDENTITY());

		INSERT INTO dbo.tbl_sede_usuario (Id_sede, Id_psicologo, Fecha, Principal)
		VALUES (@IdSede, @IdUsuario, CONVERT(DATE, dbo.Get_date()), 1);

		COMMIT TRANSACTION;
		SELECT @IdUsuario;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH;
END;
GO
