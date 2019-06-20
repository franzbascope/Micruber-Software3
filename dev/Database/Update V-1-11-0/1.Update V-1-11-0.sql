USE [micruberDB]
GO

CREATE TABLE tbl_seg_tipoUsuario (
    tipoUsuario int IDENTITY(1,1) PRIMARY KEY ,
    descripcion varchar(50)
);


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


INSERT INTO [dbo].[tbl_seg_tipoUsuario]
           ([descripcion])
     VALUES
           ('Saldo')
GO

ALTER TABLE tbl_seg_usuario ADD tipoUsuario int;

ALTER TABLE tbl_seg_usuario
ADD FOREIGN KEY (tipoUsuario) REFERENCES tbl_seg_tipoUsuario(tipoUsuario);

ALTER TABLE tbl_pagos_pagos ADD usuarioRecarga int;

ALTER TABLE tbl_pagos_pagos
ADD CONSTRAINT FK_seg_usuario_pago
FOREIGN KEY (usuarioRecarga) REFERENCES tbl_seg_usuario(usuarioId);

USE [micruberDB]
GO

UPDATE [dbo].[tbl_seg_usuario]
   SET 
      [tipoUsuario] = 4
 WHERE usuarioId = 1
GO