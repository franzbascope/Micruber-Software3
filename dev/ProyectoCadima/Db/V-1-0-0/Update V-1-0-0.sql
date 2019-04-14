USE master
go
CREATE DATABASE [bdTienda] 
GO

USE [bdTienda]
GO
/****** Object:  Table [dbo].[tblRol]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRol](
	[rolId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](250) NULL,
	[estado] [nchar](18) NULL,
 CONSTRAINT [XPKtblRol] PRIMARY KEY CLUSTERED 
(
	[rolId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuario]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUsuario](
	[usuarioId] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[apellido] [nvarchar](50) NULL,
	[correo] [nvarchar](50) NULL,
	[contraseña] [char](16) NOT NULL,
	[tipoUsuario] [nvarchar](50) NULL,
 CONSTRAINT [XPKtblUsuario] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPermiso]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPermiso](
	[permisoId] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](250) NULL,
	[url] [nvarchar](250) NULL,
	[posicion] [nchar](10) NULL,
	[estado] [nchar](18) NULL,
 CONSTRAINT [XPKtblPermiso] PRIMARY KEY CLUSTERED 
(
	[permisoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuarioRol]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsuarioRol](
	[idUsuarioRol] [int] IDENTITY(1,1) NOT NULL,
	[usuarioId] [int] NOT NULL,
	[rolId] [int] NOT NULL,
	[estado] [nchar](18) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuarioPermiso]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsuarioPermiso](
	[usuarioId] [int] NOT NULL,
	[permisoId] [int] NOT NULL,
	[estado] [nchar](18) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRolPermiso]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRolPermiso](
	[idRolPermiso] [int] IDENTITY(1,1) NOT NULL,
	[rolId] [int] NOT NULL,
	[permisoId] [int] NOT NULL,
	[estado] [nchar](18) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRecuperacion]    Script Date: 09/23/2017 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRecuperacion](
	[recuperacionId] [int] IDENTITY(1,1) NOT NULL,
	[usuarioId] [int] NOT NULL,
	[codigoGenerado] [nvarchar](15) NULL,
	[fechaGenerado] [datetime] NULL,
	[fechaActual] [datetime] NULL,
	[tiempo] [int] NULL,
	[estado] [char](15) NULL,
 CONSTRAINT [XPKtblRecuperacion] PRIMARY KEY CLUSTERED 
(
	[recuperacionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_tblRecuperacion_tblUsuario]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblRecuperacion]  WITH CHECK ADD  CONSTRAINT [FK_tblRecuperacion_tblUsuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tblRecuperacion] CHECK CONSTRAINT [FK_tblRecuperacion_tblUsuario]
GO
/****** Object:  ForeignKey [FK_tblRolPermiso_tblPermiso]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblRolPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblRolPermiso_tblPermiso] FOREIGN KEY([permisoId])
REFERENCES [dbo].[tblPermiso] ([permisoId])
GO
ALTER TABLE [dbo].[tblRolPermiso] CHECK CONSTRAINT [FK_tblRolPermiso_tblPermiso]
GO
/****** Object:  ForeignKey [FK_tblRolPermiso_tblRol]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblRolPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblRolPermiso_tblRol] FOREIGN KEY([rolId])
REFERENCES [dbo].[tblRol] ([rolId])
GO
ALTER TABLE [dbo].[tblRolPermiso] CHECK CONSTRAINT [FK_tblRolPermiso_tblRol]
GO
/****** Object:  ForeignKey [FK_tblUsuarioPermiso_tblPermiso]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblUsuarioPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioPermiso_tblPermiso] FOREIGN KEY([permisoId])
REFERENCES [dbo].[tblPermiso] ([permisoId])
GO
ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tblPermiso]
GO
/****** Object:  ForeignKey [FK_tblUsuarioPermiso_tblUsuario]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblUsuarioPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioPermiso_tblUsuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tblUsuario]
GO
/****** Object:  ForeignKey [FK_tblUsuarioRol_tblRol1]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblUsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioRol_tblRol1] FOREIGN KEY([rolId])
REFERENCES [dbo].[tblRol] ([rolId])
GO
ALTER TABLE [dbo].[tblUsuarioRol] CHECK CONSTRAINT [FK_tblUsuarioRol_tblRol1]
GO
/****** Object:  ForeignKey [FK_tblUsuarioRol_tblUsuario]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblUsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioRol_tblUsuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tblUsuarioRol] CHECK CONSTRAINT [FK_tblUsuarioRol_tblUsuario]
GO
