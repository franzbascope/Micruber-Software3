Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.7.0'

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_VERSION_GetVersion]') AND type in (N'P', N'PC'))
BEGIN

	RAISERROR('La base de datos no esta inicializada',16,127)
	RETURN;

END

DECLARE @intVersionMayor int
DECLARE @intVersionMenor int
DECLARE @intPatch int

EXECUTE [dbo].[usp_VERSION_GetVersion] 
   @intVersionMayor OUTPUT
  ,@intVersionMenor OUTPUT
  ,@intPatch OUTPUT

IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL
BEGIN
	
	RAISERROR('La base de datos no esta inicializada',16,127)
	RETURN;

END


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 6)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.6. Este script solamente se apllica a la version 1.6',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblPERMISO_selectById]    Script Date: 10/31/2017 07:27:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 12-09-2016
-- Description:	<Mostrar por Nombre>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_selectByName]
@Nombre NVARCHAR(50)
AS
BEGIN
	SELECT [permisoId]      
	FROM [dbo].[tblPermiso]
	WHERE nombre = @Nombre
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_insert]    Script Date: 10/31/2017 07:46:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 12-09-2016
-- Description:	<creacion del procedimiento almanacenado para insertar en la tabla tblROLPERMISO>
-- =============================================
ALTER PROCEDURE [dbo].[tblROLPERMISO_insert]
@pRolId int,
@pPermisoID int,
@pEstado nchar(18),

@pIdRolPermiso int OUTPUT
AS
BEGIN
INSERT INTO [dbo].[tblRolPermiso]
           ([rolId]
           ,[permisoId]
           ,[estado])
     VALUES
           (@pRolId
           ,@pPermisoID
           ,@pEstado)
           
     SET	@pIdRolPermiso = SCOPE_IDENTITY()
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[rsp_ROL_MostrarRolId]    Script Date: 10/31/2017 10:21:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 12-09-2016
-- Description:	Mostrar Rol por Id
-- =============================================
ALTER PROCEDURE [dbo].[rsp_ROL_MostrarRolId] 
	@intUsuarioId	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- i50n,terfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT *
	FROM [dbo].[tblRol]
	WHERE  [rolId] = @intUsuarioId and estado = 'activo';
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_MostrarIdByPermRol]    Script Date: 10/31/2017 11:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	Mostrar Id
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_MostrarIdByPermRol]
@pRolId int,
@pPermisoID int

AS
BEGIN
SELECT *
  FROM [dbo].[tblRolPermiso]
	WHERE [rolId] = @pRolId and [permisoId] = @pPermisoID
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[ursp_USUARIOROL_InsertarUsuarioRol]    Script Date: 11/07/2017 17:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 12-09-2016
-- Description:	Insertar un UsuarioRol
-- =============================================
ALTER PROCEDURE [dbo].[ursp_USUARIOROL_InsertarUsuarioRol]

	@varUsuarioId	int,
	@varRolId		int,	
	@varEstado		nvarchar(10),

	@intUsuarioRolId	int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[tblUsuarioRol]
           ([usuarioId]
           ,[rolId]
           ,[estado])
    VALUES
           (
			@varUsuarioId,			
			@varRolId,
			@varEstado			
           )          
	SET	@intUsuarioRolId = SCOPE_IDENTITY()
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblPERMISO_selectByName]    Script Date: 12/01/2017 13:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 12-09-2016
-- Description:	<Mostrar Rol por Nombre>
-- =============================================
CREATE PROCEDURE [dbo].[tblRol_selectByName]
@Nombre NVARCHAR(50)
AS
BEGIN
	SELECT rolId      
	FROM [dbo].[tblrol]
	WHERE nombre = @Nombre
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblUsuarioRol_MostrarIdByUserRol]    Script Date: 12/01/2017 15:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Julio Agreda>
-- Create date: <19,08,2017>
-- Description:	Mostrar  Id
-- =============================================
CREATE PROCEDURE [dbo].[tblUsuarioRol_MostrarIdByUserRol]
@UsuarioId int,
@RolId int
AS
BEGIN
SELECT *
  FROM [dbo].[tblUsuarioRol]
	WHERE [usuarioId] = @UsuarioId and [rolId] = @RolId
END
GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[usp_USUARIO_UpdateUsuario]    Script Date: 12/01/2017 16:12:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 08-09-2016
-- Description:	Actualizar un Usuario
-- =============================================
ALTER PROCEDURE [dbo].[usp_USUARIO_UpdateUsuario] 
	@varNombre		nvarchar(50),
	@apellido		nvarchar(50),

	@intUsuarioId	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- i50n,terfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [bdTienda].[dbo].[tblUsuario]
	SET [nombre] = @varNombre
		,[apellido] = @apellido 	     
	WHERE [usuarioId] = @intUsuarioId
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_totalDelete]    Script Date: 12/10/2017 20:46:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar definitivamente en la tabla tblUSUARIOPERMISO>
-- =============================================
ALTER PROCEDURE [dbo].[tblUSUARIOPERMISO_totalDelete]
@usuarioId int,
@permisoId int
AS
BEGIN
DELETE FROM [dbo].[tblUsuarioPermiso]
      WHERE usuarioId = @usuarioId and permisoId = @permisoId
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[rsp_ROL_MostrarTodos]    Script Date: 12/07/2017 17:23:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 11-09-2016
-- Description:	MostrarTodos
-- =============================================
ALTER PROCEDURE [dbo].[rsp_ROL_MostrarTodos] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- i50n,terfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT r.*
	FROM [dbo].[tblRol] r 
	where r.estado = 'activo'
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblPERMISO_selectById]    Script Date: 12/11/2017 05:57:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Julio Agreda>
-- Create date: <19,08,2017>
-- Description:	<Mostrar Permisos de Roles>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_selectPermisosByUsuarioIdAndRolId]
	@usuarioId int,
	@rolId int
AS
BEGIN
	select distinct up.*
	from tblUsuarioPermiso up, tblPermiso p, tblRolPermiso rp, tblUsuarioRol ur 
	where	
		p.permisoId = up.permisoId and
		p.permisoId = rp.permisoId and		
		
		up.usuarioId = @usuarioId and rp.rolId = @rolId
END


GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[rsp_ROL_EliminarRol]    Script Date: 12/07/2017 17:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 12-09-2016
-- Description:	Eliminar un Rol
-- =============================================
ALTER PROCEDURE [dbo].[rsp_ROL_EliminarRol] 
	@estadoRol	nchar(18),
	@RolId		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- i50n,terfering with SELECT statements.
	SET NOCOUNT ON;	
	UPDATE [dbo].[tblRol]
    SET 
      [estado] = @estadoRol
	WHERE [rolId] =  @RolId
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_insert]    Script Date: 12/10/2017 19:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Julio Agreda>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para insertar en la tabla tblUSUARIOPERMISO>
-- =============================================
ALTER PROCEDURE [dbo].[tblUSUARIOPERMISO_insert]
@usuarioId int,
@pPermisoId int,
@pEstado nchar(18)
AS
BEGIN
INSERT INTO [dbo].[tblUsuarioPermiso]
           ([usuarioId]
           ,[permisoId]
           ,[estado])
     VALUES
           (@usuarioId
           ,@pPermisoID
           ,@pEstado)
END

GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[rsp_ROL_MostrarById]    Script Date: 12/10/2017 21:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julio Agreda
-- Create date: 11-09-2016
-- Description:	Mostrar Rol Selccionado
-- =============================================
CREATE PROCEDURE [dbo].[rsp_ROL_MostrarById] 
	@rolId INT
AS
BEGIN
	SET NOCOUNT ON;
	select rp.*
	from tblRol r, tblRolPermiso rp
	where r.rolId = rp.rolId and  r.rolId = @rolId
END

GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblPERMISO_selectPermisosByUsuarioIdAndRolId]    Script Date: 12/11/2017 09:44:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Julio Agreda>
-- Create date: <19,08,2017>
-- Description:	<Mostrar Si tiene Permisos>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_MostrarSiTienePemiso]
	@usuarioId int,
	@permisoId int
AS
BEGIN
	select distinct up.*
	from tblUsuarioPermiso up
	where up.usuarioId = @usuarioId and up.permisoId = @permisoId
END



GO
USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_totalDelete]    Script Date: 12/01/2017 10:46:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Julio Agreda>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar definitivo en la tabla tblROLPERMISO>
-- =============================================
ALTER PROCEDURE [dbo].[tblROLPERMISO_totalDelete]
	@pIdRolPermiso int
AS
BEGIN
DELETE FROM [dbo].[tblRolPermiso]
 WHERE [idRolPermiso] = @pIdRolPermiso
END
Go


USE [bdTienda]
GO
DROP TABLE tblUsuarioPermiso;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsuarioPermiso](
	[usuarioId] [int] NOT NULL,
	[permisoId] [int] NOT NULL,
	[estado] [nchar](18) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUsuarioPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioPermiso_tblPermiso] FOREIGN KEY([permisoId])
REFERENCES [dbo].[tblPermiso] ([permisoId])
GO
ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tblPermiso]
GO
/****** Object:  ForeignKey [FK_tblUsuarioPermiso_tblUsuario]    Script Date: 09/23/2017 17:45:21 ******/
ALTER TABLE [dbo].[tblUsuarioPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioPermiso_tblUsuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tblUsuario]
GO



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