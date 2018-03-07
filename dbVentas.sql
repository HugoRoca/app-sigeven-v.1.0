/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.24-log : Database - dbventas
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dbventas` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dbventas`;

/*Table structure for table `articulo` */

DROP TABLE IF EXISTS `articulo`;

CREATE TABLE `articulo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `cDescripcion` varchar(100) NOT NULL,
  `nStock` int(11) NOT NULL,
  `nTipo` int(11) NOT NULL,
  `nMarca` int(11) NOT NULL,
  `nPrecioCompra` double NOT NULL,
  `nPrecioVenta` double NOT NULL,
  `nEstado` int(11) DEFAULT '1',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `articulo` */

LOCK TABLES `articulo` WRITE;

insert  into `articulo`(`Id`,`cDescripcion`,`nStock`,`nTipo`,`nMarca`,`nPrecioCompra`,`nPrecioVenta`,`nEstado`) values (1,'Poet',5,1,1,1.5,1.7,1),(2,'Cepillo',10,2,1,0.9,1,1);

UNLOCK TABLES;

/*Table structure for table `articuloimagen` */

DROP TABLE IF EXISTS `articuloimagen`;

CREATE TABLE `articuloimagen` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IdArticulo` int(11) NOT NULL,
  `iImagen` mediumblob,
  `cRuta` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FKArticuloImagen` (`IdArticulo`),
  CONSTRAINT `FKArticuloImagen` FOREIGN KEY (`IdArticulo`) REFERENCES `articulo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `articuloimagen` */

LOCK TABLES `articuloimagen` WRITE;

UNLOCK TABLES;

/*Table structure for table `catalogocodigo` */

DROP TABLE IF EXISTS `catalogocodigo`;

CREATE TABLE `catalogocodigo` (
  `Id` int(11) NOT NULL,
  `cNomCod` varchar(100) NOT NULL,
  `cValor` varchar(20) NOT NULL,
  `nEstado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `catalogocodigo` */

LOCK TABLES `catalogocodigo` WRITE;

insert  into `catalogocodigo`(`Id`,`cNomCod`,`cValor`,`nEstado`) values (1000,'TIPO PRODUCTOS','1000',1),(1000,'LIQUIDO','1',1),(1000,'SOLIDO','2',1),(1000,'VENENO','3',1),(1000,'DETERGENTES','4',1),(1000,'ASEO','5',1),(2000,'MARCAS','2000',1),(2000,'SAPOLIO','1',1),(2000,'POET','2',1),(2000,'RAIDMAX','3',1),(2000,'AYUDIN','4',1);

UNLOCK TABLES;

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `cNomUsu` varchar(20) DEFAULT NULL,
  `cContrasenia` varchar(100) DEFAULT NULL,
  `cNombres` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `usuario` */

LOCK TABLES `usuario` WRITE;

insert  into `usuario`(`Id`,`cNomUsu`,`cContrasenia`,`cNombres`) values (1,'hroca','ventas2018','Hugo Antonio Roca Espinoza'),(2,'jchavez','ventas2018',NULL);

UNLOCK TABLES;

/* Procedure structure for procedure `Articulo_Lista_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulo_Lista_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Articulo_Lista_SP`()
BEGIN
  SELECT 
    a.Id,
    a.`cDescripcion`,
    a.`nStock`,
    a.`nTipo`,
    tipo.`cNomCod` AS cTipo,
    a.`nMarca`,
    marca.`cNomCod` AS cMarca,
    a.`nPrecioCompra`,
    a.`nPrecioVenta` 
  FROM
    articulo a 
    INNER JOIN catalogocodigo tipo 
      ON tipo.Id = 1000 
      AND tipo.`cValor` = a.nTipo 
    INNER JOIN catalogocodigo marca 
      ON marca.`Id` = 2000 
      AND marca.`cValor` = a.`nMarca` 
  WHERE a.`nEstado` = 1;
  END */$$
DELIMITER ;

/* Procedure structure for procedure `CatalogoCodigo_Lista_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `CatalogoCodigo_Lista_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CatalogoCodigo_Lista_SP`(in nCodigo int)
BEGIN
select * from catalogocodigo where Id = nCodigo and cValor != Id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Usuario_Validar_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Usuario_Validar_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuario_Validar_SP`(IN cUsuario VARCHAR(20), IN cPassword VARCHAR(30))
BEGIN
SELECT * FROM usuario WHERE cNomUsu = cUsuario AND cContrasenia = cPassword;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
