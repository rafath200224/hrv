-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: oss
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
INSERT INTO `surveymeta` VALUES ('T7mC5lT7w','admin','form5','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjQ3ODQ3NCwiZXhwIjoxNjgyNDc5MDc0fQ.eyJzaWQiOiJUN21DNWxUN3ciLCJodG1sX3BhZ2UiOiJmb3JtNSJ9.pNVhkNofWUxeepq08KW_z-Tzr8gNXkgE5wd7B8hW4eStvUaWKL5ZrcE5hJ8CXsMTGt6zwNGGUqajyePooxV2TQ','2023-04-26 08:37:54'),('G5tI3lO9a','admin','form1','http://127.0.0.1:5000/survey/eyJhbGciOiJIUzUxMiIsImlhdCI6MTY4MjQ3ODQ4NCwiZXhwIjoxNjgyNDc4OTg0fQ.eyJzaWQiOiJHNXRJM2xPOWEiLCJodG1sX3BhZ2UiOiJmb3JtMSJ9.CmgJlIlDDA-4dS87CG57j1VitBmsjSHcGtLDSRItABvyuq7FCkHFF3k2xB8nsNUZHz_MQmU7IjvxnVrqM7quBA','2023-04-26 08:38:04');
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
INSERT INTO `surveys` VALUES ('G5tI3lO9a','256789','anusha','B.sc MSCs','g','dsds','E','No','Yes','a','s','g','dsdsd','dsds',50),('T7mC5lT7w','197208','Eswar Nandivada','B.sc MSCs','Yes','E','E','Yes','No','y','g','E','No','xxjhjdsjs',62);
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

-- Dump completed on 2023-04-26  9:46:47
