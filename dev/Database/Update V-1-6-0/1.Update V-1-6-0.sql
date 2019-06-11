USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateRol]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateRol]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateRol]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertRolesPermisos]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertRolesPermisos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_insertRolesPermisos]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertRol]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertRol]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_insertRol]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getRolById]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getRolById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getRolById]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getPermisosByUsuarioId]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getPermisosByUsuarioId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getPermisosByUsuarioId]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllRoles]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllRoles]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllPermisos]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllPermisos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllPermisos]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasByVehiculoId]    Script Date: 9/6/2019 22:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineasByVehiculoId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getLineasByVehiculoId]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasByVehiculoId]    Script Date: 9/6/2019 22:32:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineasByVehiculoId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllPermisos]    Script Date: 9/6/2019 22:32:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllPermisos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 08/04/2019
-- Description:	Trae una lista de todos los permisos
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getAllPermisos]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [permisoId],
			[descripcion]
	  FROM [dbo].[tbl_seg_permisos]
	   
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllRoles]    Script Date: 9/6/2019 22:32:56 ******/
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
			[descripcion]
	  FROM [dbo].[tbl_seg_roles]
	   
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getPermisosByUsuarioId]    Script Date: 9/6/2019 22:32:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getPermisosByUsuarioId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getPermisosByUsuarioId]
	-- Add the parameters for the stored procedure here
	@intRoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select [permisoId],
   [descripcion],
   case when [permisoId] in (select permisoId from tbl_seg_rolesPermisos where roleId=@intRoleId) then 1 else 0 end [perteneceRol]
   from [dbo].[tbl_seg_permisos]
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getRolById]    Script Date: 9/6/2019 22:32:56 ******/
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
		  ,[descripcion]
		  
	  FROM [dbo].[tbl_seg_roles]
	  where [roleId] =@rolId
	   


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertRol]    Script Date: 9/6/2019 22:32:56 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_seg_insertRolesPermisos]    Script Date: 9/6/2019 22:32:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertRolesPermisos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 07/04/2019
-- Description:	Asigna permisos al rol
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_insertRolesPermisos]
	-- Add the parameters for the stored procedure here
	@permisoId int,
	@roleId int,
	@Id	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO [dbo].[tbl_seg_rolesPermisos]
			([permisoId]
			,[roleId])
		VALUES
			(@permisoId
			,@roleId)

	SET @Id = SCOPE_IDENTITY()
	 


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateRol]    Script Date: 9/6/2019 22:32:56 ******/
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
           ,6
           ,0)
GO

