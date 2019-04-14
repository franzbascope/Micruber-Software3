Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.10.0'

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_VERSION_GetVersion]') AND type in (N'P', N'PC'))
BEGIN

	RAISERROR('La base de datos no esta inicializada',16,127)
	RETURN;

END

DECLARE @intVersionMayor int
DECLARE @intVersionMenor int
DECLARE @intPatch int

EXECUTE [dbo].[usp_VERSION_GetVersion] 
   @intVersionMayor OUTPUT
  ,@intVersionMenor OUTPUT
  ,@intPatch OUTPUT

IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL
BEGIN
	
	RAISERROR('La base de datos no esta inicializada',16,127)
	RETURN;

END


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 10)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.8. Este script solamente se apllica a la version 1.10',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END
GO


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[DASH_GetDashByCode]    Script Date: 01/12/2017 17:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 01/12/2017
-- Description:	Obtener Dash por codigo
-- =============================================
CREATE PROCEDURE [dbo].[DASH_GetDashByCode]
	-- Add the parameters for the stored procedure here
	@codigo	VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[tblDash] 
	WHERE [codigo] = @codigo
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[CONF_GetConfigByDashId]    Script Date: 01/12/2017 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 01/12/2017
-- Description:	Obtener Configuracion por DashId
-- =============================================
CREATE PROCEDURE [dbo].[CONF_GetConfigByDashId]
	-- Add the parameters for the stored procedure here
	@DashId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[tblConfigDash] 
	WHERE [dashId] = @DashId 

END
GO


DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,11
           ,0)
GO