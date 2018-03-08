/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.1.30-MariaDB : Database - dbventas
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
  `cDescripcion` varchar(100) CHARACTER SET latin1 NOT NULL,
  `nStock` int(11) NOT NULL,
  `nTipo` int(11) NOT NULL,
  `nMarca` int(11) NOT NULL,
  `nPrecioCompra` double NOT NULL,
  `nPrecioVenta` double NOT NULL,
  `nEstado` int(11) DEFAULT '1',
  `cUserReg` varchar(50) CHARACTER SET latin1 NOT NULL,
  `dFechaReg` datetime NOT NULL,
  `cUserAct` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `dFechaAct` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `articulo` */

insert  into `articulo`(`Id`,`cDescripcion`,`nStock`,`nTipo`,`nMarca`,`nPrecioCompra`,`nPrecioVenta`,`nEstado`,`cUserReg`,`dFechaReg`,`cUserAct`,`dFechaAct`) values (1,'POET',10,1,2,1.2,1.7,1,'','0000-00-00 00:00:00','hroca','2018-03-07 17:12:07'),(2,'Cepillo',10,2,1,0.9,1,1,'','0000-00-00 00:00:00',NULL,NULL),(3,'Pega Mosca',10,4,3,0.7,1,1,'','0000-00-00 00:00:00',NULL,NULL),(4,'probando',40,2,4,1.2,1.58,0,'','0000-00-00 00:00:00',NULL,NULL),(5,'dento 75ml',7,2,4,2,2.5,1,'','0000-00-00 00:00:00',NULL,NULL),(6,'colgate 125ml',5,1,2,2.3,2.8,1,'','0000-00-00 00:00:00',NULL,NULL),(7,'DENTO 125ML',15,5,4,1.9,2.9,1,'','0000-00-00 00:00:00','hroca','2018-03-07 17:06:42'),(8,'ganchos de ropa (plÃ¡stico)',6,2,1,2,2.5,1,'hroca','2018-03-07 17:07:35',NULL,NULL),(9,'gancho de ropa (madera)',6,1,2,2,2.5,1,'hroca','2018-03-07 17:10:51',NULL,NULL);

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

/*Table structure for table `catalogocodigo` */

DROP TABLE IF EXISTS `catalogocodigo`;

CREATE TABLE `catalogocodigo` (
  `Id` int(11) NOT NULL,
  `cNomCod` varchar(100) NOT NULL,
  `cValor` varchar(20) NOT NULL,
  `nEstado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `catalogocodigo` */

insert  into `catalogocodigo`(`Id`,`cNomCod`,`cValor`,`nEstado`) values (1000,'TIPO PRODUCTOS','1000',1),(1000,'LIQUIDO','1',1),(1000,'SOLIDO','2',1),(1000,'VENENO','3',1),(1000,'DETERGENTES','4',1),(1000,'ASEO','5',1),(2000,'MARCAS','2000',1),(2000,'SAPOLIO','1',1),(2000,'POET','2',1),(2000,'RAIDMAX','3',1),(2000,'AYUDIN','4',1);

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

insert  into `usuario`(`Id`,`cNomUsu`,`cContrasenia`,`cNombres`) values (1,'hroca','ventas2018','Hugo Antonio Roca Espinoza'),(2,'jchavez','ventas2018',NULL);

/*Table structure for table `venta` */

DROP TABLE IF EXISTS `venta`;

CREATE TABLE `venta` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `dFecha` date NOT NULL,
  `nCantidad` int(11) NOT NULL,
  `nTotal` double NOT NULL,
  `cUsuReg` varchar(50) NOT NULL,
  `dFechaReg` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `venta` */

/*Table structure for table `ventadetalle` */

DROP TABLE IF EXISTS `ventadetalle`;

CREATE TABLE `ventadetalle` (
  `nIdVenta` int(11) NOT NULL,
  `nIdArticulo` int(11) NOT NULL,
  `nCantidad` int(11) NOT NULL,
  `nPrecio` double NOT NULL,
  KEY `venta` (`nIdVenta`),
  KEY `articulo` (`nIdArticulo`),
  CONSTRAINT `articulo` FOREIGN KEY (`nIdArticulo`) REFERENCES `articulo` (`Id`),
  CONSTRAINT `venta` FOREIGN KEY (`nIdVenta`) REFERENCES `venta` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventadetalle` */

/* Procedure structure for procedure `Articulo_Actualiza_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulo_Actualiza_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Articulo_Actualiza_SP`(
  in nId int,
  IN Descripcion VARCHAR (100),
  IN Stock INT,
  IN Tipo INT,
  IN Marca INT,
  IN PrecioCompra DOUBLE,
  IN PrecioVenta DOUBLE,
  in cUser varchar(50)
)
BEGIN
  update 
    articulo 
  set
    cDescripcion = Descripcion,
    nStock = Stock,
    nTipo = Tipo,
    nMarca = Marca,
    nPrecioCompra = PrecioCompra,
    nPrecioVenta = PrecioVenta,
    cUserAct = cUser,
    dFechaAct = now()
  WHERE Id = nId ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulo_Anular_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulo_Anular_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Articulo_Anular_SP`(
  in nId int
)
BEGIN
  update 
    articulo 
  set
    nEstado = 0 
  WHERE Id = nId ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulo_Insrtar_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulo_Insrtar_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Articulo_Insrtar_SP`(
  IN cDescripcion varchar (100),
  in nStock int,
  in nTipo int,
  in nMarca int,
  in nPrecioCompra double,
  in nPrecioVenta double,
  in cUser varchar(50)
)
BEGIN
  insert into articulo (
    cDescripcion,
    nStock,
    nTipo,
    nMarca,
    nPrecioCompra,
    nPrecioVenta,
    nEstado,
    cUserReg,
    dFechaReg
  ) 
  Values
    (
      cDescripcion,
      nStock,
      nTipo,
      nMarca,
      nPrecioCompra,
      nPrecioVenta,
      1,
      cUser,
      now()
    ) ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulo_ListaPorId_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulo_ListaPorId_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Articulo_ListaPorId_SP`(in nId int)
BEGIN
SELECT Id, cDescripcion, nStock, nTipo, nMarca, nPrecioCompra, nPrecioVenta FROM articulo WHERE Id = nId;
END */$$
DELIMITER ;

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
  WHERE a.`nEstado` = 1
  order by a.Id;
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
