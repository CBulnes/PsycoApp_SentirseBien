USE [DB_TEA]
GO
/****** Object:  StoredProcedure [dbo].[SP_VISITAS]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_VISITAS]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_USUARIO]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_VALIDAR_USUARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_FLUJO_ACTUAL]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_VALIDAR_FLUJO_ACTUAL]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_NPS]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_RESULTADOS_NPS]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_VISITA]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_VISITA]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_USUARIO]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_USUARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_TICKET]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_TICKET]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTUACION]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_PUNTUACION]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTO_VISITADO]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_PUNTO_VISITADO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_INVITADO]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_INVITADO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_FLUJO]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_FLUJO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CITA]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_CITA]
GO
/****** Object:  StoredProcedure [dbo].[SP_PUNTOS_VISITADOS]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_PUNTOS_VISITADOS]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_MENU]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_MENU]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DOCTORES]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_DOCTORES]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_USUARIO]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_CITAS_USUARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_DOCTOR]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_CITAS_DOCTOR]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CENTROS_ATENCION]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_CENTROS_ATENCION]
GO
/****** Object:  StoredProcedure [dbo].[sp_generar_ticket]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[sp_generar_ticket]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_CONTRASEÑA]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[SP_ACTUALIZAR_CONTRASEÑA]
GO
/****** Object:  StoredProcedure [dbo].[generar_backup_watson]    Script Date: 08/09/2022 1:27:40 ******/
DROP PROCEDURE [dbo].[generar_backup_watson]
GO
/****** Object:  Table [dbo].[tbl_visitas]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_visitas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_visitas]
GO
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_usuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_usuario]
GO
/****** Object:  Table [dbo].[tbl_tipousuario]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tipousuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_tipousuario]
GO
/****** Object:  Table [dbo].[tbl_tipolinea]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tipolinea]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_tipolinea]
GO
/****** Object:  Table [dbo].[tbl_tickets]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tickets]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_tickets]
GO
/****** Object:  Table [dbo].[tbl_resumen_flujo]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_resumen_flujo]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_resumen_flujo]
GO
/****** Object:  Table [dbo].[tbl_puntos_visitados]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_puntos_visitados]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_puntos_visitados]
GO
/****** Object:  Table [dbo].[tbl_opciones_usuario]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_opciones_usuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_opciones_usuario]
GO
/****** Object:  Table [dbo].[tbl_meses]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_meses]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_meses]
GO
/****** Object:  Table [dbo].[tbl_menu]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_menu]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_menu]
GO
/****** Object:  Table [dbo].[tbl_invitados]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_invitados]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_invitados]
GO
/****** Object:  Table [dbo].[tbl_historial_paciente]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_historial_paciente]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_historial_paciente]
GO
/****** Object:  Table [dbo].[tbl_flujos]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_flujos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_flujos]
GO
/****** Object:  Table [dbo].[tbl_estados_cita]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_estados_cita]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_estados_cita]
GO
/****** Object:  Table [dbo].[tbl_encuesta]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_encuesta]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_encuesta]
GO
/****** Object:  Table [dbo].[tbl_cita]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_cita]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_cita]
GO
/****** Object:  Table [dbo].[tbl_centros_atencion]    Script Date: 08/09/2022 1:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_centros_atencion]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_centros_atencion]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_EncriptarPassword]    Script Date: 08/09/2022 1:27:40 ******/
DROP FUNCTION [dbo].[fn_EncriptarPassword]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DesencriptarPassword]    Script Date: 08/09/2022 1:27:40 ******/
DROP FUNCTION [dbo].[fn_DesencriptarPassword]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DesencriptarPassword]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_DesencriptarPassword]
(
	@password varbinary(300)
)
RETURNS varchar(300)
AS   

BEGIN
    DECLARE @res_decrypt varchar(300);

    SELECT @res_decrypt = CONVERT(VARCHAR(100), DecryptByPassPhrase('12', @password))	
    RETURN @res_decrypt;
END;


GO
/****** Object:  UserDefinedFunction [dbo].[fn_EncriptarPassword]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_EncriptarPassword]
(
	@password varchar(300)
)
RETURNS varbinary(300)
AS   

BEGIN  
    DECLARE @res_encrypt varbinary(300);

    SELECT @res_encrypt = EncryptByPassPhrase('12', @password)
    RETURN @res_encrypt;
END;
GO
/****** Object:  Table [dbo].[tbl_centros_atencion]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_centros_atencion](
	[id_centro_atencion] [int] IDENTITY(1,1) NOT NULL,
	[centro_atencion] [varchar](200) NULL,
	[direccion] [varchar](200) NULL,
	[horario] [varchar](200) NULL,
	[latitud] [varchar](20) NULL,
	[longitud] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_centro_atencion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_cita]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cita](
	[id_cita] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[fecha_cita] [date] NULL,
	[hora_cita] [time](7) NULL,
	[id_doctor_asignado] [int] NULL,
	[id_estado_cita] [int] NULL,
	[fecha_registro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_encuesta]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_encuesta](
	[id_item] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[puntuacion] [int] NULL,
	[hora] [varchar](8) NULL,
	[fecha] [varchar](10) NULL,
	[resultado] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_estados_cita]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_estados_cita](
	[id_estado_cita] [int] IDENTITY(1,1) NOT NULL,
	[estado_cita] [varchar](50) NULL,
	[fecha_registro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_estado_cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_flujos]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_flujos](
	[id_flujo] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[tipo] [varchar](50) NULL,
	[contenido_texto] [nvarchar](max) NULL,
	[contenido_html] [nvarchar](max) NULL,
	[habilitado] [int] NULL,
	[remitente] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_flujo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_historial_paciente]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_historial_paciente](
	[id_historial] [int] IDENTITY(1,1) NOT NULL,
	[id_paciente] [int] NULL,
	[nota] [varchar](500) NULL,
	[recomendacion] [varchar](500) NULL,
	[medicina] [varchar](500) NULL,
	[id_doctor] [int] NULL,
	[fecha_registro] [date] NULL,
	[hora_registro] [time](7) NULL,
 CONSTRAINT [PK__tbl_hist__76E6C502D94772C6] PRIMARY KEY CLUSTERED 
(
	[id_historial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_invitados]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_invitados](
	[id_invitado] [int] IDENTITY(-1,-1) NOT NULL,
	[linea] [varchar](20) NULL,
	[id_tipolinea] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_invitado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_menu]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_menu](
	[id_padre] [char](2) NULL,
	[id_opcion] [char](4) NULL,
	[opcion] [varchar](100) NULL,
	[posicion] [int] NULL,
	[icono] [varchar](100) NULL,
	[url] [varchar](100) NULL,
	[habilitado] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_meses]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_meses](
	[num_mes] [int] NULL,
	[mes] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_opciones_usuario]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_opciones_usuario](
	[id_usuario] [int] NULL,
	[id_tipousuario] [int] NULL,
	[id_opcion] [varchar](5) NULL,
	[habilitado] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_puntos_visitados]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_puntos_visitados](
	[punto_visitado] [varchar](50) NULL,
	[visitante] [varchar](50) NULL,
	[fecha_visita] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_resumen_flujo]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_resumen_flujo](
	[id_item] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[resultado] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tickets]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tickets](
	[id_ticket] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NULL,
	[id_usuario] [int] NULL,
	[estado] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipolinea]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipolinea](
	[id_tipolinea] [int] IDENTITY(1,1) NOT NULL,
	[tipolinea] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipolinea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipousuario]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipousuario](
	[id_tipousuario] [int] IDENTITY(1,1) NOT NULL,
	[tipousuario] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipousuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](100) NULL,
	[apellidos] [varchar](100) NULL,
	[id_tipousuario] [int] NULL,
	[password] [varbinary](300) NULL,
	[habilitado] [int] NULL,
	[tipo_documento] [varchar](50) NULL,
	[num_documento] [varchar](50) NULL,
	[email] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_visitas]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_visitas](
	[visitante] [varchar](50) NULL,
	[fecha_visita] [datetime] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_centros_atencion] ON 
GO
INSERT [dbo].[tbl_centros_atencion] ([id_centro_atencion], [centro_atencion], [direccion], [horario], [latitud], [longitud]) VALUES (1, N'Centro Cívico', N'Av. Paseo de la República', N'Todo el día', N'-12.056308', N'-77.037218')
GO
INSERT [dbo].[tbl_centros_atencion] ([id_centro_atencion], [centro_atencion], [direccion], [horario], [latitud], [longitud]) VALUES (2, N'Rambla', N'Av. Javier Prado', N'10:00 - 18:00', N'-12.087802', N'-77.014022')
GO
INSERT [dbo].[tbl_centros_atencion] ([id_centro_atencion], [centro_atencion], [direccion], [horario], [latitud], [longitud]) VALUES (3, N'Plaza Lima Sur', N'Av Paseo de la República', N'10:00 - 21:00', N'-12.173210', N'-77.014127')
GO
SET IDENTITY_INSERT [dbo].[tbl_centros_atencion] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_cita] ON 
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (1, 2, CAST(N'2022-08-05' AS Date), CAST(N'13:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:10:17.757' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (2, 2, CAST(N'2022-08-05' AS Date), CAST(N'14:00:00' AS Time), 4, 2, CAST(N'2022-08-05T13:11:37.873' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (3, 2, CAST(N'2022-08-12' AS Date), CAST(N'13:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:14:12.070' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (4, 2, CAST(N'2022-08-04' AS Date), CAST(N'08:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:21:55.307' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (5, 2, CAST(N'2022-08-26' AS Date), CAST(N'14:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:38:20.857' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (6, 2, CAST(N'2022-08-26' AS Date), CAST(N'13:00:00' AS Time), 5, 1, CAST(N'2022-08-05T15:26:47.760' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (7, 2, CAST(N'2022-09-08' AS Date), CAST(N'10:00:00' AS Time), 3, 1, CAST(N'2022-08-31T22:12:17.580' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_cita] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_encuesta] ON 
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (1, 2, 4, N'15:09:34', N'2021-04-03', N'Detractor')
GO
SET IDENTITY_INSERT [dbo].[tbl_encuesta] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_estados_cita] ON 
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (1, N'REGISTRADO', CAST(N'2022-08-25T21:45:58.160' AS DateTime))
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (2, N'ATENDIDO', CAST(N'2022-08-25T21:45:58.163' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_estados_cita] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_flujos] ON 
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1, 2, N'text', N'Hola, ¿cómo estás?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">19:28</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (2, -1, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">03:00</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (3, -2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">15:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (4, -2, N'text', N'graciass', N'<li class="reverse"><div class="chat-time">15:05</div><div class="chat-content"><div class="box bg-light-inverse">graciass</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (5, -2, N'text', N'Gracias a Usted! Que tenga un buen día!', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias a Usted! Que tenga un buen día!</div></div><div class="chat-time">15:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (6, -2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:06</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (7, -2, N'text', N'Revise si se encuentra enchufado a la corriente
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Revise si se encuentra enchufado a la corriente
</div></div><div class="chat-time">15:06</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (8, -2, N'options_title', N'¿Se soluciono?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Se soluciono?</div></div></div><div class="chat-time">15:06</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (9, -2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Confirm'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''LaptoRouter'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (10, -2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">15:06</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (11, -2, N'text', N'Gracias! Por su preferencia
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias! Por su preferencia
</div></div><div class="chat-time">15:06</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (12, 2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (13, 2, N'text', N'Revise si se encuentra enchufado a la corriente
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Revise si se encuentra enchufado a la corriente
</div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (14, 2, N'options_title', N'¿Se soluciono?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Se soluciono?</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (15, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Confirm'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''LaptoRouter'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (16, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (17, 2, N'text', N'Gracias! Por su preferencia
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias! Por su preferencia
</div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (18, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (19, 2, N'options_title', N'Por favor conecte su laptop al router por cable de red', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor conecte su laptop al router por cable de red</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (20, 2, N'option', N'Si tengo mi cable de Red,No tengo mi cable de Red', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''SiCable'',''Si tengo mi cable de Red'')"><div class="box bg-light-info">Si tengo mi cable de Red</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo mi cable de red'',''No tengo mi cable de Red'')"><div class="box bg-light-info">No tengo mi cable de Red</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (21, 2, N'text', N'No tengo mi cable de red', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">No tengo mi cable de red</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (22, 2, N'options_title', N'Por favor conecte su laptop al router por cable de red', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor conecte su laptop al router por cable de red</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (23, 2, N'option', N'Si tengo mi cable de Red,No tengo mi cable de Red', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''SiCable'',''Si tengo mi cable de Red'')"><div class="box bg-light-info">Si tengo mi cable de Red</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo mi cable de red'',''No tengo mi cable de Red'')"><div class="box bg-light-info">No tengo mi cable de Red</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (24, 2, N'text', N'Si tengo mi cable de Red', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo mi cable de Red</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (25, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (26, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (27, 2, N'text', N'Si tengo internet', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (28, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (29, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (30, 2, N'text', N'Si tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (31, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (32, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (33, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (34, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (35, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (36, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (37, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (38, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (39, 2, N'text', N'No tengo mi cable de red', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo mi cable de red</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (40, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (41, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (42, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (43, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (44, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (45, 2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (46, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (47, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (48, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (49, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (50, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (51, 2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (52, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (53, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (54, 2, N'text', N'Si tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (55, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (56, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (57, 2, N'text', N'si tengo', N'<li class="reverse"><div class="chat-time">15:09</div><div class="chat-content"><div class="box bg-light-inverse">si tengo</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (58, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (59, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (60, 2, N'text', N'gracias', N'<li class="reverse"><div class="chat-time">15:09</div><div class="chat-content"><div class="box bg-light-inverse">gracias</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (61, 2, N'options_title', N'¿Tienes alguna consulta adicional?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tienes alguna consulta adicional?</div></div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (62, 2, N'option', N'SI,NINGUNA', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''si_otra_consulta'',''SI'')"><div class="box bg-light-info">SI</div></div><div class="chat-content chat-option" onclick="redirect_message(''ninguna_consulta'',''NINGUNA'')"><div class="box bg-light-info">NINGUNA</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (63, 2, N'text', N'No tengo otra consulta', N'<li class="reverse"><div class="chat-time">15:09</div><div class="chat-content"><div class="box bg-light-inverse">No tengo otra consulta</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (64, 2, N'text', N'Gracias! Por su preferencia', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias! Por su preferencia</div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (65, 2, N'text', N'Hola otra vez, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola otra vez, ¿cómo puedo ayudarte?</div></div><div class="chat-time">15:09</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (66, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">01:13</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (67, 2, N'text', N'¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:</div></div><div class="chat-time">01:13</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (68, 2, N'options_title', N'Menu de opciones', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Menu de opciones</div></div></div><div class="chat-time">01:13</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (69, 2, N'option', N'A) Cuentas y número de Cuentas Interbancarias (CCI) ??,B) Tarjetas de Crédito ??,C) Créditos Personales ??,D) Seguros Bancarios ??,E) Estado de Cuenta ??,F) Más Productos y servicios Bancarias ,G) Sugerencias para mejorar el servicio', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Opción A'',''A) Cuentas y número de Cuentas Interbancarias (CCI) ??'')"><div class="box bg-light-info">A) Cuentas y número de Cuentas Interbancarias (CCI) ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción B'',''B) Tarjetas de Crédito ??'')"><div class="box bg-light-info">B) Tarjetas de Crédito ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción C'',''C) Créditos Personales ??'')"><div class="box bg-light-info">C) Créditos Personales ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción D'',''D) Seguros Bancarios ??'')"><div class="box bg-light-info">D) Seguros Bancarios ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción E'',''E) Estado de Cuenta ??'')"><div class="box bg-light-info">E) Estado de Cuenta ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción F'',''F) Más Productos y servicios Bancarias '')"><div class="box bg-light-info">F) Más Productos y servicios Bancarias </div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción G'',''G) Sugerencias para mejorar el servicio'')"><div class="box bg-light-info">G) Sugerencias para mejorar el servicio</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (70, 2, N'text', N'Opción B', N'<li class="reverse"><div class="chat-time">22:21</div><div class="chat-content"><div class="box bg-light-inverse">Opción B</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (71, 2, N'text', N'Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114</div></div><div class="chat-time">22:21</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (72, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">22:23</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (73, 2, N'options_title', N'Menu de opciones', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Menu de opciones</div></div></div><div class="chat-time">22:23</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (74, 2, N'text', N'¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:</div></div><div class="chat-time">22:23</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (75, 2, N'option', N'A) Cuentas y número de Cuentas Interbancarias (CCI) ??,B) Tarjetas de Crédito ??,C) Créditos Personales ??,D) Seguros Bancarios ??,E) Estado de Cuenta ??,F) Más Productos y servicios Bancarias ,G) Sugerencias para mejorar el servicio', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Opción A'',''A) Cuentas y número de Cuentas Interbancarias (CCI) ??'')"><div class="box bg-light-info">A) Cuentas y número de Cuentas Interbancarias (CCI) ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción B'',''B) Tarjetas de Crédito ??'')"><div class="box bg-light-info">B) Tarjetas de Crédito ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción C'',''C) Créditos Personales ??'')"><div class="box bg-light-info">C) Créditos Personales ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción D'',''D) Seguros Bancarios ??'')"><div class="box bg-light-info">D) Seguros Bancarios ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción E'',''E) Estado de Cuenta ??'')"><div class="box bg-light-info">E) Estado de Cuenta ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción F'',''F) Más Productos y servicios Bancarias '')"><div class="box bg-light-info">F) Más Productos y servicios Bancarias </div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción G'',''G) Sugerencias para mejorar el servicio'')"><div class="box bg-light-info">G) Sugerencias para mejorar el servicio</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (76, 2, N'text', N'Opción B', N'<li class="reverse"><div class="chat-time">22:23</div><div class="chat-content"><div class="box bg-light-inverse">Opción B</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (77, 2, N'text', N'Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114</div></div><div class="chat-time">22:23</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (78, 2, N'text', N'Opción F', N'<li class="reverse"><div class="chat-time">22:24</div><div class="chat-content"><div class="box bg-light-inverse">Opción F</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (79, 2, N'text', N'El servicio de Chatbot no responde. Vuelva a intentarlo', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">El servicio de Chatbot no responde. Vuelva a intentarlo</div></div><div class="chat-time">22:24</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (80, 2, N'text', N'Opción E', N'<li class="reverse"><div class="chat-time">22:24</div><div class="chat-content"><div class="box bg-light-inverse">Opción E</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (81, 2, N'text', N'Le brindamos el saldo de sus cuentas actuales.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Le brindamos el saldo de sus cuentas actuales.</div></div><div class="chat-time">22:24</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (82, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">00:02</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (83, 2, N'options_title', N'Hola somos el asistente virtual de la clinica ingrese la edad del paciente.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Hola somos el asistente virtual de la clinica ingrese la edad del paciente.</div></div></div><div class="chat-time">00:03</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (84, 2, N'option', N'16-30 Meses,4 años,4 a 11 años', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario 1'',''16-30 Meses'')"><div class="box bg-light-info">16-30 Meses</div></div><div class="chat-content chat-option" onclick="redirect_message(''4 años'',''4 años'')"><div class="box bg-light-info">4 años</div></div><div class="chat-content chat-option" onclick="redirect_message(''11 años'',''4 a 11 años'')"><div class="box bg-light-info">4 a 11 años</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (85, 2, N'text', N'4 años', N'<li class="reverse"><div class="chat-time">00:04</div><div class="chat-content"><div class="box bg-light-inverse">4 años</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (86, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">00:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (87, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">00:05</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (88, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">00:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (89, 2, N'text', N'11 años', N'<li class="reverse"><div class="chat-time">00:05</div><div class="chat-content"><div class="box bg-light-inverse">11 años</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (90, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">00:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1082, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:07</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1083, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:08</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1084, 2, N'text', N'4 años', N'<li class="reverse"><div class="chat-time">21:08</div><div class="chat-content"><div class="box bg-light-inverse">4 años</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1085, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:08</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1086, 2, N'text', N'11 años', N'<li class="reverse"><div class="chat-time">21:08</div><div class="chat-content"><div class="box bg-light-inverse">11 años</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1087, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:09</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1088, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:25</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1089, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:25</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1090, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:26</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1091, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:26</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1092, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:27</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1093, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:27</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1094, 2, N'text', N'16-30 Meses', N'<li class="reverse"><div class="chat-time">21:28</div><div class="chat-content"><div class="box bg-light-inverse">16-30 Meses</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1095, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:28</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1096, 2, N'text', N'11 años', N'<li class="reverse"><div class="chat-time">21:28</div><div class="chat-content"><div class="box bg-light-inverse">11 años</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1097, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:28</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1098, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:28</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1099, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:29</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1100, 2, N'text', N'Hola', N'<li class="reverse"><div class="chat-time">21:29</div><div class="chat-content"><div class="box bg-light-inverse">Hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1101, 2, N'options_title', N'Hola somos el asistente virtual de la clinica ingrese la edad del paciente.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Hola somos el asistente virtual de la clinica ingrese la edad del paciente.</div></div></div><div class="chat-time">21:29</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1102, 2, N'option', N'16-30 Meses,4 años,4 a 11 años', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario 1'',''16-30 Meses'')"><div class="box bg-light-info">16-30 Meses</div></div><div class="chat-content chat-option" onclick="redirect_message(''4 años'',''4 años'')"><div class="box bg-light-info">4 años</div></div><div class="chat-content chat-option" onclick="redirect_message(''11 años'',''4 a 11 años'')"><div class="box bg-light-info">4 a 11 años</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1103, 2, N'text', N'Hola', N'<li class="reverse"><div class="chat-time">21:30</div><div class="chat-content"><div class="box bg-light-inverse">Hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1104, 2, N'options_title', N'Hola somos el asistente virtual de la clinica ingrese la edad del paciente.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Hola somos el asistente virtual de la clinica ingrese la edad del paciente.</div></div></div><div class="chat-time">21:30</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1105, 2, N'option', N'16-30 Meses,4 años,4 a 11 años', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario 1'',''16-30 Meses'')"><div class="box bg-light-info">16-30 Meses</div></div><div class="chat-content chat-option" onclick="redirect_message(''4 años'',''4 años'')"><div class="box bg-light-info">4 años</div></div><div class="chat-content chat-option" onclick="redirect_message(''11 años'',''4 a 11 años'')"><div class="box bg-light-info">4 a 11 años</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1106, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:34</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1107, 2, N'options_title', N'Se tomara el cuestionario para niños de 16 a 30 meses de edad.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Se tomara el cuestionario para niños de 16 a 30 meses de edad.</div></div></div><div class="chat-time">21:34</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1108, 2, N'option', N'Empezar', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta1'',''Empezar'')"><div class="box bg-light-info">Empezar</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1109, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">21:38</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1110, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">21:40</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1111, 2, N'text', N'Cuestionario 1', N'<li class="reverse"><div class="chat-time">21:40</div><div class="chat-content"><div class="box bg-light-inverse">Cuestionario 1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1112, 2, N'options_title', N'Se tomara el cuestionario para niños de 16 a 30 meses de edad.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Se tomara el cuestionario para niños de 16 a 30 meses de edad.</div></div></div><div class="chat-time">21:40</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1113, 2, N'option', N'Empezar', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta1'',''Empezar'')"><div class="box bg-light-info">Empezar</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1114, 2, N'text', N'Tpregunta1', N'<li class="reverse"><div class="chat-time">21:40</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta1</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1115, 2, N'options_title', N'1.Si usted señala algo al otro lado de la habitación,¿suhijo/alomira?(POREJEMPLO, Siusted señala a un juguete, un peluche o un animal, ¿su hijo/a lo mira?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">1.Si usted señala algo al otro lado de la habitación,¿suhijo/alomira?(POREJEMPLO, Siusted señala a un juguete, un peluche o un animal, ¿su hijo/a lo mira?)</div></div></div><div class="chat-time">21:40</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1116, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1117, 2, N'text', N'Tpregunta2', N'<li class="reverse"><div class="chat-time">21:41</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta2</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1118, 2, N'options_title', N'2.¿Alguna vez se ha preguntado si su hijo/aes sordo/a?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">2.¿Alguna vez se ha preguntado si su hijo/aes sordo/a?</div></div></div><div class="chat-time">21:41</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1119, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1120, 2, N'text', N'Tpregunta3', N'<li class="reverse"><div class="chat-time">21:41</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta3</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1121, 2, N'options_title', N'3. ¿Su hijo/a juega juegos de fantasía o imaginación? (POR EJEMPLO, “hace como que” bebe de unatazavacía,hablaporteléfonoodadecomeraunamuñecaopeluche,…) ', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">3. ¿Su hijo/a juega juegos de fantasía o imaginación? (POR EJEMPLO, “hace como que” bebe de unatazavacía,hablaporteléfonoodadecomeraunamuñecaopeluche,…) </div></div></div><div class="chat-time">21:41</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1122, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta4'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta4'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1123, 2, N'text', N'Tpregunta4', N'<li class="reverse"><div class="chat-time">21:50</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta4</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1124, 2, N'options_title', N'4.¿A su hijo le gusta subirse cosas?(POR EJEMPLO,auna silla,escaleras,y tobogán,…) ', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">4.¿A su hijo le gusta subirse cosas?(POR EJEMPLO,auna silla,escaleras,y tobogán,…) </div></div></div><div class="chat-time">21:50</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1125, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta5'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta5'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1126, 2, N'text', N'Tpregunta5', N'<li class="reverse"><div class="chat-time">21:50</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta5</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1127, 2, N'options_title', N'5. ¿Hace su hijo/a movimientos inusuales con sus dedos cerca de sus ojos? (POR EJEMPLO, mueve sus dedos cerca de sus ojos de manera inusual?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">5. ¿Hace su hijo/a movimientos inusuales con sus dedos cerca de sus ojos? (POR EJEMPLO, mueve sus dedos cerca de sus ojos de manera inusual?)</div></div></div><div class="chat-time">21:50</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1128, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta6'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta6'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1129, 2, N'text', N'Tpregunta6', N'<li class="reverse"><div class="chat-time">21:50</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta6</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1130, 2, N'options_title', N'6..¿Su Hijo/a señala con un dedo cuando quiere pedir algo o pedir ayuda?(POR EJEMPLO,señala un juguete o algo de comer que está fuera de su alcance?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">6..¿Su Hijo/a señala con un dedo cuando quiere pedir algo o pedir ayuda?(POR EJEMPLO,señala un juguete o algo de comer que está fuera de su alcance?)</div></div></div><div class="chat-time">21:51</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1131, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta7'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta7'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1132, 2, N'text', N'Tpregunta7', N'<li class="reverse"><div class="chat-time">21:51</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta7</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1133, 2, N'options_title', N'7.Su hijo/a señala con un dedo cuando quiere mostrarle algo que le llama la atención?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">7.Su hijo/a señala con un dedo cuando quiere mostrarle algo que le llama la atención?</div></div></div><div class="chat-time">21:51</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1134, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta8'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta8'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1135, 2, N'text', N'Tpregunta8', N'<li class="reverse"><div class="chat-time">21:51</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta8</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1136, 2, N'options_title', N'8. ¿Su hijo/a se interesa en otros niños? (POR EJEMPLO, mira con atención a otros niños, les sonríe o se les acerca?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">8. ¿Su hijo/a se interesa en otros niños? (POR EJEMPLO, mira con atención a otros niños, les sonríe o se les acerca?)</div></div></div><div class="chat-time">21:51</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1137, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta9'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta9'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1138, 2, N'text', N'Tpregunta9', N'<li class="reverse"><div class="chat-time">21:51</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta9</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1139, 2, N'options_title', N'9 . ¿Su hijo/a le muestra cosas acercándolas o levantándolas para que usted las vea – no para pedir ayuda sino solamente para compartirlas con usted? (POR EJEMPLO, le muestra una flor o un peluche o un carrito de juguete)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">9 . ¿Su hijo/a le muestra cosas acercándolas o levantándolas para que usted las vea – no para pedir ayuda sino solamente para compartirlas con usted? (POR EJEMPLO, le muestra una flor o un peluche o un carrito de juguete)</div></div></div><div class="chat-time">21:51</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1140, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta10'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta10'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1141, 2, N'text', N'Tpregunta10', N'<li class="reverse"><div class="chat-time">21:52</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta10</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1142, 2, N'options_title', N'10.¿Su hijo/a responde cuando usted le llama por su nombre? (POREJEMPLO,sevuelve,habla o balbucea, o deja de hacer lo que estaba haciendo para mirarle?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">10.¿Su hijo/a responde cuando usted le llama por su nombre? (POREJEMPLO,sevuelve,habla o balbucea, o deja de hacer lo que estaba haciendo para mirarle?)</div></div></div><div class="chat-time">21:52</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1143, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta11'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta11'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1144, 2, N'text', N'Tpregunta11', N'<li class="reverse"><div class="chat-time">21:52</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta11</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1145, 2, N'options_title', N'11.¿Cuándo usted sonríe hijo/a,él o ella también sonríe?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">11.¿Cuándo usted sonríe hijo/a,él o ella también sonríe?</div></div></div><div class="chat-time">21:52</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1146, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta12'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta12'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1147, 2, N'text', N'Tpregunta12', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta12</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1148, 2, N'options_title', N'12. ¿Le molestan a su hijo/a ruidos cotidianos? (¿POR EJEMPLO, la aspiradora, secador de cabello, licuadora, máquina de cortar césped?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">12. ¿Le molestan a su hijo/a ruidos cotidianos? (¿POR EJEMPLO, la aspiradora, secador de cabello, licuadora, máquina de cortar césped?</div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1149, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta13'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta13'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1150, 2, N'text', N'Tpregunta13', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta13</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1151, 2, N'options_title', N'13. ¿Suhijo/acaminasolo? ', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">13. ¿Suhijo/acaminasolo? </div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1152, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta14'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta14'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1153, 2, N'text', N'Tpregunta14', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta14</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1154, 2, N'options_title', N'14.¿Su hijo/a le mira a los ojos cuando usted le habla,juega con él o ella,o lo viste? ', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">14.¿Su hijo/a le mira a los ojos cuando usted le habla,juega con él o ella,o lo viste? </div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1155, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta15'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta15'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1156, 2, N'text', N'Tpregunta15', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta15</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1157, 2, N'options_title', N'15.¿Su hijo/a imita tus movimientos?(POR EJEMPLO,decir adiós con lamano,aplaudir o algún ruido gracioso que usted haga?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">15.¿Su hijo/a imita tus movimientos?(POR EJEMPLO,decir adiós con lamano,aplaudir o algún ruido gracioso que usted haga?)</div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1158, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta16'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta16'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1159, 2, N'text', N'Tpregunta16', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta16</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1160, 2, N'options_title', N'16.. Si usted se gira a veralgo , ¿su hijo/a trata de mirar hacia lo que ustedes miran?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">16.. Si usted se gira a veralgo , ¿su hijo/a trata de mirar hacia lo que ustedes miran?</div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1161, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta17'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta17'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1162, 2, N'text', N'Tpregunta17', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta17</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1163, 2, N'options_title', N'17. ¿Su hijo/a intenta que usted le mire/preste atención? (POR EJEMPLO, busca que  usted le haga un cumplido, le diga palabras cariñosas, o le dice “mira” ó "mírame") ', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">17. ¿Su hijo/a intenta que usted le mire/preste atención? (POR EJEMPLO, busca que  usted le haga un cumplido, le diga palabras cariñosas, o le dice “mira” ó "mírame") </div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1164, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta18'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta18'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1165, 2, N'text', N'Tpregunta18', N'<li class="reverse"><div class="chat-time">21:53</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta18</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1166, 2, N'options_title', N'18.¿Su hijo/a le entiende cuando usted le dice que haga algo? (POR EJEMPLO, si usted no hace gestos, ¿su hijo/a entiende “pon el libro encima de la silla” o “tráeme la manta/sábana”?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">18.¿Su hijo/a le entiende cuando usted le dice que haga algo? (POR EJEMPLO, si usted no hace gestos, ¿su hijo/a entiende “pon el libro encima de la silla” o “tráeme la manta/sábana”?)</div></div></div><div class="chat-time">21:53</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1167, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta19'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta19'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1168, 2, N'text', N'Tpregunta19', N'<li class="reverse"><div class="chat-time">21:54</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta19</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1169, 2, N'options_title', N'19.Si algo nuevo pasa,¿su hijo/a le mira para ver como usted reacciona alrespecto?(POR EJEMPLO, si oye un ruido extraño o ve un juguete nuevo, ¿se gira a ver su cara?)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">19.Si algo nuevo pasa,¿su hijo/a le mira para ver como usted reacciona alrespecto?(POR EJEMPLO, si oye un ruido extraño o ve un juguete nuevo, ¿se gira a ver su cara?)</div></div></div><div class="chat-time">21:54</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1170, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta20'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta20'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1171, 2, N'text', N'Tpregunta20', N'<li class="reverse"><div class="chat-time">21:54</div><div class="chat-content"><div class="box bg-light-inverse">Tpregunta20</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1172, 2, N'options_title', N'20.Le gustan a su hijo/a los juegos de movimiento?(POR EJEMPLO , le gusta que le balancee ,o que le haga “el caballito” sentándole en sus rodillas)', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">20.Le gustan a su hijo/a los juegos de movimiento?(POR EJEMPLO , le gusta que le balancee ,o que le haga “el caballito” sentándole en sus rodillas)</div></div></div><div class="chat-time">21:54</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1173, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''TpreguntaFinal'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''TpreguntaFinal'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1174, 2, N'text', N'TpreguntaFinal', N'<li class="reverse"><div class="chat-time">21:54</div><div class="chat-content"><div class="box bg-light-inverse">TpreguntaFinal</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1175, 2, N'text', N'Muy bien se agendo un nuevo test, por favor venir el día de mañana', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Muy bien se agendo un nuevo test, por favor venir el día de mañana</div></div><div class="chat-time">21:54</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1176, 2, N'text', N'j', N'<li class="reverse"><div class="chat-time">18:19</div><div class="chat-content"><div class="box bg-light-inverse">j</div></div><div class="chat-img"><img src="~/images/user.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1177, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://cdn.dribbble.com/users/1953813/screenshots/5350927/media/843d828477b1a647baa33ae4689a8f07.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">18:20</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1178, 2, N'text', N'asd', N'<li class="reverse"><div class="chat-time">18:20</div><div class="chat-content"><div class="box bg-light-inverse">asd</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1179, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://cdn.dribbble.com/users/1953813/screenshots/5350927/media/843d828477b1a647baa33ae4689a8f07.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">18:20</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1180, 2, N'text', N'hi', N'<li class="reverse"><div class="chat-time">18:29</div><div class="chat-content"><div class="box bg-light-inverse">hi</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1181, 2, N'text', N'No le he entendido. Intente reformular la consulta.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">No le he entendido. Intente reformular la consulta.</div></div><div class="chat-time">18:29</div></li>', 1, N'bot')
GO
SET IDENTITY_INSERT [dbo].[tbl_flujos] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_invitados] ON 
GO
INSERT [dbo].[tbl_invitados] ([id_invitado], [linea], [id_tipolinea]) VALUES (-2, N'123123123', 1)
GO
INSERT [dbo].[tbl_invitados] ([id_invitado], [linea], [id_tipolinea]) VALUES (-1, N'98769876', 2)
GO
SET IDENTITY_INSERT [dbo].[tbl_invitados] OFF
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'00', N'01  ', N'ADMINISTRACION', 1, N'mdi mdi-gauge', N'', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'02  ', N'Visitas', 1, N'mdi mdi-gauge', N'Home', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'03  ', N'Reportes', 1, N'mdi mdi-gauge', N'Reportes', 1)
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (1, N'ENERO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (2, N'FEBRERO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (3, N'MARZO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (4, N'ABRIL')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (5, N'MAYO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (6, N'JUNIO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (7, N'JULIO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (8, N'AGOSTO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (9, N'SETIEMBRE')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (10, N'OCTUBRE')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (11, N'NOVIEMBRE')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (12, N'DICIEMBRE')
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'01', 1)
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'02', 1)
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'03', 1)
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-10-18T18:17:45.190' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-07T21:15:15.290' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'CALL-CENTER', N'CLIENTE', CAST(N'2020-11-07T21:26:01.613' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-07T21:30:22.330' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:23:33.793' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:24:57.120' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:26:42.620' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:27:37.190' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-13T09:01:27.710' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-13T09:04:13.883' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'NO CLIENTE', CAST(N'2020-11-20T19:04:29.557' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2022-05-23T22:11:58.780' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_resumen_flujo] ON 
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (1, 2, N'GRACIAS')
GO
SET IDENTITY_INSERT [dbo].[tbl_resumen_flujo] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_tipolinea] ON 
GO
INSERT [dbo].[tbl_tipolinea] ([id_tipolinea], [tipolinea]) VALUES (1, N'Móvil')
GO
INSERT [dbo].[tbl_tipolinea] ([id_tipolinea], [tipolinea]) VALUES (2, N'Fija')
GO
SET IDENTITY_INSERT [dbo].[tbl_tipolinea] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_tipousuario] ON 
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (1, N'Admin')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (2, N'Cliente')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (3, N'Doctor')
GO
SET IDENTITY_INSERT [dbo].[tbl_tipousuario] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_usuario] ON 
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (1, N'Martin', N'Aguirre', 1, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'11111111', N'admin@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (2, N'Juan', N'Marca', 2, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'22222222', N'cliente@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (3, N'Dr Luis', N'Ortiz', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'33333333', N'doc1@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (4, N'Dr Daniel', N'Espinoza', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'44444444', N'doc2@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (5, N'Dr Felipe', N'Ugarte', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'55555555', N'doc3@abc.com')
GO
SET IDENTITY_INSERT [dbo].[tbl_usuario] OFF
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T17:01:22.340' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T17:08:28.523' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T17:10:28.167' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T18:03:50.630' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T18:17:22.860' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T20:05:46.383' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T20:31:08.837' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T21:06:55.187' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:03:27.740' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:10:19.307' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:41:39.900' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:45:25.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:53:15.087' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T23:31:33.050' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-29T15:03:32.530' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-29T15:14:06.697' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-29T15:14:43.107' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:13:44.420' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:25:33.137' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:26:24.060' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:33:29.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:37:26.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-09T23:23:15.430' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-09T23:24:44.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-09T23:26:29.413' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:18:30.257' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:23:40.253' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:25:29.783' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:57:54.527' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T08:42:02.010' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T09:07:06.500' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T21:21:46.403' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:10:22.693' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:19:03.200' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:25:20.510' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:38:34.117' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T00:03:48.243' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T01:13:57.937' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T02:25:05.823' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T09:21:02.403' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T18:40:27.193' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-20T19:04:13.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T21:09:52.207' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T21:19:27.397' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T21:56:19.180' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T02:43:07.653' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T05:10:59.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:07:40.880' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:25:19.447' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:58:50.423' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:14:03.230' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:28:45.530' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:36:17.780' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:37:14.417' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:39:25.890' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:50:43.737' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:52:22.477' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:57:01.113' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T16:29:40.193' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T17:10:11.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T19:14:30.257' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T19:27:21.433' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T23:44:06.047' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T01:56:49.433' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T02:05:00.840' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T02:53:43.643' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T03:10:56.497' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T10:36:37.360' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T13:36:40.570' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T13:55:27.627' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:11:55.133' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:31:00.313' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:06:50.770' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:20:21.707' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:36:06.803' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:55:08.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T16:04:37.290' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T16:12:31.720' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T16:46:30.163' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:08:12.767' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:26:12.120' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:38:22.640' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:51:28.963' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T20:53:09.323' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T20:54:49.463' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:05:41.677' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:13:05.033' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:45:12.043' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:58:47.307' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:29:11.257' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:46:39.710' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:49:59.540' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T23:02:21.300' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T02:05:55.477' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T16:44:47.490' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T21:13:23.830' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:19:29.493' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:25:53.457' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:41:53.920' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:45:51.487' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T23:33:19.970' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:00:24.520' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:26:57.143' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:29:40.093' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:35:35.050' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:36:22.670' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:23:25.300' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:25:34.503' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:35:43.340' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:40:39.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:48:25.263' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T15:39:03.060' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T15:40:12.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T20:10:02.403' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T20:21:09.610' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:18:46.113' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:51:06.400' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:54:42.407' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:30:25.330' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:33:47.340' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:42:56.480' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:44:30.310' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:48:41.383' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:07:46.973' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2021-04-03T15:05:15.093' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2021-04-03T15:06:57.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:13:24.350' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:15:08.037' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:16:22.953' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:19:10.560' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:20:29.630' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:08:52.680' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:16:25.420' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T23:54:18.203' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:57:45.740' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:59:02.170' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T23:14:16.510' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T03:55:23.450' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T05:21:50.497' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:08:07.293' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T04:38:33.267' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:40:51.583' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:41:25.560' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:29:52.073' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:44:39.617' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T08:31:48.800' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T01:32:43.563' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T10:09:54.467' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T20:37:36.750' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T17:10:27.890' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T21:35:07.223' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T00:33:36.527' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T00:59:12.530' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T15:20:47.543' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T15:58:54.300' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T16:27:13.630' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T16:27:42.473' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T17:48:30.920' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:42:46.770' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:43:30.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:57:38.527' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T01:50:23.573' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-25T01:58:01.160' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T02:11:14.277' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-25T03:00:25.997' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T03:06:18.637' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T03:13:22.090' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T03:21:55.013' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:39:53.287' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:46:16.187' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:52:41.777' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T09:21:14.007' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T01:53:20.590' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T02:41:21.250' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T03:46:46.387' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T18:02:16.027' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T20:31:42.950' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T20:45:05.333' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T20:50:08.987' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:21:08.880' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T03:19:49.460' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T03:33:57.957' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T04:17:06.720' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T05:46:55.307' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:22:09.040' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:23:09.750' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:26:54.440' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:46:27.050' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:04:07.460' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T19:26:59.183' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T20:26:55.457' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T22:54:56.687' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T23:01:18.810' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T01:06:56.693' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T02:38:10.163' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T03:36:41.920' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T03:40:00.367' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:40:09.000' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:53:16.873' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:18:46.590' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T23:01:53.800' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T23:02:51.143' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T00:42:21.877' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T00:50:46.443' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T02:56:52.873' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T03:18:26.580' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:48:13.713' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T21:55:16.333' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:06:05.277' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T23:12:42.500' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T01:56:50.127' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:54:41.180' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:07:22.693' AS DateTime))
GO
ALTER TABLE [dbo].[tbl_cita] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[tbl_estados_cita] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[tbl_historial_paciente] ADD  CONSTRAINT [DF__tbl_histo__fecha__08B54D69]  DEFAULT (getdate()) FOR [fecha_registro]
GO
/****** Object:  StoredProcedure [dbo].[generar_backup_watson]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[generar_backup_watson]
as
begin
	set nocount on;

	declare @fecha char(8) = convert(char(8),getdate(),112);
	declare @hora varchar(8) = replace(convert(varchar(8), convert(time, getdate())), ':', '')

	declare @path varchar(100) = concat('D:\BACKS\', 'WATSON_BACKUP', '_', @fecha, '_', @hora, '.bak');

	backup database DB_WATSON
	to disk = @path
	with no_compression, name='DB_WATSON'

end
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_CONTRASEÑA]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_CONTRASEÑA]
(
	@usuario varchar(100),
	@password varchar(50),
	@nuevo_password varchar(50)
)
as
begin
	set nocount on;

	declare @error varchar(100) = '';

	update tbl_usuario set
		password = dbo.fn_EncriptarPassword(@nuevo_password)
	where email = @usuario;

	select
		'OK' 'validacion'

end
GO
/****** Object:  StoredProcedure [dbo].[sp_generar_ticket]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_generar_ticket]
AS
BEGIN

	select
		CONCAT('TK', RIGHT(CONCAT('0000000000',count(*) + 1),6)) 'codigo'
	from tbl_tickets

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CENTROS_ATENCION]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_CENTROS_ATENCION]
(
	@latitud varchar(20),
	@longitud varchar(20)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	if (select COUNT(*) from tbl_centros_atencion) = 0
	begin
		select
		0 id_centro_atencion,
		'' centro_atencion,
		'' direccion,
		'' horario,
		'No hay centros de atención registrados' validacion
	end
	else
	begin
		if @latitud = '0' and @longitud = '0'
		begin
			select
				id_centro_atencion,
				centro_atencion,
				direccion,
				horario,
				'OK' validacion
			from tbl_centros_atencion
		end
		else
		begin
			declare @latitud_ decimal(10,8) = cast(@latitud as decimal(10,8))
			declare @longitud_ decimal(10,8) = cast(@longitud as decimal(10,8))

			SELECT
				id_centro_atencion,
				centro_atencion,
				direccion,
				horario,
				'OK' validacion
			FROM tbl_centros_atencion
			ORDER BY
			ABS(ABS( cast(latitud as decimal(10,8)) - @latitud_) +
			ABS(cast(longitud as decimal(10,8)) - @longitud_))

		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_DOCTOR]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_CITAS_DOCTOR]
(
	@id_usuario int,
	@fecha varchar(10),
	@id_estado int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		c.id_cita,
		c.id_estado_cita,
		e.estado_cita 'estado',
		CONVERT(varchar(10), CONVERT(date, c.fecha_cita)) 'fecha_cita',
		REPLACE(REPLACE(RIGHT(CONCAT('0', CONVERT(varchar(15),c.hora_cita,100)), 7), 'PM', ' PM'), 'AM', ' AM') 'hora_cita',
		c.id_usuario,
		CONCAT(u.nombres, ' ', u.apellidos) 'usuario'
	FROM tbl_cita c
	INNER JOIN tbl_usuario u ON u.id_usuario = c.id_usuario
	INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita
	WHERE c.id_doctor_asignado = @id_usuario
	AND (@id_estado = -1 or c.id_estado_cita = @id_estado)
	AND (@fecha = '-' or convert(varchar(10), convert(date, c.fecha_cita)) = @fecha)

	ORDER BY fecha_cita, hora_cita

END


GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_USUARIO]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_CITAS_USUARIO]
(
	@id_usuario INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		c.id_cita,
		c.id_estado_cita,
		e.estado_cita 'estado',
		CONVERT(varchar(10), CONVERT(date, c.fecha_cita)) 'fecha_cita',
		REPLACE(REPLACE(RIGHT(CONCAT('0', CONVERT(varchar(15),c.hora_cita,100)), 7), 'PM', ' PM'), 'AM', ' AM') 'hora_cita',
		c.id_doctor_asignado,
		CONCAT(u.nombres, ' ', u.apellidos) 'doctor_asignado'
	FROM tbl_cita c
	INNER JOIN tbl_usuario u ON u.id_usuario = c.id_doctor_asignado
	INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita
	WHERE c.id_usuario = @id_usuario
	ORDER BY fecha_cita, hora_cita

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]
(
	@id_doctor int,
	@fecha varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @fecha_ date = convert(date, @fecha);

	declare @temp_horas table (
		hora_cita varchar(8),
		estado varchar(20)
	)

	insert into @temp_horas select '08:00 AM','';
	insert into @temp_horas select '09:00 AM','';
	insert into @temp_horas select '10:00 AM','';
	insert into @temp_horas select '11:00 AM','';
	insert into @temp_horas select '12:00 PM','';
	insert into @temp_horas select '01:00 PM','';
	insert into @temp_horas select '02:00 PM','';
	insert into @temp_horas select '03:00 PM','';
	insert into @temp_horas select '04:00 PM','';

	select
		t.hora_cita,
		case
			when c.id_cita is null then 'DISPONIBLE'
			else 'RESERVADO'
		end 'estado'
	from @temp_horas t
	left join tbl_cita c on c.id_doctor_asignado = @id_doctor and c.fecha_cita = @fecha_ and c.hora_cita = convert(time, convert(datetime, t.hora_cita, 0))
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DOCTORES]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_DOCTORES]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		id_usuario 'id_usuario',
		nombres + ' ' + apellidos 'nombres'
	FROM tbl_usuario
	WHERE id_tipousuario = 3
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from tbl_usuario

CREATE PROCEDURE [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]
(
	@id_usuario int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		h.id_historial,
		ISNULL(h.nota, '') 'nota',
		ISNULL(h.recomendacion, '') 'recomendacion',
		ISNULL(h.medicina, '') 'medicina',
		CONCAT(u.nombres,' ',u.apellidos) 'doctor',
		CONVERT(varchar(10), CONVERT(date, h.fecha_registro)) 'fecha_registro',
		REPLACE(REPLACE(RIGHT(CONCAT('0', CONVERT(varchar(15), h.hora_registro,100)), 7), 'PM', ' PM'), 'AM', ' AM') 'hora_registro'
	FROM tbl_historial_paciente h
	LEFT JOIN tbl_usuario u on u.id_usuario = h.id_doctor and u.id_tipousuario = 3
	WHERE h.id_paciente = @id_usuario
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_MENU]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_MENU]
(
	@id_usuario INT,
	@id_tipousuario INT
)
AS
BEGIN
  
	SET NOCOUNT ON;
   
	SELECT
		(select m2.opcion from tbl_menu m2 where m2.id_opcion = m1.id_padre) 'nombre_categoria',
		m1.opcion 'nombre_opcion',
		m1.url 'ruta_opcion',
		(select m2.icono from tbl_menu m2 where m2.id_opcion = m1.id_padre) 'icono',
		'' 'acceso_directo',
		'OK' 'validacion'
	FROM tbl_opciones_usuario ou
	inner join tbl_menu m1 on m1.id_opcion = ou.id_opcion

	where ou.id_usuario = @id_usuario
	and ou.id_tipousuario = @id_tipousuario
	and m1.id_padre <> '00'
	order by 1,2

END
GO
/****** Object:  StoredProcedure [dbo].[SP_PUNTOS_VISITADOS]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_PUNTOS_VISITADOS]
(
	@año int,
	@mes int
)
AS
BEGIN

	--declare @año int = 2020
	declare @tbl_meses table (orden int, num_mes int, mes varchar(50), tipo varchar(50), visitante varchar(50), total int)

	declare @i int = 1;
	declare @c1 int = 1;
	declare @c2 int = 2;
	declare @c3 int = 3;
	declare @c4 int = 4;
	while (@i < 13)
	begin
		insert into @tbl_meses select @c1, num_mes, mes, 'WHATSAPP', 'CLIENTE', 0 from tbl_meses where num_mes = @i;
		insert into @tbl_meses select @c2, num_mes, mes, 'WHATSAPP', 'NO CLIENTE', 0 from tbl_meses where num_mes = @i;
		insert into @tbl_meses select @c3, num_mes, mes, 'CALL-CENTER', 'CLIENTE', 0 from tbl_meses where num_mes = @i;
		insert into @tbl_meses select @c4, num_mes, mes, 'CALL-CENTER', 'NO CLIENTE', 0 from tbl_meses where num_mes = @i;

		set @i = @i + 1;
		set @c1 = @c1 + 4;
		set @c2 = @c2 + 4;
		set @c3 = @c3 + 4;
		set @c4 = @c4 + 4;
	end

	declare @j int = 1;
	while (@j < (select COUNT(*) + 1 from @tbl_meses))
	begin
		declare @tipo varchar(50);
		declare @visitante varchar(50);
		declare @num_mes int;
		declare @total int;

		select @tipo = tipo, @visitante = visitante, @num_mes = num_mes from @tbl_meses where orden = @j;

		select @total = count(*) from tbl_puntos_visitados
		where datepart(year,convert(date,fecha_visita)) = @año and visitante = @visitante and punto_visitado = @tipo and DATEPART(month,convert(date,fecha_visita)) = @num_mes;

		update @tbl_meses set total = @total
		where tipo = @tipo and visitante = @visitante and num_mes = @num_mes;

		set @j = @j + 1;
	end


	select * from @tbl_meses

END

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CITA]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_CITA]
(
	@id_cita int,
	@id_usuario int,
	@fecha_cita varchar(10),
	@hora_cita varchar(8),
	@id_doctor int
)
AS
BEGIN
	SET NOCOUNT ON;

	--SET @hora_cita = REPLACE(@hora_cita, ' PM', ':00 PM');
	--SET @hora_cita = REPLACE(@hora_cita, ' AM', ':00 AM');

	declare @estado_cita int = 1;
	declare @fecha_cita_ date = convert(date, @fecha_cita);
	declare @hora_cita_ time = convert(time, convert(datetime, @hora_cita, 0));
	declare @fecha_hora_cita_ datetime = CAST(@fecha_cita_ AS DATETIME) + CAST(@hora_cita_ AS DATETIME);

	declare @inicio time = convert(time, convert(datetime, '08:00 AM', 0));
	declare @fin time = convert(time, convert(datetime, '04:00 PM', 0));

	IF @fecha_hora_cita_ < GETDATE()
	BEGIN
		SELECT 'La fecha y hora seleccionados son incorrectos.' AS 'rpta';
	END
	ELSE
	BEGIN
		IF @hora_cita_ BETWEEN @inicio AND @fin
		BEGIN
			IF EXISTS (SELECT * FROM tbl_cita WHERE hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_usuario = @id_usuario)
			BEGIN
				SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
			END
			ELSE
			BEGIN

				IF @id_cita = 0
				BEGIN
					IF EXISTS (SELECT * FROM tbl_cita WHERE id_doctor_asignado = @id_doctor and hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita)
					BEGIN
						SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
					END
					ELSE
					BEGIN
						INSERT INTO tbl_cita (id_usuario, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita)
						VALUES (@id_usuario, @fecha_cita_, @hora_cita_, @id_doctor, @estado_cita);
						SELECT 'OK' AS 'rpta';
					END
				END
				ELSE
				IF @id_cita > 0
				BEGIN
					IF EXISTS (SELECT * FROM tbl_cita WHERE id_doctor_asignado = @id_doctor and hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita)
					BEGIN
						SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
					END
					ELSE
					BEGIN
						UPDATE tbl_cita SET
							fecha_cita = @fecha_cita_,
							hora_cita = @hora_cita_,
							id_doctor_asignado = @id_doctor
						WHERE id_cita = @id_cita;

						SELECT 'OK' AS 'rpta';
					END
				END

			END
		END
		ELSE
		BEGIN
			SELECT 'El registro de citas debe ser entre las 08:00 AM y 04:00 PM.' AS 'rpta';
		END
	END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_FLUJO]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_REGISTRAR_FLUJO]
(
	@id_usuario int,
	@tipo varchar(50),
	@remitente varchar(20),
	@contenido_texto nvarchar(max),
	@contenido_html nvarchar(max)
)
AS
BEGIN

	if @remitente = 'bot'
	begin
		if (@contenido_texto = 'Gracias! Por su preferencia')
		begin
			insert into tbl_resumen_flujo values (@id_usuario, 'GRACIAS');
		end
		else
		if (@contenido_texto like '%' + 'ticket de seguimiento' + '%')
		begin
			insert into tbl_resumen_flujo values (@id_usuario, 'TICKET');
		end
		else
		if (@contenido_texto = 'En este momento procedo a llamar al Call Center')
		begin
			insert into tbl_resumen_flujo values (@id_usuario, 'CALL CENTER');
		end
	end

	insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
	values (@id_usuario, @tipo, @contenido_texto, @contenido_html, 1, @remitente);

	select 'OK' 'rpta';

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]
(
	@id_paciente int,
	@nota varchar(500),
	@recomendacion varchar(500),
	@medicina varchar(500),
	@id_doctor int,
	@id_cita int
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @id_estado_cita INT = (SELECT id_estado_cita FROM tbl_cita WHERE id_cita = @id_cita);

	IF @id_estado_cita = 1
	BEGIN
		
		UPDATE tbl_cita SET id_estado_cita = 2 WHERE id_cita = @id_cita;

		declare @fecha date = convert(date,getdate());
		declare @hora time = convert(time,getdate());

		INSERT INTO tbl_historial_paciente (id_paciente, nota, recomendacion, medicina, id_doctor, fecha_registro, hora_registro)
		VALUES (@id_paciente, @nota, @recomendacion, @medicina, @id_doctor, @fecha, @hora)

		SELECT 'OK' AS 'rpta';

	END
	ELSE
	BEGIN
		SELECT 'La cita ya ha sido atendida.' AS 'res';
	END	
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_INVITADO]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_REGISTRAR_INVITADO]
(
	@linea varchar(20),
	@id_tipolinea int
)
AS
BEGIN

	declare @id_invitado int = 0;

	if exists (select * from tbl_invitados where linea = @linea and id_tipolinea = @id_tipolinea)
	begin
		select @id_invitado = id_invitado from tbl_invitados where linea = @linea and id_tipolinea = @id_tipolinea;
	end
	else
	begin
		
		insert into tbl_invitados select @linea, @id_tipolinea;
		set @id_invitado = @@IDENTITY;

		declare @nuevo_contenido_html nvarchar(max) = '<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,getdate()),5) + '</div></li>';

		insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
		values (@id_invitado, 'text', 'Hola, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');
	end

	select @id_invitado 'id_invitado'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTO_VISITADO]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_REGISTRAR_PUNTO_VISITADO]
(
	@id_tipousuario INT,
	@punto_visitado VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @visitante VARCHAR(50)

	if @id_tipousuario = 0
	begin
		set @visitante = 'NO CLIENTE'
	end
	else
	begin
		set @visitante = 'CLIENTE'
	end
	
	insert into tbl_puntos_visitados
	values (@punto_visitado, @visitante, getdate())

	select 'OK' 'rpta'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTUACION]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_REGISTRAR_PUNTUACION]
(
	@id_usuario int,
	@puntuacion int
)
AS
BEGIN

	declare @hora varchar(8) = convert(varchar(8),convert(time,getdate()))
	declare @fecha varchar(10) = convert(date,getdate())

	declare @resultado varchar(20) = case when @puntuacion between 1 and 6 then 'Detractor' when @puntuacion between 7 and 8 then 'Pasivo' else 'Promotor' end;

	insert into tbl_encuesta select @id_usuario, @puntuacion, @hora, @fecha, @resultado;

	update tbl_flujos set
		habilitado = 0
	where id_usuario = @id_usuario;

	declare @nuevo_contenido_html nvarchar(max) = '<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola otra vez, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,getdate()),5) + '</div></li>';

	insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
	values (@id_usuario, 'text', 'Hola otra vez, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');

	select 'OK' 'rpta';

ENd
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_TICKET]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_REGISTRAR_TICKET]
(
	@codigo varchar(50),
	@id_usuario int,
	@estado varchar(50)
)
AS
BEGIN

	insert into tbl_tickets (codigo, id_usuario, estado)
	values (@codigo, @id_usuario, @estado);

	select 'OK' 'rpta';

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_USUARIO]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_REGISTRAR_USUARIO]
(
	@nombres varchar(100),
	@apellidos varchar(100),
	@id_tipousuario int,
	@tipo_documento varchar(50),
	@num_documento varchar(20),
	@linea varchar(9),
	@id_tipolinea int
)
AS
BEGIN
	
	declare @rpta varchar(100);
	declare @id_usuario int;

	--if exists(select * from tbl_usuario where tipo_documento = @tipo_documento and num_documento = @num_documento)
	--begin
	--	set @rpta = 'El documento ingresado ya se encuentra registrado';
	--end
	--else
	--begin
	--	if exists(select * from tbl_linea where linea = @linea and id_tipolinea = @id_tipolinea)
	--	begin
	--		set @rpta = 'La línea ingresada ya se encuentra registrada';
	--	end
	--	else
	--	begin
	--		insert into tbl_usuario select @nombres, @apellidos, @id_tipousuario, '', null, 1, @tipo_documento, @num_documento;
	--		set @id_usuario = @@IDENTITY;

	--		declare @nuevo_contenido_html nvarchar(max) = '<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,getdate()),5) + '</div></li>';

	--		insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
	--		values (@id_usuario, 'text', 'Hola, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');

	--		insert into tbl_linea select @linea, @id_tipolinea, @id_usuario, 1;
	--		set @rpta = 'OK'
	--	end
	--end

	select @rpta 'rpta'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_VISITA]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_VISITA]
(
	@id_tipousuario INT
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @visitante VARCHAR(50)

	if @id_tipousuario = 0
	begin
		set @visitante = 'NO CLIENTE'
	end
	else
	begin
		set @visitante = 'CLIENTE'
	end

	insert into tbl_visitas values (@visitante, GETDATE())

	SELECT 'OK' 'rpta'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_NPS]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_RESULTADOS_NPS]
(
	@año int,
	@mes int
)
AS
BEGIN

	declare @total int = (select count(*) from tbl_encuesta where DATEPART(year,convert(date,fecha)) = @año);
	declare @total_flujo int = (select count(*) from tbl_resumen_flujo);

	declare @nps_objetivo numeric(10,2) = 85.00;

	declare @temp_resultados table ( total_entero int, total_porcentaje numeric(10,2), resultado varchar(20) )
	declare @temp_resultados_flujo table ( total_entero int, total_porcentaje numeric(10,2), resultado varchar(20) )

	insert into @temp_resultados
	select
		count(*) total_entero,
		convert(numeric(10,2), convert(numeric(10,2), count(*)) / convert(numeric(10,2), @total) * 100 ) total_porcentaje,
		resultado
	from tbl_encuesta group by resultado

	if not exists (select * from @temp_resultados where resultado = 'Detractor')
	begin
		insert into @temp_resultados select 0,0.00,'Detractor'
	end

	if not exists (select * from @temp_resultados where resultado = 'Pasivo')
	begin
		insert into @temp_resultados select 0,0.00,'Pasivo'
	end

	if not exists (select * from @temp_resultados where resultado = 'Promotor')
	begin
		insert into @temp_resultados select 0,0.00,'Promotor'
	end
	
	insert into @temp_resultados_flujo
	select
		count(*) total_entero,
		convert(numeric(10,2), convert(numeric(10,2), count(*)) / convert(numeric(10,2), @total_flujo) * 100 ) total_porcentaje,
		resultado
	from tbl_resumen_flujo
	group by resultado

	if not exists (select * from @temp_resultados_flujo where resultado = 'TICKET')
	begin
		insert into @temp_resultados_flujo select 0,0.00,'TICKET';
	end

	if not exists (select * from @temp_resultados_flujo where resultado = 'GRACIAS')
	begin
		insert into @temp_resultados_flujo select 0,0.00,'GRACIAS';
	end

	if not exists (select * from @temp_resultados_flujo where resultado = 'CALL CENTER')
	begin
		insert into @temp_resultados_flujo select 0,0.00,'CALL CENTER';
	end

	select
		total_entero,
		total_porcentaje,
		resultado
	from @temp_resultados
	union all
	select
		@total,
		100.00,
		'Total general'
	union all
	select
		0,
		@nps_objetivo,
		'NPS Objetivo'
	union all
	select
		Convert(int, (select total_entero from @temp_resultados where resultado = 'Promotor')) - Convert(int, (select total_entero from @temp_resultados where resultado = 'Detractor')),
		convert(numeric(11,2), convert(numeric(11,2), (select total_porcentaje from @temp_resultados where resultado = 'Promotor')) - convert(numeric(11,2), (select total_porcentaje from @temp_resultados where resultado = 'Detractor'))),
		'NPS Real'
	--select
	--	0,
	--	convert(numeric(10,2), convert(numeric(10,2), count(*)) / convert(numeric(10,2), (case when @total = 0 then 1 else @total end)) * 100 ) total_porcentaje,
	--	'NPS Real'
	--from tbl_encuesta where resultado <> 'Promotor'
	union all
	select * from @temp_resultados_flujo

END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_FLUJO_ACTUAL]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_VALIDAR_FLUJO_ACTUAL]
(
	@id_usuario int
)
AS
BEGIN

	select --top 1
		*
	from tbl_flujos
	where id_usuario = @id_usuario
	and habilitado = 1
	--order by 1 desc

END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_USUARIO]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC SP_VALIDAR_USUARIO 'admin@abc.com','123';
CREATE PROCEDURE [dbo].[SP_VALIDAR_USUARIO]
(
	@usuario varchar(100),
	@password varchar(50)
)
as
begin
	set nocount on;

	declare @error varchar(100) = '';

	if exists (select * from tbl_usuario where email = @usuario)
	begin
		if (select dbo.fn_DesencriptarPassword(password) from tbl_usuario where email = @usuario) = @password
		begin
			if (select habilitado from tbl_usuario where email = @usuario and dbo.fn_DesencriptarPassword(password) = @password) = 1
			begin
				set @error = ''
			end
			else
			begin
				set @error = 'El usuario no se encuentra habilitado'
			end
		end
		else
		begin
			set @error = 'Credenciales incorrectas'
		end
	end
	else
	begin
		set @error = 'El usuario no se encuentra registrado'
	end

	if @error = ''
	begin
		select
			u.id_usuario,
			u.nombres,
			u.apellidos,
			u.id_tipousuario,
			tu.tipousuario,
			u.tipo_documento,
			u.num_documento,
			'OK' 'validacion'
		from tbl_usuario u
		inner join tbl_tipousuario tu on tu.id_tipousuario = u.id_tipousuario
		where u.email = @usuario
		and dbo.fn_DesencriptarPassword(u.password) = @password
	end
	else
	begin
		select
			0 id_usuario,
			'' nombres,
			'' apellidos,
			0 id_tipousuario,
			'' tipousuario,
			'' tipo_documento,
			'' num_documento,
			@error 'validacion'
	end

end
GO
/****** Object:  StoredProcedure [dbo].[SP_VISITAS]    Script Date: 08/09/2022 1:27:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_VISITAS]
(
	@año int,
	@mes int
)
AS
BEGIN

	declare @tbl_meses table (orden int, num_mes int, mes varchar(50), tipo varchar(50), visitante varchar(50), total int)

declare @i int = 1;
declare @c1 int = 1;
declare @c2 int = 2;
declare @c3 int = 3;
declare @c4 int = 4;
while (@i < 13)
begin
	insert into @tbl_meses select @c1, num_mes, mes, '', 'CLIENTE', 0 from tbl_meses where num_mes = @i;
	insert into @tbl_meses select @c2, num_mes, mes, '', 'NO CLIENTE', 0 from tbl_meses where num_mes = @i;

	set @i = @i + 1;
	set @c1 = @c1 + 2;
	set @c2 = @c2 + 2;
end

declare @j int = 1;
while (@j < (select COUNT(*) + 1 from @tbl_meses))
begin
	declare @tipo varchar(50);
	declare @visitante varchar(50);
	declare @num_mes int;
	declare @total int;

	select @visitante = visitante, @num_mes = num_mes from @tbl_meses where orden = @j;

	select @total = count(*) from tbl_visitas
	where datepart(year,convert(date,fecha_visita)) = @año and visitante = @visitante and DATEPART(month,convert(date,fecha_visita)) = @num_mes;

	update @tbl_meses set total = @total
	where visitante = @visitante and num_mes = @num_mes;

	set @j = @j + 1;
end

select * from @tbl_meses
	
END
GO
