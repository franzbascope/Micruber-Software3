USE [micruberDB]
GO
/****** Object:  Table [dbo].[tbl_compras_prueba]    Script Date: 14/04/2019 03:04:11 p.m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_compras_prueba]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_compras_prueba]
GO
/****** Object:  StoredProcedure [dbo].[usp_compras_getPruebas]    Script Date: 14/04/2019 03:04:11 p.m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_compras_getPruebas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_compras_getPruebas]
GO
/****** Object:  StoredProcedure [dbo].[usp_compras_getPruebas]    Script Date: 14/04/2019 03:04:11 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_compras_getPruebas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_compras_getPruebas]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



SELECT [usuarioId]
      ,[correo]
      ,[password]
      ,[nombre]
      ,[activo]
      ,[codigoRecuperacion]
      ,[codigoActivacion]
      ,[fechaCodigoRecuperacion]
      ,[fechaCodigoActivacion]
      ,[eliminado]
  FROM [dbo].[tbl_seg_usuario]




    
END
' 
END
GO
/****** Object:  Table [dbo].[tbl_compras_prueba]    Script Date: 14/04/2019 03:04:11 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_compras_prueba]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_compras_prueba](
	[pruebaId] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_compras_prueba] PRIMARY KEY CLUSTERED 
(
	[pruebaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO


DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,2
           ,0)
GO

