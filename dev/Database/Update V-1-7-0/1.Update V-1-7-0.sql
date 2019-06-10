
USE [micruberDB]
GO
ALTER TABLE tbl_seg_roles add desactivado bit null default 0
update tbl_seg_roles set desactivado=0
/****** Object:  StoredProcedure [dbo].[usp_seg_updateRol]    Script Date: 10/6/2019 00:30:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateRol]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateRol]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertRol]    Script Date: 10/6/2019 00:30:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertRol]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_insertRol]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getRolById]    Script Date: 10/6/2019 00:30:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getRolById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getRolById]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllRoles]    Script Date: 10/6/2019 00:30:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllRoles]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deleteRoles]    Script Date: 10/6/2019 00:30:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_deleteRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_deleteRoles]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deleteRoles]    Script Date: 10/6/2019 00:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_deleteRoles]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 10/04/2019
-- Description:	Borrado logico de roles
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_deleteRoles]
	-- Add the parameters for the stored procedure here
	@intUsuarioId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tbl_seg_roles]
	SET [desactivado] = 1
	WHERE [roleId] =@intUsuarioId
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllRoles]    Script Date: 10/6/2019 00:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllRoles]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getRolById]    Script Date: 10/6/2019 00:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getRolById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 08/04/2019
-- Description:	Obtiene un Rol por ID
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getRolById]
	-- Add the parameters for the stored procedure here
	@rolId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [roleId]
		  ,[descripcion],
		  [desactivado]
		  
	  FROM [dbo].[tbl_seg_roles]
	  where [roleId] =@rolId
	   


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertRol]    Script Date: 10/6/2019 00:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertRol]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 07/04/2019
-- Description:	insertar un rol
-- =============================================
create PROCEDURE [dbo].[usp_seg_insertRol]
	-- Add the parameters for the stored procedure here
	@descripcion varchar(50),

	@rolId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO [dbo].[tbl_seg_roles]
			([descripcion])
			
		VALUES
			(@descripcion)

	SET @rolId = SCOPE_IDENTITY()

	


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateRol]    Script Date: 10/6/2019 00:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateRol]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 07/04/2019
-- Description:	Actualiza el rol
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_updateRol]
	-- Add the parameters for the stored procedure here
	@descripcion varchar(50),
	@userId	INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


UPDATE [dbo].[tbl_seg_roles]
   SET [descripcion] = @descripcion
      
 WHERE [roleId] = @userId





END
' 
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
           ,7
           ,0)
GO

