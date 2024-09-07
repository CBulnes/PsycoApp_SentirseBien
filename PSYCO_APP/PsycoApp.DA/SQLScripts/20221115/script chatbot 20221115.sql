USE [DB_TEA]
GO
/****** Object:  StoredProcedure [dbo].[SP_VISITAS]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_VISITAS]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_USUARIO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_VALIDAR_USUARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_FLUJO_ACTUAL]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_VALIDAR_FLUJO_ACTUAL]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_NPS]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_RESULTADOS_NPS]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_VISITA]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_VISITA]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_USUARIO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_USUARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_TICKET]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_TICKET]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTUACION]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_PUNTUACION]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTO_VISITADO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_PUNTO_VISITADO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_INVITADO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_INVITADO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_FLUJO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_FLUJO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_ESTADO_CUESTIONARIO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_ESTADO_CUESTIONARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CUESTIONARIO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_CUESTIONARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CITA]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_REGISTRAR_CITA]
GO
/****** Object:  StoredProcedure [dbo].[SP_PUNTOS_VISITADOS]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_PUNTOS_VISITADOS]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_MENU]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_MENU]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_ENCUESTAS]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_ENCUESTAS]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DOCTORES]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_DOCTORES]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_USUARIO]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_CITAS_USUARIO]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_DOCTOR]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_CITAS_DOCTOR]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CENTROS_ATENCION]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_LISTAR_CENTROS_ATENCION]
GO
/****** Object:  StoredProcedure [dbo].[sp_generar_ticket]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[sp_generar_ticket]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_CONTRASEÑA]    Script Date: 15/11/2022 1:11:16 ******/
DROP PROCEDURE [dbo].[SP_ACTUALIZAR_CONTRASEÑA]
GO
/****** Object:  Table [dbo].[tbl_visitas]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_visitas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_visitas]
GO
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_usuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_usuario]
GO
/****** Object:  Table [dbo].[tbl_tipousuario]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tipousuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_tipousuario]
GO
/****** Object:  Table [dbo].[tbl_tipolinea]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tipolinea]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_tipolinea]
GO
/****** Object:  Table [dbo].[tbl_tickets]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_tickets]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_tickets]
GO
/****** Object:  Table [dbo].[tbl_resumen_flujo]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_resumen_flujo]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_resumen_flujo]
GO
/****** Object:  Table [dbo].[tbl_puntos_visitados]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_puntos_visitados]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_puntos_visitados]
GO
/****** Object:  Table [dbo].[tbl_opciones_usuario]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_opciones_usuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_opciones_usuario]
GO
/****** Object:  Table [dbo].[tbl_meses]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_meses]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_meses]
GO
/****** Object:  Table [dbo].[tbl_menu]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_menu]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_menu]
GO
/****** Object:  Table [dbo].[tbl_invitados]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_invitados]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_invitados]
GO
/****** Object:  Table [dbo].[tbl_historial_paciente]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_historial_paciente]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_historial_paciente]
GO
/****** Object:  Table [dbo].[tbl_flujos]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_flujos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_flujos]
GO
/****** Object:  Table [dbo].[tbl_estados_cita]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_estados_cita]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_estados_cita]
GO
/****** Object:  Table [dbo].[tbl_encuesta]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_encuesta]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_encuesta]
GO
/****** Object:  Table [dbo].[tbl_cita]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_cita]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_cita]
GO
/****** Object:  Table [dbo].[tbl_centros_atencion]    Script Date: 15/11/2022 1:11:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_centros_atencion]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_centros_atencion]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_EncriptarPassword]    Script Date: 15/11/2022 1:11:16 ******/
DROP FUNCTION [dbo].[fn_EncriptarPassword]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DesencriptarPassword]    Script Date: 15/11/2022 1:11:16 ******/
DROP FUNCTION [dbo].[fn_DesencriptarPassword]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DesencriptarPassword]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_EncriptarPassword]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_centros_atencion]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_cita]    Script Date: 15/11/2022 1:11:16 ******/
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
	[tipo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_encuesta]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_estados_cita]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_flujos]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_historial_paciente]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_invitados]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_menu]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_meses]    Script Date: 15/11/2022 1:11:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_meses](
	[num_mes] [int] NULL,
	[mes] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_opciones_usuario]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_puntos_visitados]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_resumen_flujo]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_tickets]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_tipolinea]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_tipousuario]    Script Date: 15/11/2022 1:11:16 ******/
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
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 15/11/2022 1:11:16 ******/
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
	[test_actual] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_visitas]    Script Date: 15/11/2022 1:11:16 ******/
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
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro], [tipo]) VALUES (1, 2, CAST(N'2022-09-28' AS Date), CAST(N'10:00:00' AS Time), 4, 2, CAST(N'2022-09-28T09:53:04.823' AS DateTime), N'CITA')
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro], [tipo]) VALUES (2, 2, CAST(N'2022-09-29' AS Date), CAST(N'13:00:00' AS Time), 4, 1, CAST(N'2022-09-28T09:53:26.367' AS DateTime), N'CITA')
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro], [tipo]) VALUES (26, 2, CAST(N'2022-10-18' AS Date), NULL, 2, 2, CAST(N'2022-10-17T23:05:15.700' AS DateTime), N'CUESTIONARIO')
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro], [tipo]) VALUES (27, 2, CAST(N'2022-10-18' AS Date), CAST(N'08:00:00' AS Time), 3, 1, CAST(N'2022-10-17T23:22:25.763' AS DateTime), N'CITA')
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro], [tipo]) VALUES (28, 2, CAST(N'2022-10-19' AS Date), NULL, 0, 1, CAST(N'2022-10-18T18:11:38.143' AS DateTime), N'CUESTIONARIO')
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro], [tipo]) VALUES (30, 2, CAST(N'2022-11-14' AS Date), CAST(N'08:00:00' AS Time), 5, 1, CAST(N'2022-11-11T18:08:47.967' AS DateTime), N'CITA')
GO
SET IDENTITY_INSERT [dbo].[tbl_cita] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_encuesta] ON 
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (1, 2, 7, N'14:26:02', N'2022-10-15', N'Nulo')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (2, 2, 7, N'14:26:02', N'2022-09-14', N'Detractor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (3, 2, 7, N'14:26:02', N'2022-09-01', N'Detractor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (4, 2, 7, N'14:26:02', N'2022-09-01', N'Detractor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (5, 2, 4, N'15:17:49', N'2022-10-15', N'Detractor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (6, 2, 3, N'15:57:22', N'2022-10-15', N'Detractor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (7, 2, 8, N'14:52:41', N'2022-10-16', N'Nulo')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (8, 2, 7, N'22:43:15', N'2022-10-17', N'Nulo')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (9, 2, 10, N'23:05:36', N'2022-10-17', N'Promotor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (10, 2, 3, N'18:11:49', N'2022-10-18', N'Detractor')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (11, 2, 7, N'21:50:54', N'2022-11-03', N'Nulo')
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (12, 2, 6, N'21:56:07', N'2022-11-03', N'Detractor')
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
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (932, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">22:55</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (933, 2, N'options_title', N'Hola somos el asistente virtual de la clinica ingrese la edad del paciente.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Hola somos el asistente virtual de la clinica ingrese la edad del paciente.</div></div></div><div class="chat-time">22:56</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (934, 2, N'option', N'16-30 Meses', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario1'',''16-30 Meses'')"><div class="box bg-light-info">16-30 Meses</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (935, 2, N'text', N'16-30 Meses', N'<li class="reverse"><div class="chat-time">22:56</div><div class="chat-content"><div class="box bg-light-inverse">16-30 Meses</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (936, 2, N'options_title', N'Se tomara el cuestionario para niños de 16 a 30 meses de edad.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Se tomara el cuestionario para niños de 16 a 30 meses de edad.</div></div></div><div class="chat-time">22:56</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (937, 2, N'option', N'Empezar', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''TPregunta1'',''Empezar'')"><div class="box bg-light-info">Empezar</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (938, 2, N'text', N'Empezar', N'<li class="reverse"><div class="chat-time">22:56</div><div class="chat-content"><div class="box bg-light-inverse">Empezar</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (939, 2, N'options_title', N'1.Si usted señala algo al otro lado de la habitación,¿suhijo/alomira?(POREJEMPLO, Siusted señala a un juguete, un peluche o un animal, ¿su hijo/a lo mira?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">1.Si usted señala algo al otro lado de la habitación,¿suhijo/alomira?(POREJEMPLO, Siusted señala a un juguete, un peluche o un animal, ¿su hijo/a lo mira?)</div></div></div><div class="chat-time">22:56</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (940, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (941, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">22:56</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (942, 2, N'options_title', N'2.¿Alguna vez se ha preguntado si su hijo/a es sordo/a?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">2.¿Alguna vez se ha preguntado si su hijo/a es sordo/a?</div></div></div><div class="chat-time">22:56</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (943, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (944, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">22:56</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (945, 2, N'options_title', N'3. ¿Su hijo/a juega juegos de fantasía o imaginación? (POR EJEMPLO, “hace como que” bebe de una taza vacía, habla por teléfono o da de comer a una muñeca o peluche,…) ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">3. ¿Su hijo/a juega juegos de fantasía o imaginación? (POR EJEMPLO, “hace como que” bebe de una taza vacía, habla por teléfono o da de comer a una muñeca o peluche,…) </div></div></div><div class="chat-time">22:56</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (946, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta4'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta4'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (947, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (948, 2, N'options_title', N'4.¿A su hijo le gusta subirse cosas?(POR EJEMPLO, a una silla, escaleras, y tobogán,…) ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">4.¿A su hijo le gusta subirse cosas?(POR EJEMPLO, a una silla, escaleras, y tobogán,…) </div></div></div><div class="chat-time">23:03</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (949, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta5'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta5'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (950, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (951, 2, N'options_title', N'5. ¿Hace su hijo/a movimientos inusuales con sus dedos cerca de sus ojos? (POR EJEMPLO, mueve sus dedos cerca de sus ojos de manera inusual?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">5. ¿Hace su hijo/a movimientos inusuales con sus dedos cerca de sus ojos? (POR EJEMPLO, mueve sus dedos cerca de sus ojos de manera inusual?)</div></div></div><div class="chat-time">23:03</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (952, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta6'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta6'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (953, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (954, 2, N'options_title', N'6.¿Su Hijo/a señala con un dedo cuando quiere pedir algo o pedir ayuda?(POR EJEMPLO, señala un juguete o algo de comer que está fuera de su alcance?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">6.¿Su Hijo/a señala con un dedo cuando quiere pedir algo o pedir ayuda?(POR EJEMPLO, señala un juguete o algo de comer que está fuera de su alcance?)</div></div></div><div class="chat-time">23:03</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (955, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta7'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta7'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (956, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (957, 2, N'options_title', N'7.Su hijo/a señala con un dedo cuando quiere mostrarle algo que le llama la atención?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">7.Su hijo/a señala con un dedo cuando quiere mostrarle algo que le llama la atención?</div></div></div><div class="chat-time">23:03</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (958, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta8'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta8'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (959, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (960, 2, N'options_title', N'8. ¿Su hijo/a se interesa en otros niños? (POR EJEMPLO, mira con atención a otros niños, les sonríe o se les acerca?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">8. ¿Su hijo/a se interesa en otros niños? (POR EJEMPLO, mira con atención a otros niños, les sonríe o se les acerca?)</div></div></div><div class="chat-time">23:03</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (961, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta9'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta9'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (962, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (963, 2, N'options_title', N'9 . ¿Su hijo/a le muestra cosas acercándolas o levantándolas para que usted las vea – no para pedir ayuda sino solamente para compartirlas con usted? (POR EJEMPLO, le muestra una flor o un peluche o un carrito de juguete)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">9 . ¿Su hijo/a le muestra cosas acercándolas o levantándolas para que usted las vea – no para pedir ayuda sino solamente para compartirlas con usted? (POR EJEMPLO, le muestra una flor o un peluche o un carrito de juguete)</div></div></div><div class="chat-time">23:03</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (964, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta10'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta10'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (965, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:03</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (966, 2, N'options_title', N'10.¿Su hijo/a responde cuando usted le llama por su nombre? (POREJEMPLO,sevuelve,habla o balbucea, o deja de hacer lo que estaba haciendo para mirarle?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">10.¿Su hijo/a responde cuando usted le llama por su nombre? (POREJEMPLO,sevuelve,habla o balbucea, o deja de hacer lo que estaba haciendo para mirarle?)</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (967, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta11'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta11'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (968, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (969, 2, N'options_title', N'11.¿Cuándo usted sonríe hijo/a, él o ella también sonríe?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">11.¿Cuándo usted sonríe hijo/a, él o ella también sonríe?</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (970, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta12'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta12'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (971, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (972, 2, N'options_title', N'12. ¿Le molestan a su hijo/a ruidos cotidianos? (¿POR EJEMPLO, la aspiradora, secador de cabello, licuadora, máquina de cortar césped?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">12. ¿Le molestan a su hijo/a ruidos cotidianos? (¿POR EJEMPLO, la aspiradora, secador de cabello, licuadora, máquina de cortar césped?</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (973, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta13'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta13'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (974, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (975, 2, N'options_title', N'13. ¿Su hijo/a camina solo? ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">13. ¿Su hijo/a camina solo? </div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (976, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta14'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta14'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (977, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (978, 2, N'options_title', N'14.¿Su hijo/a le mira a los ojos cuando usted le habla,juega con él o ella,o lo viste? ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">14.¿Su hijo/a le mira a los ojos cuando usted le habla,juega con él o ella,o lo viste? </div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (979, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta15'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta15'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (980, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (981, 2, N'options_title', N'15.¿Su hijo/a imita tus movimientos?(POR EJEMPLO,decir adiós con lamano,aplaudir o algún ruido gracioso que usted haga?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">15.¿Su hijo/a imita tus movimientos?(POR EJEMPLO,decir adiós con lamano,aplaudir o algún ruido gracioso que usted haga?)</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (982, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta16'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta16'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (983, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (984, 2, N'options_title', N'16.. Si usted se gira a veralgo , ¿su hijo/a trata de mirar hacia lo que ustedes miran?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">16.. Si usted se gira a veralgo , ¿su hijo/a trata de mirar hacia lo que ustedes miran?</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (985, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta17'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta17'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (986, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (987, 2, N'options_title', N'17. ¿Su hijo/a intenta que usted le mire/preste atención? (POR EJEMPLO, busca que  usted le haga un cumplido, le diga palabras cariñosas, o le dice “mira” ó "mírame") ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">17. ¿Su hijo/a intenta que usted le mire/preste atención? (POR EJEMPLO, busca que  usted le haga un cumplido, le diga palabras cariñosas, o le dice “mira” ó "mírame") </div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (988, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta18'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta18'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (989, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (990, 2, N'options_title', N'18.¿Su hijo/a le entiende cuando usted le dice que haga algo? (POR EJEMPLO, si usted no hace gestos, ¿su hijo/a entiende “pon el libro encima de la silla” o “tráeme la manta/sábana”?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">18.¿Su hijo/a le entiende cuando usted le dice que haga algo? (POR EJEMPLO, si usted no hace gestos, ¿su hijo/a entiende “pon el libro encima de la silla” o “tráeme la manta/sábana”?)</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (991, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta19'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta19'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (992, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (993, 2, N'options_title', N'19.Si algo nuevo pasa, ¿su hijo/a le mira para ver como usted reacciona alrespecto?(POR EJEMPLO, si oye un ruido extraño o ve un juguete nuevo, ¿se gira a ver su cara?)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">19.Si algo nuevo pasa, ¿su hijo/a le mira para ver como usted reacciona alrespecto?(POR EJEMPLO, si oye un ruido extraño o ve un juguete nuevo, ¿se gira a ver su cara?)</div></div></div><div class="chat-time">23:04</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (994, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta20'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''Tpregunta20'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (995, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:04</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (996, 2, N'options_title', N'20.Le gustan a su hijo/a los juegos de movimiento?(POR EJEMPLO , le gusta que le balancee ,o que le haga “el caballito” sentándole en sus rodillas)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">20.Le gustan a su hijo/a los juegos de movimiento?(POR EJEMPLO , le gusta que le balancee ,o que le haga “el caballito” sentándole en sus rodillas)</div></div></div><div class="chat-time">23:05</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (997, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''TpreguntaFinal'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''TpreguntaFinal'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (998, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:05</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (999, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1000, 2, N'text', N'Muy bien se agendó un nuevo test de evaluación, a partir de mañana podrá realizarlo', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Muy bien se agendó un nuevo test de evaluación, a partir de mañana podrá realizarlo</div></div><div class="chat-time">23:05</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1001, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1002, 2, N'options_title', N'Bienvenido al cuestionario 2 para poder empezar por favor marque la opción comenzar.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Bienvenido al cuestionario 2 para poder empezar por favor marque la opción comenzar.</div></div></div><div class="chat-time">23:05</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1003, 2, N'option', N'Comenzar', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2pregunta1'',''Comenzar'')"><div class="box bg-light-info">Comenzar</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1004, 2, N'text', N'Comenzar', N'<li class="reverse"><div class="chat-time">23:05</div><div class="chat-content"><div class="box bg-light-inverse">Comenzar</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1005, 2, N'options_title', N'1. Si usted señala algo al otro lado de la habitación, ¿su hijo/a lo mira? (POR EJEMPLO, Si usted señala a un juguete, un peluche o un animal ,¿su hijo/a lo mira?) P', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">1. Si usted señala algo al otro lado de la habitación, ¿su hijo/a lo mira? (POR EJEMPLO, Si usted señala a un juguete, un peluche o un animal ,¿su hijo/a lo mira?) P</div></div></div><div class="chat-time">23:05</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1006, 2, N'option', N'Pasa,No Pasa', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta1'',''Pasa'')"><div class="box bg-light-info">Pasa</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1'',''No Pasa'')"><div class="box bg-light-info">No Pasa</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1007, 2, N'text', N'Pasa', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">Pasa</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1008, 2, N'options_title', N'Por favor deme un ejemplo de cómo responde si usted señala a algo (Si el padre no responde con uno de los ejemplos Positivos pregunte cada uno individualmente) , Mira el objeto?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor deme un ejemplo de cómo responde si usted señala a algo (Si el padre no responde con uno de los ejemplos Positivos pregunte cada uno individualmente) , Mira el objeto?</div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1009, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1010, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1011, 2, N'options_title', N'Señala al objeto ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Señala al objeto </div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1012, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1013, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1014, 2, N'options_title', N'¿Qué hace su hijo/a normalmente cuando usted señala a algo?,  Ignora al padre?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Qué hace su hijo/a normalmente cuando usted señala a algo?,  Ignora al padre?</div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1015, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1016, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1017, 2, N'options_title', N'Mira alrededor de la habitación', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Mira alrededor de la habitación</div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1018, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1019, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1020, 2, N'options_title', N'Mira el dedo al padre', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Mira el dedo al padre</div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1021, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2pregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2pregunta2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1022, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1023, 2, N'options_title', N'Mira y dice algo sobre el objeto', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Mira y dice algo sobre el objeto</div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1024, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta4'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1025, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:06</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1026, 2, N'options_title', N'Mira si el padre señala y dice “mira!”', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Mira si el padre señala y dice “mira!”</div></div></div><div class="chat-time">23:06</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1027, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2Pregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1028, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1029, 2, N'options_title', N'2. ¿Usted ha dicho que se han preguntado si su hijo es sordo ¿Qué le llevó a preguntarme eso?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">2. ¿Usted ha dicho que se han preguntado si su hijo es sordo ¿Qué le llevó a preguntarme eso?</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1030, 2, N'option', N'Pasa,No Pasa', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta1_P2'',''Pasa'')"><div class="box bg-light-info">Pasa</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta1_P2'',''No Pasa'')"><div class="box bg-light-info">No Pasa</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1031, 2, N'text', N'No Pasa', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">No Pasa</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1032, 2, N'options_title', N'¿A menudo ignora los sonidos?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿A menudo ignora los sonidos?</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1033, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta2_P2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta2_P2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1034, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1035, 2, N'options_title', N'¿A menudo ignora a la gente?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿A menudo ignora a la gente?</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1036, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1_P2'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1_P2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1037, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1038, 2, N'options_title', N'¿Se ha evaluado la audición de su hijo/a?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Se ha evaluado la audición de su hijo/a?</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1039, 2, N'option', N'Sí,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2_P2'',''Sí'')"><div class="box bg-light-info">Sí</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2_P2'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1040, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1041, 2, N'options_title', N'¿Cuáles fueron los resultados de la prueba de audición? (elija uno):', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Cuáles fueron los resultados de la prueba de audición? (elija uno):</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1042, 2, N'option', N'Audición normal,Audición por debajo de lo normal,Resultados no concluyentes', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2Pregunta3'',''Audición normal'')"><div class="box bg-light-info">Audición normal</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2Pregunta3'',''Audición por debajo de lo normal'')"><div class="box bg-light-info">Audición por debajo de lo normal</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2Pregunta3'',''Resultados no concluyentes'')"><div class="box bg-light-info">Resultados no concluyentes</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1043, 2, N'text', N'Audición normal', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">Audición normal</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1044, 2, N'options_title', N'3. ¿Su hijo/a juega juegos de fantasía o imaginación? ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">3. ¿Su hijo/a juega juegos de fantasía o imaginación? </div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1045, 2, N'option', N'Pasa,No Pasa', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta1_P3'',''Pasa'')"><div class="box bg-light-info">Pasa</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1_P3'',''No Pasa'')"><div class="box bg-light-info">No Pasa</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1046, 2, N'text', N'Pasa', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">Pasa</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1047, 2, N'options_title', N'Por favor déme un ejemplo de los juegos imaginativos de su hijo/a ,  ¿Finge beber de una taza de juguete?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor déme un ejemplo de los juegos imaginativos de su hijo/a ,  ¿Finge beber de una taza de juguete?</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1048, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1049, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:07</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1050, 2, N'options_title', N'¿Finge comer con una cuchara o tenedor de juguete?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Finge comer con una cuchara o tenedor de juguete?</div></div></div><div class="chat-time">23:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1051, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1052, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1053, 2, N'options_title', N'¿Finge hablar por teléfono?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Finge hablar por teléfono?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1054, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta4_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta4_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1055, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1056, 2, N'options_title', N'¿Finge dar de comer a un muñeco con comida de juguete o de verdad? ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Finge dar de comer a un muñeco con comida de juguete o de verdad? </div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1057, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta5_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta5_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1058, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1059, 2, N'options_title', N'¿Empuja un coche haciendo como que va por una carretera imaginaria?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Empuja un coche haciendo como que va por una carretera imaginaria?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1060, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta6_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta6_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1061, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1062, 2, N'options_title', N'¿Finge ser un robot, un avión, una bailarina, o cualquier otro personaje favorito?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Finge ser un robot, un avión, una bailarina, o cualquier otro personaje favorito?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1063, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta7_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta7_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1064, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1065, 2, N'options_title', N'¿Pone una olla de juguete en una cocina de mentira?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Pone una olla de juguete en una cocina de mentira?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1066, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta8_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta8_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1067, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1068, 2, N'options_title', N'¿Revuelve comida imaginaria?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Revuelve comida imaginaria?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1069, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta9_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta9_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1070, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1071, 2, N'options_title', N'¿Pone una figura de acción o muñeca en un coche o camión de juguete como si fuese el conductor o el pasajero?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Pone una figura de acción o muñeca en un coche o camión de juguete como si fuese el conductor o el pasajero?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1072, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta10_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta10_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1073, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1074, 2, N'options_title', N'¿Finge pasar la aspiradora a la alfombra, barrer, o cortar el césped?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Finge pasar la aspiradora a la alfombra, barrer, o cortar el césped?</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1075, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta11_P3'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta11_P3'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1076, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1077, 2, N'options_title', N'Otros', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Otros</div></div></div><div class="chat-time">23:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1078, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2Pregunta4'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2Pregunta4'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1079, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:09</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1080, 2, N'options_title', N'4. ¿A su hijo le gusta subir se a cosas?(POR EJEMPLO,a una silla, escaleras, otobogán, …)', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">4. ¿A su hijo le gusta subir se a cosas?(POR EJEMPLO,a una silla, escaleras, otobogán, …)</div></div></div><div class="chat-time">23:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1081, 2, N'option', N'Pasa,No Pasa', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1pregunta1_P4'',''Pasa'')"><div class="box bg-light-info">Pasa</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta1_P4'',''No Pasa'')"><div class="box bg-light-info">No Pasa</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1082, 2, N'text', N'Pasa', N'<li class="reverse"><div class="chat-time">23:09</div><div class="chat-content"><div class="box bg-light-inverse">Pasa</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1083, 2, N'options_title', N'Por favor déme un ejemplo de algo a lo que le gusta trepar (Si el padre no da uno de los ejemplos “PASA” siguientes, pregunte cada uno individualmente.)  /n Le gusta subirse a escaleras? ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor déme un ejemplo de algo a lo que le gusta trepar (Si el padre no da uno de los ejemplos “PASA” siguientes, pregunte cada uno individualmente.)  /n Le gusta subirse a escaleras? </div></div></div><div class="chat-time">23:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1084, 2, N'option', N'Sí,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2_P4'',''Sí'')"><div class="box bg-light-info">Sí</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta2_P4'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1085, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:09</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1086, 2, N'options_title', N'Le gusta subirse a sillas? ', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Le gusta subirse a sillas? </div></div></div><div class="chat-time">23:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1087, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3_P4'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3_P4'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1088, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">23:09</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1089, 2, N'options_title', N'Le gusta subir a muebles?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Le gusta subir a muebles?</div></div></div><div class="chat-time">23:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1090, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta3_P4'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2pregunta4_P4'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1091, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">23:09</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1092, 2, N'options_title', N'¿Le gusta subirse a toboganes?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Le gusta subirse a toboganes?</div></div></div><div class="chat-time">23:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1093, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB1Final'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB1Final'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1102, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">18:11</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1103, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1104, 2, N'text', N'El test de evaluación ha concluido se generara una cita con su médico.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">El test de evaluación ha concluido se generara una cita con su médico.</div></div><div class="chat-time">18:11</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1105, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1146, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">18:07</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1147, 2, N'options_title', N'Hola somos el asistente virtual de la clinica ingrese la edad del paciente.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Hola somos el asistente virtual de la clinica ingrese la edad del paciente.</div></div></div><div class="chat-time">18:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1148, 2, N'option', N'16-30 Meses,4 a 11 años,6 a 16 años', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario1'',''16-30 Meses'')"><div class="box bg-light-info">16-30 Meses</div></div><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario4'',''4 a 11 años'')"><div class="box bg-light-info">4 a 11 años</div></div><div class="chat-content chat-option" onclick="redirect_message(''Cuestionario3'',''6 a 16 años'')"><div class="box bg-light-info">6 a 16 años</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1149, 2, N'text', N'6 a 16 años', N'<li class="reverse"><div class="chat-time">18:07</div><div class="chat-content"><div class="box bg-light-inverse">6 a 16 años</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1150, 2, N'options_title', N'Bienvenido al cuestionario 3 para poder empezar por favor marque la opción comenzar.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Bienvenido al cuestionario 3 para poder empezar por favor marque la opción comenzar.</div></div></div><div class="chat-time">18:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1151, 2, N'option', N'Comenzar', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta1'',''Comenzar'')"><div class="box bg-light-info">Comenzar</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1152, 2, N'text', N'Comenzar', N'<li class="reverse"><div class="chat-time">18:07</div><div class="chat-content"><div class="box bg-light-inverse">Comenzar</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1153, 2, N'options_title', N'1.  Parece anticuado y precoz.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">1.  Parece anticuado y precoz.</div></div></div><div class="chat-time">18:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1154, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta2'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta2'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta2'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1155, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">18:07</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1156, 2, N'options_title', N'2.  Es considerado por otros chicos como un "profesor excéntrico".', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">2.  Es considerado por otros chicos como un "profesor excéntrico".</div></div></div><div class="chat-time">18:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1157, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta3'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta3'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta3'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1158, 2, N'text', N'Algo', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Algo</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1159, 2, N'options_title', N'3.  Vive en cierta forma en su propio mundo, con intereses intelectuales idiosincrásicos y restrictivos.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">3.  Vive en cierta forma en su propio mundo, con intereses intelectuales idiosincrásicos y restrictivos.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1160, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta4'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta4'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta4'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1161, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1162, 2, N'options_title', N'4.  Acumula hechos o datos relativos a ciertos temas pero sin comprender realmente su significado.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">4.  Acumula hechos o datos relativos a ciertos temas pero sin comprender realmente su significado.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1163, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta5'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta5'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta5'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1164, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1165, 2, N'options_title', N'5.  Posee una comprensión literal del lenguaje metfórico o ambiguo.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">5.  Posee una comprensión literal del lenguaje metfórico o ambiguo.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1166, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta6'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta6'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta6'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1167, 2, N'text', N'Algo', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Algo</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1168, 2, N'options_title', N'6.  Posee un estilo de comunicacion desviado, con un lenguaje formal, detallado, anticuado o con la entonación similar a la de un robot.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">6.  Posee un estilo de comunicacion desviado, con un lenguaje formal, detallado, anticuado o con la entonación similar a la de un robot.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1169, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta7'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta7'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta7'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1170, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1171, 2, N'options_title', N'7.  Inventa palabras o expresiones idiosincrásicas.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">7.  Inventa palabras o expresiones idiosincrásicas.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1172, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta8'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta8'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta8'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1173, 2, N'text', N'Algo', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Algo</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1174, 2, N'options_title', N'8.  Posee una voz o forma de hablar diferente.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">8.  Posee una voz o forma de hablar diferente.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1175, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta9'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta9'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta9'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1176, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1177, 2, N'options_title', N'9.  Tiende a desviar la mirada.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">9.  Tiende a desviar la mirada.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1178, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta10'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta10'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T3Pregunta10'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1179, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1180, 2, N'options_title', N'10.  Le falta empatía.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">10.  Le falta empatía.</div></div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1181, 2, N'option', N'No,Algo,Si', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''T2SB2Final'',''No'')"><div class="box bg-light-info">No</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2Final'',''Algo'')"><div class="box bg-light-info">Algo</div></div><div class="chat-content chat-option" onclick="redirect_message(''T2SB2Final'',''Si'')"><div class="box bg-light-info">Si</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1182, 2, N'text', N'Algo', N'<li class="reverse"><div class="chat-time">18:08</div><div class="chat-content"><div class="box bg-light-inverse">Algo</div></div><div class="chat-img"><img src="https://localhost:44383/images/user.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1183, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1184, 2, N'text', N'El test de evaluación ha concluido se generara una cita con su médico.', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">El test de evaluación ha concluido se generara una cita con su médico.</div></div><div class="chat-time">18:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1185, 2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">00:24</div></li>', 1, N'bot')
GO
SET IDENTITY_INSERT [dbo].[tbl_flujos] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_historial_paciente] ON 
GO
INSERT [dbo].[tbl_historial_paciente] ([id_historial], [id_paciente], [nota], [recomendacion], [medicina], [id_doctor], [fecha_registro], [hora_registro]) VALUES (1, 2, N'ninguno', N'descanso médico', N'paracetamol', 4, CAST(N'2022-09-28' AS Date), CAST(N'09:54:23.7330000' AS Time))
GO
SET IDENTITY_INSERT [dbo].[tbl_historial_paciente] OFF
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
SET IDENTITY_INSERT [dbo].[tbl_resumen_flujo] ON 
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (1, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (4, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (5, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (6, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (7, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (8, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (9, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (10, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (11, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (12, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (13, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (15, 2, N'CUESTIONARIO_OK')
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (17, 2, N'CUESTIONARIO**')
GO
SET IDENTITY_INSERT [dbo].[tbl_resumen_flujo] OFF
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
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email], [test_actual]) VALUES (1, N'Martin', N'Aguirre', 1, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'11111111', N'admin@abc.com', 0)
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email], [test_actual]) VALUES (2, N'Juan', N'Marca', 2, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'22222222', N'cliente@abc.com', 0)
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email], [test_actual]) VALUES (3, N'Dr Luis', N'Ortiz', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'33333333', N'doc1@abc.com', 0)
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email], [test_actual]) VALUES (4, N'Dr Daniel', N'Espinoza', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'44444444', N'doc2@abc.com', 0)
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email], [test_actual]) VALUES (5, N'Dr Felipe', N'Ugarte', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'55555555', N'doc3@abc.com', 0)
GO
SET IDENTITY_INSERT [dbo].[tbl_usuario] OFF
GO
ALTER TABLE [dbo].[tbl_cita] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[tbl_estados_cita] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[tbl_historial_paciente] ADD  CONSTRAINT [DF__tbl_histo__fecha__08B54D69]  DEFAULT (getdate()) FOR [fecha_registro]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_CONTRASEÑA]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_generar_ticket]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_generar_ticket]
AS
BEGIN

	select
		CONCAT('TK', RIGHT(CONCAT('0000000000',count(*) + 1),6)) 'codigo'
	from tbl_tickets

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CENTROS_ATENCION]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_DOCTOR]    Script Date: 15/11/2022 1:11:17 ******/
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
  CONCAT(u.nombres, ' ', u.apellidos) 'usuario',
  c.tipo
 FROM tbl_cita c  
 INNER JOIN tbl_usuario u ON u.id_usuario = c.id_usuario  
 INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita  
 WHERE c.id_doctor_asignado = @id_usuario  
 AND (@id_estado = -1 or c.id_estado_cita = @id_estado)  
 AND (@fecha = '-' or convert(varchar(10), convert(date, c.fecha_cita)) = @fecha)  
 AND c.tipo = 'CITA'
  
 ORDER BY fecha_cita, hora_cita  
  
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_USUARIO]    Script Date: 15/11/2022 1:11:17 ******/
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
  CONCAT(u.nombres, ' ', u.apellidos) 'doctor_asignado',
  c.tipo
 FROM tbl_cita c  
 INNER JOIN tbl_usuario u ON u.id_usuario = c.id_doctor_asignado  
 INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita  
 WHERE c.id_usuario = @id_usuario  
 AND c.tipo in ('CITA','CUESTIONARIO')
 ORDER BY fecha_cita, hora_cita  
  
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DOCTORES]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_ENCUESTAS]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_ENCUESTAS]-- SP_LISTAR_ENCUESTAS 2022,0
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
		insert into @tbl_meses select @c1, num_mes, mes, '', 'DETRACTOR', 0 from tbl_meses where num_mes = @i;
		insert into @tbl_meses select @c2, num_mes, mes, '', 'NULO', 0 from tbl_meses where num_mes = @i;
		insert into @tbl_meses select @c3, num_mes, mes, '', 'PROMOTOR', 0 from tbl_meses where num_mes = @i;

		set @i = @i + 1;
		set @c1 = @c1 + 3;
		set @c2 = @c2 + 3;
		set @c3 = @c3 + 3;
	end

	declare @j int = 1;
	while (@j < (select COUNT(*) + 1 from @tbl_meses))
	begin
		declare @tipo varchar(50);
		declare @visitante varchar(50);
		declare @num_mes int;
		declare @total int;

		select @visitante = visitante, @num_mes = num_mes from @tbl_meses where orden = @j;

		select @total = count(*) from tbl_encuesta
		where datepart(year,convert(date,fecha)) = @año and resultado = @visitante and DATEPART(month,convert(date,fecha)) = @num_mes;

		update @tbl_meses set total = @total
		where visitante = @visitante and num_mes = @num_mes;

		set @j = @j + 1;
	end

	select * from @tbl_meses
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_HISTORIAL_PACIENTE] -- SP_LISTAR_HISTORIAL_PACIENTE 2
(
	@id_usuario int
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @cuestionarios varchar(50) = '';

	if exists (select * from tbl_flujos where id_usuario = @id_usuario and tipo='text' and remitente='person' and contenido_texto='16-30 Meses')
	begin
		set @cuestionarios = @cuestionarios + 'C1';
	end

	if exists (select * from tbl_flujos where id_usuario = @id_usuario and tipo='options_title' and remitente='bot' and contenido_texto='Bienvenido al cuestionario 2 para poder empezar por favor marque la opción comenzar.')
	begin
		set @cuestionarios = @cuestionarios + 'C2';
	end

	--if exists (select * from tbl_flujos where id_usuario = @id_usuario and tipo='text' and remitente='person' and contenido_texto='16-30 Meses')
	--begin
	--	set @cuestionarios = @cuestionarios + 'C3';
	--end

	--if exists (select * from tbl_flujos where id_usuario = @id_usuario and tipo='text' and remitente='person' and contenido_texto='16-30 Meses')
	--begin
	--	set @cuestionarios = @cuestionarios + 'C4';
	--end

	SELECT
		h.id_historial,
		ISNULL(h.nota, '') 'nota',
		ISNULL(h.recomendacion, '') 'recomendacion',
		ISNULL(h.medicina, '') 'medicina',
		CONCAT(u.nombres,' ',u.apellidos) 'doctor',
		CONVERT(varchar(10), CONVERT(date, h.fecha_registro)) 'fecha_registro',
		REPLACE(REPLACE(RIGHT(CONCAT('0', CONVERT(varchar(15), h.hora_registro,100)), 7), 'PM', ' PM'), 'AM', ' AM') 'hora_registro',
		@cuestionarios 'cuestionarios'
	FROM tbl_historial_paciente h
	LEFT JOIN tbl_usuario u on u.id_usuario = h.id_doctor and u.id_tipousuario = 3
	WHERE h.id_paciente = @id_usuario
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_MENU]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_PUNTOS_VISITADOS]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PUNTOS_VISITADOS]
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CITA]    Script Date: 15/11/2022 1:11:17 ******/
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
						INSERT INTO tbl_cita (id_usuario, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo)
						VALUES (@id_usuario, @fecha_cita_, @hora_cita_, @id_doctor, @estado_cita, 'CITA');
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CUESTIONARIO]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_CUESTIONARIO]
(
	--@id_cita int,
	@id_usuario int,
	@fecha_cita varchar(10),
	--@hora_cita varchar(8),
	@id_doctor int
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @estado_cita int = 1;

	--obtener fecha de la cita
	declare @fecha_cita_ date = convert(date, dateadd(day,1,getdate()) );
	declare @nombreDia varchar(20) = (SELECT UPPER(DATENAME(WEEKDAY, @fecha_cita_)));
	
	if (@nombreDia = 'SÁBADO' or @nombreDia = 'SABADO' OR @nombreDia = 'SATURDAY')
	begin
		set @fecha_cita_ = dateadd(day,2,@fecha_cita_);
	end
	else
	if (@nombreDia = 'DOMINGO' OR @nombreDia = 'SUNDAY')
	begin
		set @fecha_cita_ = dateadd(day,1,@fecha_cita_);
	end

	--obtener doctor a asignar (aleatorio)
	declare @doctores table ( id int identity(1,1) primary key, id_doctor int );
	insert into @doctores select id_usuario from tbl_usuario where id_tipousuario=3 and habilitado=1;
	declare @minval TINYINT=1,@maxval TINYINT = (select COUNT(*) from @doctores);
	declare @random_id int;

	--obtener horario de asignación de cita
	declare @horarios table ( id int identity(1,1) primary key, hora time )
	declare @hora_cita time;

	declare @validador varchar(2) = '';
	while @validador = ''
	begin
		set @random_id = (SELECT CAST(((@maxval + 1) - @minval) * RAND(CHECKSUM(NEWID())) + @minval AS TINYINT));
		set @id_doctor = (select id_doctor from @doctores where id = @random_id);
		--horarios genericos
		insert into @horarios select CONVERT(time, '08:00:00');
		insert into @horarios select CONVERT(time, '09:00:00');
		insert into @horarios select CONVERT(time, '10:00:00');
		insert into @horarios select CONVERT(time, '11:00:00');
		insert into @horarios select CONVERT(time, '12:00:00');
		insert into @horarios select CONVERT(time, '13:00:00');
		insert into @horarios select CONVERT(time, '14:00:00');
		insert into @horarios select CONVERT(time, '15:00:00');
		insert into @horarios select CONVERT(time, '16:00:00');
		--eliminar horarios ya asignados
		delete from @horarios where hora in (select hora_cita from tbl_cita where tipo='CITA' and id_doctor_asignado=@id_doctor and fecha_cita=@fecha_cita_);
		--validar si existe o no un horario disponible
		if (select COUNT(*) from @horarios) = 0
		begin
			set @random_id = (SELECT CAST(((@maxval + 1) - @minval) * RAND(CHECKSUM(NEWID())) + @minval AS TINYINT));
			set @id_doctor = (select id_doctor from @doctores where id = @random_id);

			delete from @horarios;
		end
		else
		begin
			set @validador = 'OK'
			set @hora_cita = (select top 1 hora from @horarios);
		end
	end

	declare @total_si int =
	(
		select count(*) from tbl_flujos
		where id_usuario = @id_usuario and habilitado = 1 and remitente = 'person' and tipo = 'text' and contenido_texto = 'Si'
	);

	-- registrar cita para cuestionario 2
	if exists (select * from tbl_flujos where habilitado=1 and remitente='person' and tipo='text' and contenido_texto='16-30 Meses') and @total_si > 2
	begin

		insert into tbl_cita (id_usuario, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, fecha_registro, tipo)
		values (@id_usuario, @fecha_cita_, null, @id_doctor, @estado_cita, getdate(), 'CUESTIONARIO');

		update tbl_flujos set habilitado = 0 where id_usuario = @id_usuario and habilitado = 1;
	 	
		insert into tbl_flujos
		select top 1 id_usuario,tipo,contenido_texto,contenido_html,1,remitente from tbl_flujos
		where id_usuario = @id_usuario and habilitado = 0;
		SELECT 'OK' AS 'rpta';

	end
	else
	if exists (select * from tbl_flujos where habilitado=1 and remitente='person' and tipo='text' and contenido_texto='4 a 11 años')
	or exists (select * from tbl_flujos where habilitado=1 and remitente='person' and tipo='text' and contenido_texto='6 a 16 años')
	begin

		insert into tbl_cita (id_usuario, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, fecha_registro, tipo)
		values (@id_usuario, @fecha_cita_, @hora_cita, @id_doctor, @estado_cita, getdate(), 'CITA');

		update tbl_flujos set habilitado = 0 where id_usuario = @id_usuario and habilitado = 1;
	 	
		insert into tbl_flujos
		select top 1 id_usuario,tipo,contenido_texto,contenido_html,1,remitente from tbl_flujos
		where id_usuario = @id_usuario and habilitado = 0;
		SELECT 'OK' AS 'rpta';

	end
	else
	begin

		update tbl_flujos set habilitado = 0 where id_usuario = @id_usuario and habilitado = 1;
	 	
		insert into tbl_flujos
		select top 1 id_usuario,tipo,contenido_texto,contenido_html,1,remitente from tbl_flujos
		where id_usuario = @id_usuario and habilitado = 0;

		--insert into tbl_cita (id_usuario, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, fecha_registro, tipo)
		--values (@id_usuario, @fecha_cita_, null, @id_doctor, @estado_cita, getdate(), 'CUESTIONARIO');

		SELECT 'Gracias por participar en el cuestionario' AS 'rpta';

	end

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_ESTADO_CUESTIONARIO]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_REGISTRAR_ESTADO_CUESTIONARIO]
(
	@id_cita int
)
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @id_estado_cita INT = (SELECT id_estado_cita FROM tbl_cita WHERE id_cita = @id_cita);  
  
 IF @id_estado_cita = 1  
 BEGIN  
    
  UPDATE tbl_cita SET id_estado_cita = 2 WHERE id_cita = @id_cita;
  
  SELECT 'OK' AS 'rpta';  
  
 END  
 ELSE  
 BEGIN  
  SELECT 'Ocurrió un error atendiendo su solicitud' AS 'res';  
 END   
   
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_FLUJO]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_FLUJO]    
(    
	@id_usuario int,    
	@tipo varchar(50),    
	@remitente varchar(20),    
	@contenido_texto nvarchar(max),    
	@contenido_html nvarchar(max)    
)    
AS    
BEGIN    
    
	--if @remitente = 'bot'    
	--begin    
	--	if (@contenido_texto = 'Gracias! Por su preferencia')    
	--	begin    
	--		insert into tbl_resumen_flujo values (@id_usuario, 'GRACIAS');    
	--	end    
	--	else    
	--	if (@contenido_texto like '%' + 'ticket de seguimiento' + '%')    
	--	begin    
	--		insert into tbl_resumen_flujo values (@id_usuario, 'TICKET');    
	--	end    
	--	else    
	--	if (@contenido_texto = 'En este momento procedo a llamar al Call Center')    
	--	begin    
	--		insert into tbl_resumen_flujo values (@id_usuario, 'CALL CENTER');    
	--	end    
	--end    
    
	if @contenido_texto = 'Gracias por participar en el cuestionario'
	--cuestionario 1
	or @contenido_texto = 'Muy bien se agendó un nuevo test, a partir de mañana podrá realizarlo'  
	or @contenido_texto = 'Muy bien se agendó un nuevo test de evaluación, a partir de mañana podrá realizarlo'
	--cuestionario 2
	or @contenido_texto = 'El test de evaluación ha concluido se generara una cita con su médico.'  
	or @contenido_texto = 'El test de evaluación ha concluido se generará una cita con su médico.'
	begin  
		insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)    
		values (@id_usuario, @tipo, @contenido_texto, @contenido_html, 1, @remitente);

		/* 14-10-2022 */

		declare @cuestionario varchar(20) = case when @contenido_texto like '%Gracias%' then 'CUESTIONARIO*' else 'CUESTIONARIO**' end;
		insert into tbl_resumen_flujo values (@id_usuario, @cuestionario);

		update tbl_flujos set habilitado = 0 where id_usuario = @id_usuario and habilitado = 1;    
   
		insert into tbl_flujos    
		select top 1 id_usuario,tipo,contenido_texto,contenido_html,1,remitente from tbl_flujos    
		where id_usuario = @id_usuario and habilitado = 0;  
	end  
	else
	if @contenido_texto = 'Gracias por participar'  
		begin  
		update tbl_flujos set habilitado = 0 where id_usuario = @id_usuario and habilitado = 1;    
   
		insert into tbl_flujos    
		select top 1 id_usuario,tipo,contenido_texto,contenido_html,1,remitente from tbl_flujos    
		where id_usuario = @id_usuario and habilitado = 0;  
	end  
	else  
	begin  
		insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)    
		values (@id_usuario, @tipo, @contenido_texto, @contenido_html, 1, @remitente);    
	end  
    
	select 'OK' 'rpta';    
    
END 

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_INVITADO]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_INVITADO]
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTO_VISITADO]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_PUNTO_VISITADO]
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTUACION]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_PUNTUACION]
(
	@id_usuario int,
	@puntuacion int
)
AS
BEGIN

	declare @hora varchar(8) = convert(varchar(8),convert(time,getdate()))
	declare @fecha varchar(10) = convert(date,getdate())

	declare @resultado varchar(20) = case when @puntuacion between 1 and 6 then 'Detractor' when @puntuacion between 7 and 8 then 'Nulo' else 'Promotor' end;

	insert into tbl_encuesta select @id_usuario, @puntuacion, @hora, @fecha, @resultado;

	update tbl_resumen_flujo set
		resultado = 'CUESTIONARIO_OK'
	where resultado in ('CUESTIONARIO*','CUESTIONARIO**') and id_usuario = @id_usuario

	--update tbl_flujos set
	--	habilitado = 0
	--where id_usuario = @id_usuario;
	--declare @nuevo_contenido_html varchar(max)  = '<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,getdate()),5) + '</div></li>'

	--insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
	--values (@id_usuario, 'text', 'Hola, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');

	select 'OK' 'rpta';

END

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_TICKET]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_TICKET]
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_USUARIO]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_USUARIO]
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_VISITA]    Script Date: 15/11/2022 1:11:17 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_NPS]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RESULTADOS_NPS] -- SP_RESULTADOS_NPS 2022,10
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

	if not exists (select * from @temp_resultados where resultado = 'Nulo')
	begin
		insert into @temp_resultados select 0,0.00,'Nulo'
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

	--if not exists (select * from @temp_resultados_flujo where resultado = 'TICKET')
	--begin
	--	insert into @temp_resultados_flujo select 0,0.00,'TICKET';
	--end

	--if not exists (select * from @temp_resultados_flujo where resultado = 'GRACIAS')
	--begin
	--	insert into @temp_resultados_flujo select 0,0.00,'GRACIAS';
	--end

	--if not exists (select * from @temp_resultados_flujo where resultado = 'CALL CENTER')
	--begin
	--	insert into @temp_resultados_flujo select 0,0.00,'CALL CENTER';
	--end

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
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_FLUJO_ACTUAL]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VALIDAR_FLUJO_ACTUAL] -- exec SP_VALIDAR_FLUJO_ACTUAL 2
(
	@id_usuario int
)
AS
BEGIN

	declare @valor_reemplazar varchar(50) = 'https://localhost:44383';

	select --top 1
		id_flujo,
		id_usuario,
		tipo,
		contenido_texto,
		REPLACE(contenido_html, @valor_reemplazar, '') 'contenido_html',
		habilitado,
		remitente
	from tbl_flujos
	where id_usuario = @id_usuario
	and habilitado = 1

	union all

	select
		0,@id_usuario,'text',resultado,'',1,'bot'
	from tbl_resumen_flujo
	where id_usuario = @id_usuario and resultado in ('CUESTIONARIO*','CUESTIONARIO**')
	--order by 1 desc

END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_USUARIO]    Script Date: 15/11/2022 1:11:17 ******/
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
			u.test_actual,
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
			0 test_actual,
			@error 'validacion'
	end

end
GO
/****** Object:  StoredProcedure [dbo].[SP_VISITAS]    Script Date: 15/11/2022 1:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VISITAS]
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
