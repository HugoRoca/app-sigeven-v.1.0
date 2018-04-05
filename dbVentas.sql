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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `articulo` */

insert  into `articulo`(`Id`,`cDescripcion`,`nStock`,`nTipo`,`nMarca`,`nPrecioCompra`,`nPrecioVenta`,`nEstado`,`cUserReg`,`dFechaReg`,`cUserAct`,`dFechaAct`) values (1,'Escoba clorinda chica',2,6,6,0,5.6,1,'hroca','2018-03-14 18:06:41',NULL,NULL),(2,'Escobas madera colores',6,6,18,0,4.5,1,'hroca','2018-03-14 22:27:31',NULL,NULL),(3,'Escobas italiana',3,6,18,0,5,1,'hroca','2018-03-14 22:28:05',NULL,NULL),(4,'Escobas negro/rojo',3,6,18,0,5,1,'hroca','2018-03-14 22:30:05',NULL,NULL),(5,'Escoba negro/azul',2,6,18,0,4.5,1,'hroca','2018-03-14 22:30:34',NULL,NULL),(6,'Escoba Tula',3,6,18,0,3.6,1,'hroca','2018-03-14 22:31:06',NULL,NULL),(7,'Escobilla para botella',1,6,18,0,1.5,1,'hroca','2018-03-14 22:31:35',NULL,NULL),(8,'Recogedor de plastico',12,6,18,0,3.5,1,'hroca','2018-03-14 22:32:15',NULL,NULL),(9,'Recogedor metal',6,6,18,0,5,1,'hroca','2018-03-14 22:32:47',NULL,NULL),(10,'Isopo de Water con embase',4,6,18,0,3.5,1,'hroca','2018-03-14 22:34:32',NULL,NULL),(11,'Guantes reiu',2,6,18,0,1.8,1,'hroca','2018-03-14 22:35:57',NULL,NULL),(12,'Guantes nicson',4,7,19,0,4,1,'hroca','2018-03-14 22:38:30',NULL,NULL),(13,'Guante Koppas',1,7,18,0,3,1,'hroca','2018-03-14 22:39:01',NULL,NULL),(14,'Guantes simples',12,7,18,0,2.5,1,'hroca','2018-03-14 22:39:45',NULL,NULL),(15,'Cabezal triggerSpragers',2,6,18,0,2.3,1,'hroca','2018-03-14 22:40:26',NULL,NULL),(16,'Isopos para water',4,6,18,0,2,1,'hroca','2018-03-14 22:41:34',NULL,NULL),(17,'Tinte para ropa azul/negro',9,4,18,0,1,1,'hroca','2018-03-14 22:42:26',NULL,NULL),(18,'Galon pino',6,2,18,0,5.5,1,'hroca','2018-03-14 22:42:54',NULL,NULL),(19,'Galon Quitasarro',1,2,18,0,6,1,'hroca','2018-03-14 22:43:49',NULL,NULL),(20,'Galon perfumador morado',4,2,18,0,5.5,1,'hroca','2018-03-14 22:44:08',NULL,NULL),(21,'Galon perfumador rosado',6,2,18,0,5.5,1,'hroca','2018-03-14 22:44:44',NULL,NULL),(22,'GalÃ³n perfumador celeste',0,2,18,0,5.65,1,'hroca','2018-03-14 22:45:30',NULL,NULL),(23,'GalÃ³n creso',3,2,18,0,6.5,1,'hroca','2018-03-14 22:47:43',NULL,NULL),(24,'Ayudin Sapolio 900gr',6,8,1,0,5,1,'hroca','2018-03-14 22:50:58',NULL,NULL),(25,'Ayudin Sapolio 180gr',12,8,1,0,1.7,1,'hroca','2018-03-14 22:51:29',NULL,NULL),(26,'LejÃ­a clorox',15,4,4,0,1.7,1,'hroca','2018-03-14 22:52:38',NULL,NULL);

/*Table structure for table `articuloimagen` */

DROP TABLE IF EXISTS `articuloimagen`;

CREATE TABLE `articuloimagen` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IdArticulo` int(11) NOT NULL,
  `iImagen` mediumblob,
  `cRuta` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FKArticuloImagen` (`IdArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `articuloimagen` */

/*Table structure for table `catalogocodigo` */

DROP TABLE IF EXISTS `catalogocodigo`;

CREATE TABLE `catalogocodigo` (
  `Id` int(11) NOT NULL,
  `cNomCod` varchar(100) NOT NULL,
  `cValor` int(11) NOT NULL,
  `nEstado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `catalogocodigo` */

insert  into `catalogocodigo`(`Id`,`cNomCod`,`cValor`,`nEstado`) values (1000,'perfumadores',1000,1),(1000,'Veneno',1,1),(2000,'MARCAS',2000,1),(2000,'SAPOLIO',1,1),(1000,'Perfumador',2,1),(1000,'Mascotas',3,1),(2000,'Ayudin',2,1),(2000,'NowClin',3,1),(2000,'Clorox',4,1),(2000,'Clorandina',5,1),(2000,'Clorinda',6,1),(2000,'Poet',7,1),(1000,'Aseo Personal',4,1),(2000,'RaidMax',8,1),(2000,'Schick',9,1),(2000,'Dento',11,1),(2000,'Colgate',10,1),(2000,'Santiago',12,1),(2000,'Glade',13,1),(1000,'Pastillas',5,1),(2000,'Amigo',14,1),(2000,'Kanino',15,1),(2000,'Practican',16,1),(2000,'Doky\'s',17,1),(1000,'Escobas',6,1),(2000,'Sin Marca',18,1),(1000,'Guantes',7,1),(2000,'Nicson',19,1),(1000,'Cocina',8,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `gasto` */

insert  into `gasto`(`Id`,`dFecha`,`nCantidad`,`nTotal`,`cUsuReg`,`dFechaReg`) values (1,'2018-03-14',1,1.7,'hroca','2018-03-14 22:54:01'),(2,'2018-03-20',1,2,'hroca','2018-03-20 16:26:02');

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

insert  into `gastodetalle`(`nIdGasto`,`cDescripcion`,`nTotal`,`cUsuReg`,`dFechaReg`) values (1,'tripita',1.7,'hroca','2018-03-14 22:54:01'),(2,'canchita',2,'hroca','2018-03-20 16:26:02');

/*Table structure for table `proveedor` */

DROP TABLE IF EXISTS `proveedor`;

CREATE TABLE `proveedor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `cNomProveedor` varchar(200) NOT NULL,
  `nCantidad` int(11) NOT NULL,
  `nTotal` double NOT NULL,
  `dFecha` date NOT NULL,
  `dFechaReg` datetime NOT NULL,
  `cUserReg` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `proveedor` */

/*Table structure for table `proveedordetalle` */

DROP TABLE IF EXISTS `proveedordetalle`;

CREATE TABLE `proveedordetalle` (
  `nIdProveedor` int(11) NOT NULL,
  `nIdArticulo` int(11) NOT NULL,
  `nPrecioCompra` double NOT NULL,
  `nPrecioVenta` double NOT NULL,
  `nCantidad` int(11) NOT NULL,
  `nTotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `proveedordetalle` */

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `venta` */

insert  into `venta`(`Id`,`dFecha`,`nCantidad`,`nTotal`,`cUsuReg`,`dFechaReg`) values (1,'2018-03-14',2,7.9,'hroca','2018-03-14 22:53:32'),(2,'2018-03-20',2,10.1,'hroca','2018-03-20 16:25:49'),(3,'2018-03-19',1,5.65,'hroca','2018-03-20 16:26:13');

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
  KEY `articulo` (`nIdArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventadetalle` */

insert  into `ventadetalle`(`nIdVenta`,`nIdArticulo`,`nCantidad`,`nPrecio`,`cUsuReg`,`dFechaReg`) values (1,15,1,2.3,'hroca','2018-03-14 22:53:32'),(1,1,1,5.6,'hroca','2018-03-14 22:53:32'),(1,2,2,2.3,'hroca','2018-03-20 16:13:14'),(1,9,5,2.5,'hroca','2018-03-20 16:25:18'),(2,1,1,5.6,'hroca','2018-03-20 16:25:49'),(2,5,1,4.5,'hroca','2018-03-20 16:25:49'),(3,22,1,5.65,'hroca','2018-03-20 16:26:13');

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
  where Id = nId and cValor != nId) ;
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
    and nEstado = 1  ORDER BY cNomCod ASC;
  else 
  SELECT 
    * 
  FROM
    catalogocodigo 
  WHERE Id = nCodigo 
    AND cValor != Id ORDER BY cNomCod ASC;
  end if ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Dashboard_Consulta_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Dashboard_Consulta_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Dashboard_Consulta_SP`()
BEGIN
  SELECT 
	(SELECT COUNT(*) FROM articulo WHERE nEstado = 1) AS nArticulos,
	(SELECT COUNT(*) FROM venta) AS nVentas,
	(SELECT ifnull(AVG(nTotal), 0) FROM venta WHERE MONTH(dfechaReg) = MONTH(NOW())) AS nPromedioVentas,
	(SELECT ifnull(AVG(nTotal), 0) FROM gasto WHERE MONTH(dfechaReg) = MONTH(NOW())) AS nPromedioGasto,
	(SELECT MONTH(NOW())) AS cMes;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GastoDetalle_Consulta_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `GastoDetalle_Consulta_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `GastoDetalle_Consulta_SP`(IN nId INT)
BEGIN
  select 
    cDescripcion,
    nTotal 
  from
    gastodetalle 
  where nIdGasto = nId ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Gasto_Consulta_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Gasto_Consulta_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Gasto_Consulta_SP`(IN desde DATE, IN hasta DATE)
BEGIN
  SELECT 
    Id,
    DATE_FORMAT(dFecha, '%d/%m/%Y') AS dFecha,
    nCantidad,
    nTotal,
    cUsuReg 
  FROM
    gasto 
  WHERE dFecha BETWEEN desde 
    AND hasta 
  ORDER BY dFecha DESC ;
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

/* Procedure structure for procedure `VentaDetalle_Consulta_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentaDetalle_Consulta_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `VentaDetalle_Consulta_SP`(in nId int)
BEGIN
  select 
    v.nIdArticulo,
    a.cDescripcion,
    v.nCantidad,
    v.nPrecio,
    v.nCantidad * v.nPrecio as nTotal 
  from
    ventadetalle v 
    inner join articulo a 
      on v.nIdArticulo = a.Id 
  where nIdVenta = nId ;
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

/* Procedure structure for procedure `Venta_Consulta_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Venta_Consulta_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Venta_Consulta_SP`(in desde date, in hasta date)
BEGIN
  select 
    Id,
    DATE_FORMAT(dFecha, '%d/%m/%Y') as dFecha,
    nCantidad,
    nTotal,
    cUsuReg 
  from
    venta 
  where dFecha between desde 
    and hasta 
  order by dFecha desc ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Proveedor_Insertar_SP` */

/*!50003 DROP PROCEDURE IF EXISTS  `Proveedor_Insertar_SP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Proveedor_Insertar_SP`(
  IN dFech DATE,
  in cNomProv varchar(200),
  in idArt int,
  in nCant int,
  in nPxC double,
  in nPxV double,
  in nPTotal double,  
  IN cUsu VARCHAR(50)
)
BEGIN
	set @contador = (select count(*) from proveedor where dFecha = dFech and cNomProveedor = cNomProv);
	SET @nCodigo = 0;
		
	IF @contador = 0 THEN
		insert into proveedor(cNomProveedor, nCantidad, nTotal, dFecha, dFechaReg, cUserReg)
		values(cNomProv, nCant, nPTotal, dFech, now(), cUsu);
	ELSE	
		SET @nCodigo = (SELECT Id FROM proveedor WHERE dFecha = dFech AND cNomProveedor = cNomProv);
		update proveedor set nCantidad = nCant, nTotal = nTotal + nPTotal where Id = @nCodigo;
	END IF;	
	
	SET @nCodigo = (SELECT Id FROM proveedor WHERE dFecha = dFech AND cNomProveedor = cNomProv);
	
	insert into proveedorDetalle(nIdProveedor, nIdArticulo,nPrecioCompra, nPrecioVenta, nCantidad, nTotal)
	values(@nCodigo, idArt, nPxC, nPxV, nCant, nPTotal);
	
	update articulo	set nStock = nStock + nCant, nPrecioCompra = nPxC, nPrecioVenta = nPxV where Id = idArt;
	
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
