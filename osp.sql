-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: platform
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `contactus`
--

DROP TABLE IF EXISTS `contactus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contactus` (
  `name` varchar(30) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `text` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactus`
--

LOCK TABLES `contactus` WRITE;
/*!40000 ALTER TABLE `contactus` DISABLE KEYS */;
INSERT INTO `contactus` VALUES ('tara','206122@siddharthamahila.ac.in','tq'),('Shaik Rafath Tarannum','206118@siddharthamahila.ac.in','tq');
/*!40000 ALTER TABLE `contactus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `fid` varchar(20) NOT NULL,
  `name` char(20) DEFAULT NULL,
  `gender` char(10) DEFAULT NULL,
  `emailid` varchar(40) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`fid`),
  UNIQUE KEY `emailid` (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES ('123','rafath','female','206118@siddharthamahila.ac.in','123');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveymeta`
--

DROP TABLE IF EXISTS `surveymeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveymeta` (
  `surid` varchar(9) DEFAULT NULL,
  `username` varchar(6) DEFAULT NULL,
  `html` varchar(10) DEFAULT NULL,
  `url` text,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `username` (`username`),
  CONSTRAINT `surveymeta_ibfk_1` FOREIGN KEY (`username`) REFERENCES `faculty` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveymeta`
--

LOCK TABLES `surveymeta` WRITE;
/*!40000 ALTER TABLE `surveymeta` DISABLE KEYS */;
INSERT INTO `surveymeta` VALUES ('N6zA6wR8s','123','form2','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjUyMDI1OCwiZXhwIjoxNjgyNTIwODU4fQ.eyJzaWQiOiJONnpBNndSOHMiLCJodG1sX3BhZ2UiOiJmb3JtMiJ9.gTb08E6WeDVGX2_JIQKH_eOBqSmDcuXyDOkdPmGB1B2XezD3Tc0Pmu7kGV4BkrRDZ8hDknd97BrB9g2pamGu5g','2023-04-26 20:14:18'),('H7iV4tC6q','123','form1','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjUyMDgyNSwiZXhwIjoxNjgyNTIxNDI1fQ.eyJzaWQiOiJIN2lWNHRDNnEiLCJodG1sX3BhZ2UiOiJmb3JtMSJ9.SQClI79b-pzW5OOId-ToR5t07DAgG4ywWbvLCTNU0CLenKatE9FZcUAmWF5LyZAEMJXM43_ZOBrzLhtXmjt3-w','2023-04-26 20:23:45'),('I6bP4oU2o','123','form5','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjUyNzkwNywiZXhwIjoxNjgyNTI4NTA3fQ.eyJzaWQiOiJJNmJQNG9VMm8iLCJodG1sX3BhZ2UiOiJmb3JtNSJ9.NPrU_7ZsTN7BB5Ols-xaPiqrmk_CQ5TvbSaAb3LuVsSiHvMm_8-aXMvgJhZMpPvEkVSMeyrmJ9bxZ_4zWAbTIg','2023-04-26 22:21:47'),('Y7iW3zI5i','123','form3','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjU2MzkyNiwiZXhwIjoxNjgyNTY0NTI2fQ.eyJzaWQiOiJZN2lXM3pJNWkiLCJodG1sX3BhZ2UiOiJmb3JtMyJ9.x1tz7LZ07nlsMOn20en1lR-ZWlNBIwkLIC2KHeOFl27PW2wPgtd0jqMLUpAefIUdhqHLNLmBIQoMIQG_3ENpYg','2023-04-27 08:22:06'),('C9mQ8jL7u','123','form6','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjU3NTI0MywiZXhwIjoxNjgyNTc1ODQzfQ.eyJzaWQiOiJDOW1ROGpMN3UiLCJodG1sX3BhZ2UiOiJmb3JtNiJ9.AMPRg9uKQrW3GhWv5j0d7C3afUWntjEn_rSWUVF55bnUPzmg1VuUd-W83bPSsiUvJNQgYo1IgcHx538fvKSM0Q','2023-04-27 11:30:43'),('C8aP8eC6r','123','form3','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjU4MTk5MiwiZXhwIjoxNjgyNTgyNTkyfQ.eyJzaWQiOiJDOGFQOGVDNnIiLCJodG1sX3BhZ2UiOiJmb3JtMyJ9.BuIMyi4Gl3ZwKeF8VAfkvCCVtiyXApQm0Fcs-tHbAcHXJ2CMe-teOt4zhvJjMJb12qslVjrIW_9mKBzLgiIhvA','2023-04-27 13:23:12');
/*!40000 ALTER TABLE `surveymeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveys` (
  `surid` varchar(9) NOT NULL,
  `rollno` varchar(6) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `section` varchar(10) DEFAULT NULL,
  `one` tinytext,
  `two` tinytext,
  `three` tinytext,
  `four` tinytext,
  `five` tinytext,
  `six` tinytext,
  `seven` tinytext,
  `eight` tinytext,
  `nine` tinytext,
  `ten` tinytext,
  `eleven` smallint DEFAULT NULL,
  PRIMARY KEY (`surid`,`rollno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
INSERT INTO `surveys` VALUES ('C8aP8eC6r','52','dvv','B.sc MPCs','Yes','E','E','Yes','Yes','y','E','g','Yes','cbvn',63),('C9mQ8jL7u','23','mata','B.sc MPCs','Yes','E','g','Yes','No','y','E','E','Yes','dhfg',64),('H7iV4tC6q','20','dc','B.sc MSCs','g','ftrt','E','Yes','No','E','E','E','bhgh','nbh',60),('I6bP4oU2o','203','raf','B.sc MPCs','Yes','g','E','Yes','No','y','E','E','Yes','guhsdg',73),('N6zA6wR8s','555','gvv','B.sc MSCs','E','E','E','Yes','Yes','E','E','E','Yes','gff',77),('Y7iW3zI5i','20','abc','B.sc MSDs','Yes','g','s','Yes','Yes','y','E','E','Yes','sdfbfh dbf',67);
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(6) NOT NULL,
  `password` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-27 16:59:20
