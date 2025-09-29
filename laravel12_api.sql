-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.4.3 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for laravel12_api
CREATE DATABASE IF NOT EXISTS `laravel12_api` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laravel12_api`;

-- Dumping structure for table laravel12_api.blog_categories
CREATE TABLE IF NOT EXISTS `blog_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.blog_categories: ~7 rows (approximately)
INSERT INTO `blog_categories` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
	(4, 'Campaign 1', 'campaign-1', '2025-09-27 11:28:11', '2025-09-28 13:58:26'),
	(5, 'Campaign 2', 'campaign-2', '2025-09-28 05:59:02', '2025-09-28 13:58:40'),
	(8, 'Campaign 3', 'campaign-3', '2025-09-28 06:53:57', '2025-09-28 20:07:53'),
	(16, 'Campaign 4', 'campaign-4', '2025-09-28 19:25:23', '2025-09-28 20:08:17'),
	(17, 'Campaing 2', 'campaing-2', '2025-09-29 03:48:20', '2025-09-29 03:48:20'),
	(18, 'Campaing 2', 'campaing-2', '2025-09-29 03:52:19', '2025-09-29 03:52:19'),
	(19, 'Campaing 2', 'campaing-2', '2025-09-29 03:59:07', '2025-09-29 03:59:07');

-- Dumping structure for table laravel12_api.blog_posts
CREATE TABLE IF NOT EXISTS `blog_posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL,
  `published_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_posts_user_id_foreign` (`user_id`),
  KEY `blog_posts_category_id_foreign` (`category_id`),
  CONSTRAINT `blog_posts_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.blog_posts: ~13 rows (approximately)
INSERT INTO `blog_posts` (`id`, `user_id`, `category_id`, `title`, `slug`, `content`, `excerpt`, `thumbnail`, `status`, `published_at`, `created_at`, `updated_at`) VALUES
	(26, 5, 5, 'Banking Campaign 1', 'banking-campaign-1', 'Campaign data goes here', 'Custom data goes here', 'storage/posts/1759038118_thumbnail.jpg', 'draft', '2025-09-28 05:41:58', '2025-09-28 03:41:58', '2025-09-28 20:46:49'),
	(27, 5, 5, 'Banking Campaign 2', 'banking-campaign-2', 'Campaign data goes here', 'Custom data goes here', 'storage/posts/1759038139_thumbnail.jpg', 'draft', '2025-09-28 05:42:19', '2025-09-28 03:42:19', '2025-09-28 20:47:12'),
	(30, 5, 5, 'Banking Campaign 4', 'banking-campaign-4', 'Campaign data goes here', 'Custom data goes here', 'storage/posts/1759049546_thumbnail.jpg', 'draft', '2025-09-28 08:52:26', '2025-09-28 06:52:26', '2025-09-28 20:47:58'),
	(31, 5, 5, 'Banking Campaign 4', 'banking-campaign-4', 'Campaign data goes here', 'Custom data goes here', 'storage/posts/1759049549_thumbnail.jpg', 'draft', '2025-09-28 08:52:29', '2025-09-28 06:52:29', '2025-09-29 03:53:06'),
	(32, 5, 4, 'author blog', 'author-blog', 'author new content', NULL, 'storage/posts/1759051354_thumbnail.jpg', 'published', '2025-09-28 09:22:34', '2025-09-28 07:22:34', '2025-09-28 07:22:34'),
	(33, 5, 4, 'author blog', 'author-blog', 'author new content', NULL, 'storage/posts/1759051437_thumbnail.jpg', 'published', '2025-09-28 09:23:57', '2025-09-28 07:23:57', '2025-09-28 07:23:57'),
	(34, 4, 4, 'author blog', 'author-blog', 'author new content', NULL, 'storage/posts/1759051488_thumbnail.jpg', 'published', '2025-09-28 09:24:48', '2025-09-28 07:24:48', '2025-09-28 07:24:48'),
	(35, 4, 4, 'author blog', 'author-blog', 'author new content', NULL, 'storage/posts/1759052025_thumbnail.jpg', 'draft', '2025-09-28 09:33:45', '2025-09-28 07:33:45', '2025-09-28 07:33:45'),
	(36, 5, 4, 'author blog', 'author-blog', 'author new content', NULL, 'storage/posts/1759052071_thumbnail.jpg', 'draft', '2025-09-28 09:34:31', '2025-09-28 07:34:31', '2025-09-28 07:34:31'),
	(37, 5, 4, 'author blog', 'author-blog', 'author new content', NULL, 'storage/posts/1759052135_thumbnail.jpg', 'published', '2025-09-28 09:35:35', '2025-09-28 07:35:35', '2025-09-28 07:35:35'),
	(47, 5, 4, 'Personalized Banking That Connects', 'personalized-banking-that-connects', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action. From onboarding to investment updates, each client receives dynamic videos tailored to their name, products, and financial journey. Backed by compliance-ready delivery and actionable analytics, UBG gains deeper engagement, higher conversion, and measurable ROI. Our turnkey solution blends creativity with technology, ensuring every interaction feels personal, secure, and impactful — redefining how UBG connects with clients in today’s digital-first financial landscape.', NULL, 'storage/posts/1759076226_united group.png', 'published', '2025-09-28 16:17:06', '2025-09-28 14:17:06', '2025-09-28 14:17:06'),
	(48, 5, 4, 'Personalized Banking That Connects', 'personalized-banking-that-connects', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action. From onboarding to investment updates, each client receives dynamic videos tailored to their name, products, and financial journey. Backed by compliance-ready delivery and actionable analytics, UBG gains deeper engagement, higher conversion, and measurable ROI. Our turnkey solution blends creativity with technology, ensuring every interaction feels personal, secure, and impactful — redefining how UBG connects with clients in today’s digital-first financial landscape.', NULL, 'storage/posts/1759096101_united group.png', 'published', '2025-09-28 21:48:21', '2025-09-28 19:48:21', '2025-09-28 19:48:21'),
	(49, 5, 4, 'Personalized Banking That Connects', 'personalized-banking-that-connects', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action. From onboarding to investment updates, each client receives dynamic videos tailored to their name, products, and financial journey. Backed by compliance-ready delivery and actionable analytics, UBG gains deeper engagement, higher conversion, and measurable ROI. Our turnkey solution blends creativity with technology, ensuring every interaction feels personal, secure, and impactful — redefining how UBG connects with clients in today’s digital-first financial landscape.', NULL, 'storage/posts/1759125301_united group.png', 'published', '2025-09-29 05:55:01', '2025-09-29 03:55:01', '2025-09-29 03:55:01');

-- Dumping structure for table laravel12_api.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.cache: ~6 rows (approximately)
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('laravel-cache-posts-store:3', 'i:2;', 1759126291),
	('laravel-cache-posts-store:3:timer', 'i:1759126291;', 1759126291),
	('laravel-cache-posts-store:4', 'i:2;', 1759125853),
	('laravel-cache-posts-store:4:timer', 'i:1759125853;', 1759125853),
	('laravel-cache-posts-store:5', 'i:2;', 1759125508),
	('laravel-cache-posts-store:5:timer', 'i:1759125508;', 1759125508);

-- Dumping structure for table laravel12_api.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.cache_locks: ~0 rows (approximately)

-- Dumping structure for table laravel12_api.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.comments: ~6 rows (approximately)
INSERT INTO `comments` (`id`, `post_id`, `user_id`, `parent_id`, `content`, `status`, `created_at`, `updated_at`) VALUES
	(1, 10, 5, NULL, 'hallo daar', 'approved', '2025-09-28 12:00:24', '2025-09-28 12:53:52'),
	(2, 5, 5, NULL, 'hallo daar', 'approved', '2025-09-28 12:03:11', '2025-09-29 03:57:28'),
	(3, 19, 5, NULL, 'hallo daar die campaign is awesome guys', 'pending', '2025-09-28 12:07:31', '2025-09-28 12:07:31'),
	(4, 28, 5, NULL, 'I really like this product - please contact me', 'pending', '2025-09-28 19:50:45', '2025-09-28 19:50:45'),
	(5, 33, 4, NULL, 'I really like this product - please contact me', 'pending', '2025-09-29 03:56:47', '2025-09-29 03:56:47'),
	(6, 33, 3, NULL, 'I really like this product - please contact me', 'pending', '2025-09-29 04:09:30', '2025-09-29 04:09:30');

-- Dumping structure for table laravel12_api.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table laravel12_api.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.jobs: ~0 rows (approximately)

-- Dumping structure for table laravel12_api.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.job_batches: ~0 rows (approximately)

-- Dumping structure for table laravel12_api.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.likes: ~2 rows (approximately)
INSERT INTO `likes` (`id`, `post_id`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 10, 5, 2, '2025-09-28 10:26:58', '2025-09-28 10:29:06'),
	(5, 26, 3, 1, '2025-09-29 04:06:17', '2025-09-29 04:06:17');

-- Dumping structure for table laravel12_api.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.migrations: ~11 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_09_26_104240_create_personal_access_tokens_table', 1),
	(5, '2025_09_26_121954_create_students_table', 1),
	(6, '2025_09_26_195503_create_blog_catergories_table', 1),
	(7, '2025_09_26_195727_create_blog_posts_table', 1),
	(8, '2025_09_26_202121_create_comments_table', 1),
	(9, '2025_09_26_202600_create_likes_table', 1),
	(10, '2025_09_26_202745_create_seos_table', 1),
	(11, '2025_09_28_112057_add_status_to_likes_table', 2);

-- Dumping structure for table laravel12_api.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table laravel12_api.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.personal_access_tokens: ~45 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
	(15, 'App\\Models\\User', 1, 'BlogApp', '649bd410fcce71a20b2a3ef0b2d2bff0b1de03deccefb9a9d7ecd20e3615078e', '["*"]', NULL, NULL, '2025-09-27 08:27:58', '2025-09-27 08:27:58'),
	(16, 'App\\Models\\User', 4, 'BlogApp', '744f6ce28f8f2aa84ebc655a3b41625c11945784c99ee36076cb802c0995cfd4', '["*"]', '2025-09-28 13:50:59', NULL, '2025-09-27 08:44:23', '2025-09-28 13:50:59'),
	(17, 'App\\Models\\User', 4, 'BlogApp', '123e4252b0596579318c20be527f3a0ca3fad58466d92d4e8601bafcccd570b0', '["*"]', NULL, NULL, '2025-09-27 08:53:01', '2025-09-27 08:53:01'),
	(26, 'App\\Models\\User', 4, 'BlogApp', 'd918a25bcbeb726e1d6df58d72ce00de09fef5a36860f0f1a9961b727eb73630', '["*"]', '2025-09-27 12:22:05', NULL, '2025-09-27 12:21:49', '2025-09-27 12:22:05'),
	(30, 'App\\Models\\User', 4, 'BlogApp', 'c43238875ec85be0625c62cdbf2ff0d899c64c6f173c8daff8f88be7891f8bd4', '["*"]', '2025-09-27 12:57:43', NULL, '2025-09-27 12:56:47', '2025-09-27 12:57:43'),
	(33, 'App\\Models\\User', 4, 'BlogApp', 'ab48d7948c9bdc1ec16b3636d5ee632cd8aade44f7d6b295d1dc1ffdc1f6fff7', '["*"]', '2025-09-27 13:19:24', NULL, '2025-09-27 13:18:50', '2025-09-27 13:19:24'),
	(36, 'App\\Models\\User', 4, 'BlogApp', '7510e1a689656944d1e0826cddafe2642a7a98cd6c118d42f84f5e55d7eb0145', '["*"]', '2025-09-27 18:36:42', NULL, '2025-09-27 15:09:25', '2025-09-27 18:36:42'),
	(39, 'App\\Models\\User', 4, 'BlogApp', '63c506cd565f8329e2c95b587073c27d48bb2f1ad1de5f286dfec5104d487e51', '["*"]', '2025-09-27 16:13:26', NULL, '2025-09-27 16:13:07', '2025-09-27 16:13:26'),
	(41, 'App\\Models\\User', 4, 'BlogApp', '8e8a8adf7a871512dd996c84278266fb4670cb25bafae49cca3243b7f5950a97', '["*"]', '2025-09-27 16:36:43', NULL, '2025-09-27 16:36:26', '2025-09-27 16:36:43'),
	(46, 'App\\Models\\User', 4, 'BlogApp', '0bda7282554249ed03176626d5289c4d68a57bc433288325553f86f288600d5d', '["*"]', NULL, NULL, '2025-09-28 03:36:55', '2025-09-28 03:36:55'),
	(48, 'App\\Models\\User', 4, 'BlogApp', '3dc300b1878f6dd0182301fd4569b577b7be1029b8300fa99133602d6fe85ee1', '["*"]', '2025-09-28 04:02:18', NULL, '2025-09-28 04:01:52', '2025-09-28 04:02:18'),
	(49, 'App\\Models\\User', 4, 'BlogApp', '97b54d7fab79669bc28675596744919dd6a4c85b593aa14005f47ec91b3bcec8', '["*"]', '2025-09-28 04:18:20', NULL, '2025-09-28 04:10:13', '2025-09-28 04:18:20'),
	(50, 'App\\Models\\User', 4, 'BlogApp', 'ed4f391460c814d732a2403bdca2044b924470ac92952fc82a6bd59ddd1c86c9', '["*"]', '2025-09-28 06:44:47', NULL, '2025-09-28 04:17:09', '2025-09-28 06:44:47'),
	(52, 'App\\Models\\User', 4, 'BlogApp', 'a68043091ccc614101c68dd0f6343518d77296ad3b68d72628f885b2284c3ccb', '["*"]', '2025-09-28 04:28:01', NULL, '2025-09-28 04:25:38', '2025-09-28 04:28:01'),
	(54, 'App\\Models\\User', 4, 'BlogApp', '84060c5e559df6de009fa575744a956d978fe0f31cd433aec41a747cddb9a4a1', '["*"]', '2025-09-28 06:09:57', NULL, '2025-09-28 05:38:03', '2025-09-28 06:09:57'),
	(55, 'App\\Models\\User', 4, 'BlogApp', '63c0effc7d33789e9ce38c65fb8dfb0bf727357e590a7ab1d4b22f164726d8ab', '["*"]', '2025-09-28 06:32:44', NULL, '2025-09-28 05:59:20', '2025-09-28 06:32:44'),
	(56, 'App\\Models\\User', 4, 'BlogApp', '93ce0428b159bfc68aab82bfae8d7964e2d0f0c75d7e5c0ff4450643582b113c', '["*"]', '2025-09-28 06:27:23', NULL, '2025-09-28 06:10:17', '2025-09-28 06:27:23'),
	(57, 'App\\Models\\User', 4, 'BlogApp', 'b19500603b9dd063510991d67dbfda85e57dac8f734257c4ade64b6a0ad86d9e', '["*"]', NULL, NULL, '2025-09-28 06:27:10', '2025-09-28 06:27:10'),
	(58, 'App\\Models\\User', 3, 'BlogApp', '6f11927a9906941dcb9cc829d7182f62a1148f280a8b619399c644da6a0b3fce', '["*"]', '2025-09-28 06:52:49', NULL, '2025-09-28 06:28:01', '2025-09-28 06:52:49'),
	(59, 'App\\Models\\User', 4, 'BlogApp', '848a6560f0ac74c456dd3d2817f76a030f0d3e1493e387e879d44ffde246d501', '["*"]', '2025-09-28 19:25:22', NULL, '2025-09-28 06:32:58', '2025-09-28 19:25:22'),
	(60, 'App\\Models\\User', 4, 'BlogApp', '8e788eff72c2955577d5ee16aee9e3045481915b2af624ae8be20b1814b7e467', '["*"]', '2025-09-28 06:51:38', NULL, '2025-09-28 06:44:56', '2025-09-28 06:51:38'),
	(63, 'App\\Models\\User', 3, 'BlogApp', '76adadbfdadd080640200768c568e1011cc4428f78da2230eae4fa6498de2b14', '["*"]', '2025-09-29 03:53:52', NULL, '2025-09-28 06:53:29', '2025-09-29 03:53:52'),
	(64, 'App\\Models\\User', 3, 'BlogApp', '2340dc7ecaa95a55e2fd3c6e4ce12b427af3c7c8cd0bae555ec762d8b4ec2112', '["*"]', '2025-09-28 07:23:06', NULL, '2025-09-28 07:22:52', '2025-09-28 07:23:06'),
	(65, 'App\\Models\\User', 4, 'BlogApp', '643e223d9f1bdade17818801c16f61b490d37bac3709e0ed229305d407fd01a9', '["*"]', '2025-09-28 07:23:34', NULL, '2025-09-28 07:23:20', '2025-09-28 07:23:34'),
	(67, 'App\\Models\\User', 4, 'BlogApp', 'e05907065487c103f56809fe22450343be55abd3800506c3048bb06be8712fb9', '["*"]', '2025-09-28 07:33:45', NULL, '2025-09-28 07:24:36', '2025-09-28 07:33:45'),
	(70, 'App\\Models\\User', 4, 'BlogApp', '930af3f41f8b0f3773749c4fb888b30690a708c81e63bdec766055cd76c68721', '["*"]', '2025-09-28 07:38:17', NULL, '2025-09-28 07:37:58', '2025-09-28 07:38:17'),
	(81, 'App\\Models\\User', 4, 'BlogApp', 'b10456df5928dc2fc19063b8db97ab7293b6c93b7a87165dec0657e3b84d0b0b', '["*"]', '2025-09-28 12:26:06', NULL, '2025-09-28 12:25:54', '2025-09-28 12:26:06'),
	(84, 'App\\Models\\User', 4, 'BlogApp', 'dd893373a44f668af350b23b01996334a5654bab726023250497d0808e7bbb96', '["*"]', '2025-09-28 12:59:16', NULL, '2025-09-28 12:54:07', '2025-09-28 12:59:16'),
	(85, 'App\\Models\\User', 4, 'BlogApp', 'f36f1588f9d8be6b2a718a211b922be5a1162542fe8afbfa0f1e7ba7f9c648d7', '["*"]', NULL, NULL, '2025-09-28 12:56:04', '2025-09-28 12:56:04'),
	(88, 'App\\Models\\User', 4, 'BlogApp', 'f014deaa63338c26df759a819f1bab5c188d9605b5b083119aabc9ba11bc1335', '["*"]', '2025-09-28 13:10:32', NULL, '2025-09-28 13:08:25', '2025-09-28 13:10:32'),
	(91, 'App\\Models\\User', 5, 'BlogApp', 'e237ac2b1ac7e1d360380c23561f819c8565fb7702c5d0a060d28cf4c8a44868', '["*"]', '2025-09-28 19:43:57', NULL, '2025-09-28 19:30:55', '2025-09-28 19:43:57'),
	(92, 'App\\Models\\User', 5, 'BlogApp', '516bb5ceb93c2caadca18e967b65f3036370a277af676a49bbf67c58108289b4', '["*"]', NULL, NULL, '2025-09-28 19:35:35', '2025-09-28 19:35:35'),
	(93, 'App\\Models\\User', 5, 'BlogApp', '441e2a60b37ebdc28dc6144dad39fc47347b76436798c41b39a42dc4437837f0', '["*"]', NULL, NULL, '2025-09-28 19:35:53', '2025-09-28 19:35:53'),
	(94, 'App\\Models\\User', 5, 'BlogApp', '0c3488b7410b9dee7874af3fadf7358cd63381fc70df71184b5c45d85625e194', '["*"]', '2025-09-29 03:58:10', NULL, '2025-09-28 19:45:26', '2025-09-29 03:58:10'),
	(95, 'App\\Models\\User', 5, 'BlogApp', 'e6023b66415659bc193846c3234c357e4d74a80d2695fa8b0aca557b1645d2b6', '["*"]', '2025-09-28 20:06:38', NULL, '2025-09-28 20:05:11', '2025-09-28 20:06:38'),
	(96, 'App\\Models\\User', 5, 'BlogApp', '37ece217f0f2fb0be9dec2f42f1afab571c82349cf428e962417b33778d3a930', '["*"]', '2025-09-28 20:08:17', NULL, '2025-09-28 20:07:29', '2025-09-28 20:08:17'),
	(97, 'App\\Models\\User', 5, 'BlogApp', '85aa16b9558fe6acc90a57213a1279211c4676de67af36c74df473b5a2bee1e4', '["*"]', '2025-09-28 20:22:45', NULL, '2025-09-28 20:10:25', '2025-09-28 20:22:45'),
	(98, 'App\\Models\\User', 5, 'BlogApp', 'b0b23af82fee29273f488caf40d4a56acce33d9984da239330930a5589abf7df', '["*"]', '2025-09-28 20:47:58', NULL, '2025-09-28 20:23:11', '2025-09-28 20:47:58'),
	(99, 'App\\Models\\User', 3, 'BlogApp', 'dc921a680f78f098c3c98dfc496eb41ff6979e6d559a50bc965980e49ea232a3', '["*"]', NULL, NULL, '2025-09-29 03:42:55', '2025-09-29 03:42:55'),
	(100, 'App\\Models\\User', 3, 'BlogApp', '418b10b90f48252bc78dd6d63d78c7693ff30e661a4e818a6f8b497465c62d24', '["*"]', NULL, NULL, '2025-09-29 03:43:22', '2025-09-29 03:43:22'),
	(101, 'App\\Models\\User', 3, 'BlogApp', 'da8aa1e2f609cb3ebf6668fb5d38b64440e8c89c8e171bccffd242afd3ff61d7', '["*"]', '2025-09-29 03:45:20', NULL, '2025-09-29 03:45:07', '2025-09-29 03:45:20'),
	(102, 'App\\Models\\User', 4, 'BlogApp', 'a56a44c96f4075798b79dea4f1224e02e40cb6a868ffdb094527aaf2cdc2233b', '["*"]', '2025-09-29 03:56:47', NULL, '2025-09-29 03:48:00', '2025-09-29 03:56:47'),
	(103, 'App\\Models\\User', 4, 'BlogApp', 'a427f595b4473274510445becea3c0be38c96d92eb9885e3a50b4e80ba6c9cdd', '["*"]', '2025-09-29 03:59:29', NULL, '2025-09-29 03:57:01', '2025-09-29 03:59:29'),
	(104, 'App\\Models\\User', 4, 'BlogApp', '3af9f3ae8444b094b640b4caa278ba3750f411df1bbe2dcc92cabd7149f03a3e', '["*"]', '2025-09-29 04:04:34', NULL, '2025-09-29 04:01:49', '2025-09-29 04:04:34'),
	(105, 'App\\Models\\User', 3, 'BlogApp', '562e60da8f0fe29ab4f9d17849306e972fafbae08de2e8606994898691bb0ab0', '["*"]', '2025-09-29 04:11:05', NULL, '2025-09-29 04:05:54', '2025-09-29 04:11:05');

-- Dumping structure for table laravel12_api.seos
CREATE TABLE IF NOT EXISTS `seos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `meta_title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.seos: ~12 rows (approximately)
INSERT INTO `seos` (`id`, `post_id`, `meta_title`, `meta_description`, `meta_keywords`, `created_at`, `updated_at`) VALUES
	(1, 44, 'Banks campaigns', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action.', 'bank, finance, loans, insurance', '2025-09-28 08:27:47', '2025-09-28 08:27:47'),
	(2, 45, 'Banks campaigns', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action.', 'bank, finance, loans, insurance', '2025-09-28 08:38:23', '2025-09-28 08:38:23'),
	(3, 46, 'Banks campaigns', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action.', 'bank, finance, loans, insurance', '2025-09-28 08:39:29', '2025-09-28 08:39:29'),
	(4, 10, 'edited meta title', 'edited meta description', 'new keyword1,newkeyword2', '2025-09-28 09:12:46', '2025-09-28 09:12:46'),
	(5, 47, 'Banks campaigns', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action.', 'bank, finance, loans, insurance', '2025-09-28 14:17:06', '2025-09-28 14:17:06'),
	(6, 48, 'Banks campaigns', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action.', 'bank, finance, loans, insurance', '2025-09-28 19:48:21', '2025-09-28 19:48:21'),
	(7, 28, 'BC1', 'edited meta description', 'new keyword1,newkeyword2', '2025-09-28 20:40:47', '2025-09-28 20:47:45'),
	(8, 30, 'BC1', 'edited meta description', 'new keyword1,newkeyword2', '2025-09-28 20:44:13', '2025-09-28 20:47:58'),
	(9, 26, 'BC1', 'edited meta description', 'new keyword1,newkeyword2', '2025-09-28 20:46:37', '2025-09-28 20:46:37'),
	(10, 27, 'BC1', 'edited meta description', 'new keyword1,newkeyword2', '2025-09-28 20:47:12', '2025-09-28 20:47:12'),
	(11, 31, 'BC1', 'edited meta description', 'new keyword1,newkeyword2', '2025-09-29 03:53:06', '2025-09-29 03:53:06'),
	(12, 49, 'Banks campaigns', 'At United Banking Group, every customer deserves more than a message — they deserve a conversation. Chickpea’s Personalized Video Platform transforms data into engaging, one-to-one experiences that drive trust, loyalty, and action.', 'bank, finance, loans, insurance', '2025-09-29 03:55:01', '2025-09-29 03:55:01');

-- Dumping structure for table laravel12_api.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.sessions: ~1 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('P4Qn6A0UorkqMf9fOHuk5rDgsBRqjxeRDieUeb8S', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZnJJZ2dqdTR5ZHZKZkxlSkdyalF0Tzd4MGtUVW1tcXN0cWd4SWJyayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759081135);

-- Dumping structure for table laravel12_api.students
CREATE TABLE IF NOT EXISTS `students` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.students: ~1 rows (approximately)
INSERT INTO `students` (`id`, `name`, `email`, `gender`, `created_at`, `updated_at`) VALUES
	(1, 'Peter', 'Peter@tomorrow.com', 'male', '2025-09-26 21:16:01', '2025-09-26 21:16:01');

-- Dumping structure for table laravel12_api.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','author','reader') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'reader',
  `profile_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel12_api.users: ~4 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `profile_picture`, `remember_token`, `created_at`, `updated_at`) VALUES
	(3, 'reader', 'reader@mail.com', NULL, '$2y$12$ibcneCmAIvEqJuJVqkxmGOCISHACAxnBjNRcI3O95A7lVHqgMJRjC', 'reader', 'storage/profile1758969158_testuserprofile.jpg', NULL, '2025-09-27 08:32:38', '2025-09-27 08:32:38'),
	(4, 'Author', 'author@mail.com', NULL, '$2y$12$oInfVVqQ1aPuY3lpbYaUaO9xesUl6ZYb80943TQdkK94pf4hXRN5i', 'author', 'storage/profile1758969351_testuserprofile.jpg', NULL, '2025-09-27 08:35:51', '2025-09-27 08:35:51'),
	(5, 'Admin', 'admin@mail.com', NULL, '$2y$12$cRJcHLinWuRrUiltNHKi3u1KoP6cAbW8/ggaHNAQfttvv/URRMqau', 'admin', 'storage/profile1758969388_testuserprofile.jpg', NULL, '2025-09-27 08:36:28', '2025-09-27 08:36:28'),
	(6, 'Peter', 'Smith@mail.com', NULL, '$2y$12$EeEv8YYJt0GbQH/cjKBDE.TJW8JAJBSxYKeR.LH5xLsLG5VeSWo1S', 'admin', NULL, NULL, '2025-09-28 19:17:18', '2025-09-28 19:17:18');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
