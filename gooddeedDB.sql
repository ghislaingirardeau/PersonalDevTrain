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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negative`
--

LOCK TABLES `negative` WRITE;
/*!40000 ALTER TABLE `negative` DISABLE KEYS */;
INSERT INTO `negative` VALUES (2,'jealous','2021-06-08 14:33:07',3),(5,'anger','2021-07-25 14:53:56',7),(6,'insecure','2021-07-25 15:06:43',7),(7,'unhappy','2021-07-27 13:02:24',3),(8,'overcome','2021-07-27 13:02:34',3),(9,'unhappy','2021-07-31 10:35:17',3),(10,'lonely','2021-07-31 10:40:24',3),(11,'Enraged','2021-08-03 13:39:52',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positive`
--

LOCK TABLES `positive` WRITE;
/*!40000 ALTER TABLE `positive` DISABLE KEYS */;
INSERT INTO `positive` VALUES (1,'happy','2021-06-08 14:13:01',3),(4,'happy','2021-07-23 13:27:45',3),(5,'happy','2021-07-23 14:16:56',3),(8,'love','2021-07-24 13:08:35',3),(9,'joy','2021-07-24 13:08:40',3),(10,'fear','2021-07-24 13:15:06',3),(11,'anger','2021-07-24 13:15:09',3),(12,'sadness','2021-07-24 13:15:12',3),(13,'surprise','2021-07-24 13:15:20',3),(14,'insecure','2021-07-24 15:34:15',3),(21,'euphoric','2021-07-25 14:54:13',7),(22,'moved','2021-07-25 15:06:50',7),(23,'moved','2021-07-27 13:03:48',3),(24,'enchanted','2021-07-27 13:04:44',3),(25,'cheerful','2021-07-31 10:35:31',3),(26,'optimistic','2021-07-31 14:11:24',7),(27,'optimistic','2021-08-01 10:05:47',3),(28,'Optimistic','2021-08-03 13:39:38',3);
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
  `userId_one` smallint unsigned NOT NULL,
  `connectTo_id` smallint unsigned NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userId` (`userId_one`),
  KEY `fk_share_positive` (`connectTo_id`),
  CONSTRAINT `fk_userId` FOREIGN KEY (`userId_one`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_userId_two` FOREIGN KEY (`connectTo_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sharing`
--

LOCK TABLES `sharing` WRITE;
/*!40000 ALTER TABLE `sharing` DISABLE KEYS */;
INSERT INTO `sharing` VALUES (1,3,7,'ON DEMAND');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'test1',_binary '\‚\"8Lﬂà\≈˘‘∏\—\‹$b$','$2b$10$H66Okvv53vYktdoAOtWx2Odr3AlHKEMj2td0dR5iSfZPOyasEyPRG',NULL),(5,'test2',_binary '\‚\"8Lﬂà\≈˘‘∏\—\‹$b$','$2b$10$tqlkL7qVHyzWeszX1KiXdeyqIXvWKObrHaA/YH0xVhOEYJsCWYHsy',NULL),(6,'test3',_binary '\‚\"8Lﬂà\≈˘‘∏\—\‹$b$','$2b$10$ev9QACNPZHpZZfREcbcOzOQiTZXchU0EkK71N5AkXeivGf9h8bss2',NULL),(7,'Ghislain',_binary '\‡4X˘…∂©nÉ\[Ká\Ù\"V	2$Ö+{c\Ó0g?ìGù','$2b$10$b6Y2jdNMaKiWKuIK4w2U1.jFih9b.cdIeW6oEhAniTTng6YCGzO6e',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'gooddeed'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_negative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `add_negative`(IN p_userid INT, IN p_feeling varchar(100))
BEGIN
INSERT INTO negative (feeling_neg, date, user_id)
VALUES (p_feeling, (SELECT NOW()), p_userid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_positive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `add_positive`(IN p_userid INT, IN p_feeling varchar(100))
BEGIN
INSERT INTO positive (feeling_pos, date, user_id)
VALUES (p_feeling, (SELECT NOW()), p_userid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `all_feeling` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `all_feeling`()
BEGIN
SET lc_time_names = 'fr_FR';
SELECT positive.id AS posId, feeling_pos, pseudo, user_id, DATE_FORMAT(date, 'le %W %e %M %Y √† %Hh%i') AS Date FROM positive INNER JOIN user ON positive.user_id=user.id ORDER BY date;
SELECT negative.id AS negId, feeling_neg, pseudo, user_id, DATE_FORMAT(date, 'le %W %e %M %Y √† %Hh%i') AS Date FROM negative INNER JOIN user ON negative.user_id=user.id ORDER BY date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `signup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `signup`(IN p_pseudo varchar(40), IN p_email varbinary(100), IN p_password varchar(60))
BEGIN
DECLARE v_pseudo VARCHAR(50) DEFAULT 'null';
SELECT pseudo INTO v_pseudo FROM user WHERE pseudo=p_pseudo;
if (v_pseudo='null') THEN CALL sign_user(p_pseudo, p_email, p_password);
ELSE SELECT 'Ce pseudo ou cet email existe deja' AS Response, 'Error' AS Status;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sign_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `sign_user`(IN p_pseudo varchar(40), IN p_email varbinary(100), IN p_password varchar(60))
BEGIN
INSERT INTO User (pseudo, email, password)
VALUES (p_pseudo, p_email, p_password);
SELECT pseudo, id, roles FROM user WHERE pseudo=p_pseudo AND email=p_email;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `test`(IN p_id INT)
BEGIN
declare v_status varchar(15);
SELECT status INTO v_status from sharing WHERE userid_one=p_id;
IF(v_status = 'on demand') THEN SELECT connectTo_id from sharing;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_feeling` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`epiz_29296492`@`sql303.epizy.com` PROCEDURE `user_feeling`(IN p_user_id INT)
BEGIN
SET lc_time_names = 'fr_FR';
SELECT positive.id AS posId, feeling_pos, pseudo, user_id, DATE_FORMAT(date, 'le %W %e %M %Y √† %Hh%i') AS Date FROM positive INNER JOIN user ON positive.user_id=user.id WHERE user.id=p_user_id ORDER BY date;
SELECT negative.id AS negId, feeling_neg, pseudo, user_id, DATE_FORMAT(date, 'le %W %e %M %Y √† %Hh%i') AS Date FROM negative INNER JOIN user ON negative.user_id=user.id WHERE user.id=p_user_id ORDER BY date;
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

-- Dump completed on 2021-08-06 11:07:08
