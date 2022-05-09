-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: IDEA
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CACHE`
--

DROP TABLE IF EXISTS `CACHE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CACHE` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `HOSTNAME` varchar(50) NOT NULL,
  `FARMIP` varchar(15) DEFAULT NULL,
  `FLAG` int NOT NULL,
  `DATE` int NOT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DPX`
--

DROP TABLE IF EXISTS `DPX`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DPX` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `HOSTNAME` varchar(50) NOT NULL,
  `FARMIP` varchar(15) DEFAULT NULL,
  `FLAG` int NOT NULL,
  `DATE` int NOT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ENV`
--

DROP TABLE IF EXISTS `ENV`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENV` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `HOSTNAME` varchar(50) NOT NULL,
  `FARMIP` varchar(15) DEFAULT NULL,
  `FLAG` int NOT NULL,
  `DATE` int NOT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FARM`
--

DROP TABLE IF EXISTS `FARM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FARM` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `HOSTNAME` varchar(50) NOT NULL,
  `FARMIP` varchar(15) DEFAULT NULL,
  `FLAG` int NOT NULL,
  `DATE` int NOT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HPFX`
--

DROP TABLE IF EXISTS `HPFX`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HPFX` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `HOSTNAME` varchar(50) NOT NULL,
  `FARMIP` varchar(15) DEFAULT NULL,
  `FLAG` int NOT NULL,
  `DATE` int NOT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HPRENDER`
--

DROP TABLE IF EXISTS `HPRENDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HPRENDER` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `HOSTNAME` varchar(50) NOT NULL,
  `FARMIP` varchar(15) DEFAULT NULL,
  `FLAG` int NOT NULL,
  `DATE` int NOT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LOGIN_HISTORY`
--

DROP TABLE IF EXISTS `LOGIN_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOGIN_HISTORY` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `USERID` varchar(100) NOT NULL,
  `USERIP` varchar(15) DEFAULT NULL,
  `LOGINDATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROJECT_DF_LUSTRE`
--

DROP TABLE IF EXISTS `PROJECT_DF_LUSTRE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT_DF_LUSTRE` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `PROJECT_NAME` varchar(100) NOT NULL,
  `SIZE` varchar(10) DEFAULT NULL,
  `DATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROJECT_DF_LUSTRE2`
--

DROP TABLE IF EXISTS `PROJECT_DF_LUSTRE2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT_DF_LUSTRE2` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `PROJECT_NAME` varchar(100) NOT NULL,
  `SIZE` varchar(10) DEFAULT NULL,
  `DATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROJECT_DF_LUSTRE3`
--

DROP TABLE IF EXISTS `PROJECT_DF_LUSTRE3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT_DF_LUSTRE3` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `PROJECT_NAME` varchar(100) NOT NULL,
  `SIZE` varchar(10) DEFAULT NULL,
  `DATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROJECT_DF_NETAPP`
--

DROP TABLE IF EXISTS `PROJECT_DF_NETAPP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT_DF_NETAPP` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `PROJECT_NAME` varchar(100) NOT NULL,
  `SIZE` varchar(10) DEFAULT NULL,
  `DATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `STORAGE_INFO`
--

DROP TABLE IF EXISTS `STORAGE_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STORAGE_INFO` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `STORAGE_NAME` varchar(100) NOT NULL,
  `SIZE` varchar(10) DEFAULT NULL,
  `USED` varchar(10) DEFAULT NULL,
  `AVAIL` varchar(10) DEFAULT NULL,
  `USED_PER` varchar(100) NOT NULL,
  `DATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `USER_DEVICE_INFO`
--

DROP TABLE IF EXISTS `USER_DEVICE_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_DEVICE_INFO` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `USERID` varchar(100) NOT NULL,
  `OS` varchar(100) NOT NULL,
  `CPU` varchar(100) NOT NULL,
  `CPU_CORE` int NOT NULL,
  `DISK` varchar(100) NOT NULL,
  `MEM` varchar(10) NOT NULL,
  `GPU` varchar(100) NOT NULL,
  `GPU_VERSION` varchar(50) NOT NULL,
  `BOARD_COM` varchar(100) NOT NULL,
  `BOARD_PRODUCT` varchar(100) NOT NULL,
  `MONITOR1` varchar(100) DEFAULT NULL,
  `MONITOR2` varchar(100) DEFAULT NULL,
  `DATE` int NOT NULL,
  `FLAG` int NOT NULL,
  `MAC_ADDR1` varchar(100) DEFAULT NULL,
  `MAC_ADDR2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `USER_INFO`
--

DROP TABLE IF EXISTS `USER_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_INFO` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `USERID` varchar(100) NOT NULL,
  `USERNAME` varchar(100) NOT NULL,
  `USERIP` varchar(15) DEFAULT NULL,
  `TEAM` varchar(100) NOT NULL,
  `FLAG` int DEFAULT NULL,
  `PASSWORD` varchar(1024) NOT NULL,
  `ATTR` int NOT NULL,
  `DATE` int DEFAULT NULL,
  `MOUNT_FLAG` int DEFAULT NULL,
  `OS` varchar(2) DEFAULT NULL,
  `FAIL_COUNT` int DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `USER_STORAGE`
--

DROP TABLE IF EXISTS `USER_STORAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_STORAGE` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `USERID` varchar(100) NOT NULL,
  `LUSTRE` varchar(4) NOT NULL,
  `LUSTRE2` varchar(4) NOT NULL,
  `LUSTRE3` varchar(4) NOT NULL,
  `NETAPP` varchar(4) NOT NULL,
  `CLIB` varchar(4) NOT NULL,
  `IDEA_BACKUP` varchar(4) NOT NULL,
  `OLD_BACKUP` varchar(4) NOT NULL,
  `OLD_BACKUP2` varchar(4) NOT NULL,
  `FXDATA` varchar(4) NOT NULL,
  `FXCACHE` varchar(4) NOT NULL,
  `FX5` varchar(4) NOT NULL,
  `ENV` varchar(4) NOT NULL,
  `ASPERA` varchar(4) NOT NULL,
  `KTFTP2` varchar(4) NOT NULL,
  `KATANA` varchar(4) NOT NULL,
  `NAS` varchar(4) NOT NULL,
  `SUPER` varchar(4) NOT NULL,
  `PM` varchar(4) NOT NULL,
  `HPPOC` varchar(4) NOT NULL,
  `POCNETAPP` varchar(4) NOT NULL,
  `DELLPOC` varchar(4) NOT NULL,
  `DATE` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `USER_UPTIME`
--

DROP TABLE IF EXISTS `USER_UPTIME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_UPTIME` (
  `SEQ` int NOT NULL AUTO_INCREMENT,
  `USERID` varchar(100) NOT NULL,
  `UPTIME` int NOT NULL,
  `FLAG` int NOT NULL,
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-09 17:11:03
