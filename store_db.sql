-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2025 at 02:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `store_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `answerable_id` int(11) NOT NULL,
  `answerable_type` varchar(255) NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL,
  `text` varchar(255) NOT NULL,
  `active_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`id`, `user_id`, `answerable_id`, `answerable_type`, `comment_id`, `text`, `active_at`, `created_at`, `updated_at`) VALUES
(6, 2, 6, 'App\\Models\\Comment', 6, 'خوشحالم که خوشتون اومده', '2025-03-13 06:52:05', '2025-03-14 06:48:05', '2025-03-14 06:48:05'),
(7, 2, 15, 'App\\Models\\Comment', 15, 'مرسیییی', '2025-03-14 07:17:44', '2025-03-14 07:13:44', '2025-03-14 07:13:44'),
(8, 2, 8, 'App\\Models\\Comment', 8, 'ثیثی', '2025-03-14 07:20:10', '2025-03-14 07:16:11', '2025-03-14 07:16:11'),
(9, 2, 7, 'App\\Models\\Answer', 15, 'قربانتتتت', '2025-03-14 07:20:02', '2025-03-14 07:18:02', '2025-03-14 07:18:02');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'اپل', NULL, NULL),
(2, 'سامسونگ', NULL, NULL),
(4, 'شیائومی', NULL, NULL),
(5, 'اچ پی', NULL, NULL),
(6, 'لنوو', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel_cache_authentication-code-09144831183', 'i:99035;', 1742303179),
('laravel_cache_authentication-register-09144831183', 'b:1;', 2057663036);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `productType_id` bigint(20) UNSIGNED NOT NULL,
  `count` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'موبایل', NULL, NULL),
(2, 'لپ تاپ', NULL, NULL),
(5, 'ساعت هوشمند', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `commentable_id` int(11) NOT NULL,
  `commentable_type` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `score` varchar(255) NOT NULL,
  `active_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `commentable_id`, `commentable_type`, `text`, `score`, `active_at`, `created_at`, `updated_at`) VALUES
(6, 2, 10, 'App\\Models\\Product', 'بسیار محصول خفنی بود<br />\nاپل بهترینهههه', 'پیشنهاد می کنم', '2025-03-13 06:50:43', '2025-03-14 06:46:43', '2025-03-14 06:46:43'),
(7, 2, 10, 'App\\Models\\Product', 'یکم ایراد داره<br />\nولی در کل خوبه', 'مطمئن نیستم', '2025-03-13 06:51:05', '2025-03-14 06:47:05', '2025-03-14 06:47:05'),
(8, 2, 10, 'App\\Models\\Product', 'افتضاحححححححح', 'پیشنهاد نمی کنم', '2025-03-13 06:51:13', '2025-03-14 06:47:13', '2025-03-14 06:47:13'),
(15, 2, 9, 'App\\Models\\Product', 'من که عاشق رنگش شدممم', 'پیشنهاد می کنم', '2025-03-14 07:13:22', '2025-03-14 07:13:22', '2025-03-14 07:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `product_id`, `created_at`, `updated_at`) VALUES
(240, 2, 16, '2025-03-18 05:53:49', '2025-03-18 05:53:49'),
(242, 2, 10, '2025-03-18 05:53:50', '2025-03-18 05:53:50');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_05_085513_create_personal_access_tokens_table', 1),
(5, '2025_03_08_072559_create_categories_table', 1),
(6, '2025_03_08_072609_create_brands_table', 1),
(7, '2025_03_08_072916_create_products_table', 1),
(8, '2025_03_08_073650_create_product_types_table', 1),
(9, '2025_03_08_074008_create_likes_table', 1),
(10, '2025_03_08_074102_create_product_properties_table', 1),
(11, '2025_03_08_074427_create_comments_table', 1),
(12, '2025_03_08_074435_create_answers_table', 1),
(13, '2025_03_12_065754_create_product_type_galleries_table', 2),
(15, '2025_03_12_093120_create_carts_table', 3),
(16, '2025_03_14_083134_create_comments_table', 4),
(17, '2025_03_14_083216_create_answers_table', 4),
(22, '2025_03_15_092626_create_orders_table', 5),
(23, '2025_03_15_092637_create_order_products_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `driver` varchar(255) NOT NULL,
  `status` enum('پرداخت نشده','پرداخت شده') NOT NULL DEFAULT 'پرداخت نشده',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `full_name`, `phone`, `code`, `transaction_id`, `driver`, `status`, `created_at`, `updated_at`) VALUES
(16, 2, 'مهران امان الله', '09144831183', '412624', '4414ee33-dae0-4aa9-abcc-32efa8819e82', 'شپا', 'پرداخت نشده', '2025-03-17 07:35:39', '2025-03-17 07:35:39'),
(17, 2, 'مهران امان الله', '09144831183', '215454545787', 'e6547a68-1ee6-487a-9b54-e45eb1f2dd15', 'شپا', 'پرداخت شده', '2025-03-17 07:37:46', '2025-03-17 07:37:49'),
(18, 2, 'مهران امان الله', '09144831184', '215454545787', '3b0193f6-782d-4e09-81e5-22ea5fed91b2', 'شپا', 'پرداخت شده', '2025-03-18 10:15:44', '2025-03-18 10:15:48');

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `productType_id` bigint(20) UNSIGNED NOT NULL,
  `discount` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `payment` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_products`
--

INSERT INTO `order_products` (`id`, `order_id`, `productType_id`, `discount`, `price`, `payment`, `count`, `created_at`, `updated_at`) VALUES
(24, 16, 5, 15, 56000000, 47600000, 1, '2025-03-17 07:35:39', '2025-03-18 05:52:33'),
(25, 17, 5, 15, 56000000, 47600000, 2, '2025-03-17 07:37:46', '2025-03-17 07:37:46'),
(26, 18, 1, 25, 70000000, 52500000, 1, '2025-03-18 10:15:44', '2025-03-18 10:15:44'),
(27, 18, 28, 20, 60000000, 54500000, 1, '2025-03-18 10:15:44', '2025-03-18 10:15:44'),
(28, 18, 8, NULL, NULL, 69000000, 1, '2025-03-18 10:15:44', '2025-03-18 10:15:44');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(17, 'App\\Models\\User', 1, '09144831183', '1daa0c4b98ffc53c543648e6fcfa50725ef83278d1f7f191fdd7aabff7e3ead7', '[\"*\"]', '2025-03-14 06:29:10', '2025-05-13 17:34:27', '2025-03-13 17:34:27', '2025-03-14 06:29:10'),
(18, 'App\\Models\\User', 1, '09144831183', '1b1971a4b7f95fce081d2d5243b97f8aa0b77568d10c3e15486edc241ae042b0', '[\"*\"]', '2025-03-14 06:19:04', '2025-05-14 05:07:42', '2025-03-14 05:07:42', '2025-03-14 06:19:04'),
(25, 'App\\Models\\User', 2, '09144831183', '1115ec43e5b9115b23f042db4c5987a785b5e99e963782862fca4bab64f249bc', '[\"*\"]', '2025-03-16 07:00:10', '2025-05-16 04:25:18', '2025-03-16 04:25:18', '2025-03-16 07:00:10'),
(26, 'App\\Models\\User', 2, '09144831183', '02bbe42242d2b810790686dca4e33ec82b08d9872413121e2ed8410b29841920', '[\"*\"]', '2025-03-16 06:40:23', '2025-05-16 04:59:29', '2025-03-16 04:59:29', '2025-03-16 06:40:23'),
(28, 'App\\Models\\User', 2, '09144831183', '3958a73543dd7c508c858c32fa46df987d0e2bcea7ce1d84eb3fa37bdf58e6f3', '[\"*\"]', '2025-03-17 07:16:44', '2025-05-17 05:29:39', '2025-03-17 05:29:39', '2025-03-17 07:16:44'),
(30, 'App\\Models\\User', 2, '09144831183', '7d1e3f0250ef9cea4e6cdfe0daf5e15d933c17a3597c780925eb694e27d2b98f', '[\"*\"]', '2025-03-18 09:06:20', '2025-05-18 08:35:38', '2025-03-18 08:35:38', '2025-03-18 09:06:20'),
(31, 'App\\Models\\User', 2, '09144831183', '3427be743417f630fb84874103d642ddc9facab425d7d9f17efad04278517152', '[\"*\"]', '2025-03-18 08:55:11', '2025-05-18 08:53:59', '2025-03-18 08:53:59', '2025-03-18 08:55:11'),
(32, 'App\\Models\\User', 2, '09144831183', '310a14d3afc89998e410ba8c3b229561ea482449cf39bc2fa1c74533ab146948', '[\"*\"]', '2025-03-18 10:25:30', '2025-05-18 09:34:30', '2025-03-18 09:34:30', '2025-03-18 10:25:30');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `brand_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `brand_id`, `title`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'گوشی موبایل اپل مدل iPhone 16 Pro Max ZAA دو سیم کارت ظرفیت 1 ترابایت و رم 8 گیگابایت', '2025-03-08 09:15:36', NULL),
(2, 1, 1, 'گوشی موبایل اپل مدل iPhone 13 Pro Max ZAA دو سیم‌ کارت ظرفیت 128 گیگابایت و رم 6 گیگابایت - نات اکتیو پارت نامبر F', '2025-03-08 09:15:34', NULL),
(3, 1, 1, 'گوشی موبایل اپل مدل iPhone 16 CH دو سیم کارت ظرفیت 128 گیگابایت و رم 8 گیگابایت', '2025-03-08 09:15:40', NULL),
(4, 1, 1, 'گوشی آیفون 15 پرو مکس حافظه 256 گیگابایت', '2025-03-08 09:15:30', NULL),
(5, 1, 2, 'گوشی موبایل سامسونگ مدل Galaxy A35 دو سیم کارت ظرفیت 128 گیگابایت رم 8 گیگابایت', '2025-03-08 09:15:42', NULL),
(6, 1, 2, 'گوشی موبایل سامسونگ مدل Galaxy A05s دو سیم کارت ظرفیت 128 گیگابایت و رم 4 گیگابایت', '2025-03-08 09:15:25', NULL),
(7, 1, 4, 'گوشی موبایل شیائومی مدل Redmi Note 13 Pro Plus 5G دو سیم کارت ظرفیت 512 گیگابایت و رم 12 گیگابایت', '2025-03-08 09:15:22', NULL),
(8, 2, 1, 'لپ تاپ 15.3 اینچی اپل مدل MacBook Air MXD33 2024 LLA-M3-16GB RAM-512GB SSD', '2025-03-08 09:32:06', NULL),
(9, 2, 1, 'لپ تاپ 16.2 اینچی اپل مدل MacBook Pro MX2X3 2024 LLA-M4 Pro-24GB RAM-512GB SSD', '2025-03-08 09:32:20', NULL),
(10, 2, 1, 'لپ تاپ 15.3 اینچی اپل مدل MacBook Air MXD13 2024 LLA-M3-16GB RAM-512GB SSD', '2025-03-08 09:35:20', NULL),
(11, 2, 1, 'لپ تاپ 15.3 اینچی اپل مدل MacBook Air MXD23 2024 LLA-M3-16GB RAM-512GB SSD', '2025-03-08 09:40:16', NULL),
(12, 2, 6, 'لپ تاپ 15.6 اینچی لنوو مدل V15 G4 AMN-Athlon Silver 7120U-8GB LPDDR5-256GB SSD-TN', '2025-03-08 09:46:38', NULL),
(13, 2, 5, 'لپ تاپ 16.1 اینچی اچ‌ پی مدل Victus 16-R0073CL-i7 13700HX 32GB 1SSD RTX4060', '2025-03-08 09:52:29', NULL),
(14, 5, 1, 'ساعت هوشمند اپل واچ مدل 38mm Stainless Steel Case with Black Modern Buckle', '2025-03-07 10:04:14', NULL),
(15, 5, 1, 'ساعت هوشمند اپل واچ سری 4 سلولار مدل 40mm Stainless Steel Case with Stone Sport Silicon Band', '2025-03-07 10:07:30', NULL),
(16, 1, 1, 'گوشی موبایل اپل مدل iPhone XS Max دو سیم‌ کارت ظرفیت 256 گیگابایت', '2025-03-08 10:25:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_properties`
--

CREATE TABLE `product_properties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_properties`
--

INSERT INTO `product_properties` (`id`, `product_id`, `title`, `created_at`, `updated_at`) VALUES
(1, 1, 'پرچم‌دار', NULL, NULL),
(2, 1, 'دوربین 48 مگاپیکسلی', NULL, NULL),
(3, 1, '8 گیگ رم', NULL, NULL),
(4, 1, '1 ترابایت', NULL, NULL),
(5, 2, '6 گیگ رم', NULL, NULL),
(6, 2, '128 گیگ فضای ذخیره سازی', NULL, NULL),
(7, 2, 'دو سیم کارته', NULL, NULL),
(8, 3, '8 گیگ رم', NULL, NULL),
(9, 3, '128 گیگ فضای ذخیره سازی', NULL, NULL),
(10, 3, 'دو سیم کارته', NULL, NULL),
(11, 4, '256 گیگ حافظه', NULL, NULL),
(12, 4, '8 گیگ رم', NULL, NULL),
(13, 5, '128 گیگ حافظه', NULL, NULL),
(14, 5, '8 گیگ رم', NULL, NULL),
(15, 6, '4 گیگ رم', NULL, NULL),
(16, 6, '128 گیگ حافظه', NULL, NULL),
(17, 7, '512 گیگ حافظه', NULL, NULL),
(18, 7, '12 گیگ رم', NULL, NULL),
(19, 7, 'دو سیم کارته', NULL, NULL),
(20, 8, '16 گیگ رم', NULL, NULL),
(21, 8, '512 SSD حافظه', NULL, NULL),
(22, 8, 'پردازنده M3', NULL, NULL),
(23, 8, 'صفحه نمایش 2880x1864 پیکسل', NULL, NULL),
(24, 9, 'پردازنده M4', NULL, NULL),
(25, 9, '24 گیگ رم', NULL, NULL),
(26, 9, '512 گیگ حاقظه SSD', NULL, NULL),
(27, 9, 'صفحه نمایش 3456x2234 پیکسل', NULL, NULL),
(28, 10, 'پردازنده M3', NULL, NULL),
(29, 10, '16 گیگ رم', NULL, NULL),
(30, 10, '512 گیگ حافظه', NULL, NULL),
(31, 11, 'پردازنده M3', NULL, NULL),
(32, 11, '512 گیگ حافظه', NULL, NULL),
(33, 11, '16 گیگ رم', NULL, NULL),
(34, 12, 'سری پردازنده ATHLON', NULL, NULL),
(35, 12, '8 گیگ رم', NULL, NULL),
(36, 12, '256 گیگ حافظه', NULL, NULL),
(37, 12, 'گرافیک Radeon 610M', NULL, NULL),
(39, 13, 'سری پردازنده Core i7', NULL, NULL),
(40, 13, '32 گیگ رم', NULL, NULL),
(41, 13, '1 ترابایت حافظه', NULL, NULL),
(42, 13, 'NVIDIA GeForce RTX 4060', NULL, NULL),
(43, 14, 'روزمره، ورزشی', NULL, NULL),
(44, 14, 'مناسب برای بانوان', NULL, NULL),
(45, 14, 'رزولوشن صفحه نمایش ۲۷۲x۳۴۰ ', NULL, NULL),
(46, 15, 'ورزشی، رسمی، روزمره', NULL, NULL),
(47, 15, 'جنس بند سیلیکون', NULL, NULL),
(48, 16, '256 گیگ حافظه', NULL, NULL),
(49, 16, '4 گیگ رم', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE `product_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `color_code` varchar(255) NOT NULL,
  `color_title` varchar(255) NOT NULL,
  `discount` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `payment` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_types`
--

INSERT INTO `product_types` (`id`, `product_id`, `image`, `color_code`, `color_title`, `discount`, `price`, `payment`, `count`, `created_at`, `updated_at`) VALUES
(1, 1, '/images/673beeacd35379a3944551e2ca51389730d7703d_1736598864.webp', '#333', 'تیتانیوم مشکی', 25, 70000000, 52500000, 19, NULL, '2025-03-18 10:15:48'),
(2, 1, '/images/ecddd0557a29c361ec03563931394125578f4128_1736598673.webp', '#cbbbad', 'تیتانیوم صحرایی', 20, 71500000, 57200000, 24, NULL, '2025-03-17 07:34:45'),
(5, 2, '/images/dcd6e4e843bea3f070614a95d27b1181fdf23008_1727276123.webp', '#c99212', 'طلایی', 15, 56000000, 47600000, 10, NULL, '2025-03-17 07:37:49'),
(6, 3, '/images/5af568b4909435c6a215ad5e728e902db234b673_1736597759.webp', '#2196f3', 'آبی', 13, 79200000, 68784000, 14, NULL, NULL),
(7, 3, '/images/atrinkala-apple-iphone-16-128-black_2.jpg', '#000', 'مشکی', NULL, NULL, 69200000, 25, NULL, NULL),
(8, 3, '/images/atrinkala-apple-iphone-16-128-green_2.jpg', '#a1c9c9', 'سبز', NULL, NULL, 69000000, 29, NULL, '2025-03-18 10:15:48'),
(9, 4, '/images/atrinkala-iphone-15-pro-max-256gb-white.jpg', '#fff', 'سفید', 12, 48500000, 42680000, 20, NULL, NULL),
(10, 4, '/images/atrinkala-iphone-15-pro-max-256gb-titanium.jpg', '#b5b5b5', 'تیتانیوم', 10, 48700000, 43830000, 20, NULL, NULL),
(11, 5, '/images/color_image_TLP-31018_3479bf_18ea70be-b6a0-44b7-bd03-7e70961774eb.webp', '#3479bf', 'آبی', 10, 18560000, 16704000, 25, NULL, NULL),
(12, 5, '/images/samsung-galaxy-a35-8GB-256GB-awesome-navy.jpg', '#00009c', 'سرمه ای', 13, 18160000, 15803000, 11, NULL, NULL),
(13, 6, '/images/Screenshot-2024-04-25-133240.png', '#dfebbd', 'سبز', NULL, NULL, 32000000, 25, NULL, NULL),
(14, 7, '/images/8bcbe8c1a392d66add16bf9adf4e58f1066d4df1_1706095042.webp', '#000', 'مشکی', 22, 29000000, 25980000, 17, NULL, NULL),
(15, 7, '/images/Redmi-Note-13-Pro-plus-White.jpg', '#fff', 'سفید', 20, 29200000, 26250000, 20, NULL, NULL),
(16, 8, '/images/e75d69cc408ea9d99fee43cd8e3229fa6e57f06a_1723653904.webp', '#e6dab3', 'طلایی', 20, 117000000, 98600000, 17, NULL, '2025-03-17 07:23:31'),
(17, 9, '/images/52911bcdb01c4122759b430697732b2bf538c784_1731165214.webp', '#000', 'مشکی', 12, 150000000, 143500000, 19, NULL, '2025-03-17 07:08:30'),
(18, 10, '/images/f947a1158081a83438a8f6d7d53ecbdd69f72a37_1723644625.webp', '#9e9e9e', 'خاکستری', 10, 116000000, 113680000, 17, NULL, '2025-03-17 03:55:06'),
(19, 10, '/images/b872d69721bf570c6c99278a890b6c82c87687db_1733937234.webp', '#002171', 'سرمه ای', 11, 115900000, 114899000, 21, NULL, '2025-03-17 07:18:03'),
(20, 11, '/images/5c2368648b37a98c33c513316c71f79436db6a5a_1723654426.webp', 'rgb(222, 222, 222)', 'نقره ای', NULL, NULL, 100000000, 23, NULL, '2025-03-17 07:23:31'),
(21, 12, '/images/f9d556a68cc4a507cc80981935cf68ae2e3d7711_1690028248.webp', '#000', 'مشکی', 12, 55000000, 53980000, 29, NULL, '2025-03-17 03:55:06'),
(22, 13, '/images/a44eeef495ef317c6c7c3aa8d1220d78ba308cd6_1703448223.webp', '#e0e0e0', 'خاکستری', NULL, NULL, 120000000, 39, NULL, '2025-03-17 03:55:06'),
(23, 14, '/images/876148.webp', '#000', 'مشکی', 10, 6900000, 5550000, 30, NULL, NULL),
(24, 14, '/images/1ed7524074e83cdb665d4e9619e5a8ff32b133b0_1701161232.webp', '#e6dab3', 'طلایی', 12, 6900000, 5880000, 32, NULL, NULL),
(25, 15, '/images/1ed7524074e83cdb665d4e9619e5a8ff32b133b0_1701161232.webp', '#fff', 'سفید', NULL, NULL, 9600000, 25, NULL, NULL),
(28, 16, '/images/80aedbf89779340a46c5974916222cf9dd7309c9_1656406751.webp', '#fee0ca', 'طلایی', 20, 60000000, 54500000, 25, NULL, '2025-03-18 10:15:48');

-- --------------------------------------------------------

--
-- Table structure for table `product_type_galleries`
--

CREATE TABLE `product_type_galleries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `productType_id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_type_galleries`
--

INSERT INTO `product_type_galleries` (`id`, `productType_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, '/images/gallery/a5a8557e2ad13191c8b9c01373b2ad7f90290f57_1736598864.webp', NULL, NULL),
(2, 2, '/images/gallery/2-smart_crop-c0-5__0-5-1500x1500-70-600x600.jpg', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0orfCNnXWl3dV7KvPFqt0aSNdc9Qx97UkflgMYoJ', NULL, '127.0.0.1', 'PostmanRuntime/7.43.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibGVhMlloMmF0M3lnbUZ6b0NqQUdvVTY2WVh3aGJqMmxiQ25NM1VSTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742201959),
('FSJIFoOUWFeb5KbS7ZYw6pPOef1eXuZXXpJAu46C', NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFZ4NnNLZFhMZExqN0gza3M4RE9MNHBDbjFhSDdBcjBhcGtiNDZmciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTAzOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvdmVyaWZ5P2Ftb3VudD0xNzYwMDAwMDAmc3RhdHVzPXN1Y2Nlc3MmdG9rZW49M2IwMTkzZjYtNzgyZC00ZTA5LTgxZTUtMjJlYTVmZWQ5MWIyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742305550),
('jOLiIPPLbi34k8vfKD8ccPK3jFJ1wRHtv29mvkTe', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibTdiMjVRTmRWRUFLY085eFBpRGliNEZ5RnpBUW15S0IxQjdMZjhJMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTAyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvdmVyaWZ5P2Ftb3VudD05NTIwMDAwMCZzdGF0dXM9c3VjY2VzcyZ0b2tlbj1lNjU0N2E2OC0xZWU2LTQ4N2EtOWI1NC1lNDVlYjFmMmRkMTUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1742209670),
('mG0dMpkPtAcHehffexNpI7YLSeL9SWJYtcpqq0sQ', NULL, '127.0.0.1', 'PostmanRuntime/7.43.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGM0S01xdDlwNGtQc2hjMW9idWIwTnBQa1J0Q0xKa3phallUaVRyMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742300349);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `phone`, `password`, `is_admin`, `created_at`, `updated_at`) VALUES
(2, 'مهران', 'امان الله', '09144831183', '$2y$12$WhCZnPH8oyztUT0ZsLRNqOXNJqRzCmLMfnfIfiE7IIQ3jak68ZnJK', 0, '2025-03-14 06:32:57', '2025-03-18 10:22:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `answers_user_id_foreign` (`user_id`),
  ADD KEY `answers_comment_id_foreign` (`comment_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_user_id_foreign` (`user_id`),
  ADD KEY `carts_producttype_id_foreign` (`productType_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`),
  ADD KEY `likes_product_id_foreign` (`product_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_products_order_id_foreign` (`order_id`),
  ADD KEY `order_products_producttype_id_foreign` (`productType_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `product_properties`
--
ALTER TABLE `product_properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_properties_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_types_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_type_galleries`
--
ALTER TABLE `product_type_galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_type_galleries_producttype_id_foreign` (`productType_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `product_properties`
--
ALTER TABLE `product_properties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `product_type_galleries`
--
ALTER TABLE `product_type_galleries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_producttype_id_foreign` FOREIGN KEY (`productType_id`) REFERENCES `product_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_products_producttype_id_foreign` FOREIGN KEY (`productType_id`) REFERENCES `product_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_properties`
--
ALTER TABLE `product_properties`
  ADD CONSTRAINT `product_properties_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_types`
--
ALTER TABLE `product_types`
  ADD CONSTRAINT `product_types_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_type_galleries`
--
ALTER TABLE `product_type_galleries`
  ADD CONSTRAINT `product_type_galleries_producttype_id_foreign` FOREIGN KEY (`productType_id`) REFERENCES `product_types` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
