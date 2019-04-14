Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.11.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 11)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.11. Este script solamente se apllica a la version 1.11',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END
GO


USE [bdTienda]
GO
ALTER TABLE [dbo].[tblConfigDash] ADD latitud VARCHAR(15) NULL, longitud VARCHAR(15) NULL;
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PED_GetPedidos]    Script Date: 10/12/2017 21:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
	ORDER BY pe.[fecha] DESC 
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
           ,12
           ,0)
GO