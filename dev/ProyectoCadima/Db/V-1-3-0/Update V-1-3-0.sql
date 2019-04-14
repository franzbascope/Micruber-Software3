USE [bdTienda]
GO

/****** Object:  StoredProcedure [dbo].[usp_USUARIO_GetUsuariosByEmail]    Script Date: 09/23/2017 17:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 17/09/2017
-- Description:	Obtener usuarios por Email
-- =============================================
CREATE PROCEDURE [dbo].[usp_USUARIO_GetUsuariosByEmail] 
	@varCorreo NVARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [usuarioId]
		  ,[nombre]
		  ,[apellido]
		  ,[correo]
		  ,[contraseña]
		  ,[tipoUsuario]
	FROM [dbo].[tblUsuario]
	WHERE [correo] = @varCorreo
END
GO

/****** Object:  StoredProcedure [dbo].[usp_USUARIO_GetUsuariosByEmailPassword]    Script Date: 09/23/2017 17:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_USUARIO_GetUsuariosByEmailPassword] 
	@varCorreo NVARCHAR (50),
	@varPassword NVARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [usuarioId]
		  ,[nombre]
		  ,[apellido]
		  ,[correo]
		  ,[contraseña]
		  ,[tipoUsuario]
	FROM [dbo].[tblUsuario]
	WHERE [correo] = @varCorreo and [contraseña] = @varPassword
END
GO



/****** Object:  StoredProcedure [dbo].[rsp_RECUPERACION_InsertarRecuperacion]    Script Date: 09/23/2017 17:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rsp_RECUPERACION_InsertarRecuperacion] 
	@usuarioId 		int,
	@varcodigoGenerado nvarchar(15),
	@fechaGenerado	datetime,
	@fechaActual	datetime,
	@tiempo			int,
	@estado			char(18),
	
	@recuperacionId	int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- i50n,terfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO [bdTienda].[dbo].[tblRecuperacion]
           ([usuarioId]
           ,[codigoGenerado]
           ,[fechaGenerado]
           ,[fechaActual]
           ,[tiempo]
           ,[estado])
     VALUES
           (
           		@usuarioId,
				@varcodigoGenerado,
				@fechaGenerado,
				@fechaActual,
				@tiempo,
				@estado
           )
	 SET	@recuperacionId = SCOPE_IDENTITY()
END
GO

