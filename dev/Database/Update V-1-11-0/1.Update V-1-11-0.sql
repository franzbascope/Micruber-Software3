CREATE TABLE tbl_seg_tipoUsuario (
    tipoUsuario int IDENTITY(1,1) PRIMARY KEY ,
    descripcion varchar(50)
);

USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_seg_tipoUsuario]
           ([descripcion])
     VALUES
           ('Conductor')
GO

USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_seg_tipoUsuario]
           ([descripcion])
     VALUES
           ('Pasajero')
GO
USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_seg_tipoUsuario]
           ([descripcion])
     VALUES
           ('Administrador')
GO
USE [micruberDB]
GO

INSERT INTO [dbo].[tbl_seg_tipoUsuario]
           ([descripcion])
     VALUES
           ('Saldo')
GO

ALTER TABLE tbl_seg_usuario ADD tipoUsuario int;

ALTER TABLE tbl_seg_tipoUsuario
ADD CONSTRAINT FK_seg_usuario_tipo
FOREIGN KEY (tipoUsuario) REFERENCES tbl_seg_usuario(tipoUsuario);




ALTER TABLE tbl_pagos_pagos ADD usuarioRecarga int;

ALTER TABLE tbl_seg_usuario
ADD CONSTRAINT FK_seg_usuario_pago
FOREIGN KEY (usuarioId) REFERENCES tbl_pagos_pagos(usuarioRecarga);

USE [micruberDB]
GO

UPDATE [dbo].[tbl_seg_usuario]
   SET 
      [tipoUsuario] = 4
 WHERE usuarioId = 1
GO