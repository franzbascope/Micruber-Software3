USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_rutas_vehiculos]
           ([capacidad]
           ,[placa])
     VALUES
           (20
           ,'413FIS')
GO

INSERT INTO [dbo].[tbl_rutas_vehiculos]
           ([capacidad]
           ,[placa])
     VALUES
           (40
           ,'FBJ123')
GO


INSERT INTO [dbo].[tbl_rutas_lineas]
           ([numeroLinea])
     VALUES
           ('10')
GO


INSERT INTO [dbo].[tbl_rutas_lineas]
           ([numeroLinea])
     VALUES
           ('108')
GO

INSERT INTO [dbo].[tbl_rutas_lineas]
           ([numeroLinea])
     VALUES
           ('72')
GO

INSERT INTO [dbo].[tbl_rutas_vehiculosLineas]
           ([vehiculoId]
           ,[lineaId])
     VALUES
           (1
           ,1)
GO

INSERT INTO [dbo].[tbl_rutas_vehiculosLineas]
           ([vehiculoId]
           ,[lineaId])
     VALUES
           (1
           ,2)
GO


INSERT INTO [dbo].[tbl_rutas_vehiculosLineas]
           ([vehiculoId]
           ,[lineaId])
     VALUES
           (2
           ,2)
GO

INSERT INTO [dbo].[tbl_rutas_vehiculosLineas]
           ([vehiculoId]
           ,[lineaId])
     VALUES
           (2
           ,3)
GO