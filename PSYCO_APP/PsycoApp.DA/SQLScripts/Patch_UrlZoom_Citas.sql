USE [PsycoApp]
GO
IF COL_LENGTH('dbo.tbl_cita', 'url_zoom') IS NULL
	ALTER TABLE dbo.tbl_cita ADD url_zoom NVARCHAR(500) NULL;
GO
ALTER PROCEDURE [dbo].[SP_REGISTRAR_CITA]
(
	@id_cita int,
	@id_paciente int,
	@fecha_cita varchar(10),
	@hora_cita varchar(8),
	@id_doctor int,
	@monto_pactado decimal(10,2) = null,
	@descuento decimal(10,2) = null,
	@id_servicio int,
	@id_sede int,
	@tipo_cita varchar(1),
	@usuario varchar(50),
	@adicional varchar(2),
	@feedback bit = NULL,
	@comentario varchar(500) = NULL,
	@orden int = 0,
	@id_paquete INT = 0 OUTPUT,
	@url_zoom nvarchar(500) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @estado_cita int = 1;
	DECLARE @fecha_cita_ date = CONVERT(date, @fecha_cita);
	DECLARE @hora_cita_ time = NULL;
	DECLARE @fecha_hora_cita_ datetime = NULL;

	DECLARE @moneda varchar(10) = 'S/.';
	DECLARE @inicio time = CONVERT(time, CONVERT(datetime, '07:00 AM', 0));
	DECLARE @fin time = CONVERT(time, CONVERT(datetime, '09:00 PM', 0));
	DECLARE @siglas varchar(20) = (SELECT Siglas FROM Productos WHERE id=@id_servicio);

	SET @monto_pactado = (SELECT Precio FROM Productos WHERE id=@id_servicio);
	IF (@adicional = 'SI')
	BEGIN
		SET @monto_pactado = 0.00;
		SET @descuento = NULL;
	END

	IF @hora_cita = '-1'
	BEGIN
		IF @id_cita = 0
		BEGIN
			IF (@orden = 0)
				SET @id_paquete = 0;
			ELSE IF (@orden = 1)
			BEGIN
				INSERT INTO tbl_paquete (informe_adicional, usuario_registra, fecha_registra)
				VALUES ('NO', @usuario, dbo.Get_date());
				SET @id_paquete = SCOPE_IDENTITY();
			END;

			INSERT INTO tbl_cita (
				id_paciente, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo,
				Moneda, Monto_pactado, Monto_pagado, Monto_pendiente, id_servicio, id_sede,
				usuario_registra, fecha_registra, feedback, comentario, orden, pago_gratis,
				tipo_cita, id_paquete, Monto_descuento, url_zoom
			)
			VALUES (
				@id_paciente, @fecha_cita_, '00:00:00.000', @id_doctor, @estado_cita, 'CITA',
				@moneda, @monto_pactado, 0.00, @monto_pactado, @id_servicio, @id_sede,
				@usuario, dbo.Get_date(), @feedback, @comentario, @orden,
				(CASE WHEN @siglas = 'EG' THEN 1 ELSE 0 END),
				@tipo_cita, @id_paquete, @descuento, @url_zoom
			);

			SET @id_cita = SCOPE_IDENTITY();
			INSERT INTO tbl_historial_cita
			SELECT @id_cita, 1, 'CITA EN BORRADOR', @usuario, dbo.Get_date();

			SELECT 'OK' AS 'rpta';
			RETURN;
		END
		ELSE
		BEGIN
			UPDATE tbl_cita SET
				fecha_cita = @fecha_cita_,
				hora_cita = NULL,
				id_doctor_asignado = @id_doctor,
				moneda = @moneda,
				Monto_pactado = @monto_pactado,
				id_servicio = @id_servicio,
				usuario_modifica = @usuario,
				fecha_modifica = dbo.Get_date(),
				feedback = @feedback,
				comentario = @comentario,
				tipo = 'CITA',
				tipo_cita = @tipo_cita,
				Monto_descuento = @descuento,
				url_zoom = @url_zoom
			WHERE id_cita = @id_cita;

			INSERT INTO tbl_historial_cita
			SELECT @id_cita, 0, 'ACTUALIZADO A BORRADOR', @usuario, dbo.Get_date();

			SELECT 'OK' AS 'rpta';
			RETURN;
		END
	END

	IF (@id_paquete > 0)
	BEGIN
		SET @id_servicio = (SELECT TOP 1 id_servicio FROM tbl_cita WHERE id_paquete = @id_paquete);
		SET @monto_pactado = 0.00;
	END

	SET @hora_cita_ = CONVERT(time, CONVERT(datetime, @hora_cita, 0));
	SET @fecha_hora_cita_ = CAST(@fecha_cita_ AS DATETIME) + CAST(@hora_cita_ AS DATETIME);

	IF EXISTS (SELECT 1 FROM tbl_vacaciones_psicologo WHERE Id_psicologo=@id_doctor AND Fecha=@fecha_cita)
	BEGIN
		SELECT 'La fecha seleccionada es un día registrado como vacaciones.' AS 'rpta';
		RETURN;
	END

	IF EXISTS (SELECT * FROM tbl_cita WHERE hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_doctor_asignado = @id_doctor and id_estado_cita <> 4)
	BEGIN
		SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
	END
	ELSE
	BEGIN
		IF @id_cita = 0
		BEGIN
			IF EXISTS (SELECT * FROM tbl_cita WHERE id_doctor_asignado = @id_doctor and hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_estado_cita <> 4)
			BEGIN
				SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
			END
			ELSE
			BEGIN
				IF (@orden = 0)
				BEGIN
					IF @id_paquete = 0
						SET @id_paquete = 0;
				END
				ELSE IF (@orden = 1)
				BEGIN
					INSERT INTO tbl_paquete (informe_adicional, usuario_registra, fecha_registra)
					VALUES ('NO', @usuario, dbo.Get_date());
					SET @id_paquete = SCOPE_IDENTITY();
				END

				INSERT INTO tbl_cita (id_paciente, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo, Moneda, Monto_pactado, Monto_pagado, Monto_pendiente, id_servicio, id_sede, usuario_registra, fecha_registra, feedback, comentario, orden, pago_gratis, tipo_cita, id_paquete, Monto_descuento, url_zoom)
				VALUES (@id_paciente, @fecha_cita_, @hora_cita_, @id_doctor, @estado_cita, 'CITA', @moneda, @monto_pactado, 0.00, @monto_pactado, @id_servicio, @id_sede, @usuario, dbo.Get_date(), @feedback, @comentario, @orden, (case when @siglas = 'EG' then 1 else 0 end), @tipo_cita, @id_paquete, @descuento, @url_zoom);

				SET @id_cita = SCOPE_IDENTITY();
				INSERT INTO tbl_historial_cita SELECT @id_cita, 1, (SELECT ec.estado_cita FROM tbl_estados_cita ec WHERE ec.id_estado_cita=@estado_cita), @usuario, dbo.Get_date();

				SELECT 'OK' AS 'rpta';
			END
		END
		ELSE IF @id_cita > 0
		BEGIN
			IF EXISTS (SELECT * FROM tbl_cita WHERE id_doctor_asignado = @id_doctor and hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_estado_cita <> 4)
			BEGIN
				SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
			END
			ELSE
			BEGIN
				UPDATE tbl_cita SET
					fecha_cita = @fecha_cita_,
					hora_cita = @hora_cita_,
					id_doctor_asignado = @id_doctor,
					moneda = @moneda,
					Monto_pactado = @monto_pactado,
					id_servicio = @id_servicio,
					usuario_modifica = @usuario,
					fecha_modifica = dbo.Get_date(),
					feedback = @feedback,
					comentario = @comentario,
					tipo_cita = @tipo_cita,
					Monto_descuento = @descuento,
					[url_zoom] = @url_zoom
				WHERE id_cita = @id_cita;

				INSERT INTO tbl_historial_cita SELECT @id_cita, 0, 'REPROGRAMACIÓN', @usuario, dbo.Get_date();

				SELECT 'OK' AS 'rpta';
			END
		END
	END
END
GO

ALTER PROCEDURE [dbo].[SP_LISTAR_CITAS_USUARIO]
(
	@id_usuario INT,
	@id_paciente INT,
	@id_doctor INT,
	@id_sede INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @fechaIni date = DATEADD(month, -4, dbo.Get_date());
	DECLARE @id_tipousuario INT;
	DECLARE @dni_usuario VARCHAR(10);

	SELECT
		@id_tipousuario = u.id_tipousuario,
		@dni_usuario = u.num_documento
	FROM tbl_usuario u WHERE u.id_usuario=@id_usuario;

	IF (@id_tipousuario = 4)
	BEGIN
		SELECT TOP 1 @id_doctor = p.Id
		FROM tbl_psicologo p
		INNER JOIN tbl_sede_usuario sd ON sd.Id_psicologo=p.Id
		WHERE sd.Id_sede=@id_sede
		AND p.DocumentoNumero = @dni_usuario;
	END

	;WITH CitasFiltradas AS (
		SELECT
			c.*,
			p.Nombre 'nombre_servicio'
		FROM tbl_cita c
		LEFT JOIN Productos p ON p.id=c.id_servicio
		WHERE c.tipo IN ('CITA')
		AND c.id_estado_cita IN (1, 2, 3)
		AND (@id_paciente = -1 OR c.id_paciente = @id_paciente)
		AND (@id_doctor = -1 OR c.id_doctor_asignado = @id_doctor)
		AND (@id_sede = -1 OR c.id_sede = @id_sede)
		AND c.fecha_cita > @fechaIni
	)

	SELECT
		c.id_cita,
		c.id_estado_cita,
		e.estado_cita 'estado',
		CONVERT(varchar(10), CONVERT(date, c.fecha_cita)) 'fecha_cita',
		FORMAT(c.FechaHoraCita, 'hh:mm tt') AS 'hora_cita',
		c.id_doctor_asignado,
		ps.Nombre 'doctor_asignado',
		c.tipo,
		pa.Id 'id_paciente',
		CONCAT(pa.DocumentoTipo,' - ',LTRIM(RTRIM(ISNULL(pa.DocumentoNumero,'')))) 'dni_paciente',
		CONCAT(LTRIM(RTRIM(pa.Nombre)), ' ', LTRIM(RTRIM(pa.Apellido))) 'paciente',
		pa.Telefono 'telefono',
		c.Moneda 'moneda',
		c.Monto_pactado 'monto_pactado',
		c.Monto_pagado 'monto_pagado',
		dbo.fn_FixDecimal(c.Monto_pendiente) - dbo.fn_FixDecimal(ISNULL(c.Monto_descuento, 0.00)) 'monto_pendiente',
		c.id_servicio 'id_servicio',
		c.nombre_servicio 'nombre_servicio',
		ISNULL(c.tipo_cita, 'P') 'tipo_cita',
		c.id_sede 'id_sede',
		ISNULL(p.esEvaluacion, CAST(0 AS bit)) 'esEvaluacion',
		CASE
			WHEN p.Siglas IS NULL THEN ''
			WHEN p.Siglas IN ('CSC','I30') THEN CONCAT('(',p.Siglas,')')
			ELSE CONCAT('(',p.Siglas,c.orden,')')
		END 'siglas',
		ISNULL(c.feedback, CAST(0 AS BIT)) AS 'feedback',
		c.comentario AS 'comentario',
		ISNULL(c.pago_gratis, 0) AS 'pago_gratis',
		ISNULL(c.id_paquete, 0) AS 'id_paquete',
		CASE
			WHEN ISNULL(c.id_paquete, 0) = 0 THEN ''
			WHEN c.orden > p.NumSesiones THEN 'Adicional'
			ELSE CONCAT(c.orden, '/', p.NumSesiones)
		END AS 'orden_cita',
		DATEDIFF(YEAR, pa.FechaNacimiento, GETDATE())
			- CASE WHEN (MONTH(pa.FechaNacimiento) > MONTH(GETDATE())
				OR (MONTH(pa.FechaNacimiento) = MONTH(GETDATE())
				AND DAY(pa.FechaNacimiento) > DAY(GETDATE())))
			THEN 1 ELSE 0 END AS 'edad',
		c.url_zoom AS 'url_zoom'
	FROM CitasFiltradas c
	INNER JOIN tbl_paciente pa ON pa.Id = c.id_paciente
	INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita
	INNER JOIN Productos p ON p.id = c.id_servicio
	LEFT JOIN tbl_psicologo ps ON ps.Id = c.id_doctor_asignado
	ORDER BY c.FechaHoraCita ASC;
END
GO
