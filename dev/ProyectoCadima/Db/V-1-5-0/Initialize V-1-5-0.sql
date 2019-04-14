USE [bdTienda]
GO

INSERT INTO tblTipoMaestro 
VALUES (1, 'Tipo Empresas'), (2, 'Tipo Productos');

INSERT INTO tblTipoHijos 
VALUES (1, 1, 'Farmacia', 0, 1), (2, 1, 'Supermercado', 0, 1), (3, 1, 'Ferreteria', 0, 1), (4, 1, 'Libreria', 0, 1), 
(5, 2, 'Medicamento', 0, 1), (6, 2, 'Herramienta', 0, 1), (7, 2,'Bebida', 0, 1), (8, 2,'Alimento', 0, 1),
(9, 2,'Utencilio', 0, 1), (10, 2,'Material Escolar', 0, 1), (11, 2,'Vestimenta', 0, 1), (12, 2,'Otro', 0, 1);