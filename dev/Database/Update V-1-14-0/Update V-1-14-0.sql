USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_rep_cantidadGenteEnUnMes]    Script Date: 25/6/2019 20:18:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rep_cantidadGenteEnUnMes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rep_cantidadGenteEnUnMes]
GO
/****** Object:  StoredProcedure [dbo].[usp_rep_cantidadGenteEnUnMes]    Script Date: 25/6/2019 20:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rep_cantidadGenteEnUnMes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 10/06/2019
-- Description:	reporte para ver la cantidad de gente que usa micro en un mes
-- =============================================
CREATE PROCEDURE [dbo].[usp_rep_cantidadGenteEnUnMes] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	DECLARE @fechaActual DATETIME
	DECLARE @fechaMesAnterior DATETIME
	set @fechaActual=GETDATE()
	set @fechaMesAnterior= DATEADD(month,-1,@fechaActual)


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


	select  numeroLinea,(select count (*) from tbl_pagos_pagos where lineaId = rl.lineaId and fechaPago between @fechaMesAnterior and @fechaActual ) as nroVeces
	from tbl_rutas_lineas rl
	
	--select  pg.fechaPago , count(ln.numeroLinea) as veces from tbl_pagos_pagos pg
	--join tbl_rutas_lineas ln on pg.lineaId=ln.lineaId
	--where pg.fechaPago > @fechaMesAnterior and pg.fechaPago < @fechaActual
	--group by pg.fechaPago
	



END
' 
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
           ,14
           ,0)
GO