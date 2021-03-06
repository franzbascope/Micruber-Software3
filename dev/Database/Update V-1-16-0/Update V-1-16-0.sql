USE [micruberDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_seg_deletePermisosByRolId]    Script Date: 04/07/2019 10:23:40 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_deletePermisosByRolId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_deletePermisosByRolId]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deletePermisosByRolId]    Script Date: 04/07/2019 10:23:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 04/07/2019
-- Description:	<Description,,0>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_deletePermisosByRolId] 
	-- Add the parameters for the stored procedure here
	@intRolId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DELETE FROM [dbo].[tbl_seg_rolesPermisos]
      WHERE roleId= @intRolId

END
GO


/****** Object:  StoredProcedure [dbo].[usp_seg_deletePermisosByRolId]    Script Date: 04/07/2019 10:38:56 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_deletePermisosByRolId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_deletePermisosByRolId]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deletePermisosByRolId]    Script Date: 04/07/2019 10:38:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 04/07/2019
-- Description:	<Description,,0>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_deletePermisosByRolId] 
	-- Add the parameters for the stored procedure here
	@intRolId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DELETE FROM [dbo].[tbl_seg_rolesPermisos]
      WHERE roleId= @intRolId

END
GO

/****** Object:  StoredProcedure [dbo].[usp_seg_getAllRoles]    Script Date: 04/07/2019 10:56:21 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllRoles]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllRoles]    Script Date: 04/07/2019 10:56:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Luis Humberto
-- Create date: 08/04/2019
-- Description:	Trae una lista de todos los roles
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getAllRoles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [roleId],
			[descripcion],
			[desactivado]
	  FROM [dbo].[tbl_seg_roles]
	  WHERE desactivado =0
	   
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
           ,16
           ,0)
GO
