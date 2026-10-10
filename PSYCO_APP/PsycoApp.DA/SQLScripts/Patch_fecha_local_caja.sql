SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[Get_date]()
RETURNS DATETIME
AS
BEGIN
	DECLARE @UtcNow DATETIME2(7) = SYSUTCDATETIME();
	RETURN CONVERT(DATETIME, @UtcNow AT TIME ZONE 'UTC' AT TIME ZONE 'SA Pacific Standard Time');
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_APERTURAR_CAJA]
(
	@UsuarioApertura VARCHAR(20),
	@IdSede INT,
	@Observaciones VARCHAR(1000) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @FechaHoraApertura DATETIME = dbo.Get_date();

	IF EXISTS
	(
		SELECT 1
		FROM dbo.tbl_caja
		WHERE Fecha < CAST(@FechaHoraApertura AS DATE)
		  AND Estado = 'ABIERTA'
		  AND UsuarioApertura = @UsuarioApertura
		  AND IdSede = @IdSede
	)
	BEGIN
		SELECT 'Existe una caja de una fecha anterior que sigue abierta para esta sede' AS rpta;
		RETURN;
	END

	IF EXISTS
	(
		SELECT 1
		FROM dbo.tbl_caja
		WHERE Fecha = CAST(@FechaHoraApertura AS DATE)
		  AND Estado = 'ABIERTA'
		  AND UsuarioApertura = @UsuarioApertura
		  AND IdSede = @IdSede
	)
	BEGIN
		SELECT 'Ya existe una caja abierta para el día de hoy para esta sede' AS rpta;
		RETURN;
	END

	INSERT INTO dbo.tbl_caja (Fecha, HoraApertura, Estado, UsuarioApertura, IdSede, Observaciones)
	VALUES (CAST(@FechaHoraApertura AS DATE), @FechaHoraApertura, 'ABIERTA', @UsuarioApertura, @IdSede, @Observaciones);

	SELECT 'OK' AS rpta;
	RETURN;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_CERRAR_CAJA]
	@UsuarioCierre VARCHAR(20),
	@IdSede INT,
	@Observaciones VARCHAR(1000) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS
	(
		SELECT TOP 1 Id
		FROM dbo.tbl_caja
		WHERE Estado = 'ABIERTA'
		  AND UsuarioApertura = @UsuarioCierre
		  AND IdSede = @IdSede
		ORDER BY HoraApertura ASC
	)
	BEGIN
		SELECT 'No existe una caja abierta para cerrar en esta sede' AS rpta;
		RETURN;
	END

	DECLARE @IdCaja INT;

	SELECT TOP 1 @IdCaja = Id
	FROM dbo.tbl_caja
	WHERE Estado = 'ABIERTA'
	  AND UsuarioApertura = @UsuarioCierre
	  AND IdSede = @IdSede
	ORDER BY HoraApertura;

	UPDATE dbo.tbl_caja
	SET Estado = 'CERRADA',
		HoraCierre = dbo.Get_date(),
		UsuarioCierre = @UsuarioCierre,
		Observaciones = CASE
			WHEN Observaciones IS NULL THEN @Observaciones
			ELSE CONCAT(Observaciones, ' | ', @Observaciones)
		END
	WHERE Id = @IdCaja;

	SELECT 'OK' AS rpta;
	RETURN;
END
GO
