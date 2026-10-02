CREATE OR ALTER PROCEDURE dbo.SP_LISTAR_SEDES_COMBO
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		Id AS Id_Sede,
		Nombre,
		Centro,
		Estado,
		Id_empresa
	FROM dbo.tbl_sede
	WHERE Estado = 1
	ORDER BY Id;
END;
GO
