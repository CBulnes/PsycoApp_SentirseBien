CREATE OR ALTER PROCEDURE dbo.sp_obtener_paciente
	@Id INT,
	@IdSede INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero,
		Telefono, EstadoCivil, ISNULL(Sexo, 0) AS Sexo, Estado, ISNULL(id_sede, 0) AS id_sede
	FROM dbo.tbl_paciente
	WHERE Id = @Id
	  AND (@IdSede = 0 OR id_sede = @IdSede);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_actualizar_paciente
	@Id INT,
	@Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
	@FechaNacimiento DATE,
	@DocumentoTipo NVARCHAR(50),
	@DocumentoNumero NVARCHAR(50),
	@Telefono NVARCHAR(50),
	@EstadoCivil NVARCHAR(50),
	@Sexo NVARCHAR(10),
	@Estado NVARCHAR(20),
	@IdSede INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE dbo.tbl_paciente
	SET Nombre = @Nombre,
		Apellido = @Apellido,
		FechaNacimiento = @FechaNacimiento,
		DocumentoTipo = @DocumentoTipo,
		DocumentoNumero = @DocumentoNumero,
		Telefono = @Telefono,
		EstadoCivil = @EstadoCivil,
		Sexo = @Sexo,
		Estado = @Estado
	WHERE Id = @Id
	  AND (@IdSede = 0 OR id_sede = @IdSede);

	IF @@ROWCOUNT = 0
		THROW 50041, 'El paciente no existe o no pertenece a la sede autorizada.', 1;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_eliminar_paciente
	@Id INT,
	@IdSede INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE dbo.tbl_paciente
	SET Estado = CASE WHEN Estado = '1' THEN '0' ELSE '1' END
	WHERE Id = @Id
	  AND (@IdSede = 0 OR id_sede = @IdSede);

	IF @@ROWCOUNT = 0
		THROW 50042, 'El paciente no existe o no pertenece a la sede autorizada.', 1;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_LISTAR_PACIENTES_COMBO
	@IdSede INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Id AS id_paciente,
		CONCAT(LTRIM(RTRIM(Nombre)), ' ', LTRIM(RTRIM(Apellido))) AS nombres
	FROM dbo.tbl_paciente
	WHERE Estado = 1
	  AND (@IdSede = 0 OR id_sede = @IdSede)
	ORDER BY Nombre, Apellido;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_agregar_paciente
	@Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
	@FechaNacimiento DATE,
	@DocumentoTipo NVARCHAR(50),
	@DocumentoNumero NVARCHAR(50),
	@Telefono NVARCHAR(50),
	@EstadoCivil NVARCHAR(50),
	@Sexo NVARCHAR(10),
	@Estado NVARCHAR(20),
	@IdSede INT
AS
BEGIN
	SET NOCOUNT ON;

	IF @IdSede IS NULL OR NOT EXISTS
	(
		SELECT 1
		FROM dbo.tbl_sede s
		INNER JOIN dbo.tbl_empresa e ON e.Id = s.Id_empresa
		WHERE s.Id = @IdSede
		  AND s.Estado = 1
		  AND e.Estado = 1
	)
		THROW 50043, 'La sede no existe o su empresa está inactiva.', 1;

	IF EXISTS (SELECT 1 FROM dbo.tbl_paciente WHERE DocumentoNumero = @DocumentoNumero)
	BEGIN
		SELECT -1 AS CodigoResultado, 'Documento ya registrado' AS Mensaje;
		RETURN;
	END;

	INSERT INTO dbo.tbl_paciente
		(Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono,
		 EstadoCivil, Sexo, Estado, id_sede)
	VALUES
		(@Nombre, @Apellido, @FechaNacimiento, @DocumentoTipo, @DocumentoNumero,
		 @Telefono, @EstadoCivil, @Sexo, @Estado, @IdSede);

	SELECT 1 AS CodigoResultado, 'Paciente registrado correctamente' AS Mensaje;
END;
GO
