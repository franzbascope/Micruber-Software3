USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateEmail]    Script Date: 17/04/2019 12:15:29 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_validateEmail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_validateEmail]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoRecuperacion]    Script Date: 17/04/2019 12:15:29 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_validateCodigoRecuperacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_validateCodigoRecuperacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updatePassword]    Script Date: 17/04/2019 12:15:29 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updatePassword]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updatePassword]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateCodigoRecuperacion]    Script Date: 17/04/2019 12:15:29 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateCodigoRecuperacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateCodigoRecuperacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 17/04/2019 12:15:29 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllUsuarios]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllUsuarios]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 17/04/2019 12:15:29 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_autenticarUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_autenticarUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 17/04/2019 12:15:29 a. m. ******/
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
	  FROM [dbo].[tbl_seg_usuario]
	  WHERE [correo]=@correo
	  AND PWDCOMPARE(@password, [password]) = 1 
	  AND [activo]=1
	  and [eliminado] =0
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 17/04/2019 12:15:29 a. m. ******/
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
		  ,[ro].[descripcion] [rol]
		  ,[codigoActivacion]
		  ,[codigoRecuperacion]
	  FROM [dbo].[tbl_seg_usuario] [us]
	  LEFT JOIN [dbo].[tbl_seg_usuarioRoles] [ur] ON [ur].[usuarioId] = [us].[usuarioId]
	  LEFT JOIN [dbo].[tbl_seg_roles] [ro] ON [ur].[roleId] =  [ro].[roleId]
	  WHERE [eliminado] =0
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateCodigoRecuperacion]    Script Date: 17/04/2019 12:15:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_updateCodigoRecuperacion]
	@varEmail varchar(50),
	@intUsuarioId int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	UPDATE [dbo].[tbl_seg_usuario] 
	SET [codigoRecuperacion] = (SELECT LEFT(REPLACE(NEWID(),'-',''),10)),
	[fechaCodigoRecuperacion] = GETDATE()
	WHERE [correo] =@varEmail

	select @intUsuarioId=[usuarioId] from [dbo].[tbl_seg_usuario] where [correo] = @varEmail

END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updatePassword]    Script Date: 17/04/2019 12:15:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_updatePassword]
	-- Add the parameters for the stored procedure here
	@varCodigoRecuperacion varchar(50),
	@password varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tbl_seg_usuario] SET [password] =PWDENCRYPT(@password)
	,[codigoRecuperacion] = null
	WHERE  [codigoRecuperacion]= @varCodigoRecuperacion
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoRecuperacion]    Script Date: 17/04/2019 12:15:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_validateCodigoRecuperacion]
	@codigoRecuperacion varchar(10),
	@existeCodigo BIT OUTPUT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		DECLARE @intSegundos int
	select @intSegundos=[duracionSegundos] from [dbo].[tbl_seg_parametros] WHERE [parametroId] = 2

    -- Insert statements for procedure here

	SELECT  @existeCodigo=1 
	FROM [dbo].[tbl_seg_usuario] 
	WHERE [codigoRecuperacion] = @codigoRecuperacion
	AND DATEDIFF(SECOND,[fechaCodigoRecuperacion],GETDATE()) <=@intSegundos

END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateEmail]    Script Date: 17/04/2019 12:15:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 15/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_validateEmail]
	@existeCodigo BIT OUTPUT,
	@varEmail varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @intSegundos int
	select @intSegundos=[duracionSegundos] from [dbo].[tbl_seg_parametros]

    -- Insert statements for procedure here

	SELECT  @existeCodigo=1 
	FROM [dbo].[tbl_seg_usuario] 
	WHERE  [correo] =@varEmail
	AND [activo] = 1
END
GO
DROP PROCEDURE [dbo].[usp_seg_recuperarContrasena]
GO

DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,1
           ,0)
GO

