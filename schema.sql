-- loverimages表结构
CREATE TABLE `loverimages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `caption` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- softdata表结构
CREATE TABLE `softdata` (
  `s` int NOT NULL,
  `c` int DEFAULT NULL,
  `p` int DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `num` int DEFAULT NULL,
  `lg` varchar(255) DEFAULT NULL,
  `ver` varchar(50) DEFAULT NULL,
  `fs` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `star` int DEFAULT NULL,
  `ux` int DEFAULT NULL,
  `tx` int DEFAULT NULL,
  `fe` text,
  `detailUrl` varchar(255) DEFAULT NULL,
  `os_type` int DEFAULT NULL,
  `os_bit` int DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `nick_ver` varchar(50) DEFAULT NULL,
  `ver_name` varchar(50) DEFAULT NULL,
  `file_size` varchar(20) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `download_url` text,
  `download_https_url` text,
  `Logo48File` text,
  PRIMARY KEY (`s`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 注意：software_info和users表的结构未能获取
-- 可能是权限问题，建议手动查询或检查MySQL用户权限