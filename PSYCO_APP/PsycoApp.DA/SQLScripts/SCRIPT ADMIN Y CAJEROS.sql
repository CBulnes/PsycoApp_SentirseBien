USE DB_PSYCO
GO

DECLARE @estudios AS type_estudios_psicologo
INSERT INTO @estudios (Id,IdPsicologo,GradoAcademico,Institucion,Carrera) VALUES (1,0,1,1,1);


EXEC [dbo].[sp_agregar_psicologo] 'ESPOSO','DRA GINA','1950-01-01','1','00000000','999999999','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXEC [dbo].[sp_agregar_psicologo] 'MARIA JOSE','LANGUASCO RODRIGUEZ','1997-07-13','1','70806582','933747334','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'LUIS','REYES MARTINEZ','1995-02-21','1','72881690','943093366','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'JOSE','ESTEBAN CIEZA','1996-05-03','1','75343797','985414694','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'ANDREA','CORRALES ROJAS','1995-12-20','1','76536973','972294222','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
GO

UPDATE tbl_usuario SET email=CONCAT(num_documento,'@gmail.com'), id_sede=1 WHERE num_documento in ('00000000'); --La molina
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE tbl_usuario SET email='MLANGUASCO', id_sede=1 WHERE num_documento in ('70806582'); --La molina
UPDATE tbl_usuario SET email='LREYES', id_sede=1 WHERE num_documento in ('72881690'); --La molina
UPDATE tbl_usuario SET email='JESTEBAN', id_sede=2 WHERE num_documento in ('75343797'); --Surco
UPDATE tbl_usuario SET email='ACORRALES', id_sede=2 WHERE num_documento in ('76536973'); --Surco
GO

UPDATE tbl_usuario SET id_tipousuario=1 WHERE num_documento in ('00000000');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE tbl_usuario SET id_tipousuario=3 WHERE num_documento in ('70806582','72881690','75343797','76536973');
GO

DELETE FROM tbl_psicologo WHERE DocumentoNumero in ('00000000');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM tbl_psicologo WHERE DocumentoNumero in ('70806582','72881690','75343797','76536973');
GO