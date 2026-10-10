IF COL_LENGTH('dbo.tbl_cita', 'url_zoom') IS NULL
	ALTER TABLE dbo.tbl_cita ADD url_zoom NVARCHAR(500) NULL;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_LISTAR_CITAS_USUARIO]
(
	@id_usuario INT,
	@id_paciente INT,
	@id_doctor INT,
	@id_sede INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @fechaIni DATE = DATEADD(MONTH, -4, dbo.Get_date());
	DECLARE @id_tipousuario INT;
	DECLARE @dni_usuario VARCHAR(10);

	SELECT
		@id_tipousuario = u.id_tipousuario,
		@dni_usuario = u.num_documento
	FROM dbo.tbl_usuario u
	WHERE u.id_usuario = @id_usuario;

	IF (@id_tipousuario = 4)
	BEGIN
		SELECT TOP 1 @id_doctor = p.Id
		FROM dbo.tbl_psicologo p
		INNER JOIN dbo.tbl_sede_usuario sd ON sd.Id_psicologo = p.Id
		WHERE sd.Id_sede = @id_sede
		  AND p.DocumentoNumero = @dni_usuario;
	END

	;WITH CitasPaquete AS
	(
		SELECT
			c.id_cita,
			CASE
				WHEN ISNULL(c.orden, 0) > 0 THEN c.orden
				ELSE ISNULL(MAX(NULLIF(c.orden, 0)) OVER (PARTITION BY c.id_paquete), 0)
					+ SUM(CASE WHEN ISNULL(c.orden, 0) <= 0 THEN 1 ELSE 0 END)
						OVER (PARTITION BY c.id_paquete ORDER BY c.id_cita ROWS UNBOUNDED PRECEDING)
			END AS orden_calculado,
			COUNT(*) OVER (PARTITION BY c.id_paquete) AS total_citas_paquete
		FROM dbo.tbl_cita c
		WHERE ISNULL(c.id_paquete, 0) > 0
		  AND c.tipo = 'CITA'
	),
	CitasFiltradas AS
	(
		SELECT
			c.*,
			p.Nombre AS nombre_servicio,
			cp.orden_calculado,
			cp.total_citas_paquete
		FROM dbo.tbl_cita c
		LEFT JOIN dbo.Productos p ON p.id = c.id_servicio
		LEFT JOIN CitasPaquete cp ON cp.id_cita = c.id_cita
		WHERE c.tipo = 'CITA'
		  AND c.id_estado_cita IN (1, 2, 3)
		  AND (@id_paciente = -1 OR c.id_paciente = @id_paciente)
		  AND (@id_doctor = -1 OR c.id_doctor_asignado = @id_doctor)
		  AND (@id_sede = -1 OR c.id_sede = @id_sede)
		  AND c.fecha_cita > @fechaIni
	)
	SELECT
		c.id_cita,
		c.id_estado_cita,
		e.estado_cita AS estado,
		CONVERT(VARCHAR(10), CONVERT(DATE, c.fecha_cita)) AS fecha_cita,
		FORMAT(c.FechaHoraCita, 'hh:mm tt') AS hora_cita,
		c.id_doctor_asignado,
		ps.Nombre AS doctor_asignado,
		c.tipo,
		pa.Id AS id_paciente,
		CONCAT(pa.DocumentoTipo, ' - ', LTRIM(RTRIM(ISNULL(pa.DocumentoNumero, '')))) AS dni_paciente,
		CONCAT(LTRIM(RTRIM(pa.Nombre)), ' ', LTRIM(RTRIM(pa.Apellido))) AS paciente,
		pa.Telefono AS telefono,
		c.Moneda AS moneda,
		c.Monto_pactado AS monto_pactado,
		c.Monto_pagado AS monto_pagado,
		dbo.fn_FixDecimal(c.Monto_pendiente) - dbo.fn_FixDecimal(ISNULL(c.Monto_descuento, 0.00)) AS monto_pendiente,
		c.id_servicio AS id_servicio,
		c.nombre_servicio AS nombre_servicio,
		ISNULL(c.tipo_cita, 'P') AS tipo_cita,
		c.id_sede AS id_sede,
		ISNULL(p.esEvaluacion, CAST(0 AS BIT)) AS esEvaluacion,
		CASE
			WHEN p.Siglas IS NULL THEN ''
			WHEN p.Siglas IN ('CSC', 'I30') THEN CONCAT('(', p.Siglas, ')')
			ELSE CONCAT('(', p.Siglas, ISNULL(c.orden_calculado, c.orden), ')')
		END AS siglas,
		ISNULL(c.feedback, CAST(0 AS BIT)) AS feedback,
		c.comentario AS comentario,
		ISNULL(c.pago_gratis, 0) AS pago_gratis,
		ISNULL(c.id_paquete, 0) AS id_paquete,
		CASE
			WHEN ISNULL(c.id_paquete, 0) = 0 THEN ''
			ELSE CONCAT(
				ISNULL(c.orden_calculado, ISNULL(c.orden, 0)),
				'/',
				CASE
					WHEN ISNULL(c.total_citas_paquete, 0) > ISNULL(p.NumSesiones, 0) THEN c.total_citas_paquete
					WHEN ISNULL(c.orden_calculado, ISNULL(c.orden, 0)) > ISNULL(p.NumSesiones, 0) THEN c.orden_calculado
					ELSE ISNULL(p.NumSesiones, 0)
				END
			)
		END AS orden_cita,
		c.url_zoom AS url_zoom,
		DATEDIFF(YEAR, pa.FechaNacimiento, GETDATE())
			- CASE
				WHEN MONTH(pa.FechaNacimiento) > MONTH(GETDATE())
					OR (MONTH(pa.FechaNacimiento) = MONTH(GETDATE()) AND DAY(pa.FechaNacimiento) > DAY(GETDATE()))
				THEN 1 ELSE 0
			  END AS edad
	FROM CitasFiltradas c
	INNER JOIN dbo.tbl_paciente pa ON pa.Id = c.id_paciente
	INNER JOIN dbo.tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita
	INNER JOIN dbo.Productos p ON p.id = c.id_servicio
	LEFT JOIN dbo.tbl_psicologo ps ON ps.Id = c.id_doctor_asignado
	ORDER BY c.FechaHoraCita ASC;
END
GO
