USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoActivacion]    Script Date: 14/04/2019 07:20:27 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_validateCodigoActivacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_validateCodigoActivacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertUsuario]    Script Date: 14/04/2019 07:20:27 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_insertUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioById]    Script Date: 14/04/2019 07:20:27 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getUsuarioById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getUsuarioById]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioById]    Script Date: 14/04/2019 07:20:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 08/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getUsuarioById]
	-- Add the parameters for the stored procedure here
	@usuarioId int
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
		  ,[codigoActivacion]
		  ,[codigoRecuperacion]
	  FROM [dbo].[tbl_seg_usuario]
	  where [usuarioId] =@usuarioId
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertUsuario]    Script Date: 14/04/2019 07:20:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_insertUsuario]
	-- Add the parameters for the stored procedure here
	@correo varchar(50),
	@password varchar(50),
	@nombre varchar(100),
	@userId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO [dbo].[tbl_seg_usuario]
			([correo]
			,[password]
			,[nombre])
		VALUES
			(@correo
			,PWDENCRYPT(@password)
			,@nombre)

	SET @userId = SCOPE_IDENTITY()

	UPDATE [dbo].[tbl_seg_usuario] 
	SET [codigoActivacion] = (SELECT LEFT(REPLACE(NEWID(),'-',''),10)),
	[fechaCodigoActivacion] = GETDATE()
	WHERE [usuarioId] =@userId

	 


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoActivacion]    Script Date: 14/04/2019 07:20:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_validateCodigoActivacion]
	-- Add the parameters for the stored procedure here
	@codigoActivacion varchar(10),
	@existeCodigo BIT OUTPUT
	
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
	WHERE  [codigoActivacion] = @codigoActivacion
	AND DATEDIFF(SECOND,[fechaCodigoActivacion],GETDATE()) <=@intSegundos

	if(@existeCodigo = 1)
	begin
		update [dbo].[tbl_seg_usuario] 
		set [activo] =1
		where [codigoActivacion] = @codigoActivacion
	end

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
           ,1
           ,1)
GO

