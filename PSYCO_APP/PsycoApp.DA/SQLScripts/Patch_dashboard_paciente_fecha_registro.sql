/*
   Fecha de alta para las métricas del dashboard.
   Los pacientes existentes permanecen con FechaRegistro NULL porque no se
   dispone de una fecha histórica fiable. Los nuevos registros reciben la
   fecha del servidor SQL al insertarse.
*/
IF COL_LENGTH('dbo.tbl_paciente', 'FechaRegistro') IS NULL
BEGIN
	ALTER TABLE dbo.tbl_paciente
		ADD FechaRegistro DATETIME NULL;
END;
GO

IF NOT EXISTS
(
	SELECT 1
	FROM sys.default_constraints dc
	INNER JOIN sys.columns c
		ON c.object_id = dc.parent_object_id
	   AND c.column_id = dc.parent_column_id
	WHERE dc.parent_object_id = OBJECT_ID('dbo.tbl_paciente')
	  AND c.name = 'FechaRegistro'
)
BEGIN
	ALTER TABLE dbo.tbl_paciente
		ADD CONSTRAINT DF_tbl_paciente_FechaRegistro
		DEFAULT (GETDATE()) FOR FechaRegistro;
END;
GO