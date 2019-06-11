USE [micruberDB]
GO

alter table tbl_rutas_vehiculos
add desactivado bit null default 0

GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_insertLineaVehiculo]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_insertLineaVehiculo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_insertLineaVehiculo]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getVehiculoById]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getVehiculoById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getVehiculoById]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasByVehiculoId_Asignar]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineasByVehiculoId_Asignar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getLineasByVehiculoId_Asignar]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllVehiculos]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllVehiculos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getAllVehiculos]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllLineas]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllLineas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getAllLineas]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteVehiculo]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_deleteVehiculo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_deleteVehiculo]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteLinea]    Script Date: 11/6/2019 00:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_deleteLinea]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_deleteLinea]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteLinea]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_deleteLinea]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Denar Terrazas
-- Create date: 09/06/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_deleteLinea]
	-- Add the parameters for the stored procedure here
	@intLineaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


UPDATE [dbo].[tbl_rutas_lineas]
		SET [eliminado] = 1
      WHERE [lineaId] = @intLineaId



END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_deleteVehiculo]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_deleteVehiculo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 10/04/2019
-- Description:	Borrado logico de vehiculo
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_deleteVehiculo]
	-- Add the parameters for the stored procedure here
	@intVehiculoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tbl_rutas_vehiculos]
	SET [desactivado] = 1
	WHERE [vehiculoId] =@intVehiculoId
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllLineas]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllLineas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Franz Bascope
-- Create date: 15/05/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getAllLineas]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT [lineaId]
      ,[numeroLinea]
  FROM [dbo].[tbl_rutas_lineas]

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getAllVehiculos]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getAllVehiculos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Franz Bascope
-- Create date: 14/05/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getAllVehiculos]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [vehiculoId]
		  ,[capacidad]
		  ,[placa]
	  FROM [dbo].[tbl_rutas_vehiculos]
	  WHERE desactivado= 0

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasByVehiculoId_Asignar]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineasByVehiculoId_Asignar]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getLineasByVehiculoId_Asignar]
	-- Add the parameters for the stored procedure here
	@intVehiculoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

SELECT [lineaId]
      ,[numeroLinea],
	  case when lineaId IN (select lineaId FROM tbl_rutas_vehiculosLineas where vehiculoId=@intVehiculoId) then 1 else 0 end [perteneceLinea]
  FROM [dbo].[tbl_rutas_lineas]

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getVehiculoById]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getVehiculoById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 08/04/2019
-- Description:	Obtiene un vehiculo por ID
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getVehiculoById]
	-- Add the parameters for the stored procedure here
	@VehiculoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT vehiculoId
		  ,capacidad,
		  [placa]
		  
	  FROM [dbo].[tbl_rutas_vehiculos]
	  where [vehiculoId] =@VehiculoId
	   


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_insertLineaVehiculo]    Script Date: 11/6/2019 00:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_insertLineaVehiculo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 07/04/2019
-- Description:	Asigna vehiculo a linea
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_insertLineaVehiculo]
	-- Add the parameters for the stored procedure here
	@lineaId int,
	@rutaId int,
	@Id	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO [dbo].[tbl_rutas_rutasLineas]
			([lineaId]
			,[rutaId])
		VALUES
			(@lineaId
			,@rutaId)

	SET @Id = SCOPE_IDENTITY()
	 


END
' 
END
GO


/****** Object:  Table [dbo].[tbl_rutas_coordenadas]    Script Date: 6/11/2019 12:39:23 AM ******/

----------------------------------------------------------------------->
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

