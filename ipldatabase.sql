CREATE DATABASE  IF NOT EXISTS `ipl` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ipl`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ipl
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `login_info`
--

DROP TABLE IF EXISTS `login_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_info` (
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `email_id` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_info`
--

LOCK TABLES `login_info` WRITE;
/*!40000 ALTER TABLE `login_info` DISABLE KEYS */;
INSERT INTO `login_info` VALUES ('new','user','admin','admin@root','admin123');
/*!40000 ALTER TABLE `login_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `lost_team`
--

DROP TABLE IF EXISTS `lost_team`;
/*!50001 DROP VIEW IF EXISTS `lost_team`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `lost_team` AS SELECT 
 1 AS `match_no`,
 1 AS `team_name`,
 1 AS `team_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `match_details`
--

DROP TABLE IF EXISTS `match_details`;
/*!50001 DROP VIEW IF EXISTS `match_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `match_details` AS SELECT 
 1 AS `match_no`,
 1 AS `won_team_name`,
 1 AS `lost_team_name`,
 1 AS `date`,
 1 AS `mom`,
 1 AS `stadium_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `match_no` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `won_team_id` varchar(10) NOT NULL,
  `lost_team_id` varchar(10) NOT NULL,
  `stadium_id` int NOT NULL,
  `mom` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`match_no`),
  KEY `won_team_idx` (`won_team_id`),
  KEY `team_lost_idx` (`lost_team_id`),
  KEY `played_at_idx` (`stadium_id`),
  CONSTRAINT `played_at` FOREIGN KEY (`stadium_id`) REFERENCES `stadium` (`stadium_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_lost` FOREIGN KEY (`lost_team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_won` FOREIGN KEY (`won_team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` VALUES (4,'2016-04-12 00:00:00','RCB','SRH',1,'AB De Villiers'),(27,'2016-04-30 00:00:00','SRH','RCB',2,'David Warner'),(60,'2016-05-29 00:00:00','SRH','RCB',1,'Ben Cutting');
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Points_Upgrade` AFTER INSERT ON `matches` FOR EACH ROW BEGIN
	UPDATE team SET `team`.points = `team`.points + 2 WHERE team_id = NEW.won_team_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `team_id` varchar(10) NOT NULL,
  `player_name` varchar(100) DEFAULT NULL,
  `player_role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`player_id`,`team_id`),
  KEY `plays_for_idx` (`team_id`),
  CONSTRAINT `plays_for` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (3,'RCB','Yuzvendra Chahal','Bowler'),(5,'SRH','Deepak Hooda','Allrounder'),(9,'RCB','Sreenath Aravind','Bowler'),(11,'RCB','KL Rahul','Batsman'),(12,'SRH','Yuvraj Singh','Bowler'),(15,'SRH','Bhuvneshwar Kumar','Bowler'),(16,'SRH','Eoin Morgan','Batsman'),(17,'RCB','AB De Villiers','Batsman'),(18,'RCB','Virat Kohli (C)','Batsman'),(21,'SRH','Moises Henriques','Allrounder'),(22,'SRH','Kane Williamson','Batsman'),(25,'SRH','Shikhar Dhawan','Batsman'),(30,'SRH','Naman Ojha','Batsman'),(31,'SRH','David Warner (C)','Batsman'),(33,'RCB','Shane Watson','Allrounder'),(34,'RCB','Chris Jordan','Batsman'),(36,'RCB','Sachin Baby','Batsman'),(51,'SRH','Barinder Sran','Bowler'),(55,'RCB','Kane Richardson','Bowler'),(84,'RCB','Stuart Binny','Bowler'),(90,'SRH','Mustafizur Rahman','Bowler'),(333,'RCB','Chris Gayle','Allrounder');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stadium`
--

DROP TABLE IF EXISTS `stadium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stadium` (
  `stadium_id` int NOT NULL,
  `stadium_name` varchar(50) DEFAULT NULL,
  `stadium_location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stadium_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stadium`
--

LOCK TABLES `stadium` WRITE;
/*!40000 ALTER TABLE `stadium` DISABLE KEYS */;
INSERT INTO `stadium` VALUES (1,'M Chinnaswamy Stadium','Bangalore'),(2,'Rajiv Gandhi International Stadium','Hyderabad');
/*!40000 ALTER TABLE `stadium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `team_id` varchar(10) NOT NULL,
  `staff_name` varchar(100) DEFAULT NULL,
  `staff_role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`staff_id`,`team_id`),
  KEY `team_has_idx` (`team_id`),
  CONSTRAINT `team_has` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (101,'RCB','Daniel Vettori','Head Coach'),(102,'RCB','B Arun','Assistant Coach'),(103,'RCB','Trent Woodhill','Batting Coach'),(104,'RCB','Evan Speechley','PHYSIOTHERAPIST'),(105,'RCB','Shankar Basu','Strengh and Conditioning Coach'),(501,'SRH','Tom Moody','Head Coach'),(502,'SRH','VVS Laxman','Mentor'),(503,'SRH','Muttiah Muralitharan ','Spin-Bowling Coach'),(504,'SRH','Shyam Sundar','Physiotherapist');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `player_id` int NOT NULL,
  `team_id` varchar(10) NOT NULL,
  `innings` int DEFAULT '0',
  `runs` int DEFAULT '0',
  `wickets` int DEFAULT '0',
  `50s` int DEFAULT '0',
  `100s` int DEFAULT '0',
  `3wh` int DEFAULT '0',
  PRIMARY KEY (`team_id`,`player_id`),
  CONSTRAINT `has_stats` FOREIGN KEY (`team_id`, `player_id`) REFERENCES `player` (`team_id`, `player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (3,'RCB',13,0,21,0,0,1),(9,'RCB',9,0,11,0,0,0),(11,'RCB',12,397,0,4,0,0),(17,'RCB',16,687,0,6,1,0),(18,'RCB',16,973,0,7,4,0),(33,'RCB',15,179,0,0,0,1),(34,'RCB',1,3,0,2,0,1),(36,'RCB',6,119,0,0,0,0),(55,'RCB',4,1,7,0,0,0),(84,'RCB',6,63,1,0,0,0),(333,'RCB',10,227,2,2,0,0),(5,'SRH',15,144,3,0,0,0),(12,'SRH',5,236,0,0,0,0),(15,'SRH',17,43,23,0,0,1),(16,'SRH',6,123,0,1,0,0),(21,'SRH',15,182,12,0,0,0),(22,'SRH',6,124,0,1,0,0),(25,'SRH',17,501,0,4,0,0),(30,'SRH',13,136,0,0,0,0),(31,'SRH',17,848,0,9,0,0),(51,'SRH',14,4,14,0,0,0),(90,'srh',16,0,17,0,0,0);
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `team_id` varchar(10) NOT NULL,
  `team_name` varchar(100) DEFAULT NULL,
  `owner_name` varchar(50) DEFAULT NULL,
  `points` int DEFAULT '0',
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `team_name_UNIQUE` (`team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES ('RCB','Royal Challengers Banglore','Vijay Mallya',2),('SRH','Sunrisers Hyderabad','Kaviya Maran',4);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `won_team`
--

DROP TABLE IF EXISTS `won_team`;
/*!50001 DROP VIEW IF EXISTS `won_team`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `won_team` AS SELECT 
 1 AS `match_no`,
 1 AS `team_name`,
 1 AS `team_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'ipl'
--

--
-- Dumping routines for database 'ipl'
--
/*!50003 DROP PROCEDURE IF EXISTS `points_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `points_table`(in teamid varchar(10))
BEGIN
	SET @team_name = (SELECT team_name FROM team WHERE team_id = teamid);
    SET @points = (SELECT points FROM team WHERE team_id = teamid);
	SET @won = (SELECT count(*) FROM won_team WHERE team_id = teamid);
    SET @lost = (SELECT count(*) FROM lost_team WHERE team_id = teamid);
    SELECT @team_name AS team_name, @won AS won_count, @lost AS lost_count, @points AS points;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `team_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `team_details`(in teamid varchar(10))
BEGIN
	SET @ownername = (SELECT owner_name FROM team WHERE team_id = teamid);
    SET @captain = (SELECT player_name FROM player WHERE team_id = teamid AND player_name REGEXP '(.)*[w(]C');
    Select @ownername as ownername, @captain as captain;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `lost_team`
--

/*!50001 DROP VIEW IF EXISTS `lost_team`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lost_team` AS select `matches`.`match_no` AS `match_no`,`team`.`team_name` AS `team_name`,`team`.`team_id` AS `team_id` from (`matches` join `team`) where (`team`.`team_id` = `matches`.`lost_team_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `match_details`
--

/*!50001 DROP VIEW IF EXISTS `match_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `match_details` AS select `m`.`match_no` AS `match_no`,`w`.`team_name` AS `won_team_name`,`l`.`team_name` AS `lost_team_name`,date_format(`m`.`date`,'%d %b %Y') AS `date`,`m`.`mom` AS `mom`,`s`.`stadium_name` AS `stadium_name` from (((`matches` `m` join `won_team` `w`) join `lost_team` `l`) join `stadium` `s`) where ((`s`.`stadium_id` = `m`.`stadium_id`) and (`m`.`match_no` = `w`.`match_no`) and (`m`.`match_no` = `l`.`match_no`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `won_team`
--

/*!50001 DROP VIEW IF EXISTS `won_team`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `won_team` AS select `matches`.`match_no` AS `match_no`,`team`.`team_name` AS `team_name`,`team`.`team_id` AS `team_id` from (`matches` join `team`) where (`team`.`team_id` = `matches`.`won_team_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-21 17:31:51
