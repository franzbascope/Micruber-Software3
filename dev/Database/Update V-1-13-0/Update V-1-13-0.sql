USE [micruberDB]

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Franz Bascope
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_seg_autenticarUsuario]
	-- Add the parameters for the stored procedure here
	@correo varchar(50),
	@password varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [usuarioId]
		  ,[correo]
		  ,[nombre]
		  ,[activo]
		  ,[saldoActual]
		  ,[esEstudiante]
		  ,[tipoUsuario]
	  FROM [dbo].[tbl_seg_usuario]
	  WHERE [correo]=@correo
	  AND PWDCOMPARE(@password, [password]) = 1 
	  AND [activo]=1
	  and [eliminado] =0
	   


END

ALTER TABLE tbl_pagos_pagos ALTER COLUMN vehiculoId int NULL;


GO
/****** Object:  StoredProcedure [dbo].[usp_pagos_pagoApp]    Script Date: 6/11/2019 3:09:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ETCHEVERRY/PC
-- Create date: 11/06/2019
-- Description:	Realizar Pagos
-- =============================================
CREATE PROCEDURE [dbo].[usp_pagos_pagoApp]
	-- Add the parameters for the stored procedure here
	@correo varchar, --correo o usuario
	@monto int,
	@userRecargo int,
	@conceptoId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.d
	SET NOCOUNT ON;
	DECLARE @logUs int
	DECLARE @usUpMonto int
	DECLARE @nMonto int
	DECLARE @pagoId int

	SELECT @logUs=usuarioId FROM tbl_seg_usuario WHERE @correo = correo or nombre like '%' + @correo + '%'

	if(isnull(@logUs,0) > 0)
	begin
		INSERT INTO [dbo].[tbl_pagos_conceptos]
			   (descripcion,monto,esIngreso)
		VALUES
			   ('Recarga',@monto,1)

		SET @conceptoId = SCOPE_IDENTITY()

		if( isnull(@conceptoId,0) > 0)
		begin
			INSERT INTO [dbo].[tbl_pagos_pagos]
			   (fechaPago,conceptoId,usuarioId,usuarioRecarga)
			VALUES
			   (GETDATE(),@conceptoId,@logUs,@userRecargo)
			
			SET @pagoId = SCOPE_IDENTITY()

			if( isnull(@pagoId,0) > 0)
			begin
				SELECT @usUpMonto=sug.usuarioId,@nMonto=sug.saldoActual FROM tbl_seg_usuario sug
				join tbl_pagos_pagos pag
				on sug.usuarioId = pag.usuarioId
				where @pagoId = pagoId

				UPDATE [dbo].[tbl_seg_usuario]
				SET saldoActual = @nMonto + @monto
				WHERE [usuarioId] = @usUpMonto
			end

		end

	end
END
GO

USE [micruberDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_seg_getAllUsuarios]    Script Date: 6/11/2019 4:28:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erick Etcheverry
-- Create date: 6/11/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_pagos_getAllPagos]
	@intUsuarioId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select correo,usuarioRecarga usuarioRecargo,monto from tbl_pagos_pagos pag
	join tbl_pagos_conceptos con
	on pag.conceptoId = con.conceptoId
	join tbl_seg_usuario seg
	on pag.usuarioRecarga = seg.usuarioId
	where pag.usuarioId = @intUsuarioId

END

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (1
           ,13
           ,0)
GO