USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getRutasById]    Script Date: 20/05/2019 10:49:31 p.m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getRutasById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getRutasById]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getRutasById]    Script Date: 20/05/2019 10:49:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getRutasById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
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


END' 
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
           ,4
           ,0)
GO

