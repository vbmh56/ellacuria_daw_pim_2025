/*SCRIPT PARA RELLENAR LA BASE DE DATOS*/
USE `bd_aulas`;


/* 1 - RELLENA LA TABLA MAESTRA QUE CONTIENE LAS IMAGENES DE LOS AVATARES*/
INSERT INTO `tm_avatar` VALUES (1,'../images/Avatar/Female1.svg',1),
							   (2,'../images/Avatar/Female2.svg',1),
                               (3,'../images/Avatar/Female3.svg',1),
                               (4,'../images/Avatar/Female4.svg',1),
                               (5,'../images/Avatar/Female5.svg',1),
                               (6,'../images/Avatar/Male1.svg',1),
                               (7,'../images/Avatar/Male2.svg',1),
                               (8,'../images/Avatar/Male3.svg',1),
                               (9,'../images/Avatar/Male4.svg',1),
                               (10,'../images/Avatar/Male5.svg',1);


/* 2 - RELLENA EL PRIMER USUARIO DEL SISTEMA QUE ES EL ADMINISTRADOR*/
INSERT INTO dt_usuarios (DS_NOMBRE, DS_APELLIDO1, DS_APELLIDO2, DS_LOGIN, DS_CLAVE, FE_FECHA_CLAVE, ID_DT_AVATAR, B_ACTIVO, B_HABILITADO)
	 VALUES ("Administrador","Apellido1","Apellido2","admin","1234", now(),1,1,1);
     
/* 3 - RELLENA LA TABLA CON LOS DATOS DE CONTACTO*/
INSERT INTO `dt_datos_contacto` VALUES (1,'ADMIN@IGNACIO_ELLACURIA.ES','(+34)123456789','AdminInstagram','AdminFacebook',1);

/* 4 - RELLENA LA TABLA DE RELACION*/
INSERT INTO `re_usuarios_datos_contacto` VALUES (1,1);

/* 5 -RELLENA LA TABLA DE AULAS CON 2 AULAS DE EJEMPLO*/
INSERT INTO `dt_aulas` VALUES (1,'Aula 1',300,'En la planta baja a la izquierda',1),(2,'Aula 2',150,'En la planta baja a la derecha',1);

/* 6 - INSERTA OTRO USUARIO PARA QUE HAYA MAS DE UNO PARA LAS PRUEBAS */
INSERT INTO dt_usuarios (DS_NOMBRE, DS_APELLIDO1, DS_APELLIDO2, DS_LOGIN, DS_CLAVE, FE_FECHA_CLAVE, ID_DT_AVATAR, B_ACTIVO, B_HABILITADO)
	 VALUES ("Demostracion","usuario","demostracion","demo","1234", now(),2,1,1);

INSERT INTO `dt_datos_contacto` VALUES (2,'DEMO@IGNACIO_ELLACURIA.ES','(+34)123456789','DemoInstagram','DemoFacebook',1);

INSERT INTO `re_usuarios_datos_contacto` VALUES (2,2);