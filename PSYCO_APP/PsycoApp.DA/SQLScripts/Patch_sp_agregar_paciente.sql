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
		FROM dbo.tbl_sede
		WHERE Id = @IdSede
		  AND Estado = 1
	)
		THROW 50010, 'La sede del paciente no existe o está inactiva.', 1;

	IF EXISTS
	(
		SELECT 1
		FROM dbo.tbl_paciente
		WHERE DocumentoNumero = @DocumentoNumero
	)
	BEGIN
		SELECT -1 AS CodigoResultado, 'Documento ya registrado' AS Mensaje;
		RETURN;
	END;

	INSERT INTO dbo.tbl_paciente
	(
		Nombre,
		Apellido,
		FechaNacimiento,
		DocumentoTipo,
		DocumentoNumero,
		Telefono,
		EstadoCivil,
		Sexo,
		Estado,
		id_sede
	)
	VALUES
	(
		@Nombre,
		@Apellido,
		@FechaNacimiento,
		@DocumentoTipo,
		@DocumentoNumero,
		@Telefono,
		@EstadoCivil,
		@Sexo,
		@Estado,
		@IdSede
	);

	SELECT 1 AS CodigoResultado, 'Paciente registrado correctamente' AS Mensaje;
END;
GO
