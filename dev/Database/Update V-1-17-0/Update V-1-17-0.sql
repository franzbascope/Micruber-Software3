USE [micruberDB]
GO

USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_insertPago]    Script Date: 05/07/2019 12:36:15 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_pagos_insertPago]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_pagos_insertPago]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_getTarjetasByUsuarioId]    Script Date: 05/07/2019 12:36:15 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_pagos_getTarjetasByUsuarioId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_pagos_getTarjetasByUsuarioId]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_pagos_usuarioTarjetas_tbl_seg_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_pagos_usuarioTarjetas]'))
ALTER TABLE [dbo].[tbl_pagos_usuarioTarjetas] DROP CONSTRAINT [FK_tbl_pagos_usuarioTarjetas_tbl_seg_usuario]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_pagos_usuarioTarjetas_tbl_pagos_tarjetas]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_pagos_usuarioTarjetas]'))
ALTER TABLE [dbo].[tbl_pagos_usuarioTarjetas] DROP CONSTRAINT [FK_tbl_pagos_usuarioTarjetas_tbl_pagos_tarjetas]
GO
/****** Object:  Table [dbo].[tbl_pagos_usuarioTarjetas]    Script Date: 05/07/2019 12:36:15 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_pagos_usuarioTarjetas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_pagos_usuarioTarjetas]
GO
/****** Object:  Table [dbo].[tbl_pagos_tarjetas]    Script Date: 05/07/2019 12:36:15 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_pagos_tarjetas]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_pagos_tarjetas]
GO
/****** Object:  Table [dbo].[tbl_pagos_tarjetas]    Script Date: 05/07/2019 12:36:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pagos_tarjetas](
	[id] [int] NOT NULL,
	[codigoNFC] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_pagos_tarjetas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_pagos_usuarioTarjetas]    Script Date: 05/07/2019 12:36:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pagos_usuarioTarjetas](
	[id] [int] NOT NULL,
	[usuarioId] [int] NULL,
	[tarjetaId] [int] NULL,
	[estado] [int] NULL,
 CONSTRAINT [PK_tbl_pagos_usuarioTarjetas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_pagos_usuarioTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pagos_usuarioTarjetas_tbl_pagos_tarjetas] FOREIGN KEY([tarjetaId])
REFERENCES [dbo].[tbl_pagos_tarjetas] ([id])
GO
ALTER TABLE [dbo].[tbl_pagos_usuarioTarjetas] CHECK CONSTRAINT [FK_tbl_pagos_usuarioTarjetas_tbl_pagos_tarjetas]
GO
ALTER TABLE [dbo].[tbl_pagos_usuarioTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pagos_usuarioTarjetas_tbl_seg_usuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tbl_seg_usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tbl_pagos_usuarioTarjetas] CHECK CONSTRAINT [FK_tbl_pagos_usuarioTarjetas_tbl_seg_usuario]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_getTarjetasByUsuarioId]    Script Date: 05/07/2019 12:36:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 2019/07/05
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_pagos_getTarjetasByUsuarioId]
	-- Add the parameters for the stored procedure here
	@intUsuarioId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
SELECT [ut].[estado]
	  ,[tr].[codigoNFC]
	  ,[tr].[id]
  FROM [dbo].[tbl_pagos_usuarioTarjetas] [ut]
  join [dbo].[tbl_pagos_tarjetas] [tr] on [ut].[tarjetaId] = [tr].[id]


END
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_insertPago]    Script Date: 05/07/2019 12:36:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 09/06/2019
-- Description:	Realizar Pagos
-- =============================================
CREATE PROCEDURE [dbo].[usp_pagos_insertPago]
	-- Add the parameters for the stored procedure here
	@intUsuarioId int,
	@intVehiculoId int,
	@intConceptoId int,
	@intLineaId		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[tbl_pagos_pagos]
           ([fechaPago]
           ,[usuarioId]
           ,[vehiculoId]
           ,[conceptoId]
		   ,[lineaId])
     VALUES
           (GETDATE()
           ,@intUsuarioId
           ,@intVehiculoId
           ,@intConceptoId
		   ,@intLineaId)



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
           ,17
           ,0)
GO
