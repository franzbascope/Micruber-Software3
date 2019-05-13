USE [micruberDB]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_rutaVehiculo_tbl_rutas_vehiculos]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutaVehiculo]'))
ALTER TABLE [dbo].[tbl_rutas_rutaVehiculo] DROP CONSTRAINT [FK_tbl_rutas_rutaVehiculo_tbl_rutas_vehiculos]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_rutaVehiculo_tbl_rutas_rutas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutaVehiculo]'))
ALTER TABLE [dbo].[tbl_rutas_rutaVehiculo] DROP CONSTRAINT [FK_tbl_rutas_rutaVehiculo_tbl_rutas_rutas]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_lineas_tbl_rutas_rutas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_lineas]'))
ALTER TABLE [dbo].[tbl_rutas_lineas] DROP CONSTRAINT [FK_tbl_rutas_lineas_tbl_rutas_rutas]
GO
/****** Object:  Table [dbo].[tbl_rutas_vehiculos]    Script Date: 5/13/2019 1:27:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_vehiculos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_vehiculos]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutaVehiculo]    Script Date: 5/13/2019 1:27:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutaVehiculo]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_rutaVehiculo]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutas]    Script Date: 5/13/2019 1:27:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_rutas]
GO
/****** Object:  Table [dbo].[tbl_rutas_lineas]    Script Date: 5/13/2019 1:27:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_lineas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_lineas]
GO
/****** Object:  Table [dbo].[tbl_rutas_lineas]    Script Date: 5/13/2019 1:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_lineas](
	[lineaId] [int] IDENTITY(1,1) NOT NULL,
	[numeroLinea] [varchar](10) NULL,
	[rutaId] [int] NULL,
 CONSTRAINT [PK_tbl_rutas_lineas] PRIMARY KEY CLUSTERED 
(
	[lineaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutas]    Script Date: 5/13/2019 1:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_rutas](
	[rutaId] [int] IDENTITY(1,1) NOT NULL,
	[posX] [decimal](20, 10) NULL,
	[posY] [decimal](20, 10) NULL,
 CONSTRAINT [PK_tbl_rutas_rutas] PRIMARY KEY CLUSTERED 
(
	[rutaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutaVehiculo]    Script Date: 5/13/2019 1:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_rutaVehiculo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vehiculoId] [int] NULL,
	[rutaId] [int] NULL,
 CONSTRAINT [PK_tbl_rutas_rutaVehiculo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rutas_vehiculos]    Script Date: 5/13/2019 1:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_vehiculos](
	[vehiculoId] [int] IDENTITY(1,1) NOT NULL,
	[capacidad] [int] NULL,
	[placa] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_rutas_vehiculos] PRIMARY KEY CLUSTERED 
(
	[vehiculoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_rutas_lineas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_lineas_tbl_rutas_rutas] FOREIGN KEY([rutaId])
REFERENCES [dbo].[tbl_rutas_rutas] ([rutaId])
GO
ALTER TABLE [dbo].[tbl_rutas_lineas] CHECK CONSTRAINT [FK_tbl_rutas_lineas_tbl_rutas_rutas]
GO
ALTER TABLE [dbo].[tbl_rutas_rutaVehiculo]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_rutaVehiculo_tbl_rutas_rutas] FOREIGN KEY([rutaId])
REFERENCES [dbo].[tbl_rutas_rutas] ([rutaId])
GO
ALTER TABLE [dbo].[tbl_rutas_rutaVehiculo] CHECK CONSTRAINT [FK_tbl_rutas_rutaVehiculo_tbl_rutas_rutas]
GO
ALTER TABLE [dbo].[tbl_rutas_rutaVehiculo]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_rutaVehiculo_tbl_rutas_vehiculos] FOREIGN KEY([vehiculoId])
REFERENCES [dbo].[tbl_rutas_vehiculos] ([vehiculoId])
GO
ALTER TABLE [dbo].[tbl_rutas_rutaVehiculo] CHECK CONSTRAINT [FK_tbl_rutas_rutaVehiculo_tbl_rutas_vehiculos]
GO

DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,3
           ,0)
GO

