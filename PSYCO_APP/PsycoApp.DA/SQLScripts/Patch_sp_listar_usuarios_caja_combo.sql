CREATE OR ALTER PROCEDURE dbo.SP_LISTAR_USUARIOS_CAJA_COMBO
	@IdEmpresa INT,
	@IdSede INT
AS
BEGIN
	SET NOCOUNT ON;

	IF @IdEmpresa <= 0 OR @IdSede = 0 OR @IdSede < -1
		THROW 50031, 'La empresa o sede seleccionada no es válida.', 1;

	IF NOT EXISTS
	(
		SELECT 1
		FROM dbo.tbl_empresa e
		WHERE e.Id = @IdEmpresa AND e.Estado = 1
	)
		THROW 50032, 'La empresa no existe o está inactiva.', 1;

	IF @IdSede <> -1 AND NOT EXISTS
	(
		SELECT 1
		FROM dbo.tbl_sede s
		WHERE s.Id = @IdSede AND s.Id_empresa = @IdEmpresa AND s.Estado = 1
	)
		THROW 50033, 'La sede no pertenece a la empresa indicada o está inactiva.', 1;

	SELECT
		u.id_usuario,
		CONCAT(LTRIM(RTRIM(u.nombres)), ' ', LTRIM(RTRIM(u.apellidos))) AS nombres,
		MIN(s.Id) AS id_sede,
		s.Id_empresa AS id_empresa,
		CONVERT(VARCHAR(10), MIN(s.Id)) AS sedes
	FROM dbo.tbl_usuario u
	LEFT JOIN dbo.tbl_psicologo p
		ON u.id_tipousuario = 1
	   AND NULLIF(LTRIM(RTRIM(u.num_documento)), '') IS NOT NULL
	   AND p.DocumentoNumero = u.num_documento
	LEFT JOIN dbo.tbl_sede_usuario su
		ON u.id_tipousuario = 1
	   AND su.Id_psicologo IN (u.id_usuario, p.Id)
	INNER JOIN dbo.tbl_sede s
		ON s.Id = CASE WHEN u.id_tipousuario = 1 THEN su.Id_sede ELSE u.id_sede END
	   AND s.Id_empresa = @IdEmpresa
	   AND s.Estado = 1
	WHERE u.id_tipousuario IN (1, 3)
	  AND u.habilitado = 1
	  AND (@IdSede = -1 OR s.Id = @IdSede)
	GROUP BY u.id_usuario, u.nombres, u.apellidos, s.Id_empresa
	ORDER BY MIN(s.Id), nombres;
END;
GO
