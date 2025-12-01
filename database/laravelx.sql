-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2025-12-01 01:16:25
-- 服务器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `laravelx`
--
CREATE DATABASE IF NOT EXISTS `laravelx` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `laravelx`;

-- --------------------------------------------------------

--
-- 表的结构 `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `cache`
--

TRUNCATE TABLE `cache`;
--
-- 转存表中的数据 `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravelxdemo-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:3;', 1764548069),
('laravelxdemo-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1764548069;', 1764548069);

-- --------------------------------------------------------

--
-- 表的结构 `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `cache_locks`
--

TRUNCATE TABLE `cache_locks`;
-- --------------------------------------------------------

--
-- 表的结构 `failed_jobs`
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

--
-- 插入之前先把表清空（truncate） `failed_jobs`
--

TRUNCATE TABLE `failed_jobs`;
-- --------------------------------------------------------

--
-- 表的结构 `jobs`
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

--
-- 插入之前先把表清空（truncate） `jobs`
--

TRUNCATE TABLE `jobs`;
-- --------------------------------------------------------

--
-- 表的结构 `job_batches`
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

--
-- 插入之前先把表清空（truncate） `job_batches`
--

TRUNCATE TABLE `job_batches`;
-- --------------------------------------------------------

--
-- 表的结构 `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `migrations`
--

TRUNCATE TABLE `migrations`;
--
-- 转存表中的数据 `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_11_28_182847_create_personal_access_tokens_table', 2);

-- --------------------------------------------------------

--
-- 表的结构 `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `password_reset_tokens`
--

TRUNCATE TABLE `password_reset_tokens`;
-- --------------------------------------------------------

--
-- 表的结构 `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `personal_access_tokens`
--

TRUNCATE TABLE `personal_access_tokens`;
-- --------------------------------------------------------

--
-- 表的结构 `query`
--

CREATE TABLE `query` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `query_code` bigint(20) NOT NULL DEFAULT 0 COMMENT '唯一编码(雪花ID)',
  `sql` text NOT NULL COMMENT 'SQL语句',
  `exec_time` decimal(10,6) NOT NULL COMMENT '执行耗时',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作人ID',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '错误信息',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `query`
--

TRUNCATE TABLE `query`;
--
-- 转存表中的数据 `query`
--

INSERT INTO `query` (`id`, `query_code`, `sql`, `exec_time`, `user_id`, `error`, `created_at`, `updated_at`) VALUES
(1, 11111111111111, 'select * from query', 1.000000, 1, NULL, '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(2, 638793733428616211, 'select * from query', 0.000873, 1, '', '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(3, 638795392011605517, 'select * from query', 0.001073, 1, '', '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(4, 638795460714304767, 'select * from query', 0.000509, 1, '', '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(5, 638795477172752995, 'select * from query', 0.000498, 1, '', '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(6, 638795554981288002, 'select * from query', 0.000579, 1, '', '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(7, 638795579853512332, 'select * from query', 0.000959, 1, '', '2025-11-30 09:53:00', '2025-11-30 09:53:00'),
(8, 638797679832471171, 'select * from query', 0.000942, 1, '', '2025-11-30 09:53:55', '2025-11-30 09:53:55'),
(9, 638797732357742565, 'select * from query', 0.002286, 1, '', '2025-11-30 09:54:07', '2025-11-30 09:54:07'),
(10, 638799220282890381, 'select * from query1', 0.000000, 1, 'System Error: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'laravelx.query1\' doesn\'t exist', '2025-11-30 10:00:02', '2025-11-30 10:00:02'),
(11, 638799256576201204, 'select * from query', 0.000567, 1, '', '2025-11-30 10:00:11', '2025-11-30 10:00:11'),
(12, 638799315845913241, 'select * from users', 0.000000, 1, 'The following data table does not support access :users', '2025-11-30 10:00:25', '2025-11-30 10:00:25'),
(13, 638799330102350350, 'select * from user', 0.000000, 1, 'System Error: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'laravelx.user\' doesn\'t exist', '2025-11-30 10:00:28', '2025-11-30 10:00:28'),
(14, 638799356354502467, 'select * from query', 0.001077, 1, '', '2025-11-30 10:00:34', '2025-11-30 10:00:34'),
(15, 638799379720968196, 'select * from query', 0.000679, 1, '', '2025-11-30 10:00:40', '2025-11-30 10:00:40'),
(16, 638812426455879876, 'select * from query', 0.000550, 1, '', '2025-11-30 10:52:31', '2025-11-30 10:52:31'),
(17, 638812530923410095, 'select * from query', 0.000670, 1, '', '2025-11-30 10:52:55', '2025-11-30 10:52:55'),
(18, 638834986736293843, 'select * from query', 0.000668, 1, '', '2025-11-30 12:22:09', '2025-11-30 12:22:09'),
(19, 638835011117784423, 'select * from query', 0.000501, 1, '', '2025-11-30 12:22:15', '2025-11-30 12:22:15'),
(20, 638835033452452016, 'select * from query', 0.000578, 1, '', '2025-11-30 12:22:20', '2025-11-30 12:22:20'),
(21, 638835043015465384, 'select * from query', 0.001540, 1, '', '2025-11-30 12:22:23', '2025-11-30 12:22:23'),
(22, 638837683300470865, 'select * from querys', 0.000000, 1, 'System Error: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'laravelx.querys\' doesn\'t exist', '2025-11-30 12:32:52', '2025-11-30 12:32:52'),
(23, 638837701503753213, 'select * from query', 0.000924, 1, '', '2025-11-30 12:32:57', '2025-11-30 12:32:57'),
(24, 638837768381930942, 'select * from query', 0.001056, 1, '', '2025-11-30 12:33:13', '2025-11-30 12:33:13'),
(25, 638854274943688540, 'select * from query', 0.000947, 1, '', '2025-11-30 13:38:48', '2025-11-30 13:38:48'),
(26, 638856525863064162, 'select * from query', 0.000853, 1, '', '2025-11-30 13:47:45', '2025-11-30 13:47:45'),
(27, 638861016209432190, 'select * from  query', 0.000599, 1, '', '2025-11-30 14:05:35', '2025-11-30 14:05:35'),
(28, 639008712257835513, 'select * from roles', 0.000572, 1, '', '2025-11-30 23:52:29', '2025-11-30 23:52:29'),
(29, 639011484147522267, 'select * from roles', 0.000508, 1, '', '2025-12-01 00:03:30', '2025-12-01 00:03:30'),
(30, 639012633223237695, 'select * from role_user_relations', 0.000517, 1, '', '2025-12-01 00:08:04', '2025-12-01 00:08:04'),
(31, 639013708491788377, 'select * from query', 0.000579, 1, '', '2025-12-01 00:12:20', '2025-12-01 00:12:20'),
(32, 639013999354190750, 'select * from query', 0.008178, 1, '', '2025-12-01 00:13:29', '2025-12-01 00:13:29');

-- --------------------------------------------------------

--
-- 表的结构 `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '角色名称',
  `description` text NOT NULL COMMENT '角色描述',
  `route` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '可访问的路由列表' CHECK (json_valid(`route`)),
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '角色状态(1:启用；2：禁用)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `roles`
--

TRUNCATE TABLE `roles`;
--
-- 转存表中的数据 `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `route`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'manager', '[\"dev\",\"dev\\/queryList\",\"dev\\/queryExport\"]', 1, '2025-11-28 03:09:26', '2025-11-28 03:09:26'),
(2, 'user', 'user', '[\"user\\/index\"]', 1, '2025-11-28 03:09:26', '2025-11-28 03:09:26');

-- --------------------------------------------------------

--
-- 表的结构 `role_user_relations`
--

CREATE TABLE `role_user_relations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID(users.id)',
  `role_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID(roles.id)',
  `created_user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建人用户ID(users.id)',
  `created_user_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '创建人用户名(users.name)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 插入之前先把表清空（truncate） `role_user_relations`
--

TRUNCATE TABLE `role_user_relations`;
--
-- 转存表中的数据 `role_user_relations`
--

INSERT INTO `role_user_relations` (`id`, `user_id`, `role_id`, `created_user_id`, `created_user_name`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'admin1', '2025-11-28 03:09:21', '2025-11-28 03:09:21'),
(2, 1, 2, 1, 'admin1', '2025-11-28 03:09:21', '2025-11-28 03:09:21'),
(3, 4, 2, 1, 'admin1', '2025-11-28 03:09:21', '2025-11-28 03:09:21');

-- --------------------------------------------------------

--
-- 表的结构 `sessions`
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
-- 插入之前先把表清空（truncate） `sessions`
--

TRUNCATE TABLE `sessions`;
--
-- 转存表中的数据 `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('7u8cfx3jMUtFv1Pw6syGi6nXtxsuXnEZakChIDoN', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiYmNDOWw2WDhkdUtXSWlVR0NZaXFCRmRHM0NQNHZHWFdpQU5VemQwUSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI1OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvZGV2IjtzOjU6InJvdXRlIjtzOjM6ImRldiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1764548039);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '用户状态(1:正常；2:停用；3：禁用)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 插入之前先把表清空（truncate） `users`
--

TRUNCATE TABLE `users`;
--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin1', 'admin1@example.com', NULL, '$2y$12$jspv3u7X6IAKrKapVFw0nuexr6MIgbvtW80CGTES/DWyTkmIT9A5y', NULL, 1, '2025-11-28 03:09:07', '2025-11-28 03:09:07'),
(2, 'admin2', 'admin2@example.com', NULL, '$2y$12$1iwZMt8ukGzP18ObZgJCpO.ZUsyJ6pF0Zsl.pJFHXa21QIIKTglUW', NULL, 2, '2025-11-28 03:09:07', '2025-11-28 03:09:07'),
(3, 'admin3', 'admin3@example.com', NULL, '$2y$12$.aaF89/1kdB4V9ewPTD57OJ.lsRGSAw.8CbATABxIyvVcGS1LcYtS', NULL, 3, '2025-11-28 03:09:07', '2025-11-28 03:09:07'),
(4, 'user1', 'user1@example.com', NULL, '$2y$12$0k39tN7kox3vvMqZaYe6IuGUAJfMBbbutg6qrjTnQs/aqINVRlnEC', NULL, 1, '2025-11-28 03:09:08', '2025-11-28 03:09:08'),
(5, 'user2', 'user2@example.com', NULL, '$2y$12$t3ieRb7uu.q38J4WwZDHHOkPPhtTUQZ4hIeR31TpiFM1h1fQQ0Doa', NULL, 2, '2025-11-28 03:09:08', '2025-11-28 03:09:08'),
(6, 'user3', 'user3@example.com', NULL, '$2y$12$tq2VdZxdHQ3kVVujP4FuCO3Km8IcAcGDsyS0f6TeazmjCShAv7HNy', NULL, 3, '2025-11-28 03:09:08', '2025-11-28 03:09:08'),
(7, 'admin12', 'admin12@example.com', NULL, '$2y$12$Pb5/gAToblXtdrD26B5SUuYKWBQN0HT4BFlreWid8zw/etbjYAtTO', NULL, 1, '2025-11-29 01:41:33', '2025-11-29 01:41:33');

--
-- 转储表的索引
--

--
-- 表的索引 `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- 表的索引 `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- 表的索引 `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- 表的索引 `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- 表的索引 `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- 表的索引 `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- 表的索引 `query`
--
ALTER TABLE `query`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_query_code` (`query_code`),
  ADD KEY `user_id` (`user_id`);

--
-- 表的索引 `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `role_user_relations`
--
ALTER TABLE `role_user_relations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_role_id` (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- 表的索引 `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `query`
--
ALTER TABLE `query`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- 使用表AUTO_INCREMENT `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `role_user_relations`
--
ALTER TABLE `role_user_relations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
