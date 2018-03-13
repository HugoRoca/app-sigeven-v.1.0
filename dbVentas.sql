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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `articulo` */

LOCK TABLES `articulo` WRITE;

insert  into `articulo`(`Id`,`cDescripcion`,`nStock`,`nTipo`,`nMarca`,`nPrecioCompra`,`nPrecioVenta`,`nEstado`,`cUserReg`,`dFechaReg`,`cUserAct`,`dFechaAct`) values (1,'POET',7,1,2,1.2,1.7,1,'','0000-00-00 00:00:00','hroca','2018-03-12 09:08:32'),(2,'Cepillo',5,2,1,0.9,1,1,'','0000-00-00 00:00:00',NULL,NULL),(3,'Pega Mosca',5,4,3,0.7,1,1,'','0000-00-00 00:00:00',NULL,NULL),(4,'probando',40,2,4,1.2,1.58,0,'','0000-00-00 00:00:00',NULL,NULL),(5,'dento 75ml',5,2,4,2,2.5,1,'','0000-00-00 00:00:00',NULL,NULL),(6,'colgate 125ml',1,1,2,2.3,2.8,1,'','0000-00-00 00:00:00',NULL,NULL),(7,'DENTO 125ML',13,5,4,1.9,2.9,1,'','0000-00-00 00:00:00','hroca','2018-03-07 17:06:42'),(8,'ganchos de ropa (plastico)',5,2,1,2,2.5,1,'hroca','2018-03-07 17:07:35','hroca','2018-03-12 09:08:41'),(9,'gancho de ropa (madera)',5,1,2,2,2.5,1,'hroca','2018-03-07 17:10:51','hroca','2018-03-11 17:45:59'),(10,'Escoba Clorinda chica',2,3,4,4.6,5,1,'hroca','2018-03-11 17:25:14','hroca','2018-03-11 18:24:23');

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

insert  into `catalogocodigo`(`Id`,`cNomCod`,`cValor`,`nEstado`) values (1000,'perfumadores','1000',1),(1000,'Veneno','1',0),(1000,'cera','2',1),(1000,'saca brillo','3',1),(1000,'casa suciedad','4',1),(1000,'perfumadores antiestress','5',1),(2000,'MARCAS','2000',1),(2000,'SAPOLIO','1',1),(2000,'POET','2',1),(2000,'RAIDMAX','3',1),(2000,'AYUDIN','4',1),(2000,'prueba','5',0),(1000,'perfumadores','6',1),(2000,'RAIDMAX','6',1);

UNLOCK TABLES;

/*Table structure for table `gasto` */

DROP TABLE IF EXISTS `gasto`;

CREATE TABLE `gasto` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `dFecha` date NOT NULL,
  `nCantidad` int(11) NOT NULL,
  `nTotal` double NOT NULL,
  `cUsuReg` varchar(50) NOT NULL,
  `dFechaReg` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `gasto` */

LOCK TABLES `gasto` WRITE;

insert  into `gasto`(`Id`,`dFecha`,`nCantidad`,`nTotal`,`cUsuReg`,`dFechaReg`) values (1,'2018-03-12',4,3.3,'hroca','2018-03-12 15:19:46');

UNLOCK TABLES;

/*Table structure for table `gastodetalle` */

DROP TABLE IF EXISTS `gastodetalle`;

CREATE TABLE `gastodetalle` (
  `nIdGasto` int(11) NOT NULL,
  `cDescripcion` varchar(500) NOT NULL,
  `nTotal` double NOT NULL,
  `cUsuReg` varchar(50) NOT NULL,
  `dFechaReg` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gastodetalle` */

LOCK TABLES `gastodetalle` WRITE;

insert  into `gastodetalle`(`nIdGasto`,`cDescripcion`,`nTotal`,`cUsuReg`,`dFechaReg`) values (1,'marcianp',0.5,'hroca','2018-03-12 15:19:47'),(1,'tripita',1.2,'hroca','2018-03-12 15:19:47'),(1,'tari',0.4,'hroca','2018-03-12 15:19:47'),(1,'gaseosa',1.2,'hroca','2018-03-12 15:19:47');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `venta` */

LOCK TABLES `venta` WRITE;

insert  into `venta`(`Id`,`dFecha`,`nCantidad`,`nTotal`,`cUsuReg`,`dFechaReg`) values (1,'2018-03-10',26,43.3,'hroca','2018-03-10 11:37:46'),(2,'2018-03-09',8,17.6,'hroca','2018-03-10 11:57:03'),(3,'2018-03-11',6,17,'hroca','2018-03-11 17:26:46'),(4,'2018-03-12',4,11.4,'hroca','2018-03-12 09:30:55');

UNLOCK TABLES;

/*Table structure for table `ventadetalle` */

DROP TABLE IF EXISTS `ventadetalle`;

CREATE TABLE `ventadetalle` (
  `nIdVenta` int(11) NOT NULL,
  `nIdArticulo` int(11) NOT NULL,
  `nCantidad` int(11) NOT NULL,
  `nPrecio` double NOT NULL,
  `cUsuReg` varchar(50) NOT NULL,
  `dFechaReg` datetime NOT NULL,
  KEY `venta` (`nIdVenta`),
  KEY `articulo` (`nIdArticulo`),
  CONSTRAINT `articulo` FOREIGN KEY (`nIdArticulo`) REFERENCES `articulo` (`Id`),
  CONSTRAINT `venta` FOREIGN KEY (`nIdVenta`) REFERENCES `venta` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventadetalle` */

LOCK TABLES `ventadetalle` WRITE;

insert  into `ventadetalle`(`nIdVenta`,`nIdArticulo`,`nCantidad`,`nPrecio`,`cUsuReg`,`dFechaReg`) values (1,2,1,1,'hroca','2018-03-10 11:45:00'),(1,8,1,2.5,'hroca','2018-03-10 11:45:00'),(1,9,1,2.5,'hroca','2018-03-10 11:45:00'),(1,1,5,1.7,'hroca','2018-03-10 11:52:23'),(1,2,2,1,'hroca','2018-03-10 11:52:23'),(1,3,5,1,'hroca','2018-03-10 11:52:23'),(1,5,2,2.5,'hroca','2018-03-10 11:52:24'),(1,6,2,2.8,'hroca','2018-03-10 11:52:24'),(2,1,1,1.7,'hroca','2018-03-10 11:57:03'),(2,9,2,2.5,'hroca','2018-03-10 11:57:03'),(2,8,3,2.5,'hroca','2018-03-10 11:57:03'),(3,10,2,5,'hroca','2018-03-11 17:26:46'),(3,2,2,1,'hroca','2018-03-11 17:26:46'),(3,9,2,2.5,'hroca','2018-03-11 17:26:47'),(2,1,2,1.7,'hroca','2018-03-11 22:59:44'),(4,6,2,2.8,'hroca','2018-03-12 09:30:55'),(4,7,2,2.9,'hroca','2018-03-12 09:30:56');

UNLOCK TABLES;

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

/* Procedure structure for procedure `Articulo_ListaMasVendidos_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulo_ListaMasVendidos_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Articulo_ListaMasVendidos_SP`()
BEGIN
  SELECT 
    concat(' - ',a.`cDescripcion`) label,
    SUM(ncantidad) as `data`
  FROM
    ventadetalle v 
    INNER JOIN articulo a 
      ON v.`nIdArticulo` = a.`Id` 
  GROUP BY nIdArticulo,
    cDescripcion 
  ORDER BY `data` DESC 
  LIMIT 5 ;
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

/* Procedure structure for procedure `CatalogoCodigo_Insertar_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `CatalogoCodigo_Insertar_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CatalogoCodigo_Insertar_SP`(
  in nId int,
  in cNom varchar (100),
  in cVal int,
  in nEst int
)
BEGIN
  if cVal = 0 
  then set @cValor = 
  (select 
    max(cValor) + 1 
  from
    catalogocodigo 
  where Id = nId) ;
  insert into catalogocodigo (Id, cNomCod, cValor, nEstado) 
  values
    (nId, cNom, @cValor, nEst) ;
  else 
  update 
    catalogocodigo 
  set
    cNomCod = cNom,
    nEstado = nEst 
  where Id = nId and cValor = cVal;
  end if ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CatalogoCodigo_Lista_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `CatalogoCodigo_Lista_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CatalogoCodigo_Lista_SP`(in nCodigo int, in nTipo int)
BEGIN
  if nTipo = 1 
  then 
  select 
    * 
  from
    catalogocodigo 
  where Id = nCodigo 
    and cValor != Id 
    and nEstado = 1 ;
  else 
  SELECT 
    * 
  FROM
    catalogocodigo 
  WHERE Id = nCodigo 
    AND cValor != Id order by cValor asc;
  end if ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Gasto_Insertar_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Gasto_Insertar_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Gasto_Insertar_SP`(
  IN dFechaReg DATE,
  IN cUsu VARCHAR(50),
  IN cDesc varchar(500),
  IN nMontoTot double
)
BEGIN
	SET @nContador = (SELECT COUNT(*) FROM gasto WHERE dFecha = dFechaReg);
	
	IF @nContador = 0 THEN
		INSERT INTO gasto(dFecha, nCantidad, nTotal, cUsuReg, dFechaReg) 
		VALUES(dFechaReg, 1, nMontoTot, cUsu, NOW());
	ELSE		
		UPDATE gasto SET nCantidad = nCantidad + 1, nTotal = nTotal + nMontoTot WHERE dFecha = dFechaReg;
	END IF;	
	
	SET @nGasto = (SELECT Id FROM gasto WHERE dFecha = dFechaReg);
	
	INSERT INTO gastoDetalle(nIdGasto, cDescripcion, nTotal, cUsuReg, dFechaReg)
	VALUES (@nGasto, cDesc, nMontoTot, cUsu, NOW());	
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

/* Procedure structure for procedure `Ventas_ListaPorSemana_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_ListaPorSemana_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ventas_ListaPorSemana_SP`()
BEGIN
  SELECT 
    DATE_FORMAT(v.dFecha, '%d/%m/%y') AS `y`,
    v.nTotal AS `a`,
    IFNULL(g.nTotal, 0) AS `b` 
  FROM
    venta v 
    LEFT JOIN gasto g 
      ON v.`dFecha` = g.`dFecha` 
  ORDER BY v.dfecha DESC 
  LIMIT 4 ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Venta_Insertar_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Venta_Insertar_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Venta_Insertar_SP`(
  IN dFechaReg date,
  in cUsu varchar(50),
  in nId int,
  in nCant int
)
BEGIN
	set @nPrecioVenta = (select nPrecioVenta from articulo where Id = nId);
	set @nTotal = round(nCant * @nPrecioVenta,2);
	set @nContador = (select count(*) from venta where dFecha = dFechaReg);
	if @nContador = 0 then
		insert into venta(dFecha, nCantidad, nTotal, cUsuReg, dFechaReg) values(dFechaReg, nCant, @nTotal, cUsu, now());
	else
		set @nTotal = round((select nTotal from venta where dFecha = dFechaReg) + @nTotal, 2);
		SET @nCantidad = (SELECT nCantidad FROM venta WHERE dFecha = dFechaReg) + nCant;		
		
		update venta set nCantidad = @nCantidad, nTotal = @nTotal where dFecha = dFechaReg;
	end if;	
	
	set @nVenta = (select Id from venta where dFecha = dFechaReg);
	
	insert into ventadetalle(nIdVenta, nIdArticulo, nCantidad, nPrecio, cUsuReg, dFechaReg)
	values (@nVenta, nId, nCant, @nPrecioVenta, cUsu, now());
	
	update articulo set nStock = nStock - nCant where Id = nId;	
	
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
