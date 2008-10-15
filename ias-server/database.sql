-- MySQL dump 10.11
--
-- Host: localhost    Database: ias
-- ------------------------------------------------------
-- Server version	5.0.38-Ubuntu_0ubuntu1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
CREATE TABLE `artists` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `GUID` varchar(36) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `conducteur`
--

DROP TABLE IF EXISTS `conducteur`;
CREATE TABLE `conducteur` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `guid` varchar(36) collate utf8_unicode_ci NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `URI` varchar(255) collate utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `event_types`
--

DROP TABLE IF EXISTS `event_types`;
CREATE TABLE `event_types` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `horloge_elements`
--

DROP TABLE IF EXISTS `horloge_elements`;
CREATE TABLE `horloge_elements` (
  `horloge_id` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `stack_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`horloge_id`,`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `horloges`
--

DROP TABLE IF EXISTS `horloges`;
CREATE TABLE `horloges` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `semaine_horloges`
--

DROP TABLE IF EXISTS `semaine_horloges`;
CREATE TABLE `semaine_horloges` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `day` tinyint(1) unsigned NOT NULL,
  `hour` tinyint(2) unsigned NOT NULL,
  `horloge_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `stack_elements`
--

DROP TABLE IF EXISTS `stack_elements`;
CREATE TABLE `stack_elements` (
  `id` int(10) NOT NULL auto_increment,
  `position` int(10) unsigned NOT NULL,
  `stack_id` int(10) unsigned NOT NULL,
  `URL` varchar(255) collate utf8_unicode_ci NOT NULL,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
  `artist` int(10) NOT NULL,
  `duration` tinyint(5) unsigned NOT NULL,
  `GUID` varchar(36) collate utf8_unicode_ci NOT NULL,
  `opening` varchar(255) collate utf8_unicode_ci default NULL,
  `ending` varchar(255) collate utf8_unicode_ci default NULL,
  `audio_format` varchar(255) collate utf8_unicode_ci NOT NULL,
  `audio_container` varchar(255) collate utf8_unicode_ci NOT NULL,
  `audio_channels` tinyint(2) NOT NULL,
  `audio_samplerate` mediumint(9) NOT NULL,
  `marker_fade_in` float default NULL,
  `marker_fade_out` float default NULL,
  `marker_start_next` float default NULL,
  PRIMARY KEY  (`id`),
  KEY `stack_id` (`stack_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `stacks`
--

DROP TABLE IF EXISTS `stacks`;
CREATE TABLE `stacks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `URI` varchar(255) collate utf8_unicode_ci NOT NULL,
  `weight` tinyint(4) NOT NULL default '-1',
  `rotations` tinyint(4) NOT NULL default '-1',
  `art_separation` tinyint(4) NOT NULL default '60',
  `tit_separation` tinyint(4) NOT NULL default '120',
  `di_bypass` tinyint(4) NOT NULL default '0',
  `as_bypass` tinyint(4) NOT NULL default '0',
  `ts_bypass` tinyint(4) NOT NULL default '0',
  `type_id` int(11) NOT NULL,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2007-07-15 16:12:31
