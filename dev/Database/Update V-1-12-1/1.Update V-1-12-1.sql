USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasCercanas]    Script Date: 22/06/2019 06:07:47 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_rutas_getLineasCercanas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_rutas_getLineasCercanas]
GO
/****** Object:  StoredProcedure [dbo].[usp_rutas_getLineasCercanas]    Script Date: 22/06/2019 06:07:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 21/06/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_rutas_getLineasCercanas]
	-- Add the parameters for the stored procedure here
	@decLatitudInicio decimal(20,10)
	,@decLongitudInicio decimal(20,10)
	,@decLatitudFin decimal(20,10)
	,@decLongitudFin decimal(20,10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



	DECLARE @varPointInicio geography = geography::Point(@decLatitudInicio, @decLongitudInicio, 4326);
	DECLARE @varPointFin geography = geography::Point(@decLatitudFin, @decLongitudFin, 4326);


	DECLARE @decLatitudActual decimal(20,10) 
	DECLARE @decLongitudActual decimal(20,10) 
	DECLARE @intCoordenadaId int
	declare @intLineaId int
	DECLARE @varPointInicioActual geography 
	DECLARE @varPointFinActual geography 
	declare @decDistancia1 float
	declare @decDistancia2 float

	declare @decDistanciaCorta1 float
	declare @decDistanciaCorta2 float
	declare @decPromedioCaminar float
	declare @decDistanciaRecorrido float
	DECLARE @varPointDeterminar geography 
	DECLARE @varPointDeterminarAnterior geography 

	declare @distanciaId int
	declare @distanciaId2 int


	CREATE TABLE #tablaResultado( 
		rowNumber int identity(1,1)
		,lineaId int 
		,distanciaInicio  float 
		,distanciaFin  float
		,puntoActual geography  )

	CREATE TABLE #tablaDistancias( 
	lineaId int 
	,promedioCaminar  float
	,distancia float )

	 

	declare @intLineaIdActual int
	DECLARE lineaCursor CURSOR FOR 
	SELECT [lineaId]
	FROM [micruberDB].[dbo].[tbl_rutas_lineas]

	OPEN lineaCursor  
	FETCH NEXT FROM lineaCursor INTO @intLineaIdActual

	WHILE @@FETCH_STATUS = 0  
	BEGIN 
			DECLARE db_cursor CURSOR FOR 
			SELECT [coodenadaId]
			  ,[latitud]
			  ,[longitud]
			  ,[lineaId]
		  FROM [micruberDB].[dbo].[tbl_rutas_coordenadas] where lineaId=@intLineaIdActual

			OPEN db_cursor  
			FETCH NEXT FROM db_cursor INTO @intCoordenadaId,@decLatitudActual,@decLongitudActual,@intLineaId  

			WHILE @@FETCH_STATUS = 0  
			BEGIN 
		  			set @varPointInicioActual= geography::Point(@decLatitudActual, @decLongitudActual, 4326);
					SELECT @decDistancia1= @varPointInicio.STDistance(@varPointInicioActual) 

					SELECT @decDistancia2= @varPointFin.STDistance(@varPointInicioActual)

					insert into #tablaResultado values(@intLineaId,@decDistancia1,@decDistancia2,@varPointInicioActual)

				  FETCH NEXT FROM db_cursor INTO @intCoordenadaId,@decLatitudActual,@decLongitudActual,@intLineaId   
			END 

			CLOSE db_cursor  
			DEALLOCATE db_cursor
			
			select top 1 @decDistanciaCorta1= distanciaInicio,@distanciaId=rowNumber from #tablaResultado order by distanciaInicio 
			select top 1 @decDistanciaCorta2=distanciaFin,@distanciaId2=rowNumber from #tablaResultado order by distanciaFin 
		
			--cursor para sacar distancia
			DECLARE @distanciaActual float
			declare @distanciaTotal float
			set @distanciaTotal = 0
			DECLARE cClientes CURSOR FOR
			SELECT  puntoActual
			FROM #tablaResultado where rowNumber between @distanciaId and @distanciaId2
			OPEN cClientes
			FETCH cClientes INTO  @varPointDeterminar

			WHILE (@@FETCH_STATUS = 0 )
			BEGIN
				SELECT @distanciaActual= isnull( @varPointDeterminar.STDistance(@varPointDeterminarAnterior),0)
				select @distanciaTotal += @distanciaActual
			set @varPointDeterminarAnterior = @varPointDeterminar

			FETCH cClientes INTO   @varPointDeterminar

			END
			CLOSE cClientes
			DEALLOCATE cClientes

			insert into  #tablaDistancias values(@intLineaIdActual,(@decDistanciaCorta1+@decDistanciaCorta2)/2,@distanciaTotal)
			delete from  #tablaResultado

		  FETCH NEXT FROM lineaCursor INTO @intLineaIdActual
	END 

	CLOSE lineaCursor  
	DEALLOCATE lineaCursor

 
	select td.lineaId,rl.numeroLinea,td.promedioCaminar as distanciaCaminarMetros,td.distancia distanciaRecorridoMetros from
	 #tablaDistancias td join tbl_rutas_lineas rl on td.lineaId=rl.lineaId
	  order by promedioCaminar,td.distancia
	


	drop table #tablaResultado
	drop table #tablaDistancias

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
           ,12
           ,1)
GO

