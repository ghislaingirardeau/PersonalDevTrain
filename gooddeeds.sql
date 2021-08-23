-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: gooddeed
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `deeds`
--

DROP TABLE IF EXISTS `deeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deeds` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `deed` varchar(70) NOT NULL,
  `date` timestamp NOT NULL,
  `user_id` smallint unsigned NOT NULL,
  `validate_by` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deeds`
--

LOCK TABLES `deeds` WRITE;
/*!40000 ALTER TABLE `deeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `deeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `negative`
--

DROP TABLE IF EXISTS `negative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `negative` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `feeling_neg` tinytext NOT NULL,
  `date` timestamp NOT NULL,
  `user_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_negative_user` (`user_id`),
  CONSTRAINT `fk_negative_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negative`
--

LOCK TABLES `negative` WRITE;
/*!40000 ALTER TABLE `negative` DISABLE KEYS */;
INSERT INTO `negative` VALUES (2,'jealous','2021-06-08 14:33:07',3),(5,'anger','2021-07-25 14:53:56',7),(6,'insecure','2021-07-25 15:06:43',7),(7,'unhappy','2021-07-27 13:02:24',3),(8,'overcome','2021-07-27 13:02:34',3),(9,'unhappy','2021-07-31 10:35:17',3),(10,'lonely','2021-07-31 10:40:24',3),(11,'Enraged','2021-08-03 13:39:52',3),(12,'Fear','2021-08-06 09:46:11',3),(13,'Unhappy','2021-08-06 13:39:03',8),(14,'Enraged','2021-08-06 14:10:24',9),(15,'Jealous','2021-08-08 14:15:17',3),(16,'Jealous','2021-08-08 14:15:45',3),(17,'Enraged','2021-08-23 13:24:00',7);
/*!40000 ALTER TABLE `negative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positive`
--

DROP TABLE IF EXISTS `positive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positive` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `feeling_pos` tinytext NOT NULL,
  `date` timestamp NOT NULL,
  `user_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_positive_user` (`user_id`),
  CONSTRAINT `fk_positive_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positive`
--

LOCK TABLES `positive` WRITE;
/*!40000 ALTER TABLE `positive` DISABLE KEYS */;
INSERT INTO `positive` VALUES (1,'happy','2021-06-08 14:13:01',3),(4,'happy','2021-07-23 13:27:45',3),(5,'happy','2021-07-23 14:16:56',3),(8,'love','2021-07-24 13:08:35',3),(9,'joy','2021-07-24 13:08:40',3),(10,'fear','2021-07-24 13:15:06',3),(11,'anger','2021-07-24 13:15:09',3),(12,'sadness','2021-07-24 13:15:12',3),(13,'surprise','2021-07-24 13:15:20',3),(14,'insecure','2021-07-24 15:34:15',3),(21,'euphoric','2021-07-25 14:54:13',7),(22,'moved','2021-07-25 15:06:50',7),(23,'moved','2021-07-27 13:03:48',3),(24,'enchanted','2021-07-27 13:04:44',3),(25,'cheerful','2021-07-31 10:35:31',3),(26,'optimistic','2021-07-31 14:11:24',7),(27,'optimistic','2021-08-01 10:05:47',3),(28,'Optimistic','2021-08-03 13:39:38',3),(29,'Perplexed','2021-08-06 09:37:41',3),(30,'Love','2021-08-06 09:51:25',3),(31,'Optimistic','2021-08-06 13:38:56',8),(33,'Amazed','2021-08-08 14:14:11',3),(34,'Enchanted','2021-08-08 14:23:51',3),(35,'Content','2021-08-08 15:03:16',3),(36,'Enchanted','2021-08-08 15:10:46',3),(37,'Euphoric','2021-08-23 13:24:10',7);
/*!40000 ALTER TABLE `positive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sharing`
--

DROP TABLE IF EXISTS `sharing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sharing` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `connectFrom` smallint unsigned NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `connectTo` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userId` (`connectFrom`),
  KEY `fk_user_id` (`connectTo`),
  CONSTRAINT `fk_connectTo` FOREIGN KEY (`connectTo`) REFERENCES `negative` (`user_id`),
  CONSTRAINT `fk_connectTo_pos` FOREIGN KEY (`connectTo`) REFERENCES `positive` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`connectTo`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_userId` FOREIGN KEY (`connectFrom`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sharing`
--

LOCK TABLES `sharing` WRITE;
/*!40000 ALTER TABLE `sharing` DISABLE KEYS */;
INSERT INTO `sharing` VALUES (3,7,'authorized',3),(5,3,'authorized',7),(7,3,'authorized',8),(8,8,'on demand',7);
/*!40000 ALTER TABLE `sharing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(40) NOT NULL,
  `email` varbinary(100) NOT NULL,
  `password` varchar(60) NOT NULL,
  `roles` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ind_uni_pseudo` (`pseudo`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'test1',_binary '\�\"8L߈\��Ը\�\�$b$','$2b$10$H66Okvv53vYktdoAOtWx2Odr3AlHKEMj2td0dR5iSfZPOyasEyPRG',NULL),(7,'Ghislain',_binary '\�4X�ɶ�n�\�[K�\�\"V	2$�+{c\�0g?�G�','$2b$10$b6Y2jdNMaKiWKuIK4w2U1.jFih9b.cdIeW6oEhAniTTng6YCGzO6e',NULL),(8,'share',_binary 'm5\�&�)�\0\�\�\�\�\�\�','$2b$10$PdxqzdOj4d0WqweUHDcLK.cgdTuWIEOeyor0ZzUa7BphZz138fKHa',NULL),(9,'sign',_binary '�	_�\�\n?��*\0\�:f\�','$2b$10$X7gspdIxJR/hBx.97w9cNe9xsAYEa9vnoAKEdQr3okD0E6egRKQH2',NULL),(17,'testsign',_binary '���[\�\n\�<\�R\� Q\�','$2b$10$LmeUUwp4w.sJJnMIjEvO4.hqhJ.gXrtcTlo9M1SPFrwRBkvH9eJ/i',NULL),(19,'testsign12',_binary '���[\�\n\�<\�R\� Q\�','$2b$10$zYNN2LuV5T2Vntx6ezg1ROQ/RZTcV8qJsXvTOjtupoSEVz5fDIgTO',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-23 15:49:13
