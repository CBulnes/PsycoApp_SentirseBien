SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_REGISTRAR_EFECTIVO]
(
	@fecha varchar(10),
	@importe DECIMAL(10,2),
	@usuario varchar(20),
	@id_sede int,
	@comentario varchar(50) = null
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @f_actual datetime = dbo.Get_date();

	INSERT INTO dbo.tbl_efectivo_diario
		(fecha, importe, usuario, comentario, fecha_registro, id_sede)
	VALUES
		(@fecha, @importe, @usuario, @comentario, @f_actual, @id_sede);

	SELECT 'OK' AS rpta;
END
GO
