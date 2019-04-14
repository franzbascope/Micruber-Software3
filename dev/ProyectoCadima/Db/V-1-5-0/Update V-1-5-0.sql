Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdTienda')
	RAISERROR('La base de datos ''bdTienda'' no existe. Cree la base de datos primero',16,127)
GO

USE [bdTienda]
GO

PRINT 'Actualizando a la version 1.5.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 1 AND @intVersionMenor = 4)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 1.4. Este script solamente se apllica a la version 1.4',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END


USE [bdTienda]
GO
/****** Object:  Table [dbo].[tblEmpresa]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmpresa](
	[empresaId] [int] IDENTITY(1,1) NOT NULL,
	[tipoIdc] [int] NOT NULL,
	[nit] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[gerente] [nvarchar](50) NOT NULL,
	[telefono] [nvarchar](10) NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_tblEmpresa] PRIMARY KEY CLUSTERED 
(
	[empresaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblProducto]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducto](
	[productoId] [int] IDENTITY(1,1) NOT NULL,
	[tipoIdc] [int] NOT NULL,
	[empresaId] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[precio] [decimal](10, 2) NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_tblProducto] PRIMARY KEY CLUSTERED 
(
	[productoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTipoHijos]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTipoHijos](
	[tipoHijosId] [int] NOT NULL,
	[tipoMaestroId] [int] NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[valor] [varchar](50) NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_tblTipoHijos] PRIMARY KEY CLUSTERED 
(
	[tipoHijosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTipoMaestro]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTipoMaestro](
	[tipoMaestroId] [int] NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tblTipoMaestro] PRIMARY KEY CLUSTERED 
(
	[tipoMaestroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblEmpresa]  WITH CHECK ADD  CONSTRAINT [FK_tblEmpresa_tblEmpresa] FOREIGN KEY([tipoIdc])
REFERENCES [dbo].[tblTipoHijos] ([tipoHijosId])
GO
ALTER TABLE [dbo].[tblEmpresa] CHECK CONSTRAINT [FK_tblEmpresa_tblEmpresa]
GO
ALTER TABLE [dbo].[tblProducto]  WITH CHECK ADD  CONSTRAINT [FK_tblProducto_tblEmpresa] FOREIGN KEY([empresaId])
REFERENCES [dbo].[tblEmpresa] ([empresaId])
GO
ALTER TABLE [dbo].[tblProducto] CHECK CONSTRAINT [FK_tblProducto_tblEmpresa]
GO
ALTER TABLE [dbo].[tblProducto]  WITH CHECK ADD  CONSTRAINT [FK_tblProducto_tblTipoHijos] FOREIGN KEY([tipoIdc])
REFERENCES [dbo].[tblTipoHijos] ([tipoHijosId])
GO
ALTER TABLE [dbo].[tblProducto] CHECK CONSTRAINT [FK_tblProducto_tblTipoHijos]
GO
ALTER TABLE [dbo].[tblTipoHijos]  WITH CHECK ADD  CONSTRAINT [FK_tblTipoHijos_tblTipoMaestro] FOREIGN KEY([tipoMaestroId])
REFERENCES [dbo].[tblTipoMaestro] ([tipoMaestroId])
GO
ALTER TABLE [dbo].[tblTipoHijos] CHECK CONSTRAINT [FK_tblTipoHijos_tblTipoMaestro]
GO

/****** Object:  StoredProcedure [dbo].[emp_EMP_DeleteEmpresa]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jose Manuel Cadima
-- Create date: 13/10/2017
-- Description:	Eliminar Empresa
-- =============================================
CREATE PROCEDURE [dbo].[emp_EMP_DeleteEmpresa]
	-- Add the parameters for the stored procedure here
	@intEmpresaId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[tblEmpresa]
	SET [estado] = 0
	WHERE [empresaId] = @intEmpresaId
      
END
GO
/****** Object:  StoredProcedure [dbo].[emp_EMP_GetEmpresaById]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 13/10/2017
-- Description:	Obtener Empresas por Id
-- =============================================
CREATE PROCEDURE [dbo].[emp_EMP_GetEmpresaById]
	-- Add the parameters for the stored procedure here
	@intEmpresaId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM[dbo].[tblEmpresa]
	WHERE [empresaId] = @intEmpresaId
END
GO
/****** Object:  StoredProcedure [dbo].[emp_EMP_GetEmpresaByName]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 13/10/2017
-- Description:	Obtener Empresas por Nombre
-- =============================================
CREATE PROCEDURE [dbo].[emp_EMP_GetEmpresaByName]
	-- Add the parameters for the stored procedure here
	@nvarNombre NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM[dbo].[tblEmpresa]
	WHERE [nombre] = @nvarNombre
END
GO
/****** Object:  StoredProcedure [dbo].[emp_EMP_GetEmpresas]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima 
-- Create date: 13/10/2017
-- Description:	Obtener Empresas
-- =============================================
CREATE PROCEDURE [dbo].[emp_EMP_GetEmpresas]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [empresaId]
      ,[tipoIdc]
      ,[nit]
      ,[nombre]
      ,[gerente]
      ,[telefono]
      ,[estado]
	FROM [dbo].[tblEmpresa]	

END
GO
/****** Object:  StoredProcedure [dbo].[emp_EMP_InsertarEmpresa]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 13/10/2017
-- Description:	Insertar la empresa
-- =============================================
CREATE PROCEDURE [dbo].[emp_EMP_InsertarEmpresa]
	-- Add the parameters for the stored procedure here
	@intTipoIdc INT,
	@nvarNit NVARCHAR(50),
	@nvarNombre NVARCHAR(50),
	@nvarGerente NVARCHAR(50),
	@nvarTelefono NVARCHAR(10),	
	@ncharEstado BIT,

	@intEmpresaId INT OUTPUT	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[tblEmpresa]
           ([tipoIdc]
		   ,[nit]
           ,[nombre]
           ,[gerente]
           ,[telefono]           
           ,[estado])
     VALUES
           (
				@intTipoIdc,
				@nvarNit, 
				@nvarNombre, 
				@nvarGerente, 
				@nvarTelefono, 				
				@ncharEstado							
		   )

	SET @intEmpresaId = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[emp_EMP_UpdateEmpresa]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima
-- Create date: 13/10/2017
-- Description: Actualizar empresa
-- =============================================
CREATE PROCEDURE [dbo].[emp_EMP_UpdateEmpresa]
	-- Add the parameters for the stored procedure here
	@intTipoIdc INT,
	@nvarNit NVARCHAR(50),
	@nvarNombre NVARCHAR(50),
	@nvarGerente NVARCHAR(50),
	@nvarTelefono NVARCHAR(10),		

	@intEmpresaId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tblEmpresa]
   SET [tipoIdc] = @intTipoIdc
      ,[nit] = @nvarNit
      ,[nombre] = @nvarNombre
      ,[gerente] = @nvarGerente
      ,[telefono] = @nvarTelefono      
 WHERE [empresaId] = @intEmpresaId

END
GO
/****** Object:  StoredProcedure [dbo].[prod_PROD_DeleteProducto]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima
-- Create date: 13/10/2017
-- Description: Eliminar producto
-- =============================================
CREATE PROCEDURE [dbo].[prod_PROD_DeleteProducto]
	-- Add the parameters for the stored procedure here	
	@intProductoId INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[tblProducto]
	SET [estado] = 0		
	WHERE [productoId] = @intProductoId	
END
GO
/****** Object:  StoredProcedure [dbo].[prod_PROD_GetProductos]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima 
-- Create date: 13/10/2017
-- Description:	Obtener Productos
-- =============================================
CREATE PROCEDURE [dbo].[prod_PROD_GetProductos]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT [productoId]
		,[tipoIdc]
		,[empresaId]
		,[nombre]
		,[precio]
		,[estado]
  FROM [dbo].[tblProducto]

END
GO
/****** Object:  StoredProcedure [dbo].[prod_PROD_GetProductosById]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 13/10/2017
-- Description:	Obtener Productos por Id
-- =============================================
CREATE PROCEDURE [dbo].[prod_PROD_GetProductosById]
	-- Add the parameters for the stored procedure here
	@intProductoId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM[dbo].[tblProducto]
	WHERE [productoId] = @intProductoId
END
GO
/****** Object:  StoredProcedure [dbo].[prod_PROD_InsertProducto]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima
-- Create date: 13/10/2017
-- Description: Insertar producto
-- =============================================
CREATE PROCEDURE [dbo].[prod_PROD_InsertProducto]
	-- Add the parameters for the stored procedure here
	@intTipoIdc INT,
	@intEmpresaId INT,
	@nvarNombre NVARCHAR(50),
	@decPrecio DECIMAL(10,2),
	@bitEstado BIT,

	@intProductoId INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	INSERT INTO [dbo].[tblProducto]
           ([tipoIdc]
           ,[empresaId]
           ,[nombre]
           ,[precio]
           ,[estado])
     VALUES
           (@intTipoIdc
           ,@intEmpresaId
           ,@nvarNombre
           ,@decPrecio
           ,@bitEstado
		   )
	
	SET @intProductoId = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[prod_PROD_UpdateProducto]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima
-- Create date: 13/10/2017
-- Description: Actualizar producto
-- =============================================
CREATE PROCEDURE [dbo].[prod_PROD_UpdateProducto]
	-- Add the parameters for the stored procedure here
	@intTipoIdc INT,
	@intEmpresaId INT,
	@nvarNombre NVARCHAR(50),
	@decPrecio DECIMAL(10,2),	

	@intProductoId INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[tblProducto]
	SET [tipoIdc] = @intTipoIdc
		,[empresaId] = @intEmpresaId
		,[nombre] = @nvarNombre
		,[precio] = @decPrecio		
	WHERE [productoId] = @intProductoId	
END
GO
/****** Object:  StoredProcedure [dbo].[tipo_TIPO_GetHijos]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 14/10/2017
-- Description:	Obtener todos los Tipo Hijos
-- =============================================
CREATE PROCEDURE [dbo].[tipo_TIPO_GetHijos]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * 
	FROM [dbo].[tblTipoHijos] 	
	
END
GO
/****** Object:  StoredProcedure [dbo].[tipo_TIPO_GetHijosByIdMaestro]    Script Date: 16/10/2017 21:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 14/10/2017
-- Description:	Obtener los Tipo Hijos por Padre
-- =============================================
CREATE PROCEDURE [dbo].[tipo_TIPO_GetHijosByIdMaestro]
	-- Add the parameters for the stored procedure here
	@intTipoMaestroId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * 
	FROM [dbo].[tblTipoHijos] 
	WHERE [tipoMaestroId] = @intTipoMaestroId
	
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
           ,5
           ,0)
GO