Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.8.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 7)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.7. Este script solamente se apllica a la version 1.7',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END

USE [bdTienda]
GO
ALTER TABLE [dbo].[tblPedido] ADD latitud VARCHAR(15) NULL, longitud VARCHAR(15) NULL, isMovil BIT NULL;
GO

USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PEDIDO_Insertar]    Script Date: 27/10/2017 20:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PEDIDO_Insertar]
	-- Add the parameters for the stored procedure here
	@clienteId INT = NULL
 ,@empresaId INT = NULL
 ,@usuarioId INT = NULL

 ,@fecha DATETIME = NULL
 ,@Atendido BIT = NULL
 ,@latitud VARCHAR(15) = NULL
 ,@longitud VARCHAR(15) = NULL
 ,@isMovil BIT = NULL
 ,@intPedidoId INT OUTPUT	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		INSERT INTO tblPedido(     
		clienteId
		,empresaId
		,usuarioId
		,fecha
		,Atendido
		,latitud
		,longitud
		,isMovil
	 )
 
	VALUES(
		 @clienteId
		,@empresaId
		,@usuarioId
		,@fecha
		,@Atendido
		,@latitud
		,@longitud
		,@isMovil
	 )

	SET @intPedidoId = SCOPE_IDENTITY()
END
GO


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PED_GetPedidoById]    Script Date: 02/11/2017 20:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 02/11/2017
-- Description:	Obtener pedidos por ID
-- =============================================
CREATE PROCEDURE [dbo].[PED_GetPedidoById]
	-- Add the parameters for the stored procedure here
	@pedidoId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM [dbo].[tblPedido] 
	WHERE [pedidoId] = @pedidoId
END
GO


USE [bdTienda]
GO
/****** Object:  StoredProcedure [dbo].[PED_AtenderPedido]    Script Date: 02/11/2017 20:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 02/11/2017
-- Description:	Atender Pedido
-- =============================================
CREATE PROCEDURE [dbo].[PED_AtenderPedido]
	-- Add the parameters for the stored procedure here
	@pedidoId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tblPedido]
   SET [Atendido] = 1
     WHERE [pedidoId] = @pedidoId

END
GO

USE [bdTienda]
GO
/****** Object:  Table [dbo].[tblConfigDash]    Script Date: 02/11/2017 20:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConfigDash](
	[configId] [int] IDENTITY(1,1) NOT NULL,
	[dashId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[productoId] [int] NOT NULL,
	[empresaId] [int] NOT NULL,
	[cantidad] [decimal](10, 2) NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_tblConfigDash] PRIMARY KEY CLUSTERED 
(
	[configId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDash]    Script Date: 02/11/2017 20:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDash](
	[dashId] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_tblDash] PRIMARY KEY CLUSTERED 
(
	[dashId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblConfigDash]  WITH CHECK ADD  CONSTRAINT [FK_tblConfigDash_tblDash] FOREIGN KEY([dashId])
REFERENCES [dbo].[tblDash] ([dashId])
GO
ALTER TABLE [dbo].[tblConfigDash] CHECK CONSTRAINT [FK_tblConfigDash_tblDash]
GO
ALTER TABLE [dbo].[tblConfigDash]  WITH CHECK ADD  CONSTRAINT [FK_tblConfigDash_tblEmpresa] FOREIGN KEY([empresaId])
REFERENCES [dbo].[tblEmpresa] ([empresaId])
GO
ALTER TABLE [dbo].[tblConfigDash] CHECK CONSTRAINT [FK_tblConfigDash_tblEmpresa]
GO
ALTER TABLE [dbo].[tblConfigDash]  WITH CHECK ADD  CONSTRAINT [FK_tblConfigDash_tblProducto] FOREIGN KEY([productoId])
REFERENCES [dbo].[tblProducto] ([productoId])
GO
ALTER TABLE [dbo].[tblConfigDash] CHECK CONSTRAINT [FK_tblConfigDash_tblProducto]
GO
ALTER TABLE [dbo].[tblConfigDash]  WITH CHECK ADD  CONSTRAINT [FK_tblConfigDash_tblUsuario] FOREIGN KEY([userId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tblConfigDash] CHECK CONSTRAINT [FK_tblConfigDash_tblUsuario]
GO

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