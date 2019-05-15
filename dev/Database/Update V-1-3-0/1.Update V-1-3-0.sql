USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getVehiculoByPlaca]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getVehiculoByPlaca]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getVehiculoByPlaca]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasByVehiculoId]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineasByVehiculoId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getLineasByVehiculoId]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllVehiculos]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllVehiculos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getAllVehiculos]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllLineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllLineas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getAllLineas]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_vehiculosLineas_tbl_rutas_vehiculos]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_vehiculosLineas]'))
ALTER TABLE [dbo].[tbl_rutas_vehiculosLineas] DROP CONSTRAINT [FK_tbl_rutas_vehiculosLineas_tbl_rutas_vehiculos]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_vehiculosLineas_tbl_rutas_lineas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_vehiculosLineas]'))
ALTER TABLE [dbo].[tbl_rutas_vehiculosLineas] DROP CONSTRAINT [FK_tbl_rutas_vehiculosLineas_tbl_rutas_lineas]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_rutasLineas_tbl_rutas_rutas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutasLineas]'))
ALTER TABLE [dbo].[tbl_rutas_rutasLineas] DROP CONSTRAINT [FK_tbl_rutas_rutasLineas_tbl_rutas_rutas]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_rutasLineas_tbl_rutas_lineas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutasLineas]'))
ALTER TABLE [dbo].[tbl_rutas_rutasLineas] DROP CONSTRAINT [FK_tbl_rutas_rutasLineas_tbl_rutas_lineas]
GO
/****** Object:  Table [dbo].[tbl_rutas_vehiculosLineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_vehiculosLineas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_vehiculosLineas]
GO
/****** Object:  Table [dbo].[tbl_rutas_vehiculos]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_vehiculos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_vehiculos]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutasLineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutasLineas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_rutasLineas]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_rutas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_rutas]
GO
/****** Object:  Table [dbo].[tbl_rutas_lineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_lineas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_lineas]
GO
/****** Object:  Table [dbo].[tbl_rutas_lineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_lineas](
	[lineaId] [int] IDENTITY(1,1) NOT NULL,
	[numeroLinea] [varchar](10) NULL,
 CONSTRAINT [PK_tbl_rutas_lineas] PRIMARY KEY CLUSTERED 
(
	[lineaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[numeroLinea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rutas_rutas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
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
/****** Object:  Table [dbo].[tbl_rutas_rutasLineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_rutasLineas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[lineaId] [int] NULL,
	[rutaId] [int] NULL,
 CONSTRAINT [PK_tbl_rutas_rutasLineas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rutas_vehiculos]    Script Date: 15/05/2019 09:39:36 a. m. ******/
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
/****** Object:  Table [dbo].[tbl_rutas_vehiculosLineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas_vehiculosLineas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vehiculoId] [int] NULL,
	[lineaId] [int] NULL,
 CONSTRAINT [PK_tbl_rutas_vehiculosLineas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_rutas_rutasLineas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_rutasLineas_tbl_rutas_lineas] FOREIGN KEY([lineaId])
REFERENCES [dbo].[tbl_rutas_lineas] ([lineaId])
GO
ALTER TABLE [dbo].[tbl_rutas_rutasLineas] CHECK CONSTRAINT [FK_tbl_rutas_rutasLineas_tbl_rutas_lineas]
GO
ALTER TABLE [dbo].[tbl_rutas_rutasLineas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_rutasLineas_tbl_rutas_rutas] FOREIGN KEY([rutaId])
REFERENCES [dbo].[tbl_rutas_rutas] ([rutaId])
GO
ALTER TABLE [dbo].[tbl_rutas_rutasLineas] CHECK CONSTRAINT [FK_tbl_rutas_rutasLineas_tbl_rutas_rutas]
GO
ALTER TABLE [dbo].[tbl_rutas_vehiculosLineas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_vehiculosLineas_tbl_rutas_lineas] FOREIGN KEY([lineaId])
REFERENCES [dbo].[tbl_rutas_lineas] ([lineaId])
GO
ALTER TABLE [dbo].[tbl_rutas_vehiculosLineas] CHECK CONSTRAINT [FK_tbl_rutas_vehiculosLineas_tbl_rutas_lineas]
GO
ALTER TABLE [dbo].[tbl_rutas_vehiculosLineas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_vehiculosLineas_tbl_rutas_vehiculos] FOREIGN KEY([vehiculoId])
REFERENCES [dbo].[tbl_rutas_vehiculos] ([vehiculoId])
GO
ALTER TABLE [dbo].[tbl_rutas_vehiculosLineas] CHECK CONSTRAINT [FK_tbl_rutas_vehiculosLineas_tbl_rutas_vehiculos]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllLineas]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 15/05/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getAllLineas]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT [lineaId]
      ,[numeroLinea]
  FROM [dbo].[tbl_rutas_lineas]

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllVehiculos]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 14/05/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getAllVehiculos]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [vehiculoId]
		  ,[capacidad]
		  ,[placa]
	  FROM [dbo].[tbl_rutas_vehiculos]

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasByVehiculoId]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 15/05/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getLineasByVehiculoId] 
	-- Add the parameters for the stored procedure here
	@intVehiculoId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [li].[lineaId]
			,[li].[numeroLinea]
	FROM [dbo].[tbl_rutas_lineas] [li]
	JOIN [dbo].[tbl_rutas_vehiculosLineas] [vl] ON [li].[lineaId] = [vl].[lineaId]
	WHERE [vl].[vehiculoId] = @intVehiculoId




END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getVehiculoByPlaca]    Script Date: 15/05/2019 09:39:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 14/05/2019
-- Description:	Autenticar Conductor segun el nro Placa
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getVehiculoByPlaca] 
	-- Add the parameters for the stored procedure here
	@varPlaca varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [vehiculoId]
      ,[capacidad]
      ,[placa]
	FROM [dbo].[tbl_rutas_vehiculos]
	WHERE [placa]=@varPlaca

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
           ,3
           ,0)
GO

