IF NOT EXISTS (SELECT 1 FROM dbo.tbl_empresa WHERE Id = 1)
BEGIN
	THROW 50001, 'No existe dbo.tbl_empresa con Id = 1; no se puede asignar el catálogo inicial.', 1;
END
GO

IF COL_LENGTH('dbo.Productos', 'Id_empresa') IS NULL
	ALTER TABLE dbo.Productos ADD Id_empresa int NULL;
GO

UPDATE dbo.Productos SET Id_empresa = 1 WHERE Id_empresa IS NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.default_constraints WHERE name = 'DF_Productos_Id_empresa')
	ALTER TABLE dbo.Productos ADD CONSTRAINT DF_Productos_Id_empresa DEFAULT (1) FOR Id_empresa;
GO

ALTER TABLE dbo.Productos ALTER COLUMN Id_empresa int NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Productos_tbl_empresa')
	ALTER TABLE dbo.Productos WITH CHECK ADD CONSTRAINT FK_Productos_tbl_empresa
		FOREIGN KEY (Id_empresa) REFERENCES dbo.tbl_empresa (Id);
GO

CREATE OR ALTER PROCEDURE dbo.SP_LISTAR_PRODUCTOS_COMBO
(
	@Id_empresa int = 1
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @moneda varchar(10) = 'S/.';

	SELECT
		ROW_NUMBER() OVER (ORDER BY p.Nombre) AS orden,
		p.id AS Id,
		p.Nombre,
		CONCAT(p.Nombre, ' - ', @moneda, p.Precio) AS Alias,
		CONCAT(@moneda, p.Precio) AS Precio,
		ISNULL(p.Color, '') AS Color,
		ISNULL(p.NumSesiones, 0) AS NumSesiones
	FROM dbo.Productos p
	WHERE p.Mostrar = 1 AND p.Id_empresa = @Id_empresa
	ORDER BY p.Nombre;
END
GO

CREATE OR ALTER TRIGGER dbo.TR_tbl_cita_validar_empresa_producto
ON dbo.tbl_cita
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS
	(
		SELECT 1
		FROM inserted c
		INNER JOIN dbo.tbl_sede s ON s.Id = c.id_sede
		LEFT JOIN dbo.Productos p ON p.id = c.id_servicio AND p.Id_empresa = s.Id_empresa
		WHERE c.id_servicio IS NOT NULL AND p.id IS NULL
	)
		THROW 50003, 'El producto no pertenece a la empresa de la sede seleccionada.', 1;
END
GO

CREATE OR ALTER PROCEDURE dbo.SP_ADMIN_PRODUCTOS_LISTAR
(
	@Id_empresa int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT id AS Id, Nombre, Precio, Color, ISNULL(EsEvaluacion, 0) AS EsEvaluacion,
		ISNULL(NumSesiones, 0) AS NumSesiones, Siglas, ISNULL(Mostrar, 0) AS Mostrar, Id_empresa
	FROM dbo.Productos
	WHERE Id_empresa = @Id_empresa
	ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE dbo.SP_ADMIN_PRODUCTO_GUARDAR
(
	@Id int,
	@Id_empresa int,
	@Nombre nvarchar(100),
	@Precio decimal(10,2),
	@Color char(7) = NULL,
	@EsEvaluacion bit,
	@NumSesiones int,
	@Siglas varchar(10) = NULL,
	@Mostrar int
)
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 FROM dbo.tbl_empresa WHERE Id = @Id_empresa)
		THROW 50002, 'La empresa indicada no existe.', 1;

	IF @Id = 0
	BEGIN
		INSERT INTO dbo.Productos (Id_empresa, Nombre, Precio, Color, EsEvaluacion, NumSesiones, Siglas, Mostrar)
		VALUES (@Id_empresa, @Nombre, @Precio, @Color, @EsEvaluacion, @NumSesiones, @Siglas, @Mostrar);
		SELECT CONVERT(int, SCOPE_IDENTITY()) AS Id;
		RETURN;
	END

	UPDATE dbo.Productos
	SET Nombre = @Nombre, Precio = @Precio, Color = @Color, EsEvaluacion = @EsEvaluacion,
		NumSesiones = @NumSesiones, Siglas = @Siglas, Mostrar = @Mostrar
	WHERE id = @Id AND Id_empresa = @Id_empresa;
	SELECT CASE WHEN @@ROWCOUNT = 1 THEN @Id ELSE 0 END AS Id;
END
GO

CREATE OR ALTER PROCEDURE dbo.SP_ADMIN_PRODUCTO_ELIMINAR
(
	@Id int,
	@Id_empresa int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.Productos SET Mostrar = 0 WHERE id = @Id AND Id_empresa = @Id_empresa;
	SELECT @@ROWCOUNT AS FilasAfectadas;
END
GO
