USE DB_PSYCO
GO

PRINT 'INSERT ESTUDIOS'
GO

DECLARE @estudios AS type_estudios_psicologo
INSERT INTO @estudios (Id,IdPsicologo,GradoAcademico,Institucion,Carrera) VALUES (1,0,1,1,1);


EXEC [dbo].[sp_agregar_psicologo] 'CAROLINA','MONGE PARRA','1991-09-10','1','72381584','987721924','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'CINTHIA ISABEL','MALDONADO MENDOZA','1995-05-28','1','75335536','932594459','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'FRANCO DIEGO','SANDROMAN FLORES','1992-09-30','1','70443183','969996199','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'BLANCA GLORIA','SIHUAY MARAVI','1990-01-01','1','44608581','955324398','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'AISSA CELESTE','MONTEALEGRE ECHAIZ','1995-10-20','1','76663179','956326338','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'ARIANA','QUILCHE','1995-02-20','1','72621877','977651294','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'LAURA ISABEL','NUÑEZ ALCARRAZ','1988-01-17','1','44788398','992058907','13:00','08:00','17:00',1,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'JOANA GRINN','PINEDA RAMOS','1986-08-23','1','44812548','990401003','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'EMMA','OSORIO OSORIO','1980-08-17','1','72389767','957333444','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'VIRGINIA','CALLE GONZALES','1984-04-06','1','42438950','989167032','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'ROBERT','QUILLA DE LA CRUZ','1988-05-13','1','45681397','999222222','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'MILUSKA','SANTOS LIMAYLLA','1993-05-07','1','48075756','953750667','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'CECILIA MABEL','JUSCAMAITA ARTEAGA','1989-11-26','1','46054838','999999999','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'LISSETE ELIZABETH','BARRIONUEVO CANDIA','1992-09-26','1','479409449','954750252','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
EXEC [dbo].[sp_agregar_psicologo] 'GINA','ROJAS','1957-08-25','1','21810680','941087800','13:00','08:00','17:00',2,-1,1,'--','150140','1',@estudios;
GO

UPDATE tbl_usuario SET email=CONCAT(num_documento,'@gmail.com'), id_sede=1 WHERE email='' AND id_sede IS NULL;
GO

UPDATE tbl_usuario SET id_tipousuario=1 WHERE num_documento='21810680';
GO

DELETE FROM tbl_psicologo WHERE DocumentoNumero='21810680';
GO