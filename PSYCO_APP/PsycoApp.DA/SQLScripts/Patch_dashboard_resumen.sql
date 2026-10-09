/*
	Fuentes agregadas para el inicio por sede y rol.
	Prerrequisito: aplicar Patch_dashboard_paciente_fecha_registro.sql y
	los parches multi-sede que incorporan tbl_paciente.id_sede.
*/
CREATE OR ALTER PROCEDURE dbo.SP_DASHBOARD_RESUMEN
	@InicioSemana DATE,
	@FinSemana DATE,
	@AhoraLocalSolicitado DATETIME,
	@IdSede INT,
	@IdUsuario INT,
	@IdDoctor INT,
	@TipoUsuario INT,
	@Login VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @IdSede <= 0 OR @IdUsuario <= 0 OR @TipoUsuario NOT IN (1, 3, 4)
		THROW 50100, 'El contexto de sede, usuario o rol del dashboard no es válido.', 1;

	/* dbo.Get_date() is the application's Peru-local clock; server GETDATE()/DateTime.Today may be UTC. */
	DECLARE @AhoraLocal DATETIME = COALESCE(@AhoraLocalSolicitado, dbo.Get_date());
	DECLARE @Hoy DATE = CONVERT(DATE, @AhoraLocal);
	SET @InicioSemana = DATEADD(DAY, -(DATEDIFF(DAY, CONVERT(DATE, '19000101'), @Hoy) % 7), @Hoy);
	SET @FinSemana = DATEADD(DAY, 6, @InicioSemana);

	DECLARE @InicioMes DATE = DATEFROMPARTS(YEAR(@Hoy), MONTH(@Hoy), 1);
	DECLARE @DiasSemana TABLE (Fecha DATE NOT NULL PRIMARY KEY);
	DECLARE @FechaIteracion DATE = @InicioSemana;
	WHILE @FechaIteracion <= @FinSemana
	BEGIN
		INSERT INTO @DiasSemana (Fecha) VALUES (@FechaIteracion);
		SET @FechaIteracion = DATEADD(DAY, 1, @FechaIteracion);
	END;
	DECLARE @EsEspecialista BIT = CASE WHEN @TipoUsuario = 4 THEN 1 ELSE 0 END;
	DECLARE @EsCounter BIT = CASE WHEN @TipoUsuario = 3 THEN 1 ELSE 0 END;
	DECLARE @IdDoctorEfectivo INT = @IdDoctor;

	IF @EsEspecialista = 1
	BEGIN
		SELECT @IdDoctorEfectivo = ps.Id
		FROM dbo.tbl_usuario u
		INNER JOIN dbo.tbl_psicologo ps ON ps.DocumentoNumero = u.num_documento
		WHERE u.id_usuario = @IdUsuario;

		IF ISNULL(@IdDoctorEfectivo, 0) <= 0
			THROW 50101, 'No se encontró el especialista asociado al usuario autenticado.', 1;
	END;

	/* Resumen del centro/rol. Citas de hoy se basan en fecha de agenda. */
	SELECT
		@Hoy AS FechaActual,
		(SELECT COUNT(1) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.tipo = 'CITA' AND c.fecha_cita = @Hoy AND c.id_estado_cita IN (1, 2, 3) AND (@EsEspecialista = 0 OR c.id_doctor_asignado = @IdDoctorEfectivo)) AS CitasHoy,
		(SELECT COUNT(1) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.tipo = 'CITA' AND c.fecha_cita = @Hoy AND c.id_estado_cita = 1 AND (@EsEspecialista = 0 OR c.id_doctor_asignado = @IdDoctorEfectivo)) AS CitasCitadasHoy,
		(SELECT COUNT(1) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.tipo = 'CITA' AND c.fecha_cita = @Hoy AND c.id_estado_cita = 2 AND (@EsEspecialista = 0 OR c.id_doctor_asignado = @IdDoctorEfectivo)) AS CitasConfirmadasHoy,
		(SELECT COUNT(1) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.tipo = 'CITA' AND c.fecha_cita = @Hoy AND c.id_estado_cita = 3 AND (@EsEspecialista = 0 OR c.id_doctor_asignado = @IdDoctorEfectivo)) AS CitasAtendidasHoy,
		(SELECT COUNT(1) FROM dbo.tbl_paciente p WHERE p.id_sede = @IdSede) AS PacientesTotal,
		(SELECT COUNT(1) FROM dbo.tbl_paciente p WHERE p.id_sede = @IdSede AND p.FechaRegistro >= @InicioMes AND p.FechaRegistro < DATEADD(DAY, 1, @Hoy)) AS PacientesMes,
		(SELECT COUNT(DISTINCT su.Id_psicologo)
		 FROM dbo.tbl_sede_usuario su INNER JOIN dbo.tbl_psicologo ps ON ps.Id = su.Id_psicologo
		 WHERE su.Id_sede = @IdSede AND ps.Estado = '1') AS EspecialistasDisponibles,
		(SELECT COUNT(DISTINCT su.Id_psicologo)
		 FROM dbo.tbl_sede_usuario su INNER JOIN dbo.tbl_psicologo ps ON ps.Id = su.Id_psicologo
		 WHERE su.Id_sede = @IdSede) AS EspecialistasTotal,
		(SELECT ISNULL(SUM(pg.importe), 0)
		 FROM dbo.tbl_pago pg
		 INNER JOIN dbo.tbl_cita pc ON pc.id_cita = pg.id_cita
		 LEFT JOIN dbo.tbl_caja cajaPago ON cajaPago.Id = pg.id_caja
		 WHERE pc.id_sede = @IdSede
		   AND (
				(cajaPago.Id IS NOT NULL AND (cajaPago.Fecha = @Hoy OR UPPER(LTRIM(RTRIM(cajaPago.Estado))) = 'ABIERTA'))
				OR (cajaPago.Id IS NULL AND pg.fecha_registro >= @Hoy AND pg.fecha_registro < DATEADD(DAY, 1, @Hoy))
			)
		   AND (
				@EsCounter = 0
				OR UPPER(LTRIM(RTRIM(ISNULL(pg.usuario_registro, '')))) = UPPER(LTRIM(RTRIM(ISNULL(@Login, ''))))
				OR UPPER(LTRIM(RTRIM(ISNULL(cajaPago.UsuarioApertura, '')))) = UPPER(LTRIM(RTRIM(ISNULL(@Login, ''))))
		   )) AS IngresosHoy,
		CONVERT(BIT, CASE WHEN EXISTS
		(
			SELECT 1
			FROM dbo.tbl_caja caja
			WHERE caja.IdSede = @IdSede
			  AND UPPER(LTRIM(RTRIM(caja.Estado))) = 'ABIERTA'
			  AND (@TipoUsuario <> 3 OR (NULLIF(LTRIM(RTRIM(ISNULL(@Login, ''))), '') IS NOT NULL AND UPPER(LTRIM(RTRIM(ISNULL(caja.UsuarioApertura, '')))) = UPPER(LTRIM(RTRIM(@Login)))))
		) THEN 1 ELSE 0 END) AS CajaAbierta,
		CASE WHEN EXISTS
		(
			SELECT 1
			FROM dbo.tbl_caja caja
			WHERE caja.IdSede = @IdSede
			  AND UPPER(LTRIM(RTRIM(caja.Estado))) = 'ABIERTA'
			  AND (@TipoUsuario <> 3 OR (NULLIF(LTRIM(RTRIM(ISNULL(@Login, ''))), '') IS NOT NULL AND UPPER(LTRIM(RTRIM(ISNULL(caja.UsuarioApertura, '')))) = UPPER(LTRIM(RTRIM(@Login)))))
		) THEN 'Abierta' ELSE 'Cerrada' END AS EstadoCaja
	;

	/* Conteos de pacientes del especialista en toda su agenda de la sede. */
	SELECT
		CASE WHEN @EsEspecialista = 1 THEN (SELECT COUNT(DISTINCT c.id_paciente) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.id_doctor_asignado = @IdDoctorEfectivo AND c.id_estado_cita = 3 AND c.tipo = 'CITA') ELSE 0 END AS PacientesAtendidos,
		CASE WHEN @EsEspecialista = 1 THEN (SELECT COUNT(DISTINCT c.id_paciente) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.id_doctor_asignado = @IdDoctorEfectivo AND c.id_estado_cita = 1 AND c.tipo = 'CITA') ELSE 0 END AS PacientesCitados,
		CASE WHEN @EsEspecialista = 1 THEN (SELECT COUNT(DISTINCT c.id_paciente) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.id_doctor_asignado = @IdDoctorEfectivo AND c.id_estado_cita = 2 AND c.tipo = 'CITA') ELSE 0 END AS PacientesConfirmados,
		CASE WHEN @EsEspecialista = 1 THEN (SELECT COUNT(DISTINCT c.id_paciente) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.id_doctor_asignado = @IdDoctorEfectivo AND c.id_estado_cita IN (1, 2) AND c.tipo = 'CITA') ELSE 0 END AS PacientesPorAtender;

	/* Recaudación de hoy por forma de pago. Admin ve toda la sede; counter, su usuario. */
	SELECT CONCAT(fp.descripcion, CASE WHEN NULLIF(LTRIM(RTRIM(dt.descripcion)), '') IS NULL THEN '' ELSE CONCAT(' - ', LTRIM(RTRIM(dt.descripcion))) END) AS FormaPago,
		SUM(pg.importe) AS Importe
	FROM dbo.tbl_pago pg
	INNER JOIN dbo.tbl_cita c ON c.id_cita = pg.id_cita
	INNER JOIN dbo.tbl_forma_pago fp ON fp.id = pg.id_forma_pago
	LEFT JOIN dbo.tbl_detalle_transferencia dt ON dt.id = pg.id_detalle_transferencia
	LEFT JOIN dbo.tbl_caja cajaPago ON cajaPago.Id = pg.id_caja
	WHERE c.id_sede = @IdSede
	  AND (
			(cajaPago.Id IS NOT NULL AND (cajaPago.Fecha = @Hoy OR UPPER(LTRIM(RTRIM(cajaPago.Estado))) = 'ABIERTA'))
			OR (cajaPago.Id IS NULL AND pg.fecha_registro >= @Hoy AND pg.fecha_registro < DATEADD(DAY, 1, @Hoy))
	  )
	  AND (
			@EsCounter = 0
			OR UPPER(LTRIM(RTRIM(ISNULL(pg.usuario_registro, '')))) = UPPER(LTRIM(RTRIM(ISNULL(@Login, ''))))
			OR UPPER(LTRIM(RTRIM(ISNULL(cajaPago.UsuarioApertura, '')))) = UPPER(LTRIM(RTRIM(ISNULL(@Login, ''))))
	  )
	GROUP BY fp.descripcion, dt.descripcion
	ORDER BY FormaPago;

	/* Próximas citas: por sede para admin/counter; solo del especialista para tipo 4. */
	SELECT TOP (5)
		c.id_cita AS Id,
		CAST(c.fecha_cita AS DATETIME) AS Fecha,
		c.hora_cita AS Hora,
		CONCAT(LTRIM(RTRIM(pa.Nombre)), ' ', LTRIM(RTRIM(pa.Apellido))) AS Paciente,
		CONCAT(LTRIM(RTRIM(ps.Nombre)), ' ', LTRIM(RTRIM(ps.Apellido))) AS Especialista,
		ISNULL(pr.Nombre, '') AS Servicio,
		ISNULL(ec.estado_cita, '') AS Estado
	FROM dbo.tbl_cita c
	INNER JOIN dbo.tbl_paciente pa ON pa.Id = c.id_paciente
	INNER JOIN dbo.tbl_psicologo ps ON ps.Id = c.id_doctor_asignado
	LEFT JOIN dbo.Productos pr ON pr.id = c.id_servicio
	LEFT JOIN dbo.tbl_estados_cita ec ON ec.id_estado_cita = c.id_estado_cita
	WHERE c.id_sede = @IdSede
	  AND c.tipo = 'CITA'
	  AND c.id_estado_cita IN (1, 2)
	  AND (c.fecha_cita > @Hoy OR (c.fecha_cita = @Hoy AND c.hora_cita >= CONVERT(TIME, @AhoraLocal)))
		AND (@EsEspecialista = 0 OR c.id_doctor_asignado = @IdDoctorEfectivo)
	ORDER BY c.fecha_cita, c.hora_cita;

	/* Siete días, incluyendo hoy; citas por fecha de creación, pagos por fecha de pago. */
	SELECT d.Fecha,
		CASE WHEN @EsEspecialista = 1
			  THEN (SELECT COUNT(1) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.id_doctor_asignado = @IdDoctorEfectivo AND c.fecha_registra >= d.Fecha AND c.fecha_registra < DATEADD(DAY, 1, d.Fecha) AND c.tipo = 'CITA')
			 ELSE (SELECT COUNT(1) FROM dbo.tbl_cita c WHERE c.id_sede = @IdSede AND c.fecha_registra >= d.Fecha AND c.fecha_registra < DATEADD(DAY, 1, d.Fecha) AND c.tipo = 'CITA')
		END AS Citas,
		CASE WHEN @EsEspecialista = 1 THEN 0
			 ELSE (SELECT COUNT(1) FROM dbo.tbl_paciente p WHERE p.id_sede = @IdSede AND p.FechaRegistro >= d.Fecha AND p.FechaRegistro < DATEADD(DAY, 1, d.Fecha))
		END AS Pacientes,
		CASE WHEN @EsEspecialista = 1 THEN 0
			 ELSE (SELECT ISNULL(SUM(pg.importe), 0) FROM dbo.tbl_pago pg INNER JOIN dbo.tbl_cita c ON c.id_cita = pg.id_cita WHERE c.id_sede = @IdSede AND pg.fecha_registro >= d.Fecha AND pg.fecha_registro < DATEADD(DAY, 1, d.Fecha) AND (@EsCounter = 0 OR pg.usuario_registro = @Login))
		END AS Ingresos
	FROM @DiasSemana d;

	/* Eventos recientes disponibles; no se incluyen ediciones de especialistas. */
	IF @EsEspecialista = 0
	BEGIN
		SELECT TOP (5) recientes.Tipo, recientes.Titulo, recientes.Descripcion, recientes.Fecha
		FROM
		(
			SELECT 'Cita' AS Tipo,
				CASE WHEN hc.evento LIKE '%ATENDID%' THEN 'Cita atendida' ELSE 'Nueva cita agendada' END AS Titulo,
				CONCAT(LTRIM(RTRIM(pa.Nombre)), ' ', LTRIM(RTRIM(pa.Apellido))) AS Descripcion,
				hc.fecha_registra AS Fecha
			FROM dbo.tbl_historial_cita hc
			INNER JOIN dbo.tbl_cita c ON c.id_cita = hc.id_cita
			INNER JOIN dbo.tbl_paciente pa ON pa.Id = c.id_paciente
			WHERE c.id_sede = @IdSede
			  AND (hc.evento LIKE '%CITAD%' OR hc.evento LIKE '%ATENDID%' OR hc.evento LIKE '%CONFIRMAD%')
			  AND hc.fecha_registra IS NOT NULL
			UNION ALL
			SELECT 'Paciente', 'Nuevo paciente registrado', CONCAT(LTRIM(RTRIM(p.Nombre)), ' ', LTRIM(RTRIM(p.Apellido))), p.FechaRegistro
			FROM dbo.tbl_paciente p
			WHERE p.id_sede = @IdSede AND p.FechaRegistro IS NOT NULL
			UNION ALL
			SELECT 'Pago', 'Pago registrado', CONCAT(ISNULL(fp.descripcion, 'Pago'), ' - S/ ', CONVERT(VARCHAR(30), pg.importe)), pg.fecha_registro
			FROM dbo.tbl_pago pg
			INNER JOIN dbo.tbl_cita c ON c.id_cita = pg.id_cita
			LEFT JOIN dbo.tbl_forma_pago fp ON fp.id = pg.id_forma_pago
			WHERE c.id_sede = @IdSede
			  AND (@EsCounter = 0 OR pg.usuario_registro = @Login)
		) recientes
		ORDER BY recientes.Fecha DESC;
	END
	ELSE
	BEGIN
		SELECT CAST(NULL AS VARCHAR(20)) AS Tipo, CAST(NULL AS VARCHAR(100)) AS Titulo,
			   CAST(NULL AS VARCHAR(200)) AS Descripcion, CAST(NULL AS DATETIME) AS Fecha
		WHERE 1 = 0;
	END
END;
GO
