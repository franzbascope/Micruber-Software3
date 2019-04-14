Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.10.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 9)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.8. Este script solamente se apllica a la version 1.9',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END
GO



USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PED_GetPedidoById]    Script Date: 07/11/2017 20:30:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 02/11/2017
-- Description:	Obtener pedidos por ID
-- =============================================
ALTER PROCEDURE [dbo].[PED_GetPedidoById]
	-- Add the parameters for the stored procedure here
	@pedidoId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [pedidoId],
		[clienteId],
		pe.[empresaId],
		em.[nombre] [nombreEmpresa],
		pe.[usuarioId],		
		us.[nombre] + ' ' + us.[apellido] [nombreCliente],
		us.[correo] [correo],
		pe.[fecha],
		[Atendido],
		[latitud],
		[longitud],
		pe.[isMovil],
		(CASE WHEN(pe.[isMovil] = 1) THEN 'Teléfono Móvil' ELSE 'Dash-Button' END) [Dispositivo],
		(SELECT SUM(DP.SubTotal) [totalPago]
		FROM [dbo].[tblPedido] pe, [dbo].[tblDetallePedido] dp 
		WHERE pe.[pedidoId] = @PedidoId 
		AND dp.[PedidoId] = pe.[pedidoId] ) [totalPago]
	FROM [dbo].[tblPedido] pe 
	JOIN [dbo].[tblUsuario] us ON us.[usuarioId] = pe.[clienteId] 
	JOIN [dbo].[tblEmpresa] em ON em.[empresaId] = pe.[empresaId] 
	WHERE [pedidoId] = @pedidoId
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PED_GetPedidos]    Script Date: 07/11/2017 20:30:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


----------------------------------------------------

ALTER PROCEDURE [dbo].[PED_GetPedidos]
 
AS
BEGIN
 SET NOCOUNT OFF;

    SELECT [pedidoId],
		[clienteId],
		pe.[empresaId],
		em.[nombre] [nombreEmpresa],
		pe.[usuarioId],		
		us.[nombre] + ' ' + us.[apellido] [nombreCliente],
		us.[correo] [correo],
		pe.[fecha],
		[Atendido],
		[latitud],
		[longitud],
		pe.[isMovil],
		(CASE WHEN(pe.[isMovil] = 1) THEN 'Teléfono Móvil' ELSE 'Dash-Button' END) [Dispositivo], 
		(SELECT SUM(DP.SubTotal) [totalPago]
		FROM [dbo].[tblPedido] pd, [dbo].[tblDetallePedido] dp 
		WHERE pd.[pedidoId] = pe.pedidoId
		AND dp.[PedidoId] = pd.[pedidoId] ) [totalPago]
	FROM [dbo].[tblPedido] pe 
	JOIN [dbo].[tblUsuario] us ON us.[usuarioId] = pe.[clienteId] 
	JOIN [dbo].[tblEmpresa] em ON em.[empresaId] = pe.[empresaId] 	
END
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PEDDET_GetDetallePedidoByPedidoId]    Script Date: 07/11/2017 20:31:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 05/11/2017
-- Description:	Obtener Detalle de Pedido por PedidoId
-- =============================================
ALTER PROCEDURE [dbo].[PEDDET_GetDetallePedidoByPedidoId]
	-- Add the parameters for the stored procedure here
	@PedidoId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [DetallePedidoId],
		[PedidoId],
		dp.[ProductoId],				
		p.[nombre] [nombreProducto],
		dp.[Precio],
		[Cantidad],
		[SubTotal]
	FROM [dbo].[tblDetallePedido] dp 
	JOIN [dbo].[tblProducto] p ON p.[productoId] = dp.[ProductoId]
	WHERE [PedidoId] = @PedidoId

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
           ,10
           ,0)
GO
