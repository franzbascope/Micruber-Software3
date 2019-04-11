USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoRecuperacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_validateCodigoRecuperacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_validateCodigoRecuperacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoActivacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_validateCodigoActivacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_validateCodigoActivacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateCodigoRecuperacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateCodigoRecuperacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateCodigoRecuperacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateCodigoActivacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateCodigoActivacion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateCodigoActivacion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_recuperarContrasena]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_recuperarContrasena]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_recuperarContrasena]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_insertUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioById]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getUsuarioById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getUsuarioById]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getAllUsuarios]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getAllUsuarios]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deleteUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_deleteUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_deleteUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_cambiarContrasena]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_cambiarContrasena]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_cambiarContrasena]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_autenticarUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_autenticarUsuario]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_seg_usuarioRoles_tbl_seg_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_seg_usuarioRoles]'))
ALTER TABLE [dbo].[tbl_seg_usuarioRoles] DROP CONSTRAINT [FK_tbl_seg_usuarioRoles_tbl_seg_usuario]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_seg_usuarioRoles_tbl_seg_roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_seg_usuarioRoles]'))
ALTER TABLE [dbo].[tbl_seg_usuarioRoles] DROP CONSTRAINT [FK_tbl_seg_usuarioRoles_tbl_seg_roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_seg_rolesPermisos_tbl_seg_roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_seg_rolesPermisos]'))
ALTER TABLE [dbo].[tbl_seg_rolesPermisos] DROP CONSTRAINT [FK_tbl_seg_rolesPermisos_tbl_seg_roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_seg_rolesPermisos_tbl_seg_permisos]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_seg_rolesPermisos]'))
ALTER TABLE [dbo].[tbl_seg_rolesPermisos] DROP CONSTRAINT [FK_tbl_seg_rolesPermisos_tbl_seg_permisos]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tbl_seg_usuario_eliminado]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tbl_seg_usuario] DROP CONSTRAINT [DF_tbl_seg_usuario_eliminado]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tbl_seg_usuario_activo]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tbl_seg_usuario] DROP CONSTRAINT [DF_tbl_seg_usuario_activo]
END
GO
/****** Object:  Table [dbo].[tbl_seg_usuarioRoles]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_seg_usuarioRoles]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_seg_usuarioRoles]
GO
/****** Object:  Table [dbo].[tbl_seg_usuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_seg_usuario]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_seg_usuario]
GO
/****** Object:  Table [dbo].[tbl_seg_rolesPermisos]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_seg_rolesPermisos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_seg_rolesPermisos]
GO
/****** Object:  Table [dbo].[tbl_seg_roles]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_seg_roles]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_seg_roles]
GO
/****** Object:  Table [dbo].[tbl_seg_permisos]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_seg_permisos]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_seg_permisos]
GO
/****** Object:  Table [dbo].[tbl_seg_parametros]    Script Date: 11/04/2019 01:15:54 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_seg_parametros]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_seg_parametros]
GO
/****** Object:  Table [dbo].[tbl_seg_parametros]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_seg_parametros](
	[parametroId] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[duracionSegundos] [int] NOT NULL,
 CONSTRAINT [PK_tbl_seg_parametros] PRIMARY KEY CLUSTERED 
(
	[parametroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_seg_permisos]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_seg_permisos](
	[permisoId] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_seg_permisos] PRIMARY KEY CLUSTERED 
(
	[permisoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_seg_roles]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_seg_roles](
	[roleId] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_seg_roles] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_seg_rolesPermisos]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_seg_rolesPermisos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[permisoId] [int] NOT NULL,
	[roleId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_seg_rolesPermisos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[permisoId] ASC,
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_seg_usuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_seg_usuario](
	[usuarioId] [int] IDENTITY(1,1) NOT NULL,
	[correo] [varchar](50) NOT NULL,
	[password] [varbinary](128) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[activo] [bit] NOT NULL,
	[codigoRecuperacion] [varchar](10) NULL,
	[codigoActivacion] [varchar](10) NULL,
	[fechaCodigoRecuperacion] [datetime] NULL,
	[fechaCodigoActivacion] [datetime] NULL,
	[eliminado] [bit] NULL,
 CONSTRAINT [PK_tbl_seg_usuario] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_seg_usuarioRoles]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_seg_usuarioRoles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleId] [int] NOT NULL,
	[usuarioId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_seg_usuarioRoles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_seg_usuario] ADD  CONSTRAINT [DF_tbl_seg_usuario_activo]  DEFAULT ((0)) FOR [activo]
GO
ALTER TABLE [dbo].[tbl_seg_usuario] ADD  CONSTRAINT [DF_tbl_seg_usuario_eliminado]  DEFAULT ((0)) FOR [eliminado]
GO
ALTER TABLE [dbo].[tbl_seg_rolesPermisos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_seg_rolesPermisos_tbl_seg_permisos] FOREIGN KEY([permisoId])
REFERENCES [dbo].[tbl_seg_permisos] ([permisoId])
GO
ALTER TABLE [dbo].[tbl_seg_rolesPermisos] CHECK CONSTRAINT [FK_tbl_seg_rolesPermisos_tbl_seg_permisos]
GO
ALTER TABLE [dbo].[tbl_seg_rolesPermisos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_seg_rolesPermisos_tbl_seg_roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[tbl_seg_roles] ([roleId])
GO
ALTER TABLE [dbo].[tbl_seg_rolesPermisos] CHECK CONSTRAINT [FK_tbl_seg_rolesPermisos_tbl_seg_roles]
GO
ALTER TABLE [dbo].[tbl_seg_usuarioRoles]  WITH CHECK ADD  CONSTRAINT [FK_tbl_seg_usuarioRoles_tbl_seg_roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[tbl_seg_roles] ([roleId])
GO
ALTER TABLE [dbo].[tbl_seg_usuarioRoles] CHECK CONSTRAINT [FK_tbl_seg_usuarioRoles_tbl_seg_roles]
GO
ALTER TABLE [dbo].[tbl_seg_usuarioRoles]  WITH CHECK ADD  CONSTRAINT [FK_tbl_seg_usuarioRoles_tbl_seg_usuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tbl_seg_usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tbl_seg_usuarioRoles] CHECK CONSTRAINT [FK_tbl_seg_usuarioRoles_tbl_seg_usuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_autenticarUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_cambiarContrasena]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_cambiarContrasena]
	-- Add the parameters for the stored procedure here
	@userId int,
	@oldPassword varchar(20),
	@newPassword varchar(20),
	@respuesta	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS (SELECT 1
	  FROM [dbo].[tbl_seg_usuario]
	  WHERE PWDCOMPARE(@oldPassword, [password]) = 1 
	  AND [activo]=1)
	BEGIN
		UPDATE [dbo].[tbl_seg_usuario] SET [password] =PWDENCRYPT(@newPassword)
		WHERE  usuarioId= @userId

		SET @respuesta=1
	END
	ELSE
		SET @respuesta=0
    
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_deleteUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 10/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_deleteUsuario]
	-- Add the parameters for the stored procedure here
	@intUsuarioId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tbl_seg_usuario]
	SET [eliminado] = 1
	WHERE [usuarioId] =@intUsuarioId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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
	  FROM [dbo].[tbl_seg_usuario] [us]
	  LEFT JOIN [dbo].[tbl_seg_usuarioRoles] [ur] ON [ur].[usuarioId] = [us].[usuarioId]
	  LEFT JOIN [dbo].[tbl_seg_roles] [ro] ON [ur].[roleId] =  [ro].[roleId]
	  WHERE [eliminado] =0
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioById]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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
	  FROM [dbo].[tbl_seg_usuario]
	  where [usuarioId] =@usuarioId
	   


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_recuperarContrasena]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_recuperarContrasena]
	-- Add the parameters for the stored procedure here
	@userId int,
	@password varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tbl_seg_usuario] SET [password] =PWDENCRYPT(@password)
	WHERE  usuarioId= @userId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateCodigoActivacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_updateCodigoActivacion]
	-- Add the parameters for the stored procedure here
	@userId INT,
	@codigoRecuperacion varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	UPDATE [dbo].[tbl_seg_usuario] 
	SET [codigoActivacion] = @codigoRecuperacion,
	[fechaCodigoActivacion] = GETDATE()
	WHERE [usuarioId] =@userId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateCodigoRecuperacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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
	-- Add the parameters for the stored procedure here
	@userId INT,
	@codigoRecuperacion varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	UPDATE [dbo].[tbl_seg_usuario] 
	SET [codigoRecuperacion] = @codigoRecuperacion,
	[fechaCodigoRecuperacion] = GETDATE()
	WHERE [usuarioId] =@userId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateUsuario]    Script Date: 11/04/2019 01:15:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_updateUsuario]
	-- Add the parameters for the stored procedure here
	@correo varchar(50),
	@nombre varchar(100),
	@userId	INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


UPDATE [dbo].[tbl_seg_usuario]
   SET [correo] = @correo
      ,[nombre] = @nombre
 WHERE [usuarioId] = @userId





END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoActivacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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
	@intUsuarioId int,
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
	WHERE [usuarioId] = @intUsuarioId
	AND [codigoActivacion] = @codigoActivacion
	AND DATEDIFF(SECOND,[fechaCodigoActivacion],GETDATE()) <=@intSegundos

END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validateCodigoRecuperacion]    Script Date: 11/04/2019 01:15:54 a. m. ******/
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
	-- Add the parameters for the stored procedure here
	@intUsuarioId int,
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
	WHERE [usuarioId] = @intUsuarioId
	AND [codigoRecuperacion] = @codigoRecuperacion
	AND DATEDIFF(SECOND,[fechaCodigoRecuperacion],GETDATE()) <=@intSegundos

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
           ,0)
GO

