CREATE OR ALTER PROCEDURE dbo.SP_GUARDAR_CREDENCIALES_PSICOLOGO
	@IdPsicologo INT,
	@IdSede INT,
	@Email VARCHAR(100),
	@Password VARCHAR(300)
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SET @Email = LTRIM(RTRIM(@Email));

	IF @IdPsicologo <= 0 OR @IdSede <= 0 OR @Email = '' OR @Password = ''
	BEGIN
		RAISERROR('Ingrese un especialista, email y contraseña válidos.', 16, 1);
		RETURN;
	END;

	DECLARE @DocumentoNumero VARCHAR(50);
	DECLARE @Nombre VARCHAR(100);
	DECLARE @Apellido VARCHAR(100);
	DECLARE @TipoDocumento VARCHAR(50);
	DECLARE @Estado INT;
	DECLARE @IdUsuario INT;

	SELECT
		@DocumentoNumero = p.DocumentoNumero,
		@Nombre = p.Nombre,
		@Apellido = p.Apellido,
		@TipoDocumento = td.descripcion,
		@Estado = TRY_CONVERT(INT, p.Estado)
	FROM dbo.tbl_psicologo p
	LEFT JOIN dbo.tbl_tipo_documento td ON td.id = p.DocumentoTipo
	WHERE p.Id = @IdPsicologo;

	IF @DocumentoNumero IS NULL
	BEGIN
		RAISERROR('No se encontró el especialista indicado.', 16, 1);
		RETURN;
	END;

	IF NOT EXISTS (
		SELECT 1
		FROM dbo.tbl_sede
		WHERE Id = @IdSede
	)
	BEGIN
		RAISERROR('La sede del usuario que crea la cuenta no existe.', 16, 1);
		RETURN;
	END;

	IF EXISTS (SELECT 1 FROM dbo.tbl_usuario WHERE email = @Email AND num_documento <> @DocumentoNumero)
	BEGIN
		RAISERROR('El email ya está registrado para otro usuario.', 16, 1);
		RETURN;
	END;

	SELECT @IdUsuario = MIN(id_usuario)
	FROM dbo.tbl_usuario
	WHERE id_tipousuario = 4 AND num_documento = @DocumentoNumero;

	IF (SELECT COUNT(*) FROM dbo.tbl_usuario WHERE id_tipousuario = 4 AND num_documento = @DocumentoNumero) > 1
	BEGIN
		RAISERROR('El especialista tiene más de una cuenta tipo 4 asociada. Revise los usuarios duplicados.', 16, 1);
		RETURN;
	END;

	BEGIN TRANSACTION;

	IF @IdUsuario IS NULL
	BEGIN
		INSERT INTO dbo.tbl_usuario
			(nombres, apellidos, id_tipousuario, password, habilitado, tipo_documento, num_documento, email, test_actual, login, id_sede)
		VALUES
			(@Nombre, @Apellido, 4, dbo.fn_EncriptarPassword(@Password), ISNULL(@Estado, 1), @TipoDocumento, @DocumentoNumero, @Email, 0, '', @IdSede);
	END
	ELSE
	BEGIN
		UPDATE dbo.tbl_usuario
		SET email = @Email,
			password = dbo.fn_EncriptarPassword(@Password),
			habilitado = ISNULL(@Estado, habilitado),
			id_sede = @IdSede
		WHERE id_usuario = @IdUsuario;
	END;

	COMMIT TRANSACTION;
END;
GO
