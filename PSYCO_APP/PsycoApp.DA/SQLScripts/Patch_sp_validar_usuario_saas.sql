CREATE OR ALTER PROCEDURE dbo.SP_VALIDAR_USUARIO_V2
(
	@usuario varchar(100),
	@password varchar(50),
	@id_sede int
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @error varchar(150) = '';
	DECLARE @id_usuario int;
	DECLARE @id_tipousuario int;
	DECLARE @id_empresa int = 0;
	DECLARE @id_psicologo int = 0;
	DECLARE @nombres varchar(100) = '';
	DECLARE @apellidos varchar(100) = '';
	DECLARE @tipousuario varchar(50) = '';
	DECLARE @tipo_documento varchar(50) = '';
	DECLARE @num_documento varchar(50) = '';
	DECLARE @test_actual int = 0;
	DECLARE @login varchar(50) = '';
	DECLARE @es_global bit = 0;

	SELECT
		@id_usuario = u.id_usuario,
		@id_tipousuario = u.id_tipousuario,
		@nombres = ISNULL(u.nombres, ''),
		@apellidos = ISNULL(u.apellidos, ''),
		@tipo_documento = ISNULL(u.tipo_documento, ''),
		@num_documento = ISNULL(u.num_documento, ''),
		@test_actual = ISNULL(u.test_actual, 0),
		@login = ISNULL(u.login, ''),
		@es_global = CASE WHEN u.id_tipousuario = 20 THEN 1 ELSE 0 END
	FROM dbo.tbl_usuario u
	WHERE u.email = @usuario;

	IF @id_usuario IS NULL
		SET @error = 'El usuario no se encuentra registrado';
	ELSE IF NOT EXISTS (SELECT 1 FROM dbo.tbl_usuario WHERE id_usuario = @id_usuario AND habilitado = 1)
		SET @error = 'El usuario no se encuentra habilitado';
	ELSE IF ISNULL(dbo.fn_DesencriptarPassword((SELECT password FROM dbo.tbl_usuario WHERE id_usuario = @id_usuario)), '') <> ISNULL(@password, '')
		SET @error = 'Credenciales incorrectas';
	ELSE IF @es_global = 1
		SET @id_sede = 0;
	ELSE IF NOT EXISTS
	(
		SELECT 1
		FROM dbo.tbl_sede s
		INNER JOIN dbo.tbl_empresa e ON e.Id = s.Id_empresa
		WHERE s.Id = @id_sede
		  AND s.Estado = 1
		  AND e.Estado = 1
		  AND
		  (
			  (@id_tipousuario IN (1, 3) AND EXISTS
				  (SELECT 1 FROM dbo.tbl_sede_usuario su WHERE su.Id_sede = s.Id AND su.Id_psicologo = @id_usuario))
			  OR
			  (@id_tipousuario NOT IN (1, 3) AND EXISTS
				  (SELECT 1 FROM dbo.tbl_psicologo p
				   INNER JOIN dbo.tbl_sede_usuario su ON su.Id_psicologo = p.Id
				   WHERE p.DocumentoNumero = @num_documento AND su.Id_sede = s.Id))
		  )
	)
		SET @error = 'La sede no está activa, no pertenece a una empresa activa o no está configurada para el usuario';
	ELSE
		SELECT @id_empresa = s.Id_empresa
		FROM dbo.tbl_sede s
		INNER JOIN dbo.tbl_empresa e ON e.Id = s.Id_empresa
		WHERE s.Id = @id_sede AND s.Estado = 1 AND e.Estado = 1;

	IF @error = '' AND @id_empresa > 0 AND EXISTS (SELECT 1 FROM dbo.tbl_empresa_acceso WHERE Id_empresa = @id_empresa)
	   AND NOT EXISTS
	   (
		   SELECT 1
		   FROM dbo.tbl_empresa_acceso
		   WHERE Id_empresa = @id_empresa
			 AND Estado IN ('Prueba', 'Activa')
			 AND (Fecha_fin_utc IS NULL OR Fecha_fin_utc >= SYSUTCDATETIME())
	   )
		SET @error = 'El acceso de la empresa está suspendido o vencido. Contacta con el administrador.';

	IF @error = ''
	BEGIN
		SELECT @tipousuario = ISNULL(tu.tipousuario, ''), @id_psicologo = ISNULL(p.Id, 0)
		FROM dbo.tbl_usuario u
		INNER JOIN dbo.tbl_tipousuario tu ON tu.id_tipousuario = u.id_tipousuario
		LEFT JOIN dbo.tbl_psicologo p ON p.DocumentoNumero = u.num_documento
		WHERE u.id_usuario = @id_usuario;

		SELECT @id_usuario AS id_usuario, @nombres AS nombres, @apellidos AS apellidos,
			@id_tipousuario AS id_tipousuario, @id_psicologo AS id_psicologo, @tipousuario AS tipousuario,
			@tipo_documento AS tipo_documento, @num_documento AS num_documento, @test_actual AS test_actual,
			@login AS login, @id_sede AS id_sede, @id_empresa AS id_empresa, 'OK' AS validacion;
	END
	ELSE
	BEGIN
		SELECT 0 AS id_usuario, '' AS nombres, '' AS apellidos, 0 AS id_tipousuario, 0 AS id_psicologo,
			'' AS tipousuario, '' AS tipo_documento, '' AS num_documento, 0 AS test_actual, '' AS login,
			0 AS id_sede, 0 AS id_empresa, @error AS validacion;
	END
END;
GO
