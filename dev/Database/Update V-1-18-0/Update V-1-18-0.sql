USE [micruberDB]
GO
USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_rep_cantidadGananciasEnUnMes]    Script Date: 5/7/2019 01:23:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rep_cantidadGananciasEnUnMes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rep_cantidadGananciasEnUnMes]
GO
/****** Object:  StoredProcedure [dbo].[usp_rep_cantidadGananciasEnUnMes]    Script Date: 5/7/2019 01:23:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rep_cantidadGananciasEnUnMes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Luis Humberto
-- Create date: 10/06/2019
-- Description:	reporte para ver la cantidad de gente que usa micro en un mes
-- =============================================
CREATE PROCEDURE [dbo].[usp_rep_cantidadGananciasEnUnMes] 
	-- Add the parameters for the stored procedure here
	AS
	BEGIN
	declare @tablaPagos as table
( fecha date 
, ingresos decimal(10,2) )

DECLARE @datFechaAcual datetime
DECLARE @datFechaMesAnterior datetime
DECLARE @datCurrentDay datetime
set @datFechaAcual = getdate()
SELECT @datFechaMesAnterior= DATEADD(day, -30, @datFechaAcual)
set @datCurrentDay = @datFechaMesAnterior
declare @decMontoActual decimal(10,2)


WHILE @datCurrentDay <= @datFechaAcual
BEGIN
	select @decMontoActual=sum([monto] )
	from [dbo].[tbl_pagos_pagos] [pagos]
	join [dbo].[tbl_pagos_conceptos] [co] on [pagos].[conceptoId] = [co].[conceptoId]
	where  CAST([pagos].[fechaPago] as date)  = CAST( @datCurrentDay AS date)
	if(@decMontoActual is null)
		set @decMontoActual = 0
	INSERT INTO @tablaPagos values(cast(@datCurrentDay as date),@decMontoActual)
	set @decMontoActual =0
   SELECT @datCurrentDay= DATEADD(day, 1, @datCurrentDay)
END
select * from @tablaPagos



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
           ,18
           ,0)
GO
