USE [bdTienda]
GO

/****** Object:  StoredProcedure [dbo].[tblPERMISO_update]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para actualizar en la tabla TBLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_update]
@pPermisoId int,
@pNombre nvarchar(50),
@pDescripcion nvarchar(50),
@pUrl nvarchar(250),
@pPosicion nchar(10),
@pEstado nchar(18)
	
AS
BEGIN

UPDATE [bdTienda].[dbo].[tblPermiso]
   SET [nombre] = @pNombre
      ,[descripcion] = @pDescripcion
      ,[url] = @pUrl
      ,[posicion] = @pPosicion
      ,[estado] = @pEstado
 WHERE permisoId = @pPermisoId

END
GO

/****** Object:  StoredProcedure [dbo].[tblPERMISO_totalDelete]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar(defenitivamente) en la tabla TBLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_totalDelete]
@pPermisoId int
	
AS
BEGIN
	DELETE FROM [bdTienda].[dbo].[tblPermiso]
      WHERE permisoId = @pPermisoId
END
GO

/****** Object:  StoredProcedure [dbo].[tblPERMISO_selectById]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para SELECCIONAR POR ID en la tabla TBLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_selectById]
@pPermisoId int
AS
BEGIN
	SELECT [permisoId]
      ,[nombre]
      ,[descripcion]
      ,[url]
      ,[posicion]
      ,[estado]
  FROM [bdTienda].[dbo].[tblPermiso]
  WHERE permisoId = @pPermisoId
END
GO

/****** Object:  StoredProcedure [dbo].[tblPERMISO_selectAll]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para SELECCIONAR en la tabla TBLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_selectAll]
AS
BEGIN
	SELECT [permisoId]
      ,[nombre]
      ,[descripcion]
      ,[url]
      ,[posicion]
      ,[estado]
  FROM [bdTienda].[dbo].[tblPermiso]
END
GO

/****** Object:  StoredProcedure [dbo].[tblPERMISO_insertar]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para insertar en la tabla TBLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_insertar]
@pNombre nvarchar(50),
@pDescripcion nvarchar(50),
@pUrl nvarchar(250),
@pPosicion nchar(10),
@pEstado nchar(18)
	
AS
BEGIN
	INSERT INTO [bdTienda].[dbo].[tblPermiso]
           ([nombre]
           ,[descripcion]
           ,[url]
           ,[posicion]
           ,[estado])
     VALUES
           (@pNombre, @pDescripcion, @pUrl, @pPosicion, @pEstado)

END
GO

/****** Object:  StoredProcedure [dbo].[tblPERMISO_delete]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar en la tabla TBLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblPERMISO_delete]
@pPermisoId int,
@pNombre nvarchar(50),
@pDescripcion nvarchar(50),
@pUrl nvarchar(250),
@pPosicion nchar(10),
@pEstado nchar(18)
	
AS
BEGIN

UPDATE [bdTienda].[dbo].[tblPermiso]
   SET [nombre] = @pNombre
      ,[descripcion] = @pDescripcion
      ,[url] = @pUrl
      ,[posicion] = @pPosicion
      ,[estado] = @pEstado
 WHERE permisoId = @pPermisoId

END
GO

/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_update]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para actualizar en la tabla tblUSUARIOPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblUSUARIOPERMISO_update]
@pUsuarioID int,
@pPermisoID int,
@pEstado nchar(18)
AS
BEGIN
UPDATE [bdTienda].[dbo].[tblUsuarioPermiso]
   SET [permisoId] = permisoId
      ,[estado] = @pEstado
 WHERE usuarioId = @pUsuarioID
END
GO

/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_totalDelete]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar definitivamente en la tabla tblUSUARIOPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblUSUARIOPERMISO_totalDelete]
@pUsuarioID int
AS
BEGIN
DELETE FROM [bdTienda].[dbo].[tblUsuarioPermiso]
      WHERE usuarioId = @pUsuarioID
END
GO

/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_selectByID]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para seleccionar POR id en la tabla tblUSUARIOPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblUSUARIOPERMISO_selectByID]
@pUsurioID int,
@pPermisoID int
AS
BEGIN
SELECT *
  FROM [bdTienda].[dbo].[tblUsuarioPermiso]
  where usuarioId = @pUsurioID and permisoId = @pPermisoID
END
GO

/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_selectAll]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para seleccionar todo en la tabla tblUSUARIOPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblUSUARIOPERMISO_selectAll]
AS
BEGIN
SELECT *
  FROM [bdTienda].[dbo].[tblUsuarioPermiso]
END
GO

/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_insert]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para insertar en la tabla tblUSUARIOPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblUSUARIOPERMISO_insert]
@pPermisoID int,
@pEstado nchar(18)
AS
BEGIN
INSERT INTO [bdTienda].[dbo].[tblUsuarioPermiso]
           ([permisoId]
           ,[estado])
     VALUES
           (@pPermisoID,@pEstado)
END
GO

/****** Object:  StoredProcedure [dbo].[tblUSUARIOPERMISO_delete]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar en la tabla tblUSUARIOPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblUSUARIOPERMISO_delete]
@pUsuarioID int,
@pPermisoID int,
@pEstado nchar(18)
AS
BEGIN
UPDATE [bdTienda].[dbo].[tblUsuarioPermiso]
   SET [permisoId] = permisoId
      ,[estado] = @pEstado
 WHERE usuarioId = @pUsuarioID
END
GO

/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_update]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para actualizar en la tabla tblROLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_update]
@pIdRolPermiso int,
@pRolId int,
@pPermisoID int,
@pEstado nchar(18)
AS
BEGIN
	UPDATE [bdTienda].[dbo].[tblRolPermiso]
   SET [estado] = @pEstado
 WHERE [idRolPermiso] = @pIdRolPermiso
       and [rolId] = @pRolId and
      [permisoId] = @pPermisoID
END
GO

/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_totalDelete]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar definitivo en la tabla tblROLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_totalDelete]
@pIdRolPermiso int,
@pRolId int,
@pPermisoID int
AS
BEGIN
DELETE FROM [bdTienda].[dbo].[tblRolPermiso]
 WHERE [idRolPermiso] = @pIdRolPermiso
       and [rolId] = @pRolId and
      [permisoId] = @pPermisoID
END
GO

/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_selectByID]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para seleccionar por ID en la tabla tblROLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_selectByID]
@pIdRolPermiso int,
@pRolId int,
@pPermisoID int

AS
BEGIN
SELECT *
  FROM [bdTienda].[dbo].[tblRolPermiso]
	WHERE [idRolPermiso] = @pIdRolPermiso
       and [rolId] = @pRolId and
      [permisoId] = @pPermisoID
END
GO

/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_selectAll]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para seleccionar todo en la tabla tblROLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_selectAll]
AS
BEGIN
SELECT *
  FROM [bdTienda].[dbo].[tblRolPermiso]
END
GO

/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_insert]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para insertar en la tabla tblROLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_insert]
@pIdRolPermiso int,
@pRolId int,
@pPermisoID int,
@pEstado nchar(18)
AS
BEGIN
INSERT INTO [bdTienda].[dbo].[tblRolPermiso]
           ([idRolPermiso]
           ,[rolId]
           ,[permisoId]
           ,[estado])
     VALUES
           (@pIdRolPermiso,@pRolId, @pPermisoID, @pEstado)
END
GO

/****** Object:  StoredProcedure [dbo].[tblROLPERMISO_delete]    Script Date: 09/23/2017 18:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Flavia Veizaga>
-- Create date: <19,08,2017>
-- Description:	<creacion del procedimiento almanacenado para borrar en la tabla tblROLPERMISO>
-- =============================================
CREATE PROCEDURE [dbo].[tblROLPERMISO_delete]
@pIdRolPermiso int,
@pRolId int,
@pPermisoID int,
@pEstado nchar(18)
AS
BEGIN
	UPDATE [bdTienda].[dbo].[tblRolPermiso]
   SET [estado] = @pEstado
 WHERE [idRolPermiso] = @pIdRolPermiso
       and [rolId] = @pRolId and
      [permisoId] = @pPermisoID
END
GO
