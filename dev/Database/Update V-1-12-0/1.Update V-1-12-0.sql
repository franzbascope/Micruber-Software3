USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 21/06/2019 05:58:48 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllUsuarios]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllUsuarios]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deletePermisosByRolId]    Script Date: 21/06/2019 05:58:48 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_deletePermisosByRolId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_deletePermisosByRolId]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 21/06/2019 05:58:48 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_autenticarUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_autenticarUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 21/06/2019 05:58:48 p. m. ******/
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
		  ,[tipoUsuario]
	  FROM [dbo].[tbl_seg_usuario]
	  WHERE [correo]=@correo
	  AND PWDCOMPARE(@password, [password]) = 1 
	  AND [activo]=1
	  and [eliminado] =0
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deletePermisosByRolId]    Script Date: 21/06/2019 05:58:48 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 21/06/2019
-- Description:	<Description,,>
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
	delete from tbl_seg_rolesPermisos where roleId = @intRolId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 21/06/2019 05:58:48 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 08/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getAllUsuarios]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [us].[usuarioId]
		  ,[correo]
		  ,[nombre]
		  ,[activo]
		  ,[codigoActivacion]
		  ,[codigoRecuperacion]
	  FROM [dbo].[tbl_seg_usuario] [us]
	  WHERE [eliminado] =0
	   


END
GO
