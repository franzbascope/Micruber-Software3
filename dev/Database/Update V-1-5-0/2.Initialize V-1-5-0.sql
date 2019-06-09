USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_pagos_conceptos]
           ([descripcion]
           ,[monto]
           ,[esIngreso])
     VALUES
           ('pasaje estudiantes'
           ,1
           ,0)
GO



INSERT INTO [dbo].[tbl_pagos_conceptos]
           ([descripcion]
           ,[monto]
           ,[esIngreso])
     VALUES
           ('pasaje Mayores'
           ,2
           ,0)


INSERT INTO [dbo].[tbl_pagos_conceptos]
           ([descripcion]
           ,[monto]
           ,[esIngreso])
     VALUES
           ('carga Saldo'
           ,0
           ,1)

GO

USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_pagos_pagos]
           ([fechaPago]
           ,[usuarioId]
           ,[vehiculoId]
           ,[conceptoId]
           ,[lineaId])
     VALUES
           ('20190608'
           ,1
           ,1
           ,1
           ,1)
GO


INSERT INTO [dbo].[tbl_pagos_pagos]
           ([fechaPago]
           ,[usuarioId]
           ,[vehiculoId]
           ,[conceptoId]
           ,[lineaId])
     VALUES
           (GETDATE()
           ,1
           ,2
           ,2
           ,1)
GO





