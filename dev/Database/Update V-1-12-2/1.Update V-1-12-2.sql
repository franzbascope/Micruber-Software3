USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioByCodigoNFC]    Script Date: 24/06/2019 04:34:20 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_seg_getUsuarioByCodigoNFC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_seg_getUsuarioByCodigoNFC]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_insertPago]    Script Date: 24/06/2019 04:34:20 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_pagos_insertPago]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_pagos_insertPago]
GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_insertPago]    Script Date: 24/06/2019 04:34:20 p. m. ******/
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

	update tbl_seg_usuario 
	set saldoActual = saldoActual - (select monto from tbl_pagos_conceptos where conceptoId = @intConceptoId)
	where usuarioId=@intUsuarioId



END
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getUsuarioByCodigoNFC]    Script Date: 24/06/2019 04:34:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 23/06/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_seg_getUsuarioByCodigoNFC] 
	-- Add the parameters for the stored procedure here
	@varCodigoNFC varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

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
			  ,[saldoActual]
			  ,[esEstudiante]
			  ,[tempPassword]
			  ,[rolId]
			  ,[tipoUsuario]
			  ,[codigoNFC]
		  FROM [dbo].[tbl_seg_usuario] where [codigoNFC] = @varCodigoNFC
	
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
           ,2)
GO

