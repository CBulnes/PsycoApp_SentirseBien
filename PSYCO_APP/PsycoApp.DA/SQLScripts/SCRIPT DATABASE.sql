/****** Object:  Database [DB_PSYCO]    Script Date: 13/02/2025 17:20:51 ******/
CREATE DATABASE [DB_PSYCO]  (EDITION = 'Basic', SERVICE_OBJECTIVE = 'Basic', MAXSIZE = 500 MB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [DB_PSYCO] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [DB_PSYCO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_PSYCO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_PSYCO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_PSYCO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_PSYCO] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_PSYCO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_PSYCO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_PSYCO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_PSYCO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_PSYCO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_PSYCO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_PSYCO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_PSYCO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_PSYCO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_PSYCO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_PSYCO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_PSYCO] SET  MULTI_USER 
GO
ALTER DATABASE [DB_PSYCO] SET ENCRYPTION ON
GO
ALTER DATABASE [DB_PSYCO] SET QUERY_STORE = ON
GO
ALTER DATABASE [DB_PSYCO] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  UserDefinedTableType [dbo].[type_estudios_psicologo]    Script Date: 13/02/2025 17:20:51 ******/
CREATE TYPE [dbo].[type_estudios_psicologo] AS TABLE(
	[Id] [int] NULL,
	[IdPsicologo] [int] NULL,
	[GradoAcademico] [int] NULL,
	[Institucion] [int] NULL,
	[Carrera] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[type_horarios_psicologo]    Script Date: 13/02/2025 17:20:51 ******/
CREATE TYPE [dbo].[type_horarios_psicologo] AS TABLE(
	[IdPsicologo] [int] NULL,
	[Orden] [int] NULL,
	[Id] [int] NULL,
	[Fecha] [varchar](10) NULL,
	[NombreDia] [varchar](20) NULL,
	[Inicio] [varchar](5) NULL,
	[Refrigerio] [varchar](5) NULL,
	[Fin] [varchar](5) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DesencriptarPassword]    Script Date: 13/02/2025 17:20:51 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_EncriptarPassword]    Script Date: 13/02/2025 17:20:51 ******/
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
/****** Object:  UserDefinedFunction [dbo].[Get_date]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Get_date]()
RETURNS DATETIME
AS
BEGIN
    declare @TimezoneName varchar(max) = 'SA Pacific Standard Time'
	declare @timezoneOffset bigint = Datediff(MINUTE, getdate() at time zone @TimezoneName, getdate() )
	RETURN dateadd(minute,@timezoneOffset,getdate())
END
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Color] [char](7) NULL,
	[EsEvaluacion] [bit] NULL,
	[NumSesiones] [int] NULL,
	[Siglas] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_centros_atencion]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_cita]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cita](
	[id_cita] [int] IDENTITY(1,1) NOT NULL,
	[id_paciente] [int] NULL,
	[fecha_cita] [date] NULL,
	[hora_cita] [time](7) NULL,
	[id_doctor_asignado] [int] NULL,
	[id_estado_cita] [int] NULL,
	[tipo] [varchar](50) NULL,
	[Moneda] [varchar](10) NULL,
	[Monto_pactado] [decimal](10, 2) NULL,
	[Monto_pagado] [decimal](10, 2) NULL,
	[Monto_pendiente] [decimal](10, 2) NULL,
	[usuario_registra] [varchar](50) NULL,
	[fecha_registra] [datetime] NULL,
	[usuario_modifica] [varchar](50) NULL,
	[fecha_modifica] [datetime] NULL,
	[id_servicio] [int] NULL,
	[Id_sede] [int] NULL,
	[feedback] [bit] NULL,
	[comentario] [varchar](500) NULL,
	[orden] [int] NULL,
	[pago_gratis] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cita] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_transferencia]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_transferencia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_encuesta]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_estados_cita]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_estudios_psicologo]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_estudios_psicologo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPsicologo] [int] NULL,
	[GradoAcademico] [int] NULL,
	[Institucion] [int] NULL,
	[Carrera] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_flujos]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_forma_pago]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_forma_pago](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_historial_cita]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_historial_cita](
	[id_historial] [int] IDENTITY(1,1) NOT NULL,
	[id_cita] [int] NULL,
	[mostrar] [bit] NULL,
	[evento] [varchar](50) NULL,
	[usuario_registra] [varchar](50) NULL,
	[fecha_registra] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_historial] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_historial_paciente]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_horarios_psicologo]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_horarios_psicologo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_psicologo] [int] NULL,
	[Fecha] [date] NULL,
	[Inicio] [varchar](5) NULL,
	[Refrigerio] [varchar](5) NULL,
	[Fin] [varchar](5) NULL,
 CONSTRAINT [PK__tbl_hora__3214EC0773E2DCB4] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_invitados]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_menu]    Script Date: 13/02/2025 17:20:51 ******/
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
/****** Object:  Table [dbo].[tbl_meses]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_meses](
	[num_mes] [int] NULL,
	[mes] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_opciones_usuario]    Script Date: 13/02/2025 17:20:51 ******/
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
/****** Object:  Table [dbo].[tbl_paciente]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_paciente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[DocumentoTipo] [nvarchar](50) NOT NULL,
	[DocumentoNumero] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](50) NOT NULL,
	[EstadoCivil] [nvarchar](50) NOT NULL,
	[Sexo] [nvarchar](10) NOT NULL,
	[Estado] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK__tbl_paci__3214EC0752FABBC5] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_pago]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pago](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_cita] [int] NULL,
	[id_forma_pago] [int] NULL,
	[id_detalle_transferencia] [int] NULL,
	[importe] [decimal](10, 2) NULL,
	[fecha_registro] [datetime] NULL,
	[usuario_registro] [varchar](20) NULL,
	[comentario] [varchar](50) NULL,
 CONSTRAINT [PK__tbl_pago__3213E83FF2571401] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_psicologo]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_psicologo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[DocumentoTipo] [nvarchar](50) NOT NULL,
	[DocumentoNumero] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](50) NOT NULL,
	[Refrigerio] [varchar](5) NOT NULL,
	[Especialidad] [int] NOT NULL,
	[Direccion] [nvarchar](200) NOT NULL,
	[Distrito] [nvarchar](6) NOT NULL,
	[Estado] [nvarchar](20) NOT NULL,
	[InicioLabores] [varchar](5) NULL,
	[FinLabores] [varchar](5) NULL,
 CONSTRAINT [PK__tbl_psic__3214EC079F09F03C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_puntos_visitados]    Script Date: 13/02/2025 17:20:51 ******/
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
/****** Object:  Table [dbo].[tbl_resumen_flujo]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sede]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sede](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sede_usuario]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sede_usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_sede] [int] NULL,
	[Id_psicologo] [int] NULL,
	[Fecha] [date] NULL,
	[Principal] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tickets]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipo_documento]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipo_documento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](30) NULL,
	[estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipolinea]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipousuario]    Script Date: 13/02/2025 17:20:51 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ubigeo]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ubigeo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodUbigeo] [nvarchar](6) NULL,
	[Departamento] [nvarchar](100) NULL,
	[Provincia] [nvarchar](100) NULL,
	[Distrito] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 13/02/2025 17:20:51 ******/
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
	[login] [varchar](50) NULL,
	[id_sede] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_vacaciones_psicologo]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_vacaciones_psicologo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_psicologo] [int] NULL,
	[Fecha] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_visitas]    Script Date: 13/02/2025 17:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_visitas](
	[visitante] [varchar](50) NULL,
	[fecha_visita] [datetime] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (1, N'Consulta o atención sin costo', CAST(0.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (2, N'Entrega informe 30 minutos', CAST(0.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (3, N'Evaluación de aprendizaje', CAST(520.00 AS Decimal(10, 2)), NULL, 1, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (4, N'Evaluación integral (EI)', CAST(690.00 AS Decimal(10, 2)), NULL, 1, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (5, N'Evaluación neuropsicológica', CAST(760.00 AS Decimal(10, 2)), NULL, 1, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (6, N'Evaluación personalidad (EP)', CAST(590.00 AS Decimal(10, 2)), NULL, 1, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (7, N'Paquete de 5 sesiones de terapia de pareja', CAST(750.00 AS Decimal(10, 2)), NULL, 0, 5, N'STP')
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (8, N'Paquete de 5 sesiones individual', CAST(650.00 AS Decimal(10, 2)), NULL, 0, 5, N'SI')
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (10, N'Terapia de aprendizaje (TA)', CAST(130.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (11, N'Terapia de lenguaje (TL)', CAST(130.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (12, N'Terapia de pareja y familia (TPF)', CAST(160.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (13, N'Terapia virtual y presenciales (V)', CAST(150.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (14, N'Test de inteligencia (TI)', CAST(280.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (15, N'Test vocacional (TV)', CAST(390.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (16, N'Visita colegio', CAST(150.00 AS Decimal(10, 2)), NULL, 0, 0, NULL)
GO
INSERT [dbo].[Productos] ([id], [Nombre], [Precio], [Color], [EsEvaluacion], [NumSesiones], [Siglas]) VALUES (93, N'Evaluación gratuita', CAST(0.00 AS Decimal(10, 2)), NULL, 0, 0, N'EG')
GO
SET IDENTITY_INSERT [dbo].[Productos] OFF
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
SET IDENTITY_INSERT [dbo].[tbl_detalle_transferencia] ON 
GO
INSERT [dbo].[tbl_detalle_transferencia] ([id], [descripcion], [estado]) VALUES (1, N'BCP - Ahorros S/.', 1)
GO
INSERT [dbo].[tbl_detalle_transferencia] ([id], [descripcion], [estado]) VALUES (2, N'BBVA - Ahorros S/.', 1)
GO
INSERT [dbo].[tbl_detalle_transferencia] ([id], [descripcion], [estado]) VALUES (3, N'Interbank - Ahorros S/.', 1)
GO
SET IDENTITY_INSERT [dbo].[tbl_detalle_transferencia] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_estados_cita] ON 
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (1, N'CITADO', CAST(N'2024-12-06T10:43:40.370' AS DateTime))
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (2, N'CONFIRMADO', CAST(N'2024-12-06T10:43:40.377' AS DateTime))
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (3, N'ATENDIDO', CAST(N'2024-12-06T10:43:40.380' AS DateTime))
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (4, N'CANCELADO', CAST(N'2024-12-06T10:43:40.383' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_estados_cita] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_forma_pago] ON 
GO
INSERT [dbo].[tbl_forma_pago] ([id], [descripcion], [estado]) VALUES (1, N'Transferencia', 1)
GO
INSERT [dbo].[tbl_forma_pago] ([id], [descripcion], [estado]) VALUES (2, N'Depósito', 1)
GO
INSERT [dbo].[tbl_forma_pago] ([id], [descripcion], [estado]) VALUES (3, N'Pago gratis', 1)
GO
SET IDENTITY_INSERT [dbo].[tbl_forma_pago] OFF
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'00', N'01  ', N'ADMINISTRACION', 1, N'mdi mdi-gauge', N'', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'02  ', N'Visitas', 1, N'mdi mdi-gauge', N'Home', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'03  ', N'Reportes', 1, N'mdi mdi-gauge', N'Reportes', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'04  ', N'Clientes', 1, N'mdi mdi-gauge', N'/Mantenimiento/Cliente', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'05  ', N'Pacientes', 1, N'mdi mdi-gauge', N'/Mantenimiento/Paciente', 1)
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
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'04', 1)
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'05', 1)
GO
SET IDENTITY_INSERT [dbo].[tbl_sede] ON 
GO
INSERT [dbo].[tbl_sede] ([Id], [Nombre], [Estado]) VALUES (1, N'La Molina', 1)
GO
INSERT [dbo].[tbl_sede] ([Id], [Nombre], [Estado]) VALUES (2, N'Surco', 1)
GO
SET IDENTITY_INSERT [dbo].[tbl_sede] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_tipo_documento] ON 
GO
INSERT [dbo].[tbl_tipo_documento] ([id], [descripcion], [estado]) VALUES (1, N'DNI', 1)
GO
INSERT [dbo].[tbl_tipo_documento] ([id], [descripcion], [estado]) VALUES (2, N'Carnet Extranjeria', 1)
GO
SET IDENTITY_INSERT [dbo].[tbl_tipo_documento] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_tipousuario] ON 
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (1, N'ADMIN')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (2, N'CLIENTE')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (3, N'CAJA')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (4, N'PSICOLOGO')
GO
SET IDENTITY_INSERT [dbo].[tbl_tipousuario] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ubigeo] ON 
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (1, N'150101', N'Lima', N'Lima', N'Lima')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (2, N'150102', N'Lima', N'Lima', N'Ancón')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (3, N'150103', N'Lima', N'Lima', N'Ate')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (4, N'150104', N'Lima', N'Lima', N'Barranco')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (5, N'150105', N'Lima', N'Lima', N'Breña')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (6, N'150106', N'Lima', N'Lima', N'Carabayllo')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (7, N'150107', N'Lima', N'Lima', N'Chaclacayo')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (8, N'150108', N'Lima', N'Lima', N'Chorrillos')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (9, N'150109', N'Lima', N'Lima', N'Cieneguilla')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (10, N'150110', N'Lima', N'Lima', N'Comas')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (11, N'150111', N'Lima', N'Lima', N'El Agustino')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (12, N'150112', N'Lima', N'Lima', N'Independencia')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (13, N'150113', N'Lima', N'Lima', N'Jesús María')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (14, N'150114', N'Lima', N'Lima', N'La Molina')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (15, N'150115', N'Lima', N'Lima', N'La Victoria')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (16, N'150116', N'Lima', N'Lima', N'Lince')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (17, N'150117', N'Lima', N'Lima', N'Los Olivos')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (18, N'150118', N'Lima', N'Lima', N'Lurigancho-Chosica')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (19, N'150119', N'Lima', N'Lima', N'Lurín')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (20, N'150120', N'Lima', N'Lima', N'Magdalena del Mar')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (21, N'150121', N'Lima', N'Lima', N'Pueblo Libre')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (22, N'150122', N'Lima', N'Lima', N'Miraflores')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (23, N'150123', N'Lima', N'Lima', N'Pachacamac')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (24, N'150124', N'Lima', N'Lima', N'Pucusana')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (25, N'150125', N'Lima', N'Lima', N'Puente Piedra')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (26, N'150126', N'Lima', N'Lima', N'Punta Hermosa')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (27, N'150127', N'Lima', N'Lima', N'Punta Negra')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (28, N'150128', N'Lima', N'Lima', N'Rimac')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (29, N'150129', N'Lima', N'Lima', N'San Bartolo')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (30, N'150130', N'Lima', N'Lima', N'San Borja')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (31, N'150131', N'Lima', N'Lima', N'San Isidro')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (32, N'150132', N'Lima', N'Lima', N'San Juan de Lurigancho')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (33, N'150133', N'Lima', N'Lima', N'San Juan de Miraflores')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (34, N'150134', N'Lima', N'Lima', N'San Luis')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (35, N'150135', N'Lima', N'Lima', N'San Martín de Porres')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (36, N'150136', N'Lima', N'Lima', N'San Miguel')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (37, N'150137', N'Lima', N'Lima', N'Santa Anita')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (38, N'150138', N'Lima', N'Lima', N'Santa María del Mar')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (39, N'150139', N'Lima', N'Lima', N'Santa Rosa')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (40, N'150140', N'Lima', N'Lima', N'Santiago de Surco')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (41, N'150141', N'Lima', N'Lima', N'Surquillo')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (42, N'150142', N'Lima', N'Lima', N'Villa El Salvador')
GO
INSERT [dbo].[tbl_ubigeo] ([Id], [CodUbigeo], [Departamento], [Provincia], [Distrito]) VALUES (43, N'150143', N'Lima', N'Lima', N'Villa María del Triunfo')
GO
SET IDENTITY_INSERT [dbo].[tbl_ubigeo] OFF
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((0)) FOR [NumSesiones]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT (NULL) FOR [Siglas]
GO
ALTER TABLE [dbo].[tbl_cita] ADD  DEFAULT ((0)) FOR [orden]
GO
ALTER TABLE [dbo].[tbl_cita] ADD  DEFAULT ((0)) FOR [pago_gratis]
GO
ALTER TABLE [dbo].[tbl_estados_cita] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[tbl_historial_paciente] ADD  CONSTRAINT [DF__tbl_histo__fecha__08B54D69]  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[tbl_pago] ADD  DEFAULT (NULL) FOR [comentario]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD CHECK  (([Color] like '#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]'))
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_CONTRASEÑA]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_actualizar_paciente]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_actualizar_paciente]
    @Id INT,
    @Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
    @FechaNacimiento DATE,
    @DocumentoTipo NVARCHAR(50),
    @DocumentoNumero NVARCHAR(50),
    @Telefono NVARCHAR(50),
    @EstadoCivil NVARCHAR(50),
    @Sexo NVARCHAR(10),
    @Estado NVARCHAR(20)
AS
BEGIN
    UPDATE tbl_paciente
    SET Nombre = @Nombre,
		Apellido = @Apellido,
        FechaNacimiento = @FechaNacimiento,
        DocumentoTipo = @DocumentoTipo,
        DocumentoNumero = @DocumentoNumero,
        Telefono = @Telefono,
        EstadoCivil = @EstadoCivil,
        Sexo = @Sexo,
        Estado = @Estado
    WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_producto]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_actualizar_producto]
    @id INT,
    @Nombre NVARCHAR(100),
    @Precio DECIMAL(10, 2),
    @Color CHAR(7)
AS
BEGIN
    UPDATE Productos
    SET Nombre = @Nombre,
        Precio = @Precio,
        Color = @Color
    WHERE id = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_psicologo]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_actualizar_psicologo]
    @Id INT,
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @FechaNacimiento DATE,
    @DocumentoTipo NVARCHAR(50),
    @DocumentoNumero NVARCHAR(50),
    @Telefono NVARCHAR(50),
	@Refrigerio NVARCHAR(5),
	@InicioLabores NVARCHAR(5),
	@FinLabores NVARCHAR(5),
	@IdSedePrincipal INT,
	@IdSedeSecundaria INT,
    @Especialidad INT,
	@Direccion NVARCHAR(200),
    @Distrito NVARCHAR(6),
    @Estado NVARCHAR(20),
	@EstudiosPsicologo type_estudios_psicologo READONLY
AS
BEGIN
    UPDATE tbl_psicologo SET
		Nombre = @Nombre,
		Apellido = @Apellido,
        FechaNacimiento = @FechaNacimiento,
        DocumentoTipo = @DocumentoTipo,
        DocumentoNumero = @DocumentoNumero,
        Telefono = @Telefono,
		Refrigerio = @Refrigerio,
        Especialidad = @Especialidad,
		Direccion = @Direccion,
        Distrito = @Distrito,
        Estado = @Estado
    WHERE Id = @Id;

	DECLARE @f_actual DATE = dbo.Get_date();
	DELETE FROM tbl_estudios_psicologo WHERE IdPsicologo=@Id;
	DELETE FROM tbl_sede_usuario WHERE Id_psicologo=@Id;

	INSERT INTO tbl_sede_usuario select @IdSedePrincipal, @Id, '', 1;
	if (@IdSedeSecundaria <> -1)
	begin
		INSERT INTO tbl_sede_usuario select @IdSedeSecundaria, @Id, '', 0;
	end

	INSERT INTO tbl_estudios_psicologo
	SELECT es.IdPsicologo, es.GradoAcademico, es.Institucion, es.Carrera FROM @EstudiosPsicologo es
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_SERVICIO_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_SERVICIO_CITA]
(
	@id_cita int,
	@id_servicio int
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @nuevo_monto_pactado decimal(10,2) = (select Precio from Productos where id=@id_servicio);

	update tbl_cita SET
		id_servicio = @id_servicio,
		Monto_pactado = @nuevo_monto_pactado
	where id_cita=@id_cita;

	select 'OK' as 'RPTA';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_agregar_paciente]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_agregar_paciente]
    @Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
    @FechaNacimiento DATE,
    @DocumentoTipo NVARCHAR(50),
    @DocumentoNumero NVARCHAR(50),
    @Telefono NVARCHAR(50),
    @EstadoCivil NVARCHAR(50),
    @Sexo NVARCHAR(10),
    @Estado NVARCHAR(20)
AS
BEGIN
    INSERT INTO tbl_paciente (Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, EstadoCivil, Sexo, Estado)
    VALUES (@Nombre, @Apellido, @FechaNacimiento, @DocumentoTipo, @DocumentoNumero, @Telefono, @EstadoCivil, @Sexo, @Estado)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_agregar_productos]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_agregar_productos]
    @Nombre NVARCHAR(100),
    @Precio DECIMAL(10, 2),
    @Color CHAR(7)
AS
BEGIN
    INSERT INTO Productos (Nombre, Precio, Color)
    VALUES (@Nombre, @Precio, @Color);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_agregar_psicologo]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_agregar_psicologo]
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @FechaNacimiento DATE,
    @DocumentoTipo NVARCHAR(50),
    @DocumentoNumero NVARCHAR(50),
    @Telefono NVARCHAR(50),
	@Refrigerio NVARCHAR(5),
	@InicioLabores NVARCHAR(5),
	@FinLabores NVARCHAR(5),
	@IdSedePrincipal INT,
	@IdSedeSecundaria INT,
    @Especialidad INT,
	@Direccion NVARCHAR(200),
    @Distrito NVARCHAR(6),
    @Estado NVARCHAR(20),
	@EstudiosPsicologo type_estudios_psicologo READONLY
AS
BEGIN
    INSERT INTO tbl_psicologo (Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, Refrigerio, InicioLabores, FinLabores, Especialidad, Direccion, Distrito, Estado)
    VALUES (@Nombre, @Apellido, @FechaNacimiento, @DocumentoTipo, @DocumentoNumero, @Telefono, @Refrigerio, @InicioLabores, @FinLabores, @Especialidad, @Direccion, @Distrito, @Estado);

	DECLARE @IdPsicologo INT = @@IDENTITY;
	DECLARE @f_actual DATE = dbo.Get_date();
	DECLARE @id_tipo_usuario INT = 4; --psicologo
	DECLARE @tipo_doc varchar(20) = (select descripcion from tbl_tipo_documento where id=@DocumentoTipo);
	DECLARE @email varchar(20) = '';
	DECLARE @login varchar(20) = '';

	insert into tbl_usuario (nombres, apellidos, id_tipousuario, password, habilitado, tipo_documento, num_documento, email, test_actual, login)
	values (@Nombre, @Apellido, @id_tipo_usuario, dbo.fn_EncriptarPassword(@DocumentoNumero), cast(@estado as int), @tipo_doc, @DocumentoNumero, @email, 0, @login);

	INSERT INTO tbl_sede_usuario select @IdSedePrincipal, @IdPsicologo, '', 1;
	if (@IdSedeSecundaria <> -1)
	begin
		INSERT INTO tbl_sede_usuario select @IdSedeSecundaria, @IdPsicologo, '', 0;
	end

	INSERT INTO tbl_estudios_psicologo
	SELECT @IdPsicologo, es.GradoAcademico, es.Institucion, es.Carrera FROM @EstudiosPsicologo es

	--horarios
	SET LANGUAGE Spanish;
	declare @f__actual date = dbo.Get_date();
	declare @nombre_dia VARCHAR(20) = UPPER(DATENAME(WEEKDAY, @f__actual))
	declare @ultimo_dia_mes date = EOMONTH(@f__actual);
	declare @mes int = datepart(month, @f__actual), @año int = datepart(year, @f__actual), @tipo_busqueda varchar(20) = 'ACTUAL';

	if @f__actual = @ultimo_dia_mes
	begin
		set @mes = case when datepart(month, @f__actual) = 12 then 1 else datepart(month, @f__actual) end;
		set @año = case when datepart(month, @f__actual) = 12 then datepart(year, @f__actual)+1 else datepart(year, @f__actual) end;
		set @tipo_busqueda = 'SIGUIENTE';
	end

	DECLARE @dateSearch DATE = DATEFROMPARTS(@año, @mes, 1);

	WITH DateTable AS
	(
		SELECT
			DATEADD(month, DATEDIFF(month, 0, @dateSearch), 0) AS [date]
		UNION ALL
		SELECT
			DATEADD(DAY, 1, [date])
		FROM DateTable
		WHERE DATEADD(DAY, 1, [date]) <= EOMONTH(@dateSearch)
	)

	INSERT INTO tbl_horarios_psicologo
	SELECT
		@IdPsicologo,
		CAST([date] AS DATE),
		@InicioLabores,
		@Refrigerio,
		@FinLabores
	FROM DateTable
	WHERE UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))) NOT IN ('DOMINGO')
	AND (@tipo_busqueda = 'ACTUAL' AND CAST([date] AS DATE) > @f__actual);

	SET LANGUAGE us_english;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ATENDER_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ATENDER_CITA]
(
	@id_cita int,
	@usuario varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @estado_cita INT = 2;
	DECLARE @sgte_estado_cita INT = 3;

	IF (SELECT id_estado_cita FROM tbl_cita WHERE id_cita=@id_cita) = @estado_cita
	BEGIN
		update tbl_cita set
			id_estado_cita = @sgte_estado_cita
		where id_cita=@id_cita;

		insert into tbl_historial_cita select @id_cita, 1, (select ec.estado_cita from tbl_estados_cita ec WHERE ec.id_estado_cita=@sgte_estado_cita), @usuario, dbo.Get_date();

		SELECT 'OK' AS 'rpta';
	END
	ELSE
	BEGIN
		SELECT 'La cita ya ha sido atendida.' AS 'rpta';
	END

END

GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_paciente]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_buscar_paciente]
    @Nombre NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Buscar pacientes cuyo nombre contenga la cadena de búsqueda
    SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, EstadoCivil, Sexo, Estado
    FROM [dbo].[tbl_paciente]
    WHERE (Nombre LIKE '%' + @Nombre + '%' OR Apellido LIKE '%' + @Nombre + '%');
END

GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_producto]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_buscar_producto]
    @Nombre NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Productos
    WHERE Nombre LIKE '%' + @Nombre + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_psicologo]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_buscar_psicologo]
    @Nombre NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Buscar psicologos cuyo nombre contenga la cadena de búsqueda
    SELECT p.Id, p.Nombre, p.Apellido, p.FechaNacimiento, td.descripcion 'DocumentoTipo', p.DocumentoNumero, p.Telefono, p.Refrigerio, p.Especialidad, p.Direccion, p.Distrito, p.Estado
    FROM [dbo].[tbl_psicologo] p
	INNER JOIN tbl_tipo_documento td ON td.id = p.DocumentoTipo
    WHERE (p.Nombre LIKE '%' + @Nombre + '%' OR p.Apellido LIKE '%' + @Nombre + '%');
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CANCELAR_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CANCELAR_CITA]
(
	@id_cita int,
	@usuario varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @estado_cita INT = (SELECT id_estado_cita FROM tbl_cita WHERE id_cita=@id_cita);
	DECLARE @sgte_estado_cita INT = 4;

	IF @estado_cita IN (1,2) /*CITADO, CONFIRMADO*/
	BEGIN
		update tbl_cita set
			id_estado_cita = @sgte_estado_cita
		where id_cita=@id_cita;

		insert into tbl_historial_cita select @id_cita, 1, (select ec.estado_cita from tbl_estados_cita ec WHERE ec.id_estado_cita=@sgte_estado_cita), @usuario, dbo.Get_date();

		SELECT 'OK' AS 'rpta';
	END
	ELSE
	BEGIN
		IF @estado_cita = 3 --ATENDIDO
		BEGIN
			SELECT 'La cita ya ha sido atendida.' AS 'rpta';
		END
		ELSE
		IF @estado_cita = 4 --CANCELADO
		BEGIN
			SELECT 'La cita ya ha sido cancelada.' AS 'rpta';
		END
	END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_CITA_PAGO_GRATIS]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
exec SP_CITA_PAGO_GRATIS 1
*/
CREATE PROCEDURE [dbo].[SP_CITA_PAGO_GRATIS]
(
	@id_cita int
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @pago_gratis bit = (select pago_gratis from tbl_cita where id_cita=@id_cita);

	if (@pago_gratis = 0)
	begin
		declare @id_forma_pago int = (select id from tbl_forma_pago where descripcion='Pago gratis');
		declare @id_detalle_transferencia int = -1;
		declare @f_actual date = dbo.Get_date();

		update tbl_cita set pago_gratis=1, Monto_pactado=0.00, Monto_pendiente=0.00 where id_cita=@id_cita;
		insert into tbl_pago (id_cita, id_forma_pago, id_detalle_transferencia, importe, fecha_registro, usuario_registro, comentario)
		values (@id_cita, @id_forma_pago, @id_detalle_transferencia, 0.00, @f_actual, '', 'PAGO GRATUITO');
	end

	select 'OK' as 'rpta';

END
GO
/****** Object:  StoredProcedure [dbo].[SP_CONFIRMAR_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONFIRMAR_CITA]
(
	@id_cita int,
	@usuario varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @estado_cita INT = 1;
	DECLARE @sgte_estado_cita INT = 2;

	IF (SELECT id_estado_cita FROM tbl_cita WHERE id_cita=@id_cita) = @estado_cita
	BEGIN
		update tbl_cita set
			id_estado_cita = @sgte_estado_cita
		where id_cita=@id_cita;

		insert into tbl_historial_cita select @id_cita, 1, (select ec.estado_cita from tbl_estados_cita ec WHERE ec.id_estado_cita=@sgte_estado_cita), @usuario, dbo.Get_date();

		SELECT 'OK' AS 'rpta';
	END
	ELSE
	BEGIN
		SELECT 'La cita ya ha sido confirmada.' AS 'rpta';
	END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_paciente]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminar_paciente]
    @Id INT
AS
BEGIN
	DECLARE @estado_actual NVARCHAR(1) = (select Estado from tbl_paciente WHERE Id = @Id);
    UPDATE tbl_paciente SET Estado = case when @estado_actual = '1' then '0' else '1' end WHERE Id = @Id;
    --DELETE FROM tbl_paciente WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_producto]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminar_producto]
    @id INT
AS
BEGIN
    DELETE FROM Productos
    WHERE id = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_psicologo]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_eliminar_psicologo]
    @Id INT
AS
BEGIN
	DECLARE @estado_actual NVARCHAR(1) = (select Estado from tbl_psicologo WHERE Id = @Id);
    UPDATE tbl_psicologo SET Estado = case when @estado_actual = '1' then '0' else '1' end WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_generar_ticket]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GUARDAR_HORARIO_PSICOLOGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GUARDAR_HORARIO_PSICOLOGO]
(
	@HorariosPsicologo type_horarios_psicologo READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @horarios table
	(
		IdTabla int identity(1,1) primary key,
		IdPsicologo int,
		Id int,
		Fecha varchar(10),
		Inicio varchar(5),
		Refrigerio varchar(5),
		Fin varchar(5)
	);

	insert into @horarios
	select IdPsicologo, Id, Fecha, Inicio, Refrigerio, Fin from @HorariosPsicologo

	declare @i int = 1;
	declare @Fecha varchar(10),
	@Inicio varchar(5),
	@Refrigerio varchar(5),
	@Fin varchar(5),
	@Id int,
	@IdPsicologo int;

	while (@i < (select count(*)+1 from @horarios))
	begin
		select @Inicio=Inicio, @Refrigerio=Refrigerio, @Fin=Fin, @Id=Id, @IdPsicologo=IdPsicologo from @horarios where IdTabla=@i;

		if (@Id=0)
		begin
			insert into tbl_horarios_psicologo (Id_psicologo, Fecha, Inicio, Refrigerio, Fin) values (@IdPsicologo, @Fecha, @Inicio, @Refrigerio, @Fin);
		end
		else
		begin
			update tbl_horarios_psicologo set
				Inicio=@Inicio,
				Refrigerio=@Refrigerio,
				Fin=@Fin
			where Id=@Id;
		end
	end

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GUARDAR_HORARIO_PSICOLOGO_V2]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GUARDAR_HORARIO_PSICOLOGO_V2]
(
	@Id int,
	@IdPsicologo int,
	@Fecha varchar(10),
	@Inicio varchar(5),
	@Refrigerio varchar(5),
	@Fin varchar(5)
)
AS
BEGIN
	SET NOCOUNT ON;

	if (@Id=0)
	begin
		insert into tbl_horarios_psicologo (Id_psicologo, Fecha, Inicio, Refrigerio, Fin) values (@IdPsicologo, @Fecha, @Inicio, @Refrigerio, @Fin);
	end
	else
	begin
		update tbl_horarios_psicologo set
			Inicio=@Inicio,
			Refrigerio=@Refrigerio,
			Fin=@Fin
		where Id=@Id;
	end

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GUARDAR_VACACIONES_PSICOLOGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GUARDAR_VACACIONES_PSICOLOGO]
(
	@Id int,
	@IdPsicologo int,
	@Fecha varchar(10),
	@Eliminar int,
	@TotalEliminar int
)
AS
BEGIN
	SET NOCOUNT ON;

	if (@Eliminar = 1)
	begin
		delete from tbl_vacaciones_psicologo where Id_psicologo=@IdPsicologo and DATEPART(YEAR, Fecha) = DATEPART(year, CONVERT(date, @Fecha));
	end

	insert into tbl_vacaciones_psicologo (Id_psicologo, Fecha) values (@IdPsicologo, @Fecha);
	select 'OK' as 'rpta';

	--if (@Id=0)
	--begin
		--insert into tbl_vacaciones_psicologo (Id_psicologo, Fecha) values (@IdPsicologo, @Fecha);
		--select 'OK' as 'rpta';
	--end
	--else
	--begin
	--	if (@Eliminar=1)
	--	begin
	--		delete from tbl_vacaciones_psicologo where Id=@Id and Id_psicologo=@IdPsicologo;
	--	end
	--	select 'OK' as 'rpta';
	--end

END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CAJA_MES_FORMA_PAGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_CAJA_MES_FORMA_PAGO]
(
	@usuario varchar(20),
	@mes INT,
	@año INT,
	@sede INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @moneda VARCHAR(10) = 'S/.';

	SELECT
		COUNT(1) 'cantidad',
		CONCAT(@moneda,SUM(p.importe)) 'importe',
		f.descripcion 'forma_pago',
		ISNULL(d.descripcion, '') 'detalle_transferencia'
	FROM tbl_pago p
	INNER JOIN tbl_forma_pago f ON f.id = p.id_forma_pago
	LEFT JOIN tbl_detalle_transferencia d ON d.id = p.id_detalle_transferencia
	LEFT JOIN tbl_cita c on c.id_cita = p.id_cita
	WHERE (@mes = -1 OR DATEPART(MONTH, p.fecha_registro) = @mes)
	AND (@año = -1 OR DATEPART(YEAR, p.fecha_registro) = @año)
	AND (@sede = -1 OR c.Id_sede = @sede)
	--AND (@usuario = '-1' OR p.usuario_registro = @usuario)
	GROUP BY f.descripcion, d.descripcion, DATEPART(MONTH, p.fecha_registro), DATEPART(YEAR, p.fecha_registro)

END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CAJA_MES_USUARIO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_CAJA_MES_USUARIO]
(
	@usuario varchar(20),
	@mes INT,
	@año INT,
	@sede INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @moneda VARCHAR(10) = 'S/.';

	SELECT
		CONCAT(@moneda,SUM(p.importe)) 'importe',
		p.usuario_registro 'usuario'
	FROM tbl_pago p
	LEFT JOIN tbl_cita c on c.id_cita=p.id_cita
	WHERE (@mes = -1 OR DATEPART(MONTH, p.fecha_registro) = @mes)
	AND (@año = -1 OR DATEPART(YEAR, p.fecha_registro) = @año)
	AND (@sede = -1 OR c.Id_sede = @sede)
	--AND (@usuario = '-1' OR p.usuario_registro = @usuario)
	GROUP BY p.usuario_registro, DATEPART(MONTH, p.fecha_registro), DATEPART(YEAR, p.fecha_registro)

END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CENTROS_ATENCION]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_DOCTOR]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- dbo.SP_LISTAR_CITAS_DOCTOR 'ADMIN','-',-1,1
CREATE PROCEDURE [dbo].[SP_LISTAR_CITAS_DOCTOR]
(
	@usuario varchar(20),
	@fecha varchar(10),
	@id_estado int,
	@ver_sin_reserva INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @f_actual DATE = dbo.Get_date();
	DECLARE @dif_dias INT = 15;

	SELECT
		c.id_cita,
		c.id_estado_cita,
		e.estado_cita 'estado',
		CONVERT(varchar(10), CONVERT(date, c.fecha_cita)) 'fecha_cita',
		REPLACE(REPLACE(RIGHT(CONCAT('0', CONVERT(varchar(15),c.hora_cita,100)), 7), 'PM', ' PM'), 'AM', ' AM') 'hora_cita',
		c.id_paciente,
		p.Nombre 'usuario',
		p.Id 'id_usuario',
		c.tipo
	FROM tbl_cita c
	INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita
	INNER JOIN tbl_psicologo p on p.Id = c.id_doctor_asignado
	WHERE (@id_estado = -1 or c.id_estado_cita = @id_estado)
	AND (@fecha = '-' or convert(varchar(10), convert(date, c.fecha_cita)) = @fecha)
	AND (@ver_sin_reserva = 2 OR DATEDIFF(DAY, fecha_cita, @f_actual) > @dif_dias)

	ORDER BY fecha_cita, hora_cita

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CITAS_USUARIO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_LISTAR_CITAS_USUARIO 1,-1,11,-1
CREATE PROCEDURE [dbo].[SP_LISTAR_CITAS_USUARIO]
(
	@id_usuario INT,
	@id_paciente INT,
	@id_doctor INT,
	@id_sede INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @id_tipousuario INT;
	DECLARE @dni_usuario VARCHAR(8);

	SELECT
		@id_tipousuario = u.id_tipousuario,
		@dni_usuario = u.num_documento
	FROM tbl_usuario u WHERE u.id_usuario=@id_usuario;

	IF (@id_tipousuario = 4)--PSICOLOGO
	BEGIN
		SET @id_doctor = (SELECT Id FROM tbl_psicologo WHERE DocumentoNumero=@dni_usuario);
	END

	SELECT
		c.id_cita,
		c.id_estado_cita,
		e.estado_cita 'estado',
		CONVERT(varchar(10), CONVERT(date, c.fecha_cita)) 'fecha_cita',
		REPLACE(REPLACE(RIGHT(CONCAT('0', CONVERT(varchar(15),c.hora_cita,100)), 7), 'PM', ' PM'), 'AM', ' AM') 'hora_cita',
		c.id_doctor_asignado,
		ps.Nombre 'doctor_asignado',
		c.tipo,
		pa.Id 'id_paciente',
		CONCAT(LTRIM(RTRIM(pa.Nombre)), ' ', LTRIM(RTRIM(pa.Apellido))) 'paciente',
		pa.Telefono 'telefono',
		c.Moneda 'moneda',
		c.Monto_pactado 'monto_pactado',
		c.Monto_pagado 'monto_pagado',
		c.Monto_pendiente 'monto_pendiente',
		c.id_servicio 'id_servicio',
		c.id_sede 'id_sede',
		isnull(p.esEvaluacion, cast(0 as bit)) 'esEvaluacion',
		case
			when p.Siglas is null then ''
			when p.Siglas = 'EG' then concat('(',p.Siglas,')')
			else concat('(',p.Siglas,c.orden,')')
		end 'siglas',
		ISNULL(c.feedback, CAST(0 AS BIT)) AS 'feedback', -- Aquí usamos ISNULL para garantizar que sea falso si está vacío
		c.comentario AS 'comentario',
		isnull(c.pago_gratis, 0) AS 'pago_gratis'
	FROM tbl_cita c
	INNER JOIN tbl_psicologo ps ON ps.Id = c.id_doctor_asignado
	INNER JOIN tbl_paciente pa ON pa.Id = c.id_paciente
	INNER JOIN tbl_estados_cita e ON e.id_estado_cita = c.id_estado_cita
	INNER JOIN Productos p on p.id = c.id_servicio
	WHERE c.tipo in ('CITA')
	AND c.id_estado_cita in (
		1,--citado
		2,--confirmado
		3 --atendido
	)
	AND (@id_paciente=-1 OR @id_paciente=pa.Id)
	AND (@id_doctor=-1 OR @id_doctor=c.id_doctor_asignado)
	AND (@id_sede=-1 OR @id_sede=c.id_sede)
	--AND c.id_usuario = @id_usuario
	order by (CAST(c.fecha_cita AS datetime) + CAST(c.hora_cita AS datetime))

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_CUADRE_CAJA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTAR_CUADRE_CAJA
CREATE PROCEDURE [dbo].[SP_LISTAR_CUADRE_CAJA]
(
	@usuario VARCHAR(20),
	@pagina INT,
	@tamanoPagina INT,
	@mes INT,
	@anio INT,
	@sede INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Inicio INT = (@Pagina - 1) * @TamanoPagina;

	SELECT
		paciente,
		fecha_transaccion,
		estado_cita,
		servicio,
		forma_pago,
		detalle_transferencia,
		importe,
		estado_orden,
		usuario,
		Sede
	FROM (
		SELECT
			pa.Nombre 'paciente',
			p.fecha_registro 'fecha_transaccion',
			ec.estado_cita,
			pr.Nombre 'servicio',
			fp.descripcion 'forma_pago',
			ISNULL(dt.descripcion, '') 'detalle_transferencia',
			CONCAT(c.Moneda,p.importe) 'importe',
			CASE c.Monto_pendiente
				WHEN 0.00 THEN 'Pagado'
				ELSE 'Pendiente'
			END 'estado_orden',
			s.Nombre 'Sede',
			p.usuario_registro 'usuario',
			ROW_NUMBER() OVER (ORDER BY p.id) AS Fila
		FROM tbl_pago p
		INNER JOIN tbl_cita c ON c.id_cita = p.id_cita
		INNER JOIN tbl_paciente pa ON pa.id = c.id_paciente
		INNER JOIN tbl_estados_cita ec ON ec.id_estado_cita = c.id_estado_cita
		INNER JOIN Productos pr ON pr.id = c.id_servicio
		INNER JOIN tbl_forma_pago fp ON fp.id = p.id_forma_pago
		LEFT JOIN tbl_detalle_transferencia dt ON dt.id = p.id_detalle_transferencia
		LEFT JOIN tbl_sede s ON s.Id=c.Id_sede
		WHERE 1=1
		--(@usuario = '' OR p.usuario_registro = @usuario)
		AND (@mes = -1 OR DATEPART(MONTH, p.fecha_registro) = @mes)
		AND (@anio = -1 OR DATEPART(YEAR, p.fecha_registro) = @anio)
		AND (@sede = -1 OR c.Id_sede = @sede)
	) AS Numerados
	WHERE Fila > @Inicio AND Fila <= (@Inicio + @TamanoPagina)
    ORDER BY Fila;

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DIAS_X_SEMANA_MES]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
exec SP_LISTAR_DIAS_X_SEMANA_MES 1,12,2024
*/
CREATE PROCEDURE [dbo].[SP_LISTAR_DIAS_X_SEMANA_MES]
(
	@numSemana INT,
	@mes INT,
	@año INT
)
AS
BEGIN
	SET LANGUAGE Spanish;

	DECLARE @dateSearch DATE = DATEFROMPARTS(@año, @mes, 1);

	DECLARE @Fechas TABLE ( Fecha DATE );
	DECLARE @Fechas2 TABLE ( ID INT IDENTITY(1,1) PRIMARY KEY, NumeroSemana INT, Fecha DATE, NombreDia VARCHAR(20), NumeroDia INT );
	DECLARE @DiasSemana TABLE ( Nombre VARCHAR(20), Orden INT );
	INSERT INTO @DiasSemana VALUES ('LUNES',1),('MARTES',2),('MIÉRCOLES',3),('JUEVES',4),('VIERNES',5),('SÁBADO',6),('DOMINGO',7);


	WITH DateTable AS
	(
		SELECT
			DATEADD(month, DATEDIFF(month, 0, @dateSearch), 0) AS [date]
		UNION ALL
		SELECT
			DATEADD(DAY, 1, [date])
		FROM DateTable
		WHERE DATEADD(DAY, 1, [date]) <= EOMONTH(@dateSearch)
	)

	INSERT INTO @Fechas
	SELECT
		CAST([date] AS DATE) 'Fecha'
	FROM DateTable;

	INSERT INTO @Fechas2
	SELECT
		DATEPART(WEEk, Fecha),
		Fecha,
		UPPER(DATENAME(WEEKDAY, Fecha)) 'NombreDia',
		0
	FROM @Fechas

	--UPDATE @Fechas2 SET NombreDia = 'LUNES' WHERE NombreDia = 'MONDAY';
	--UPDATE @Fechas2 SET NombreDia = 'MARTES' WHERE NombreDia = 'TUESDAY';
	--UPDATE @Fechas2 SET NombreDia = 'MIÉRCOLES' WHERE NombreDia = 'WEDNESDAY';
	--UPDATE @Fechas2 SET NombreDia = 'JUEVES' WHERE NombreDia = 'THURSDAY';
	--UPDATE @Fechas2 SET NombreDia = 'VIERNES' WHERE NombreDia = 'FRIDAY';
	--UPDATE @Fechas2 SET NombreDia = 'SÁBADO' WHERE NombreDia = 'SATURDAY';
	--UPDATE @Fechas2 SET NombreDia = 'DOMINGO' WHERE NombreDia = 'SUNDAY';

	UPDATE OA SET
		OA.NumeroDia = AN.Orden
	FROM @Fechas2 OA
	INNER JOIN @DiasSemana AN ON OA.NombreDia = AN.Nombre;

	DECLARE @primeraSemana INT, @ultimaSemana INT;
	DECLARE @primerDia INT, @ultimoDia INT;	
	SELECT TOP 1 @primerDia = NumeroDia, @primeraSemana=NumeroSemana FROM @Fechas2 ORDER BY ID ASC;
	SELECT TOP 1 @ultimoDia = NumeroDia, @ultimaSemana=NumeroSemana FROM @Fechas2 ORDER BY ID DESC;

	DECLARE @fechasFinal TABLE ( ID INT IDENTITY(1,1) PRIMARY KEY, NumeroSemana INT, Fecha VARCHAR(10), NombreDia VARCHAR(20), NumeroDia INT )

	INSERT INTO @fechasFinal
	SELECT TOP (@primerDia-1)
		1 'NumeroSemana',
		'' 'Fecha',
		Nombre 'NombreDia',
		Orden 'NumeroDia'
	FROM @DiasSemana
	UNION ALL
	SELECT
		(NumeroSemana - @primeraSemana + 1) 'NumeroSemana',
		CAST(Fecha AS VARCHAR(10)) 'Fecha',
		NombreDia,
		NumeroDia
	FROM @Fechas2
	UNION ALL
	SELECT
		(@ultimaSemana - @primeraSemana + 1) 'NumeroSemana',
		'' 'Fecha',
		Nombre 'NombreDia',
		Orden 'NumeroDia'
	FROM @DiasSemana
	WHERE Orden > @ultimoDia;

	SET LANGUAGE us_english;

	SELECT
		ff.ID 'Id',
		ff.NumeroSemana,
		ff.Fecha,
		ff.NombreDia,
		ff.NumeroDia
	FROM @fechasFinal ff
	WHERE ff.NumeroSemana=@numSemana
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_DISPONIBILIDAD_DOCTOR]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SP_LISTAR_DISPONIBILIDAD_DOCTOR 11,'2025-01-09'
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
		hora_calculo int,
		estado varchar(20),
		mostrar bit
	)

	declare @inicioLabores int, @finLabores int, @refrigerio VARCHAR(5);
	select
		@inicioLabores = cast(left(Inicio, 2) as int),
		@refrigerio = cast(left(Refrigerio, 2) as int),
		@finLabores = cast(left(Fin, 2) as int)
	from tbl_horarios_psicologo
	where Id_psicologo=@id_doctor AND Fecha=@fecha_;

	insert into @temp_horas select '07:00 AM', 7,  '', 0;
	insert into @temp_horas select '08:00 AM', 8,  '', 0;
	insert into @temp_horas select '09:00 AM', 9,  '', 0;
	insert into @temp_horas select '10:00 AM', 10, '', 0;
	insert into @temp_horas select '11:00 AM', 11, '', 0;
	insert into @temp_horas select '12:00 PM', 12, '', 0;
	insert into @temp_horas select '01:00 PM', 13, '', 0;
	insert into @temp_horas select '02:00 PM', 14, '', 0;
	insert into @temp_horas select '03:00 PM', 15, '', 0;
	insert into @temp_horas select '04:00 PM', 16, '', 0;
	insert into @temp_horas select '05:00 PM', 17, '', 0;
	insert into @temp_horas select '06:00 PM', 18, '', 0;
	insert into @temp_horas select '07:00 PM', 19, '', 0;
	insert into @temp_horas select '08:00 PM', 20, '', 0;
	insert into @temp_horas select '09:00 PM', 21, '', 0;

	update @temp_horas set mostrar=1 where hora_calculo between @inicioLabores and (@finLabores-1);
	update @temp_horas set estado = 'REFRIGERIO', mostrar=1 where hora_calculo=@refrigerio;
	delete from @temp_horas where mostrar=0;

	select
		t.hora_cita,
		case
			when t.estado <> '' then t.estado
			when c.id_cita is null then 'DISPONIBLE'
			else 'RESERVADO'
		end 'estado'
	from @temp_horas t
	left join tbl_cita c on c.id_doctor_asignado = @id_doctor and c.fecha_cita = @fecha_ and c.hora_cita = convert(time, convert(datetime, t.hora_cita, 0))
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_ENCUESTAS]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_listar_estudios_psicologo]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_listar_estudios_psicologo]
(
	@IdPsicologo INT
)
AS
BEGIN
	SELECT Id, IdPsicologo, GradoAcademico, Institucion, Carrera FROM tbl_estudios_psicologo
	WHERE IdPsicologo = @IdPsicologo
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HISTORIAL_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_HISTORIAL_CITA]
(
	@id_cita INT
)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT
		usuario_registra 'usuario',
		CONCAT(
				CONVERT(VARCHAR,fecha_registra,103),
				' ',
				RIGHT('0'+CONVERT(VARCHAR(15),CAST(fecha_registra AS TIME),100), 7)
			) 'fecha',
		evento
	FROM tbl_historial_cita h
	WHERE h.id_cita = @id_cita
	AND mostrar=1
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_HISTORIAL_PACIENTE]
(
	@id_paciente int
)
AS
BEGIN
	SET NOCOUNT ON;

	select distinct
		concat(p.Nombre,' ',p.Apellido) AS 'doctor',
		CONCAT(
			CONVERT(VARCHAR,h.fecha_registra,103),
			' ',
			RIGHT('0'+CONVERT(VARCHAR(15),CAST(h.fecha_registra AS TIME),100), 7)
		) 'fecha_registro',
		h.id_historial,
		h.fecha_registra 'fecha_orden'
	from tbl_cita c
	inner join tbl_psicologo p on p.Id=c.id_doctor_asignado
	inner join tbl_historial_cita h on h.id_cita=c.id_cita
	where h.mostrar=1
	and h.evento='ATENDIDO'
	and c.id_paciente=@id_paciente
	order by h.fecha_registra asc
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HORARIO_PSICOLOGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
exec SP_LISTAR_HORARIO_PSICOLOGO 11, '2024-12-06', '2025-01-07', ''
exec SP_LISTAR_HORARIO_PSICOLOGO 11, '2024-12-06', '2025-01-07', '*LU**MI**SA*'
*/
CREATE PROCEDURE [dbo].[SP_LISTAR_HORARIO_PSICOLOGO]
(
	@id_psicologo int,
	@inicio date,
	@fin date,
	@dias varchar(28)
)
AS
BEGIN
	SET NOCOUNT ON;

	SET LANGUAGE Spanish;
	DECLARE @fechas TABLE ( Fecha date, NombreDia varchar(20), Inicio varchar(20), Fin varchar(20) );
	DECLARE @fechas2 TABLE ( Fecha date, NombreDia varchar(20), Inicio varchar(20), Fin varchar(20) );

	WITH DateTable AS
	(
		SELECT
			DATEADD(month, DATEDIFF(month, 0, @inicio), 0) AS [date]
		UNION ALL
		SELECT
			DATEADD(DAY, 1, [date])
		FROM DateTable
		WHERE DATEADD(DAY, 1, [date]) <= EOMONTH(@inicio)
	)
	insert into @fechas
	SELECT distinct
		CAST([date] AS DATE),
		UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))),
		'',
		''
	FROM DateTable
	WHERE UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))) NOT IN ('DOMINGO');
	--AND CAST([date] AS DATE) between @inicio and @fin;

	WITH DateTable2 AS
	(
		SELECT
			DATEADD(month, DATEDIFF(month, 0, @fin), 0) AS [date]
		UNION ALL
		SELECT
			DATEADD(DAY, 1, [date])
		FROM DateTable2
		WHERE DATEADD(DAY, 1, [date]) <= EOMONTH(@fin)
	)
	insert into @fechas
	SELECT distinct
		CAST([date] AS DATE),
		UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))),
		'',
		''
	FROM DateTable2
	WHERE UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))) NOT IN ('DOMINGO')
	--AND CAST([date] AS DATE) between @inicio and @fin

	insert into @fechas2
	select distinct
		convert(varchar(10), f.Fecha) 'Fecha',
		f.NombreDia,
		'',
		''
	from @fechas f
	where f.Fecha between @inicio and @fin

	declare @filtroDias table ( dia varchar(20) )
	IF @dias LIKE '%*LU*%' BEGIN INSERT INTO @filtroDias SELECT 'LUNES' END
	IF @dias LIKE '%*MA*%' BEGIN INSERT INTO @filtroDias SELECT 'MARTES' END
	IF @dias LIKE '%*MI*%' BEGIN INSERT INTO @filtroDias SELECT 'MIÉRCOLES' END
	IF @dias LIKE '%*JU*%' BEGIN INSERT INTO @filtroDias SELECT 'JUEVES' END
	IF @dias LIKE '%*VI*%' BEGIN INSERT INTO @filtroDias SELECT 'VIERNES' END
	IF @dias LIKE '%*SA*%' BEGIN INSERT INTO @filtroDias SELECT 'SÁBADO' END
	IF @dias LIKE '%*DO*%' BEGIN INSERT INTO @filtroDias SELECT 'DOMINGO' END

	select
		ROW_NUMBER() OVER(ORDER BY f.Fecha ASC) 'Orden',
		isnull((select h.Id from tbl_horarios_psicologo h where h.Fecha=f.Fecha and h.Id_psicologo=@id_psicologo), 0) 'Id',
		convert(varchar(10), f.Fecha) 'Fecha',
		f.NombreDia,
		isnull((select h.Inicio from tbl_horarios_psicologo h where h.Fecha=f.Fecha and h.Id_psicologo=@id_psicologo), '-1') 'Inicio',
		isnull((select h.Refrigerio from tbl_horarios_psicologo h where h.Fecha=f.Fecha and h.Id_psicologo=@id_psicologo), '-1') 'Refrigerio',
		isnull((select h.Fin from tbl_horarios_psicologo h where h.Fecha=f.Fecha and h.Id_psicologo=@id_psicologo), '-1') 'Fin'
	from @fechas2 f
	where (((select COUNT(*) from @filtroDias) = 0) or f.NombreDia in (select * from @filtroDias))

	--select
	--	f.Fecha,
	--	f.Inicio,
	--	f.Fin,
	--	h.Inicio,
	--	h.Fin
	--from @fechas f
	--left join tbl_horarios_psicologo h on h.Fecha=f.Fecha
	--where h.Id_psicologo=4
	--order by f.Fecha asc

	--select * from tbl_horarios_psicologo where Id_psicologo=4
	--and Fecha between @inicio and @fin

	SET LANGUAGE us_english;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_HORARIOS_SEMANA_PSICOLOGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
exec SP_LISTAR_HORARIOS_SEMANA_PSICOLOGO '2025-01-20', '2025-01-26',7
*/
CREATE PROCEDURE [dbo].[SP_LISTAR_HORARIOS_SEMANA_PSICOLOGO]
(
	@inicio_ varchar(10),
	@fin_ varchar(10),
	@id_psicologo int
)
AS
BEGIN
	SET NOCOUNT ON;

	SET LANGUAGE Spanish;
	declare @inicio date = convert(date, @inicio_);
	declare @fin date = convert(date, @fin_);

	declare @horas table ( hora varchar(5), hora_formato varchar(8), tipo varchar(20) )
	insert into @horas select '06:00', '06:00 AM', 'HORARIO';
	insert into @horas select '07:00', '07:00 AM', 'HORARIO';
	insert into @horas select '08:00', '08:00 AM', 'HORARIO';
	insert into @horas select '09:00', '09:00 AM', 'HORARIO';
	insert into @horas select '10:00', '10:00 AM', 'HORARIO';
	insert into @horas select '11:00', '11:00 AM', 'HORARIO';
	insert into @horas select '12:00', '12:00 PM', 'HORARIO';
	insert into @horas select '13:00', '01:00 PM', 'HORARIO';
	insert into @horas select '14:00', '02:00 PM', 'HORARIO';
	insert into @horas select '15:00', '03:00 PM', 'HORARIO';
	insert into @horas select '16:00', '04:00 PM', 'HORARIO';
	insert into @horas select '17:00', '05:00 PM', 'HORARIO';
	insert into @horas select '18:00', '06:00 PM', 'HORARIO';
	insert into @horas select '19:00', '07:00 PM', 'HORARIO';
	insert into @horas select '20:00', '08:00 PM', 'HORARIO';
	insert into @horas select '21:00', '09:00 PM', 'HORARIO';
	insert into @horas select '22:00', '10:00 PM', 'HORARIO';

	--UPDATE @horas set tipo = 'REFRIGERIO' where hora in (select Refrigerio from tbl_horarios_psicologo where Id=@id_psicologo);

	declare @fechas table ( orden int identity(1,1) primary key, fecha date, inicio varchar(5), refrigerio varchar(5), fin varchar(5) )
	declare @fechasFinal table ( fecha_cita varchar(10), hora_cita varchar(8), tipo varchar(20) )

	insert into @fechas
	select
		Fecha, Inicio, Refrigerio, Fin
	from tbl_horarios_psicologo
	where Id_psicologo=@id_psicologo
	and Fecha between @inicio and @fin

	declare @i int = 1;
	declare @inicio_int int = 0, @refrigerio_int int = 0, @fin_int int = 0, @fecha date;
	while @i < (select COUNT(*)+1 from @fechas)
	begin
		select @inicio_int=CAST(LEFT(inicio, 2) AS int), @refrigerio_int=CAST(LEFT(refrigerio, 2) as int), @fin_int=CAST(LEFT(fin, 2) as int), @fecha = fecha from @fechas where orden=@i;
	
		insert into @fechasFinal
		select
			@fecha,
			hora_formato,
			tipo
		from @horas where CAST(LEFT(hora, 2) as int) between @inicio_int and @fin_int-1
		and hora not in (
			select CONVERT(varchar(5), hora_cita) from tbl_cita where id_doctor_asignado=@id_psicologo and id_estado_cita in (1,2,3) and fecha_cita=@fecha
		)

		set @i=@i+1;
	end

	declare @refrigerio table ( orden int identity(1,1) primary key, fecha varchar(10), hora varchar(5) )
	insert into @refrigerio
	select Fecha, Refrigerio from tbl_horarios_psicologo where Id_psicologo=@id_psicologo and Fecha between @inicio and @fin;

	declare @j int = 1, @hora_formato varchar(8), @fecha_buscar date;
	while (@j < (select COUNT(*)+1 from @refrigerio))
	begin
		select @hora_formato=h.hora_formato, @fecha_buscar=r.fecha from @refrigerio r inner join @horas h on h.hora=r.hora where r.orden=@j;
		update @fechasFinal set tipo='REFRIGERIO' where fecha_cita=@fecha_buscar and hora_cita=@hora_formato;
		set @j=@j+1;
	end

	select * from @fechasFinal

	SET LANGUAGE us_english;

END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_MENU]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_listar_pacientes]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_listar_pacientes]
AS
BEGIN
    SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, EstadoCivil, Sexo, Estado
    FROM tbl_paciente
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PACIENTES_COMBO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_PACIENTES_COMBO]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		Id 'id_paciente',
		CONCAT(LTRIM(RTRIM(Nombre)),' ',LTRIM(RTRIM(Apellido))) 'nombres'
	FROM tbl_paciente
	WHERE Estado=1
	order by Nombre, Apellido asc

END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PACIENTES_COMBO_DINAMICO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_PACIENTES_COMBO_DINAMICO]
    @Page INT,
    @PageSize INT,
    @Search NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@Page - 1) * @PageSize; -- Cálculo del offset basado en la página y el tamaño de la página
    DECLARE @IsNumericSearch BIT = 0; -- Variable para verificar si @Search es un número

    -- Verificar si el parámetro @Search es un número
    IF ISNUMERIC(@Search) = 1
    BEGIN
        SET @IsNumericSearch = 1; -- Si es un número, marcamos la variable
    END

    -- Consultar dependiendo de si @Search es numérico o no
    IF @IsNumericSearch = 1
    BEGIN
        -- Buscar por ID si @Search es un número
        SELECT
            Id AS 'id_paciente',
            CONCAT(LTRIM(RTRIM(Nombre)), ' ', LTRIM(RTRIM(Apellido))) AS 'nombres'
        FROM tbl_paciente
        WHERE Estado = 1
        AND Id = CAST(@Search AS INT)
        ORDER BY Nombre, Apellido ASC
        OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY; -- Usar el tamaño de la página para la cantidad de registros
    END
    ELSE
    BEGIN
        -- Buscar por Nombre o Apellido si @Search no es un número
        SELECT
            Id AS 'id_paciente',
            CONCAT(LTRIM(RTRIM(Nombre)), ' ', LTRIM(RTRIM(Apellido))) AS 'nombres'
        FROM tbl_paciente
        WHERE Estado = 1
        AND (Nombre LIKE '%' + @Search + '%' OR Apellido LIKE '%' + @Search + '%')
        ORDER BY Nombre, Apellido ASC
        OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY; -- Usar el tamaño de la página para la cantidad de registros
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_listar_pacientes_paginado]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_listar_pacientes_paginado]
    @Pagina INT,
    @TamanoPagina INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Inicio INT = (@Pagina - 1) * @TamanoPagina;

    SELECT
        Id,
        Nombre,
		Apellido,
        FechaNacimiento,
        DocumentoTipo,
        DocumentoNumero,
        Telefono,
        EstadoCivil,
        Sexo,
        Estado
    FROM (
        SELECT
            p.Id,
            p.Nombre,
			p.Apellido,
            p.FechaNacimiento,
            td.descripcion DocumentoTipo,
            p.DocumentoNumero,
            p.Telefono,
            p.EstadoCivil,
            p.Sexo,
            p.Estado,
            ROW_NUMBER() OVER (ORDER BY p.Nombre) AS Fila
        FROM tbl_paciente p
		INNER JOIN tbl_tipo_documento td ON td.id = p.DocumentoTipo
    ) AS Numerados
    WHERE Fila > @Inicio AND Fila <= (@Inicio + @TamanoPagina)
    ORDER BY Fila;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PAGOS_PENDIENTES]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_PAGOS_PENDIENTES]
(
	@id_paciente INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		c.id_cita,
		p.Nombre 'servicio',
		CONVERT(varchar(10), CONVERT(date, c.fecha_cita)) 'fecha_cita',
		c.usuario_registra,
		CONVERT(varchar(10), CONVERT(date, c.fecha_registra)) 'fecha_registra',
		ec.estado_cita,
		concat(c.Moneda,c.Monto_pactado) 'monto_pactado',
		concat(c.Moneda,c.Monto_pagado) 'monto_pagado',
		concat(c.Moneda,c.Monto_pendiente) 'monto_pendiente'
	FROM tbl_cita c
	INNER JOIN Productos p ON p.id = c.id_servicio
	INNER JOIN tbl_estados_cita ec ON ec.id_estado_cita = c.id_estado_cita
	WHERE (@id_paciente = -1 OR c.id_paciente = @id_paciente)
	AND c.Monto_pendiente > 0

END
GO
/****** Object:  StoredProcedure [dbo].[sp_listar_producto_paginado]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_listar_producto_paginado]
    @Pagina INT,
    @TamanoPagina INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Inicio INT = (@Pagina - 1) * @TamanoPagina;

    SELECT
        Id,
        Nombre,
        Precio,
        Color
    FROM (
        SELECT
            Id,
            Nombre,
            Precio,
            Color,
            ROW_NUMBER() OVER (ORDER BY Nombre) AS Fila
        FROM Productos
    ) AS Numerados
    WHERE Fila > @Inicio AND Fila <= (@Inicio + @TamanoPagina)
    ORDER BY Fila;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_listar_productos]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[sp_listar_productos] 
as

begin
	select * from Productos
end
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PRODUCTOS_COMBO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_PRODUCTOS_COMBO]
AS
BEGIN
	SET NOCOUNT ON;

	declare @moneda varchar(10)= 'S/.';

	declare @temp table (
		orden int identity(1,1) primary key,
		Id int,
		Nombre varchar(100),
		Alias varchar(100),
		Precio varchar(20),
		Color varchar(10),
		NumSesiones int
	)

	insert into @temp
	SELECT
		p.id 'Id',
		p.Nombre,
		CONCAT(p.Nombre, ' - ', @moneda, p.Precio) 'Alias',
		concat(@moneda,p.Precio) 'Precio',
		ISNULL(p.Color,'') 'Color',
		ISNULL(p.NumSesiones, 0) 'NumSesiones'
	FROM Productos p
	--WHERE EsTaller=0
	order by p.Nombre

	--insert into @temp
	--SELECT
	--	p.id 'Id',
	--	p.Nombre,
	--	CONCAT('TALLER: ',p.Nombre, ' - ', @moneda, p.Precio) 'Alias',
	--	concat(@moneda,p.Precio) 'Precio',
	--	ISNULL(p.Color,'') 'Color'
	--FROM Productos p
	--WHERE EsTaller=1
	--order by p.Nombre

	select * from @temp

END

GO
/****** Object:  StoredProcedure [dbo].[sp_listar_psicologos]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_listar_psicologos]
AS
BEGIN
    SELECT Id, Nombre, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, Especialidad, Direccion, Distrito, Estado
    FROM tbl_psicologo
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PSICOLOGOS_COMBO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAR_PSICOLOGOS_COMBO]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		p.Id 'id_psicologo',
		CONCAT(LTRIM(RTRIM(p.Nombre)),' ',LTRIM(RTRIM(p.Apellido))) 'nombres',
		isnull((case
			when exists (select * from tbl_sede_usuario s where s.Id_psicologo=p.Id and s.Principal in (1,0) )
				then CONCAT((select CONVERT(varchar(10),s.Id_sede) from tbl_sede_usuario s where s.id_psicologo=p.Id and s.Principal=1),'/',(select CONVERT(varchar(10), s.Id_sede) from tbl_sede_usuario s where s.id_psicologo=p.Id and s.Principal=0))
			else (select CONVERT(varchar(10),s.Id_sede) from tbl_sede_usuario s where s.id_psicologo=p.Id and s.Principal=1) 
		end), '-1') 'sedes'
	FROM tbl_psicologo p
	WHERE p.Estado=1
	order by p.Nombre, p.Apellido asc

END


GO
/****** Object:  StoredProcedure [dbo].[sp_listar_psicologos_paginado]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_listar_psicologos_paginado]
(
	@Pagina INT,
    @TamanoPagina INT
)
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @Inicio INT = (@Pagina - 1) * @TamanoPagina;

    SELECT
		Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, Refrigerio, Especialidad, Direccion, Distrito, Estado
    FROM (
        SELECT
            p.Id, p.Nombre, p.Apellido, p.FechaNacimiento, td.descripcion DocumentoTipo, p.DocumentoNumero, p.Telefono, p.Refrigerio, p.Especialidad, p.Direccion, p.Distrito, p.Estado,
            ROW_NUMBER() OVER (ORDER BY p.Nombre) AS Fila
        FROM tbl_psicologo p
		INNER JOIN tbl_tipo_documento td on td.id = p.DocumentoTipo
    ) AS Numerados
    WHERE Fila > @Inicio AND Fila <= (@Inicio + @TamanoPagina)
    ORDER BY Fila;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_SEDES_COMBO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_SEDES_COMBO]
AS
BEGIN

	SELECT
		Id 'Id_Sede',
		Nombre
	FROM tbl_sede

END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_SEDES_X_USUARIO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SP_LISTAR_SEDES_X_USUARIO 11
CREATE PROCEDURE [dbo].[SP_LISTAR_SEDES_X_USUARIO]
(
	@id_psicologo INT
)
AS
BEGIN

	--DECLARE @f_actual DATE = dbo.Get_date();
	--declare @dni varchar(8) = (select num_documento from tbl_usuario where id_usuario=@id_usuario);
	--declare @id_psicologo int = (select Id from tbl_psicologo where DocumentoNumero=@dni);
	
	SELECT distinct
		s.Id 'Id_Sede',
		s.Nombre
	FROM tbl_usuario u
	LEFT JOIN tbl_sede_usuario su ON su.Id_psicologo=@id_psicologo
	INNER JOIN tbl_sede s ON s.Id=su.Id_sede
	WHERE su.Id_psicologo=@id_psicologo

END

GO
/****** Object:  StoredProcedure [dbo].[sp_listar_ubigeos]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_listar_ubigeos]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT -1 Id, '-1' CodUbigeo, '' Departamento, '' Provincia, 'Seleccionar' Distrito
	union all
	SELECT Id, CodUbigeo, Departamento, Provincia, Distrito FROM tbl_ubigeo
	WHERE Departamento = 'Lima'
	AND Provincia = 'Lima'
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_VACACIONES_PSICOLOGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
exec SP_LISTAR_VACACIONES_PSICOLOGO 11, '2000-01-01', '2000-12-31',2025
*/
CREATE PROCEDURE [dbo].[SP_LISTAR_VACACIONES_PSICOLOGO]
(
	@id_psicologo int,
	@inicio date,
	@fin date,
	@año int
)
AS
BEGIN
	SET NOCOUNT ON;

	SET LANGUAGE Spanish;
	DECLARE @fechas TABLE ( Fecha date, NombreDia varchar(20), Inicio varchar(20), Fin varchar(20) );
	DECLARE @fechas2 TABLE ( Fecha date, NombreDia varchar(20), Inicio varchar(20), Fin varchar(20) );

	insert into @fechas
	select
		v.Fecha,
		UPPER(DATENAME(WEEKDAY, CAST(v.Fecha AS DATE))),
		'',
		''
	from tbl_vacaciones_psicologo v
	where v.Id_psicologo=@id_psicologo
	and DATEPART(year, v.Fecha)=@año

	--WITH DateTable AS
	--(
	--	SELECT
	--		DATEADD(month, DATEDIFF(month, 0, '2025-01-01'), 0) AS [date]
	--	UNION ALL
	--	SELECT
	--		DATEADD(DAY, 1, [date])
	--	FROM DateTable
	--	WHERE DATEADD(DAY, 1, [date]) <= EOMONTH('2025-01-01')
	--)
	----insert into @fechas
	--SELECT distinct
	--	CAST([date] AS DATE),
	--	UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))),
	--	'',
	--	''
	--FROM DateTable
	--WHERE UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))) NOT IN ('SÁBADO','DOMINGO');

	--WITH DateTable2 AS
	--(
	--	SELECT
	--		DATEADD(month, DATEDIFF(month, 0, @fin), 0) AS [date]
	--	UNION ALL
	--	SELECT
	--		DATEADD(DAY, 1, [date])
	--	FROM DateTable2
	--	WHERE DATEADD(DAY, 1, [date]) <= EOMONTH(@fin)
	--)
	--insert into @fechas
	--SELECT distinct
	--	CAST([date] AS DATE),
	--	UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))),
	--	'',
	--	''
	--FROM DateTable2
	--WHERE UPPER(DATENAME(WEEKDAY, CAST([date] AS DATE))) NOT IN ('SÁBADO','DOMINGO')

	insert into @fechas2
	select distinct
		convert(varchar(10), f.Fecha) 'Fecha',
		f.NombreDia,
		'',
		''
	from @fechas f
	--where f.Fecha between @inicio and @fin

	select
		ROW_NUMBER() OVER(ORDER BY f.Fecha ASC) 'Orden',
		isnull((select h.Id from tbl_vacaciones_psicologo h where h.Fecha=f.Fecha and h.Id_psicologo=@id_psicologo), 0) 'Id',
		convert(varchar(10), f.Fecha) 'Fecha',
		f.NombreDia,
		'-' 'Inicio',
		'-' 'Refrigerio',
		'-' 'Fin',
		0 'Eliminar'
	from @fechas2 f

	SET LANGUAGE us_english;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_paciente]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_paciente]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener los datos del paciente según el ID
    SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, EstadoCivil, Sexo, Estado
    FROM [dbo].[tbl_paciente]
    WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_paciente_paginado]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_paciente_paginado]
    @Nombre NVARCHAR(255) = NULL, -- Parámetro para el nombre del paciente (opcional)
    @NumeroPagina INT = 1, -- Número de página (default: 1)
    @TamanoPagina INT = 10 -- Tamaño de la página (default: 10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Calcular el índice de la primera fila de la página actual
    DECLARE @Inicio INT = (@NumeroPagina - 1) * @TamanoPagina + 1;
    DECLARE @Fin INT = @NumeroPagina * @TamanoPagina;

    -- Seleccionar los datos de pacientes con paginación y filtrado por nombre si se proporciona
    SELECT Id, Nombre, Apellido, FechaNacimiento, DocumentoTipo, DocumentoNumero, Telefono, EstadoCivil, Sexo, Estado
    FROM (
        SELECT
            p.Id, p.Nombre, p.Apellido, p.FechaNacimiento, td.descripcion DocumentoTipo, p.DocumentoNumero, p.Telefono, p.EstadoCivil, p.Sexo, p.Estado,
            ROW_NUMBER() OVER (ORDER BY p.Id) AS RowNum
        FROM [dbo].[tbl_paciente] p
		INNER JOIN tbl_tipo_documento td ON td.id = p.DocumentoTipo
        WHERE (@Nombre IS NULL OR (Nombre LIKE '%' + @Nombre + '%' OR Apellido LIKE '%' + @Nombre + '%'))
    ) AS PacientesPaginados
    WHERE RowNum BETWEEN @Inicio AND @Fin;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_producto_paginado]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_producto_paginado]
    @Nombre NVARCHAR(255) = NULL, -- Parámetro para el nombre del paciente (opcional)
    @NumeroPagina INT = 1, -- Número de página (default: 1)
    @TamanoPagina INT = 10 -- Tamaño de la página (default: 10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Calcular el índice de la primera fila de la página actual
    DECLARE @Inicio INT = (@NumeroPagina - 1) * @TamanoPagina + 1;
    DECLARE @Fin INT = @NumeroPagina * @TamanoPagina;

    -- Seleccionar los datos de pacientes con paginación y filtrado por nombre si se proporciona
    SELECT Id, Nombre, Precio, Color
    FROM (
        SELECT
            Id, Nombre, Precio, Color,
            ROW_NUMBER() OVER (ORDER BY Id) AS RowNum
        FROM Productos
        WHERE (@Nombre IS NULL OR Nombre LIKE '%' + @Nombre + '%')
    ) AS ProductosPaginados
    WHERE RowNum BETWEEN @Inicio AND @Fin;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_productos]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_productos]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener los datos del paciente según el ID
    SELECT * 
    FROM Productos
    WHERE id = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_psicologo]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_obtener_psicologo]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener los datos del psicologo según el ID
    SELECT
		p.Id,
		p.Nombre,
		p.Apellido,
		p.FechaNacimiento,
		p.DocumentoTipo,
		p.DocumentoNumero,
		p.Telefono,
		p.Refrigerio,
		isnull(p.InicioLabores,'-1') 'InicioLabores',
		isnull(p.FinLabores,'-1') 'FinLabores',
		isnull(su1.Id_sede, -1) 'IdSedePrincipal',
		isnull(su2.Id_sede, -1) 'IdSedeSecundaria',
		p.Especialidad,
		p.Direccion,
		p.Distrito,
		p.Estado
    FROM [dbo].[tbl_psicologo] p
	LEFT JOIN tbl_sede_usuario su1 ON su1.Id_psicologo=p.Id and su1.Principal=1
	LEFT JOIN tbl_sede_usuario su2 ON su2.Id_psicologo=p.Id and su2.Principal=0
    WHERE p.Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_PUNTOS_VISITADOS]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_CITA]
(
	@id_cita int,
	@id_paciente int,
	@fecha_cita varchar(10),
	@hora_cita varchar(8),
	@id_doctor int,
	@monto_pactado decimal(10,2) = null,
	@id_servicio int,
	@id_sede int,
	@usuario varchar(50),
	@adicional varchar(2),
	@feedback bit = NULL,            -- Nuevo parámetro
    @comentario varchar(500) = NULL, -- Nuevo parámetro
	@orden int = 0
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @estado_cita int = 1;
	declare @fecha_cita_ date = convert(date, @fecha_cita);
	declare @hora_cita_ time = convert(time, convert(datetime, @hora_cita, 0));
	declare @fecha_hora_cita_ datetime = CAST(@fecha_cita_ AS DATETIME) + CAST(@hora_cita_ AS DATETIME);

	declare @moneda varchar(10) = 'S/.';
	declare @inicio time = convert(time, convert(datetime, '07:00 AM', 0));
	declare @fin time = convert(time, convert(datetime, '09:00 PM', 0));
	declare @siglas varchar(20) = (select Siglas from Productos where id=@id_servicio);
	set @monto_pactado = (select Precio from Productos where id=@id_servicio);

	if (@adicional = 'SI')
	begin
		set @monto_pactado = 0.00;
	end

	if exists (select * from tbl_vacaciones_psicologo where Id_psicologo=@id_doctor and Fecha=@fecha_cita)
	begin
		SELECT 'La fecha seleccionada es un día registrado como vacaciones.' AS 'rpta';
	end
	else
	begin

		IF @fecha_hora_cita_ < dbo.Get_date()
		BEGIN
			SELECT 'La fecha y hora seleccionados son incorrectos.' AS 'rpta';
		END
		ELSE
		BEGIN
			IF @hora_cita_ BETWEEN @inicio AND @fin
			BEGIN
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
							INSERT INTO tbl_cita (id_paciente, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo, Moneda, Monto_pactado, Monto_pagado, Monto_pendiente, id_servicio, id_sede, usuario_registra, fecha_registra, feedback, comentario, orden, pago_gratis)
							VALUES (@id_paciente, @fecha_cita_, @hora_cita_, @id_doctor, @estado_cita, 'CITA', @moneda, @monto_pactado, 0.00, @monto_pactado, @id_servicio, @id_sede, @usuario, dbo.Get_date(), @feedback, @comentario, @orden, (case when @siglas = 'EG' then 1 else 0 end));

							set @id_cita = @@IDENTITY;
							insert into tbl_historial_cita select @id_cita, 1, (select ec.estado_cita from tbl_estados_cita ec WHERE ec.id_estado_cita=@estado_cita), @usuario, dbo.Get_date();

							SELECT 'OK' AS 'rpta';
						END
					END
					ELSE
					IF @id_cita > 0
					BEGIN
						IF EXISTS (SELECT * FROM tbl_cita WHERE id_doctor_asignado = @id_doctor and hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_estado_cita <> 4)
						BEGIN
							SELECT 'Ya hay una cita registrada en el horario seleccionado.' AS 'rpta';
						END
						ELSE
						BEGIN
							--verificar 24 horas restantes para la cita
							declare @fecha_hora_actual datetime = dbo.Get_date();
							declare @fecha_hora_cita datetime = (select (CAST(fecha_cita AS datetime) + CAST(hora_cita AS datetime)) from tbl_cita where id_cita = @id_cita);
							declare @mins_x_dia int = 1440;
							declare @mins_hasta_cita int = datediff(minute,@fecha_hora_actual, @fecha_hora_cita);
						
							if (@mins_hasta_cita < @mins_x_dia)
							begin
								SELECT 'La reprogramación de citas es hasta 24 horas antes.' AS 'rpta';
							end
							else
							begin
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
									comentario = @comentario
								WHERE id_cita = @id_cita;

								insert into tbl_historial_cita select @id_cita, 0, 'REPROGRAMACIÓN', @usuario, dbo.Get_date();

								SELECT 'OK' AS 'rpta';
							end
						END
					END

				END
			END
			ELSE
			BEGIN
				SELECT 'El registro de citas debe ser entre las 08:00 AM y 05:00 PM.' AS 'rpta';
			END
		END

	end

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_CUESTIONARIO]    Script Date: 13/02/2025 17:21:26 ******/
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
	declare @fecha_cita_ date = convert(date, dateadd(day, 1, dbo.Get_date()) );
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

		insert into tbl_cita (id_paciente, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo)
		values (@id_usuario, @fecha_cita_, null, @id_doctor, @estado_cita, 'CUESTIONARIO');

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

		insert into tbl_cita (id_paciente, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo)
		values (@id_usuario, @fecha_cita_, @hora_cita, @id_doctor, @estado_cita, 'CITA');

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
		--values (@id_usuario, @fecha_cita_, null, @id_doctor, @estado_cita, dbo.Get_date(), 'CUESTIONARIO');

		SELECT 'Gracias por participar en el cuestionario' AS 'rpta';

	end

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_ESTADO_CUESTIONARIO]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_FLUJO]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_HISTORIAL_PACIENTE]    Script Date: 13/02/2025 17:21:26 ******/
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

		declare @fecha date = convert(date,dbo.Get_date());
		declare @hora time = convert(time,dbo.Get_date());

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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_INVITADO]    Script Date: 13/02/2025 17:21:26 ******/
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

		declare @nuevo_contenido_html nvarchar(max) = '<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,dbo.Get_date()),5) + '</div></li>';

		insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
		values (@id_invitado, 'text', 'Hola, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');
	end

	select @id_invitado 'id_invitado'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PAGO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRAR_PAGO]
(
	@id_cita INT,
	@id_forma_pago INT,
	@id_detalle_transferencia INT,
	@importe DECIMAL(10,2),
	@usuario varchar(20),
	@comentario varchar(50) = null
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @hora_limite_pago INT = 23;
	DECLARE @hora_pago INT = DATEPART(HOUR, dbo.Get_date());

	if (@id_forma_pago != 1)
	BEGIN
		SET @id_detalle_transferencia = -1;
	END

	IF (@hora_pago < @hora_limite_pago)
	BEGIN
		INSERT INTO tbl_pago (id_cita, id_forma_pago, id_detalle_transferencia, importe, fecha_registro, usuario_registro, comentario)
		VALUES (@id_cita, @id_forma_pago, @id_detalle_transferencia, @importe, dbo.Get_date(), @usuario, @comentario);

		UPDATE tbl_cita SET
			Monto_pagado = Monto_pagado + @importe,
			Monto_pendiente = Monto_pactado - (Monto_pagado + @importe)
		WHERE id_cita=@id_cita;

		SELECT 'OK' AS 'rpta';
	END
	ELSE
	BEGIN
		SELECT 'La hora límite para el registro de pagos son las 23:00' AS 'rpta';
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTO_VISITADO]    Script Date: 13/02/2025 17:21:26 ******/
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
	values (@punto_visitado, @visitante, dbo.Get_date())

	select 'OK' 'rpta'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_PUNTUACION]    Script Date: 13/02/2025 17:21:26 ******/
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

	declare @hora varchar(8) = convert(varchar(8),convert(time,dbo.Get_date()))
	declare @fecha varchar(10) = convert(date,dbo.Get_date())

	declare @resultado varchar(20) = case when @puntuacion between 1 and 6 then 'Detractor' when @puntuacion between 7 and 8 then 'Nulo' else 'Promotor' end;

	insert into tbl_encuesta select @id_usuario, @puntuacion, @hora, @fecha, @resultado;

	update tbl_resumen_flujo set
		resultado = 'CUESTIONARIO_OK'
	where resultado in ('CUESTIONARIO*','CUESTIONARIO**') and id_usuario = @id_usuario

	--update tbl_flujos set
	--	habilitado = 0
	--where id_usuario = @id_usuario;
	--declare @nuevo_contenido_html varchar(max)  = '<li><div class="chat-img"><img src="https://localhost:44383/images/bot.jpg" class=""/></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,dbo.Get_date()),5) + '</div></li>'

	--insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
	--values (@id_usuario, 'text', 'Hola, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');

	select 'OK' 'rpta';

END

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_TICKET]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_USUARIO]    Script Date: 13/02/2025 17:21:26 ******/
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

	--		declare @nuevo_contenido_html nvarchar(max) = '<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">' + left(convert(time,dbo.Get_date()),5) + '</div></li>';

	--		insert into tbl_flujos (id_usuario, tipo, contenido_texto, contenido_html, habilitado, remitente)
	--		values (@id_usuario, 'text', 'Hola, ¿cómo puedo ayudarte?', @nuevo_contenido_html, 1, 'bot');

	--		insert into tbl_linea select @linea, @id_tipolinea, @id_usuario, 1;
	--		set @rpta = 'OK'
	--	end
	--end

	select @rpta 'rpta'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRAR_VISITA]    Script Date: 13/02/2025 17:21:26 ******/
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

	insert into tbl_visitas values (@visitante, dbo.Get_date())

	SELECT 'OK' 'rpta'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_NPS]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_CITA]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VALIDAR_CITA]
(
	@id_cita int,
	@id_paciente int,
	@fecha_cita varchar(10),
	@hora_cita varchar(8),
	@id_doctor int,
	@monto_pactado decimal(10,2) = null,
	@id_servicio int,
	@id_sede int,
	@usuario varchar(50),
	@adicional varchar(2),
	@feedback bit = NULL,            -- Nuevo parámetro
    @comentario varchar(500) = NULL, -- Nuevo parámetro
	@orden int = 0
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @estado_cita int = 1;
	declare @fecha_cita_ date = convert(date, @fecha_cita);
	declare @hora_cita_ time = convert(time, convert(datetime, @hora_cita, 0));
	declare @fecha_hora_cita_ datetime = CAST(@fecha_cita_ AS DATETIME) + CAST(@hora_cita_ AS DATETIME);

	declare @moneda varchar(10) = 'S/.';
	declare @inicio time = convert(time, convert(datetime, '07:00 AM', 0));
	declare @fin time = convert(time, convert(datetime, '09:00 PM', 0));

	set @monto_pactado = (select Precio from Productos where id=@id_servicio);
	if (@adicional = 'SI')
	begin
		set @monto_pactado = 0.00;
	end

	IF @fecha_hora_cita_ < dbo.Get_date()
	BEGIN
		SELECT 'La fecha y hora seleccionados son incorrectos.' AS 'rpta';
	END
	ELSE
	BEGIN
		IF @hora_cita_ BETWEEN @inicio AND @fin
		BEGIN
			IF EXISTS (SELECT * FROM tbl_cita WHERE hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_doctor_asignado = @id_doctor and id_estado_cita <> 4)
			BEGIN
				SELECT 'Ya hay una cita registrada:' AS 'rpta';
			END
			ELSE
			BEGIN

				IF EXISTS (SELECT * FROM tbl_cita WHERE id_doctor_asignado = @id_doctor and hora_cita = @hora_cita_ and fecha_cita = @fecha_cita_ and id_cita <> @id_cita and id_estado_cita <> 4)
				BEGIN
					SELECT 'Ya hay una cita registrada:' AS 'rpta';
				END
				ELSE
				BEGIN
					--INSERT INTO tbl_cita (id_paciente, fecha_cita, hora_cita, id_doctor_asignado, id_estado_cita, tipo, Moneda, Monto_pactado, Monto_pagado, Monto_pendiente, id_servicio, id_sede, usuario_registra, fecha_registra, feedback, comentario, orden)
					--VALUES (@id_paciente, @fecha_cita_, @hora_cita_, @id_doctor, @estado_cita, 'CITA', @moneda, @monto_pactado, 0.00, @monto_pactado, @id_servicio, @id_sede, @usuario, dbo.Get_date(), @feedback, @comentario, @orden);

					--set @id_cita = @@IDENTITY;
					--insert into tbl_historial_cita select @id_cita, 1, (select ec.estado_cita from tbl_estados_cita ec WHERE ec.id_estado_cita=@estado_cita), @usuario, dbo.Get_date();

					SELECT 'OK' AS 'rpta';
				END

			END
		END
		ELSE
		BEGIN
			SELECT 'El registro de citas debe ser entre las 07:00 AM y 09:00 PM.' AS 'rpta';
		END
	END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_FLUJO_ACTUAL]    Script Date: 13/02/2025 17:21:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_VALIDAR_USUARIO]    Script Date: 13/02/2025 17:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
			isnull(p.Id, 0) 'id_psicologo',
			tu.tipousuario,
			u.tipo_documento,
			u.num_documento,
			u.test_actual,
			u.login,
			u.id_sede 'id_sede',
			'OK' 'validacion'
		from tbl_usuario u
		inner join tbl_tipousuario tu on tu.id_tipousuario = u.id_tipousuario
		left join tbl_psicologo p on p.DocumentoNumero=u.num_documento
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
			0 id_psicologo,
			'' tipousuario,
			'' tipo_documento,
			'' num_documento,
			0 test_actual,
			'' login,
			0 'id_sede',
			@error 'validacion'
	end

end

GO
/****** Object:  StoredProcedure [dbo].[SP_VISITAS]    Script Date: 13/02/2025 17:21:26 ******/
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
ALTER DATABASE [DB_PSYCO] SET  READ_WRITE 
GO
