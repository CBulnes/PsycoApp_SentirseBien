CREATE OR ALTER PROCEDURE dbo.SP_LISTAR_PSICOLOGOS_POR_EMPRESA
	@Pagina INT,
	@TamanoPagina INT,
	@IdEmpresa INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Inicio INT = (@Pagina - 1) * @TamanoPagina;

	;WITH PsicologosEmpresa AS
	(
		SELECT
			p.Id,
			p.Nombre,
			p.Apellido,
			p.FechaNacimiento,
			td.descripcion AS DocumentoTipo,
			p.DocumentoNumero,
			p.Telefono,
			p.Refrigerio,
			p.Especialidad,
			p.Direccion,
			p.Distrito,
			p.Estado,
			ISNULL(ap.IdSedePrincipal, 0) AS IdSedePrincipal,
			ISNULL(as1.IdSedeSecundaria1, 0) AS IdSedeSecundaria1,
			ISNULL(as2.IdSedeSecundaria2, 0) AS IdSedeSecundaria2,
			ISNULL(sedes.Sedes, 'No tiene sedes') AS Sedes,
			ROW_NUMBER() OVER (ORDER BY p.Nombre, p.Id) AS Fila
		FROM dbo.tbl_psicologo p
		INNER JOIN dbo.tbl_tipo_documento td ON td.id = p.DocumentoTipo
		OUTER APPLY
		(
			SELECT STRING_AGG(s2.Centro, '/') WITHIN GROUP
				(ORDER BY CASE WHEN su2.Principal = 1 THEN 0 ELSE 1 END, s2.Id) AS Sedes
			FROM dbo.tbl_sede_usuario su2
			INNER JOIN dbo.tbl_sede s2 ON s2.Id = su2.Id_sede
			WHERE su2.Id_psicologo = p.Id
		) sedes
		OUTER APPLY
		(
			SELECT TOP (1) suP.Id_sede AS IdSedePrincipal
			FROM dbo.tbl_sede_usuario suP
			WHERE suP.Id_psicologo = p.Id AND suP.Principal = 1
			ORDER BY suP.Id_sede
		) ap
		OUTER APPLY
		(
			SELECT TOP (1) suS.Id_sede AS IdSedeSecundaria1
			FROM dbo.tbl_sede_usuario suS
			WHERE suS.Id_psicologo = p.Id
			  AND (suS.Principal = 0 OR (suS.Principal = 1 AND suS.Id_sede <> ISNULL(ap.IdSedePrincipal, 0)))
			ORDER BY suS.Id_sede
		) as1
		OUTER APPLY
		(
			SELECT TOP (1) suT.Id_sede AS IdSedeSecundaria2
			FROM dbo.tbl_sede_usuario suT
			WHERE suT.Id_psicologo = p.Id
			  AND suT.Id_sede NOT IN (ISNULL(ap.IdSedePrincipal, 0), ISNULL(as1.IdSedeSecundaria1, 0))
			ORDER BY suT.Id_sede
		) as2
		WHERE p.Estado = '1'
		  AND EXISTS
		  (
			  SELECT 1
			  FROM dbo.tbl_sede_usuario suEmpresa
			  INNER JOIN dbo.tbl_sede sEmpresa ON sEmpresa.Id = suEmpresa.Id_sede
			  WHERE suEmpresa.Id_psicologo = p.Id
				AND sEmpresa.Id_empresa = @IdEmpresa
		  )
	)
	SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero,
		   Telefono, Refrigerio, Especialidad, Direccion, Distrito, Estado,
		   IdSedePrincipal, IdSedeSecundaria1, IdSedeSecundaria2, Sedes
	FROM PsicologosEmpresa
	WHERE Fila > @Inicio AND Fila <= @Inicio + @TamanoPagina
	ORDER BY Fila;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_LISTAR_PSICOLOGOS_POR_EMPRESA_SEDE
	@Pagina INT,
	@TamanoPagina INT,
	@IdEmpresa INT,
	@IdSede INT
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT 1 FROM dbo.tbl_sede WHERE Id = @IdSede AND Id_empresa = @IdEmpresa AND Estado = 1)
		THROW 50001, 'La sede no pertenece a la empresa indicada o está inactiva.', 1;

	DECLARE @Inicio INT = (@Pagina - 1) * @TamanoPagina;
	;WITH PsicologosSede AS
	(
		SELECT p.Id, p.Nombre, p.Apellido, p.FechaNacimiento, td.descripcion AS DocumentoTipo,
			p.DocumentoNumero, p.Telefono, p.Refrigerio, p.Especialidad, p.Direccion, p.Distrito, p.Estado,
			ISNULL(ap.IdSedePrincipal, 0) AS IdSedePrincipal,
			ISNULL(as1.IdSedeSecundaria1, 0) AS IdSedeSecundaria1,
			ISNULL(as2.IdSedeSecundaria2, 0) AS IdSedeSecundaria2,
			ISNULL(sedes.Sedes, 'No tiene sedes') AS Sedes,
			ROW_NUMBER() OVER (ORDER BY p.Nombre, p.Id) AS Fila
		FROM dbo.tbl_psicologo p
		INNER JOIN dbo.tbl_tipo_documento td ON td.id = p.DocumentoTipo
		OUTER APPLY
		(
			SELECT STRING_AGG(s2.Centro, '/') WITHIN GROUP (ORDER BY CASE WHEN su2.Principal = 1 THEN 0 ELSE 1 END, s2.Id) AS Sedes
			FROM dbo.tbl_sede_usuario su2
			INNER JOIN dbo.tbl_sede s2 ON s2.Id = su2.Id_sede
			WHERE su2.Id_psicologo = p.Id AND s2.Id_empresa = @IdEmpresa
		) sedes
		OUTER APPLY
		(
			SELECT TOP (1) suP.Id_sede AS IdSedePrincipal
			FROM dbo.tbl_sede_usuario suP INNER JOIN dbo.tbl_sede sP ON sP.Id = suP.Id_sede
			WHERE suP.Id_psicologo = p.Id AND suP.Principal = 1 AND sP.Id_empresa = @IdEmpresa
			ORDER BY suP.Id_sede
		) ap
		OUTER APPLY
		(
			SELECT TOP (1) suS.Id_sede AS IdSedeSecundaria1
			FROM dbo.tbl_sede_usuario suS INNER JOIN dbo.tbl_sede sS ON sS.Id = suS.Id_sede
			WHERE suS.Id_psicologo = p.Id AND sS.Id_empresa = @IdEmpresa
				AND (suS.Principal = 0 OR suS.Id_sede <> ISNULL(ap.IdSedePrincipal, 0))
			ORDER BY suS.Id_sede
		) as1
		OUTER APPLY
		(
			SELECT TOP (1) suT.Id_sede AS IdSedeSecundaria2
			FROM dbo.tbl_sede_usuario suT INNER JOIN dbo.tbl_sede sT ON sT.Id = suT.Id_sede
			WHERE suT.Id_psicologo = p.Id AND sT.Id_empresa = @IdEmpresa
				AND suT.Id_sede NOT IN (ISNULL(ap.IdSedePrincipal, 0), ISNULL(as1.IdSedeSecundaria1, 0))
			ORDER BY suT.Id_sede
		) as2
		WHERE p.Estado = '1'
			AND EXISTS
			(
				SELECT 1 FROM dbo.tbl_sede_usuario su
				WHERE su.Id_psicologo = p.Id AND su.Id_sede = @IdSede
			)
	)
	SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, Refrigerio,
		Especialidad, Direccion, Distrito, Estado, IdSedePrincipal, IdSedeSecundaria1, IdSedeSecundaria2, Sedes
	FROM PsicologosSede WHERE Fila > @Inicio AND Fila <= @Inicio + @TamanoPagina ORDER BY Fila;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_BUSCAR_PSICOLOGOS_POR_EMPRESA
	@Nombre NVARCHAR(100),
	@IdEmpresa INT
AS
BEGIN
	SET NOCOUNT ON;

	SET @Nombre = LTRIM(RTRIM(ISNULL(@Nombre, '')));

	SELECT
		p.Id,
		p.Nombre,
		p.Apellido,
		p.FechaNacimiento,
		td.descripcion AS DocumentoTipo,
		p.DocumentoNumero,
		p.Telefono,
		p.Refrigerio,
		p.Especialidad,
		p.Direccion,
		p.Distrito,
		p.Estado,
		ISNULL(ap.IdSedePrincipal, 0) AS IdSedePrincipal,
		ISNULL(as1.IdSedeSecundaria1, 0) AS IdSedeSecundaria1,
		ISNULL(as2.IdSedeSecundaria2, 0) AS IdSedeSecundaria2,
		ISNULL(sedes.Sedes, 'No tiene sedes') AS Sedes
	FROM dbo.tbl_psicologo p
	INNER JOIN dbo.tbl_tipo_documento td ON td.id = p.DocumentoTipo
	OUTER APPLY
	(
		SELECT STRING_AGG(s2.Centro, '/') WITHIN GROUP
			(ORDER BY CASE WHEN su2.Principal = 1 THEN 0 ELSE 1 END, s2.Id) AS Sedes
		FROM dbo.tbl_sede_usuario su2
		INNER JOIN dbo.tbl_sede s2 ON s2.Id = su2.Id_sede
		WHERE su2.Id_psicologo = p.Id
	) sedes
	OUTER APPLY
	(
		SELECT TOP (1) suP.Id_sede AS IdSedePrincipal
		FROM dbo.tbl_sede_usuario suP
		WHERE suP.Id_psicologo = p.Id AND suP.Principal = 1
		ORDER BY suP.Id_sede
	) ap
	OUTER APPLY
	(
		SELECT TOP (1) suS.Id_sede AS IdSedeSecundaria1
		FROM dbo.tbl_sede_usuario suS
		WHERE suS.Id_psicologo = p.Id
		  AND (suS.Principal = 0 OR (suS.Principal = 1 AND suS.Id_sede <> ISNULL(ap.IdSedePrincipal, 0)))
		ORDER BY suS.Id_sede
	) as1
	OUTER APPLY
	(
		SELECT TOP (1) suT.Id_sede AS IdSedeSecundaria2
		FROM dbo.tbl_sede_usuario suT
		WHERE suT.Id_psicologo = p.Id
		  AND suT.Id_sede NOT IN (ISNULL(ap.IdSedePrincipal, 0), ISNULL(as1.IdSedeSecundaria1, 0))
		ORDER BY suT.Id_sede
	) as2
	WHERE p.Estado = '1'
	  AND EXISTS
	  (
		  SELECT 1
		  FROM dbo.tbl_sede_usuario suEmpresa
		  INNER JOIN dbo.tbl_sede sEmpresa ON sEmpresa.Id = suEmpresa.Id_sede
		  WHERE suEmpresa.Id_psicologo = p.Id
			AND sEmpresa.Id_empresa = @IdEmpresa
	  )
	  AND (@Nombre = '' OR p.Nombre LIKE '%' + @Nombre + '%' OR p.Apellido LIKE '%' + @Nombre + '%')
	ORDER BY p.Nombre, p.Id;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_BUSCAR_PSICOLOGOS_POR_EMPRESA_SEDE
	@Nombre NVARCHAR(100),
	@IdEmpresa INT,
	@IdSede INT
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT 1 FROM dbo.tbl_sede WHERE Id = @IdSede AND Id_empresa = @IdEmpresa AND Estado = 1)
		THROW 50002, 'La sede no pertenece a la empresa indicada o está inactiva.', 1;
	SET @Nombre = LTRIM(RTRIM(ISNULL(@Nombre, '')));

	SELECT p.Id, p.Nombre, p.Apellido, p.FechaNacimiento, td.descripcion AS DocumentoTipo,
		p.DocumentoNumero, p.Telefono, p.Refrigerio, p.Especialidad, p.Direccion, p.Distrito, p.Estado,
		ISNULL(ap.IdSedePrincipal, 0) AS IdSedePrincipal,
		ISNULL(as1.IdSedeSecundaria1, 0) AS IdSedeSecundaria1,
		ISNULL(as2.IdSedeSecundaria2, 0) AS IdSedeSecundaria2,
		ISNULL(sedes.Sedes, 'No tiene sedes') AS Sedes
	FROM dbo.tbl_psicologo p
	INNER JOIN dbo.tbl_tipo_documento td ON td.id = p.DocumentoTipo
	OUTER APPLY
	(
		SELECT STRING_AGG(s2.Centro, '/') WITHIN GROUP (ORDER BY CASE WHEN su2.Principal = 1 THEN 0 ELSE 1 END, s2.Id) AS Sedes
		FROM dbo.tbl_sede_usuario su2 INNER JOIN dbo.tbl_sede s2 ON s2.Id = su2.Id_sede
		WHERE su2.Id_psicologo = p.Id AND s2.Id_empresa = @IdEmpresa
	) sedes
	OUTER APPLY
	(
		SELECT TOP (1) suP.Id_sede AS IdSedePrincipal
		FROM dbo.tbl_sede_usuario suP INNER JOIN dbo.tbl_sede sP ON sP.Id = suP.Id_sede
		WHERE suP.Id_psicologo = p.Id AND suP.Principal = 1 AND sP.Id_empresa = @IdEmpresa
		ORDER BY suP.Id_sede
	) ap
	OUTER APPLY
	(
		SELECT TOP (1) suS.Id_sede AS IdSedeSecundaria1
		FROM dbo.tbl_sede_usuario suS INNER JOIN dbo.tbl_sede sS ON sS.Id = suS.Id_sede
		WHERE suS.Id_psicologo = p.Id AND sS.Id_empresa = @IdEmpresa
			AND (suS.Principal = 0 OR suS.Id_sede <> ISNULL(ap.IdSedePrincipal, 0))
		ORDER BY suS.Id_sede
	) as1
	OUTER APPLY
	(
		SELECT TOP (1) suT.Id_sede AS IdSedeSecundaria2
		FROM dbo.tbl_sede_usuario suT INNER JOIN dbo.tbl_sede sT ON sT.Id = suT.Id_sede
		WHERE suT.Id_psicologo = p.Id AND sT.Id_empresa = @IdEmpresa
			AND suT.Id_sede NOT IN (ISNULL(ap.IdSedePrincipal, 0), ISNULL(as1.IdSedeSecundaria1, 0))
		ORDER BY suT.Id_sede
	) as2
	WHERE p.Estado = '1'
		AND EXISTS (SELECT 1 FROM dbo.tbl_sede_usuario su WHERE su.Id_psicologo = p.Id AND su.Id_sede = @IdSede)
		AND (@Nombre = '' OR p.Nombre LIKE '%' + @Nombre + '%' OR p.Apellido LIKE '%' + @Nombre + '%')
	ORDER BY p.Nombre, p.Id;
END;
GO
