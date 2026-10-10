SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_VALIDAR_USUARIO_V2]
(
	@usuario VARCHAR(100),
	@password VARCHAR(50),
	@id_sede INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @error VARCHAR(100) = '';
	DECLARE @es_global BIT;
	DECLARE @es_counter INT;
	DECLARE @id_empresa INT = 0;

	SET @es_global = CASE WHEN EXISTS
	(
		SELECT 1 FROM dbo.tbl_usuario WHERE email = @usuario AND id_tipousuario = 20
	) THEN 1 ELSE 0 END;

	SET @es_counter =
	(
		SELECT COUNT(1)
		FROM dbo.tbl_usuario
		WHERE email = @usuario AND id_tipousuario IN (1, 3)
	);

	IF (@es_global = 1)
	BEGIN
		SET @id_sede = 0;
	END
	ELSE
	BEGIN
		SELECT @id_empresa = ISNULL(s.Id_empresa, 0)
		FROM dbo.tbl_sede s
		WHERE s.Id = @id_sede AND s.Estado = 1;

		IF (@id_empresa = 0)
		BEGIN
			SET @error = 'La empresa o sede seleccionada no está activa';
		END
		ELSE IF (@es_counter = 1 AND NOT EXISTS
		(
			SELECT 1
			FROM dbo.tbl_usuario u
			INNER JOIN dbo.tbl_sede_usuario su ON su.Id_psicologo = u.id_usuario
			WHERE u.email = @usuario
			  AND u.habilitado = 1
			  AND su.Id_sede = @id_sede
		))
		BEGIN
			SET @error = 'El centro seleccionado no está configurado para su usuario';
		END
		ELSE IF (@es_counter <> 1 AND NOT EXISTS
		(
			SELECT 1
			FROM dbo.tbl_usuario u
			INNER JOIN dbo.tbl_psicologo p ON p.DocumentoNumero = u.num_documento
			INNER JOIN dbo.tbl_sede_usuario su ON su.Id_psicologo = p.Id
			WHERE u.email = @usuario
			  AND u.habilitado = 1
			  AND su.Id_sede = @id_sede
		))
		BEGIN
			SET @error = 'El centro seleccionado no está configurado para su usuario';
		END
	END

	IF (@error = '' AND NOT EXISTS
	(
		SELECT 1
		FROM dbo.tbl_usuario u
		WHERE u.email = @usuario
		  AND u.habilitado = 1
		  AND dbo.fn_DesencriptarPassword(u.password) = @password
	))
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.tbl_usuario WHERE email = @usuario)
			SET @error = 'El usuario no se encuentra registrado';
		ELSE IF NOT EXISTS
		(
			SELECT 1
			FROM dbo.tbl_usuario u
			WHERE u.email = @usuario
			  AND u.habilitado = 1
			  AND dbo.fn_DesencriptarPassword(u.password) = @password
		)
			SET @error = 'Credenciales incorrectas';
		ELSE
			SET @error = 'El usuario no se encuentra habilitado';
	END

	IF (@error = '')
	BEGIN
		SELECT
			u.id_usuario,
			u.nombres,
			u.apellidos,
			u.id_tipousuario,
			ISNULL(p.Id, 0) AS id_psicologo,
			tu.tipousuario,
			u.tipo_documento,
			u.num_documento,
			u.test_actual,
			u.login,
			CASE WHEN @es_global = 1 THEN 0 ELSE @id_sede END AS id_sede,
			CASE WHEN @es_global = 1 THEN 0 ELSE @id_empresa END AS id_empresa,
			'OK' AS validacion
		FROM dbo.tbl_usuario u
		INNER JOIN dbo.tbl_tipousuario tu ON tu.id_tipousuario = u.id_tipousuario
		LEFT JOIN dbo.tbl_psicologo p ON p.DocumentoNumero = u.num_documento
		WHERE u.email = @usuario
		  AND u.habilitado = 1
		  AND dbo.fn_DesencriptarPassword(u.password) = @password;
	END
	ELSE
	BEGIN
		SELECT
			0 AS id_usuario,
			'' AS nombres,
			'' AS apellidos,
			0 AS id_tipousuario,
			0 AS id_psicologo,
			'' AS tipousuario,
			'' AS tipo_documento,
			'' AS num_documento,
			0 AS test_actual,
			'' AS login,
			0 AS id_sede,
			0 AS id_empresa,
			@error AS validacion;
	END
END
GO
