USE [micruberDB]
GO

/****** Object:  Table [dbo].[tbl_Version]    Script Date: 04/02/2019 21:32:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Version](
	[versionMayor] [int] NOT NULL,
	[versionMenor] [int] NOT NULL,
	[patch] [int] NOT NULL
) ON [PRIMARY]

GO

/****** Object:  StoredProcedure [dbo].[usp_GetVersionData]    Script Date: 04/02/2019 21:32:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetVersionData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetVersionData]
GO


/****** Object:  StoredProcedure [dbo].[usp_GetVersionData]    Script Date: 04/02/2019 21:32:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jose Carlos Gutierrez
-- Create date: 02/04/2019
-- Description:	Obtiene la informacion de la version de la base de datos
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetVersionData]
	@intVersionMayor	INT OUTPUT,
	@intVersionMenor	INT OUTPUT,
	@intPatch			INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TOP 1 @intVersionMayor = [versionMayor]
		  ,@intVersionMenor = [versionMenor]
		  ,@intPatch = [patch]
	FROM [dbo].[tbl_Version]


END

GO


DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [micruberDB].[dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,0
           ,0)
GO

