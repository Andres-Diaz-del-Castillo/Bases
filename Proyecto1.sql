DROP SEQUENCE seq_visita;
DROP SEQUENCE seq_mascota;
DROP SEQUENCE seq_especie;
DROP SEQUENCE seq_especialidad;

DROP TABLE Notas;
DROP TABLE MascotaXVisita;
DROP TABLE Visita;
DROP TABLE Veterinario;
DROP TABLE Mascota;
DROP TABLE Especie;
DROP TABLE Especialidad;
DROP TABLE Dueno;

CREATE TABLE Dueno (
  tipo_doc varchar2(2),
  num_doc varchar2(20),
  nombres varchar2(20) NOT NULL,
  apellidos varchar2(20) NOT NULL,
  telefono varchar2(20) NOT NULL,
  ciudad varchar2(20) NOT NULL,
  direccion varchar2(50) NOT NULL,
  correo varchar2(20) NOT NULL, 
  PRIMARY KEY (tipo_doc, num_doc),
  CHECK (tipo_doc IN ('CC', 'CE')),
  CHECK (REGEXP_LIKE(correo, '^([a-z]|[0-9])+@+[^0-9]'))
);

CREATE TABLE Especialidad (
  id_especialidad varchar2(20),
  descripcion varchar2(60) NOT NULL,
  factor_costo number(3,2) DEFAULT 1.00 NOT NULL,
  PRIMARY KEY (id_especialidad),
  CHECK (factor_costo BETWEEN 1.00 AND 2.00)
);

CREATE TABLE Especie (
  id_especie varchar2(20),
  Descripcion varchar2(60) NOT NULL,
  PRIMARY KEY (id_especie)
);

CREATE TABLE Mascota (
  id_mascota varchar2(20),
  Nombre varchar2(20) NOT NULL,
  Fecha_nacimiento Date NOT NULL,
  id_especie varchar2(20) REFERENCES Especie1,
  tipo_doc_dueno varchar2(2),
  num_doc_dueno varchar2(20),
  PRIMARY KEY (id_mascota),
  FOREIGN KEY (tipo_doc_dueno, num_doc_dueno) REFERENCES Dueno1
);

CREATE TABLE Veterinario (
  tipo_doc varchar2(2),
  num_doc varchar2(20),
  numero_tarjeta_profesional varchar2(20) NOT NULL,
  nombres varchar2(20) NOT NULL,
  apellidos varchar2(20) NOT NULL,
  id_especialidad varchar2(60) REFERENCES Especialidad1,--
  PRIMARY KEY (tipo_doc, num_doc)
);

CREATE TABLE Visita (
  id_visita varchar2(20),
  tipo varchar2(20) NOT NULL,
  fecha_ingreso Date NOT NULL,
  fecha_egreso Date,
  motivo_visita varchar2(60) NOT NULL,
  tipo_doc varchar2(2),
  id_veterinario varchar2(20),
  costo numeric,
  id_mascota varchar2(20),
  PRIMARY KEY (id_visita),
  FOREIGN KEY (tipo_doc, id_veterinario) REFERENCES Veterinario1,--
  FOREIGN KEY(id_mascota) REFERENCES Mascota1 ,--
  CHECK (tipo IN ('HOSPITALIZACION', 'CONSULTA'))
);

CREATE TABLE MascotaXVisita(
	id_mascota varchar2(20) REFERENCES Mascota1,-- 
	id_visita varchar2(20) REFERENCES Visita1 --
);

CREATE TABLE Notas (
  id_visita varchar2(20) REFERENCES Visita ON DELETE CASCADE,
  fecha_nota timestamp NOT NULL,
  nota varchar2(60) NOT NULL,
  PRIMARY KEY (id_visita, fecha_nota)
);

CREATE SEQUENCE seq_especialidad 
	START WITH 1
	INCREMENT BY 1
	NOMAXVALUE
	MINVALUE 1
	CACHE 10
	NOCYCLE
	NOORDER;

CREATE SEQUENCE seq_especie 
	START WITH 1
	INCREMENT BY 1
	NOMAXVALUE
	MINVALUE 1
	CACHE 10
	NOCYCLE
	NOORDER;

CREATE SEQUENCE seq_mascota 
	START WITH 1
	INCREMENT BY 1
	NOMAXVALUE
	MINVALUE 1
	CACHE 10
	NOCYCLE
	NOORDER;

CREATE SEQUENCE seq_visita 
	START WITH 1
	INCREMENT BY 1
	NOMAXVALUE
	MINVALUE 1
	CACHE 10
	NOCYCLE
	NOORDER;
    

--Datos 1:

INSERT INTO Especie VALUES(TO_CHAR(seq_especie.NEXTVAL),'Especial para gente alergica');
INSERT INTO Dueno VALUES('CC','1072714557','Andres','Diaz del Castillo','3163990344','Bogota','Call353#12-45','andres09@gmail.com');
INSERT INTO Mascota VALUES(TO_CHAR(seq_mascota.NEXTVAL),'Firulais',to_date('1984/02/01', 'YYYY/MM/DD'),TO_CHAR(seq_especie.CURRVAL),'CC','1072714557');
INSERT INTO Especialidad VALUES(TO_CHAR(seq_especialidad.NEXTVAL),'Especilidad en problemas cardiacos',1);
INSERT INTO Veterinario VALUES('CC','129023445','11221133','Alfredo','Gutierrez', TO_CHAR(seq_especialidad.CURRVAL));

--visita1
INSERT INTO Visita VALUES(TO_CHAR(seq_visita.NEXTVAL),'HOSPITALIZACION',to_date('2019/02/01', 'YYYY/MM/DD'),NULL,'Motivo de prueba','CC','129023445',140000,TO_CHAR(seq_mascota.CURRVAL));
INSERT INTO Notas VALUES(TO_CHAR(seq_visita.CURRVAL),to_timestamp('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),'Prguntas prueba');
INSERT INTO MascotaXVisita VALUES(TO_CHAR(seq_mascota.CURRVAL),TO_CHAR(seq_visita.CURRVAL));

--visita2
INSERT INTO Visita VALUES(TO_CHAR(seq_visita.NEXTVAL),'CONSULTA',to_date('2019/08/12', 'YYYY/MM/DD'),to_date('2019/01/21', 'YYYY/MM/DD'),'Infeccion','CC','129023445',200000,TO_CHAR(seq_mascota.CURRVAL));
INSERT INTO MascotaXVisita VALUES(TO_CHAR(seq_mascota.CURRVAL),TO_CHAR(seq_visita.CURRVAL));
INSERT INTO Notas VALUES(TO_CHAR(seq_visita.CURRVAL),to_timestamp('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),'Infecci�n curada');

--Datos 2:
INSERT INTO Especie VALUES(TO_CHAR(seq_especie.NEXTVAL),'Raza ideal para ni�os');
INSERT INTO DUENO VALUES('CC','1020827074','Mateo','Galvis Lopez',3168729449,'Bogota','Calle127#5C-46','mgalvis@hotmai.com');
INSERT INTO MASCOTA VALUES(TO_CHAR(seq_mascota.NEXTVAL),'CODY',TO_DATE('2012/04/26', 'YYYY/MM/DD'),TO_CHAR(seq_especie.CURRVAL),'CC','1020827074');
INSERT INTO ESPECIALIDAD VALUES(TO_CHAR(seq_especialidad.NEXTVAL),'Especilidad en problemas digestivos',2);
INSERT INTO Veterinario VALUES('CC','192031743','11221133','Guillermo','Martinez', TO_CHAR(seq_especialidad.CURRVAL));

--visita1
INSERT INTO Visita VALUES(TO_CHAR(seq_visita.NEXTVAL),'CONSULTA',to_date('2019/08/23', 'YYYY/MM/DD'),NULL,'Control General','CC','192031743',140000,TO_CHAR(seq_mascota.CURRVAL));
INSERT INTO Notas VALUES(TO_CHAR(seq_visita.CURRVAL),to_timestamp('19-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),'Correcto estado de salud');
INSERT INTO Notas VALUES(TO_CHAR(seq_visita.CURRVAL),to_timestamp('02-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),'Correcto estado de salud');
INSERT INTO MascotaXVisita1 VALUES(TO_CHAR(seq_mascota.CURRVAL),TO_CHAR(seq_visita.CURRVAL));

--Datos3:
INSERT INTO Especie VALUES(TO_CHAR(seq_especie.NEXTVAL),'Raza ideal para ni�os');
INSERT INTO DUENO VALUES('CC','1019038131','Sara','Siginolfi','3005468963','Bogota','Carrera 9 # 12-08','sigi@homtail.com');
INSERT INTO MASCOTA VALUES(TO_CHAR(seq_mascota.NEXTVAL),'Sasha',TO_DATE('2008/03/13', 'YYYY/MM/DD'),TO_CHAR(seq_especie.CURRVAL),'CC','1019038131');
INSERT INTO ESPECIALIDAD VALUES(TO_CHAR(seq_especialidad.NEXTVAL),'Especilidad en probelmas musculares',1.8);

--visita1
INSERT INTO Veterinario VALUES('CC','156041213','10921123','Dario','Duarte', TO_CHAR(seq_especialidad.CURRVAL));
INSERT INTO Visita VALUES(TO_CHAR(seq_visita.NEXTVAL),'CONSULTA',to_date('2019/09/2', 'YYYY/MM/DD'),NULL,'Visita de Urgencia ','CC','156041213',140000,TO_CHAR(seq_mascota.CURRVAL));

--Veterinario Sin Visitas
INSERT INTO Veterinario VALUES('CE','156041214','10921123','Dario','Duarte', TO_CHAR(seq_especialidad.CURRVAL));

COMMIT;

--Consulta 1
SELECT M.Nombre, D.nombres, D.apellidos, Vi.fecha_ingreso, Vi.motivo_visita, Ve.nombres, Ve.apellidos
FROM ((Mascota M INNER JOIN Dueno D ON M.tipo_doc_dueno = D.tipo_doc AND M.num_doc_dueno = D.num_doc) INNER JOIN MascotaXVisita MxV ON M.id_mascota = MxV.id_mascota) 
INNER JOIN (Visita Vi INNER JOIN Veterinario Ve ON Ve.tipo_doc = Vi.tipo_doc AND Ve.num_doc = Vi.id_veterinario) 
ON MxV.id_visita = Vi.id_visita
WHERE Vi.fecha_egreso IS NULL;

--Consulta 2
WITH VisitaExiste(TipoDoc, NumDoc, NumTarProf, Nombres, Apellidos, IdEspecialidad, IdVisita, TipoVisita, FechaIngreso, FechaEgreso, MotivoVisita, TipoDocVi, IdVeterinario, Costo, IdMascota) AS
    (SELECT DISTINCT tipo_doc, num_doc, numero_tarjeta_profesional, nombres, apellidos, id_especialidad, id_visita, tipo, fecha_ingreso, fecha_egreso, motivo_visita, tipo_doc, id_veterinario, costo, id_mascota
    FROM Veterinario NATURAL LEFT OUTER JOIN Visita)
SELECT TipoDoc, NumDoc, NumTarProf, Nombres, Apellidos, IdEspecialidad, NVL(TipoVisita, 'Ninguna') AS TipoVisita, COUNT(DISTINCT IdVisita) AS NumeroDeVisitas
FROM VisitaExiste Ve
WHERE (Ve.TipoDoc = Ve.TipoDocVi AND Ve.NumDoc = Ve.IdVeterinario) OR (Ve.TipoDoc = Ve.TipoDocVi AND Ve.IdVisita IS NULL)
GROUP BY TipoDoc, NumDoc, NumTarProf, Nombres, Apellidos, IdEspecialidad, TipoVisita
ORDER BY COUNT(DISTINCT Ve.TipoVisita) DESC;

--Consulta 3 
SELECT EXTRACT (YEAR FROM fecha_ingreso) AS Anio, EXTRACT (MONTH FROM fecha_ingreso)AS Mes, tipo AS TipoVisita, COUNT(EXTRACT (MONTH FROM fecha_ingreso)) AS Cantidad_De_Visitas_Mes
FROM VISITA
GROUP BY tipo, EXTRACT (YEAR FROM fecha_ingreso), EXTRACT (MONTH FROM fecha_ingreso)
ORDER BY EXTRACT (YEAR FROM fecha_ingreso), EXTRACT (MONTH FROM fecha_ingreso);

--Consulta 4
SELECT SUM(COSTO) AS SUMA_COSTOS
FROM VISITA
WHERE EXTRACT(MONTH FROM FECHA_INGRESO) = TO_CHAR(SYSDATE, 'MM')
AND EXTRACT(YEAR FROM FECHA_INGRESO) = TO_CHAR(SYSDATE, 'YYYY');


--Consulta 5
--a.        
UPDATE Visita
SET costo = 50000*(SELECT factor_costo
                   FROM (SELECT Vi.id_visita, Vi.tipo, Vi.fecha_ingreso, Vi.fecha_egreso, Vi.motivo_visita, Vi.costo, Ve.tipo_doc, Ve.num_doc, Ve.numero_tarjeta_profesional, Ve.nombres, Ve.apellidos, E.id_especialidad, E.descripcion, E.factor_costo
                         FROM ((Especialidad E INNER JOIN Veterinario Ve ON E.id_especialidad = Ve.id_especialidad)
                         INNER JOIN Visita Vi ON Ve.tipo_doc = Vi.tipo_doc AND Ve.num_doc = Vi.id_veterinario))
                   WHERE costo = '0')
WHERE tipo = 'CONSULTA';

--b.
UPDATE Visita
SET costo = (100000*(SELECT factor_costo 
                     FROM (SELECT Vi.id_visita, Vi.tipo, Vi.fecha_ingreso, Vi.fecha_egreso, Vi.motivo_visita, Vi.costo, Ve.tipo_doc, Ve.num_doc, Ve.numero_tarjeta_profesional, Ve.nombres, Ve.apellidos, E.id_especialidad, E.descripcion, E.factor_costo
                           FROM ((Especialidad E INNER JOIN Veterinario Ve ON E.id_especialidad = Ve.id_especialidad)
                           INNER JOIN Visita Vi ON Ve.tipo_doc = Vi.tipo_doc AND Ve.num_doc = Vi.id_veterinario))
                     WHERE costo = '0')) * (SELECT fecha_egreso - fecha_ingreso
                                                        FROM Visita V1
                                                        WHERE V1.costo = '0')
WHERE tipo = 'HOSPITALIZACION';

--Consulta 6
/*INSERT INTO Notas(id_visita, fecha_nota, nota)
SELECT VIS.id_visita,VIS.fecha_egreso,'NOTA AUTOMATICA: FECHA DE SALIDA DEL PACIENTE '  + cast(trunc(sysdate) as varchar(50))
FROM Visita VIS
WHERE EXTRACT (MONTH FROM VIS.fecha_egreso) = TO_CHAR(SYSDATE, 'MM') 
AND EXTRACT (DAY FROM VIS.fecha_egreso) = TO_CHAR(SYSDATE, 'DD')
AND EXTRACT (YEAR FROM VIS.fecha_egreso) = TO_CHAR(SYSDATE, 'YYYY');*/

--Consulta 7
--VISTA INICIAL
WITH VISTA_VISITAS_CONSULTA
AS
(SELECT *
FROM VISITA V1
WHERE  V1.tipo = 'CONSULTA')

--SELECT * FROM VISTA_VISITAS_CONSULTA;

--DATOS DUEÑO
SELECT 
  D1.tipo_doc AS TIPO_DOCUMENTO,
  D1.num_doc AS NUMERO_DOCUMENTO,
  D1.nombres  AS NOMBRE_DUENO,
  D1.apellidos AS APELIIDOS_DUENO,
  D1.telefono AS TELEFONO_DUENO,
  D1.ciudad AS CIUDAD_DUENO,
  D1.direccion AS DIRECCION,
--DATOS MASCOTA
  M1.id_mascota AS ID_MASCOTA,
  M1.Nombre AS NOMBRE_MASCOTA,
  M1.Fecha_nacimiento AS FECHA_NACIMIENTO_MASCOTA,
  M1.id_especie AS ESPECIE_MASCOTA,
  V1.fecha_egreso,
  V1.tipo
FROM DUENO D1 INNER JOIN MASCOTA M1 ON D1.tipo_doc = M1.tipo_doc_dueno AND D1. num_doc = M1.num_doc_dueno 
INNER JOIN  VISITA V1 ON M1.id_mascota =  V1.id_mascota  INNER JOIN VISTA_VISITAS_CONSULTA V2 ON V1.id_mascota = V2.id_mascota

MINUS

SELECT 
  D1.tipo_doc AS TIPO_DOCUMENTO,
  D1.num_doc AS NUMERO_DOCUMENTO,
  D1.nombres  AS NOMBRE_DUENO,
  D1.apellidos AS APELIIDOS_DUENO,
  D1.telefono AS TELEFONO_DUENO,
  D1.ciudad AS CIUDAD_DUENO,
  D1.direccion AS DIRECCION,
--DATOS MASCOTA
  M1.id_mascota AS ID_MASCOTA,
  M1.Nombre AS NOMBRE_MASCOTA,
  M1.Fecha_nacimiento AS FECHA_NACIMIENTO_MASCOTA,
  M1.id_especie AS ESPECIE_MASCOTA,
  V1.fecha_egreso,
  V1.tipo
FROM DUENO D1 INNER JOIN MASCOTA M1 ON D1.tipo_doc = M1.tipo_doc_dueno AND D1. num_doc = M1.num_doc_dueno 
INNER JOIN  VISITA V1 ON M1.id_mascota =  V1.id_mascota  INNER JOIN VISTA_VISITAS_CONSULTA V2 ON V1.id_mascota = V2.id_mascota
WHERE V1.tipo = 'HOSPITALIZACION' AND EXTRACT(DAY FROM V1.fecha_egreso) - EXTRACT(DAY FROM V2.fecha_ingreso) > 7;

--Consulta 8
SELECT A.NOMBRES AS Nombres_Dueno, A.APELLIDOS AS Apellidos_Dueno, A.CORREO AS Correo, B.NOMBRE AS Nombre_Mascota, C.NOTA AS Resumen
FROM (((DUENO A INNER JOIN MASCOTA B ON A.NUM_DOC = B.NUM_DOC_DUENO AND A.TIPO_DOC = B.TIPO_DOC_DUENO)
INNER JOIN MASCOTAXVISITA V ON V.ID_MASCOTA = B.ID_MASCOTA) 
INNER JOIN NOTAS C ON C.ID_VISITA = V.ID_MASCOTA
AND EXTRACT(MONTH FROM C.FECHA_NOTA) = TO_CHAR(SYSDATE, 'MM')
AND EXTRACT(DAY FROM C.FECHA_NOTA) = TO_CHAR(SYSDATE, 'DD')
AND EXTRACT(YEAR FROM C.FECHA_NOTA) = TO_CHAR(SYSDATE, 'YY'));

ROLLBACK;
