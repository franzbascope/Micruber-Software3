USE [micruberDB]
GO
ALTER TABLE [dbo].[tbl_seg_usuario]
ADD [saldoActual] decimal(10,2) DEFAULT 0


GO

ALTER TABLE [dbo].[tbl_seg_usuario]
ADD [esEstudiante] BIT DEFAULT 0
go

update tbl_seg_usuario set esEstudiante=0
go
update tbl_seg_usuario set saldoActual=0
go

/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioById]    Script Date: 09/06/2019 12:36:12 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getUsuarioById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getUsuarioById]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 09/06/2019 12:36:12 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_autenticarUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_autenticarUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_insertPago]    Script Date: 09/06/2019 12:36:12 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_pagos_insertPago]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_pagos_insertPago]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_getPagosByUsuarioId]    Script Date: 09/06/2019 12:36:12 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_pagos_getPagosByUsuarioId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_pagos_getPagosByUsuarioId]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_pagos_pagos_tbl_seg_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_pagos_pagos]'))
ALTER TABLE [dbo].[tbl_pagos_pagos] DROP CONSTRAINT [FK_tbl_pagos_pagos_tbl_seg_usuario]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_pagos_pagos_tbl_rutas_vehiculos]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_pagos_pagos]'))
ALTER TABLE [dbo].[tbl_pagos_pagos] DROP CONSTRAINT [FK_tbl_pagos_pagos_tbl_rutas_vehiculos]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_pagos_pagos_tbl_rutas_lineas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_pagos_pagos]'))
ALTER TABLE [dbo].[tbl_pagos_pagos] DROP CONSTRAINT [FK_tbl_pagos_pagos_tbl_rutas_lineas]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_pagos_pagos_tbl_pagos_conceptos]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_pagos_pagos]'))
ALTER TABLE [dbo].[tbl_pagos_pagos] DROP CONSTRAINT [FK_tbl_pagos_pagos_tbl_pagos_conceptos]
GO
/****** Object:  Table [dbo].[tbl_pagos_pagos]    Script Date: 09/06/2019 12:36:12 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_pagos_pagos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_pagos_pagos]
GO
/****** Object:  Table [dbo].[tbl_pagos_conceptos]    Script Date: 09/06/2019 12:36:12 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_pagos_conceptos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_pagos_conceptos]
GO
/****** Object:  Table [dbo].[tbl_pagos_conceptos]    Script Date: 09/06/2019 12:36:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pagos_conceptos](
	[conceptoId] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[monto] [decimal](10, 2) NULL,
	[esIngreso] [bit] NULL,
 CONSTRAINT [PK_tbl_pagos_conceptos] PRIMARY KEY CLUSTERED 
(
	[conceptoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_pagos_pagos]    Script Date: 09/06/2019 12:36:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pagos_pagos](
	[pagoId] [int] IDENTITY(1,1) NOT NULL,
	[fechaPago] [datetime] NOT NULL,
	[usuarioId] [int] NOT NULL,
	[vehiculoId] [int] NOT NULL,
	[conceptoId] [int] NOT NULL,
	[lineaId] [int] NULL,
 CONSTRAINT [PK_tbl_pagos_pagos] PRIMARY KEY CLUSTERED 
(
	[pagoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_pagos_pagos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pagos_pagos_tbl_pagos_conceptos] FOREIGN KEY([conceptoId])
REFERENCES [dbo].[tbl_pagos_conceptos] ([conceptoId])
GO
ALTER TABLE [dbo].[tbl_pagos_pagos] CHECK CONSTRAINT [FK_tbl_pagos_pagos_tbl_pagos_conceptos]
GO
ALTER TABLE [dbo].[tbl_pagos_pagos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pagos_pagos_tbl_rutas_lineas] FOREIGN KEY([lineaId])
REFERENCES [dbo].[tbl_rutas_lineas] ([lineaId])
GO
ALTER TABLE [dbo].[tbl_pagos_pagos] CHECK CONSTRAINT [FK_tbl_pagos_pagos_tbl_rutas_lineas]
GO
ALTER TABLE [dbo].[tbl_pagos_pagos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pagos_pagos_tbl_rutas_vehiculos] FOREIGN KEY([vehiculoId])
REFERENCES [dbo].[tbl_rutas_vehiculos] ([vehiculoId])
GO
ALTER TABLE [dbo].[tbl_pagos_pagos] CHECK CONSTRAINT [FK_tbl_pagos_pagos_tbl_rutas_vehiculos]
GO
ALTER TABLE [dbo].[tbl_pagos_pagos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pagos_pagos_tbl_seg_usuario] FOREIGN KEY([conceptoId])
REFERENCES [dbo].[tbl_pagos_conceptos] ([conceptoId])
GO
ALTER TABLE [dbo].[tbl_pagos_pagos] CHECK CONSTRAINT [FK_tbl_pagos_pagos_tbl_seg_usuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_getPagosByUsuarioId]    Script Date: 09/06/2019 12:36:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 09/06/2019
-- Description:	ObtenerPagos
-- =============================================
CREATE PROCEDURE [dbo].[usp_pagos_getPagosByUsuarioId] 
	-- Add the parameters for the stored procedure here
	@intUsuarioId int,
	@datFechaDesde datetime,
	@datFechaHasta datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT [pp].[pagoId]
      ,[pp].[fechaPago]
      ,[pp].[usuarioId]
      ,[pp].[conceptoId]
	  ,[pc].[descripcion] [concepto]
	  ,[rl].[numeroLinea]
	  ,[pc].[esIngreso]
  FROM [dbo].[tbl_pagos_pagos] [pp]
  JOIN [dbo].[tbl_pagos_conceptos] [pc] on [pp].[conceptoId] = [pc].[conceptoId]
  JOIN [dbo].[tbl_rutas_lineas] [rl] on [pp].[lineaId] = [rl].[lineaId]
  WHERE [pp].fechaPago between @datFechaDesde and @datFechaHasta



END
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_insertPago]    Script Date: 09/06/2019 12:36:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 09/06/2019
-- Description:	Realizar Pagos
-- =============================================
CREATE PROCEDURE [dbo].[usp_pagos_insertPago]
	-- Add the parameters for the stored procedure here
	@intUsuarioId int,
	@intVehiculoId int,
	@intConceptoId int,
	@intLineaId		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[tbl_pagos_pagos]
           ([fechaPago]
           ,[usuarioId]
           ,[vehiculoId]
           ,[conceptoId]
		   ,[lineaId])
     VALUES
           (GETDATE()
           ,@intUsuarioId
           ,@intVehiculoId
           ,@intConceptoId
		   ,@intLineaId)



END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 09/06/2019 12:36:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_autenticarUsuario]
	-- Add the parameters for the stored procedure here
	@correo varchar(50),
	@password varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [usuarioId]
		  ,[correo]
		  ,[nombre]
		  ,[activo]
		  ,[saldoActual]
		  ,[esEstudiante]
	  FROM [dbo].[tbl_seg_usuario]
	  WHERE [correo]=@correo
	  AND PWDCOMPARE(@password, [password]) = 1 
	  AND [activo]=1
	  and [eliminado] =0
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioById]    Script Date: 09/06/2019 12:36:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 08/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getUsuarioById]
	-- Add the parameters for the stored procedure here
	@usuarioId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [usuarioId]
		  ,[correo]
		  ,[nombre]
		  ,[activo]
		  ,[codigoActivacion]
		  ,[codigoRecuperacion]
		  ,[saldoActual]
		  ,[esEstudiante]
	  FROM [dbo].[tbl_seg_usuario]
	  where [usuarioId] =@usuarioId
	   


END
GO

----------------------------------------------------------------------->
DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,5
           ,0)
GO

