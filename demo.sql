-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: wordpress
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

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
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
INSERT INTO `wp_comments` VALUES (1,1,'A WordPress Commenter','wapuu@wordpress.example','https://wordpress.org/','','2024-02-08 14:18:49','2024-02-08 14:18:49','Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href=\"https://en.gravatar.com/\">Gravatar</a>.',0,'1','','comment',0,0);
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_links` (
  `link_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint unsigned NOT NULL DEFAULT '1',
  `link_rating` int NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_options` (
  `option_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (1,'siteurl','http://wordpress.io/edition','yes'),(2,'home','http://wordpress.io','yes'),(3,'blogname','Wp Steroids','yes'),(4,'blogdescription','','yes'),(5,'users_can_register','0','yes'),(6,'admin_email','demo@demo.com','yes'),(7,'start_of_week','1','yes'),(8,'use_balanceTags','0','yes'),(9,'use_smilies','1','yes'),(10,'require_name_email','1','yes'),(11,'comments_notify','','yes'),(12,'posts_per_rss','10','yes'),(13,'rss_use_excerpt','0','yes'),(14,'mailserver_url','mail.example.com','yes'),(15,'mailserver_login','login@example.com','yes'),(16,'mailserver_pass','password','yes'),(17,'mailserver_port','110','yes'),(18,'default_category','1','yes'),(19,'default_comment_status','','yes'),(20,'default_ping_status','','yes'),(21,'default_pingback_flag','','yes'),(22,'posts_per_page','10','yes'),(23,'date_format','F j, Y','yes'),(24,'time_format','g:i a','yes'),(25,'links_updated_date_format','F j, Y g:i a','yes'),(26,'comment_moderation','1','yes'),(27,'moderation_notify','1','yes'),(28,'permalink_structure','/%postname%','yes'),(29,'rewrite_rules','a:66:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:17:\"^wp-sitemap\\.xml$\";s:23:\"index.php?sitemap=index\";s:17:\"^wp-sitemap\\.xsl$\";s:36:\"index.php?sitemap-stylesheet=sitemap\";s:23:\"^wp-sitemap-index\\.xsl$\";s:34:\"index.php?sitemap-stylesheet=index\";s:48:\"^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$\";s:75:\"index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]\";s:34:\"^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$\";s:47:\"index.php?sitemap=$matches[1]&paged=$matches[2]\";s:8:\"guide/?$\";s:25:\"index.php?post_type=guide\";s:25:\"guide/page/([0-9]{1,})/?$\";s:43:\"index.php?post_type=guide&paged=$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:30:\"guide/([^/]+)(?:/([0-9]+))?/?$\";s:44:\"index.php?guide=$matches[1]&page=$matches[2]\";s:33:\"item/([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?item=$matches[1]&paged=$matches[2]\";s:15:\"item/([^/]+)/?$\";s:26:\"index.php?item=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:13:\"favicon\\.ico$\";s:19:\"index.php?favicon=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:27:\"comment-page-([0-9]{1,})/?$\";s:39:\"index.php?&page_id=20&cpage=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";}','yes'),(30,'hack_file','0','yes'),(31,'blog_charset','UTF-8','yes'),(32,'moderation_keys','','no'),(33,'active_plugins','a:3:{i:0;s:33:\"acf-extensions/acf-extensions.php\";i:1;s:34:\"advanced-custom-fields-pro/acf.php\";i:2;s:27:\"wp-steroids/wp-steroids.php\";}','yes'),(34,'category_base','','yes'),(35,'ping_sites','http://rpc.pingomatic.com/','yes'),(36,'comment_max_links','2','yes'),(37,'gmt_offset','0','yes'),(38,'default_email_category','1','yes'),(39,'recently_edited','','no'),(40,'template','timber','yes'),(41,'stylesheet','timber','yes'),(42,'comment_registration','1','yes'),(43,'html_type','text/html','yes'),(44,'use_trackback','0','yes'),(45,'default_role','subscriber','yes'),(46,'db_version','57155','yes'),(47,'uploads_use_yearmonth_folders','1','yes'),(48,'upload_path','','yes'),(49,'blog_public','0','yes'),(50,'default_link_category','2','yes'),(51,'show_on_front','page','yes'),(52,'tag_base','','yes'),(53,'show_avatars','','yes'),(54,'avatar_rating','G','yes'),(55,'upload_url_path','','yes'),(56,'thumbnail_size_w','150','yes'),(57,'thumbnail_size_h','150','yes'),(58,'thumbnail_crop','1','yes'),(59,'medium_size_w','300','yes'),(60,'medium_size_h','300','yes'),(61,'avatar_default','mystery','yes'),(62,'large_size_w','1024','yes'),(63,'large_size_h','1024','yes'),(64,'image_default_link_type','none','yes'),(65,'image_default_size','','yes'),(66,'image_default_align','','yes'),(67,'close_comments_for_old_posts','','yes'),(68,'close_comments_days_old','14','yes'),(69,'thread_comments','1','yes'),(70,'thread_comments_depth','5','yes'),(71,'page_comments','','yes'),(72,'comments_per_page','50','yes'),(73,'default_comments_page','newest','yes'),(74,'comment_order','asc','yes'),(75,'sticky_posts','a:0:{}','yes'),(76,'widget_categories','a:0:{}','yes'),(77,'widget_text','a:0:{}','yes'),(78,'widget_rss','a:0:{}','yes'),(79,'uninstall_plugins','a:0:{}','no'),(80,'timezone_string','','yes'),(81,'page_for_posts','0','yes'),(82,'page_on_front','20','yes'),(83,'default_post_format','0','yes'),(84,'link_manager_enabled','0','yes'),(85,'finished_splitting_shared_terms','1','yes'),(86,'site_icon','0','yes'),(87,'medium_large_size_w','768','yes'),(88,'medium_large_size_h','0','yes'),(89,'wp_page_for_privacy_policy','3','yes'),(90,'show_comments_cookies_opt_in','1','yes'),(91,'admin_email_lifespan','1741268048','yes'),(92,'disallowed_keys','','no'),(93,'comment_previously_approved','1','yes'),(94,'auto_plugin_theme_update_emails','a:0:{}','no'),(95,'auto_update_core_dev','enabled','yes'),(96,'auto_update_core_minor','enabled','yes'),(97,'auto_update_core_major','enabled','yes'),(98,'wp_force_deactivated_plugins','a:0:{}','yes'),(99,'wp_attachment_pages_enabled','0','yes'),(100,'initial_db_version','56657','yes'),(101,'wp_user_roles','a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:61:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:36:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:18:\"edit_theme_options\";b:1;s:6:\"editor\";s:20:\"wpseo_manage_options\";}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}','yes'),(102,'fresh_site','0','yes'),(103,'user_count','1','no'),(104,'widget_block','a:6:{i:2;a:1:{s:7:\"content\";s:19:\"<!-- wp:search /-->\";}i:3;a:1:{s:7:\"content\";s:154:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Posts</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->\";}i:4;a:1:{s:7:\"content\";s:227:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Comments</h2><!-- /wp:heading --><!-- wp:latest-comments {\"displayAvatar\":false,\"displayDate\":false,\"displayExcerpt\":false} /--></div><!-- /wp:group -->\";}i:5;a:1:{s:7:\"content\";s:146:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->\";}i:6;a:1:{s:7:\"content\";s:150:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->\";}s:12:\"_multiwidget\";i:1;}','yes'),(105,'sidebars_widgets','a:2:{s:19:\"wp_inactive_widgets\";a:5:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";i:3;s:7:\"block-5\";i:4;s:7:\"block-6\";}s:13:\"array_version\";i:3;}','yes'),(106,'bedrock_autoloader','a:2:{s:7:\"plugins\";a:1:{s:55:\"bedrock-disallow-indexing/bedrock-disallow-indexing.php\";a:14:{s:4:\"Name\";s:17:\"Disallow Indexing\";s:9:\"PluginURI\";s:25:\"https://roots.io/bedrock/\";s:7:\"Version\";s:5:\"2.0.0\";s:11:\"Description\";s:62:\"Disallow indexing of your site on non-production environments.\";s:6:\"Author\";s:5:\"Roots\";s:9:\"AuthorURI\";s:17:\"https://roots.io/\";s:10:\"TextDomain\";s:5:\"roots\";s:10:\"DomainPath\";s:0:\"\";s:7:\"Network\";b:0;s:10:\"RequiresWP\";s:0:\"\";s:11:\"RequiresPHP\";s:0:\"\";s:9:\"UpdateURI\";s:0:\"\";s:5:\"Title\";s:17:\"Disallow Indexing\";s:10:\"AuthorName\";s:5:\"Roots\";}}s:5:\"count\";i:1;}','no'),(107,'cron','a:6:{i:1725718729;a:4:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1725718735;a:3:{s:21:\"wp_update_user_counts\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1725718736;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1725956596;a:1:{s:27:\"acf_update_site_health_data\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}i:1726237129;a:1:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}s:7:\"version\";i:2;}','yes'),(108,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(109,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(110,'widget_archives','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(111,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(112,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(113,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(114,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(115,'widget_meta','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(116,'widget_search','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(117,'widget_recent-posts','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(118,'widget_recent-comments','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(119,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(120,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(121,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(122,'nonce_key','3<F;vb@jr_l;<=O95zE]L<R8]st:RU+$10tj0Hg7mIao8~5^GCTi>ha2GJE9}qnn','no'),(123,'nonce_salt','oOnIl+7uI7NdV=cI9=M%5^B|`bN1Dqp`^U(Z@llEn?Xz!Ry1lzFBY:9DCy&iGXY8','no'),(125,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-6.4.3.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-6.4.3.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-6.4.3-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-6.4.3-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:5:\"6.4.3\";s:7:\"version\";s:5:\"6.4.3\";s:11:\"php_version\";s:5:\"7.0.0\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"6.4\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1707401929;s:15:\"version_checked\";s:5:\"6.4.3\";s:12:\"translations\";a:0:{}}','no'),(126,'_site_transient_update_plugins','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1707401940;s:8:\"response\";a:1:{s:24:\"wordpress-seo/wp-seo.php\";O:8:\"stdClass\":12:{s:2:\"id\";s:27:\"w.org/plugins/wordpress-seo\";s:4:\"slug\";s:13:\"wordpress-seo\";s:6:\"plugin\";s:24:\"wordpress-seo/wp-seo.php\";s:11:\"new_version\";s:4:\"22.0\";s:3:\"url\";s:44:\"https://wordpress.org/plugins/wordpress-seo/\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/plugin/wordpress-seo.22.0.zip\";s:5:\"icons\";a:2:{s:2:\"1x\";s:58:\"https://ps.w.org/wordpress-seo/assets/icon.svg?rev=2363699\";s:3:\"svg\";s:58:\"https://ps.w.org/wordpress-seo/assets/icon.svg?rev=2363699\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/wordpress-seo/assets/banner-1544x500.png?rev=2643727\";s:2:\"1x\";s:68:\"https://ps.w.org/wordpress-seo/assets/banner-772x250.png?rev=2643727\";}s:11:\"banners_rtl\";a:2:{s:2:\"2x\";s:73:\"https://ps.w.org/wordpress-seo/assets/banner-1544x500-rtl.png?rev=2643727\";s:2:\"1x\";s:72:\"https://ps.w.org/wordpress-seo/assets/banner-772x250-rtl.png?rev=2643727\";}s:8:\"requires\";s:3:\"6.3\";s:6:\"tested\";s:5:\"6.4.3\";s:12:\"requires_php\";s:5:\"7.2.5\";}}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:7:{s:57:\"acf-content-analysis-for-yoast-seo/yoast-acf-analysis.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:48:\"w.org/plugins/acf-content-analysis-for-yoast-seo\";s:4:\"slug\";s:34:\"acf-content-analysis-for-yoast-seo\";s:6:\"plugin\";s:57:\"acf-content-analysis-for-yoast-seo/yoast-acf-analysis.php\";s:11:\"new_version\";s:3:\"3.1\";s:3:\"url\";s:65:\"https://wordpress.org/plugins/acf-content-analysis-for-yoast-seo/\";s:7:\"package\";s:81:\"https://downloads.wordpress.org/plugin/acf-content-analysis-for-yoast-seo.3.1.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:87:\"https://ps.w.org/acf-content-analysis-for-yoast-seo/assets/icon-256x256.png?rev=1717503\";s:2:\"1x\";s:87:\"https://ps.w.org/acf-content-analysis-for-yoast-seo/assets/icon-128x128.png?rev=1717503\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:90:\"https://ps.w.org/acf-content-analysis-for-yoast-seo/assets/banner-1544x500.png?rev=1717503\";s:2:\"1x\";s:89:\"https://ps.w.org/acf-content-analysis-for-yoast-seo/assets/banner-772x250.png?rev=1717503\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"6.1\";}s:31:\"cache-control/cache-control.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:27:\"w.org/plugins/cache-control\";s:4:\"slug\";s:13:\"cache-control\";s:6:\"plugin\";s:31:\"cache-control/cache-control.php\";s:11:\"new_version\";s:5:\"2.2.5\";s:3:\"url\";s:44:\"https://wordpress.org/plugins/cache-control/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/plugin/cache-control.2.2.5.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:66:\"https://ps.w.org/cache-control/assets/icon-256x256.png?rev=1632145\";s:2:\"1x\";s:66:\"https://ps.w.org/cache-control/assets/icon-128x128.png?rev=1632145\";}s:7:\"banners\";a:0:{}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:5:\"4.4.1\";}s:36:\"contact-form-7/wp-contact-form-7.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:28:\"w.org/plugins/contact-form-7\";s:4:\"slug\";s:14:\"contact-form-7\";s:6:\"plugin\";s:36:\"contact-form-7/wp-contact-form-7.php\";s:11:\"new_version\";s:5:\"5.8.7\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/contact-form-7/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.8.7.zip\";s:5:\"icons\";a:2:{s:2:\"1x\";s:59:\"https://ps.w.org/contact-form-7/assets/icon.svg?rev=2339255\";s:3:\"svg\";s:59:\"https://ps.w.org/contact-form-7/assets/icon.svg?rev=2339255\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/contact-form-7/assets/banner-1544x500.png?rev=860901\";s:2:\"1x\";s:68:\"https://ps.w.org/contact-form-7/assets/banner-772x250.png?rev=880427\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"6.2\";}s:41:\"password-protected/password-protected.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:32:\"w.org/plugins/password-protected\";s:4:\"slug\";s:18:\"password-protected\";s:6:\"plugin\";s:41:\"password-protected/password-protected.php\";s:11:\"new_version\";s:5:\"2.6.6\";s:3:\"url\";s:49:\"https://wordpress.org/plugins/password-protected/\";s:7:\"package\";s:67:\"https://downloads.wordpress.org/plugin/password-protected.2.6.6.zip\";s:5:\"icons\";a:1:{s:2:\"1x\";s:71:\"https://ps.w.org/password-protected/assets/icon-128x128.gif?rev=2824217\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:74:\"https://ps.w.org/password-protected/assets/banner-1544x500.jpg?rev=2824126\";s:2:\"1x\";s:73:\"https://ps.w.org/password-protected/assets/banner-772x250.jpg?rev=2824126\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"4.6\";}s:31:\"query-monitor/query-monitor.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:27:\"w.org/plugins/query-monitor\";s:4:\"slug\";s:13:\"query-monitor\";s:6:\"plugin\";s:31:\"query-monitor/query-monitor.php\";s:11:\"new_version\";s:6:\"3.15.0\";s:3:\"url\";s:44:\"https://wordpress.org/plugins/query-monitor/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/query-monitor.3.15.0.zip\";s:5:\"icons\";a:2:{s:2:\"1x\";s:58:\"https://ps.w.org/query-monitor/assets/icon.svg?rev=2994095\";s:3:\"svg\";s:58:\"https://ps.w.org/query-monitor/assets/icon.svg?rev=2994095\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/query-monitor/assets/banner-1544x500.png?rev=2870124\";s:2:\"1x\";s:68:\"https://ps.w.org/query-monitor/assets/banner-772x250.png?rev=2457098\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"5.6\";}s:27:\"redirection/redirection.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:25:\"w.org/plugins/redirection\";s:4:\"slug\";s:11:\"redirection\";s:6:\"plugin\";s:27:\"redirection/redirection.php\";s:11:\"new_version\";s:5:\"5.4.2\";s:3:\"url\";s:42:\"https://wordpress.org/plugins/redirection/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/plugin/redirection.5.4.2.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:63:\"https://ps.w.org/redirection/assets/icon-256x256.jpg?rev=983639\";s:2:\"1x\";s:63:\"https://ps.w.org/redirection/assets/icon-128x128.jpg?rev=983640\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:66:\"https://ps.w.org/redirection/assets/banner-1544x500.jpg?rev=983641\";s:2:\"1x\";s:65:\"https://ps.w.org/redirection/assets/banner-772x250.jpg?rev=983642\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"5.9\";}s:17:\"wp-2fa/wp-2fa.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:20:\"w.org/plugins/wp-2fa\";s:4:\"slug\";s:6:\"wp-2fa\";s:6:\"plugin\";s:17:\"wp-2fa/wp-2fa.php\";s:11:\"new_version\";s:5:\"2.6.2\";s:3:\"url\";s:37:\"https://wordpress.org/plugins/wp-2fa/\";s:7:\"package\";s:55:\"https://downloads.wordpress.org/plugin/wp-2fa.2.6.2.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:59:\"https://ps.w.org/wp-2fa/assets/icon-256x256.png?rev=2961533\";s:2:\"1x\";s:59:\"https://ps.w.org/wp-2fa/assets/icon-128x128.png?rev=2961533\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:62:\"https://ps.w.org/wp-2fa/assets/banner-1544x500.png?rev=2961533\";s:2:\"1x\";s:61:\"https://ps.w.org/wp-2fa/assets/banner-772x250.png?rev=2961533\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"5.0\";}}s:7:\"checked\";a:12:{s:57:\"acf-content-analysis-for-yoast-seo/yoast-acf-analysis.php\";s:3:\"3.1\";s:33:\"acf-extensions/acf-extensions.php\";s:5:\"1.3.8\";s:34:\"advanced-custom-fields-pro/acf.php\";s:7:\"6.2.6.1\";s:31:\"cache-control/cache-control.php\";s:5:\"2.2.5\";s:36:\"contact-form-7/wp-contact-form-7.php\";s:5:\"5.8.7\";s:41:\"password-protected/password-protected.php\";s:5:\"2.6.6\";s:31:\"query-monitor/query-monitor.php\";s:6:\"3.15.0\";s:27:\"redirection/redirection.php\";s:5:\"5.4.2\";s:45:\"wp-carbon-calculator/wp-carbon-calculator.php\";s:5:\"1.1.5\";s:27:\"wp-steroids/wp-steroids.php\";s:5:\"1.3.0\";s:17:\"wp-2fa/wp-2fa.php\";s:5:\"2.6.2\";s:24:\"wordpress-seo/wp-seo.php\";s:6:\"21.9.1\";}}','no'),(129,'_site_transient_update_themes','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1707401931;s:7:\"checked\";a:1:{s:6:\"timber\";s:0:\"\";}s:8:\"response\";a:0:{}s:9:\"no_update\";a:0:{}s:12:\"translations\";a:0:{}}','no'),(130,'auth_key','sfL=b$XtI>>vx49vra,A_$8FDGR5si-qsfqOPixy?$9S3>?HB)wtW7#2v&L[K4g*','no'),(131,'auth_salt','l`<X6{=Kse;U=i0q]l4j7[efWi`a;x`llgZ8]=60ChNCnmZ#H]*1*u_e@39H#5of','no'),(132,'logged_in_key','ai,y[}{%0e6_pQdY%~t5q18H$fm61O.&DpHkG(zq5IU$Kv%mR(#E>3;*g=Gy9;15','no'),(133,'logged_in_salt','b@I!a)b+8QJ1^,CpHQ?~NvnCc JyxR`wJO519vwwL|86fH!C>iaX4= Brfa_U$:N','no'),(152,'recently_activated','a:0:{}','yes'),(153,'wp_steroid','a:3:{s:7:\"version\";s:5:\"1.4.1\";s:6:\"config\";a:1:{s:9:\"wordpress\";a:18:{s:9:\"gutenberg\";a:10:{s:20:\"replace_reset_styles\";b:1;s:17:\"remove_core_block\";b:1;s:26:\"remove_core_block_patterns\";b:1;s:28:\"disable_classic_theme_styles\";b:1;s:20:\"remove_block_library\";b:1;s:26:\"load_remote_block_patterns\";b:0;s:18:\"block_editor_style\";s:17:\"/build/bundle.css\";s:19:\"block_editor_script\";s:10:\"/blocks.js\";s:15:\"render_template\";s:24:\"block/{name}/{name}.twig\";s:13:\"preview_image\";s:22:\"/app/blocks/{name}.png\";}s:5:\"image\";a:2:{s:11:\"compression\";i:95;s:6:\"resize\";a:2:{s:9:\"max_width\";i:1920;s:10:\"max_height\";i:2160;}}s:11:\"maintenance\";b:1;s:16:\"remove_menu_page\";a:1:{i:0;s:17:\"edit-comments.php\";}s:19:\"remove_submenu_page\";a:1:{i:0;a:1:{s:10:\"themes.php\";s:30:\"site-editor.php?path=/patterns\";}}s:11:\"mce_buttons\";a:23:{i:0;s:12:\"formatselect\";i:1;s:4:\"bold\";i:2;s:6:\"italic\";i:3;s:9:\"underline\";i:4;s:3:\"sup\";i:5;s:13:\"strikethrough\";i:6;s:11:\"superscript\";i:7;s:9:\"subscript\";i:8;s:7:\"bullist\";i:9;s:7:\"numlist\";i:10;s:10:\"blockquote\";i:11;s:2:\"hr\";i:12;s:5:\"table\";i:13;s:9:\"alignleft\";i:14;s:11:\"aligncenter\";i:15;s:10:\"alignright\";i:16;s:12:\"alignjustify\";i:17;s:4:\"link\";i:18;s:6:\"unlink\";i:19;s:7:\"wp_more\";i:20;s:12:\"spellchecker\";i:21;s:6:\"wp_adv\";i:22;s:3:\"dfw\";}s:7:\"support\";a:3:{i:0;s:4:\"page\";i:1;s:3:\"tag\";i:2;s:8:\"category\";}s:17:\"post_type_support\";a:1:{s:4:\"page\";a:1:{i:0;s:7:\"excerpt\";}}s:13:\"theme_support\";a:2:{i:0;s:21:\"disable-layout-styles\";i:1;s:9:\"thumbnail\";}s:12:\"options_page\";a:2:{s:6:\"global\";a:1:{s:6:\"fields\";a:1:{s:3:\"gtm\";a:1:{s:4:\"type\";s:4:\"text\";}}}s:12:\"translations\";a:1:{s:6:\"fields\";a:1:{s:12:\"translations\";a:3:{s:4:\"type\";s:8:\"repeater\";s:6:\"layout\";s:5:\"table\";s:10:\"sub_fields\";a:2:{s:3:\"key\";a:1:{s:4:\"type\";s:4:\"text\";}s:11:\"translation\";a:1:{s:4:\"type\";s:4:\"text\";}}}}}}s:3:\"acf\";a:6:{s:9:\"json_path\";s:11:\"/config/acf\";s:8:\"settings\";a:2:{s:10:\"use_entity\";b:1;s:8:\"autoload\";b:1;}s:13:\"user_settings\";a:1:{s:14:\"gallery_height\";i:210;}s:5:\"block\";a:1:{s:11:\"api_version\";i:3;}s:5:\"input\";a:1:{s:15:\"lock_max_length\";b:0;}s:8:\"toolbars\";a:2:{s:4:\"Full\";a:2:{i:1;a:15:{i:0;s:12:\"formatselect\";i:1;s:4:\"bold\";i:2;s:6:\"italic\";i:3;s:10:\"blockquote\";i:4;s:11:\"superscript\";i:5;s:9:\"subscript\";i:6;s:7:\"bullist\";i:7;s:7:\"numlist\";i:8;s:5:\"table\";i:9;s:12:\"alignjustify\";i:10;s:9:\"pastetext\";i:11;s:12:\"removeformat\";i:12;s:4:\"link\";i:13;s:6:\"wp_adv\";i:14;s:10:\"fullscreen\";}i:2;a:10:{i:0;s:4:\"undo\";i:1;s:4:\"redo\";i:2;s:2:\"hr\";i:3;s:9:\"underline\";i:4;s:13:\"strikethrough\";i:5;s:9:\"forecolor\";i:6;s:12:\"removeformat\";i:7;s:7:\"charmap\";i:8;s:7:\"outdent\";i:9;s:6:\"indent\";}}s:5:\"Basic\";a:1:{i:1;a:14:{i:0;s:4:\"bold\";i:1;s:6:\"italic\";i:2;s:10:\"blockquote\";i:3;s:11:\"superscript\";i:4;s:9:\"subscript\";i:5;s:9:\"forecolor\";i:6;s:7:\"bullist\";i:7;s:7:\"numlist\";i:8;s:5:\"table\";i:9;s:4:\"link\";i:10;s:12:\"alignjustify\";i:11;s:9:\"pastetext\";i:12;s:12:\"removeformat\";i:13;s:10:\"fullscreen\";}}}}s:4:\"menu\";a:2:{s:5:\"depth\";i:1;s:8:\"register\";a:2:{s:6:\"footer\";a:2:{s:5:\"title\";s:6:\"Footer\";s:6:\"fields\";a:1:{s:6:\"sample\";a:1:{s:4:\"type\";s:4:\"text\";}}}s:6:\"header\";s:6:\"Header\";}}s:5:\"block\";a:2:{s:4:\"hero\";a:6:{s:5:\"title\";s:4:\"Hero\";s:11:\"description\";s:9:\"Page Hero\";s:8:\"supports\";a:1:{s:8:\"multiple\";b:0;}s:4:\"icon\";s:16:\"editor-alignleft\";s:10:\"post_types\";a:2:{i:0;s:4:\"page\";i:1;s:5:\"guide\";}s:6:\"fields\";a:5:{s:8:\"suptitle\";a:1:{s:4:\"type\";s:4:\"text\";}s:5:\"title\";a:1:{s:4:\"type\";s:4:\"text\";}s:7:\"content\";a:3:{s:4:\"type\";s:7:\"wysiwyg\";s:7:\"toolbar\";s:5:\"basic\";s:12:\"media_upload\";b:0;}s:5:\"image\";a:1:{s:4:\"type\";s:5:\"image\";}s:3:\"cta\";a:1:{s:4:\"type\";s:4:\"link\";}}}s:7:\"contact\";a:3:{s:5:\"title\";s:7:\"Contact\";s:4:\"icon\";s:5:\"email\";s:10:\"post_types\";a:1:{i:0;s:4:\"page\";}}}s:9:\"post_type\";a:2:{s:4:\"page\";a:1:{s:8:\"template\";a:1:{i:0;a:2:{i:0;s:8:\"acf/hero\";i:1;a:1:{s:4:\"lock\";a:2:{s:4:\"move\";b:1;s:6:\"remove\";b:1;}}}}}s:5:\"guide\";a:7:{s:9:\"menu_icon\";s:4:\"book\";s:11:\"has_archive\";b:1;s:12:\"show_in_rest\";b:1;s:8:\"template\";a:1:{i:0;a:2:{i:0;s:8:\"acf/hero\";i:1;a:1:{s:4:\"lock\";a:2:{s:4:\"move\";b:1;s:6:\"remove\";b:1;}}}}s:8:\"supports\";a:5:{i:0;s:5:\"title\";i:1;s:7:\"excerpt\";i:2;s:9:\"thumbnail\";i:3;s:6:\"editor\";i:4;s:9:\"revisions\";}s:11:\"field_group\";a:1:{s:8:\"position\";s:4:\"side\";}s:6:\"fields\";a:1:{s:6:\"sample\";a:1:{s:4:\"type\";s:4:\"text\";}}}}s:8:\"taxonomy\";a:1:{s:4:\"item\";a:3:{s:12:\"show_in_rest\";b:1;s:11:\"object_type\";a:1:{i:0;s:5:\"guide\";}s:6:\"fields\";a:1:{s:6:\"sample\";a:1:{s:4:\"type\";s:4:\"text\";}}}}s:7:\"plugins\";a:1:{s:11:\"redirection\";a:1:{s:16:\"redirection_role\";s:17:\"edit_others_posts\";}}s:13:\"rewrite_rules\";a:1:{s:6:\"remove\";a:5:{i:0;s:6:\"author\";i:1;s:10:\"attachment\";i:2;s:5:\"embed\";i:3;s:9:\"trackback\";i:4;s:7:\"comment\";}}s:8:\"security\";a:4:{s:8:\"rest_api\";b:0;s:6:\"xmlrpc\";b:0;s:5:\"pings\";b:0;s:14:\"disable_update\";b:1;}}}s:9:\"filemtime\";i:1725717208;}','on'),(154,'acf_first_activated_version','6.2.6.1','yes'),(155,'acf_version','6.3.6','yes'),(158,'finished_updating_comment_type','1','yes'),(159,'theme_mods_twentytwentyfour','a:1:{s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1707402233;s:4:\"data\";a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";}s:9:\"sidebar-2\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}}}}','off'),(160,'current_theme','Timber Theme','yes'),(161,'theme_mods_timber','a:3:{i:0;b:0;s:18:\"nav_menu_locations\";a:2:{s:6:\"header\";i:2;s:6:\"footer\";i:3;}s:18:\"custom_css_post_id\";i:-1;}','yes'),(162,'theme_switched','','yes'),(163,'nav_menu_options','a:2:{i:0;b:0;s:8:\"auto_add\";a:0:{}}','yes'),(164,'item_children','a:0:{}','yes'),(171,'https_detection_errors','a:1:{s:20:\"https_request_failed\";a:1:{i:0;s:21:\"HTTPS request failed.\";}}','yes'),(172,'_transient_health-check-site-status-result','{\"good\":13,\"recommended\":6,\"critical\":1}','yes'),(179,'acf_site_health','{\"version\":\"6.3.6\",\"plugin_type\":\"PRO\",\"activated\":false,\"activated_url\":\"\",\"license_type\":\"\",\"license_status\":\"\",\"subscription_expires\":\"\",\"wp_version\":\"6.6.1\",\"mysql_version\":\"8.0.39-0ubuntu0.22.04.1\",\"is_multisite\":false,\"active_theme\":{\"name\":\"Timber Theme\",\"version\":\"\",\"theme_uri\":\"\",\"stylesheet\":false},\"active_plugins\":{\"acf-extensions\\/acf-extensions.php\":{\"name\":\"Advanced Custom Fields Extensions\",\"version\":\"1.3.10\",\"plugin_uri\":\"\"},\"advanced-custom-fields-pro\\/acf.php\":{\"name\":\"Advanced Custom Fields PRO\",\"version\":\"6.3.6\",\"plugin_uri\":\"https:\\/\\/www.advancedcustomfields.com\"},\"wp-steroids\\/wp-steroids.php\":{\"name\":\"WordPress on Steroids\",\"version\":\"1.4.1\",\"plugin_uri\":\"\"}},\"ui_field_groups\":\"1\",\"php_field_groups\":\"0\",\"json_field_groups\":\"2\",\"rest_field_groups\":\"0\",\"number_of_fields_by_type\":{\"post_object\":1,\"text\":8,\"wysiwyg\":2,\"image\":2,\"link\":2},\"number_of_third_party_fields_by_type\":[],\"post_types_enabled\":false,\"ui_post_types\":\"4\",\"json_post_types\":\"0\",\"ui_taxonomies\":\"4\",\"json_taxonomies\":\"0\",\"ui_options_pages_enabled\":true,\"ui_options_pages\":\"0\",\"json_options_pages\":\"0\",\"php_options_pages\":\"0\",\"rest_api_format\":\"light\",\"registered_acf_blocks\":\"2\",\"blocks_per_api_version\":{\"v2\":2},\"blocks_per_acf_block_version\":{\"v1\":2},\"blocks_using_post_meta\":\"0\",\"preload_blocks\":true,\"admin_ui_enabled\":true,\"field_type-modal_enabled\":true,\"field_settings_tabs_enabled\":false,\"shortcode_enabled\":true,\"registered_acf_forms\":\"0\",\"json_save_paths\":1,\"json_load_paths\":1,\"last_updated\":1725716027}','off'),(181,'_site_transient_timeout_wp_theme_files_patterns-fb10449267687425ace9312f7c16ab2d','1725717825','off'),(182,'_site_transient_wp_theme_files_patterns-fb10449267687425ace9312f7c16ab2d','a:2:{s:7:\"version\";s:0:\"\";s:8:\"patterns\";a:0:{}}','off'),(184,'_site_transient_timeout_theme_roots','1725717825','off'),(185,'_site_transient_theme_roots','a:1:{s:6:\"timber\";s:7:\"/themes\";}','off'),(186,'_site_transient_timeout_php_check_5d752ba2016ea61f3d144fd3524590fe','1726320826','off'),(187,'_site_transient_php_check_5d752ba2016ea61f3d144fd3524590fe','a:5:{s:19:\"recommended_version\";s:3:\"7.4\";s:15:\"minimum_version\";s:6:\"7.2.24\";s:12:\"is_supported\";b:1;s:9:\"is_secure\";b:1;s:13:\"is_acceptable\";b:1;}','off'),(188,'db_upgraded','','auto'),(191,'can_compress_scripts','0','on'),(194,'guide_rewrite_slug','guide','on'),(195,'guide_rewrite_archive','guide','on'),(196,'item_rewrite_slug','item','on'),(201,'_site_transient_wp_plugin_dependencies_plugin_data','a:0:{}','off');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES (1,2,'_wp_page_template','default'),(2,3,'_wp_page_template','default'),(4,2,'_edit_lock','1707402974:1'),(6,2,'footnotes',''),(8,6,'footnotes',''),(10,2,'_edit_last','1'),(15,8,'footnotes',''),(21,10,'footnotes',''),(23,11,'footnotes',''),(24,11,'_acf_changed',''),(25,12,'_edit_lock','1707403183:1'),(26,13,'_menu_item_type','post_type'),(27,13,'_menu_item_menu_item_parent','0'),(28,13,'_menu_item_object_id','2'),(29,13,'_menu_item_object','page'),(30,13,'_menu_item_target',''),(31,13,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(32,13,'_menu_item_xfn',''),(33,13,'_menu_item_url',''),(51,18,'_edit_last','1'),(52,18,'_edit_lock','1707405714:1'),(53,20,'_edit_lock','1725717638:1'),(55,20,'footnotes',''),(57,21,'footnotes',''),(59,20,'_edit_last','1'),(60,20,'dsfdsf',''),(61,20,'_dsfdsf','field_65c4efe1baa19'),(62,21,'dsfdsf',''),(63,21,'_dsfdsf','field_65c4efe1baa19'),(64,18,'_wp_trash_meta_status','publish'),(65,18,'_wp_trash_meta_time','1725716094'),(66,18,'_wp_desired_post_slug','group_65c4efe15063b'),(67,19,'_wp_trash_meta_status','publish'),(68,19,'_wp_trash_meta_time','1725716094'),(69,19,'_wp_desired_post_slug','field_65c4efe1baa19'),(70,22,'_wp_attached_file','2024/09/20240408-solareclipseoregon_en-us2134131862_uhd.jpg'),(71,22,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:1920;s:6:\"height\";i:1080;s:4:\"file\";s:59:\"2024/09/20240408-solareclipseoregon_en-us2134131862_uhd.jpg\";s:8:\"filesize\";i:471521;s:5:\"sizes\";a:2:{s:9:\"thumbnail\";a:5:{s:4:\"file\";s:59:\"20240408-solareclipseoregon_en-us2134131862_uhd-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:7801;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:60:\"20240408-solareclipseoregon_en-us2134131862_uhd-1536x864.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:864;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:120354;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}'),(74,23,'footnotes',''),(76,24,'_menu_item_type','post_type'),(77,24,'_menu_item_menu_item_parent','0'),(78,24,'_menu_item_object_id','20'),(79,24,'_menu_item_object','page'),(80,24,'_menu_item_target',''),(81,24,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(82,24,'_menu_item_xfn',''),(83,24,'_menu_item_url',''),(85,25,'_menu_item_type','post_type'),(86,25,'_menu_item_menu_item_parent','0'),(87,25,'_menu_item_object_id','2'),(88,25,'_menu_item_object','page'),(89,25,'_menu_item_target',''),(90,25,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(91,25,'_menu_item_xfn',''),(92,25,'_menu_item_url',''),(94,26,'_menu_item_type','post_type'),(95,26,'_menu_item_menu_item_parent','0'),(96,26,'_menu_item_object_id','20'),(97,26,'_menu_item_object','page'),(98,26,'_menu_item_target',''),(99,26,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(100,26,'_menu_item_xfn',''),(101,26,'_menu_item_url',''),(103,13,'_wp_old_date','2024-02-08'),(104,27,'footnotes',''),(105,27,'_acf_changed','');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_posts` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES (1,1,'2024-02-08 14:18:49','2024-02-08 14:18:49','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','publish','open','open','','hello-world','','','2024-02-08 14:18:49','2024-02-08 14:18:49','',0,'http://wordpress.io/?p=1',0,'post','',1),(2,1,'2024-02-08 14:18:49','2024-02-08 14:18:49','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"Hello\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"World\",\"_title\":\"field_65b819d15096\",\"content\":\"\",\"_content\":\"field_0a179ac1043c\",\"image\":\"\",\"_image\":\"field_e490253d05d6\",\"cta\":\"\",\"_cta\":\"field_6812820fd887\"},\"mode\":\"preview\"} /-->','Sample Page','','publish','closed','open','','sample-page','','','2024-02-08 14:27:36','2024-02-08 14:27:36','',0,'urn:uuid:35363938-6633-5432-b765-653437666332',0,'page','',0),(3,1,'2024-02-08 14:18:49','2024-02-08 14:18:49','<!-- wp:heading --><h2>Who we are</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Our website address is: http://wordpress.io.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Comments</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Media</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Cookies</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Embedded content from other websites</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Who we share your data with</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>How long we retain your data</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>What rights you have over your data</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Where your data is sent</h2><!-- /wp:heading --><!-- wp:paragraph --><p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p><!-- /wp:paragraph -->','Privacy Policy','','draft','closed','open','','privacy-policy','','','2024-02-08 14:18:49','2024-02-08 14:18:49','',0,'http://wordpress.io/?page_id=3',0,'page','',0),(6,1,'2024-02-08 14:21:15','2024-02-08 14:21:15','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"\",\"_suptitle\":\"field_63c55e460cba4\",\"title\":\"\",\"_title\":\"field_63c55e4e0cba5\",\"content\":\"\",\"_content\":\"field_63c55e570cba6\",\"image\":\"\",\"_image\":\"field_659c221c86026\",\"cta\":\"\",\"_cta\":\"field_63c55e6b0cba7\"},\"mode\":\"preview\"} /-->','Sample Page','','inherit','closed','closed','','2-revision-v1','','','2024-02-08 14:21:15','2024-02-08 14:21:15','',2,'urn:uuid:61633064-3230-5236-a138-353630386331',0,'revision','',0),(8,1,'2024-02-08 14:25:06','2024-02-08 14:25:06','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"\",\"_suptitle\":\"field_63c55e460cba4\",\"title\":\"\",\"_title\":\"field_63c55e4e0cba5\",\"content\":\"\",\"_content\":\"field_63c55e570cba6\",\"image\":\"\",\"_image\":\"field_659c221c86026\",\"cta\":\"\",\"_cta\":\"field_63c55e6b0cba7\"},\"mode\":\"preview\"} /-->','Sample Page','','inherit','closed','closed','','2-revision-v1','','','2024-02-08 14:25:06','2024-02-08 14:25:06','',2,'urn:uuid:64383630-6165-5366-b463-633264363037',0,'revision','',0),(10,1,'2024-02-08 14:27:36','2024-02-08 14:27:36','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"Hello\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"World\",\"_title\":\"field_65b819d15096\",\"content\":\"\",\"_content\":\"field_0a179ac1043c\",\"image\":\"\",\"_image\":\"field_e490253d05d6\",\"cta\":\"\",\"_cta\":\"field_6812820fd887\"},\"mode\":\"preview\"} /-->','Sample Page','','inherit','closed','closed','','2-revision-v1','','','2024-02-08 14:27:36','2024-02-08 14:27:36','',2,'urn:uuid:62623731-3866-5639-b062-663661653161',0,'revision','',0),(11,1,'2024-02-08 14:36:47','2024-02-08 14:36:47','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"Hello\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"World\",\"_title\":\"field_65b819d15096\",\"content\":\"\",\"_content\":\"field_0a179ac1043c\",\"image\":\"\",\"_image\":\"field_e490253d05d6\",\"cta\":\"\",\"_cta\":\"field_6812820fd887\",\"post\":{\"post_title\":\"Sample Page\",\"post_excerpt\":\"\",\"thumbnail_id\":0}},\"mode\":\"preview\"} /-->','Sample Page','','inherit','closed','closed','','2-autosave-v1','','','2024-02-08 14:36:47','2024-02-08 14:36:47','',2,'urn:uuid:65353531-6231-5965-b137-626466363634',0,'revision','',0),(12,1,'2024-02-08 14:39:43','0000-00-00 00:00:00','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"\",\"_title\":\"field_65b819d15096\",\"content\":\"\",\"_content\":\"field_0a179ac1043c\",\"image\":\"\",\"_image\":\"field_e490253d05d6\",\"cta\":\"\",\"_cta\":\"field_6812820fd887\"},\"mode\":\"preview\",\"lock\":{\"move\":true,\"remove\":true}} /-->','','','draft','closed','closed','','','','','2024-02-08 14:39:43','2024-02-08 14:39:43','',0,'urn:uuid:30316463-6163-5163-b334-323337626266',0,'guide','',0),(13,1,'2024-09-07 13:39:46','2024-02-08 14:43:21',' ','','','publish','closed','closed','','13','','','2024-09-07 13:39:46','2024-09-07 13:39:46','',0,'urn:uuid:37393831-3161-5266-a462-373461323233',1,'nav_menu_item','',0),(18,1,'2024-02-08 15:14:49','2024-02-08 15:14:49','a:9:{s:8:\"location\";a:1:{i:0;a:1:{i:0;a:3:{s:5:\"param\";s:9:\"post_type\";s:8:\"operator\";s:2:\"==\";s:5:\"value\";s:4:\"page\";}}}s:8:\"position\";s:4:\"side\";s:5:\"style\";s:7:\"default\";s:15:\"label_placement\";s:3:\"top\";s:21:\"instruction_placement\";s:5:\"label\";s:14:\"hide_on_screen\";s:0:\"\";s:11:\"description\";s:0:\"\";s:12:\"show_in_rest\";i:0;s:16:\"is_acf_component\";i:0;}','dsf','dsf','trash','closed','closed','','group_65c4efe15063b__trashed','','','2024-09-07 13:34:54','2024-09-07 13:34:54','',0,'urn:uuid:65616137-6263-5265-b930-646138303466',0,'acf-field-group','',0),(19,1,'2024-02-08 15:14:49','2024-02-08 15:14:49','a:12:{s:10:\"aria-label\";s:0:\"\";s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:3:\"tag\";i:0;s:13:\"default_value\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";}','dsf','dsfdsf','trash','closed','closed','','field_65c4efe1baa19__trashed','','','2024-09-07 13:34:54','2024-09-07 13:34:54','',18,'urn:uuid:39303161-3836-5630-a433-636630353561',0,'acf-field','',0),(20,1,'2024-09-07 13:34:50','2024-09-07 13:34:50','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"Lorem ipsum\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"Homepage\",\"_title\":\"field_65b819d15096\",\"content\":\"Lorem ipsum\",\"_content\":\"field_0a179ac1043c\",\"image\":22,\"_image\":\"field_e490253d05d6\",\"cta\":{\"title\":\"Homepage\",\"url\":\"http://wordpress.io/homepage/\",\"target\":\"\",\"aria_label\":\"\",\"post_id\":20,\"is_title\":true},\"_cta\":\"field_6812820fd887\"},\"mode\":\"preview\",\"lock\":{\"move\":true,\"remove\":true}} /-->','Homepage','','publish','closed','closed','','homepage','','','2024-09-07 13:35:51','2024-09-07 13:35:51','',0,'urn:uuid:64633563-3565-5438-b265-356533333135',0,'page','',0),(21,1,'2024-09-07 13:34:50','2024-09-07 13:34:50','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"\",\"_suptitle\":\"field_63c55e460cba4\",\"title\":\"\",\"_title\":\"field_63c55e4e0cba5\",\"content\":\"\",\"_content\":\"field_63c55e570cba6\",\"image\":\"\",\"_image\":\"field_659c221c86026\",\"cta\":\"\",\"_cta\":\"field_63c55e6b0cba7\"},\"mode\":\"preview\",\"lock\":{\"move\":true,\"remove\":true}} /-->','Homepage','','inherit','closed','closed','','20-revision-v1','','','2024-09-07 13:34:50','2024-09-07 13:34:50','',20,'urn:uuid:32386535-6439-5664-b534-363730646461',0,'revision','',0),(22,1,'2024-09-07 13:35:43','2024-09-07 13:35:43','','20240408-solareclipseoregon_en-us2134131862_uhd','','inherit','open','closed','','20240408-solareclipseoregon_en-us2134131862_uhd','','','2024-09-07 13:35:43','2024-09-07 13:35:43','',20,'urn:uuid:34303033-3061-5537-a466-316265376334',0,'attachment','image/jpeg',0),(23,1,'2024-09-07 13:35:51','2024-09-07 13:35:51','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"Lorem ipsum\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"Homepage\",\"_title\":\"field_65b819d15096\",\"content\":\"Lorem ipsum\",\"_content\":\"field_0a179ac1043c\",\"image\":22,\"_image\":\"field_e490253d05d6\",\"cta\":{\"title\":\"Homepage\",\"url\":\"http://wordpress.io/homepage/\",\"target\":\"\",\"aria_label\":\"\",\"post_id\":20,\"is_title\":true},\"_cta\":\"field_6812820fd887\"},\"mode\":\"preview\",\"lock\":{\"move\":true,\"remove\":true}} /-->','Homepage','','inherit','closed','closed','','20-revision-v1','','','2024-09-07 13:35:51','2024-09-07 13:35:51','',20,'urn:uuid:62353165-3865-5963-b138-313237633537',0,'revision','',0),(24,1,'2024-09-07 13:39:36','2024-09-07 13:39:36',' ','','','publish','closed','closed','','24','','','2024-09-07 13:39:36','2024-09-07 13:39:36','',0,'urn:uuid:37326130-3464-5564-a330-373062663336',1,'nav_menu_item','',0),(25,1,'2024-09-07 13:39:36','2024-09-07 13:39:36',' ','','','publish','closed','closed','','25','','','2024-09-07 13:39:36','2024-09-07 13:39:36','',0,'urn:uuid:66373237-3166-5031-a436-646264656664',2,'nav_menu_item','',0),(26,1,'2024-09-07 13:39:46','2024-09-07 13:39:46',' ','','','publish','closed','closed','','26','','','2024-09-07 13:39:46','2024-09-07 13:39:46','',0,'urn:uuid:33373533-3130-5433-b563-663036363831',2,'nav_menu_item','',0),(27,1,'2024-09-07 13:59:38','2024-09-07 13:59:38','<!-- wp:acf/hero {\"name\":\"acf/hero\",\"data\":{\"suptitle\":\"Lorem ipsum\",\"_suptitle\":\"field_2b9f55a5d530\",\"title\":\"Homepage\",\"_title\":\"field_65b819d15096\",\"content\":\"Lorem ipsum\",\"_content\":\"field_0a179ac1043c\",\"image\":22,\"_image\":\"field_e490253d05d6\",\"cta\":{\"title\":\"Homepage\",\"url\":\"http://wordpress.io/homepage/\",\"target\":\"\",\"aria_label\":\"\",\"post_id\":20,\"is_title\":true},\"_cta\":\"field_6812820fd887\",\"post\":{\"post_title\":\"Homepage\",\"post_excerpt\":\"\",\"thumbnail_id\":0}},\"mode\":\"preview\",\"lock\":{\"move\":true,\"remove\":true}} /-->','Homepage','','inherit','closed','closed','','20-autosave-v1','','','2024-09-07 13:59:38','2024-09-07 13:59:38','',20,'urn:uuid:61626331-6262-5565-b036-313266643038',0,'revision','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
INSERT INTO `wp_term_relationships` VALUES (1,1,0),(13,2,0),(24,3,0),(25,3,0),(26,2,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint unsigned NOT NULL DEFAULT '0',
  `count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES (1,1,'category','',0,1),(2,2,'nav_menu','',0,2),(3,3,'nav_menu','',0,2),(4,4,'item','',0,0);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
INSERT INTO `wp_termmeta` VALUES (1,4,'sample',''),(2,4,'_sample','field_cb4f39eeccbb'),(3,3,'sample',''),(4,3,'_sample','field_f109bc9a2e05');
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES (1,'Uncategorized','uncategorized',0),(2,'Header','header',0),(3,'Footer','footer',0),(4,'sds','dsd',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','demo'),(2,1,'first_name',''),(3,1,'last_name',''),(4,1,'description',''),(5,1,'rich_editing','true'),(6,1,'syntax_highlighting','true'),(7,1,'comment_shortcuts','false'),(8,1,'admin_color','fresh'),(9,1,'use_ssl','0'),(10,1,'show_admin_bar_front','true'),(11,1,'locale',''),(12,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}'),(13,1,'wp_user_level','10'),(14,1,'dismissed_wp_pointers',''),(15,1,'show_welcome_panel','1'),(16,1,'session_tokens','a:3:{s:64:\"2302fc8f5bc4216b703b3c7abf9a8789c7875174b83adb02e840a8656445649c\";a:4:{s:10:\"expiration\";i:1725888847;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:101:\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36\";s:5:\"login\";i:1725716047;}s:64:\"9c0174ece72cf1d3bbd25adcf53cce87ac7df6a916a72f9689fb77d15e37bad2\";a:4:{s:10:\"expiration\";i:1725890239;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:101:\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36\";s:5:\"login\";i:1725717439;}s:64:\"dba9777c84357bd7ef43c43448e5eba298c2a3e0355cf488e21efc2e8b0851c0\";a:4:{s:10:\"expiration\";i:1725890310;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:101:\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36\";s:5:\"login\";i:1725717510;}}'),(17,1,'wp_user-settings','editor=tinymce&libraryContent=browse'),(18,1,'wp_user-settings-time','1707401931'),(19,1,'wp_dashboard_quick_press_last_post_id','4'),(20,1,'community-events-location','a:1:{s:2:\"ip\";s:9:\"127.0.0.0\";}'),(21,1,'acf_user_settings','a:1:{s:14:\"gallery_height\";i:210;}'),(22,1,'closedpostboxes_page','a:1:{i:0;s:12:\"wps_settings\";}'),(23,1,'metaboxhidden_page','a:0:{}'),(24,1,'managenav-menuscolumnshidden','a:5:{i:0;s:11:\"link-target\";i:1;s:11:\"css-classes\";i:2;s:3:\"xfn\";i:3;s:11:\"description\";i:4;s:15:\"title-attribute\";}'),(25,1,'metaboxhidden_nav-menus','a:3:{i:0;s:19:\"add-post-type-guide\";i:1;s:12:\"add-post_tag\";i:2;s:8:\"add-item\";}'),(26,1,'nav_menu_recently_edited','2');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_users` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'demo','$2y$10$NSvpa2KIYVccBAF8tocSPuZ1.S9FDm4e7N4dQA.Xa.y1gP56OeuSq','demo','demo@demo.com','http://wordpress.io/edition','2024-02-08 14:18:49','',0,'demo');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-07 16:02:17
