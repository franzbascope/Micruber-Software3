USE [micruberDB]
GO

ALTER TABLE [tbl_seg_permisos]
add memotecnico varchar(20) null

ALTER TABLE [tbl_seg_usuario]
add tempPassword varchar(10) null

alter table [tbl_seg_usuario]
add rolId int null

ALTER TABLE [tbl_seg_usuario]
ADD FOREIGN KEY (rolId) REFERENCES tbl_seg_roles(roleId);


--drop table tbl_seg_usuarioRoles

INSERT INTO [dbo].[tbl_seg_roles]
           ([descripcion]
           ,[desactivado])
     VALUES
           ('Administrador'
           ,0)
GO


INSERT INTO [dbo].[tbl_seg_roles]
           ([descripcion]
           ,[desactivado])
     VALUES
           ('Recursos Humanos'
           ,0)
GO

INSERT INTO [dbo].[tbl_seg_permisos]
           ([descripcion]
           ,[memotecnico])
     VALUES
           ('Registrar Usuarios'
           ,'REGISTRO_USUARIOS')
GO

INSERT INTO [dbo].[tbl_seg_permisos]
           ([descripcion]
           ,[memotecnico])
     VALUES
           ('Registrar Roles'
           ,'REGISTRO_ROLES')
GO

INSERT INTO [dbo].[tbl_seg_rolesPermisos]
           ([permisoId]
           ,[roleId])
     VALUES
           (1
           ,1)
GO


INSERT INTO [dbo].[tbl_seg_rolesPermisos]
           ([permisoId]
           ,[roleId])
     VALUES
           (2
           ,1)
GO


INSERT INTO [dbo].[tbl_seg_rolesPermisos]
           ([permisoId]
           ,[roleId])
     VALUES
           (2
           ,2)
GO

update tbl_seg_usuario set rolId = 1
go
/****** Object:  StoredProcedure [dbo].[usp_seg_validarPagina]    Script Date: 10/06/2019 10:48:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_validarPagina]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_validarPagina]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateUsuario]    Script Date: 10/06/2019 10:48:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_updateUsuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_updateUsuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertUsuarioAdministracion]    Script Date: 10/06/2019 10:48:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_insertUsuarioAdministracion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_insertUsuarioAdministracion]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getPermisosByUsuarioId]    Script Date: 10/06/2019 10:48:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getPermisosByUsuarioId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getPermisosByUsuarioId]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_changePassword]    Script Date: 10/06/2019 10:48:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_changePassword]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_changePassword]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_changePassword]    Script Date: 10/06/2019 10:48:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 10/06/2019
-- Description:	cambiar Contraseña
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_changePassword] 
	-- Add the parameters for the stored procedure here
	@intUsuarioId int,
	@varOldPassword varchar(20),
	@varNewPassword varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS (SELECT 1
	FROM [dbo].[tbl_seg_usuario]
	WHERE [usuarioId]=@intUsuarioId
	AND PWDCOMPARE(@varOldPassword, [password]) = 1 )
	BEGIN
		update [dbo].[tbl_seg_usuario] 
		set [password] = PWDENCRYPT(@varNewPassword)
		where [usuarioId] = @intUsuarioId
	END
	ELSE
	BEGIN
		BEGIN TRY
			RAISERROR ('INCORRECT_PASSWORD', 16, 1);
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH;

	END
	

	

END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getPermisosByUsuarioId]    Script Date: 10/06/2019 10:48:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
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
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_insertUsuarioAdministracion]    Script Date: 10/06/2019 10:48:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_insertUsuarioAdministracion]
	-- Add the parameters for the stored procedure here
	@correo varchar(50),
	@nombre varchar(100),
	@intRolId int,
	@userId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DECLARE @varTempPassword varchar(10)
	SET @varTempPassword =  (SELECT LEFT(REPLACE(NEWID(),'-',''),10))

	INSERT INTO [dbo].[tbl_seg_usuario]
			([correo]
			,[password]
			,[nombre]
			,[tempPassword]
			,[rolId]
			,[activo])
		VALUES
			(@correo
			,PWDENCRYPT(@varTempPassword)
			,@nombre
			,@varTempPassword
			,@intRolId
			,1)

	SET @userId = SCOPE_IDENTITY()

	

	 


END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_updateUsuario]    Script Date: 10/06/2019 10:48:03 p. m. ******/
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
	@userId	INT,
	@intRolId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


UPDATE [dbo].[tbl_seg_usuario]
   SET [correo] = @correo
      ,[nombre] = @nombre
	  ,[rolId] = @intRolId
 WHERE [usuarioId] = @userId





END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_validarPagina]    Script Date: 10/06/2019 10:48:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 10/06/2019
-- Description:	SP para validar las paginas que tienen permiso
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_validarPagina] 
	-- Add the parameters for the stored procedure here
	@intUsuarioId int,
	@varMemotecnico varchar(20),
	@bitTienePermiso bit output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists (select 1
	from [dbo].[tbl_seg_permisos] [sp]
	join [dbo].[tbl_seg_rolesPermisos] [spr] on [sp].[permisoId] = [spr].[permisoId]
	join [dbo].[tbl_seg_usuario] [su] on [spr].[roleId] = [su].[rolId]
	WHERE [su].[usuarioId] = @intUsuarioId
	and [sp].[memotecnico] = @varMemotecnico)
	set @bitTienePermiso=1
	else
	set @bitTienePermiso=0

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
           ,8
           ,0)
GO

