Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.6.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 5)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.5. Este script solamente se apllica a la version 1.5',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END


USE [bdTienda]
GO

/****** Object:  Table [dbo].[tblPedido]    Script Date: 20/10/2017 1:47:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblPedido](
	[pedidoId] [int] IDENTITY(1,1) NOT NULL,
	[clienteId] [int] NOT NULL,
	[empresaId] [int] NOT NULL,
	[usuarioId] [int] NULL,
	[fecha] [datetime] NOT NULL,
	[Atendido] [bit] NOT NULL,
 CONSTRAINT [PK_tblPedido] PRIMARY KEY CLUSTERED 
(
	[pedidoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblEmpresa] FOREIGN KEY([empresaId])
REFERENCES [dbo].[tblEmpresa] ([empresaId])
GO

ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblEmpresa]
GO

ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblUsuario] FOREIGN KEY([clienteId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO

ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblUsuario]
GO

ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblUsuario1] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tblUsuario] ([usuarioId])
GO

ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblUsuario1]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblDetallePedido](
	[DetallePedidoId] [int] IDENTITY(1,1) NOT NULL,
	[PedidoId] [int] NOT NULL,
	[ProductoId] [int] NOT NULL,
	[Precio] [decimal](5, 2) NOT NULL,
	[Cantidad] [decimal](5, 2) NOT NULL,
	[SubTotal] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_tblDetallePedido] PRIMARY KEY CLUSTERED 
(
	[DetallePedidoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblDetallePedido]  WITH CHECK ADD  CONSTRAINT [FK_tblDetallePedido_tblPedido] FOREIGN KEY([PedidoId])
REFERENCES [dbo].[tblPedido] ([pedidoId])
GO

ALTER TABLE [dbo].[tblDetallePedido] CHECK CONSTRAINT [FK_tblDetallePedido_tblPedido]
GO

ALTER TABLE [dbo].[tblDetallePedido]  WITH CHECK ADD  CONSTRAINT [FK_tblDetallePedido_tblProducto] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[tblProducto] ([productoId])
GO

ALTER TABLE [dbo].[tblDetallePedido] CHECK CONSTRAINT [FK_tblDetallePedido_tblProducto]
GO







CREATE PROCEDURE [dbo].[PEDIDO_Insertar]
	-- Add the parameters for the stored procedure here
	@clienteId INT = NULL
 ,@empresaId INT = NULL
 ,@usuarioId INT = NULL

 ,@fecha DATETIME = NULL
 ,@Atendido BIT = NULL
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
	 )
 
	VALUES(
		 @clienteId
		,@empresaId
		,@usuarioId
		,@fecha
		,@Atendido
	 )

	SET @intPedidoId = SCOPE_IDENTITY()
END
GO


----------------------------------------------------

CREATE PROCEDURE PED_GetPedidos
 
AS
BEGIN
 SET NOCOUNT OFF;

    SELECT *
    FROM tblPedido
END
GO


CREATE PROCEDURE PEDDET_InsertarDetallePedido
  @PedidoId INT = NULL
 ,@ProductoId INT = NULL
 ,
@Precio DECIMAL(5, 2) = NULL
 ,@Cantidad DECIMAL(5, 2) = NULL
 ,@SubTotal DECIMAL(5, 2) = NULL 

AS
BEGIN
 SET NOCOUNT OFF;

    INSERT INTO tblDetallePedido(     
    PedidoId
    ,ProductoId
    ,Precio
    ,Cantidad
    ,SubTotal
 )
 VALUES(
     @PedidoId
    ,@ProductoId
    ,@Precio
    ,@Cantidad
    ,@SubTotal
 )
END
GO


CREATE PROCEDURE PEDDET_GetDetallePedido
  
AS
BEGIN
 SET NOCOUNT OFF;

    SELECT *
    FROM tblDetallePedido
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
           ,6
           ,0)
GO