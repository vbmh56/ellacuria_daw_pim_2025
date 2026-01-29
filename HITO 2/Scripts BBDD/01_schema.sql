CREATE DATABASE  IF NOT EXISTS `bd_aulas` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_aulas`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: Localhost    Database: bd_aulas
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dt_aulas`
--

DROP TABLE IF EXISTS `dt_aulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_aulas` (
  `ID_DT_AULA` int NOT NULL AUTO_INCREMENT,
  `DS_AULA` varchar(100) NOT NULL,
  `I_CAPACIDAD` int NOT NULL,
  `DS_UBICACION` varchar(250) NOT NULL,
  `B_ACTIVA` tinyint NOT NULL,
  PRIMARY KEY (`ID_DT_AULA`),
  UNIQUE KEY `id_aula_UNIQUE` (`ID_DT_AULA`),
  UNIQUE KEY `DS_AULA_UNIQUE` (`DS_AULA`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `dt_datos_contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_datos_contacto` (
  `ID_DT_DATO_CONTACTO` int NOT NULL AUTO_INCREMENT,
  `DS_EMAIL` varchar(150) NOT NULL,
  `DS_TELEFONO` varchar(45) DEFAULT NULL,
  `DS_INSTAGRAM` varchar(45) DEFAULT NULL,
  `DS_FACEBOOK` varchar(45) DEFAULT NULL,
  `B_ACTIVO` tinyint NOT NULL,
  PRIMARY KEY (`ID_DT_DATO_CONTACTO`),
  UNIQUE KEY `DS_EMAIL_UNIQUE` (`DS_EMAIL`),
  UNIQUE KEY `ID_DT_DATO_CONTACTO_UNIQUE` (`ID_DT_DATO_CONTACTO`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `dt_reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_reservas` (
  `ID_DT_RESERVA` int NOT NULL AUTO_INCREMENT,
  `DS_RESERVA` varchar(150) NOT NULL,
  `FE_COMIENZO` datetime NOT NULL,
  `FE_FIN` datetime NOT NULL,
  `ID_DT_USUARIO` int NOT NULL,
  `ID_DT_AULA` int NOT NULL,
  `B_ACTIVA` tinyint NOT NULL,
  PRIMARY KEY (`ID_DT_RESERVA`),
  UNIQUE KEY `Id_reserva_UNIQUE` (`ID_DT_RESERVA`),
  KEY `fk_dtreservas_dtusuarios_idx` (`ID_DT_USUARIO`),
  KEY `fk_dtreservas_dtaulas_idx` (`ID_DT_AULA`),
  CONSTRAINT `fk_dtreservas_dtaulas` FOREIGN KEY (`ID_DT_AULA`) REFERENCES `dt_aulas` (`ID_DT_AULA`),
  CONSTRAINT `fk_dtreservas_dtusuarios` FOREIGN KEY (`ID_DT_USUARIO`) REFERENCES `dt_usuarios` (`ID_DT_USUARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `dt_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_usuarios` (
  `ID_DT_USUARIO` int NOT NULL AUTO_INCREMENT,
  `DS_NOMBRE` varchar(150) NOT NULL,
  `DS_APELLIDO1` varchar(150) NOT NULL,
  `DS_APELLIDO2` varchar(150) DEFAULT NULL,
  `DS_LOGIN` varchar(50) NOT NULL,
  `DS_CLAVE` varchar(45) NOT NULL,
  `FE_FECHA_CLAVE` date NOT NULL,
  `ID_DT_AVATAR` int NOT NULL,
  `B_ACTIVO` tinyint NOT NULL,
  `B_HABILITADO` tinyint NOT NULL,
  PRIMARY KEY (`ID_DT_USUARIO`),
  UNIQUE KEY `DS_LOGIN_UNIQUE` (`DS_LOGIN`),
  UNIQUE KEY `ID_DT_USUARIO_UNIQUE` (`ID_DT_USUARIO`),
  KEY `fk_dtusuarios_dtavatar_idx` (`ID_DT_AVATAR`),
  CONSTRAINT `fk_dtusuarios_dtavatar` FOREIGN KEY (`ID_DT_AVATAR`) REFERENCES `tm_avatar` (`ID_DT_AVATAR`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `re_usuarios_datos_contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `re_usuarios_datos_contacto` (
  `ID_DT_USUARIO` int NOT NULL,
  `ID_DT_DATO_CONTACTO` int NOT NULL,
  PRIMARY KEY (`ID_DT_USUARIO`,`ID_DT_DATO_CONTACTO`),
  KEY `FK_dtdatoscontacto_reusuariosdatoscontacto_idx` (`ID_DT_DATO_CONTACTO`),
  CONSTRAINT `FK_dtdatoscontacto_reusuariosdatoscontacto` FOREIGN KEY (`ID_DT_DATO_CONTACTO`) REFERENCES `dt_datos_contacto` (`ID_DT_DATO_CONTACTO`),
  CONSTRAINT `FK_dtusuarios_reusuariosdatoscontacto` FOREIGN KEY (`ID_DT_USUARIO`) REFERENCES `dt_usuarios` (`ID_DT_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `tm_avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_avatar` (
  `ID_DT_AVATAR` int NOT NULL AUTO_INCREMENT,
  `DS_RUTA_IMAGEN_AVATAR` varchar(255) NOT NULL,
  `B_ACTIVO` tinyint NOT NULL,
  PRIMARY KEY (`ID_DT_AVATAR`),
  UNIQUE KEY `Id_avatar_UNIQUE` (`ID_DT_AVATAR`),
  UNIQUE KEY `DS_RUTA_IMAGEN_AVATAR_UNIQUE` (`DS_RUTA_IMAGEN_AVATAR`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

/* PROCEDIMIENTOS ALMACENADOS */


/*!50003 DROP PROCEDURE IF EXISTS `DELETE_AULA_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETE_AULA_BY_ID`(IN P_ID_DT_AULA INT)
BEGIN

	DECLARE B_HAYRESERVA INT DEFAULT 0;
    DECLARE I_AULA INT DEFAULT 0;
    DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;

	SELECT ID_DT_AULA INTO I_AULA 
      FROM DT_AULAS 
	 WHERE ID_DT_AULA = P_ID_DT_AULA
       AND B_ACTIVA = 1;
       
    IF (I_AULA != 0) THEN
    
		SELECT COUNT(ID_DT_RESERVA) INTO B_HAYRESERVA
		  FROM DT_RESERVAS
		 WHERE ID_DT_AULA = P_ID_DT_AULA
		   AND B_ACTIVA = TRUE
		   AND FE_FIN > NOW();
           
		IF (B_HAYRESERVA = 0) THEN

			UPDATE DT_AULAS
			   SET B_ACTIVA = 0,
				   DS_AULA = UUID()	/*COMO ESTE VALOR ES UNICO EN LA TABLA, LO ACTUALIZO POR UN UUID PARA */ 
									/*PERMITIR QUE EN EL FUTURO SE PUEDA DAR DE ALTA OTRA AULA CON EL MISMO NOMBRE */
			 WHERE ID_DT_AULA = P_ID_DT_AULA;
			 
			SET B_RESULTADO = TRUE;
			SELECT B_RESULTADO AS resultado, 'Aula eliminada correctamente.' AS mensaje;
		
		ELSE
		
			 SELECT B_RESULTADO AS resultado, 'El aula tiene reservas activas.' AS mensaje;
		
		END IF;
           
	ELSE
		SELECT B_RESULTADO AS resultado, 'El aula no existe.' AS mensaje;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_RESERVE_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETE_RESERVE_BY_ID`(IN P_ID_DT_RESERVA INT)
BEGIN
    /* DECLARACION DE VARIABLES*/
	DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
    
    /*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
	START TRANSACTION;
		
		UPDATE DT_RESERVAS
		   SET B_ACTIVA = FALSE
		 WHERE ID_DT_RESERVA = P_ID_DT_RESERVA;
         
	COMMIT; /*CONFIRMA LA TRANSACCION*/
    
	SET B_RESULTADO = TRUE;
    
    SELECT B_RESULTADO AS resultado, 'Reserva eliminada correctamente.' AS mensaje;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_USUARIO_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETE_USUARIO_BY_ID`(IN P_ID_DT_USUARIO INT)
BEGIN
    /* DECLARACION DE VARIABLES*/
	DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
    
    /*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
	START TRANSACTION;
	
    /* BORRA EL USUARIO */
    UPDATE DT_USUARIOS
	   SET B_ACTIVO = FALSE,
		   DS_LOGIN = UUID()	/*COMO ESTE VALOR ES UNICO EN LA TABLA, LO ACTUALIZO POR UN UUID PARA */ 
								/*PERMITIR QUE EN EL FUTURO SE PUEDA DAR DE ALTA OTRO USARUIO CON EL MISMO LOGIN */
	 WHERE ID_DT_USUARIO = P_ID_DT_USUARIO;
     
	/* BORRA LOS DATOS DE CONCTACTO */
    UPDATE DT_DATOS_CONTACTO
	   SET B_ACTIVO = FALSE,
		   DS_EMAIL = UUID()	/* MISMO CASO QUE CON EL NOMBRE DE USUARIO */
	 WHERE ID_DT_DATO_CONTACTO IN (SELECT ID_DT_DATO_CONTACTO 
									 FROM RE_USUARIOS_DATOS_CONTACTO
									WHERE ID_DT_USUARIO = P_ID_DT_USUARIO);
                                    
	COMMIT; /*CONFIRMA LA TRANSACCION*/
    
	SET B_RESULTADO = TRUE;
    
    SELECT B_RESULTADO AS resultado, 'Usuario eliminado correctamente.' AS mensaje;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_AULA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_AULA`(IN P_DS_AULA VARCHAR(100),
														  IN P_I_CAPACIDAD INT, 
														  IN P_DS_UBICACION VARCHAR(250))
BEGIN

	DECLARE ID_AULA INT DEFAULT 0;
	DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
    DECLARE MESAJE VARCHAR(500) DEFAULT '';
    
	/*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
	START TRANSACTION;
    
    SELECT ID_DT_AULA INTO ID_AULA
      FROM DT_AULAS
	 WHERE DS_AULA = P_DS_AULA;
    
    IF (ID_AULA != 0) THEN
    
		SET B_RESULTADO = FALSE;
        SET MESAJE = 'Ya existe un aula con ese nombre.';
        ROLLBACK;
        
    ELSE
		INSERT INTO DT_AULAS (DS_AULA,
					  I_CAPACIDAD,
					  DS_UBICACION,
					  B_ACTIVA)
			   VALUES(P_DS_AULA,
					  P_I_CAPACIDAD,
					  P_DS_UBICACION,
					  TRUE);
							  
		SET B_RESULTADO = TRUE;
        SET MESAJE = 'Proceso realizado correctamente';		
		COMMIT;
    		
	END IF;
    
	SELECT B_RESULTADO AS resultado, MESAJE AS mensaje;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_RESERVA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_RESERVA`(IN P_ID_DT_AULA INT,
															 IN P_ID_DT_USUARIO INT,
                                                             IN P_DS_RESERVA VARCHAR(50),
															 IN P_FE_COMIENZO DATETIME,
															 IN P_FE_FIN DATETIME)
BEGIN
	DECLARE B_AULA_RESERVADA INT DEFAULT 0;
    DECLARE B_RESULTADO BOOLEAN DEFAULT TRUE;
    DECLARE VC_MENSAJE VARCHAR(250) DEFAULT '';

	/*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET B_RESULTADO = FALSE;
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
    START TRANSACTION;

	/* APARTADO PARA LAS VALIDACIONES ANTES DE INSERTAR UNA RESERVA.*/
	SELECT COUNT(ID_DT_RESERVA) INTO B_AULA_RESERVADA
      FROM DT_RESERVAS 
	 WHERE ID_DT_AULA = P_ID_DT_AULA
       AND FE_FIN >= P_FE_COMIENZO
       AND B_ACTIVA = TRUE;
       
	IF (B_AULA_RESERVADA IS NULL) THEN
		SET B_AULA_RESERVADA = 0;
	END IF;
        
	/* VALIDA QUE NO EXISTA UNA RESERVA PREVIA QUE COLISIONE CON LA QUE SE PRETENDE ISERTAR */
	IF 	(B_AULA_RESERVADA != 0) THEN
    	SET B_RESULTADO = FALSE;
		SET VC_MENSAJE =  'Ya existe una reserva para ese aula en la franja horaria indicada.' ;
    END IF;
       
	/* ASEGURA QUE LA RESERVA NO EXCEDE DEL DIA SOLICITADO*/
	IF (SELECT CAST(P_FE_COMIENZO AS DATE) != CAST(P_FE_FIN AS DATE)) THEN    
		SET B_RESULTADO = FALSE;
		SET VC_MENSAJE = 'La fecha de incio y de fin deben ser para el mismo día.';
    END IF;

	/* VALIDA QUE LA FECHA DE FIN NO SEA INFERIOR QUE LA DE INCIIO */ 
	IF (P_FE_COMIENZO > P_FE_FIN) THEN    
		SET B_RESULTADO = FALSE;
		SET VC_MENSAJE = 'La fecha de incio es mayor que la fecha de fin.';
    END IF;

	IF (B_RESULTADO = TRUE) THEN
		
		INSERT INTO DT_RESERVAS (DS_RESERVA,
								 FE_COMIENZO,
                                 FE_FIN,
                                 ID_DT_USUARIO,
                                 ID_DT_AULA,
                                 B_ACTIVA)
						 VALUES (P_DS_RESERVA,
								 P_FE_COMIENZO,
                                 P_FE_FIN,
                                 P_ID_DT_USUARIO,
                                 P_ID_DT_AULA,
                                 TRUE);
        
        SET VC_MENSAJE =  'Proceso realizado correctamente';
        
        COMMIT;
	ELSE
		ROLLBACK;
	END IF;

	SELECT B_RESULTADO AS resultado, VC_MENSAJE AS  mensaje;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_USUARIO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_USUARIO`(IN P_DS_NOMBRE VARCHAR(150),
															 IN P_DS_APELLIDO1 VARCHAR(150),
															 IN P_DS_APELLIDO2 VARCHAR(150),
															 IN P_DS_LOGIN VARCHAR(20),
															 IN P_DS_CLAVE VARCHAR(45),
															 IN P_ID_AVATAR INT,
															 IN P_DS_EMAIL VARCHAR(150),
															 IN P_DS_TELEFONO VARCHAR(45),
															 IN P_DS_INSTAGRAM VARCHAR(45),
															 IN P_DS_FACEBOOK VARCHAR(45),
															 IN P_B_HABILITADO BOOLEAN)
BEGIN

	/* DECLARACION DE VARIABLES*/
	DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
	DECLARE ID_USUARIO INT DEFAULT 0;
    DECLARE ID_DATO_CONTACTO INT DEFAULT 0;
    
    /*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
	START TRANSACTION;
	/*INSERTA EL NUEVO USUARIO*/
	INSERT INTO DT_USUARIOS (DS_NOMBRE,
							 DS_APELLIDO1,
							 DS_APELLIDO2,
							 DS_LOGIN,
							 DS_CLAVE,
							 FE_FECHA_CLAVE,
							 ID_DT_AVATAR,
							 B_ACTIVO,
							 B_HABILITADO)
					  VALUES(P_DS_NOMBRE,		
							 P_DS_APELLIDO1,
							 P_DS_APELLIDO2,
							 P_DS_LOGIN,
							 P_DS_CLAVE,
							 NOW(),
							 P_ID_AVATAR,
                             1,
                             P_B_HABILITADO);
							 
	/*OBTIENE EL ID DEL NUEVO USUARIO A PARTIR DE SU NOMBRE DE USUARIO YA QUE ES UNICO*/
	SELECT ID_DT_USUARIO INTO ID_USUARIO
	  FROM DT_USUARIOS 
	 WHERE UPPER(TRIM(DS_LOGIN)) = UPPER(TRIM(P_DS_LOGIN)); /*--> SIEMPRE SE COMPARAN CADENAS DE TEXTO CON UPPER Y TRIM PARA ASEGURAR QUE */
															/*    LAS MAYÚCULAS Y LOS ESPACIOS EN BLANCO POR LOS LATERALES NO FALSEAN RESULTADOS*/
                                                            
	/* INSERTA LOS DATOS DE CONTACTO QUE SE HAYAN PODIDO PASAR EN LOS PARAMETROS DE ENTRADA */
	INSERT INTO DT_DATOS_CONTACTO (DS_EMAIL,
								   DS_TELEFONO,
								   DS_INSTAGRAM,
								   DS_FACEBOOK,
								   B_ACTIVO)
						   VALUES (P_DS_EMAIL,
								   P_DS_TELEFONO,
								   P_DS_INSTAGRAM,
								   P_DS_FACEBOOK,
								   1);
	/* OBTIENE EL ID DEL NUEVO USUARIO A PARTIR DE SU EMAIL YA QUE ES UNICO */
    SELECT ID_DT_DATO_CONTACTO INTO ID_DATO_CONTACTO
	  FROM DT_DATOS_CONTACTO 
	 WHERE UPPER(TRIM(DS_EMAIL)) = UPPER(TRIM(P_DS_EMAIL)); /*--> SIEMPRE SE COMPARAN CADENAS DE TEXTO CON UPPER Y TRIM PARA ASEGURAR QUE */
															/*    LAS MAYÚCULAS Y LOS ESPACIOS EN BLANCO POR LOS LATERALES NO FALSEAN RESULTADOS*/
                                                            
	/* POR ÚLTIMO INSERTA EN LA TABLA DE RELACION DE DATOS DE CONTACTO CON USUARIOS */
	INSERT INTO RE_USUARIOS_DATOS_CONTACTO (ID_DT_USUARIO,
											ID_DT_DATO_CONTACTO)
									 VALUES(ID_USUARIO,
											ID_DATO_CONTACTO);
                                                
    SET B_RESULTADO = TRUE;
    
    COMMIT;
    
    SELECT B_RESULTADO AS resultado, 'Proceso realizado correctamente' AS mensaje;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_ALL_AULAS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_ALL_AULAS`()
BEGIN
	SELECT ID_DT_AULA, 
		   DS_AULA, 
           I_CAPACIDAD, 
           DS_UBICACION
	  FROM DT_AULAS
	 WHERE B_ACTIVA = TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_ALL_AVATARS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_ALL_AVATARS`()
BEGIN
	SELECT ID_DT_AVATAR,
		   DS_RUTA_IMAGEN_AVATAR
      FROM TM_AVATAR
	 WHERE B_ACTIVO = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_ALL_RESERVES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_ALL_RESERVES`()
BEGIN
	SELECT AULAS.DS_AULA,
		   USUARIOS.DS_NOMBRE,
           USUARIOS.DS_APELLIDO1,
           USUARIOS.DS_APELLIDO2,
		   RESERVAS.ID_DT_RESERVA, 
		   RESERVAS.DS_RESERVA, 
		   RESERVAS.FE_COMIENZO, 
		   RESERVAS.FE_FIN
	  FROM DT_RESERVAS RESERVAS
INNER JOIN DT_AULAS AULAS
		ON AULAS.ID_DT_AULA = RESERVAS.ID_DT_AULA
	   AND RESERVAS.B_ACTIVA = true
INNER JOIN DT_USUARIOS USUARIOS
		ON USUARIOS.ID_DT_USUARIO = RESERVAS.ID_DT_USUARIO
	 WHERE RESERVAS.FE_FIN >= NOW()
  ORDER BY FE_COMIENZO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_ALL_USUARIOS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_ALL_USUARIOS`()
BEGIN
	SELECT USUARIOS.ID_DT_USUARIO, 
		   USUARIOS.DS_NOMBRE, 
           USUARIOS.DS_APELLIDO1, 
           USUARIOS.DS_APELLIDO2, 
           USUARIOS.DS_LOGIN, 
           USUARIOS.DS_CLAVE, 
           USUARIOS.FE_FECHA_CLAVE, 
           USUARIOS.ID_DT_AVATAR,
           CONTACTO.DS_EMAIL,
           CONTACTO.DS_TELEFONO,
           CONTACTO.DS_INSTAGRAM,
           CONTACTO.DS_FACEBOOK,
           USUARIOS.B_HABILITADO
	  FROM DT_USUARIOS USUARIOS
INNER JOIN RE_USUARIOS_DATOS_CONTACTO RELACIONAL
		ON RELACIONAL.ID_DT_USUARIO = USUARIOS.ID_DT_USUARIO
	   AND USUARIOS.B_ACTIVO = TRUE
INNER JOIN DT_DATOS_CONTACTO CONTACTO
		ON CONTACTO.ID_DT_DATO_CONTACTO = RELACIONAL.ID_DT_DATO_CONTACTO
	   AND CONTACTO.B_ACTIVO = TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_AULA_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_AULA_BY_ID`(IN P_ID_DT_AULA INT)
BEGIN
	SELECT ID_DT_AULA,
		   DS_AULA,
           I_CAPACIDAD,
           DS_UBICACION
	  FROM DT_AULAS
	 WHERE ID_DT_AULA = P_ID_DT_AULA;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_AVATAR_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_AVATAR_BY_ID`(IN P_ID_AVATAR INT)
BEGIN
	
    SELECT DS_RUTA_IMAGEN_AVATAR
      FROM tm_avatar
	 WHERE ID_DT_AVATAR = P_ID_AVATAR;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_RESERVE_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_RESERVE_BY_ID`(IN P_ID_RESERVA INT)
BEGIN
	SELECT AULAS.DS_AULA,
		   USUARIOS.DS_NOMBRE,
           USUARIOS.DS_APELLIDO1,
           USUARIOS.DS_APELLIDO2,
		   RESERVAS.ID_DT_RESERVA, 
		   RESERVAS.DS_RESERVA, 
		   RESERVAS.FE_COMIENZO, 
		   RESERVAS.FE_FIN
	  FROM DT_RESERVAS RESERVAS
INNER JOIN DT_AULAS AULAS
		ON AULAS.ID_DT_AULA = RESERVAS.ID_DT_AULA
	   AND RESERVAS.B_ACTIVA = true
INNER JOIN DT_USUARIOS USUARIOS
		ON USUARIOS.ID_DT_USUARIO = RESERVAS.ID_DT_USUARIO
	 WHERE RESERVAS.FE_FIN >= NOW()
       AND RESERVAS.ID_DT_RESERVA = P_ID_RESERVA
  ORDER BY FE_COMIENZO DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_TODAY_RESERVES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_TODAY_RESERVES`()
BEGIN

    SELECT RESERVA.DS_RESERVA,
		   RESERVA.FE_COMIENZO AS DESDE,
		   RESERVA.FE_FIN AS HASTA,
           USUARIO.DS_NOMBRE, 
           USUARIO.DS_APELLIDO1,
           USUARIO.DS_APELLIDO2,
           DATOS_CONTACTO.DS_EMAIL,
           DATOS_CONTACTO.DS_TELEFONO,
           AULA.DS_AULA
	  FROM BD_AULAS.DT_RESERVAS RESERVA
INNER JOIN BD_AULAS.DT_USUARIOS USUARIO
		ON RESERVA.ID_DT_USUARIO = USUARIO.ID_DT_USUARIO
	   AND RESERVA.B_ACTIVA = TRUE
INNER JOIN BD_AULAS.DT_AULAS AULA
		ON RESERVA.ID_DT_AULA = AULA.ID_DT_AULA
	   AND RESERVA.B_ACTIVA = TRUE
INNER JOIN RE_USUARIOS_DATOS_CONTACTO RELACION
		ON USUARIO.ID_DT_USUARIO = RELACION.ID_DT_USUARIO
INNER JOIN DT_DATOS_CONTACTO DATOS_CONTACTO
		ON RELACION.ID_DT_DATO_CONTACTO = DATOS_CONTACTO.ID_DT_DATO_CONTACTO
	   AND DATOS_CONTACTO.B_ACTIVO = TRUE
	 WHERE CAST(RESERVA.FE_COMIENZO AS DATE) = CURDATE();
       
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_USER_BY_NAME_AND_PASSWORD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_USER_BY_NAME_AND_PASSWORD`(IN P_DS_LOGIN VARCHAR(20),
																			   IN P_DS_CLAVE VARCHAR(45))
BEGIN
	DECLARE ID_USUARIO INT DEFAULT 0;
    DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
    
	/*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;

	SELECT ID_DT_USUARIO INTO ID_USUARIO
	  FROM BD_AULAS.DT_USUARIOS
	 WHERE UPPER(TRIM(DS_LOGIN)) like UPPER(TRIM(P_DS_LOGIN))
	   AND DS_CLAVE like P_DS_CLAVE
       AND B_ACTIVO = TRUE;	
       
    IF ID_USUARIO > 0 THEN
        SET B_RESULTADO = 1; -- true
    ELSE
        SET B_RESULTADO = 0; -- false
    END IF;
    
    SELECT B_RESULTADO AS resultado,
		   ID_DT_USUARIO AS ID_USUARIO,
		   DS_NOMBRE AS NOMBRE,
           DS_APELLIDO1 AS APELLIDO1,
           DS_APELLIDO2 AS APELLIDO2,
           ID_DT_AVATAR AS AVATAR,
           B_HABILITADO AS HABILITADO           
	  FROM BD_AULAS.DT_USUARIOS
	 WHERE ID_DT_USUARIO = ID_USUARIO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_USUARIO_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_USUARIO_BY_ID`(IN P_ID_DT_USUARIO INT)
BEGIN
	SELECT USUARIOS.ID_DT_USUARIO, 
		   USUARIOS.DS_NOMBRE, 
           USUARIOS.DS_APELLIDO1, 
           USUARIOS.DS_APELLIDO2, 
           USUARIOS.DS_LOGIN, 
           USUARIOS.DS_CLAVE, 
           USUARIOS.FE_FECHA_CLAVE, 
           USUARIOS.ID_DT_AVATAR,
           CONTACTO.DS_EMAIL,
           CONTACTO.DS_TELEFONO,
           CONTACTO.DS_INSTAGRAM,
           CONTACTO.DS_FACEBOOK,
           USUARIOS.B_HABILITADO
	  FROM DT_USUARIOS USUARIOS
INNER JOIN RE_USUARIOS_DATOS_CONTACTO RELACIONAL
		ON RELACIONAL.ID_DT_USUARIO = USUARIOS.ID_DT_USUARIO
	   AND USUARIOS.B_ACTIVO = TRUE
INNER JOIN DT_DATOS_CONTACTO CONTACTO
		ON CONTACTO.ID_DT_DATO_CONTACTO = RELACIONAL.ID_DT_DATO_CONTACTO
	   AND CONTACTO.B_ACTIVO = TRUE
     WHERE USUARIOS.ID_DT_USUARIO = P_ID_DT_USUARIO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_AULAS_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_AULAS_BY_ID`(IN P_ID_DT_AULA INT, 
																 IN P_DS_AULA VARCHAR(100),
																 IN P_I_CAPACIDAD INT,
																 IN P_DS_UBICACION VARCHAR(250))
BEGIN

	DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN

        GET DIAGNOSTICS CONDITION 1
            @ERRNO = MYSQL_ERRNO,
            @MSG = MESSAGE_TEXT;

        ROLLBACK;

        SELECT B_RESULTADO AS resultado, @ERRNO+ ' ' + @MSG AS mensaje;
    END;

	UPDATE DT_AULAS
	   SET DS_AULA = P_DS_AULA,
		   I_CAPACIDAD = P_I_CAPACIDAD,
           DS_UBICACION = P_DS_UBICACION
	 WHERE ID_DT_AULA = P_ID_DT_AULA;
     
	SET B_RESULTADO = TRUE;
    
	SELECT B_RESULTADO AS resultado, 'Aula actualizada correctamente.' AS mensaje;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_RESERVA_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_RESERVA_BY_ID`(IN P_ID_DT_RESERVA INT,
																   IN P_DS_RESERVA VARCHAR(150),
                                                                   IN P_DESDE DATETIME,
                                                                   IN P_HASTA DATETIME)
BEGIN

	/* DECLARACION DE VARIABLES*/
	DECLARE B_RESULTADO BOOLEAN DEFAULT TRUE;
    DECLARE VC_MENSAJE VARCHAR(250) DEFAULT '';

    /*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
    
		SET B_RESULTADO = FALSE;
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
	START TRANSACTION;
    
	/* APARTADO PARA LAS VALIDACIONES ANTES DE INSERTAR UNA RESERVA.*/
       

	/* ASEGURA QUE LA RESERVA NO EXCEDE DEL DIA SOLICITADA*/
	IF (SELECT CAST(P_DESDE AS DATE) != CAST(P_HASTA AS DATE)) THEN    
		SET B_RESULTADO = FALSE;
		SET VC_MENSAJE = 'La fecha de incio y de fin deben ser para el mismo día.';
    END IF;

	/* VALIDA QUE LA FECHA DE FIN NO SEA INFERIOR QUE LA DE INCIIO */ 
	IF (SELECT CAST(P_DESDE AS DATE) > CAST(P_HASTA AS DATE)) THEN    
		SET B_RESULTADO = FALSE;
		SET VC_MENSAJE = 'La fecha de incio es mayor que la fecha de fin.';
    END IF;

	/* SI HA PASADO LAS VALIDACIONES, ACTUALZIA LA RESERVA */
    IF(B_RESULTADO = TRUE) THEN
		UPDATE DT_RESERVAS
		   SET DS_RESERVA = P_DS_RESERVA,
			   FE_COMIENZO = P_DESDE,
			   FE_FIN = P_HASTA
		 WHERE ID_DT_RESERVA = P_ID_DT_RESERVA;
         COMMIT;
         
         SET VC_MENSAJE = 'Reserva actualizada correctamente.';
         
     END IF;
	
    SELECT B_RESULTADO AS resultado, VC_MENSAJE AS  mensaje;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_USUARIO_BY_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_USUARIO_BY_ID`(IN P_ID_USUARIO INT,
																   IN P_DS_NOMBRE VARCHAR(150),
																   IN P_DS_APELLIDO1 VARCHAR(150),
																   IN P_DS_APELLIDO2 VARCHAR(150),
																   IN P_DS_LOGIN VARCHAR(20),
																   IN P_DS_CLAVE VARCHAR(45),
																   IN P_ID_AVATAR INT,
																   IN P_DS_EMAIL VARCHAR(150),
																   IN P_DS_TELEFONO VARCHAR(45),
																   IN P_DS_INSTAGRAM VARCHAR(45),
																   IN P_DS_FACEBOOK VARCHAR(45),
																   IN P_B_HABILITADO BOOLEAN)
BEGIN

	/* DECLARACION DE VARIABLES*/
	DECLARE B_RESULTADO BOOLEAN DEFAULT FALSE;
	DECLARE ID_USUARIO INT DEFAULT 0;
    DECLARE ID_DATO_CONTACTO INT DEFAULT 0;
    
    /*CONTROL DE EXCEPCIONES */
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener número de error y mensaje de error
		GET DIAGNOSTICS CONDITION 1
			@ERRNO = MYSQL_ERRNO,
			@MSG = MESSAGE_TEXT;

		ROLLBACK;

		-- Concatenar número y texto del error correctamente
		SELECT B_RESULTADO AS resultado,
			   CONCAT(@ERRNO, ' ', @MSG) AS mensaje;
	END;
    
	START TRANSACTION;
    
	/*ACTUALIZAR EL USUARIO*/
    UPDATE DT_USUARIOS
	   SET DS_NOMBRE = P_DS_NOMBRE,
		   DS_APELLIDO1 = P_DS_APELLIDO1,
		   DS_APELLIDO2 = P_DS_APELLIDO2,
		   DS_LOGIN = P_DS_LOGIN,
		   DS_CLAVE = P_DS_CLAVE,
		   ID_DT_AVATAR = P_ID_AVATAR,
		   B_HABILITADO = P_B_HABILITADO
     WHERE ID_DT_USUARIO = P_ID_USUARIO;
     
     /* OBTIENE EL ID DE LA TABLA DATO DE CONTACTO*/
     SELECT ID_DT_DATO_CONTACTO INTO ID_DATO_CONTACTO
	   FROM RE_USUARIOS_DATOS_CONTACTO
	  WHERE ID_DT_USUARIO = P_ID_USUARIO;
    									
	/* ACTUALIZA LOS DATOS DE CONTACTO */
    UPDATE DT_DATOS_CONTACTO
       SET DS_EMAIL = P_DS_EMAIL,
		   DS_TELEFONO = P_DS_TELEFONO,
		   DS_INSTAGRAM = P_DS_INSTAGRAM,
		   DS_FACEBOOK = P_DS_FACEBOOK
	 WHERE ID_DT_DATO_CONTACTO = ID_DATO_CONTACTO;
	
	   SET B_RESULTADO = TRUE;
    COMMIT;
    
    SELECT B_RESULTADO AS resultado, 'Proceso realizado correctamente' AS mensaje;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-16 17:59:42
