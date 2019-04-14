Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.9.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 8)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.8. Este script solamente se apllica a la version 1.8',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PEDDET_GetDetallePedidoByPedidoId]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Obtener Detalle de Pedido por PedidoId
-- =============================================
CREATE PROCEDURE [dbo].[PEDDET_GetDetallePedidoByPedidoId]
	-- Add the parameters for the stored procedure here
	@PedidoId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM [dbo].[tblDetallePedido] 
	WHERE [PedidoId] = @PedidoId
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[DASH_InsertDash]   Script Date: 05/11/2017 12:33:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Insertar Dispositivo DASH-BUTTON
-- =============================================
CREATE PROCEDURE [dbo].[DASH_InsertDash]
	-- Add the parameters for the stored procedure here	
	@Codigo VARCHAR(50),
	@Estado BIT,

	@DashId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[tblDash]
           ([codigo]
           ,[estado])
     VALUES
           (@Codigo
           ,@Estado)

	SET @DashId = SCOPE_IDENTITY();

END
GO 


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[DASH_UpdateDash]    Script Date: 05/11/2017 12:33:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Actualizar Dispositivo DASH-BUTTON
-- =============================================
CREATE PROCEDURE [dbo].[DASH_UpdateDash]
	-- Add the parameters for the stored procedure here	
	@DashId	INT,
	@Codigo VARCHAR(50),
	@Estado BIT	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tblDash]
	SET [codigo] = @Codigo
      ,[estado] = @Estado
	WHERE [dashId] = @DashId
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[DASH_DeleteDash]    Script Date: 05/11/2017 12:33:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Eliminar Dispositivo DASH-BUTTON
-- =============================================
CREATE PROCEDURE [dbo].[DASH_DeleteDash]
	-- Add the parameters for the stored procedure here	
	@DashId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[tblDash]
    WHERE [dashId] = @DashId

END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[DASH_GetAllDash]    Script Date: 05/11/2017 12:33:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Obtener Dispositivos DASH-BUTTON
-- =============================================
CREATE PROCEDURE [dbo].[DASH_GetAllDash]
	-- Add the parameters for the stored procedure here		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM [tblDash]

END
GO


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[CONF_InsertConfigDash]   Script Date: 05/11/2017 12:33:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Insertar configuración de Dash
-- =============================================
CREATE PROCEDURE [dbo].[CONF_InsertConfigDash]
	-- Add the parameters for the stored procedure here
	@DashId	INT,
	@UserId	INT,
	@ProductoId	INT,
	@EmpresaId	INT,
	@Cantidad	DECIMAL(10, 2),
	@Fecha	DATETIME,

	@ConfigId	INT OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[tblConfigDash]
           ([dashId]
           ,[userId]
           ,[productoId]
           ,[empresaId]
           ,[cantidad]
           ,[fecha])
     VALUES
           (@DashId
           ,@UserId
           ,@ProductoId
           ,@EmpresaId
           ,@Cantidad
           ,@Fecha)

	SET @ConfigId = SCOPE_IDENTITY();
END
GO


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[CONF_UpdateConfigDash]    Script Date: 05/11/2017 12:52:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Actualizar configuración de Dash
-- =============================================
CREATE PROCEDURE [dbo].[CONF_UpdateConfigDash]
	-- Add the parameters for the stored procedure here
	@ConfigId	INT,
	@DashId	INT,
	@UserId	INT,
	@ProductoId	INT,
	@EmpresaId	INT,
	@Cantidad	DECIMAL(10, 2),
	@Fecha	DATETIME

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tblConfigDash]
	SET [dashId] = @DashId
      ,[userId] = @UserId
      ,[productoId] = @ProductoId
      ,[empresaId] = @EmpresaId
      ,[cantidad] = @Cantidad
      ,[fecha] = @Fecha
	WHERE [configId] = @ConfigId

END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[CONF_DeleteConfigDash]    Script Date: 05/11/2017 12:52:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Eliminar configuración de Dash
-- =============================================
CREATE PROCEDURE [dbo].[CONF_DeleteConfigDash]
	-- Add the parameters for the stored procedure here
	@ConfigId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[tblConfigDash]
      WHERE [configId] = @ConfigId

END
GO


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[CONF_GetAllConfigDash]    Script Date: 05/11/2017 12:52:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Obtener toda las configuraciones del Dash
-- =============================================
CREATE PROCEDURE [dbo].[CONF_GetAllConfigDash]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM [tblConfigDash]
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
           ,9
           ,0)
GO