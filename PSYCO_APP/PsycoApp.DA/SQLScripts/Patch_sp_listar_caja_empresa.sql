CREATE OR ALTER PROCEDURE [dbo].[sp_ListarCaja]
	@usuarioApertura VARCHAR(MAX),
	@fecha DATE,
	@idEmpresa INT = -1
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @login VARCHAR(50) =
		(SELECT email FROM dbo.tbl_usuario WHERE id_usuario = @usuarioApertura);

	SELECT
		c.id AS turno,
		c.UsuarioApertura,
		u.id_usuario AS IdUsuario,
		CONVERT(date, c.Fecha) AS Fecha,
		c.HoraApertura,
		c.HoraCierre,
		c.Estado
	FROM dbo.tbl_caja c
	LEFT JOIN dbo.tbl_usuario u ON u.email = c.UsuarioApertura
	WHERE (@usuarioApertura = '-1' OR c.UsuarioApertura = @login)
	  AND CONVERT(date, c.Fecha) = @fecha
	  AND (@idEmpresa = -1 OR EXISTS
	  (
		  SELECT 1
		  FROM dbo.tbl_sede s
		  INNER JOIN dbo.tbl_empresa e ON e.Id = s.Id_empresa
		  WHERE s.Id = c.IdSede
			AND s.Id_empresa = @idEmpresa
			AND s.Estado = 1
			AND e.Estado = 1
	  ));
END
GO
