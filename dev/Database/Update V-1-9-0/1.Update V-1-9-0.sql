USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_updateLinea]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_updateLinea]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_updateLinea]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_insertLinea]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_insertLinea]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_insertLinea]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_insertCoordenada]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_insertCoordenada]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_insertCoordenada]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getRutasById]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getRutasById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getRutasById]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineaById]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineaById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getLineaById]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getCoordenadasByLineaId]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getCoordenadasByLineaId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getCoordenadasByLineaId]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllLineas]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllLineas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getAllLineas]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteLinea]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_deleteLinea]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_deleteLinea]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteCoordenadasByLineaId]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_deleteCoordenadasByLineaId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_deleteCoordenadasByLineaId]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_rutas_coordenadas_tbl_rutas_lineas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_rutas_coordenadas]'))
ALTER TABLE [dbo].[tbl_rutas_coordenadas] DROP CONSTRAINT [FK_tbl_rutas_coordenadas_tbl_rutas_lineas]
GO
/****** Object:  Table [dbo].[tbl_rutas_coordenadas]    Script Date: 6/11/2019 12:53:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_rutas_coordenadas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_rutas_coordenadas]
GO

/****** Object:  Table [dbo].[tbl_rutas_coordenadas]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dbo].[tbl_rutas_lineas] ADD eliminado bit null default 0
GO

CREATE TABLE [dbo].[tbl_rutas_coordenadas](
	[coodenadaId] [int] IDENTITY(1,1) NOT NULL,
	[latitud] [decimal](20, 10) NULL,
	[longitud] [decimal](20, 10) NULL,
	[lineaId] [int] NULL,
 CONSTRAINT [PK_tbl_rutas_coordenadas] PRIMARY KEY CLUSTERED 
(
	[coodenadaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_rutas_coordenadas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rutas_coordenadas_tbl_rutas_lineas] FOREIGN KEY([lineaId])
REFERENCES [dbo].[tbl_rutas_lineas] ([lineaId])
GO
ALTER TABLE [dbo].[tbl_rutas_coordenadas] CHECK CONSTRAINT [FK_tbl_rutas_coordenadas_tbl_rutas_lineas]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteCoordenadasByLineaId]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_deleteCoordenadasByLineaId]
	-- Add the parameters for the stored procedure here
	@lineaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	  DELETE FROM [dbo].[tbl_rutas_coordenadas]
      WHERE [lineaId] = @lineaId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteLinea]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Denar Terrazas
-- Create date: 09/06/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_deleteLinea]
	-- Add the parameters for the stored procedure here
	@intLineaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


UPDATE [dbo].[tbl_rutas_lineas]
		SET [eliminado] = 1
      WHERE [lineaId] = @intLineaId



END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllLineas]    Script Date: 6/11/2019 12:53:41 AM ******/
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
  WHERE [eliminado] =0

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getCoordenadasByLineaId]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Denar Terrazas
-- Create date: 09/06/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getCoordenadasByLineaId]
	-- Add the parameters for the stored procedure here
	@lineaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [coodenadaId]
		  ,[latitud]
		  ,[longitud]
		  ,[lineaId]
	  FROM [dbo].[tbl_rutas_coordenadas]
	  WHERE [lineaId] = @lineaId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineaById]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getLineaById]
	-- Add the parameters for the stored procedure here
	@lineaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [lineaId]
		  ,[numeroLinea]
		  ,[eliminado]
	FROM [dbo].[tbl_rutas_lineas]
	WHERE [lineaId] = @lineaId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getRutasById]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ETCHEVERRY-PC
-- Create date: 20/05/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getRutasById] 
	-- Add the parameters for the stored procedure here
	@intRutaId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [li].posX lat,[li].posY lng
	FROM [dbo].[tbl_rutas_rutas] [li]
	WHERE [li].[rutaId] = @intRutaId


END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_insertCoordenada]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_insertCoordenada]
	-- Add the parameters for the stored procedure here
	@lineaId int,
	@latitud decimal(20, 10),
	@longitud decimal(20, 10),
	@coordenadaId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		INSERT INTO [dbo].[tbl_rutas_coordenadas]
				   ([lineaId]
				   ,[latitud]
				   ,[longitud])
			 VALUES
				   (@lineaId
				   ,@latitud
				   ,@longitud)

		SET @coordenadaId = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_insertLinea]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_insertLinea]
	-- Add the parameters for the stored procedure here
	@numeroLinea varchar(10),
	@lineaId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO [dbo].[tbl_rutas_lineas]
           ([numeroLinea]
           ,[eliminado])
     VALUES
           (@numeroLinea
           ,0)
	
	SET @lineaId = SCOPE_IDENTITY()

END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_updateLinea]    Script Date: 6/11/2019 12:53:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Denar Terrazas
-- Create date: 09/06/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_updateLinea]
	-- Add the parameters for the stored procedure here
	@numeroLinea varchar(10),
	@lineaId	INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

UPDATE [dbo].[tbl_rutas_lineas]
	SET [numeroLinea] = @numeroLinea
	WHERE [lineaId] = @lineaId
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
           ,9
           ,0)
GO

