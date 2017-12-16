/*
SQLyog Ultimate v9.01 
MySQL - 5.5.30 : Database - guopiao
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`guopiao` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `guopiao`;

/*Table structure for table `概念股票$` */

DROP TABLE IF EXISTS `概念股票$`;

CREATE TABLE `概念股票$` (
  `名称` varchar(255) DEFAULT NULL,
  `涨幅` double DEFAULT NULL,
  `现价` double DEFAULT NULL,
  `涨速` double DEFAULT NULL,
  `JINGE` double DEFAULT NULL,
  `大单净比%` double DEFAULT NULL,
  `换手` double DEFAULT NULL,
  `量比` double DEFAULT NULL,
  `总手` double DEFAULT NULL,
  `市盈(动)` double DEFAULT NULL,
  `市净率` double DEFAULT NULL,
  `振幅%` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `资金股份查询$` */

DROP TABLE IF EXISTS `资金股份查询$`;

CREATE TABLE `资金股份查询$` (
  `证券代码` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `证券名称` varchar(255) DEFAULT NULL,
  `股份余额` double DEFAULT NULL,
  `可用股份` double DEFAULT NULL,
  `成本价` double DEFAULT NULL,
  `当前价` double DEFAULT NULL,
  `最新市值` double DEFAULT NULL,
  `浮动盈亏` double DEFAULT NULL,
  `盈亏比例(%)` double DEFAULT NULL,
  `交易冻结数量` double DEFAULT NULL,
  `异常冻结` double DEFAULT NULL,
  `在途股份` double DEFAULT NULL,
  `当前拥股` double DEFAULT NULL,
  `股东代码` varchar(255) DEFAULT NULL,
  `资金帐号` varchar(255) DEFAULT NULL,
  `客户代码` varchar(255) DEFAULT NULL,
  `交易所名称` varchar(255) DEFAULT NULL,
  `备注` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `a` */

DROP TABLE IF EXISTS `a`;

CREATE TABLE `a` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `str` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `bar` */

DROP TABLE IF EXISTS `bar`;

CREATE TABLE `bar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `adj_factor` decimal(10,2) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `bar_type` int(11) DEFAULT NULL,
  `close` decimal(10,2) DEFAULT NULL,
  `exchange` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `high` decimal(10,2) DEFAULT NULL,
  `low` decimal(10,2) DEFAULT NULL,
  `open` decimal(10,2) DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  `pre_close` decimal(10,2) DEFAULT NULL,
  `sec_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tdate` date DEFAULT NULL,
  `ttime` time DEFAULT NULL,
  `volume` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `currency` */

DROP TABLE IF EXISTS `currency`;

CREATE TABLE `currency` (
  `curcode` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `curname` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `befcur` decimal(10,6) DEFAULT NULL,
  `lastcur` decimal(10,6) DEFAULT NULL,
  `zf` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`curcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `dpqs` */

DROP TABLE IF EXISTS `dpqs`;

CREATE TABLE `dpqs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jdate` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qs` int(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `dprec` */

DROP TABLE IF EXISTS `dprec`;

CREATE TABLE `dprec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dplow` decimal(9,2) DEFAULT NULL,
  `dptop` decimal(9,2) DEFAULT NULL,
  `dptime` time DEFAULT NULL,
  `zf` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `dzrl` */

DROP TABLE IF EXISTS `dzrl`;

CREATE TABLE `dzrl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gn` int(11) DEFAULT '0',
  `rl` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keystr` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpstr` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `eacode` */

DROP TABLE IF EXISTS `eacode`;

CREATE TABLE `eacode` (
  `CODEID` bigint(8) NOT NULL AUTO_INCREMENT COMMENT '对照ID',
  `FIELD` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '对照字段',
  `FIELDNAME` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '对照字段名称',
  `CODE` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '代码',
  `CODEDESC` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '代码描述',
  `ENABLED` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '1' COMMENT '启用状态(0:禁用;1:启用)',
  `SORTNO` int(4) DEFAULT NULL COMMENT '排序号',
  `REMARK` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODETYPE` char(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CODEID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='代码对照表';

/*Table structure for table `event` */

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remark` text COLLATE utf8_unicode_ci,
  `uptime` datetime DEFAULT NULL,
  `statue` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gn` */

DROP TABLE IF EXISTS `gn`;

CREATE TABLE `gn` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gn` bigint(30) NOT NULL,
  `gnname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `flag` double DEFAULT '0',
  `remark` varchar(200) DEFAULT NULL,
  `display` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex2` (`gnname`),
  KEY `NewIndex1` (`gn`)
) ENGINE=InnoDB AUTO_INCREMENT=655 DEFAULT CHARSET=utf8;

/*Table structure for table `gn1` */

DROP TABLE IF EXISTS `gn1`;

CREATE TABLE `gn1` (
  `code` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(5,3) DEFAULT NULL,
  `zf3` decimal(5,3) DEFAULT NULL,
  `zf10` decimal(5,3) DEFAULT NULL,
  `zf30` decimal(5,3) DEFAULT NULL,
  `rsi6` decimal(5,3) DEFAULT NULL,
  `rsi12` decimal(5,3) DEFAULT NULL,
  `rsi24` decimal(5,3) DEFAULT NULL,
  `ltg` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sel` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gn2gp` */

DROP TABLE IF EXISTS `gn2gp`;

CREATE TABLE `gn2gp` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `gn` char(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpcode` char(8) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`gpcode`),
  KEY `gn_index` (`gn`)
) ENGINE=InnoDB AUTO_INCREMENT=8360 DEFAULT CHARSET=utf8;

/*Table structure for table `gn2gp_copy` */

DROP TABLE IF EXISTS `gn2gp_copy`;

CREATE TABLE `gn2gp_copy` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `gn` char(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpcode` char(8) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`gpcode`)
) ENGINE=InnoDB AUTO_INCREMENT=8122 DEFAULT CHARSET=utf8;

/*Table structure for table `gn2gpsels` */

DROP TABLE IF EXISTS `gn2gpsels`;

CREATE TABLE `gn2gpsels` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gn` int(11) DEFAULT NULL,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gn_gp_monitor` */

DROP TABLE IF EXISTS `gn_gp_monitor`;

CREATE TABLE `gn_gp_monitor` (
  `gnname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lzg` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`gnname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gnsta` */

DROP TABLE IF EXISTS `gnsta`;

CREATE TABLE `gnsta` (
  `gn` int(11) NOT NULL,
  `gndesc` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dqj` decimal(10,2) DEFAULT NULL,
  `syl` decimal(10,2) DEFAULT NULL,
  `ltsz` decimal(10,2) DEFAULT NULL,
  `zf_b` decimal(10,2) DEFAULT NULL,
  `zf_e` decimal(10,2) DEFAULT NULL,
  `rsi6` decimal(10,2) DEFAULT NULL,
  `rsi12` decimal(10,2) DEFAULT NULL,
  `rsi24` decimal(10,2) DEFAULT NULL,
  `gnzf` decimal(10,2) DEFAULT NULL,
  `gnzr_zf` decimal(10,2) DEFAULT NULL,
  `gn3zf` decimal(10,2) DEFAULT NULL,
  `stime` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `etime` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`gn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gnzfrec` */

DROP TABLE IF EXISTS `gnzfrec`;

CREATE TABLE `gnzfrec` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gn` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(10,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`gn`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gp` */

DROP TABLE IF EXISTS `gp`;

CREATE TABLE `gp` (
  `code` char(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `hy` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `syl` decimal(15,4) DEFAULT '0.0000',
  `sjl` decimal(15,4) DEFAULT '0.0000',
  `zsz` decimal(10,2) DEFAULT '0.00',
  `ltsz` decimal(10,2) DEFAULT '0.00',
  `mgsy` decimal(10,5) DEFAULT '0.00000',
  PRIMARY KEY (`code`),
  UNIQUE KEY `gp_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `gp2gp` */

DROP TABLE IF EXISTS `gp2gp`;

CREATE TABLE `gp2gp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gpa` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpb` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpbuy` */

DROP TABLE IF EXISTS `gpbuy`;

CREATE TABLE `gpbuy` (
  `code` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(8,2) DEFAULT '0.00',
  `dp` decimal(8,2) DEFAULT '0.00',
  `flag` int(11) DEFAULT '0',
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpcw` */

DROP TABLE IF EXISTS `gpcw`;

CREATE TABLE `gpcw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `mgjzc` double DEFAULT NULL,
  `mgsy` decimal(8,2) DEFAULT NULL,
  `mgxjhl` double DEFAULT NULL,
  `mgzbgjj` double DEFAULT NULL,
  `zyywsr` double DEFAULT NULL,
  `jll` double DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=12126 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpext` */

DROP TABLE IF EXISTS `gpext`;

CREATE TABLE `gpext` (
  `code` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `gn` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpfp` */

DROP TABLE IF EXISTS `gpfp`;

CREATE TABLE `gpfp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eventtype` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(8,2) DEFAULT NULL,
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpjjrec` */

DROP TABLE IF EXISTS `gpjjrec`;

CREATE TABLE `gpjjrec` (
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `upjjcnt` int(11) DEFAULT NULL,
  `downjjcnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpjx` */

DROP TABLE IF EXISTS `gpjx`;

CREATE TABLE `gpjx` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jj5` decimal(8,2) DEFAULT '0.00',
  `jj10` decimal(8,2) DEFAULT '0.00',
  `jj20` decimal(8,2) DEFAULT '0.00',
  `jj30` decimal(8,2) DEFAULT '0.00',
  `jj50` decimal(8,2) DEFAULT '0.00',
  `atr` decimal(8,2) DEFAULT '0.00',
  `ddd` decimal(8,2) DEFAULT '0.00',
  `ema10` decimal(8,2) DEFAULT '0.00',
  `upddate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpjxhis` */

DROP TABLE IF EXISTS `gpjxhis`;

CREATE TABLE `gpjxhis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jj5` decimal(8,2) DEFAULT '0.00',
  `jj10` decimal(8,2) DEFAULT '0.00',
  `jj20` decimal(8,2) DEFAULT '0.00',
  `jj30` decimal(8,2) DEFAULT '0.00',
  `jj50` decimal(8,2) DEFAULT '0.00',
  `atr` decimal(8,2) DEFAULT '0.00',
  `ddd` decimal(8,2) DEFAULT '0.00',
  `ema10` decimal(8,2) DEFAULT '0.00',
  `upddate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_jxhis` (`code`,`upddate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gplog` */

DROP TABLE IF EXISTS `gplog`;

CREATE TABLE `gplog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logstr` longtext COLLATE utf8_unicode_ci,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpparam` */

DROP TABLE IF EXISTS `gpparam`;

CREATE TABLE `gpparam` (
  `jydate` date DEFAULT NULL,
  `code` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `tranflag` char(1) COLLATE utf8_unicode_ci DEFAULT '1' COMMENT '实盘开关',
  `jjspflag` int(11) DEFAULT '0' COMMENT '掘金实盘交易开关',
  `slspflag` int(11) DEFAULT '0',
  `tranmode` int(5) DEFAULT '0' COMMENT '交易模式(0:保守 1:激进)',
  `testbdate` date DEFAULT NULL,
  `testedate` date DEFAULT NULL,
  `intype` int(11) DEFAULT '0' COMMENT '入场模式（0:右侧 1左侧)',
  `syn_flag` int(11) DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gprefcode` */

DROP TABLE IF EXISTS `gprefcode`;

CREATE TABLE `gprefcode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpsel` */

DROP TABLE IF EXISTS `gpsel`;

CREATE TABLE `gpsel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `staid` int(11) DEFAULT '2',
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` int(20) DEFAULT '-1',
  `gn` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `date` date DEFAULT '2017-10-01',
  `zbflag` int(10) DEFAULT '2',
  `gpflag` int(11) DEFAULT '5',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpsel_bak` */

DROP TABLE IF EXISTS `gpsel_bak`;

CREATE TABLE `gpsel_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `staid` int(11) DEFAULT NULL,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` int(1) DEFAULT '-1',
  `gn` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0',
  `date` date DEFAULT NULL,
  `zbflag` int(50) DEFAULT NULL,
  `gpflag` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpsell` */

DROP TABLE IF EXISTS `gpsell`;

CREATE TABLE `gpsell` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amt` decimal(10,2) DEFAULT '0.00',
  `num` int(11) DEFAULT '0',
  `cbj` decimal(8,2) DEFAULT '0.00',
  `dqj` decimal(8,2) DEFAULT '0.00',
  `fdyk` decimal(8,2) DEFAULT '0.00',
  `ykl` decimal(8,2) DEFAULT '0.00',
  `dp` decimal(8,2) DEFAULT '0.00' COMMENT '大盘指数',
  `flag` int(1) DEFAULT '0',
  `buydate` datetime DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpsinahis` */

DROP TABLE IF EXISTS `gpsinahis`;

CREATE TABLE `gpsinahis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kpj` decimal(8,2) DEFAULT NULL,
  `dqj` decimal(8,2) DEFAULT NULL,
  `zrspj` decimal(8,2) DEFAULT NULL,
  `jrzgj` decimal(8,2) DEFAULT NULL,
  `jrzdj` decimal(8,2) DEFAULT NULL,
  `cj_num` double DEFAULT NULL,
  `cj_amt` decimal(20,2) DEFAULT NULL,
  `zf` decimal(8,2) DEFAULT NULL,
  `zhengf` decimal(8,2) DEFAULT NULL,
  `jj` decimal(20,2) DEFAULT NULL,
  `hsl` decimal(8,2) DEFAULT NULL,
  `tr` decimal(8,2) DEFAULT '0.00',
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_code` (`code`),
  KEY `idx_sihis` (`code`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=144931 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gptime` */

DROP TABLE IF EXISTS `gptime`;

CREATE TABLE `gptime` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `zf` decimal(10,2) DEFAULT NULL,
  `lastzf` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gptimehis` */

DROP TABLE IF EXISTS `gptimehis`;

CREATE TABLE `gptimehis` (
  `jytime` time DEFAULT NULL,
  `cjj` decimal(8,2) DEFAULT NULL,
  `jgbd` decimal(8,2) DEFAULT NULL,
  `cjl` decimal(8,2) DEFAULT NULL,
  `cje` double DEFAULT NULL,
  `xz` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sumcjl` decimal(25,2) DEFAULT NULL,
  `sumcje` decimal(25,2) DEFAULT NULL,
  `jj` decimal(8,2) DEFAULT NULL,
  `totalcjl` decimal(25,2) DEFAULT NULL,
  `totalcje` decimal(25,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gptimerec` */

DROP TABLE IF EXISTS `gptimerec`;

CREATE TABLE `gptimerec` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bd` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tp_cnt` int(11) DEFAULT NULL,
  `tp_price` decimal(10,4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gptimetotal` */

DROP TABLE IF EXISTS `gptimetotal`;

CREATE TABLE `gptimetotal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zb` decimal(10,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gptoday` */

DROP TABLE IF EXISTS `gptoday`;

CREATE TABLE `gptoday` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kpj` decimal(8,2) DEFAULT NULL,
  `dqj` decimal(8,2) DEFAULT NULL,
  `zrspj` decimal(8,2) DEFAULT NULL,
  `jrzgj` decimal(8,2) DEFAULT NULL,
  `jrzdj` decimal(8,2) DEFAULT NULL,
  `cj_num` double DEFAULT NULL,
  `cj_amt` decimal(20,2) DEFAULT NULL,
  `zf` decimal(8,2) DEFAULT NULL,
  `zhengf` decimal(8,2) DEFAULT NULL,
  `jj` decimal(20,2) DEFAULT NULL,
  `hsl` decimal(8,2) DEFAULT NULL,
  `tr` decimal(8,2) DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `trantime` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3419 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gptodayzfrec` */

DROP TABLE IF EXISTS `gptodayzfrec`;

CREATE TABLE `gptodayzfrec` (
  `code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(5,2) DEFAULT NULL,
  `dqj` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpyaohhis` */

DROP TABLE IF EXISTS `gpyaohhis`;

CREATE TABLE `gpyaohhis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `Code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Open` decimal(30,2) DEFAULT NULL,
  `High` decimal(30,2) DEFAULT NULL,
  `Low` decimal(30,2) DEFAULT NULL,
  `Close` decimal(30,2) DEFAULT NULL,
  `Volume` decimal(30,2) DEFAULT NULL,
  `AdjClose` decimal(30,2) DEFAULT NULL,
  `zf` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpzfrec` */

DROP TABLE IF EXISTS `gpzfrec`;

CREATE TABLE `gpzfrec` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(10,2) DEFAULT '0.00',
  `zf2` decimal(10,2) DEFAULT NULL,
  `low_3` decimal(10,2) DEFAULT NULL,
  `zf7` decimal(10,2) DEFAULT NULL,
  `zf10` decimal(10,2) DEFAULT NULL,
  `zf30` decimal(10,2) DEFAULT NULL,
  `zf3` decimal(10,2) DEFAULT NULL,
  `zf_rec` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `low_5` decimal(10,2) DEFAULT NULL,
  `top_2` decimal(10,2) DEFAULT NULL,
  `top_30` decimal(10,2) DEFAULT NULL,
  `top_60` decimal(10,2) DEFAULT NULL,
  `jx_5` decimal(10,2) DEFAULT NULL,
  `jx_10` decimal(10,2) DEFAULT NULL,
  `jx_20` decimal(10,2) DEFAULT NULL,
  `jx_30` decimal(10,2) DEFAULT NULL,
  `jx_60` decimal(10,2) DEFAULT NULL,
  `zr_close` decimal(10,2) DEFAULT NULL,
  `zr_cjl` decimal(10,2) DEFAULT NULL,
  `rsi_6` decimal(10,2) DEFAULT NULL,
  `rsi_12` decimal(10,2) DEFAULT NULL,
  `rsi_24` decimal(10,2) DEFAULT NULL,
  `pj_60_zhengfu` decimal(10,2) DEFAULT '0.00',
  `pj_30_zhengfu` decimal(10,2) DEFAULT '0.00',
  `pj_24_zhengfu` decimal(10,2) DEFAULT '0.00',
  `pj_12_zhengfu` decimal(10,2) DEFAULT '0.00',
  `pj_6_zhengfu` decimal(10,2) DEFAULT '0.00',
  `tp_bar_num` int(11) DEFAULT '0',
  `last_tp_open` decimal(10,2) DEFAULT '0.00',
  `syx_bar_num` bigint(20) DEFAULT NULL,
  `zt_bar_num` int(11) DEFAULT NULL,
  `zt_bar_open` decimal(10,2) DEFAULT NULL,
  `is_cxg` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=34684 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpzhibiao` */

DROP TABLE IF EXISTS `gpzhibiao`;

CREATE TABLE `gpzhibiao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `zf5` decimal(10,2) DEFAULT NULL,
  `zf10` decimal(10,2) DEFAULT NULL,
  `zf30` decimal(10,2) DEFAULT NULL,
  `low_5` decimal(10,2) DEFAULT NULL,
  `top_30` decimal(10,2) DEFAULT NULL,
  `jx_5` decimal(10,2) DEFAULT NULL,
  `rsi_6` decimal(10,2) DEFAULT NULL,
  `rsi_12` decimal(10,2) DEFAULT NULL,
  `rsi_24` decimal(10,2) DEFAULT NULL,
  `pj_15_zhengfu` decimal(10,2) DEFAULT NULL,
  `pj_30_zhengfu` decimal(10,2) DEFAULT '0.00',
  `tp_bar_num` int(11) DEFAULT NULL,
  `fszb` decimal(10,2) DEFAULT NULL,
  `fszb_ext` decimal(10,2) DEFAULT NULL,
  `syx_bar_num` bigint(20) DEFAULT NULL,
  `dp_rsi_6` decimal(15,2) DEFAULT NULL,
  `dp_zf3` decimal(15,2) DEFAULT NULL,
  `dp_jx_5` decimal(15,2) DEFAULT NULL,
  `dp_zf` decimal(15,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3954 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `gpzthis` */

DROP TABLE IF EXISTS `gpzthis`;

CREATE TABLE `gpzthis` (
  `code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `zf` decimal(5,2) DEFAULT NULL,
  `zftime` time DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hey` */

DROP TABLE IF EXISTS `hey`;

CREATE TABLE `hey` (
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `code1` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slcode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `heyref` */

DROP TABLE IF EXISTS `heyref`;

CREATE TABLE `heyref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hey` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `heyname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hy` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gn` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gps` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lt` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hg_code_param` */

DROP TABLE IF EXISTS `hg_code_param`;

CREATE TABLE `hg_code_param` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sccode` char(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '市场类型',
  `maxdw` int(11) DEFAULT NULL COMMENT '最大单位',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hy` */

DROP TABLE IF EXISTS `hy`;

CREATE TABLE `hy` (
  `hy` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `qz` double DEFAULT NULL,
  `sel` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`hy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hy1` */

DROP TABLE IF EXISTS `hy1`;

CREATE TABLE `hy1` (
  `hy` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `zf` decimal(5,2) DEFAULT NULL,
  `zf3` decimal(5,2) DEFAULT NULL,
  `zf10` decimal(5,2) DEFAULT NULL,
  `zf30` decimal(5,2) DEFAULT NULL,
  `rsi6` decimal(5,2) DEFAULT NULL,
  `rsi12` decimal(5,2) DEFAULT NULL,
  `rsi24` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`hy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hyorder` */

DROP TABLE IF EXISTS `hyorder`;

CREATE TABLE `hyorder` (
  `hy` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cnt` decimal(30,2) DEFAULT '0.00',
  PRIMARY KEY (`hy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hyref` */

DROP TABLE IF EXISTS `hyref`;

CREATE TABLE `hyref` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `dl` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xl` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `dl_desc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hysta` */

DROP TABLE IF EXISTS `hysta`;

CREATE TABLE `hysta` (
  `hy` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `dqj` decimal(10,2) DEFAULT NULL,
  `syl` decimal(10,2) DEFAULT NULL,
  `ltsz` decimal(10,2) DEFAULT NULL,
  `zf_b` decimal(10,2) DEFAULT NULL,
  `zf_e` decimal(10,2) DEFAULT NULL,
  `rsi6` decimal(10,2) DEFAULT NULL,
  `rsi12` decimal(10,2) DEFAULT NULL,
  `rsi24` decimal(10,2) DEFAULT NULL,
  `hyzf` decimal(10,2) DEFAULT NULL,
  `hyzr_zf` decimal(10,2) DEFAULT NULL,
  `hy3zf` decimal(10,2) DEFAULT NULL,
  `stime` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `etime` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  PRIMARY KEY (`hy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hyzfhis` */

DROP TABLE IF EXISTS `hyzfhis`;

CREATE TABLE `hyzfhis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hy` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(10,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `hyzfrec` */

DROP TABLE IF EXISTS `hyzfrec`;

CREATE TABLE `hyzfrec` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hy` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zf` decimal(10,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `inxhs` */

DROP TABLE IF EXISTS `inxhs`;

CREATE TABLE `inxhs` (
  `xh` int(11) NOT NULL,
  PRIMARY KEY (`xh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `jjlog` */

DROP TABLE IF EXISTS `jjlog`;

CREATE TABLE `jjlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `log` text COLLATE utf8_unicode_ci,
  `logtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `jxcost` */

DROP TABLE IF EXISTS `jxcost`;

CREATE TABLE `jxcost` (
  `code` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `uptime` bigint(20) DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `longhu` */

DROP TABLE IF EXISTS `longhu`;

CREATE TABLE `longhu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zjjd` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zdf` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jmre` decimal(8,2) DEFAULT NULL,
  `type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `match` */

DROP TABLE IF EXISTS `match`;

CREATE TABLE `match` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `match` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `type` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `desc` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `newsyw` */

DROP TABLE IF EXISTS `newsyw`;

CREATE TABLE `newsyw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flag` int(1) DEFAULT NULL,
  `keystr` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `newsfrom` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gn` int(11) DEFAULT NULL,
  `remark` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remark1` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updtime` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `keystr` (`keystr`)
) ENGINE=InnoDB AUTO_INCREMENT=63452 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `openjpa_sequence_table` */

DROP TABLE IF EXISTS `openjpa_sequence_table`;

CREATE TABLE `openjpa_sequence_table` (
  `ID` tinyint(4) NOT NULL,
  `SEQUENCE_VALUE` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `plan` */

DROP TABLE IF EXISTS `plan`;

CREATE TABLE `plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rq` date DEFAULT NULL,
  `desc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cls` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hy` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gn` int(11) DEFAULT NULL,
  `gps` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `position` */

DROP TABLE IF EXISTS `position`;

CREATE TABLE `position` (
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `indate` datetime DEFAULT NULL,
  `outdate` datetime DEFAULT NULL,
  `inxh` int(11) NOT NULL DEFAULT '0',
  `available` int(11) DEFAULT '0',
  `available_today` int(11) DEFAULT '0',
  `vwap` decimal(8,2) DEFAULT '0.00',
  `price` decimal(8,2) DEFAULT '0.00',
  `cost` decimal(8,2) DEFAULT '0.00',
  `fpnl` decimal(8,2) DEFAULT '0.00' COMMENT '持仓成本',
  `sumzf` decimal(8,2) DEFAULT '0.00',
  `selltime` decimal(8,2) DEFAULT '0.00',
  `zy` decimal(8,2) DEFAULT '0.00',
  `zs` decimal(8,2) DEFAULT '0.00',
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `position_prd` */

DROP TABLE IF EXISTS `position_prd`;

CREATE TABLE `position_prd` (
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `indate` datetime DEFAULT NULL,
  `outdate` datetime DEFAULT NULL,
  `inxh` int(11) DEFAULT '0',
  `available` int(11) DEFAULT '0',
  `available_today` int(11) DEFAULT '0',
  `vwap` decimal(8,2) DEFAULT '0.00',
  `price` decimal(8,2) DEFAULT '0.00',
  `cost` decimal(8,2) DEFAULT '0.00',
  `fpnl` decimal(8,2) DEFAULT '0.00' COMMENT '持仓成本',
  `sumzf` decimal(8,2) DEFAULT '0.00',
  `selltime` decimal(8,2) DEFAULT '0.00',
  `zy` decimal(8,2) DEFAULT '0.00',
  `zs` decimal(8,2) DEFAULT '0.00',
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `prezf` */

DROP TABLE IF EXISTS `prezf`;

CREATE TABLE `prezf` (
  `code` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `zf` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `qjsel` */

DROP TABLE IF EXISTS `qjsel`;

CREATE TABLE `qjsel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xhtype` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `zf` decimal(10,2) DEFAULT NULL,
  `jcdate` datetime DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `qsparam` */

DROP TABLE IF EXISTS `qsparam`;

CREATE TABLE `qsparam` (
  `id` bigint(2) NOT NULL AUTO_INCREMENT,
  `waittime` bigint(11) DEFAULT '0',
  `wait_jg` int(11) DEFAULT NULL,
  `js_qs` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `rtn_value` */

DROP TABLE IF EXISTS `rtn_value`;

CREATE TABLE `rtn_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rtn_value` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `sta_param` */

DROP TABLE IF EXISTS `sta_param`;

CREATE TABLE `sta_param` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sta_id` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_value` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `store` */

DROP TABLE IF EXISTS `store`;

CREATE TABLE `store` (
  `code` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total` decimal(8,2) DEFAULT '0.00',
  `gpsz` decimal(8,2) DEFAULT '0.00',
  `zjye` decimal(8,2) DEFAULT '0.00',
  `ykje` decimal(8,2) DEFAULT '0.00',
  `ykl` decimal(8,2) DEFAULT '0.00',
  `pamt` decimal(8,2) DEFAULT '0.00',
  `syl` decimal(8,2) DEFAULT '0.00' COMMENT '使用率',
  `per_cnt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `stratey` */

DROP TABLE IF EXISTS `stratey`;

CREATE TABLE `stratey` (
  `strcode` int(11) NOT NULL,
  `strname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `strdesc` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gpcodes` longtext COLLATE utf8_unicode_ci,
  `flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`strcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `table$` */

DROP TABLE IF EXISTS `table$`;

CREATE TABLE `table$` (
  `代码` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `名称` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `所属行业` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `市盈(动)` double DEFAULT NULL,
  `市净率` double DEFAULT NULL,
  `总市值` double DEFAULT NULL,
  `流通市值` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `todaysel` */

DROP TABLE IF EXISTS `todaysel`;

CREATE TABLE `todaysel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `bk` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `tranhis` */

DROP TABLE IF EXISTS `tranhis`;

CREATE TABLE `tranhis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `side` int(1) DEFAULT NULL,
  `inxh` int(1) DEFAULT NULL,
  `cost` decimal(8,2) DEFAULT '0.00',
  `price` decimal(8,2) DEFAULT '0.00',
  `nums` int(11) DEFAULT '0',
  `fdyk` decimal(8,2) DEFAULT '0.00',
  `in_date` datetime DEFAULT NULL,
  `tran_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `tranplan` */

DROP TABLE IF EXISTS `tranplan`;

CREATE TABLE `tranplan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `btime` time DEFAULT NULL,
  `etime` time DEFAULT NULL,
  `cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `xh` */

DROP TABLE IF EXISTS `xh`;

CREATE TABLE `xh` (
  `xh` int(2) NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '类型（股票，大盘）',
  PRIMARY KEY (`xh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `xsjj$` */

DROP TABLE IF EXISTS `xsjj$`;

CREATE TABLE `xsjj$` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `xsdate` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `bqjj` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dqj` decimal(10,2) DEFAULT NULL,
  `zjj` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `zbbl` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `tran_end_every_day` */

/*!50106 DROP EVENT IF EXISTS `tran_end_every_day`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`root`@`localhost` EVENT `tran_end_every_day` ON SCHEDULE EVERY 1 DAY STARTS '2016-03-21 17:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL end_trans_process() */$$
DELIMITER ;

/* Function  structure for function  `cjl_convert` */

/*!50003 DROP FUNCTION IF EXISTS `cjl_convert` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `cjl_convert`(in_zf DECIMAL(10,4)) RETURNS varchar(50) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
	DECLARE v_zf_str VARCHAR(200) default '';
		
		IF (in_zf >= 0 AND in_zf <= 1) THEN
		  SET v_zf_str = '0';
		ELSEIF (in_zf > 1 AND in_zf <= 2) THEN
		  SET v_zf_str = '1';
		ELSEIF (in_zf > 2 AND in_zf <= 3) THEN
		  SET v_zf_str = '2';
		ELSEIF (in_zf > 3 AND in_zf <=4) THEN
		  SET v_zf_str = '3';
		ELSEIF (in_zf > 4 AND in_zf <= 5) THEN
		  SET v_zf_str = '4';
		ELSEIF (in_zf > 5 AND in_zf <= 6) THEN
		  SET v_zf_str = '5';
		ELSEIF (in_zf > 6 AND in_zf <= 7) THEN
		  SET v_zf_str = '6';
		ELSEIF (in_zf > 7 AND in_zf <= 8) THEN
		  SET v_zf_str = '7';
		ELSEIF (in_zf > 8 AND in_zf <= 9) THEN
		  SET v_zf_str = '8';
		ELSEIF (in_zf > 9 AND in_zf <= 19) THEN
		  SET v_zf_str = '9';
		END IF;	
		
		RETURN(v_zf_str);
    END */$$
DELIMITER ;

/* Function  structure for function  `crossOver` */

/*!50003 DROP FUNCTION IF EXISTS `crossOver` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `crossOver`(in_code CHAR(10),in_extra_per DECIMAL(8,2)) RETURNS decimal(8,2)
BEGIN
	DECLARE p_code VARCHAR(20) DEFAULT '';
	DECLARE p_jj5  DECIMAL(8,2);
	DECLARE p_jj10 DECIMAL(8,2);	
	DECLARE v_flag_1 bool default false;
	DECLARE v_flag_2 BOOL DEFAULT FALSE;		
		
	declare v_date datetime;
	DECLARE v_over_date DATETIME;	
	
	declare r_max_price DECIMAL(8,2) default 0;
	DECLARE i INT DEFAULT 0;
	    
         		   
	DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/  
        DECLARE feeCodeCursor CURSOR FOR SELECT CODE,jj5,jj10,upddate 
		FROM gpjxhis h WHERE h.`code`=in_code ORDER BY h.`upddate` DESC limit 0,5;               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;     
					
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code,p_jj5,p_jj10,v_date;
	     WHILE b<>1 DO            	     	        
	     	
	     	set i = i+1;	
	     							
	        if (i=1 and p_jj5 >= p_jj10) then
		   set v_flag_1 = true;				   
		elseif (v_flag_1 = TRUE and i=2 AND p_jj5<p_jj10) then 	
		   SET v_flag_2 = TRUE; 	  
		   set v_over_date =  v_date;	   			  	
		end if;
								 
	       FETCH feeCodeCursor INTO p_code,p_jj5,p_jj10,v_date; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;  	
	 
	IF (v_flag_2 = TRUE) THEN	  
	  SELECT MAX(h.dqj) INTO r_max_price FROM gpsinahis h 
		WHERE h.`code`=in_code AND h.date<=v_over_date ORDER BY h.date DESC LIMIT 0,5;
	 END IF;
        set r_max_price = r_max_price*(1+in_extra_per/100);	
	
	return (r_max_price);		
    END */$$
DELIMITER ;

/* Function  structure for function  `crossUnder` */

/*!50003 DROP FUNCTION IF EXISTS `crossUnder` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `crossUnder`(in_code CHAR(10),in_extra_per DECIMAL(8,2)) RETURNS decimal(8,2)
BEGIN
	DECLARE p_code VARCHAR(20) DEFAULT '';
	DECLARE p_jj5  DECIMAL(8,2);
	DECLARE p_jj10 DECIMAL(8,2);	
	DECLARE v_flag_1 bool default false;
	DECLARE v_flag_2 BOOL DEFAULT FALSE;		
		
	declare v_date datetime;
	DECLARE v_over_date DATETIME;	
	
	declare r_max_price DECIMAL(8,2) default 0;
	DECLARE i INT DEFAULT 0;
	    
         		   
	DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/  
        DECLARE feeCodeCursor CURSOR FOR SELECT CODE,jj5,jj10,upddate 
		FROM gpjxhis h WHERE h.`code`=in_code ORDER BY h.`upddate` DESC limit 0,5;               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;     
					
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code,p_jj5,p_jj10,v_date;
	     WHILE b<>1 DO            	     	        
	     	
	     	set i = i+1;	
	     							
	        if (i=1 and p_jj5 <= p_jj10) then
		   set v_flag_1 = true;				   
		elseif (v_flag_1 = TRUE and i=2 AND p_jj5>p_jj10) then 	
		   SET v_flag_2 = TRUE; 	  
		   set v_over_date =  v_date;	   			  	
		end if;
								 
	       FETCH feeCodeCursor INTO p_code,p_jj5,p_jj10,v_date; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;  	
	 
	IF (v_flag_2 = TRUE) THEN	  
	  SELECT min(h.dqj) INTO r_max_price FROM gpsinahis h 
		WHERE h.`code`=in_code AND h.date<=v_over_date ORDER BY h.date DESC LIMIT 0,5;
	 END IF;
        set r_max_price = r_max_price*(1-in_extra_per/100);	
	
	return (r_max_price);		
    END */$$
DELIMITER ;

/* Function  structure for function  `get_date` */

/*!50003 DROP FUNCTION IF EXISTS `get_date` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_date`() RETURNS double
BEGIN
	DECLARE v_date double;
		SELECT CONCAT(HOUR(NOW()),'.',MINUTE(NOW())) into v_date;
		
		RETURN(v_date);
    END */$$
DELIMITER ;

/* Function  structure for function  `get_gp_ema` */

/*!50003 DROP FUNCTION IF EXISTS `get_gp_ema` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_gp_ema`(icode VARCHAR(30), n INTEGER,idate DATETIME) RETURNS decimal(8,2)
BEGIN
	
	DECLARE c_cnt INT DEFAULT 0;    
	DECLARE p_close DECIMAL(8,2);   	 
	
	DECLARE p_ema DECIMAL(8,2);   
	DECLARE pre_ema DECIMAL(8,2); 
		  
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/  
        DECLARE feeCodeCursor CURSOR FOR SELECT t.close FROM (SELECT DATE,CLOSE FROM gpyaohhis WHERE CODE=icode AND DATE<=idate ORDER BY DATE DESC LIMIT 0,n) t ORDER BY t.date;             
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;     				
	
	OPEN feeCodeCursor;	
				
	 FETCH feeCodeCursor INTO p_close;
	     WHILE b<>1 DO            	     	        
                SET c_cnt = c_cnt + 1;
                
                IF (c_cnt = 1) THEN
                  SET p_ema = p_close;
                ELSE
                  SET p_ema = (p_close*2+pre_ema*(c_cnt-1))/(c_cnt+1);                               
                END IF;                
		SET pre_ema = p_ema;
			 
	       FETCH feeCodeCursor INTO p_close; /*取下一条记录*/
	      END WHILE;
	 
	  CLOSE feeCodeCursor;   
	  	 
	return (p_ema);		
    END */$$
DELIMITER ;

/* Function  structure for function  `get_gp_group_zf` */

/*!50003 DROP FUNCTION IF EXISTS `get_gp_group_zf` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_gp_group_zf`(ign int, ihy VARCHAR(30)) RETURNS decimal(8,2)
BEGIN
		
	DECLARE o_zf DECIMAL(8,2);   	
	if (ign >0) then
	  SELECT zf INTO o_zf FROM gnzfrec g WHERE g.`gn`=ign;
	end if; 	
		
	if (o_zf is null and ihy='煤炭开采') then
	   SELECT avg(zf) INTO o_zf FROM hyzfrec g WHERE g.hy in ('煤炭开采','钢铁');
	end if;	
	
	IF (o_zf IS NULL) THEN
	  set o_zf := 0;
	END IF;	
	
	return o_zf;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_gp_hey_zfc` */

/*!50003 DROP FUNCTION IF EXISTS `get_gp_hey_zfc` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_gp_hey_zfc`(icode VARCHAR(30), ihtype VARCHAR(30)) RETURNS int(11)
BEGIN
		
	DECLARE v_hey_zf DECIMAL(8,2) default 0;  
	DECLARE v_gp_zf DECIMAL(8,2) DEFAULT 0;  
	DECLARE o_flag INT DEFAULT 0; 
	
	set v_hey_zf := get_hey_group_zf(icode,ihtype);
	
	if (icode='AU0') then
	  SET v_gp_zf := get_gp_group_zf(0,ihtype);
	else
	  SET v_gp_zf := get_gp_group_zf(702,'');
	end if;
		
	if (v_hey_zf >= 2 and v_gp_zf > 0 and (v_hey_zf-v_gp_zf) >= 1) then
	   set o_flag := 1;
	end if;		  	
		
	return o_flag;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_hey_group_zf` */

/*!50003 DROP FUNCTION IF EXISTS `get_hey_group_zf` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_hey_group_zf`(icode VARCHAR(30), itype VARCHAR(30)) RETURNS decimal(8,2)
BEGIN
		
	DECLARE o_zf DECIMAL(8,2);   	 	
	SELECT AVG(g.`zf`) into o_zf FROM hey h,gptoday g WHERE h.`slcode`=g.`code` AND h.`type` = itype;
	
	if (o_zf is null) then
	   SELECT max(g.`zf`) INTO o_zf FROM hey h,gptoday g WHERE h.`slcode`=g.`code` AND h.`slcode` = icode;
	end if;	
	
	IF (o_zf IS NULL) THEN
	  set o_zf := 0;
	END IF;	
	
	return o_zf;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_tran_date` */

/*!50003 DROP FUNCTION IF EXISTS `get_tran_date` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_tran_date`() RETURNS date
BEGIN
	DECLARE v_date date;
		SELECT jydate INTO v_date FROM gpparam;
		
		RETURN(v_date);
    END */$$
DELIMITER ;

/* Function  structure for function  `get_zs_codes` */

/*!50003 DROP FUNCTION IF EXISTS `get_zs_codes` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_zs_codes`() RETURNS varchar(50) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
	DECLARE v_zs_str VARCHAR(200) default 'int_dji,sh000001,sz399001,sz399006';
		
		RETURN(v_zs_str);
    END */$$
DELIMITER ;

/* Function  structure for function  `zf_convert` */

/*!50003 DROP FUNCTION IF EXISTS `zf_convert` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `zf_convert`(in_zf DECIMAL(10,4)) RETURNS varchar(50) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
	DECLARE v_zf_str VARCHAR(200) default '';
		IF (in_zf >= -200 AND in_zf <= -8) THEN
		  SET v_zf_str = '0';
		ELSEIF (in_zf >= -8 AND in_zf <= -6) THEN
		  SET v_zf_str = '1';	
		ELSEIF (in_zf > -6 AND in_zf <= -4) THEN
		  SET v_zf_str = '2';	
		ELSEIF (in_zf > -4 AND in_zf <= -2) THEN
		  SET v_zf_str = '3';	
		ELSEIF (in_zf > -2 AND in_zf < 0) THEN
		  SET v_zf_str = '4';
		ELSEIF (in_zf >= 0 AND in_zf <= 2) THEN
		  SET v_zf_str = '5';
		ELSEIF (in_zf > 2 AND in_zf <= 4) THEN
		  SET v_zf_str = '6';
		ELSEIF (in_zf > 4 AND in_zf <= 6) THEN
		  SET v_zf_str = '7';
		ELSEIF (in_zf > 6 AND in_zf <= 8) THEN
		  SET v_zf_str = '8';
		ELSEIF (in_zf > 8 AND in_zf <= 200) THEN
		  SET v_zf_str = '9';
		ELSE
		  SET v_zf_str = 'a';
		END IF;	
		
		RETURN(v_zf_str);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `add_gpsel` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_gpsel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_gpsel`()
BEGIN                 
	 
         INSERT INTO gpsel SELECT 0,2,SUBSTR(t.`代码`,3),t.`名称`,1,'no',NOW(),1,3 FROM `table$` t WHERE SUBSTR(t.`代码`,3) NOT IN (SELECT CODE FROM gpsel);                 	
                        
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `bar_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `bar_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `bar_process`(i_time datetime)
BEGIN
    
      delete from gp_time_total where t_time < DATE_ADD(i_time,INTERVAL -5 MINUTE);
                  
      commit;
            
    END */$$
DELIMITER ;

/* Procedure structure for procedure `buy_sell` */

/*!50003 DROP PROCEDURE IF EXISTS  `buy_sell` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `buy_sell`()
BEGIN
	/**买人 */
       SELECT DISTINCT CODE,if(price<20,300,100) buynumber,price,jcdate,trantype,xhtype,TYPE FROM (
       SELECT CODE,price,jcdate,1 trantype,xhtype,TYPE FROM (SELECT q.xhtype,q.code,q.price,IFNULL(q.jcdate,NOW()) jcdate,q.type 
         FROM qjsel q,gpzfrec g1,gp g2 WHERE q.code=g1.code AND g1.code=g2.code 
          AND q.price < 70
          AND g1.zr_close > 0
          AND (g1.`jx_5`-g1.`zr_close`)/g1.`zr_close`*100 < 30                      
	  AND q.zf < 9 
	  ORDER BY q.xhtype,g2.syl) tmp           
	  LIMIT 0,10
	  
       UNION ALL
       
       /** 止损卖出**/
       SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype,0 
	FROM POSITION p,gptoday g,gp g1 
		WHERE p.`code`=g.`code` AND g.code=g1.code
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0				
		 AND g.zf < 0
		 AND p.`sumzf` < -2					 	 
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`jj` > 0 AND g.`dqj` >= g.`jj`,"14:45:00","9:30:00"))
		 
	UNION ALL
        
        /** 止赢**/
        SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype,0 FROM POSITION p,gptoday g
		WHERE p.`code`=g.`code` 
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0		 
		 AND p.`sumzf` > 1	
		 AND g.zf < 9		
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`jj` > 0 AND g.`dqj` >= g.`jj`,"14:40:00","9:40:00"))) 
		 tmp ORDER BY trantype,xhtype;	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cjl_record` */

/*!50003 DROP PROCEDURE IF EXISTS  `cjl_record` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cjl_record`(in_code char(10))
BEGIN
    
        DECLARE v_zf_str VARCHAR(200) default '';
       
        					              
        DECLARE p_zf decimal(20,2);  
        DECLARE p_total DECIMAL(25,2);  
        DECLARE p_bfb DECIMAL(20,4);        
        
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT cj_num/1000 cj_num FROM gpsinahis where code = in_code order by date ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;
	
	SELECT sum(cj_num)/1000 into p_total FROM gpsinahis WHERE CODE = in_code ORDER BY DATE ;
			
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_zf;
	     WHILE b<>1 DO            	     	        
	     
	        /*百分百*/
	        set p_bfb = ROUND((p_zf/p_total)*100,2);			
	        
		
		SET v_zf_str = CONCAT(v_zf_str,cjl_convert(p_bfb));			 				
                                       		 		 
	       FETCH feeCodeCursor INTO p_zf; /*取下一条记录*/
	      END WHILE;
	 update gpzfrec set cjl_rec = v_zf_str where code = in_code;
	 CLOSE feeCodeCursor;      		
                                   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cjl_record_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `cjl_record_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cjl_record_all`()
BEGIN                 
        
        
        DECLARE p_code VARCHAR(20);       
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT code from gp;
        
       
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;       	
	
	
			
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code;
	     WHILE b<>1 DO            	     	        
	     
	        					
		call cjl_record(p_code);
		
                                       		 		 
	       FETCH feeCodeCursor INTO p_code; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                
        
                         
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `clear_xh_proc` */

/*!50003 DROP PROCEDURE IF EXISTS  `clear_xh_proc` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_xh_proc`(gpcode VARCHAR(20),i_selltime double,i_zy double,i_zs double)
BEGIN
UPDATE position SET selltime=i_selltime,zy=i_zy,zs=i_zs WHERE CODE =gpcode;
commit;	
END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_bc` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_bc` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_bc`(in_xh INTEGER)
BEGIN
      
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh;       
                             
      /*补仓*/ 
      INSERT INTO qjsel SELECT DISTINCT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0
                FROM position p,gp g,gptoday g1 WHERE p.`code`=g.`code` AND g.`code`=g1.`code`                             
                and p.`available` > 0  
                and p.`available_today` = 0                 
                and g1.zf < 0                
		and g1.`cj_amt` > 0		
                and p.`sumzf` < -1            
                AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:52:00"); 
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_cdqsg` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_cdqsg` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_cdqsg`(in_xh INTEGER,cyb_zf DOUBLE,zxp_zf DOUBLE,dp_zf DOUBLE)
BEGIN
          
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
            
	 /*强势股抄底2*/
	INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` 
                AND g.`code`=g1.`code` AND g.`code`=g2.`code`
                AND gs.`gn` <> 'zs'                             
                AND in_cnt < 5                          
		AND g1.kpj > 0 
		AND g1.cj_amt > 0		
		AND g1.dqj > 0						
		AND g1.zf < 1																					
		AND g.code NOT IN (SELECT CODE FROM xsjj)	
	        AND g.hy NOT IN (SELECT hy FROM 买入行业)	
		AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.available > 0) 	
		and if(cyb_zf < 0.35 and zxp_zf < 0.25 and dp_zf < 0.15,gs.gpflag=10,true)		
		AND IF(gs.gpflag=10,g1.zf < 0 and g1.dqj < g1.jj,true)
		AND IF(gs.gpflag=9,g1.dqj < g2.`jx_5`,true) 
		AND if(gs.gpflag<9,g1.dqj < g2.`jx_10`,true)
		AND IF(gs.gpflag<8,g1.dqj < g2.`jx_20`,true)	
		AND IF(gs.gpflag<7,g1.dqj < g2.`jx_30`,true)
		AND IF(gs.gpflag<1,g1.dqj < g2.`jx_60`,TRUE)				 												
		ORDER BY gs.gpflag desc LIMIT 0,1;           
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_cxg` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_cxg` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_cxg`(in_xh INTEGER)
BEGIN
         
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
            
	 /*强势股抄底2*/
	INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
                FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code`
                  AND in_cnt < 1
		  AND g.`ltsz` < 20 AND g1.`zf` >= 1.5 AND g1.`zf` < 3 AND g1.`cj_amt` > 0 
		  AND g2.`zf3` < 27
		  and g.syl < 100
		  AND g1.`dqj` < 70
		  AND (g.`hy` IN (SELECT hy FROM `行业排名6`) 
		  OR g.`code` IN (SELECT DISTINCT g.`gpcode` FROM gn2gp g WHERE g.`gn` IN (SELECT gn FROM `概念排名5`)))
		  ORDER BY (g2.`rsi_6`+g2.`rsi_12`+g2.`rsi_24`)LIMIT 0,1;  		
     
    
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_getgnztgps` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_getgnztgps` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_getgnztgps`(in_xh INTEGER)
BEGIN
                                                          
         DECLARE in_cnt INT;                
         SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
		
	 INSERT INTO qjsel SELECT 0,g2.`code`,in_xh,g2.dqj,g2.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),0 
		FROM gp g,gn2gp g1,gptoday g2,gpzfrec g3,ztgn 
		WHERE g.`code`=g1.`gpcode` AND g.`code`=g2.`code` AND g.`code`=g3.`code`
		  AND g1.`gn` = ztgn.gn 
		  AND in_cnt < 1 
		  AND g2.kpj > 0 		
		  AND g2.cj_amt > 0		  		
		  AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available` > 0)												
		  AND g2.zf > 1 AND g2.zf < 2
		  AND g.`ltsz` < 80	
		  and g.syl < 100	  
		  AND g2.dqj < 50		
		  AND g3.zf < 3													  		 
		  AND g3.`zf3` < 5		 	 		 	  				  	
		  ORDER BY g2.zf desc LIMIT 0,1;	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_gethyztgps` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_gethyztgps` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_gethyztgps`(in_xh INTEGER)
BEGIN
                                 
      DECLARE in_cnt INT;                     
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
       /**行业跟进*/
      INSERT INTO qjsel SELECT 0,g1.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 					
		  FROM gp,gptoday g1,gpzfrec g2,zthy h WHERE gp.`hy`=h.hy AND gp.`code` = g1.code AND gp.code=g2.code 		 
		  AND in_cnt < 1 
		  AND g1.code NOT IN (SELECT CODE FROM `xsjj$`)
		  AND g1.kpj > 0 		
		  AND g1.cj_amt > 0		 		
		  AND gp.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available` > 0)	
		  AND g1.zf > 0 AND g1.zf < 3
		  and gp.`ltsz` < 100	
		  AND gp.syl < 100	  
		  and g1.dqj < 50		
		  AND g2.zf < 3													  		  
		  AND g2.`zf3` < 5		  		 		 	  				  	
		  ORDER BY g1.zf desc LIMIT 0,1;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_gngj` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_gngj` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_gngj`(in_xh INTEGER)
BEGIN
    
      DECLARE avg_rsi_6 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_12 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_24 DOUBLE DEFAULT 60; 
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
	/**概念跟进*/
       INSERT INTO qjsel SELECT 0,gt.`code`,in_xh,gt.dqj,gt.zf,CONCAT(DATE_FORMAT(gt.`date`,'%Y-%m-%d'),' ',gt.`trantime`),g.`gn`
	 FROM gn2gp g,gnsta s,gp g1,gpzfrec g2,gnzfrec n,gn1,gptoday gt,hy1,gn,hy
	  WHERE g.`gn`=s.`gn` AND g.`gpcode`=g1.`code` AND g1.`code`=g2.`code` AND g2.`code`=gt.`code` AND g1.hy=hy1.`hy` AND hy1.`hy`=hy.`hy`
	  AND gn1.`code`=gn.`gn`
	  AND in_cnt < 1
	  AND g.`gn`=n.`gn` AND n.`gn`=gn1.`code` 	  
	  AND g1.`syl` < s.`syl` 
	  AND g1.`ltsz` < s.`ltsz`  
	  AND n.`zf` >= s.`gnzf`		
	  AND gn1.zf < s.`gnzr_zf`
	  AND gn1.`rsi6` < s.`rsi6` 
	  AND gt.`cj_amt` > 0 
	  AND gt.`dqj` > gt.`kpj`
	  AND gt.`dqj` < gt.`jrzgj`
	  AND gt.`dqj` < s.dqj
	  AND gt.`dqj` > gt.`jj`	    
	  AND (gt.kpj-gt.zrspj)/gt.`zrspj`*100 < 1	  
	  AND hy1.`rsi6` < s.`rsi6` AND hy1.`rsi12` < s.`rsi12` AND hy1.`rsi24` < s.`rsi24`
	  AND g2.`rsi_6` < s.`rsi6` AND g2.`rsi_12` < s.`rsi12` AND g2.`rsi_24` < s.`rsi24`	
	  AND g.`gn` NOT IN (SELECT DISTINCT p.type FROM POSITION p WHERE p.`available` > 0 AND p.`inxh` = 8)	
	  AND g1.code NOT IN (SELECT CODE FROM `xsjj$`)			 
	  AND g1.code NOT IN (SELECT p.code FROM POSITION p WHERE p.`available` > 0)	   
	  ORDER BY gn.`flag` DESC,gt.zf desc LIMIT 0,1;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_gn_top3_cd` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_gn_top3_cd` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_gn_top3_cd`(in_xh INTEGER)
BEGIN
                             
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
            
	 /*强势股抄底2*/
	INSERT INTO qjsel SELECT distinct 0,g1.`code`,in_xh,g2.dqj,g1.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),0 
                FROM gn2gp g,gp g1,gptoday g2,gpzfrec g3,gn WHERE g.`gpcode`=g1.`code` AND g.`gn`=gn.`gn`
		AND g1.`code`=g2.`code` AND g1.`code`=g3.`code` AND gn.`flag` >=3  
		AND g2.`cj_amt` > 0
		AND g1.`ltsz` < 100 AND g1.`syl` < 50
		AND in_cnt < 3                          
		AND g2.kpj > 0 
		AND g2.cj_amt > 0		
		AND g2.dqj > 0						
		AND g2.zf < 1
		AND g3.zf30 > 10					
		AND g3.zf30 < 30																		
		AND g1.code NOT IN (SELECT CODE FROM `xsjj$`)		     
		AND g1.code NOT IN (SELECT p.code FROM `position` p WHERE p.available > 0) 
		AND g2.zrspj > 0	 			
		AND g2.zrspj < g3.`jx_5` 
		AND g2.zrspj < g3.`jx_10`
		AND g2.zrspj < g3.`jx_20`	
		AND (g2.zrspj < g3.`jx_30`*1.01 OR g2.dqj < g3.jx_30*1.01 OR g2.`jrzdj` < g3.jx_30*1.01)				 												
		ORDER BY gn.`flag` desc LIMIT 0,1;         
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_hygj` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_hygj` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_hygj`(in_xh INTEGER)
BEGIN
    
      DECLARE avg_rsi_6 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_12 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_24 DOUBLE DEFAULT 60; 
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
	 /**行业跟进*/
       INSERT INTO qjsel SELECT 0,gt.`code`,in_xh,gt.dqj,gt.zf,CONCAT(DATE_FORMAT(gt.`date`,'%Y-%m-%d'),' ',gt.`trantime`),''
	  FROM hysta s,gp g1,gpzfrec g2,hyzfrec n,hy1,gptoday gt,hy
	  WHERE g1.`hy`=s.`hy` AND g1.`code`=g2.`code` AND g2.`code`=gt.`code` AND hy1.`hy`=hy.`hy` 
	  AND in_cnt < 1
	  AND s.flag = 0
	  AND s.`hy`=n.`hy` AND n.hy=hy1.`hy`
	  AND g1.`syl` < s.`syl` 
	  AND g1.`ltsz` < s.`ltsz`  
	  AND n.`zf` >= s.`hyzf`
          AND hy1.`rsi6` < s.`rsi6`	 
	  AND hy1.`zf` < s.`hyzr_zf`
	  AND gt.`cj_amt` > 0 
	  AND gt.`dqj` > gt.`kpj`
	  AND gt.`dqj` < gt.`jrzgj`
	  AND gt.`dqj` < s.dqj
	  AND gt.`dqj` > gt.`jj`	 	 	  
	  AND (gt.kpj-gt.zrspj)/gt.`zrspj`*100 < 2
	  AND g2.`rsi_6` < s.`rsi6` AND g2.`rsi_12` < s.`rsi12` AND g2.`rsi_24` < s.`rsi24`		 
	  AND g1.code NOT IN (SELECT CODE FROM `xsjj$`)	
	  AND g1.hy NOT IN (SELECT hy FROM 买入行业)	 		 
	  AND g1.code NOT IN (SELECT p.code FROM POSITION p WHERE p.`available` > 0)	   
	  ORDER BY hy.`qz` DESC,gt.zf desc LIMIT 0,1;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_hy_top3_cd` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_hy_top3_cd` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_hy_top3_cd`(in_xh INTEGER)
BEGIN
                             
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
            
      /*强势股抄底2*/
      INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
                FROM gp g,gptoday g1,gpzfrec g2,hy WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` AND g.`hy`=hy.`hy`
		AND g.`syl` < 40 AND g.`ltsz` < 100  AND hy.`qz` >=3 
		AND in_cnt < 3                          
		AND g1.kpj > 0 
		AND g1.cj_amt > 0		
		AND g1.dqj > 0						
		AND g1.zf < 1	
		AND g2.zf30 > 10				
		AND g2.zf30 < 30																		
		AND g.code NOT IN (SELECT CODE FROM `xsjj$`)		     
		AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.available > 0) 
		AND g1.zrspj > 0	 			
		AND g1.zrspj < g2.`jx_5` 
		AND g1.zrspj < g2.`jx_10`
		AND g1.zrspj < g2.`jx_20`	
		AND (g1.zrspj < g2.`jx_30`*1.01 OR g1.dqj < g2.jx_30*1.01 OR g1.`jrzdj` < g2.jx_30*1.01)				 												
		ORDER BY hy.`qz` desc LIMIT 0,1;         
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_jqhot` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_jqhot` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_jqhot`(in_xh INTEGER)
BEGIN
        
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
	/*近期热点*/
       INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),r.dl 
	FROM
	  hyref r,
	  gp g,
	  gptoday g1,
	  gpzfrec g2,
	  hy
	WHERE 
	  in_cnt < 1	
	  AND r.`dl` IN (SELECT dl FROM `大热点` WHERE dl NOT IN ('zr','jr','jg'))
	  AND r.`xl` = g.`hy` 
	  AND g.`code` = g1.`code` 
	  AND g.`code` = g2.`code` 
	  AND g.hy = hy.`hy`
	  AND g1.`cj_amt` > 0 	  	
	  AND g1.`dqj` < 60     	 	 	
	  AND g2.zf < 3	 	  			 
	  AND g1.zf > 1.5
	  AND g1.zf < 3	
	  AND (g1.kpj-g1.zrspj)/g1.`zrspj`*100 < 2	   
	  AND g.code NOT IN (SELECT p.code FROM POSITION p WHERE p.`available` > 0)	 
	  AND g.code NOT IN (SELECT CODE FROM `xsjj$`)		  	 	 	  
	  ORDER BY hy.`qz` DESC,(g2.`rsi_6`+g2.`rsi_12`+g2.`rsi_24`) LIMIT 0,1;  
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_ldg` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_ldg` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_ldg`(in_xh INTEGER)
BEGIN
          
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
      /*龙头股*/ 
      INSERT INTO qjsel SELECT DISTINCT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` AND g.`code`=g1.`code` AND g.`code`=g2.`code`                 
                and gs.`gn` <> 'zs'                                        
		AND g1.kpj > 0 
		AND in_cnt < 1
		AND g1.cj_amt > 0
		AND g1.dqj > g1.`jj`	
		AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0)		
		AND g.code NOT IN (SELECT CODE FROM `xsjj$`)										
		AND g1.dqj < g1.jrzgj
		AND g2.zf < 3
		AND g1.zf > 1.5		
		AND (g1.kpj-g1.zrspj)/g1.`zrspj`*100 < 2							
		ORDER BY gs.`gpflag` desc,(g2.`rsi_6`+g2.`rsi_12`+g2.`rsi_24`)
		LIMIT 0,1;           
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_plan` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_plan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_plan`(in_xh INTEGER)
BEGIN
         
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
       /**投资计划*/
       INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g2.dqj,g2.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),'0'
	 FROM gp g,gpzfrec g1,gptoday g2,投资计划 j,gpsel WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` AND g.code=j.code
	 and j.cls=gpsel.`gn` and g.code=gpsel.`code`
	 AND in_cnt < 1		 
	 AND g2.`cj_amt` > 0 	  
	 AND g2.`dqj` < 60 
	 and g2.zf < 0		
	 AND g2.zrspj > 0	 			
	 AND g2.zrspj < g1.`jx_5` 		
	 and g.ltsz < 100
	 and g.syl < 80				 													
	 AND g.code NOT IN (SELECT CODE FROM `xsjj$`)	
	 AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0)	 	 		 		 	  	
	 ORDER BY j.qz desc,g.ltsz LIMIT 0,1; 
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_todayhot` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_todayhot` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_todayhot`(in_xh INTEGER)
BEGIN
         
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
	/*今日概念*/
       INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g3.dqj,g3.zf,CONCAT(DATE_FORMAT(g3.`date`,'%Y-%m-%d'),' ',g3.`trantime`),0 
		 FROM `当日题材` g1,gp g,gpzfrec g2,gptoday g3 WHERE g1.`code`=g.`code` AND g.`code`=g2.`code` AND g2.`code`=g3.`code`
		 AND in_cnt < 1				 
		 AND g2.`zf` < 3 			 		
		 AND g.code NOT IN (SELECT p.code FROM POSITION p WHERE p.`available` > 0)		 
		 AND g.code NOT IN (SELECT CODE FROM xsjj)		 
		 AND g3.zf > 1.5
		 AND g3.zf < 3
		 AND g2.zf30 < 10
		 AND g3.dqj > g3.jj
		 AND g3.`dqj` > g3.`kpj`		 				
		 AND (g3.kpj-g3.zrspj)/g3.`zrspj`*100 < 2				 
		 AND g3.dqj < 60			 					 			
		 ORDER BY g1.qz,(g2.`rsi_6`+g2.`rsi_12`+g2.`rsi_24`) LIMIT 0,1;  	     
    
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_zqg` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_zqg` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_zqg`(in_xh INTEGER)
BEGIN
         
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
	/**合约套利*/
       INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),'0'
	 FROM `合约排名股票1` g,gpzfrec g2,gptoday g1,gp g3 WHERE g.`code`=g2.`code` AND g2.`code`=g1.`code` AND g1.`code`=g3.`code`	 
	  AND in_cnt < 1	 
	  AND g1.`cj_amt` > 0 	  
	  AND g1.`dqj` < 70	
	  AND g1.`dqj` > g1.`jj`  
	  AND g1.dqj < g1.`jrzgj`	 
	  AND g2.zf < 3
	  AND g1.`zf` > 1.5
	  AND g1.`zf` < 3		 	   	 
	  AND (g1.kpj-g1.zrspj)/g1.`zrspj`*100 < 2	 
	  AND g3.code NOT IN (SELECT CODE FROM `xsjj$`)		  	
	  AND g3.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0) 	 	  	 
	  ORDER BY g3.ltsz LIMIT 0,1;	  
	
      /**周期股跟进1*/
      INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),'0'
	    FROM gp g,gptoday g1,gpzfrec g2 WHERE g.code=g2.`code` AND g2.`code`=g1.`code` 
	    AND in_cnt < 1
	    AND g.`hy` IN ('有色冶炼加工','煤炭开采','钢铁') AND get_gp_hey_zfc('',g.`hy`) = 1 	    	    
	    AND g1.`jrzgj` > g1.kpj 
	    AND g1.`zf` > 1.5   
	    AND g2.zf < 3	  
	    AND g.code NOT IN (SELECT CODE FROM `xsjj$`)	   
	    AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0) 
	    AND (g1.kpj-g1.zrspj)/g1.`zrspj`*100 < 2
	    AND (g2.`zt_bar_num` = 0 OR g2.zt_bar_num > 7)	    	 
	    AND g1.`dqj` > g1.`jj` 
	    AND g1.dqj < g1.`jrzgj` 	    	    	
	    ORDER BY g.ltsz LIMIT 0,1;
	
      /**周期股跟进2*/
      INSERT INTO qjsel SELECT 0,g2.`code`,in_xh,g4.dqj,g4.zf,CONCAT(DATE_FORMAT(g4.`date`,'%Y-%m-%d'),' ',g4.`trantime`),'0'
		FROM gpzfrec g,hey h,gptoday g1,heyref h1,gp g2,gpzfrec g3,gptoday g4 WHERE 
		in_cnt < 1		
		AND LOCATE('.',g.`code`) > 0 AND h.`code`=h1.`hey` 
		AND h.`slcode`=g1.`code` AND g.`code`=h.`code` 				
		AND g.`code` NOT IN ('SHSE.000016')
		AND g1.zf >= 1.5 AND CONCAT(h1.`gps`,h1.`lt`) IS NOT NULL
		AND LOCATE(g2.`name`,CONCAT(h1.`gps`,h1.`lt`)) > 0 
		AND g2.`code`=g3.`code`
		AND g3.`code`=g4.`code`		
		AND (g1.kpj-g1.zrspj)/g1.`zrspj`*100 < 2	
		AND g2.code NOT IN (SELECT CODE FROM `xsjj$`)		
		AND g2.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0) 		
		AND g4.`cj_amt` > 0			  			
		AND g4.zf > 1.5 
		AND g4.zf < 3
		AND g4.`dqj` > g4.`jj`
		AND g4.dqj < g4.`jrzgj`
		AND g3.`zf` < 3
		AND g3.`zf2` < 10				
		ORDER BY g2.ltsz;	     
    
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_zqg_cd` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_zqg_cd` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_zqg_cd`(in_xh INTEGER)
BEGIN
         
      DECLARE in_cnt INT;    
      
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
           
	/**合约套利*/
       INSERT INTO qjsel SELECT 0,g.`code`,in_xh,g.dqj,g.zf,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`),'0'
	 FROM gptoday g,hey h,gpzfrec g1,heyref h1,gp,gptoday gt,gpzfrec g2 
	       WHERE `g`.`code` = `h`.`slcode` 
	       AND `h`.`code` = `h1`.`hey` 	      
	       AND `h`.`code` = `g1`.`code` AND h1.lt=gp.`name`    
	       AND in_cnt < 3  
	       AND h.`code1` IN ('ZC','JM','RB','JD','AL','CU')	       	      
	       and gp.`code`=gt.code and gp.`code`=g2.code
	       AND g.`dqj` <= g1.`low_5`  
	       and gt.dqj <= g2.`low_3`
	       LIMIT 0,1;	  
	    
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cl_zxp` */

/*!50003 DROP PROCEDURE IF EXISTS  `cl_zxp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_zxp`(sz_50_zf DOUBLE,cyb_zf DOUBLE,dp_zf DOUBLE,
							dc_flag INT,in_xh int,in_mode int)
BEGIN
     
      DECLARE cyb_zr_zf DOUBLE;                    
      DECLARE in_cnt INT;    
      
      SELECT MAX(g.`zf`) INTO cyb_zr_zf FROM gpzfrec g WHERE g.`code` = '399006';       
      SELECT COUNT(p.code) INTO in_cnt FROM POSITION p WHERE  p.`available` > 0 AND p.`inxh` = in_xh; 
                             
      /*中小板*/ 
      INSERT INTO qjsel SELECT DISTINCT 0,g.`code`,in_xh,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` AND g.`code`=g1.`code` AND g.`code`=g2.`code`  
                AND in_cnt < 1                
                and gs.`gn` <> 'zs'  and gs.`zbflag` in (1,2)                                     
		AND g1.kpj > 0 		
		AND g1.cj_amt > 0
		and cyb_zr_zf < 1.2
		and dc_flag = 0			
		AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available` > 0)												
		AND g1.zf > 1 and g1.zf < 2
		AND g2.zf < 3 and g2.zf > -9
		and g2.`zf30` < 20
		and g2.`zf3` < 5
		and g2.`rsi_6` < 80 and g2.`rsi_12` < 80
		AND ((sz_50_zf < -0.1 and cyb_zf > 0.18) || dp_zf > 0.15)
		AND sz_50_zf < cyb_zf
		AND TIME_TO_SEC(g1.`trantime`) < if(in_mode=1,TIME_TO_SEC("14:52:00"),TIME_TO_SEC("22:31:00")) 
		ORDER BY g.ltsz LIMIT 0,1;       
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `comm_proc` */

/*!50003 DROP PROCEDURE IF EXISTS  `comm_proc` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `comm_proc`()
BEGIN
    
	/**行业涨幅  */   
        TRUNCATE hyzfrec;     
        INSERT INTO hyzfrec SELECT 0,hy,zf,NOW() FROM 今日行业涨幅;	 
         	      
        /**概念涨幅**/	     
        TRUNCATE gnzfrec;
        INSERT INTO gnzfrec SELECT 0,gn,gnzf,NOW() FROM 热点排序;	 
                          
        /**浮动盈亏**/  
        UPDATE `position` SET sumzf=((SELECT dqj FROM gptoday WHERE position.`code`= gptoday.`code`)-position.`vwap`)/position.`vwap`*100
		WHERE available > 0; 		     	
             
        TRUNCATE qjsel; 
        
        commit;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `copy_day_his` */

/*!50003 DROP PROCEDURE IF EXISTS  `copy_day_his` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `copy_day_his`()
BEGIN   
         DECLARE v_cur_date date default get_tran_date();
         declare cnt int default 0;
               
	 delete from gpsinahis where date = v_cur_date;
	 COMMIT;
	 
	 INSERT INTO gpsinahis SELECT * FROM gptoday;	 	
	 
     commit;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `copy_to_gpsel` */

/*!50003 DROP PROCEDURE IF EXISTS  `copy_to_gpsel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `copy_to_gpsel`()
BEGIN
DECLARE limit_cnt INTEGER DEFAULT 210;  
	
	DECLARE gpcodes TEXT;         
        
        DELETE FROM gpsel;                
        
        INSERT INTO gpsel SELECT DISTINCT NULL,g.code,g.name,-1 flag,NOW() FROM qjsel q,gp g
		WHERE q.code=g.code 		
						
		ORDER BY g.ltsz,g.syl LIMIT 0,limit_cnt;    
		
         SELECT GROUP_CONCAT(DISTINCT g.`code`) INTO gpcodes  FROM gpsel g,gptoday g2 WHERE g.code=g2.code AND g2.cj_amt >0 LIMIT 0,limit_cnt;
		
         UPDATE `stratey` SET gpcodes = gpcodes;    
         commit;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `end_stratey` */

/*!50003 DROP PROCEDURE IF EXISTS  `end_stratey` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `end_stratey`()
BEGIN
DECLARE cnt integer DEFAULT 0; 
select count(*) into cnt from POSITION;
IF (cnt > 0) THEN
	UPDATE `position` SET sumzf=((SELECT dqj FROM gptoday WHERE position.`code`= gptoday.`code`)-position.`vwap`)/position.`vwap`*100
	       WHERE available > 0;
	commit;
	  
	DELETE FROM position_prd;
	INSERT INTO position_prd SELECT * FROM POSITION;  
	DELETE FROM position_prd WHERE available = 0;
END IF;
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `end_trans_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `end_trans_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `end_trans_process`()
BEGIN   
        call gp_data_init();
            
    END */$$
DELIMITER ;

/* Procedure structure for procedure `every_10_sec_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `every_10_sec_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `every_10_sec_process`()
BEGIN
        select now();
    END */$$
DELIMITER ;

/* Procedure structure for procedure `every_1_miu_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `every_1_miu_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `every_1_miu_process`()
BEGIN           
        call `syn_store`();
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_all_gn_codes` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_all_gn_codes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_gn_codes`()
BEGIN                 
        
        declare p_cnt integer default 0;
        DECLARE p_gn VARCHAR(20);     
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT DISTINCT g.`gn` FROM gn g,gn2gp g1 
                  WHERE g.`gn`=g1.`gn` AND g.`flag` >= 3 ORDER BY g.`flag` DESC;
        
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;   
	
	delete from gpsel;    	
				
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_gn;
	     WHILE b<>1 DO            	     	        
	     	   	     	 
	     	     CALL get_gn_codes(p_gn);      	     	   				
		                                 		 		
	       FETCH feeCodeCursor INTO p_gn; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                        
          UPDATE `stratey` SET gpcodes = (SELECT GROUP_CONCAT(g.code) FROM gpsel g);               
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_all_hy_codes` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_all_hy_codes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_hy_codes`()
BEGIN                 
        
        declare p_cnt integer default 0;
        DECLARE p_hy VARCHAR(80);     
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT DISTINCT g.`hy` FROM gp g WHERE g.`hy` NOT IN ('上证','道琼斯') 
		AND g.`hy` IS NOT NULL ORDER BY g.hy;
                
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;   
	
	delete from gpsel;    	
				
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_hy;
	     WHILE b<>1 DO            	     	        
	     	   	     	 
	     	     CALL get_hy_codes(p_hy);      	     	   				
		                                 		 		
	       FETCH feeCodeCursor INTO p_hy; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                        
          UPDATE `stratey` SET gpcodes = (SELECT GROUP_CONCAT(distinct g.`code`) FROM gpsel g);               
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_comm_gn_sel` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_comm_gn_sel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comm_gn_sel`(in_gn varchar(40))
BEGIN
    
SELECT g5.`code`,g5.`name`,g4.`zf`,gs.`rsi_6`,gs.`rsi_12`,gs.`tp_bar_num`,gs.`pj_30_zhengfu`,g4.`dqj`,g5.`ltsz`,
ROUND((((`g5`.`zsz` - `g5`.`ltsz`) / `g5`.`zsz`) * 100),2) AS `ltzb`,g5.`syl`
FROM gpzfrec gs,gp g5,gptoday g4 WHERE gs.`code`=g5.code AND g5.`code`=g4.`code`
AND gs.`code` IN (
SELECT DISTINCT t.code FROM (SELECT g1.`gpcode` CODE,g1.`gpname` NAME FROM gn g,gn2gp g1 WHERE g.`gn`=g1.`gn` AND g.`gnname` LIKE CONCAT('%',CONCAT(in_gn,'%'))
 UNION ALL
SELECT g.`code`,g.`name` FROM gp g WHERE g.`hy` LIKE concat('%',CONCAT(in_gn,'%'))) t) AND gs.`rsi_6` < 60 AND gs.`rsi_12` < 60
AND g4.`zf` <> -100 AND g4.`zf` <> 0 
AND ROUND((((`g5`.`zsz` - `g5`.`ltsz`) / `g5`.`zsz`) * 100),2) < 20
AND g4.`dqj` < 50 ORDER BY gs.`pj_30_zhengfu` DESC LIMIT 0,5;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_gn_codes` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_gn_codes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_gn_codes`(in gn integer)
BEGIN                 
        
        declare p_date date;
        DECLARE p_code VARCHAR(20);  
        DECLARE p_name VARCHAR(20);       
          
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT DISTINCT g.`gpcode`,g.`gpname` FROM `热点排序` gn,gn2gp g,gp g1,gptoday g3
          WHERE gn.`gn`=g.`gn` and g.gpcode=g1.code and g1.code=g3.code AND g.gn=gn and g1.ltsz < 120 and g1.mgsy>0.01 
          AND g1.`code` NOT IN (SELECT CODE FROM gpsel) and g1.code not in (select code from `限售解禁`) 
          AND g1.code NOT IN (SELECT gpcode FROM 黑天鹅) and g3.zf > -4 and g3.zf <=8
          order by g1.ltsz,g1.syl limit 0,10;
               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;       	
	set p_date = get_tran_date();				
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code,p_name;
	     WHILE b<>1 DO            	     	        
	     	
		INSERT INTO gpsel (CODE,NAME,flag,DATE) VALUES (p_code,p_name,-1,p_date);   
		
		                                      		 		
	       FETCH feeCodeCursor INTO p_code,p_name; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                        
                         
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_hy_codes` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_hy_codes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_hy_codes`(in hy VARCHAR(80))
BEGIN                 
        
        declare p_date date;
        DECLARE p_code VARCHAR(20);  
        DECLARE p_name VARCHAR(20);       
          
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT DISTINCT g.`code`,g.`name` FROM gp g,gptoday g1  
          WHERE g.code=g1.code and g.hy=hy AND g.ltsz <= 120 and g.mgsy >=0.01 and g1.dqj < 40 
          AND g.code NOT IN (SELECT CODE FROM `限售解禁`)
          AND g.code NOT IN (SELECT gpcode FROM `黑天鹅`)
          ORDER BY g.ltsz asc limit 0,3;
               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;       	
	set p_date = get_tran_date();				
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code,p_name;
	     WHILE b<>1 DO            	     	        
	     	
		INSERT INTO gpsel (CODE,NAME,flag,DATE) VALUES (p_code,p_name,-1,p_date);   
				                                      		 	
	       FETCH feeCodeCursor INTO p_code,p_name; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                        
                         
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `gn_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `gn_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `gn_total`()
BEGIN
DECLARE t_date date DEFAULT get_tran_date(); 
DELETE FROM gnzfhis WHERE DATE=t_date;
INSERT INTO gnzfhis SELECT 0 id,gn,gnzf,DATE FROM `热点排序`;
DELETE FROM gnzfrec;
INSERT INTO gnzfrec SELECT 0,gn,0,SUM(h.`zf`) zf5,'',t_date FROM gnzfhis h GROUP BY gn;
UPDATE gnzfrec SET zf=(SELECT zf FROM gnzfhis WHERE gnzfhis.gn=gnzfrec.gn AND gnzfhis.`date`=t_date),zfrec=(
SELECT GROUP_CONCAT(zf_convert(gnzfhis.zf) ORDER BY gnzfhis.`date` ASC  SEPARATOR '')
		FROM gnzfhis where gnzfhis.`gn`=gnzfrec.`gn`
		GROUP BY gnzfhis.gn );
		
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `gp_data_init` */

/*!50003 DROP PROCEDURE IF EXISTS  `gp_data_init` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `gp_data_init`()
BEGIN      
                 		 
	 DECLARE v_date DATETIME default  get_tran_date();     	 	
	 
	 /*历史表值保留1一个月*/
	 DELETE FROM gpsinahis WHERE `date` < DATE_SUB(v_date,INTERVAL 3 MONTH); 	 	
         
         DELETE FROM gpsinahis WHERE gpsinahis.`date` = v_date;
         INSERT INTO gpsinahis SELECT 0 id,`code`, `kpj`, `dqj`, `zrspj`, `jrzgj`, `jrzdj`, `cj_num`, `cj_amt`, `zf`, `zhengf`, `jj`, `hsl`, `tr`, `date` FROM gptoday;  
         		               	                                                           
         INSERT INTO gplog (logstr,date) values ('gp_data_init doing..',now());                                   
                                                   
         COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `gp_sel_time_init` */

/*!50003 DROP PROCEDURE IF EXISTS  `gp_sel_time_init` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `gp_sel_time_init`()
BEGIN                 
        
        
        DECLARE p_code VARCHAR(20);   
        declare p_zb integer default 0;   
      
         
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT CODE FROM gpsel WHERE flag = -2 limit 1,10;
        
       
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;       	
		
			
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code;
	     WHILE b<>1 DO            	     	        
	     
	        			
		CALL jj_time_record(p_code);	
			       
	        UPDATE gptimehis SET jj= (`totalcje`-`sumcje`+cje)/((`totalcjl`-`sumcjl`+cjl)*100) WHERE CODE=p_code; 	
	        
	        update gpsel set flag=-3 where code = p_code;		
                                       		 		 
	       FETCH feeCodeCursor INTO p_code; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
              
         call jx_time_total();
         select total into p_zb from gpparam;     
         
         /** 删除不好的*/
         update gpsel set flag=-99 WHERE CODE IN (SELECT t.`code` FROM gptimetotal t,gptoday g WHERE t.code=g.code and g.zf >=0 and t.`zb`<=p_zb);      
         
         INSERT INTO gpbuy SELECT g.`code`,0,NOW() FROM gpsel s,gp g 
                WHERE s.`code`=g.`code` and s.flag <> -99 and s.code not in (select code from gpbuy) ORDER BY g.syl LIMIT 0,5;
          
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `gp_sort` */

/*!50003 DROP PROCEDURE IF EXISTS  `gp_sort` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `gp_sort`(in lev integer)
BEGIN
    declare v_sql varchar(500);    /*需要执行的SQL语句*/
     
     if (lev = 7) then
         SET v_sql= 'SELECT * FROM `涨跌幅排行` s WHERE s.zf >9 ';
     elseif (lev = 6) THEN
        SET v_sql= ' SELECT * FROM `涨跌幅排行` s WHERE s.zf<=9 AND s.zf >=7 '; 
     ELSEIF (lev = 5) THEN
        SET v_sql= ' SELECT * FROM `涨跌幅排行` s WHERE s.zf<7 AND s.zf >=5'; 
     ELSEIF (lev = 4) THEN
        SET v_sql= 'SELECT * FROM `涨跌幅排行` s WHERE s.zf<5 AND s.zf >=3';  
      ELSEIF (lev = 3) THEN
        SET v_sql= 'SELECT * FROM `涨跌幅排行` s WHERE s.zf<3 AND s.zf >=1';       
      ELSEIF (lev = 2) THEN
        SET v_sql= 'SELECT * FROM `涨跌幅排行` s WHERE s.zf<1 AND s.zf >=0 AND s.jj >0';       
       ELSEIF (lev = 1) THEN
        SET v_sql= 'SELECT * FROM `涨跌幅排行` s WHERE s.zf<0 AND s.zf >-2';  
       else
       SET v_sql= 'SELECT * FROM `涨跌幅排行` s ';     
     end if;
    
     set @v_sql=v_sql;   /**--注意很重要，将连成成的字符串赋值给一个变量（可以之前没有定义，但要以@开头）**/
     prepare stmt from @v_sql;  /**--预处理需要执行的动态SQL，其中stmt是一个变量**/
     EXECUTE stmt;      /**--执行SQL语句**/
     
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hb_all_sell_gp` */

/*!50003 DROP PROCEDURE IF EXISTS  `hb_all_sell_gp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hb_all_sell_gp`()
BEGIN                 
                
        DECLARE p_code VARCHAR(20);       
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT code from gpsell;
               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;
       				
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code;
	     WHILE b<>1 DO            	     	        
	     	        		
		CALL hb_sell_gp(p_code);				
                                       		 		 
	       FETCH feeCodeCursor INTO p_code; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                                   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hb_sell_gp` */

/*!50003 DROP PROCEDURE IF EXISTS  `hb_sell_gp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hb_sell_gp`(IN gpcode CHAR(10))
BEGIN
    
    DECLARE v_maxId INT DEFAULT 0; 
    
    INSERT INTO gpsell 
	SELECT 0 id, gpcode CODE,SUM(s.`num`*s.`dqj`) amt,SUM(s.`num`) num
	,AVG(s.`cbj`) cbj
	,AVG(s.`dqj`) dqj,
	SUM(s.`num`*s.`dqj`-s.`num`*s.`cbj`) fdyk,
	SUM(s.`num`*s.`dqj`-s.`num`*s.`cbj`)/SUM(s.`num`*s.`cbj`)*100 ykl
	,AVG(s.`dp`) dp,
	0 flag,NOW() buydate,NOW() DATE FROM gpsell s WHERE s.`code`=gpcode;
    
    
    SELECT MAX(id) into v_maxId FROM gpsell WHERE CODE = gpcode;
    
    DELETE FROM gpsell WHERE CODE = gpcode AND id < v_maxId;
    
    commit;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hg_sta_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `hg_sta_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hg_sta_total`(in gpcode char(20))
BEGIN
	DECLARE v_tr DECIMAL(10,2) default 0; 
        DECLARE v_n DECIMAL(10,2) DEFAULT 0;      
        DECLARE v_pdn DECIMAL(10,2) DEFAULT 0; 
        DECLARE v_pv DECIMAL(10,2) DEFAULT 0; 
        DECLARE v_dw DECIMAL(10,2) DEFAULT 0; 
        
        DECLARE v_amt DECIMAL(10,2) DEFAULT 0;
        
        DECLARE v_date date;
        DECLARE v_cnt integer default 0;
        
        set v_date = get_tran_date();
        
        SELECT count(h.n) INTO v_cnt FROM hgsta h WHERE h.`code` = gpcode and h.caldate=v_date;
        
        IF (v_cnt = 0) THEN
           
		SELECT h.n INTO v_pdn FROM hgsta h WHERE h.`code` = gpcode;        		
					
		select j.atr into v_n from gpjx j where j.code = gpcode;
		
		IF (v_pdn = NULL OR v_pdn <= 0) THEN
		   set v_pdn = v_n;
		END IF;
		
		SELECT t.tr INTO v_tr FROM gptoday t WHERE t.code = gpcode;
		
		SELECT t.`dqj`*100 into v_pv FROM gptoday t WHERE t.code = gpcode;
		
		SELECT s.`zjye`*s.syl/100 into v_amt FROM store s;
		
		/**
		 单位大小=(0.01×1,000,000)/(0.0141×42,000)=16.88 
		*/
		set v_dw = (0.01*v_amt)/(v_n*v_pv);
		
		INSERT INTO hgsta (CODE,tr,pdn,n,pv,dw,caldate) VALUES (gpcode,ifnull(v_tr,0),ifnull(v_pdn,0),ifnull(v_n,0),ifnull(v_pv,0),ifnull(v_dw,0),v_date);
		
		commit;
		
           
        END IF;
       
        
        
        
        
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hsl_update` */

/*!50003 DROP PROCEDURE IF EXISTS  `hsl_update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hsl_update`(in_code CHAR(10))
BEGIN
           	
	DECLARE v_hsl DECIMAL(8,2); 
	DECLARE v_id varchar(40); 
        
        SELECT h.cj_amt/g.ltsz*100,h.id INTO v_hsl,v_id FROM gp g,gptoday h 
           WHERE g.code = h.code AND g.code=in_code and h.date = get_tran_date();
	         
	UPDATE gptoday SET hsl=v_hsl WHERE CODE = in_code AND id=v_id;     		
                                   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hsl_update_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `hsl_update_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hsl_update_all`()
BEGIN                 
        
        
        DECLARE p_code VARCHAR(20);       
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT code from gp g where g.code not in ('int_dji','sh000001','sz399001','sz399006');
        
       
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;
       
	
			
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code;
	     WHILE b<>1 DO            	     	        
	     
	        			
		CALL hsl_update(p_code);
		
		
                                       		 		 
	       FETCH feeCodeCursor INTO p_code; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		
                                   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hy_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `hy_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hy_total`()
BEGIN
DECLARE t_date date DEFAULT get_tran_date(); 
DELETE FROM hyzfhis WHERE DATE=t_date;
INSERT INTO hyzfhis SELECT 0 id,t_date d,hy,zf FROM 今日行业涨幅;
DELETE FROM hyzfrec;
INSERT INTO hyzfrec SELECT 0,hy,0,SUM(h.`zf`) zf5,'',t_date FROM hyzfhis h GROUP BY hy;
UPDATE hyzfrec SET zf=(SELECT zf FROM hyzfhis WHERE hyzfhis.`hy`=hyzfrec.`hy` AND hyzfhis.`date`=t_date),zfrec=(
SELECT GROUP_CONCAT(zf_convert(hyzfhis.zf) ORDER BY hyzfhis.`date` ASC  SEPARATOR '')
		FROM hyzfhis where hyzfhis.`hy`=hyzfrec.`hy`
		GROUP BY hyzfhis.hy );
		
call gn_total();	
	
commit;		
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `import_today_gns` */

/*!50003 DROP PROCEDURE IF EXISTS  `import_today_gns` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `import_today_gns`(gpid integer)
BEGIN
        
        DECLARE cnt INT DEFAULT 0; 
        SELECT count(1) into cnt FROM gntoday$ g WHERE INSTR(g.`股票代码`,'.SH') >0 OR INSTR(g.`股票代码`,'.SZ') >0; 
        
        if (cnt >0) then		
	        UPDATE `gntoday$` SET 股票代码=REPLACE(REPLACE(股票代码,'.SH',''),'.SZ','');
		UPDATE `gntoday$` SET 股票代码=CONCAT(IF(SUBSTRING(股票代码,1,1)=6,'sh','sz'),股票代码);		
        end if;
        
        DELETE FROM gn2gp WHERE gn = gpid;	
		
	INSERT INTO gn2gp SELECT distinct 0 id,gpid gn, 股票代码 gpcode,股票简称 gpname FROM gntoday$;
	
	delete from gntoday$;
	
	commit;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `imp_gn_data` */

/*!50003 DROP PROCEDURE IF EXISTS  `imp_gn_data` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `imp_gn_data`(in i_gn integer,IN i_gnname VARCHAR(200))
BEGIN
DELETE FROM gn WHERE gn.`gn`=i_gn;
DELETE FROM gn2gp WHERE gn=i_gn;
INSERT INTO gn(gn,gnname) VALUE (i_gn,i_gnname);
INSERT INTO gn2gp (gn,gpname) SELECT i_gn, 名称 FROM `概念股票$`;
UPDATE gn2gp SET gpcode=(SELECT gp.`code` FROM gp WHERE gp.`name`=gn2gp.`gpname`) WHERE gn = i_gn;
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `imp_pa_cw` */

/*!50003 DROP PROCEDURE IF EXISTS  `imp_pa_cw` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `imp_pa_cw`()
BEGIN
	DECLARE t_date DATE ;
	DECLARE t_num int ;
	
	set @dt = now();
	select date_add(@dt, interval -1 day) into t_date; 
	
	SELECT COUNT(0) INTO t_num FROM 资金股份查询$;
	
	IF (t_num > 0) THEN		            
        
		UPDATE 资金股份查询$ SET 备注=(SELECT inxh FROM `position` WHERE position.`code`=资金股份查询$.`证券代码`);
		
		DELETE FROM `position`;	
		DELETE FROM `position_prd`;
		INSERT INTO POSITION SELECT `证券代码`,t_date,NULL,IFNULL(备注,10), `当前拥股`,`当前拥股`,
			`成本价`,`成本价`,`浮动盈亏`,`盈亏比例(%)`,`盈亏比例(%)`,NULL,0,0,'0' FROM `资金股份查询$` WHERE `当前拥股` > 0;
			
		UPDATE POSITION SET inxh=17 WHERE inxh=0;
		update POSITION set `available_today` = 0;		
					
		INSERT INTO position_prd SELECT * FROM POSITION;
	END IF;	
		
	
	
	commit;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `init_stratey` */

/*!50003 DROP PROCEDURE IF EXISTS  `init_stratey` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `init_stratey`(in_mode integer)
BEGIN
DECLARE gpcodes TEXT;  
declare g_num int;
DECLARE t_date DATE default get_tran_date();  
DELETE FROM POSITION;
IF (in_mode = 2) THEN
UPDATE position_prd SET available_today = 0;
INSERT INTO POSITION SELECT * FROM position_prd WHERE DATE(indate)<=DATE(NOW());
end if;
DELETE FROM gpyaohhis;
DELETE FROM gpjxhis; 
TRUNCATE jjlog;
TRUNCATE tranhis;
UPDATE store SET gpsz=IFNULL((SELECT SUM(available*vwap) FROM POSITION),0),zjye=total-gpsz,ykje=0,ykl=0,pamt=total/per_cnt,syl=0;
DELETE FROM bar ;        
DELETE FROM `gpsinahis` WHERE `date`<DATE_ADD(t_date,INTERVAL -8 DAY);
update gpjjrec set upjjcnt=0,downjjcnt=0;
INSERT INTO EVENT SELECT 0,keystr,'',updtime,'0' FROM `概念集合` WHERE keystr NOT IN (SELECT title FROM EVENT);
UPDATE `gptodayzfrec` SET zf = 0,dqj = 0;
UPDATE gn1 SET sel = 0;
UPDATE hy SET sel = 0;
INSERT INTO gpzfrec (CODE) SELECT lostgps.`code` FROM lostgps;
delete from `position` where code in ('000001','399001','399006');
UPDATE jxcost SET uptime =0;
  
 set g_num = 80;
 if (in_mode = 4) then
     SET g_num = 100;
 end if;
 
 TRUNCATE dprec;
 TRUNCATE gn1;
 TRUNCATE hy1;
 TRUNCATE rtn_value;
 
 INSERT INTO gn1 (code,name,zf,zf3,zf10,zf30,rsi6,rsi12,rsi24) SELECT g.`gn`,gn.`gnname`,AVG(g1.`zf`),AVG(g1.`zf3`),AVG(g1.`zf10`),AVG(g1.`zf30`),AVG(g1.`rsi_6`),AVG(g1.`rsi_12`),AVG(g1.`rsi_24`)
 FROM gn2gp g,gpzfrec g1,gn WHERE g.`gn`=gn.`gn` AND g.`gpcode` = g1.`code` AND gn.`gn` NOT IN (999) GROUP BY g.`gn`;
 
 INSERT INTO hy1 SELECT g.`hy`,AVG(g1.`zf`),AVG(g1.`zf3`),AVG(g1.`zf10`),AVG(g1.`zf30`),AVG(g1.`rsi_6`),AVG(g1.`rsi_12`),AVG(g1.`rsi_24`)
 FROM gp g,gpzfrec g1 WHERE g.`code`=g1.`code` AND g.`hy` IS NOT NULL AND g.hy <> '--' GROUP BY g.`hy`;
 
 /*DELETE FROM gpsel WHERE gpsel.`code` IN (SELECT xsjj.code FROM xsjj WHERE xsjj.zbbl >=1);*/
 UPDATE gpsel SET gpflag =-1 WHERE gpsel.`code` IN (SELECT xsjj.code FROM xsjj WHERE xsjj.zbbl >=1);
 
 if (in_mode = 2 or in_mode = 6 OR in_mode = 7 OR in_mode = 4) then
          
     TRUNCATE qjsel;           	
 		     	
    /*放入股票池*/
     if (in_mode =4) then
             TRUNCATE dpqs;     
	     SELECT GROUP_CONCAT(DISTINCT t.`code`) INTO gpcodes  
	      FROM (SELECT CODE FROM gpsel g where g.`zbflag` in (1) ORDER BY g.`gpflag` DESC) t;		      
	     UPDATE `stratey` SET gpcodes = gpcodes WHERE flag=2;  
     elseif (in_mode= 6) then
            SELECT GROUP_CONCAT(DISTINCT t.`code`) INTO gpcodes  
	      FROM (SELECT CODE FROM gpsel g WHERE g.flag >= 0 AND g.zbflag IN (1,2) ORDER BY g.zbflag ASC LIMIT 0,23) t;		
	     UPDATE `stratey` SET gpcodes = gpcodes WHERE flag=6;    	     
     ELSEIF (in_mode= 2 or in_mode =3) THEN
           SELECT GROUP_CONCAT(DISTINCT t.`code`) INTO gpcodes  
	      FROM (SELECT p.CODE FROM POSITION p WHERE p.`available` > 0 LIMIT 0,21) t;		
	     UPDATE `stratey` SET gpcodes = gpcodes WHERE flag=2;  
	     
	     call imp_pa_cw();
     ELSEIF (in_mode= 8) THEN
            SELECT GROUP_CONCAT(DISTINCT t.`code`) INTO gpcodes  
	      FROM (SELECT CODE FROM gpsel g WHERE g.flag >= 0 AND g.zbflag IN (0,1,2,5) ORDER BY g.zbflag ASC LIMIT 0,23) t;		
	     UPDATE `stratey` SET gpcodes = gpcodes WHERE flag=8;   
     end if;
      
          
	
 end if;
 
  UPDATE POSITION SET available_today = 0;
  UPDATE gpparam SET tranmode=1;
 
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `jc_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `jc_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jc_total`()
BEGIN
   
    UPDATE jcrec SET jcdate = DATE_ADD(jcdate, INTERVAL -1 DAY);  
    /*复制*/
    INSERT INTO jcrec_cp SELECT * FROM jcrec where code not in (select code from jcrec_cp);   
        	              
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `jx_time_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `jx_time_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jx_time_total`()
BEGIN
    
       
        declare p_date date;	
        DECLARE p_zb DECIMAL(8,2); 				              
        declare p_code varchar(30) default '';
        
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT h.code ,SUM(IF(h.cjj>h.jj,1,-1)) bj1 FROM gptimehis h GROUP BY h.`code`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;
	
	DELETE FROM gptimetotal;
	
	set p_date = get_tran_date();		
			
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_code,p_zb;
	     WHILE b<>1 DO            	     	        
	     	        	
	       INSERT INTO gptimetotal (CODE,zb,date) VALUES (p_code,p_zb,p_date);
                                       		 		 
	       FETCH feeCodeCursor INTO p_code,p_zb; /*取下一条记录*/
	      END WHILE;
	 	
	 CLOSE feeCodeCursor;      		
                                   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `jx_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `jx_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jx_total`(in_code CHAR(10),in_date datetime)
BEGIN
    
        DECLARE v_avg_5 DECIMAL(8,2); 
        DECLARE v_avg_10 DECIMAL(8,2);      
        DECLARE v_avg_20 DECIMAL(8,2); 
        DECLARE v_avg_30 DECIMAL(8,2); 
        DECLARE v_avg_50 DECIMAL(8,2);               
        
        DECLARE v_tr_20 DECIMAL(8,2);
               	
	DECLARE c_cnt int;  	
	
	select count(code) into c_cnt from gpsinahis where code = in_code and date=in_date;	
	
	IF (c_cnt > 0 ) THEN	
		
	 SELECT AVG(avg1.p) INTO v_avg_5 FROM 
			(SELECT g.dqj p FROM gpsinahis g WHERE g.Code= in_code AND g.Date<=in_date ORDER BY g.Date DESC LIMIT 0,5) avg1;			
	 SELECT AVG(avg2.p) INTO v_avg_10 FROM 
		(SELECT g.dqj p FROM gpsinahis g WHERE g.Code= in_code AND g.Date<=in_date ORDER BY g.Date DESC LIMIT 0,10) avg2; 	
	 SELECT AVG(avg3.p) INTO v_avg_20 FROM 
		(SELECT g.dqj p FROM gpsinahis g WHERE g.Code= in_code AND g.Date<=in_date ORDER BY g.Date DESC LIMIT 0,20) avg3; 
		
	 SELECT AVG(avg5.p) INTO v_avg_30 FROM 
		(SELECT g.dqj p FROM gpsinahis g WHERE g.Code= in_code AND g.Date<=in_date ORDER BY g.Date DESC LIMIT 0,30) avg5;		
		
	 SELECT AVG(avg4.p) INTO v_avg_50 FROM 
		(SELECT g.dqj p FROM gpsinahis g WHERE g.Code= in_code AND g.Date<=in_date ORDER BY g.Date DESC LIMIT 0,50) avg4; 
		
		
	 SELECT AVG(tr.p) INTO v_tr_20 FROM 
		(SELECT g.tr p FROM gpsinahis g WHERE g.Code= in_code AND g.Date<=in_date ORDER BY g.Date DESC LIMIT 0,20) tr; 
		
			  							
	 INSERT INTO gpjx(CODE,jj5,jj10,jj20,jj30,jj50,atr,ddd,upddate) 
	    VALUES (in_code,v_avg_5,v_avg_10,v_avg_20,v_avg_30,v_avg_50,v_tr_20,v_avg_5-v_avg_10,in_date); 
	    
	 COMMIT;            
	END IF;	  			              
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `jx_total_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `jx_total_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jx_total_all`(icode varchar(30),idate datetime)
BEGIN                 
        	
        
	DECLARE c_cnt INT DEFAULT 0;    
	DECLARE p_code VARCHAR(20);       
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/  
        DECLARE feeCodeCursor CURSOR FOR SELECT CODE FROM gp where code=ifnull(icode,code);               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;     		
	
	select count(1) into c_cnt from gpjx j where j.upddate = idate;
	
	if (c_cnt=0) then
	   		      		
		DELETE FROM `hgsta`;
				
		OPEN feeCodeCursor;	
				
		FETCH feeCodeCursor INTO p_code;
		     WHILE b<>1 DO            	     	        
	
			CALL jx_total(p_code,idate);
			CALL hg_sta_total(p_code);
				 
		       FETCH feeCodeCursor INTO p_code; /*取下一条记录*/
		      END WHILE;
		 
		 CLOSE feeCodeCursor;   		   
		COMMIT;   
		
		 /**插入历史表**/   
		 select count(1) into c_cnt from gpjxhis where upddate=idate;	
		 if (c_cnt = 0) then
			INSERT INTO gpjxhis SELECT * FROM gpjx;
		 end if;
		 		 
		 COMMIT;   
	end if;
        
              
                 
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `jx_yh_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `jx_yh_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jx_yh_total`(in icode CHAR(10),in idate datetime)
BEGIN
    
        DECLARE v_avg_5 DECIMAL(8,2); 
        DECLARE v_avg_10 DECIMAL(8,2);      
        DECLARE v_avg_20 DECIMAL(8,2); 
        DECLARE v_avg_30 DECIMAL(8,2); 
        DECLARE v_avg_50 DECIMAL(8,2);                           
               	
	DECLARE c_cnt int;  	
	
	DECLARE v_ema_10 DECIMAL(8,2);                 
	
	select count(code) into c_cnt from gpyaohhis where code = icode;	
	
	IF (c_cnt >0 ) THEN
	
	 SELECT AVG(avg1.p) INTO v_avg_5 FROM 
			(SELECT g.close p FROM gpyaohhis g WHERE g.Code= icode AND g.Date<=idate ORDER BY g.Date DESC LIMIT 0,5) avg1;			
	 SELECT AVG(avg2.p) INTO v_avg_10 FROM 
		(SELECT g.close p FROM gpyaohhis g WHERE g.Code= icode AND g.Date<=idate ORDER BY g.Date DESC LIMIT 0,10) avg2; 	
	 SELECT AVG(avg3.p) INTO v_avg_20 FROM 
		(SELECT g.close p FROM gpyaohhis g WHERE g.Code= icode AND g.Date<=idate ORDER BY g.Date DESC LIMIT 0,20) avg3; 
		
	 SELECT AVG(avg5.p) INTO v_avg_30 FROM 
		(SELECT g.close p FROM gpyaohhis g WHERE g.Code= icode AND g.Date<=idate ORDER BY g.Date DESC LIMIT 0,30) avg5;		
		
	 SELECT AVG(avg4.p) INTO v_avg_50 FROM 
		(SELECT g.close p FROM gpyaohhis g WHERE g.Code= icode AND g.Date<=idate ORDER BY g.Date DESC LIMIT 0,50) avg4; 
		
	 
	 set v_ema_10 = get_gp_ema(icode,10,idate);
	
	 INSERT INTO gpjxhis(CODE,jj5,jj10,jj20,jj30,jj50,ddd,ema10,upddate) 
	       VALUES (icode,v_avg_5,v_avg_10,v_avg_20,v_avg_30,v_avg_50,v_avg_10-v_avg_50,v_ema_10,idate);	
	  	    
	 COMMIT;            
	END IF;	  			              
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `jx_yh_total_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `jx_yh_total_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jx_yh_total_all`(in icode varchar(20))
BEGIN                         	        
	DECLARE c_cnt INT DEFAULT 0;    	
	DECLARE v_date datetime;   
	DECLARE v_cur_date DATETIME default get_tran_date(); 
	DECLARE v_code VARCHAR(20);     	
	declare v_cnt integer;
	    
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/  
        DECLARE feeCodeCursor CURSOR FOR SELECT distinct CODE,DATE FROM gpyaohhis h WHERE h.`code` = icode ORDER BY DATE DESC;              
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;     		
	
	delete from gpjxhis where code = icode;
	
	
	
	OPEN feeCodeCursor;					
		FETCH feeCodeCursor INTO v_code,v_date;
		     WHILE b<>1 DO            	     	        
		
			CALL jx_yh_total(v_code,v_date);			
					 
		       FETCH feeCodeCursor INTO v_code,v_date; /*取下一条记录*/
		      END WHILE;
		 
	CLOSE feeCodeCursor;   	
	
	DELETE FROM gpjxhis WHERE CODE = icode and jj10=jj20 and jj20=jj30 AND upddate < v_cur_date;	
	DELETE FROM gpjxhis WHERE CODE = icode and jj5=jj10 AND jj10=jj20 AND jj20=jj30;	   						
			 
	COMMIT;   
                                               
    END */$$
DELIMITER ;

/* Procedure structure for procedure `qj_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `qj_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `qj_process`()
BEGIN		      
        DECLARE td_mode INT;  
        
        DECLARE zxp_zf DOUBLE;  /*上证50涨幅*/  
        DECLARE cyb_zf DOUBLE; 
        DECLARE dp_zf DOUBLE;  
         
        SELECT MAX(g.zf) INTO cyb_zf FROM gptoday g WHERE g.`code` = 'sz399006';                               
        SELECT MAX(g.zf) INTO zxp_zf FROM gptoday g WHERE g.`code` = 'sz399001';    
        SELECT MAX(g.zf) INTO dp_zf FROM gptoday g WHERE g.`code` = 'sh000001';   
        
                                                       	
	 /**初始化*/   
        call comm_proc();
        
        /**股票池抄底*/
        CALL cl_cdqsg(1,cyb_zf,zxp_zf,dp_zf);            		
	
	 /**补仓**/
        CALL cl_bc(2);    
	        
        /**测试模式*/              
        SELECT g.tranmode INTO td_mode FROM gpparam g WHERE g.code= '001';   
        IF (td_mode = 0) THEN      
           delete FROM POSITION;           
           INSERT POSITION (CODE,indate,inxh,available) 
		SELECT CODE,jcdate,xhtype,300 FROM qjsel WHERE qjsel.`code` NOT IN (SELECT CODE FROM POSITION); 
           COMMIT;
        END IF;        
        
        TRUNCATE prezf;   
	INSERT INTO prezf SELECT CODE,zf FROM gptoday;                          
        
        commit;
             
        /**买人 卖出 */
        call buy_sell();
       			 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `qs_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `qs_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `qs_process`()
BEGIN      
      DECLARE v_cnt INT;           
      DECLARE total_cnt INT;      
      DECLARE can_buy_cnt INT DEFAULT 15;   
      DECLARE in_time VARCHAR(200) DEFAULT "9:40:00";  
      DECLARE end_time VARCHAR(200) DEFAULT "14:40:00";    
                        
      DECLARE sz_50_zf DOUBLE;  /*上证50涨幅*/    
      DECLARE cyb_zf DOUBLE; 
      DECLARE cyb_jj DOUBLE; 
      DECLARE cyb_dqj DOUBLE; 
      DECLARE cyb_zgj DOUBLE; 
      DECLARE cyb_zdj DOUBLE; 
      DECLARE cyb_zr_close DOUBLE; 
           
      DECLARE dp_zf DOUBLE;   
      DECLARE dp_zr_zf DOUBLE;    
      DECLARE dp_jj DOUBLE;  
      DECLARE dp_zf_3 DOUBLE;  
      DECLARE dp_zf_7 DOUBLE;  
      DECLARE dp_jx_5 DOUBLE;  
      DECLARE dp_jx_10 DOUBLE;   
      DECLARE dp_jx_20 DOUBLE;   
      DECLARE dp_jx_60 DOUBLE;   
      DECLARE dp_rsi_6 DOUBLE; 
      DECLARE dp_rsi_12 DOUBLE;
      DECLARE dp_rsi_24 DOUBLE;     
            
      DECLARE dp_dqj DOUBLE;  
      DECLARE dp_zgj DOUBLE; 
      DECLARE dp_zdj DOUBLE; 
      DECLARE dp_zr_close DOUBLE; 
      DECLARE dp_low_cnt INT; 
      DECLARE dp_top_cnt INT; 
      DECLARE wait_time_jg INT; 
      DECLARE wait_time INT; 
                
      DECLARE zxp_zf DOUBLE;   
      DECLARE zxp_dqj DOUBLE;  
      DECLARE zxp_zgj DOUBLE; 
      DECLARE zxp_zr_close DOUBLE; 
      DECLARE avg_rsi_6 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_12 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_24 DOUBLE DEFAULT 60;      
          
      DECLARE dp_time TIME;                     	
      /*大盘趋势*/
      DECLARE cyb_qs INT DEFAULT 0; 
      DECLARE zxb_qs INT DEFAULT 0; 
      DECLARE dp_qs INT DEFAULT 0;                  
      
      /*新浪趋势*/
      DECLARE is_cyb_qs INT DEFAULT 0; 
      DECLARE is_zxb_qs INT DEFAULT 0; 
      DECLARE is_dp_qs INT DEFAULT 0;  
            
      DECLARE cyb_zf_str VARCHAR(200);
      DECLARE dp_zf_str VARCHAR(200);
      DECLARE zxb_zf_str VARCHAR(200);
      
      SELECT MAX(g.zf) INTO sz_50_zf FROM gptoday g WHERE g.`code` = 'sh000016';      
         
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj),MAX(g.`jrzdj`),MAX(g.`trantime`) 
        INTO dp_zf,dp_jj,dp_dqj,dp_zr_close,dp_zgj,dp_zdj,dp_time
            FROM gptoday g WHERE g.`code` = 'sh000001';        
       
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj),MAX(g.jrzdj) 
             INTO cyb_zf,cyb_jj,cyb_dqj,cyb_zr_close,cyb_zgj,cyb_zdj
            FROM gptoday g WHERE g.`code` = 'sz399006';    
       
      SELECT MAX(g.zf),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO zxp_zf,zxp_dqj,zxp_zr_close,zxp_zgj
            FROM gptoday g WHERE g.`code` = 'sz399001';     
	
      SELECT MAX(g.jx_5),MAX(g.jx_10),MAX(g.jx_20),MAX(g.zf3),MAX(g.zf7),MAX(g.`rsi_6`),MAX(g.jx_60),MAX(g.`zf`),MAX(g.rsi_12),MAX(g.rsi_24),MAX(g.`zf_rec`)
           INTO dp_jx_5,dp_jx_10,dp_jx_20,dp_zf_3,dp_zf_7,dp_rsi_6,dp_jx_60,dp_zr_zf,dp_rsi_12,dp_rsi_24,dp_zf_str
            FROM gpzfrec g WHERE g.`code` = '000001'; 
            
       /*记录大盘最低*/
       SELECT COUNT(dplow) INTO v_cnt FROM dprec WHERE dplow=dp_zdj;
       IF (v_cnt = 0) THEN
	  INSERT INTO dprec (dplow,dptop,zf,dptime) VALUES (dp_zdj,dp_zgj,dp_zf,dp_time);         
       END IF;
       SELECT COUNT(dptop) INTO v_cnt FROM dprec WHERE dptop=dp_zgj;
       IF (v_cnt = 0) THEN
	    INSERT INTO dprec (dplow,dptop,zf,dptime) VALUES (dp_zdj,dp_zgj,dp_zf,dp_time);         
       END IF;      
      
      SELECT COUNT(DISTINCT dplow) INTO dp_low_cnt FROM dprec WHERE dplow >0 AND dptime < '15:01:03';
      SELECT COUNT(DISTINCT dptop) INTO dp_top_cnt FROM dprec WHERE dptop >0 AND dptime < '15:01:03';
      SET dp_low_cnt=dp_low_cnt-dp_top_cnt;
      SET wait_time_jg= IF(dp_low_cnt<=0,0,dp_low_cnt)*800;   
      SET wait_time= IF((TIME_TO_SEC(in_time)+wait_time_jg) > 50400,50400,(TIME_TO_SEC(in_time)+wait_time_jg));  
      
      update qsparam set waittime=wait_time,wait_jg=wait_time_jg where id=1;     
      
      SELECT d.qs INTO dp_qs FROM dpqs d WHERE d.`code`='000001' ORDER BY d.`jdate` DESC LIMIT 0,1;
      SELECT d.qs INTO cyb_qs FROM dpqs d WHERE d.`code`='399006' ORDER BY d.`jdate` DESC LIMIT 0,1;
      SELECT d.qs INTO zxb_qs FROM dpqs d WHERE d.`code`='399001' ORDER BY d.`jdate` DESC LIMIT 0,1;        
      
      SELECT MAX(g.`zf_rec`) INTO dp_zf_str FROM gpzfrec g WHERE g.`code` = '000001'; 
      SELECT MAX(g.`zf_rec`) INTO zxb_zf_str FROM gpzfrec g WHERE g.`code` = '399001'; 
      SELECT MAX(g.`zf_rec`) INTO cyb_zf_str FROM gpzfrec g WHERE g.`code` = '399006';              
      IF (INSTR(cyb_zf_str,'3') > INSTR(cyb_zf_str,'5')) THEN
        SET is_cyb_qs = -1;
      END IF;     
      
      IF (INSTR(zxb_zf_str,'3') > INSTR(zxb_zf_str,'5')) THEN
        SET is_zxb_qs = -1;
      END IF; 
      
      IF (INSTR(dp_zf_str,'3') > INSTR(dp_zf_str,'5')) THEN
        SET is_dp_qs = -1;
      END IF;       
      
      /*技术性趋势*/   
      IF ((is_cyb_qs+is_dp_qs+is_zxb_qs < 0 OR dp_qs+zxb_qs+cyb_qs > 4)
             AND zxp_zf+dp_zf+cyb_zf < 1.2 ) THEN                      
         /*关闭*/                            
         UPDATE `gpparam` SET tranflag = '0';   
         
         /*技术性趋势*/
         update qsparam set js_qs=-1;               
      ELSE	 	 
	 UPDATE qsparam SET js_qs=0;
      END IF;  	              
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `rec_jump_end` */

/*!50003 DROP PROCEDURE IF EXISTS  `rec_jump_end` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `rec_jump_end`()
BEGIN
DELETE FROM gptodayzfrec;
INSERT INTO gptodayzfrec SELECT DISTINCT CODE,zf FROM gptoday;
END */$$
DELIMITER ;

/* Procedure structure for procedure `rec_jump_start` */

/*!50003 DROP PROCEDURE IF EXISTS  `rec_jump_start` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `rec_jump_start`()
BEGIN
INSERT INTO jump_rec 
SELECT 0,g2.`code`,1,(g2.`zf`-g1.`zf`),NOW() FROM gptodayzfrec g1,gptoday g2 WHERE g1.`code`=g2.`code` ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sel_cjl_lowest` */

/*!50003 DROP PROCEDURE IF EXISTS  `sel_cjl_lowest` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sel_cjl_lowest`()
BEGIN
INSERT INTO gpsel SELECT 0 id,h5.code,'' NAME,-1,NOW() FROM (SELECT h1.* FROM gpsinahis h1,(SELECT h.`code`,MIN(h.`cj_amt`) mcjl FROM gpsinahis h GROUP BY h.`code`) h2 WHERE h1.`code`=h2.code
 AND h1.`cj_amt`=h2.mcjl AND h1.`cj_amt` > 0 AND h1.`date`=get_tran_date()) h5 
 
 INNER JOIN 
 
 (SELECT h1.* FROM gpsinahis h1,(SELECT h.`code`,MIN(h.`dqj`) mjg FROM gpsinahis h GROUP BY h.`code`) h2 WHERE h1.`code`=h2.code
 AND h1.`dqj`=h2.mjg AND h1.`cj_amt` > 0 AND h1.`date`=get_tran_date()) h4 ON h5.`code`=h4.code;
 
 UPDATE gpsel SET NAME=(SELECT gp.name FROM gp WHERE gp.`code`= gpsel.`code`);
 
		
         UPDATE `stratey` SET gpcodes = (SELECT GROUP_CONCAT(g.`code`) FROM gpsel g);  
 
 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sel_zt_gps` */

/*!50003 DROP PROCEDURE IF EXISTS  `sel_zt_gps` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sel_zt_gps`()
BEGIN
	DECLARE p_code VARCHAR(20); 	 
	DECLARE p_hy VARCHAR(20); 
	DECLARE p_gn VARCHAR(20);        
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/  
        DECLARE feeCodeCursor CURSOR FOR 
		SELECT g.`code`,g.hy FROM gpzthis h,gp g,gpzfrec g1 WHERE h.`code`=g.`code` AND g.`code`=g1.`code` 
		AND g1.`zf30` < 15 AND g1.`zf10` <> 0 AND h.flag = 0 and g1.zf < 3
		ORDER BY h.zf DESC;               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;   
       /*初始化*/
       INSERT INTO gpzthis SELECT CODE,zf,trantime,0 FROM zttoday g WHERE g.code NOT IN (SELECT gpzthis.code FROM gpzthis);
       DELETE FROM gpzthis WHERE gpzthis.`code` IN (SELECT g.`code` FROM gptoday g WHERE g.`code`=gpzthis.`code` AND g.`dqj` < g.`jj`) AND gpzthis.`flag`=0;
       DELETE FROM gpzthis WHERE gpzthis.`code` IN (SELECT g.`gpcode` FROM gn2gp g WHERE g.`gn`=718) AND gpzthis.`flag`=0;   
       TRUNCATE rtn_value;        	
	  					
	OPEN feeCodeCursor;	
				
	FETCH feeCodeCursor INTO p_code,p_hy;
	
	WHILE b<>1 DO            	     	        
      
	       IF (p_hy IN ('纺织制造','医药商业','服装家纺','燃气水务','房地产开发','食品加工制造')) THEN
		  SELECT g.gn into p_gn FROM gn2gp g,gn WHERE g.gpcode=p_code and g.gn=gn.`gn` and gn.`flag` > 0; 
		  if (p_gn is null) then
		     set b:=1;
		  else
		     insert into rtn_value (type,rtn_value) values ('gn',p_gn);	
		     SET b:=1;	     
		  end if;
	       else
	            INSERT INTO rtn_value (TYPE,rtn_value) VALUES ('hy',p_hy);	
		    SET b:=1;	 		                                            
	       END IF;
		 
	       FETCH feeCodeCursor INTO p_code,p_hy; /*取下一条记录*/
	END WHILE;
	 
	CLOSE feeCodeCursor; 
	
	commit;
	        	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `syn_store` */

/*!50003 DROP PROCEDURE IF EXISTS  `syn_store` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `syn_store`()
BEGIN                 
                
        UPDATE store SET ykje = IFNULL((SELECT SUM(fpnl) FROM POSITION),0)
	,ykl=ykje/total*100,zjye=total-IFNULL((SELECT SUM(cost) FROM POSITION),0);  
                                   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `tl_gp_upd` */

/*!50003 DROP PROCEDURE IF EXISTS  `tl_gp_upd` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `tl_gp_upd`()
BEGIN                 
                
       UPDATE gprefcode SET NAME = (SELECT gp.name FROM gp WHERE gp.`code`=gprefcode.`code`);
       UPDATE `stratey` SET gpcodes = ( SELECT GROUP_CONCAT(DISTINCT gprefcode.`code`) FROM gprefcode);   
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `update_gp_cw_info` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_gp_cw_info` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_gp_cw_info`()
BEGIN                 
        
        UPDATE gp SET mgsy=(SELECT distinct mgsy FROM gpcw WHERE gpcw.code=gp.`code` AND gpcw.`date`=(SELECT MAX(DATE) FROM gpcw WHERE CODE = gp.`code`));             
        COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_all_his_tr` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_all_his_tr` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_all_his_tr`()
BEGIN                 
                
        DECLARE p_code VARCHAR(20);     
        
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT DISTINCT CODE FROM gpsinahis WHERE CODE <> 'int_dji';
               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;   
	
	DELETE FROM gpzfrec;			
	OPEN feeCodeCursor;				
	FETCH feeCodeCursor INTO p_code;
	     WHILE b<>1 DO          
									
		call upd_his_tr(p_code);			
								 
	       FETCH feeCodeCursor INTO p_code; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		             
				 
	 COMMIT;  
       
       	
	          
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_gn_data` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_gn_data` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_gn_data`(in i_gn integer)
BEGIN
UPDATE `table$` SET 代码=REPLACE(REPLACE(LOWER(代码),'sh',''),'sz',''),总市值=总市值/100000000,流通市值=流通市值/100000000;
delete from gn2gp_copy;
/*高送转不要*/
insert into gn2gp_copy select * from gn2gp where gn=i_gn and gn not in (357,589);
delete from gn2gp where gn=i_gn;
INSERT INTO `gn2gp` (gn,gpcode,gpname) (SELECT i_gn,代码,名称 FROM  `table$` );
commit;
INSERT INTO gn2gp SELECT * FROM gn2gp_copy WHERE gpcode NOT IN (SELECT gpcode FROM gn2gp WHERE gn=i_gn);
delete from `table$`;
DELETE FROM gpext;
INSERT INTO gpext (code,gn) SELECT gpcode,GROUP_CONCAT(gn SEPARATOR ',') FROM `gn2gp` GROUP BY gpcode ORDER BY gpcode;
INSERT INTO gpext SELECT CODE,'' FROM gp WHERE CODE NOT IN (SELECT CODE FROM gpext);
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_gp_data` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_gp_data` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_gp_data`()
BEGIN
UPDATE `table$` SET 代码=LOWER(代码),总市值=总市值/100000000,流通市值=流通市值/100000000;
COMMIT;
DELETE FROM gp;
INSERT INTO gp (CODE,NAME,hy,syl,sjl,zsz,ltsz) (SELECT * FROM  `table$` );
UPDATE gp SET syl=999 WHERE (syl IS NULL OR syl = 0);
UPDATE gp SET CODE= REPLACE(REPLACE(`code`,'sh',''),'sz','');
UPDATE gp SET ltsz=IFNULL(ltsz,0),zsz=IFNULL(zsz,0),mgsy=IFNULL(mgsy,0);
CALL update_gp_cw_info();
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_gp_self_data` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_gp_self_data` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_gp_self_data`()
BEGIN
DECLARE gpcodes TEXT;      
/*放入股票池*/
SELECT GROUP_CONCAT(DISTINCT g.`code`) INTO gpcodes  fROM gpsel g;
		
UPDATE `stratey` SET gpcodes = gpcodes; 
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_his_tr` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_his_tr` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_his_tr`(in p_code char(20))
BEGIN                 
        	               
        DECLARE p_a decimal(8,2);  
        DECLARE p_b DECIMAL(8,2);    
        DECLARE p_c DECIMAL(8,2); 
        DECLARE p_id integer;
        
        DECLARE p_max DECIMAL(8,2);  
                
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT h.id,h.`jrzgj`-h.`jrzdj` a, h.`zrspj`-h.`jrzgj` b,h.`zrspj`-h.`jrzdj` c 
               FROM gpsinahis h WHERE h.`code` = p_code;
		               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;   			
      
	DELETE FROM gpzfrec;			
	OPEN feeCodeCursor;				
	FETCH feeCodeCursor INTO p_id,p_a,p_b,p_c;
	     WHILE b<>1 DO          
									
		if (p_a>p_b and p_a>p_c) then
		  set p_max = p_a;
		elseif (p_a>p_b AND p_a<p_c) then
		   SET p_max = p_c;
		ELSEIF (p_a<p_b AND p_b>p_c) THEN
		   SET p_max = p_b;
		end if;		
		
		update gpsinahis set tr=p_max where id=p_id;
								 
	       FETCH feeCodeCursor INTO p_id,p_a,p_b,p_c; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      		             
				 
	 COMMIT;  
        
       	
	          
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_position` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_position` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_position`(IN p_side INTEGER,in p_code char(20),
		IN p_xh INTEGER,
		IN p_volume INTEGER,
		IN p_price double,
		in p_time datetime,
		in p_type varchar(20))
BEGIN                 
        	               
        DECLARE v_trandate Datetime;          
        DECLARE v_cnt integer;        
	DECLARE v_vwap double;  
	DECLARE v_sell_nums DOUBLE;       
	
	DECLARE v_in_date datetime;      
        
        /*交易日*/
        set v_trandate = p_time;
        
        /*判断是否存在记录**/
        select count(1) into v_cnt from position where code=p_code;
                     
        /*买入*/
        if (p_side =1) then
                
		IF (v_cnt = 0) THEN
		   INSERT INTO POSITION (CODE,inxh,indate,available,available_today,price,vwap,cost,fpnl,type) VALUES
		     (p_code,p_xh,v_trandate,p_volume,p_volume,p_price,p_price,p_volume*p_price,0,p_type);
		ELSE                                      			
		    UPDATE POSITION SET inxh=if(available=0,p_xh,if(inxh=1,inxh,p_xh)),
		         indate=v_trandate,vwap=(available*vwap+p_volume*p_price)/(available+p_volume)
			,available = available+p_volume
			,available_today = available_today +p_volume
			,price = p_price,cost=available*vwap			 		
			WHERE CODE=p_code;
		END IF;
		
		insert into tranhis (code,side,inxh,price,nums,tran_date) values (p_code,p_side,p_xh,p_price,p_volume,v_trandate);
	ELSEIF (p_side =-1) THEN
		
           SELECT vwap,indate,(available-available_today) into v_vwap,v_in_date,v_sell_nums FROM POSITION WHERE CODE=p_code;
	  
	   UPDATE POSITION SET outdate=v_trandate
			,fpnl=fpnl+(available-available_today)*(p_price-vwap)
			,sumzf=	sumzf+(p_price-vwap)/vwap*100				
			,price = p_price,cost=(available-available_today)*vwap,
			available = available_today,available_today=0,
			selltime=IF(available>0,selltime,0),
			zy=IF(available>0,zy,0),zs=IF(available>0,zs,0),
			vwap=IF(available>0,vwap,0),inxh=if(available>0,inxh,0)			
			WHERE CODE=p_code and vwap >0;
	        
	   INSERT INTO tranhis (CODE,side,inxh,cost,price,nums,fdyk,in_date,tran_date) VALUES (p_code,p_side,p_xh,
	                v_vwap,
			p_price,v_sell_nums
			,(v_sell_nums*(p_price-v_vwap)),v_in_date,v_trandate);				   	  	 
	      
        end if;                              	 
	  
	COMMIT;       
	   	
	/** 总额更新**/
        UPDATE store SET ykje = IFNULL((SELECT SUM(fpnl) FROM POSITION),0)
		,gpsz=IFNULL((SELECT SUM(cost) FROM POSITION),0)
		,zjye=total-gpsz,ykl=ykje/total*100; 
		             	        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `upd_time_total` */

/*!50003 DROP PROCEDURE IF EXISTS  `upd_time_total` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_time_total`(in i_code char(20),
   in i_dqj DOUBLE,in i_fszb DOUBLE,in i_zf double,in i_flag integer)
BEGIN                         
        IF (i_flag=1) THEN
           update gp_time_order set fszb=i_fszb,dqj=i_dqj,flag=i_flag,zf=i_zf where code=i_code;
        ELSEif (i_flag=-1) then
           UPDATE gp_time_order SET flag=i_flag WHERE CODE=i_code; 
        ELSE
           insert into gp_time_order (code,fszb,dqj,zf,flag) values (i_code,i_fszb,i_dqj,i_zf,i_flag);
        END IF;
           
       COMMIT;            
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `xw_process` */

/*!50003 DROP PROCEDURE IF EXISTS  `xw_process` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `xw_process`()
BEGIN                 
        
        
        DECLARE p_key VARCHAR(2000);   
        DECLARE p_newsfrom VARCHAR(20);  
	DECLARE p_gn int;          
          
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT GROUP_CONCAT(DISTINCT g.keystr) str,g.gn,g.newsfrom
            FROM newsyw g WHERE g.gn <> 0 and g.newsfrom in ('今日要闻','新闻联播','早盘必读') GROUP BY g.gn HAVING COUNT(gn) > 1;
               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;       
			
	OPEN feeCodeCursor;	
			
	FETCH feeCodeCursor INTO p_key,p_gn,p_newsfrom;
	     WHILE b<>1 DO            	     	        
	     	
	     	delete from  Newsyw where gn= p_gn;    		
		insert into Newsyw (flag,gn,newsfrom,keystr,remark,updtime) values (0,p_gn,p_newsfrom,p_key,'',now());		
				                                       		 		
	       FETCH feeCodeCursor INTO p_key,p_gn,p_newsfrom; /*取下一条记录*/
	      END WHILE;
	 
	 CLOSE feeCodeCursor;      	
	 
        DELETE FROM newsyw  WHERE keystr IN ('新高','暴跌','反弹',
               '油价','蔓延','大盘','人民币','减少','电池','布伦特原油,油价','批复',
              '重组','减产','创新','行业','不可以减持','市场化','A股,美股','A股','美股','跌破');	
              
        delete from EVENT;
              
        INSERT INTO EVENT SELECT 0,keystr,'',updtime,'0' FROM `概念集合` WHERE keystr NOT IN (SELECT title FROM EVENT);
                                   
        COMMIT;      
        
              
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `zf_record_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `zf_record_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `zf_record_all`()
BEGIN                 
        
	DECLARE v_cnt INT DEFAULT 0;         
        
        DECLARE p_code VARCHAR(20);     
        DECLARE p_rec VARCHAR(500);      
        DECLARE p_zf7 DECIMAL(25,2);  
        DECLARE p_date DATE;         
        DECLARE b INT DEFAULT 0;  /*是否达到记录的末尾控制变量*/          
        DECLARE feeCodeCursor CURSOR FOR SELECT CODE,GROUP_CONCAT(zf_convert(zf) ORDER BY DATE ASC  SEPARATOR ''),sum(zf)
		FROM `gpsinahis` 
		GROUP BY CODE ;
               
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;   
	SET p_date = get_tran_date();	
	
	select count(1) into  v_cnt from  gpzfrec where  date = p_date;	
        if (v_cnt =0) then              	
		OPEN feeCodeCursor;				
		FETCH feeCodeCursor INTO p_code,p_rec,p_zf7;
		     WHILE b<>1 DO          
										
			update gpzfrec set zf_rec=p_rec,zf7=p_zf7,DATE=p_date where code=p_code;			
									 
		       FETCH feeCodeCursor INTO p_code,p_rec,p_zf7; /*取下一条记录*/
		      END WHILE;
		 
		 CLOSE feeCodeCursor;      		             
					 
		 COMMIT;  
        end if;
       	
	          
        
    END */$$
DELIMITER ;

/*Table structure for table `业绩快报` */

DROP TABLE IF EXISTS `业绩快报`;

/*!50001 DROP VIEW IF EXISTS `业绩快报` */;
/*!50001 DROP TABLE IF EXISTS `业绩快报` */;

/*!50001 CREATE TABLE  `业绩快报`(
 `code` char(20) ,
 `name` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `业绩预增` */

DROP TABLE IF EXISTS `业绩预增`;

/*!50001 DROP VIEW IF EXISTS `业绩预增` */;
/*!50001 DROP TABLE IF EXISTS `业绩预增` */;

/*!50001 CREATE TABLE  `业绩预增`(
 `code` char(20) ,
 `name` varchar(200) ,
 `updtime` date 
)*/;

/*Table structure for table `业绩预披` */

DROP TABLE IF EXISTS `业绩预披`;

/*!50001 DROP VIEW IF EXISTS `业绩预披` */;
/*!50001 DROP TABLE IF EXISTS `业绩预披` */;

/*!50001 CREATE TABLE  `业绩预披`(
 `code` char(20) ,
 `name` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `个股公告` */

DROP TABLE IF EXISTS `个股公告`;

/*!50001 DROP VIEW IF EXISTS `个股公告` */;
/*!50001 DROP TABLE IF EXISTS `个股公告` */;

/*!50001 CREATE TABLE  `个股公告`(
 `code` char(20) ,
 `name` varchar(255) ,
 `gn` int(11) ,
 `newsfrom` varchar(200) ,
 `remark` varchar(300) ,
 `updtime` date 
)*/;

/*Table structure for table `买入清单` */

DROP TABLE IF EXISTS `买入清单`;

/*!50001 DROP VIEW IF EXISTS `买入清单` */;
/*!50001 DROP TABLE IF EXISTS `买入清单` */;

/*!50001 CREATE TABLE  `买入清单`(
 `code` varchar(50) ,
 `NAME` varchar(255) ,
 `indate` datetime ,
 `outdate` datetime ,
 `available` int(11) ,
 `available_today` int(11) ,
 `vwap` decimal(8,2) ,
 `fpnl` decimal(8,2) ,
 `sumzf` decimal(8,2) ,
 `inxh` varchar(20) 
)*/;

/*Table structure for table `买入行业` */

DROP TABLE IF EXISTS `买入行业`;

/*!50001 DROP VIEW IF EXISTS `买入行业` */;
/*!50001 DROP TABLE IF EXISTS `买入行业` */;

/*!50001 CREATE TABLE  `买入行业`(
 `hy` varchar(255) 
)*/;

/*Table structure for table `交易记录` */

DROP TABLE IF EXISTS `交易记录`;

/*!50001 DROP VIEW IF EXISTS `交易记录` */;
/*!50001 DROP TABLE IF EXISTS `交易记录` */;

/*!50001 CREATE TABLE  `交易记录`(
 `id` bigint(20) ,
 `code` char(20) ,
 `side` int(1) ,
 `inxh` int(1) ,
 `cost` decimal(8,2) ,
 `price` decimal(8,2) ,
 `nums` int(11) ,
 `fdyk` decimal(8,2) ,
 `in_date` datetime ,
 `tran_date` datetime 
)*/;

/*Table structure for table `今日行业涨幅` */

DROP TABLE IF EXISTS `今日行业涨幅`;

/*!50001 DROP VIEW IF EXISTS `今日行业涨幅` */;
/*!50001 DROP TABLE IF EXISTS `今日行业涨幅` */;

/*!50001 CREATE TABLE  `今日行业涨幅`(
 `hy` varchar(255) ,
 `zf` decimal(9,2) ,
 `gcnt` bigint(21) 
)*/;

/*Table structure for table `优质底位股` */

DROP TABLE IF EXISTS `优质底位股`;

/*!50001 DROP VIEW IF EXISTS `优质底位股` */;
/*!50001 DROP TABLE IF EXISTS `优质底位股` */;

/*!50001 CREATE TABLE  `优质底位股`(
 `code` char(20) ,
 `name` varchar(255) ,
 `hy` varchar(255) 
)*/;

/*Table structure for table `优质股` */

DROP TABLE IF EXISTS `优质股`;

/*!50001 DROP VIEW IF EXISTS `优质股` */;
/*!50001 DROP TABLE IF EXISTS `优质股` */;

/*!50001 CREATE TABLE  `优质股`(
 `CODE` char(20) ,
 `NAME` varchar(255) ,
 `dqj` decimal(8,2) ,
 `hy` varchar(255) ,
 `syl` decimal(15,4) ,
 `ltsz` decimal(10,2) ,
 `mgsy` decimal(10,5) 
)*/;

/*Table structure for table `优选股盘前` */

DROP TABLE IF EXISTS `优选股盘前`;

/*!50001 DROP VIEW IF EXISTS `优选股盘前` */;
/*!50001 DROP TABLE IF EXISTS `优选股盘前` */;

/*!50001 CREATE TABLE  `优选股盘前`(
 `CODE` char(20) ,
 `NAME` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `全局筛选` */

DROP TABLE IF EXISTS `全局筛选`;

/*!50001 DROP VIEW IF EXISTS `全局筛选` */;
/*!50001 DROP TABLE IF EXISTS `全局筛选` */;

/*!50001 CREATE TABLE  `全局筛选`(
 `code` char(20) ,
 `name` varchar(255) ,
 `price` decimal(10,2) ,
 `iscxg` int(11) ,
 `jcdate` time ,
 `ltzb` decimal(17,2) ,
 `ltsz` decimal(10,2) ,
 `zf` decimal(10,2) ,
 `zrzf` decimal(10,2) ,
 `syl` decimal(15,4) ,
 `rsi6` decimal(10,2) ,
 `rsi12` decimal(10,2) ,
 `jx_60` decimal(10,2) ,
 `zrclose` decimal(10,2) ,
 `zfrec` varchar(300) ,
 `hy` varchar(255) ,
 `low5` decimal(10,2) ,
 `zf30` decimal(10,2) ,
 `pj_30_zhengfu` decimal(10,2) 
)*/;

/*Table structure for table `创新低` */

DROP TABLE IF EXISTS `创新低`;

/*!50001 DROP VIEW IF EXISTS `创新低` */;
/*!50001 DROP TABLE IF EXISTS `创新低` */;

/*!50001 CREATE TABLE  `创新低`(
 `code` char(20) ,
 `name` varchar(255) ,
 `syl` decimal(15,4) ,
 `ltsz` decimal(10,2) 
)*/;

/*Table structure for table `利好股` */

DROP TABLE IF EXISTS `利好股`;

/*!50001 DROP VIEW IF EXISTS `利好股` */;
/*!50001 DROP TABLE IF EXISTS `利好股` */;

/*!50001 CREATE TABLE  `利好股`(
 `CODE` char(20) ,
 `NAME` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `合约命中股票` */

DROP TABLE IF EXISTS `合约命中股票`;

/*!50001 DROP VIEW IF EXISTS `合约命中股票` */;
/*!50001 DROP TABLE IF EXISTS `合约命中股票` */;

/*!50001 CREATE TABLE  `合约命中股票`(
 `gps` text 
)*/;

/*Table structure for table `合约命中股票1` */

DROP TABLE IF EXISTS `合约命中股票1`;

/*!50001 DROP VIEW IF EXISTS `合约命中股票1` */;
/*!50001 DROP TABLE IF EXISTS `合约命中股票1` */;

/*!50001 CREATE TABLE  `合约命中股票1`(
 `code` char(20) ,
 `name` varchar(255) 
)*/;

/*Table structure for table `合约排名股票` */

DROP TABLE IF EXISTS `合约排名股票`;

/*!50001 DROP VIEW IF EXISTS `合约排名股票` */;
/*!50001 DROP TABLE IF EXISTS `合约排名股票` */;

/*!50001 CREATE TABLE  `合约排名股票`(
 `code` char(20) ,
 `name` varchar(255) ,
 `qz` bigint(20) 
)*/;

/*Table structure for table `合约排名股票1` */

DROP TABLE IF EXISTS `合约排名股票1`;

/*!50001 DROP VIEW IF EXISTS `合约排名股票1` */;
/*!50001 DROP TABLE IF EXISTS `合约排名股票1` */;

/*!50001 CREATE TABLE  `合约排名股票1`(
 `code` char(20) ,
 `name` varchar(255) 
)*/;

/*Table structure for table `合约概念股票` */

DROP TABLE IF EXISTS `合约概念股票`;

/*!50001 DROP VIEW IF EXISTS `合约概念股票` */;
/*!50001 DROP TABLE IF EXISTS `合约概念股票` */;

/*!50001 CREATE TABLE  `合约概念股票`(
 `gpcode` char(8) ,
 `gpname` varchar(255) 
)*/;

/*Table structure for table `合约行业` */

DROP TABLE IF EXISTS `合约行业`;

/*!50001 DROP VIEW IF EXISTS `合约行业` */;
/*!50001 DROP TABLE IF EXISTS `合约行业` */;

/*!50001 CREATE TABLE  `合约行业`(
 `hy` varchar(50) 
)*/;

/*Table structure for table `合约行业股票` */

DROP TABLE IF EXISTS `合约行业股票`;

/*!50001 DROP VIEW IF EXISTS `合约行业股票` */;
/*!50001 DROP TABLE IF EXISTS `合约行业股票` */;

/*!50001 CREATE TABLE  `合约行业股票`(
 `code` char(20) ,
 `name` varchar(255) 
)*/;

/*Table structure for table `合约龙头` */

DROP TABLE IF EXISTS `合约龙头`;

/*!50001 DROP VIEW IF EXISTS `合约龙头` */;
/*!50001 DROP TABLE IF EXISTS `合约龙头` */;

/*!50001 CREATE TABLE  `合约龙头`(
 `lt` varchar(300) 
)*/;

/*Table structure for table `多头走势` */

DROP TABLE IF EXISTS `多头走势`;

/*!50001 DROP VIEW IF EXISTS `多头走势` */;
/*!50001 DROP TABLE IF EXISTS `多头走势` */;

/*!50001 CREATE TABLE  `多头走势`(
 `code` char(20) ,
 `name` varchar(255) 
)*/;

/*Table structure for table `大宗交易` */

DROP TABLE IF EXISTS `大宗交易`;

/*!50001 DROP VIEW IF EXISTS `大宗交易` */;
/*!50001 DROP TABLE IF EXISTS `大宗交易` */;

/*!50001 CREATE TABLE  `大宗交易`(
 `code` char(20) ,
 `name` varchar(255) ,
 `yk` text ,
 `updtime` date 
)*/;

/*Table structure for table `大热点` */

DROP TABLE IF EXISTS `大热点`;

/*!50001 DROP VIEW IF EXISTS `大热点` */;
/*!50001 DROP TABLE IF EXISTS `大热点` */;

/*!50001 CREATE TABLE  `大热点`(
 `dl` varchar(30) 
)*/;

/*Table structure for table `大热点1` */

DROP TABLE IF EXISTS `大热点1`;

/*!50001 DROP VIEW IF EXISTS `大热点1` */;
/*!50001 DROP TABLE IF EXISTS `大热点1` */;

/*!50001 CREATE TABLE  `大热点1`(
 `dl` varchar(30) ,
 `hyzf` decimal(10,2) 
)*/;

/*Table structure for table `大盘历史` */

DROP TABLE IF EXISTS `大盘历史`;

/*!50001 DROP VIEW IF EXISTS `大盘历史` */;
/*!50001 DROP TABLE IF EXISTS `大盘历史` */;

/*!50001 CREATE TABLE  `大盘历史`(
 `CODE` char(20) ,
 `his` text 
)*/;

/*Table structure for table `异动观察` */

DROP TABLE IF EXISTS `异动观察`;

/*!50001 DROP VIEW IF EXISTS `异动观察` */;
/*!50001 DROP TABLE IF EXISTS `异动观察` */;

/*!50001 CREATE TABLE  `异动观察`(
 `code` char(20) ,
 `name` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `当天龙虎` */

DROP TABLE IF EXISTS `当天龙虎`;

/*!50001 DROP VIEW IF EXISTS `当天龙虎` */;
/*!50001 DROP TABLE IF EXISTS `当天龙虎` */;

/*!50001 CREATE TABLE  `当天龙虎`(
 `code` char(20) ,
 `name` varchar(255) ,
 `zf` decimal(8,2) ,
 `zf_rec` varchar(300) ,
 `trantime` time 
)*/;

/*Table structure for table `当日题材` */

DROP TABLE IF EXISTS `当日题材`;

/*!50001 DROP VIEW IF EXISTS `当日题材` */;
/*!50001 DROP TABLE IF EXISTS `当日题材` */;

/*!50001 CREATE TABLE  `当日题材`(
 `code` char(20) ,
 `name` varchar(255) ,
 `qz` double 
)*/;

/*Table structure for table `投资日历` */

DROP TABLE IF EXISTS `投资日历`;

/*!50001 DROP VIEW IF EXISTS `投资日历` */;
/*!50001 DROP TABLE IF EXISTS `投资日历` */;

/*!50001 CREATE TABLE  `投资日历`(
 `code` char(20) ,
 `name` varchar(255) ,
 `gn` int(11) ,
 `keystr` varchar(2000) ,
 `rl` varchar(50) 
)*/;

/*Table structure for table `投资日历概念` */

DROP TABLE IF EXISTS `投资日历概念`;

/*!50001 DROP VIEW IF EXISTS `投资日历概念` */;
/*!50001 DROP TABLE IF EXISTS `投资日历概念` */;

/*!50001 CREATE TABLE  `投资日历概念`(
 `keystr` varchar(2000) ,
 `rl` varchar(50) ,
 `gn` int(11) 
)*/;

/*Table structure for table `投资计划` */

DROP TABLE IF EXISTS `投资计划`;

/*!50001 DROP VIEW IF EXISTS `投资计划` */;
/*!50001 DROP TABLE IF EXISTS `投资计划` */;

/*!50001 CREATE TABLE  `投资计划`(
 `code` char(20) ,
 `days` bigint(20) ,
 `flag` int(11) ,
 `cls` varchar(30) ,
 `qz` bigint(20) 
)*/;

/*Table structure for table `持续放量` */

DROP TABLE IF EXISTS `持续放量`;

/*!50001 DROP VIEW IF EXISTS `持续放量` */;
/*!50001 DROP TABLE IF EXISTS `持续放量` */;

/*!50001 CREATE TABLE  `持续放量`(
 `code` char(20) ,
 `name` varchar(255) ,
 `syl` decimal(15,4) ,
 `ltsz` decimal(10,2) 
)*/;

/*Table structure for table `指数比较` */

DROP TABLE IF EXISTS `指数比较`;

/*!50001 DROP VIEW IF EXISTS `指数比较` */;
/*!50001 DROP TABLE IF EXISTS `指数比较` */;

/*!50001 CREATE TABLE  `指数比较`(
 `dp_zf_30` decimal(32,2) ,
 `cyb_zf_30` decimal(32,2) ,
 `dp_zf_7` decimal(32,2) ,
 `cyb_zf_7` decimal(32,2) 
)*/;

/*Table structure for table `新股申购` */

DROP TABLE IF EXISTS `新股申购`;

/*!50001 DROP VIEW IF EXISTS `新股申购` */;
/*!50001 DROP TABLE IF EXISTS `新股申购` */;

/*!50001 CREATE TABLE  `新股申购`(
 `keystr` varchar(200) ,
 `ssdate` varchar(5) ,
 `updtime` date 
)*/;

/*Table structure for table `早盘必读` */

DROP TABLE IF EXISTS `早盘必读`;

/*!50001 DROP VIEW IF EXISTS `早盘必读` */;
/*!50001 DROP TABLE IF EXISTS `早盘必读` */;

/*!50001 CREATE TABLE  `早盘必读`(
 `code` char(20) ,
 `name` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `早盘必读概念` */

DROP TABLE IF EXISTS `早盘必读概念`;

/*!50001 DROP VIEW IF EXISTS `早盘必读概念` */;
/*!50001 DROP TABLE IF EXISTS `早盘必读概念` */;

/*!50001 CREATE TABLE  `早盘必读概念`(
 `gn` int(11) ,
 `keystr` varchar(200) ,
 `updtime` date 
)*/;

/*Table structure for table `机会情报` */

DROP TABLE IF EXISTS `机会情报`;

/*!50001 DROP VIEW IF EXISTS `机会情报` */;
/*!50001 DROP TABLE IF EXISTS `机会情报` */;

/*!50001 CREATE TABLE  `机会情报`(
 `code` char(20) ,
 `name` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `机会情报概念` */

DROP TABLE IF EXISTS `机会情报概念`;

/*!50001 DROP VIEW IF EXISTS `机会情报概念` */;
/*!50001 DROP TABLE IF EXISTS `机会情报概念` */;

/*!50001 CREATE TABLE  `机会情报概念`(
 `gn` int(11) ,
 `keystr` varchar(200) ,
 `updtime` date 
)*/;

/*Table structure for table `权重值` */

DROP TABLE IF EXISTS `权重值`;

/*!50001 DROP VIEW IF EXISTS `权重值` */;
/*!50001 DROP TABLE IF EXISTS `权重值` */;

/*!50001 CREATE TABLE  `权重值`(
 `gnz` varchar(63) 
)*/;

/*Table structure for table `概念排名` */

DROP TABLE IF EXISTS `概念排名`;

/*!50001 DROP VIEW IF EXISTS `概念排名` */;
/*!50001 DROP TABLE IF EXISTS `概念排名` */;

/*!50001 CREATE TABLE  `概念排名`(
 `gn` char(50) ,
 `gnname` varchar(255) ,
 `zf` decimal(10,2) ,
 `zf7` varchar(54) 
)*/;

/*Table structure for table `概念排名1` */

DROP TABLE IF EXISTS `概念排名1`;

/*!50001 DROP VIEW IF EXISTS `概念排名1` */;
/*!50001 DROP TABLE IF EXISTS `概念排名1` */;

/*!50001 CREATE TABLE  `概念排名1`(
 `gn` char(50) ,
 `gnname` varchar(255) ,
 `zf` decimal(10,2) 
)*/;

/*Table structure for table `概念排名2` */

DROP TABLE IF EXISTS `概念排名2`;

/*!50001 DROP VIEW IF EXISTS `概念排名2` */;
/*!50001 DROP TABLE IF EXISTS `概念排名2` */;

/*!50001 CREATE TABLE  `概念排名2`(
 `gn` char(50) ,
 `gnname` varchar(255) ,
 `zf` decimal(10,2) 
)*/;

/*Table structure for table `概念排名5` */

DROP TABLE IF EXISTS `概念排名5`;

/*!50001 DROP VIEW IF EXISTS `概念排名5` */;
/*!50001 DROP TABLE IF EXISTS `概念排名5` */;

/*!50001 CREATE TABLE  `概念排名5`(
 `gn` char(50) ,
 `gnname` varchar(255) ,
 `zf` decimal(10,2) 
)*/;

/*Table structure for table `概念排名_max` */

DROP TABLE IF EXISTS `概念排名_max`;

/*!50001 DROP VIEW IF EXISTS `概念排名_max` */;
/*!50001 DROP TABLE IF EXISTS `概念排名_max` */;

/*!50001 CREATE TABLE  `概念排名_max`(
 `gn` char(50) ,
 `gnname` varchar(255) ,
 `zf` decimal(10,2) ,
 `zf7` varchar(54) 
)*/;

/*Table structure for table `概念权重` */

DROP TABLE IF EXISTS `概念权重`;

/*!50001 DROP VIEW IF EXISTS `概念权重` */;
/*!50001 DROP TABLE IF EXISTS `概念权重` */;

/*!50001 CREATE TABLE  `概念权重`(
 `gn` bigint(30) ,
 `gnname` varchar(255) ,
 `flag` double 
)*/;

/*Table structure for table `概念涨停` */

DROP TABLE IF EXISTS `概念涨停`;

/*!50001 DROP VIEW IF EXISTS `概念涨停` */;
/*!50001 DROP TABLE IF EXISTS `概念涨停` */;

/*!50001 CREATE TABLE  `概念涨停`(
 `gn` bigint(30) ,
 `gnname` varchar(255) ,
 `cnt` bigint(21) 
)*/;

/*Table structure for table `概念资金` */

DROP TABLE IF EXISTS `概念资金`;

/*!50001 DROP VIEW IF EXISTS `概念资金` */;
/*!50001 DROP TABLE IF EXISTS `概念资金` */;

/*!50001 CREATE TABLE  `概念资金`(
 `keystr` varchar(200) ,
 `fd` decimal(10,0) 
)*/;

/*Table structure for table `概念集合` */

DROP TABLE IF EXISTS `概念集合`;

/*!50001 DROP VIEW IF EXISTS `概念集合` */;
/*!50001 DROP TABLE IF EXISTS `概念集合` */;

/*!50001 CREATE TABLE  `概念集合`(
 `gn` int(11) ,
 `keystr` varchar(200) ,
 `updtime` date 
)*/;

/*Table structure for table `涨停榜` */

DROP TABLE IF EXISTS `涨停榜`;

/*!50001 DROP VIEW IF EXISTS `涨停榜` */;
/*!50001 DROP TABLE IF EXISTS `涨停榜` */;

/*!50001 CREATE TABLE  `涨停榜`(
 `hy` varchar(255) ,
 `cnt` bigint(21) 
)*/;

/*Table structure for table `涨跌幅排行` */

DROP TABLE IF EXISTS `涨跌幅排行`;

/*!50001 DROP VIEW IF EXISTS `涨跌幅排行` */;
/*!50001 DROP TABLE IF EXISTS `涨跌幅排行` */;

/*!50001 CREATE TABLE  `涨跌幅排行`(
 `code` char(20) ,
 `name` varchar(255) ,
 `zf` decimal(8,2) ,
 `jrzgj` decimal(8,2) ,
 `jrzdj` decimal(8,2) ,
 `dqj` decimal(8,2) ,
 `jj` decimal(20,2) ,
 `hsl` decimal(8,2) ,
 `zhengf` decimal(8,2) ,
 `ltsz` decimal(10,2) ,
 `syl` decimal(15,4) 
)*/;

/*Table structure for table `热点排序` */

DROP TABLE IF EXISTS `热点排序`;

/*!50001 DROP VIEW IF EXISTS `热点排序` */;
/*!50001 DROP TABLE IF EXISTS `热点排序` */;

/*!50001 CREATE TABLE  `热点排序`(
 `gn` char(50) ,
 `gnname` varchar(255) ,
 `gnzf` decimal(12,6) ,
 `date` date 
)*/;

/*Table structure for table `统计榜单` */

DROP TABLE IF EXISTS `统计榜单`;

/*!50001 DROP VIEW IF EXISTS `统计榜单` */;
/*!50001 DROP TABLE IF EXISTS `统计榜单` */;

/*!50001 CREATE TABLE  `统计榜单`(
 `hy` varchar(255) ,
 `zf` decimal(26,4) 
)*/;

/*Table structure for table `股票复盘` */

DROP TABLE IF EXISTS `股票复盘`;

/*!50001 DROP VIEW IF EXISTS `股票复盘` */;
/*!50001 DROP TABLE IF EXISTS `股票复盘` */;

/*!50001 CREATE TABLE  `股票复盘`(
 `code` char(20) ,
 `name` varchar(255) ,
 `syl` decimal(15,4) ,
 `ltsz` decimal(10,2) ,
 `eventtype` varchar(100) 
)*/;

/*Table structure for table `股票池` */

DROP TABLE IF EXISTS `股票池`;

/*!50001 DROP VIEW IF EXISTS `股票池` */;
/*!50001 DROP TABLE IF EXISTS `股票池` */;

/*!50001 CREATE TABLE  `股票池`(
 `code` char(20) ,
 `name` varchar(255) ,
 `zf` decimal(8,2) 
)*/;

/*Table structure for table `行业倒序` */

DROP TABLE IF EXISTS `行业倒序`;

/*!50001 DROP VIEW IF EXISTS `行业倒序` */;
/*!50001 DROP TABLE IF EXISTS `行业倒序` */;

/*!50001 CREATE TABLE  `行业倒序`(
 `hy` varchar(255) ,
 `hyzf` decimal(10,2) ,
 `hy_zf3` decimal(11,2) ,
 `hy_zf7` decimal(11,2) 
)*/;

/*Table structure for table `行业排名1` */

DROP TABLE IF EXISTS `行业排名1`;

/*!50001 DROP VIEW IF EXISTS `行业排名1` */;
/*!50001 DROP TABLE IF EXISTS `行业排名1` */;

/*!50001 CREATE TABLE  `行业排名1`(
 `hy` varchar(50) 
)*/;

/*Table structure for table `行业排名6` */

DROP TABLE IF EXISTS `行业排名6`;

/*!50001 DROP VIEW IF EXISTS `行业排名6` */;
/*!50001 DROP TABLE IF EXISTS `行业排名6` */;

/*!50001 CREATE TABLE  `行业排名6`(
 `hy` varchar(50) 
)*/;

/*Table structure for table `行业排名_max` */

DROP TABLE IF EXISTS `行业排名_max`;

/*!50001 DROP VIEW IF EXISTS `行业排名_max` */;
/*!50001 DROP TABLE IF EXISTS `行业排名_max` */;

/*!50001 CREATE TABLE  `行业排名_max`(
 `hy` varchar(255) ,
 `hyzf` decimal(10,2) ,
 `hy_zf3` decimal(11,2) ,
 `hy_zf7` decimal(11,2) 
)*/;

/*Table structure for table `行业涨停` */

DROP TABLE IF EXISTS `行业涨停`;

/*!50001 DROP VIEW IF EXISTS `行业涨停` */;
/*!50001 DROP TABLE IF EXISTS `行业涨停` */;

/*!50001 CREATE TABLE  `行业涨停`(
 `hy` varchar(255) ,
 `cnt` bigint(21) 
)*/;

/*Table structure for table `财经要闻` */

DROP TABLE IF EXISTS `财经要闻`;

/*!50001 DROP VIEW IF EXISTS `财经要闻` */;
/*!50001 DROP TABLE IF EXISTS `财经要闻` */;

/*!50001 CREATE TABLE  `财经要闻`(
 `gn` int(11) ,
 `keystr` varchar(200) ,
 `remark` varchar(200) ,
 `updtime` date 
)*/;

/*Table structure for table `近期有涨停` */

DROP TABLE IF EXISTS `近期有涨停`;

/*!50001 DROP VIEW IF EXISTS `近期有涨停` */;
/*!50001 DROP TABLE IF EXISTS `近期有涨停` */;

/*!50001 CREATE TABLE  `近期有涨停`(
 `code` char(20) ,
 `name` varchar(255) ,
 `zf_rec` varchar(300) 
)*/;

/*Table structure for table `送股派息` */

DROP TABLE IF EXISTS `送股派息`;

/*!50001 DROP VIEW IF EXISTS `送股派息` */;
/*!50001 DROP TABLE IF EXISTS `送股派息` */;

/*!50001 CREATE TABLE  `送股派息`(
 `code` char(20) ,
 `name` varchar(255) ,
 `remark` varchar(300) ,
 `updtime` date 
)*/;

/*Table structure for table `限售解禁` */

DROP TABLE IF EXISTS `限售解禁`;

/*!50001 DROP VIEW IF EXISTS `限售解禁` */;
/*!50001 DROP TABLE IF EXISTS `限售解禁` */;

/*!50001 CREATE TABLE  `限售解禁`(
 `code` char(20) ,
 `name` varchar(255) ,
 `remark` varchar(300) ,
 `updtime` date 
)*/;

/*Table structure for table `险资举牌` */

DROP TABLE IF EXISTS `险资举牌`;

/*!50001 DROP VIEW IF EXISTS `险资举牌` */;
/*!50001 DROP TABLE IF EXISTS `险资举牌` */;

/*!50001 CREATE TABLE  `险资举牌`(
 `code` char(20) ,
 `name` varchar(255) ,
 `remark` varchar(300) ,
 `ltsz` decimal(10,2) ,
 `updtime` date 
)*/;

/*Table structure for table `高管持股` */

DROP TABLE IF EXISTS `高管持股`;

/*!50001 DROP VIEW IF EXISTS `高管持股` */;
/*!50001 DROP TABLE IF EXISTS `高管持股` */;

/*!50001 CREATE TABLE  `高管持股`(
 `code` char(20) ,
 `name` varchar(255) ,
 `updtime` date 
)*/;

/*Table structure for table `黑天鹅` */

DROP TABLE IF EXISTS `黑天鹅`;

/*!50001 DROP VIEW IF EXISTS `黑天鹅` */;
/*!50001 DROP TABLE IF EXISTS `黑天鹅` */;

/*!50001 CREATE TABLE  `黑天鹅`(
 `id` int(20) ,
 `gn` char(50) ,
 `gpcode` char(8) ,
 `gpname` varchar(255) 
)*/;

/*Table structure for table `龙虎榜` */

DROP TABLE IF EXISTS `龙虎榜`;

/*!50001 DROP VIEW IF EXISTS `龙虎榜` */;
/*!50001 DROP TABLE IF EXISTS `龙虎榜` */;

/*!50001 CREATE TABLE  `龙虎榜`(
 `code` varchar(30) ,
 `name` varchar(50) ,
 `zjjd` varchar(200) ,
 `zdf` varchar(40) ,
 `type` varchar(100) ,
 `date` datetime 
)*/;

/*Table structure for table `codeview` */

DROP TABLE IF EXISTS `codeview`;

/*!50001 DROP VIEW IF EXISTS `codeview` */;
/*!50001 DROP TABLE IF EXISTS `codeview` */;

/*!50001 CREATE TABLE  `codeview`(
 `codeid` bigint(8) ,
 `field` varchar(15) ,
 `fieldname` varchar(20) ,
 `code` varchar(10) ,
 `codedesc` varchar(100) ,
 `sortno` int(4) 
)*/;

/*Table structure for table `inheyref` */

DROP TABLE IF EXISTS `inheyref`;

/*!50001 DROP VIEW IF EXISTS `inheyref` */;
/*!50001 DROP TABLE IF EXISTS `inheyref` */;

/*!50001 CREATE TABLE  `inheyref`(
 `xl` varchar(30) 
)*/;

/*Table structure for table `lostgps` */

DROP TABLE IF EXISTS `lostgps`;

/*!50001 DROP VIEW IF EXISTS `lostgps` */;
/*!50001 DROP TABLE IF EXISTS `lostgps` */;

/*!50001 CREATE TABLE  `lostgps`(
 `code` char(20) ,
 `name` varchar(255) 
)*/;

/*Table structure for table `maxid` */

DROP TABLE IF EXISTS `maxid`;

/*!50001 DROP VIEW IF EXISTS `maxid` */;
/*!50001 DROP TABLE IF EXISTS `maxid` */;

/*!50001 CREATE TABLE  `maxid`(
 `MAX(gptoday.id)` bigint(20) 
)*/;

/*Table structure for table `newgps` */

DROP TABLE IF EXISTS `newgps`;

/*!50001 DROP VIEW IF EXISTS `newgps` */;
/*!50001 DROP TABLE IF EXISTS `newgps` */;

/*!50001 CREATE TABLE  `newgps`(
 `id` int(20) ,
 `gn` char(50) ,
 `gpcode` char(8) ,
 `gpname` varchar(255) 
)*/;

/*Table structure for table `storegns` */

DROP TABLE IF EXISTS `storegns`;

/*!50001 DROP VIEW IF EXISTS `storegns` */;
/*!50001 DROP TABLE IF EXISTS `storegns` */;

/*!50001 CREATE TABLE  `storegns`(
 `gpcode` char(8) 
)*/;

/*Table structure for table `todaytc` */

DROP TABLE IF EXISTS `todaytc`;

/*!50001 DROP VIEW IF EXISTS `todaytc` */;
/*!50001 DROP TABLE IF EXISTS `todaytc` */;

/*!50001 CREATE TABLE  `todaytc`(
 `code` char(20) ,
 `name` varchar(255) ,
 `qz` double ,
 `sx` bigint(20) 
)*/;

/*Table structure for table `todaytcgps` */

DROP TABLE IF EXISTS `todaytcgps`;

/*!50001 DROP VIEW IF EXISTS `todaytcgps` */;
/*!50001 DROP TABLE IF EXISTS `todaytcgps` */;

/*!50001 CREATE TABLE  `todaytcgps`(
 `code` char(20) ,
 `name` varchar(255) ,
 `qz` double 
)*/;

/*Table structure for table `xsjj` */

DROP TABLE IF EXISTS `xsjj`;

/*!50001 DROP VIEW IF EXISTS `xsjj` */;
/*!50001 DROP TABLE IF EXISTS `xsjj` */;

/*!50001 CREATE TABLE  `xsjj`(
 `code` varchar(10) ,
 `name` varchar(30) ,
 `xsdate` varchar(30) ,
 `bqjj` varchar(30) ,
 `dqj` decimal(10,2) ,
 `zjj` varchar(30) ,
 `zbbl` decimal(10,2) 
)*/;

/*Table structure for table `ztgn` */

DROP TABLE IF EXISTS `ztgn`;

/*!50001 DROP VIEW IF EXISTS `ztgn` */;
/*!50001 DROP TABLE IF EXISTS `ztgn` */;

/*!50001 CREATE TABLE  `ztgn`(
 `gn` bigint(30) ,
 `gnname` varchar(255) 
)*/;

/*Table structure for table `zthy` */

DROP TABLE IF EXISTS `zthy`;

/*!50001 DROP VIEW IF EXISTS `zthy` */;
/*!50001 DROP TABLE IF EXISTS `zthy` */;

/*!50001 CREATE TABLE  `zthy`(
 `hy` varchar(255) 
)*/;

/*Table structure for table `zttoday` */

DROP TABLE IF EXISTS `zttoday`;

/*!50001 DROP VIEW IF EXISTS `zttoday` */;
/*!50001 DROP TABLE IF EXISTS `zttoday` */;

/*!50001 CREATE TABLE  `zttoday`(
 `code` char(20) ,
 `name` varchar(255) ,
 `zf` decimal(8,2) ,
 `trantime` time 
)*/;

/*View structure for view 业绩快报 */

/*!50001 DROP TABLE IF EXISTS `业绩快报` */;
/*!50001 DROP VIEW IF EXISTS `业绩快报` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `业绩快报` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '业绩快报') and (`n`.`updtime` >= `get_tran_date`())) */;

/*View structure for view 业绩预增 */

/*!50001 DROP TABLE IF EXISTS `业绩预增` */;
/*!50001 DROP VIEW IF EXISTS `业绩预增` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `业绩预增` AS select `g`.`code` AS `code`,`n`.`keystr` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '业绩预增') and (`n`.`updtime` >= `get_tran_date`()) and ((locate('上升',`n`.`remark`) > 0) or (locate('预盈',`n`.`remark`) > 0) or (locate('预增',`n`.`remark`) > 0) or (locate('扭亏',`n`.`remark`) > 0))) */;

/*View structure for view 业绩预披 */

/*!50001 DROP TABLE IF EXISTS `业绩预披` */;
/*!50001 DROP VIEW IF EXISTS `业绩预披` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `业绩预披` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`g`.`name` = `n`.`keystr`) and (`n`.`newsfrom` = '业绩预披')) order by `n`.`updtime` limit 0,3 */;

/*View structure for view 个股公告 */

/*!50001 DROP TABLE IF EXISTS `个股公告` */;
/*!50001 DROP VIEW IF EXISTS `个股公告` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `个股公告` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`gn` AS `gn`,`n`.`newsfrom` AS `newsfrom`,`n`.`remark` AS `remark`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '个股公告') and (locate('停牌',`n`.`remark`) <= 0)) */;

/*View structure for view 买入清单 */

/*!50001 DROP TABLE IF EXISTS `买入清单` */;
/*!50001 DROP VIEW IF EXISTS `买入清单` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `买入清单` AS select `p`.`code` AS `code`,if((`p`.`code` = '000001'),'上证',if((`p`.`code` = '399006'),'创业板',if((`p`.`code` = '399001'),'深市',`g`.`name`))) AS `NAME`,`p`.`indate` AS `indate`,`p`.`outdate` AS `outdate`,`p`.`available` AS `available`,`p`.`available_today` AS `available_today`,`p`.`vwap` AS `vwap`,`p`.`fpnl` AS `fpnl`,`p`.`sumzf` AS `sumzf`,ifnull(`xh`.`name`,'售出') AS `inxh` from ((`position` `p` left join `xh` on((`p`.`inxh` = `xh`.`xh`))) left join `gp` `g` on((`p`.`code` = `g`.`code`))) order by `p`.`fpnl` desc */;

/*View structure for view 买入行业 */

/*!50001 DROP TABLE IF EXISTS `买入行业` */;
/*!50001 DROP VIEW IF EXISTS `买入行业` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `买入行业` AS select distinct `g`.`hy` AS `hy` from (`position` `p` join `gp` `g`) where ((`p`.`available` > 0) and (`p`.`code` = `g`.`code`)) group by `g`.`hy` having (count(`g`.`hy`) > 0) */;

/*View structure for view 交易记录 */

/*!50001 DROP TABLE IF EXISTS `交易记录` */;
/*!50001 DROP VIEW IF EXISTS `交易记录` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `交易记录` AS select `t`.`id` AS `id`,`t`.`code` AS `code`,`t`.`side` AS `side`,`t`.`inxh` AS `inxh`,`t`.`cost` AS `cost`,`t`.`price` AS `price`,`t`.`nums` AS `nums`,`t`.`fdyk` AS `fdyk`,`t`.`in_date` AS `in_date`,`t`.`tran_date` AS `tran_date` from `tranhis` `t` order by `t`.`code`,`t`.`tran_date` */;

/*View structure for view 今日行业涨幅 */

/*!50001 DROP TABLE IF EXISTS `今日行业涨幅` */;
/*!50001 DROP VIEW IF EXISTS `今日行业涨幅` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `今日行业涨幅` AS select `g1`.`hy` AS `hy`,round(avg(`g`.`zf`),2) AS `zf`,count(`g1`.`code`) AS `gcnt` from (`gptoday` `g` join `gp` `g1`) where ((`g`.`code` = `g1`.`code`) and (`g`.`zf` <> -(100)) and (`g`.`zf` < 10.2)) group by `g1`.`hy` order by avg(`g`.`zf`) desc */;

/*View structure for view 优质底位股 */

/*!50001 DROP TABLE IF EXISTS `优质底位股` */;
/*!50001 DROP VIEW IF EXISTS `优质底位股` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `优质底位股` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name`,`g1`.`hy` AS `hy` from ((`gpzfrec` `g` join `gp` `g1`) join `gptoday` `g2`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g1`.`ltsz` < 1500) and (`g1`.`syl` <= 60) and (`g`.`rsi_6` <= 50) and (`g`.`rsi_12` <= 60) and (round((((`g1`.`zsz` - `g1`.`ltsz`) / `g1`.`zsz`) * 100),2) <= 10) and (`g1`.`hy` not in ('机场航运','中药','银行','证券','化学制药','零售','电力','贸易','物流','传媒','保险及其他','燃气水务','房地产开发','汽车整车','港口航运','公路铁路运输')) and (`g2`.`dqj` < 50) and (`g2`.`cj_amt` > 0)) order by `g1`.`hy` */;

/*View structure for view 优质股 */

/*!50001 DROP TABLE IF EXISTS `优质股` */;
/*!50001 DROP VIEW IF EXISTS `优质股` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `优质股` AS select `g`.`code` AS `CODE`,`g`.`name` AS `NAME`,`gt`.`dqj` AS `dqj`,`g`.`hy` AS `hy`,`g`.`syl` AS `syl`,`g`.`ltsz` AS `ltsz`,`g`.`mgsy` AS `mgsy` from (`gp` `g` join `gptoday` `gt`) where ((`g`.`code` = `gt`.`code`) and (`g`.`syl` >= 0) and (`g`.`syl` <= 45) and (`g`.`ltsz` <= 1000) and (`gt`.`dqj` <= 40) and (`gt`.`dqj` > 0) and (not(`g`.`code` in (select `限售解禁`.`code` from `限售解禁`))) and (not(`g`.`code` in (select `黑天鹅`.`gpcode` from `黑天鹅`)))) order by `g`.`ltsz` */;

/*View structure for view 优选股盘前 */

/*!50001 DROP TABLE IF EXISTS `优选股盘前` */;
/*!50001 DROP VIEW IF EXISTS `优选股盘前` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `优选股盘前` AS select `yxg`.`CODE` AS `CODE`,`yxg`.`NAME` AS `NAME`,`yxg`.`updtime` AS `updtime` from `利好股` `yxg` where ((not(`yxg`.`CODE` in (select `限售解禁`.`code` from `限售解禁`))) and (not(`yxg`.`CODE` in (select `个股公告`.`code` from `个股公告` where (`个股公告`.`gn` = -(1))))) and (`yxg`.`CODE` not in ('sh000001','int_dji'))) order by `yxg`.`updtime` desc */;

/*View structure for view 全局筛选 */

/*!50001 DROP TABLE IF EXISTS `全局筛选` */;
/*!50001 DROP VIEW IF EXISTS `全局筛选` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `全局筛选` AS select distinct `g1`.`code` AS `code`,`g1`.`name` AS `name`,`g`.`price` AS `price`,`g2`.`is_cxg` AS `iscxg`,cast(`g`.`jcdate` as time) AS `jcdate`,round((((`g1`.`zsz` - `g1`.`ltsz`) / `g1`.`zsz`) * 100),2) AS `ltzb`,`g1`.`ltsz` AS `ltsz`,`g`.`zf` AS `zf`,`g2`.`zf` AS `zrzf`,`g1`.`syl` AS `syl`,`g2`.`rsi_6` AS `rsi6`,`g2`.`rsi_12` AS `rsi12`,`g2`.`jx_60` AS `jx_60`,`g2`.`zr_close` AS `zrclose`,`g2`.`zf_rec` AS `zfrec`,`g1`.`hy` AS `hy`,`g2`.`low_5` AS `low5`,`g2`.`zf30` AS `zf30`,`g2`.`pj_30_zhengfu` AS `pj_30_zhengfu` from ((`qjsel` `g` join `gp` `g1`) join `gpzfrec` `g2`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`)) order by `g`.`zf` desc,`g`.`jcdate` */;

/*View structure for view 创新低 */

/*!50001 DROP TABLE IF EXISTS `创新低` */;
/*!50001 DROP VIEW IF EXISTS `创新低` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `创新低` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,ifnull(`g`.`syl`,99999) AS `syl`,`g`.`ltsz` AS `ltsz` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '创新低')) order by ifnull(`g`.`syl`,99999) */;

/*View structure for view 利好股 */

/*!50001 DROP TABLE IF EXISTS `利好股` */;
/*!50001 DROP VIEW IF EXISTS `利好股` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `利好股` AS select distinct `yz`.`code` AS `CODE`,`yz`.`name` AS `NAME`,`yz`.`updtime` AS `updtime` from `业绩预增` `yz` union all select `yp`.`code` AS `CODE`,`yp`.`name` AS `NAME`,`yp`.`updtime` AS `updtime` from `业绩预披` `yp` union all select `tzrl`.`code` AS `CODE`,`tzrl`.`name` AS `NAME`,now() AS `updtime` from `投资日历` `tzrl` union all select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '今日要闻') and (`n`.`gn` = 0) and (`n`.`keystr` not in ('道琼斯','创业板','同花顺')) and (not((`n`.`keystr` like '%证券')))) union all select `gg`.`code` AS `CODE`,`gg`.`name` AS `NAME`,`gg`.`updtime` AS `updtime` from `个股公告` `gg` where (`gg`.`gn` = 1) union all select `cg`.`code` AS `CODE`,`cg`.`name` AS `NAME`,`cg`.`updtime` AS `updtime` from `高管持股` `cg` union all select `jh`.`code` AS `CODE`,`jh`.`name` AS `NAME`,`jh`.`updtime` AS `updtime` from `机会情报` `jh` union all select `sg`.`code` AS `CODE`,`sg`.`name` AS `NAME`,`sg`.`updtime` AS `updtime` from `送股派息` `sg` union all select `jp`.`code` AS `CODE`,`jp`.`name` AS `NAME`,`jp`.`updtime` AS `updtime` from `险资举牌` `jp` union all select `zp`.`code` AS `CODE`,`zp`.`name` AS `NAME`,`zp`.`updtime` AS `updtime` from `早盘必读` `zp` */;

/*View structure for view 合约命中股票 */

/*!50001 DROP TABLE IF EXISTS `合约命中股票` */;
/*!50001 DROP VIEW IF EXISTS `合约命中股票` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约命中股票` AS select group_concat(`h1`.`gps` separator ',') AS `gps` from (((`gptoday` `g` join `hey` `h`) join `gpzfrec` `g1`) join `heyref` `h1`) where ((`g`.`code` = `h`.`slcode`) and (`h`.`code` = `g1`.`code`) and (`h`.`code` = `h1`.`hey`) and (`g`.`zf` >= 1.5) and (`h1`.`gps` is not null)) order by `g`.`zf` desc */;

/*View structure for view 合约命中股票1 */

/*!50001 DROP TABLE IF EXISTS `合约命中股票1` */;
/*!50001 DROP VIEW IF EXISTS `合约命中股票1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约命中股票1` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name` from (`合约命中股票` `g` join `gp` `g1`) where (locate(`g1`.`name`,`g`.`gps`) <> 0) */;

/*View structure for view 合约排名股票 */

/*!50001 DROP TABLE IF EXISTS `合约排名股票` */;
/*!50001 DROP VIEW IF EXISTS `合约排名股票` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约排名股票` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name`,0 AS `qz` from (((`合约龙头` `g` join `gp` `g1`) join `gpzfrec` `g2`) join `gptoday` `g3`) where ((`g`.`lt` = `g1`.`name`) and (`g1`.`code` = `g2`.`code`) and (`g1`.`code` = `g3`.`code`) and (`g3`.`cj_amt` > 0) and (`g3`.`dqj` < 60) and (`g2`.`rsi_6` < 60) and (`g3`.`zf` > 1) and (`g3`.`zf` <= 4) and (`g3`.`dqj` > `g3`.`jj`)) union all select `g1`.`code` AS `code`,`g1`.`name` AS `name`,1 AS `qz` from (((`合约命中股票1` `g` join `gp` `g1`) join `gpzfrec` `g2`) join `gptoday` `g3`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g1`.`code` = `g3`.`code`) and (`g3`.`cj_amt` > 0) and (`g3`.`dqj` < 60) and (`g2`.`rsi_6` < 60) and (`g3`.`zf` > 1) and (`g3`.`zf` <= 4) and (`g3`.`dqj` > `g3`.`jj`)) union all select `g1`.`code` AS `code`,`g1`.`name` AS `name`,2 AS `qz` from (((`合约概念股票` `g` join `gp` `g1`) join `gpzfrec` `g2`) join `gptoday` `g3`) where ((`g`.`gpcode` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g1`.`code` = `g3`.`code`) and (`g3`.`cj_amt` > 0) and (`g3`.`dqj` < 60) and (`g2`.`rsi_6` < 60) and (`g3`.`zf` > 1) and (`g3`.`zf` <= 4) and (`g3`.`dqj` > `g3`.`jj`)) union all select `g1`.`code` AS `code`,`g1`.`name` AS `name`,3 AS `qz` from (((`合约行业股票` `g` join `gp` `g1`) join `gpzfrec` `g2`) join `gptoday` `g3`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g1`.`code` = `g3`.`code`) and (`g3`.`cj_amt` > 0) and (`g3`.`dqj` < 60) and (`g2`.`rsi_6` < 60) and (`g3`.`zf` > 1) and (`g3`.`zf` <= 4) and (`g3`.`dqj` > `g3`.`jj`)) */;

/*View structure for view 合约排名股票1 */

/*!50001 DROP TABLE IF EXISTS `合约排名股票1` */;
/*!50001 DROP VIEW IF EXISTS `合约排名股票1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约排名股票1` AS select distinct `t`.`code` AS `code`,`t`.`name` AS `name` from (`合约排名股票` `t` join `gp` `g`) where (`t`.`code` = `g`.`code`) order by `t`.`qz`,`g`.`syl` */;

/*View structure for view 合约概念股票 */

/*!50001 DROP TABLE IF EXISTS `合约概念股票` */;
/*!50001 DROP VIEW IF EXISTS `合约概念股票` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约概念股票` AS select distinct `g2`.`gpcode` AS `gpcode`,`g2`.`gpname` AS `gpname` from (((((`gptoday` `g` join `hey` `h`) join `gpzfrec` `g1`) join `heyref` `h1`) join `gn2gp` `g2`) join `gn`) where ((`g`.`code` = `h`.`slcode`) and (`h`.`code` = `g1`.`code`) and (`h`.`code` = `h1`.`hey`) and (`g2`.`gn` = `gn`.`gn`) and (`h1`.`gn` = `gn`.`gnname`) and (`g`.`zf` >= 1.5) and (`h1`.`gn` is not null)) order by `g`.`zf` desc */;

/*View structure for view 合约行业 */

/*!50001 DROP TABLE IF EXISTS `合约行业` */;
/*!50001 DROP VIEW IF EXISTS `合约行业` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约行业` AS select distinct `h1`.`hy` AS `hy` from (((`gptoday` `g` join `hey` `h`) join `gpzfrec` `g1`) join `heyref` `h1`) where ((`g`.`code` = `h`.`slcode`) and (`h`.`code` = `g1`.`code`) and (`h`.`code` = `h1`.`hey`) and (`g`.`zf` >= 1.5) and (`h1`.`hy` is not null)) order by `g`.`zf` desc */;

/*View structure for view 合约行业股票 */

/*!50001 DROP TABLE IF EXISTS `合约行业股票` */;
/*!50001 DROP VIEW IF EXISTS `合约行业股票` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约行业股票` AS select `g`.`code` AS `code`,`g`.`name` AS `name` from (`gp` `g` join `gptoday` `g1`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`cj_amt` > 0) and `g`.`hy` in (select `合约行业`.`hy` from `合约行业`)) */;

/*View structure for view 合约龙头 */

/*!50001 DROP TABLE IF EXISTS `合约龙头` */;
/*!50001 DROP VIEW IF EXISTS `合约龙头` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `合约龙头` AS select `h1`.`lt` AS `lt` from (((`gptoday` `g` join `hey` `h`) join `gpzfrec` `g1`) join `heyref` `h1`) where ((`g`.`code` = `h`.`slcode`) and (`h`.`code` = `g1`.`code`) and (`h`.`code` = `h1`.`hey`) and (`g`.`zf` >= 1.5) and (`h1`.`lt` is not null)) order by `g`.`zf` desc */;

/*View structure for view 多头走势 */

/*!50001 DROP TABLE IF EXISTS `多头走势` */;
/*!50001 DROP VIEW IF EXISTS `多头走势` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `多头走势` AS select `g`.`code` AS `code`,`g`.`name` AS `name` from ((`gp` `g` join `gpzfrec` `g1`) join `gptoday` `g2`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g2`.`dqj` > `g1`.`top_30`)) */;

/*View structure for view 大宗交易 */

/*!50001 DROP TABLE IF EXISTS `大宗交易` */;
/*!50001 DROP VIEW IF EXISTS `大宗交易` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `大宗交易` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,substr(`n`.`remark`,(locate('||',`n`.`remark`) + 2)) AS `yk`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '大众交易') and (replace(substr(`n`.`remark`,(locate('||',`n`.`remark`) + 2)),'%','') >= 0)) order by replace(substr(`n`.`remark`,(locate('||',`n`.`remark`) + 2)),'%','') desc */;

/*View structure for view 大热点 */

/*!50001 DROP TABLE IF EXISTS `大热点` */;
/*!50001 DROP VIEW IF EXISTS `大热点` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `大热点` AS select distinct `大热点1`.`dl` AS `dl` from `大热点1` where (`大热点1`.`dl` not in ('yiyao','jr')) order by `大热点1`.`dl`,`大热点1`.`hyzf` desc limit 0,2 */;

/*View structure for view 大热点1 */

/*!50001 DROP TABLE IF EXISTS `大热点1` */;
/*!50001 DROP VIEW IF EXISTS `大热点1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `大热点1` AS select distinct `r`.`dl` AS `dl`,`m`.`hyzf` AS `hyzf` from (`行业排名_max` `m` join `hyref` `r`) where (`m`.`hy` = `r`.`xl`) group by `r`.`dl`,`m`.`hyzf` desc union all select distinct `r`.`dl` AS `dl`,`m`.`zf` AS `zf` from (`概念排名_max` `m` join `hyref` `r`) where (`m`.`gn` = `r`.`xl`) group by `r`.`dl`,`m`.`zf` desc */;

/*View structure for view 大盘历史 */

/*!50001 DROP TABLE IF EXISTS `大盘历史` */;
/*!50001 DROP VIEW IF EXISTS `大盘历史` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `大盘历史` AS select `gpsinahis`.`code` AS `CODE`,group_concat(`zf_convert`(`gpsinahis`.`zf`) order by `gpsinahis`.`date` ASC separator '') AS `his` from `gpsinahis` where (`gpsinahis`.`code` = 'sh000001') group by `gpsinahis`.`code` */;

/*View structure for view 异动观察 */

/*!50001 DROP TABLE IF EXISTS `异动观察` */;
/*!50001 DROP VIEW IF EXISTS `异动观察` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `异动观察` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '异动观察') and (`g`.`code` <> 'sz399006')) */;

/*View structure for view 当天龙虎 */

/*!50001 DROP TABLE IF EXISTS `当天龙虎` */;
/*!50001 DROP VIEW IF EXISTS `当天龙虎` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `当天龙虎` AS select `gp`.`code` AS `code`,`gp`.`name` AS `name`,`gptoday`.`zf` AS `zf`,`gpzfrec`.`zf_rec` AS `zf_rec`,`gptoday`.`trantime` AS `trantime` from ((`gptoday` join `gp`) join `gpzfrec`) where ((`gptoday`.`code` = `gp`.`code`) and (`gp`.`code` = `gpzfrec`.`code`) and (`gptoday`.`zf` >= 6) and (not((`gpzfrec`.`zf_rec` regexp '^.*[7-9]{2,5}$')))) order by `gptoday`.`zf` desc */;

/*View structure for view 当日题材 */

/*!50001 DROP TABLE IF EXISTS `当日题材` */;
/*!50001 DROP VIEW IF EXISTS `当日题材` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `当日题材` AS select `gp`.`code` AS `code`,`gp`.`name` AS `name`,`hy`.`qz` AS `qz` from (((`gp` join `hy`) join `hy1`) join `gptoday` `g`) where ((`gp`.`hy` = `hy`.`hy`) and (`hy`.`hy` = `hy1`.`hy`) and (`hy`.`sel` = 1) and (`gp`.`code` = `g`.`code`) and (`g`.`cj_amt` > 0)) union all select `g`.`code` AS `code`,`g`.`name` AS `name`,`gn`.`flag` AS `qz` from ((((`gp` `g` join `gptoday` `g1`) join `gn2gp` `g3`) join `gn1`) join `gn`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g3`.`gpcode`) and (`g3`.`gn` = `gn1`.`code`) and (`gn1`.`code` = `gn`.`gn`) and (`gn1`.`sel` = 1) and (`g1`.`cj_amt` > 0)) */;

/*View structure for view 投资日历 */

/*!50001 DROP TABLE IF EXISTS `投资日历` */;
/*!50001 DROP VIEW IF EXISTS `投资日历` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `投资日历` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`r`.`gn` AS `gn`,`r`.`keystr` AS `keystr`,`r`.`rl` AS `rl` from (`dzrl` `r` join `gp` `g`) where ((`r`.`gpstr` = `g`.`name`) and (date_format(`r`.`rl`,'%Y-%m-%d') > convert(`get_tran_date`() using utf8))) */;

/*View structure for view 投资日历概念 */

/*!50001 DROP TABLE IF EXISTS `投资日历概念` */;
/*!50001 DROP VIEW IF EXISTS `投资日历概念` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `投资日历概念` AS select distinct `tz`.`keystr` AS `keystr`,`tz`.`rl` AS `rl`,`tz`.`gn` AS `gn` from `投资日历` `tz` where (`tz`.`keystr` <> '') */;

/*View structure for view 投资计划 */

/*!50001 DROP TABLE IF EXISTS `投资计划` */;
/*!50001 DROP VIEW IF EXISTS `投资计划` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `投资计划` AS select `g`.`code` AS `code`,(to_days(`p`.`rq`) - to_days(`get_tran_date`())) AS `days`,`p`.`flag` AS `flag`,`p`.`cls` AS `cls`,5 AS `qz` from (`plan` `p` join `gp` `g`) where ((`p`.`hy` = `g`.`hy`) and ((to_days(`p`.`rq`) - to_days(`get_tran_date`())) < 20) and ((to_days(`p`.`rq`) - to_days(`get_tran_date`())) > 4)) union all select `g`.`gpcode` AS `gpcode`,(to_days(`p`.`rq`) - to_days(`get_tran_date`())) AS `days`,`p`.`flag` AS `flag`,`p`.`cls` AS `cls`,8 AS `qz` from (`plan` `p` join `gn2gp` `g`) where ((`p`.`gn` = `g`.`gn`) and ((to_days(`p`.`rq`) - to_days(`get_tran_date`())) < 20) and ((to_days(`p`.`rq`) - to_days(`get_tran_date`())) > 4)) union all select `g`.`code` AS `code`,(to_days(`p`.`rq`) - to_days(`get_tran_date`())) AS `days`,`p`.`flag` AS `flag`,`p`.`cls` AS `cls`,9 AS `qz` from (`plan` `p` join `gp` `g`) where ((`p`.`gps` is not null) and (locate(`g`.`name`,`p`.`gps`) > 0) and ((to_days(`p`.`rq`) - to_days(`get_tran_date`())) < 20) and ((to_days(`p`.`rq`) - to_days(`get_tran_date`())) > 4)) */;

/*View structure for view 持续放量 */

/*!50001 DROP TABLE IF EXISTS `持续放量` */;
/*!50001 DROP VIEW IF EXISTS `持续放量` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `持续放量` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,ifnull(`g`.`syl`,99999) AS `syl`,`g`.`ltsz` AS `ltsz` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '持续放量')) order by ifnull(`g`.`syl`,99999) */;

/*View structure for view 指数比较 */

/*!50001 DROP TABLE IF EXISTS `指数比较` */;
/*!50001 DROP VIEW IF EXISTS `指数比较` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `指数比较` AS select sum(if((`g`.`code` = '000001'),`g`.`zf30`,0)) AS `dp_zf_30`,sum(if((`g`.`code` = '399006'),`g`.`zf30`,0)) AS `cyb_zf_30`,sum(if((`g`.`code` = '000001'),`g`.`zf7`,0)) AS `dp_zf_7`,sum(if((`g`.`code` = '399006'),`g`.`zf7`,0)) AS `cyb_zf_7` from `gpzfrec` `g` where (`g`.`code` in ('399006','000001')) */;

/*View structure for view 新股申购 */

/*!50001 DROP TABLE IF EXISTS `新股申购` */;
/*!50001 DROP VIEW IF EXISTS `新股申购` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `新股申购` AS select `n`.`keystr` AS `keystr`,substr(`n`.`remark`,1,5) AS `ssdate`,`n`.`updtime` AS `updtime` from `newsyw` `n` where (`n`.`newsfrom` = '新股申购') */;

/*View structure for view 早盘必读 */

/*!50001 DROP TABLE IF EXISTS `早盘必读` */;
/*!50001 DROP VIEW IF EXISTS `早盘必读` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `早盘必读` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '早盘必读') and (`n`.`gn` = 0) and (`g`.`code` not in ('sh000001','sz399006'))) */;

/*View structure for view 早盘必读概念 */

/*!50001 DROP TABLE IF EXISTS `早盘必读概念` */;
/*!50001 DROP VIEW IF EXISTS `早盘必读概念` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `早盘必读概念` AS select `n`.`gn` AS `gn`,`n`.`keystr` AS `keystr`,`n`.`updtime` AS `updtime` from `newsyw` `n` where ((`n`.`newsfrom` = '早盘必读') and (`n`.`keystr` <> '进入') and (`n`.`gn` <> 0)) */;

/*View structure for view 机会情报 */

/*!50001 DROP TABLE IF EXISTS `机会情报` */;
/*!50001 DROP VIEW IF EXISTS `机会情报` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `机会情报` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '机会情报') and (`n`.`keystr` not in ('创业板','同花顺')) and (`g`.`code` <> 'sh000001')) order by `n`.`updtime` desc */;

/*View structure for view 机会情报概念 */

/*!50001 DROP TABLE IF EXISTS `机会情报概念` */;
/*!50001 DROP VIEW IF EXISTS `机会情报概念` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `机会情报概念` AS select `n`.`gn` AS `gn`,`n`.`keystr` AS `keystr`,`n`.`updtime` AS `updtime` from `newsyw` `n` where ((`n`.`newsfrom` = '机会情报') and (`n`.`keystr` not in ('进入','提价','跳涨')) and (`n`.`gn` <> 0)) */;

/*View structure for view 权重值 */

/*!50001 DROP TABLE IF EXISTS `权重值` */;
/*!50001 DROP VIEW IF EXISTS `权重值` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `权重值` AS select format(sum(`qz`.`flag`),2) AS `gnz` from `概念权重` `qz` */;

/*View structure for view 概念排名 */

/*!50001 DROP TABLE IF EXISTS `概念排名` */;
/*!50001 DROP VIEW IF EXISTS `概念排名` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念排名` AS select `g1`.`gn` AS `gn`,`g3`.`gnname` AS `gnname`,`g2`.`zf` AS `zf`,format(avg(`g`.`zf7`),2) AS `zf7` from (((`gpzfrec` `g` join `gn2gp` `g1`) join `gnzfrec` `g2`) join `gn` `g3`) where ((`g`.`code` = `g1`.`gpcode`) and (`g1`.`gn` = `g2`.`gn`) and (`g2`.`gn` = `g3`.`gn`)) group by `g1`.`gn` order by `g2`.`zf` desc */;

/*View structure for view 概念排名1 */

/*!50001 DROP TABLE IF EXISTS `概念排名1` */;
/*!50001 DROP VIEW IF EXISTS `概念排名1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念排名1` AS select `概念排名`.`gn` AS `gn`,`概念排名`.`gnname` AS `gnname`,`概念排名`.`zf` AS `zf` from `概念排名` where (`概念排名`.`zf` > 0.5) limit 0,1 */;

/*View structure for view 概念排名2 */

/*!50001 DROP TABLE IF EXISTS `概念排名2` */;
/*!50001 DROP VIEW IF EXISTS `概念排名2` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念排名2` AS select `概念排名`.`gn` AS `gn`,`概念排名`.`gnname` AS `gnname`,`概念排名`.`zf` AS `zf` from `概念排名` where (`概念排名`.`zf` > 0.5) limit 0,2 */;

/*View structure for view 概念排名5 */

/*!50001 DROP TABLE IF EXISTS `概念排名5` */;
/*!50001 DROP VIEW IF EXISTS `概念排名5` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念排名5` AS select `概念排名`.`gn` AS `gn`,`概念排名`.`gnname` AS `gnname`,`概念排名`.`zf` AS `zf` from `概念排名` where (`概念排名`.`gn` <> 718) order by `概念排名`.`zf` desc limit 0,6 */;

/*View structure for view 概念排名_max */

/*!50001 DROP TABLE IF EXISTS `概念排名_max` */;
/*!50001 DROP VIEW IF EXISTS `概念排名_max` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念排名_max` AS select `g1`.`gn` AS `gn`,`g3`.`gnname` AS `gnname`,`g2`.`zf` AS `zf`,format(avg(`g`.`zf7`),2) AS `zf7` from (((`gpzfrec` `g` join `gn2gp` `g1`) join `gnzfrec` `g2`) join `gn` `g3`) where ((`g`.`code` = `g1`.`gpcode`) and (`g1`.`gn` = `g2`.`gn`) and (`g2`.`gn` = `g3`.`gn`) and (`g2`.`zf` > 0.5)) group by `g1`.`gn` order by avg(`g`.`zf7`) desc limit 0,3 */;

/*View structure for view 概念权重 */

/*!50001 DROP TABLE IF EXISTS `概念权重` */;
/*!50001 DROP VIEW IF EXISTS `概念权重` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念权重` AS select distinct `g`.`gn` AS `gn`,`g`.`gnname` AS `gnname`,`g`.`flag` AS `flag` from (`概念集合` `j` join `gn` `g`) where (`j`.`gn` = `g`.`gn`) order by `g`.`flag` desc limit 0,1 */;

/*View structure for view 概念涨停 */

/*!50001 DROP TABLE IF EXISTS `概念涨停` */;
/*!50001 DROP VIEW IF EXISTS `概念涨停` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念涨停` AS select distinct `gn`.`gn` AS `gn`,`gn`.`gnname` AS `gnname`,count(`gn`.`gn`) AS `cnt` from ((((`gptoday` `g1` join `gp` `g`) join `gpzfrec` `g2`) join `gn2gp` `g3`) join `gn`) where ((`g1`.`code` = `g`.`code`) and (`g`.`code` = `g2`.`code`) and (`g`.`code` = `g3`.`gpcode`) and (`g3`.`gn` = `gn`.`gn`) and (`g1`.`zf` >= 9) and (`gn`.`gn` <> 718)) group by `gn`.`gn` having (count(`gn`.`gn`) >= 1) order by count(`gn`.`gn`) desc,`gn`.`flag` desc limit 0,3 */;

/*View structure for view 概念资金 */

/*!50001 DROP TABLE IF EXISTS `概念资金` */;
/*!50001 DROP VIEW IF EXISTS `概念资金` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念资金` AS select `n`.`keystr` AS `keystr`,cast(replace(`n`.`remark`,'%','') as decimal(10,0)) AS `fd` from `newsyw` `n` where (`n`.`newsfrom` = '概念资金') order by cast(replace(`n`.`remark`,'%','') as decimal(10,0)) desc */;

/*View structure for view 概念集合 */

/*!50001 DROP TABLE IF EXISTS `概念集合` */;
/*!50001 DROP VIEW IF EXISTS `概念集合` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `概念集合` AS select `yw`.`gn` AS `gn`,`yw`.`keystr` AS `keystr`,`yw`.`updtime` AS `updtime` from `财经要闻` `yw` */;

/*View structure for view 涨停榜 */

/*!50001 DROP TABLE IF EXISTS `涨停榜` */;
/*!50001 DROP VIEW IF EXISTS `涨停榜` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `涨停榜` AS select `g1`.`hy` AS `hy`,count(`g1`.`code`) AS `cnt` from ((`gpzfrec` `g` join `gp` `g1`) join `gptoday` `g2`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g2`.`zf` > 5) and (`g`.`is_cxg` <> 1)) group by `g1`.`hy` order by count(`g1`.`code`) desc */;

/*View structure for view 涨跌幅排行 */

/*!50001 DROP TABLE IF EXISTS `涨跌幅排行` */;
/*!50001 DROP VIEW IF EXISTS `涨跌幅排行` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `涨跌幅排行` AS select `h`.`code` AS `code`,`g`.`name` AS `name`,`h`.`zf` AS `zf`,`h`.`jrzgj` AS `jrzgj`,`h`.`jrzdj` AS `jrzdj`,`h`.`dqj` AS `dqj`,`h`.`jj` AS `jj`,ifnull(`h`.`hsl`,0) AS `hsl`,`h`.`zhengf` AS `zhengf`,`g`.`ltsz` AS `ltsz`,ifnull(`g`.`syl`,99999) AS `syl` from (`gptoday` `h` join `gp` `g`) where ((`h`.`code` = `g`.`code`) and (`h`.`dqj` < 500) and (`g`.`ltsz` < 1000)) order by `h`.`zf` desc */;

/*View structure for view 热点排序 */

/*!50001 DROP TABLE IF EXISTS `热点排序` */;
/*!50001 DROP VIEW IF EXISTS `热点排序` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `热点排序` AS select `g2`.`gn` AS `gn`,`gn`.`gnname` AS `gnname`,avg(`g1`.`zf`) AS `gnzf`,`g1`.`date` AS `date` from ((`gn2gp` `g2` join `gptoday` `g1`) join `gn`) where ((`g2`.`gpcode` = `g1`.`code`) and (`g2`.`gn` = `gn`.`gn`) and (`g1`.`zf` <> -(100.00)) and (`g2`.`gn` <> 999)) group by `g2`.`gn` order by avg(`g1`.`zf`) desc */;

/*View structure for view 统计榜单 */

/*!50001 DROP TABLE IF EXISTS `统计榜单` */;
/*!50001 DROP VIEW IF EXISTS `统计榜单` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `统计榜单` AS select `g`.`hy` AS `hy`,((`g1`.`zf` + `g`.`cnt`) + (`g1`.`gcnt` / 100)) AS `zf` from (`涨停榜` `g` join `今日行业涨幅` `g1`) where (`g`.`hy` = `g1`.`hy`) */;

/*View structure for view 股票复盘 */

/*!50001 DROP TABLE IF EXISTS `股票复盘` */;
/*!50001 DROP VIEW IF EXISTS `股票复盘` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `股票复盘` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`g`.`syl` AS `syl`,`g`.`ltsz` AS `ltsz`,`f`.`eventtype` AS `eventtype` from (`gp` `g` join `gpfp` `f`) where (`g`.`name` = `f`.`gpname`) order by `g`.`ltsz`,`g`.`syl` */;

/*View structure for view 股票池 */

/*!50001 DROP TABLE IF EXISTS `股票池` */;
/*!50001 DROP VIEW IF EXISTS `股票池` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `股票池` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name`,`g2`.`zf` AS `zf` from ((`gpsel` `g` join `gp` `g1`) join `gptoday` `g2`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`)) */;

/*View structure for view 行业倒序 */

/*!50001 DROP TABLE IF EXISTS `行业倒序` */;
/*!50001 DROP VIEW IF EXISTS `行业倒序` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `行业倒序` AS (select `g1`.`hy` AS `hy`,`h`.`zf` AS `hyzf`,round(avg(`g`.`zf3`),2) AS `hy_zf3`,round(avg(`g`.`zf7`),2) AS `hy_zf7` from ((`hyzfrec` `h` join `gpzfrec` `g`) join `gp` `g1`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`hy` = `h`.`hy`) and (`h`.`zf` > 0.8)) group by `g1`.`hy` order by round(avg(`g`.`zf7`),2) limit 0,1) */;

/*View structure for view 行业排名1 */

/*!50001 DROP TABLE IF EXISTS `行业排名1` */;
/*!50001 DROP VIEW IF EXISTS `行业排名1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `行业排名1` AS (select `hyzfrec`.`hy` AS `hy` from `hyzfrec` order by `hyzfrec`.`zf` desc limit 0,1) */;

/*View structure for view 行业排名6 */

/*!50001 DROP TABLE IF EXISTS `行业排名6` */;
/*!50001 DROP VIEW IF EXISTS `行业排名6` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `行业排名6` AS (select `hyzfrec`.`hy` AS `hy` from `hyzfrec` order by `hyzfrec`.`zf` desc limit 0,6) */;

/*View structure for view 行业排名_max */

/*!50001 DROP TABLE IF EXISTS `行业排名_max` */;
/*!50001 DROP VIEW IF EXISTS `行业排名_max` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `行业排名_max` AS (select `g1`.`hy` AS `hy`,`h`.`zf` AS `hyzf`,round(avg(`g`.`zf3`),2) AS `hy_zf3`,round(avg(`g`.`zf7`),2) AS `hy_zf7` from ((`hyzfrec` `h` join `gpzfrec` `g`) join `gp` `g1`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`hy` = `h`.`hy`) and (`h`.`zf` > 0.5)) group by `g1`.`hy` order by round(avg(`g`.`zf7`),2) desc limit 0,3) */;

/*View structure for view 行业涨停 */

/*!50001 DROP TABLE IF EXISTS `行业涨停` */;
/*!50001 DROP VIEW IF EXISTS `行业涨停` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `行业涨停` AS select distinct `g`.`hy` AS `hy`,count(`g`.`hy`) AS `cnt` from (((`gptoday` `g1` join `gp` `g`) join `gpzfrec` `g2`) join `hy`) where ((`g1`.`code` = `g`.`code`) and (`g`.`code` = `g2`.`code`) and (`g1`.`zf` >= 9) and (`g1`.`dqj` > `g1`.`jj`) and (`g`.`hy` = `hy`.`hy`)) group by `g`.`hy` having (count(`g`.`hy`) >= 1) order by count(`g`.`hy`) desc,`hy`.`qz` desc limit 0,3 */;

/*View structure for view 财经要闻 */

/*!50001 DROP TABLE IF EXISTS `财经要闻` */;
/*!50001 DROP VIEW IF EXISTS `财经要闻` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `财经要闻` AS select distinct `n`.`gn` AS `gn`,`n`.`keystr` AS `keystr`,`g`.`remark` AS `remark`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gn` `g`) where ((`n`.`gn` = `g`.`gn`) and (`n`.`newsfrom` in ('今日要闻','新闻联播','早盘必读','机会情报')) and (`n`.`gn` <> 0) and (`n`.`keystr` not in ('同花顺','跳涨','提价','入市','举牌'))) order by `n`.`newsfrom` desc */;

/*View structure for view 近期有涨停 */

/*!50001 DROP TABLE IF EXISTS `近期有涨停` */;
/*!50001 DROP VIEW IF EXISTS `近期有涨停` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `近期有涨停` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name`,`g`.`zf_rec` AS `zf_rec` from ((`gpzfrec` `g` join `gp` `g1`) join `gptoday` `g2`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g`.`zt_bar_num` < 7) and (`g`.`zt_bar_num` > 0) and (`g2`.`cj_amt` > 0)) */;

/*View structure for view 送股派息 */

/*!50001 DROP TABLE IF EXISTS `送股派息` */;
/*!50001 DROP VIEW IF EXISTS `送股派息` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `送股派息` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`remark` AS `remark`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '送股派息') and (`n`.`updtime` >= `get_tran_date`())) order by `n`.`updtime` desc */;

/*View structure for view 限售解禁 */

/*!50001 DROP TABLE IF EXISTS `限售解禁` */;
/*!50001 DROP VIEW IF EXISTS `限售解禁` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `限售解禁` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`remark` AS `remark`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '限售解禁')) order by `n`.`updtime` desc,cast(`n`.`remark` as decimal(8,2)) desc */;

/*View structure for view 险资举牌 */

/*!50001 DROP TABLE IF EXISTS `险资举牌` */;
/*!50001 DROP VIEW IF EXISTS `险资举牌` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `险资举牌` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`remark` AS `remark`,`g`.`ltsz` AS `ltsz`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`g`.`ltsz` <= 500) and (`n`.`newsfrom` = '险资举牌')) order by `n`.`updtime` desc */;

/*View structure for view 高管持股 */

/*!50001 DROP TABLE IF EXISTS `高管持股` */;
/*!50001 DROP VIEW IF EXISTS `高管持股` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `高管持股` AS select `g`.`code` AS `code`,`g`.`name` AS `name`,`n`.`updtime` AS `updtime` from (`newsyw` `n` join `gp` `g`) where ((`n`.`keystr` = `g`.`name`) and (`n`.`newsfrom` = '高管持股') and (`n`.`updtime` >= (select max(`h`.`date`) from `gpsinahis` `h` where (`h`.`code` = 'sh000001')))) */;

/*View structure for view 黑天鹅 */

/*!50001 DROP TABLE IF EXISTS `黑天鹅` */;
/*!50001 DROP VIEW IF EXISTS `黑天鹅` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `黑天鹅` AS select `gn2gp`.`id` AS `id`,`gn2gp`.`gn` AS `gn`,`gn2gp`.`gpcode` AS `gpcode`,`gn2gp`.`gpname` AS `gpname` from `gn2gp` where (`gn2gp`.`gn` = 999) */;

/*View structure for view 龙虎榜 */

/*!50001 DROP TABLE IF EXISTS `龙虎榜` */;
/*!50001 DROP VIEW IF EXISTS `龙虎榜` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `龙虎榜` AS select `l`.`code` AS `code`,`l`.`name` AS `name`,`l`.`zjjd` AS `zjjd`,`l`.`zdf` AS `zdf`,`l`.`type` AS `type`,`l`.`date` AS `date` from `longhu` `l` where (not((`l`.`name` like '%退市%'))) order by `l`.`zdf` desc */;

/*View structure for view codeview */

/*!50001 DROP TABLE IF EXISTS `codeview` */;
/*!50001 DROP VIEW IF EXISTS `codeview` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `codeview` AS select `eacode`.`CODEID` AS `codeid`,`eacode`.`FIELD` AS `field`,`eacode`.`FIELDNAME` AS `fieldname`,`eacode`.`CODE` AS `code`,`eacode`.`CODEDESC` AS `codedesc`,`eacode`.`SORTNO` AS `sortno` from `eacode` where (`eacode`.`ENABLED` = _utf8'1') */;

/*View structure for view inheyref */

/*!50001 DROP TABLE IF EXISTS `inheyref` */;
/*!50001 DROP VIEW IF EXISTS `inheyref` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inheyref` AS select distinct `hyref`.`xl` AS `xl` from `hyref` where (`hyref`.`dl` in (select distinct `h`.`dl` from ((`position` `p` join `gp` `g`) join `hyref` `h`) where ((`p`.`available` > 0) and (`p`.`code` = `g`.`code`) and (`g`.`hy` = `h`.`xl`))) and (`hyref`.`type` = 0)) */;

/*View structure for view lostgps */

/*!50001 DROP TABLE IF EXISTS `lostgps` */;
/*!50001 DROP VIEW IF EXISTS `lostgps` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lostgps` AS (select `gp`.`code` AS `code`,`gp`.`name` AS `name` from (`gp` left join `gpzfrec` `g` on((`g`.`code` = `gp`.`code`))) where isnull(`g`.`code`)) */;

/*View structure for view maxid */

/*!50001 DROP TABLE IF EXISTS `maxid` */;
/*!50001 DROP VIEW IF EXISTS `maxid` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `maxid` AS (select max(`gptoday`.`id`) AS `MAX(gptoday.id)` from `gptoday` where (`gptoday`.`code` = 'int_dji')) */;

/*View structure for view newgps */

/*!50001 DROP TABLE IF EXISTS `newgps` */;
/*!50001 DROP VIEW IF EXISTS `newgps` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `newgps` AS select `g`.`id` AS `id`,`g`.`gn` AS `gn`,`g`.`gpcode` AS `gpcode`,`g`.`gpname` AS `gpname` from `gn2gp` `g` where (`g`.`gn` = 718) */;

/*View structure for view storegns */

/*!50001 DROP TABLE IF EXISTS `storegns` */;
/*!50001 DROP VIEW IF EXISTS `storegns` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `storegns` AS select distinct `g1`.`gpcode` AS `gpcode` from ((`position` `p` join `gn2gp` `g`) join `gn2gp` `g1`) where ((`p`.`code` = `g`.`gpcode`) and (`p`.`available` > 0) and (`g`.`gn` = `g1`.`gn`)) */;

/*View structure for view todaytc */

/*!50001 DROP TABLE IF EXISTS `todaytc` */;
/*!50001 DROP VIEW IF EXISTS `todaytc` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `todaytc` AS select distinct `g`.`code` AS `code`,`g`.`name` AS `name`,`gn`.`flag` AS `qz`,1 AS `sx` from (((`gp` `g` join `gn2gp` `g3`) join `概念涨停` `g1`) join `gn`) where ((`g`.`code` = `g3`.`gpcode`) and (`g3`.`gn` = `g1`.`gn`) and (`g1`.`gn` = `gn`.`gn`)) union all select `g`.`code` AS `code`,`g`.`name` AS `name`,`h1`.`qz` AS `qz`,0 AS `sx` from ((`gp` `g` join `行业涨停` `h`) join `hy` `h1`) where ((`g`.`hy` = `h`.`hy`) and (`h`.`hy` = `h1`.`hy`)) union all select `todaytcgps`.`code` AS `CODE`,`todaytcgps`.`name` AS `NAME`,`todaytcgps`.`qz` AS `qz`,2 AS `sx` from `todaytcgps` */;

/*View structure for view todaytcgps */

/*!50001 DROP TABLE IF EXISTS `todaytcgps` */;
/*!50001 DROP VIEW IF EXISTS `todaytcgps` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `todaytcgps` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name`,`hy`.`qz` AS `qz` from (((`hy` join `gptoday` `g`) join `gp` `g1`) join `gpzfrec` `g2`) where ((`g1`.`code` = `g`.`code`) and (`g`.`code` = `g2`.`code`) and (`g1`.`hy` = `hy`.`hy`) and (`hy`.`sel` = 1) and (`g`.`cj_amt` > 0) and (`g`.`zf` >= 9) and (`g2`.`zf3` < 10)) union all select `g1`.`code` AS `code`,`gp`.`name` AS `name`,`gn`.`flag` AS `qz` from (((((`gn1` join `gn`) join `gn2gp` `g`) join `gptoday` `g1`) join `gpzfrec` `g2`) join `gp`) where ((`g`.`gn` = `gn1`.`code`) and (`gn1`.`code` = `gn`.`gn`) and (`gn1`.`sel` = 1) and (`g`.`gpcode` = `g1`.`code`) and (`g1`.`code` = `gp`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g1`.`cj_amt` > 0) and (`g2`.`zf3` < 10) and (`g1`.`zf` >= 9)) */;

/*View structure for view xsjj */

/*!50001 DROP TABLE IF EXISTS `xsjj` */;
/*!50001 DROP VIEW IF EXISTS `xsjj` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `xsjj` AS select distinct `xsjj$`.`code` AS `code`,`xsjj$`.`name` AS `name`,`xsjj$`.`xsdate` AS `xsdate`,`xsjj$`.`bqjj` AS `bqjj`,`xsjj$`.`dqj` AS `dqj`,`xsjj$`.`zjj` AS `zjj`,`xsjj$`.`zbbl` AS `zbbl` from `xsjj$` where ((`xsjj$`.`zbbl` >= 0.5) and ((to_days(`xsjj$`.`xsdate`) - to_days(now())) > -(45))) */;

/*View structure for view ztgn */

/*!50001 DROP TABLE IF EXISTS `ztgn` */;
/*!50001 DROP VIEW IF EXISTS `ztgn` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ztgn` AS select distinct `gn`.`gn` AS `gn`,`gn`.`gnname` AS `gnname` from ((((((`gp` `g` join `gn2gp` `g1`) join `gptoday` `g2`) join `gpzfrec` `g3`) join `gn`) join `gnzfrec`) join `prezf` `p`) where ((`g`.`code` = `g1`.`gpcode`) and (`g`.`code` = `g2`.`code`) and (`g`.`code` = `g3`.`code`) and (`gn`.`gn` = `gnzfrec`.`gn`) and (`g1`.`gn` = `gn`.`gn`) and (`g`.`code` = `p`.`code`) and ((`p`.`zf` <= 3) or (time_to_sec(`g2`.`trantime`) <= time_to_sec('9:40:00'))) and (`g2`.`zf` > 9) and (`g3`.`zf` < 3) and (`g3`.`zf30` < 10)) order by `gnzfrec`.`zf` desc limit 0,1 */;

/*View structure for view zthy */

/*!50001 DROP TABLE IF EXISTS `zthy` */;
/*!50001 DROP VIEW IF EXISTS `zthy` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zthy` AS select `g`.`hy` AS `hy` from (((((`gp` `g` join `hy`) join `gptoday` `g1`) join `gpzfrec` `g2`) join `hyzfrec` `h`) join `prezf` `p`) where ((`g`.`code` = `g1`.`code`) and (`g1`.`code` = `g2`.`code`) and (`g`.`hy` = `hy`.`hy`) and (`g`.`hy` = `h`.`hy`) and (`g`.`code` = `p`.`code`) and ((`p`.`zf` <= 3) or (time_to_sec(`g1`.`trantime`) <= time_to_sec('9:40:00'))) and (`g1`.`zf` > 9) and (`g2`.`zf` < 3) and (`g2`.`zf3` < 10)) order by `h`.`zf` desc limit 0,1 */;

/*View structure for view zttoday */

/*!50001 DROP TABLE IF EXISTS `zttoday` */;
/*!50001 DROP VIEW IF EXISTS `zttoday` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zttoday` AS select `g1`.`code` AS `code`,`g1`.`name` AS `name`,`g`.`zf` AS `zf`,`g`.`trantime` AS `trantime` from (`gptoday` `g` join `gp` `g1`) where ((`g`.`code` = `g1`.`code`) and (`g`.`zf` >= 9)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
