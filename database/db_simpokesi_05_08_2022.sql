/*
 Navicat Premium Data Transfer

 Source Server         : MYSQL LOCAL ALL
 Source Server Type    : MySQL
 Source Server Version : 100315
 Source Host           : localhost:3306
 Source Schema         : db_simpokesi_07_2022

 Target Server Type    : MySQL
 Target Server Version : 100315
 File Encoding         : 65001

 Date: 05/08/2022 06:20:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accesses
-- ----------------------------
DROP TABLE IF EXISTS `accesses`;
CREATE TABLE `accesses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `access_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of accesses
-- ----------------------------
INSERT INTO `accesses` VALUES (1, 'ACCESS_HOTEL', 'Hak Akses Potensi Pajak Hotel');
INSERT INTO `accesses` VALUES (2, 'ACCESS_RESTORAN', 'Hak Akses Potensi Pajak Restoran');
INSERT INTO `accesses` VALUES (3, 'ACCESS_KOSTAN', 'Hak Akses Potensi Pajak Kostan');
INSERT INTO `accesses` VALUES (4, 'ACCESS_RUSUN', 'Hak Akses Potensi Pajak Rusun');
INSERT INTO `accesses` VALUES (9, 'ACCESS_REKLAME', 'Hak Akses Potensi Pajak Reklame');
INSERT INTO `accesses` VALUES (10, 'ACCESS_HIBURAN', 'Hak Akses Potensi Pajak Hiburan');
INSERT INTO `accesses` VALUES (11, 'ACCESS_PARKIR', 'Hak Akses Potensi Pajak Hiburan');

-- ----------------------------
-- Table structure for hiburan_jenis_ruangans
-- ----------------------------
DROP TABLE IF EXISTS `hiburan_jenis_ruangans`;
CREATE TABLE `hiburan_jenis_ruangans`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_id` bigint NULL DEFAULT NULL,
  `hiburan_jenis_ruangan_deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_ruangan_tarif` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_ruangan_jumlah` int NULL DEFAULT 0,
  `hiburan_jenis_ruangan_kapasitas` int NULL DEFAULT 0,
  `hiburan_jenis_ruangan_jam_weekdays` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_ruangan_jam_weekends` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_ruangan_avg_weekends` int NULL DEFAULT 0,
  `hiburan_jenis_ruangan_avg_weekdays` int NULL DEFAULT 0,
  `hiburan_jenis_ruangan_potensi_pajak` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hiburan_jenis_ruangans
-- ----------------------------
INSERT INTO `hiburan_jenis_ruangans` VALUES (1, 7, 'Large', '100000', 5, 10, '10:00 - 17:00', '10:00 - 18:00', 10, 4, 122640000);
INSERT INTO `hiburan_jenis_ruangans` VALUES (2, 7, 'Medium', '80000', 10, 4, '10:00 - 17:00', '10:00 - 14:00', 12, 2, 98112000);
INSERT INTO `hiburan_jenis_ruangans` VALUES (3, 7, 'Small', '50000', 15, 6, '10:00 - 16:00', '10:00 - 17:00', 10, 2, 52560000);
INSERT INTO `hiburan_jenis_ruangans` VALUES (4, 8, 'VIP', '120000', 5, 0, NULL, NULL, 10, 4, 1445400000);
INSERT INTO `hiburan_jenis_ruangans` VALUES (5, 8, 'Suite', '150000', 15, 0, NULL, NULL, 10, 2, 4434750000);
INSERT INTO `hiburan_jenis_ruangans` VALUES (6, 8, 'Standard', '100000', 10, 0, NULL, NULL, 12, 2, 2080500000);

-- ----------------------------
-- Table structure for hiburan_jenises
-- ----------------------------
DROP TABLE IF EXISTS `hiburan_jenises`;
CREATE TABLE `hiburan_jenises`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_jenis_deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_persentase` double(8, 2) NULL DEFAULT 10,
  `hiburan_jenis_have_ruangan` tinyint(1) NULL DEFAULT 0,
  `hiburan_jenis_have_multiple_tarif` tinyint(1) NULL DEFAULT 0,
  `hiburan_jenis_slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_jumlah_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_jumlah_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_kapasitas_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'Kapasitas Kursi',
  `hiburan_jenis_kapasitas_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'Kursi',
  `hiburan_jenis_htm_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_htm_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'smile',
  `hiburan_jenis_durasi_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jenis_durasi_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hiburan_jenises
-- ----------------------------
INSERT INTO `hiburan_jenises` VALUES (1, 'Bioskop', 10.00, 0, 0, 'bioskop', 'Studio', 'Unit', 'Kapasitas Kursi Keseluruhan', 'Kursi', 'HTM', 'Tiket', 'film', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (2, 'Diskotik, Klub, PUB, dll.', 40.00, 0, 0, 'diskotik', NULL, NULL, 'Kapasitas Pengunjung', 'Orang', 'HTM', 'Tiket', 'moon-o', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (3, 'Pacuan Kuda, ATV, Race, dll.', 10.00, 0, 0, 'pacuan_kuda_motor', NULL, NULL, 'Kapasitas Kursi Keseluruhan', 'Kursi', 'HTM', 'Tiket', 'flag-checkered', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (4, 'Permainan Anak', 10.00, 0, 1, 'permainan_anak', NULL, NULL, 'Kapasitas Pengunjung', 'Orang', 'HTM', 'Tiket', 'gamepad', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (5, 'Wahana Ketangkasan', 25.00, 0, 0, 'wahana_ketangkasan', 'Alat yang digunakan dalam sekali kunjungan', 'Unit', 'Alat Permainan', 'Unit', 'Harga Rata - Rata Sewa Alat', 'Unit', 'gamepad', 'Rata - Rata Lama Bermain', 'Jam');
INSERT INTO `hiburan_jenises` VALUES (6, 'Karaoke', 30.00, 1, 0, 'karaoke', NULL, NULL, 'Kapasitas Pengunjung', 'Orang', 'HTM', 'Jam', 'microphone', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (7, 'Panti Pijat', 10.00, 1, 0, 'panti_pijat', NULL, NULL, NULL, NULL, 'HTM', 'Kunjungan', 'user', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (8, 'Fitness', 25.00, 0, 0, 'fitness', NULL, NULL, 'Kapasitas Pengunjung', 'Orang', 'HTM', 'Kunjungan', 'smile', NULL, NULL);
INSERT INTO `hiburan_jenises` VALUES (9, 'Billiard', 10.00, 0, 0, 'billiard', 'Meja Billiard', 'Unit', 'Kapasitas Pengunjung', 'Orang', 'HTM', 'Kunjungan', 'dot-circle-o', NULL, NULL);

-- ----------------------------
-- Table structure for hiburan_kategoris
-- ----------------------------
DROP TABLE IF EXISTS `hiburan_kategoris`;
CREATE TABLE `hiburan_kategoris`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_jenis_id` int NULL DEFAULT NULL,
  `hiburan_kategori_deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_kategori_persentase` double(8, 2) NULL DEFAULT 10,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hiburan_kategoris
-- ----------------------------
INSERT INTO `hiburan_kategoris` VALUES (1, 2, 'DISKOTIK', NULL);
INSERT INTO `hiburan_kategoris` VALUES (2, 2, 'KLUB', NULL);
INSERT INTO `hiburan_kategoris` VALUES (3, 2, 'PUB', NULL);
INSERT INTO `hiburan_kategoris` VALUES (4, 2, 'LAINNYA', NULL);
INSERT INTO `hiburan_kategoris` VALUES (5, 3, 'PACUAN KUDA', NULL);
INSERT INTO `hiburan_kategoris` VALUES (6, 3, 'ATV', NULL);
INSERT INTO `hiburan_kategoris` VALUES (7, 3, 'RACE', NULL);
INSERT INTO `hiburan_kategoris` VALUES (8, 3, 'LAINNYA', NULL);
INSERT INTO `hiburan_kategoris` VALUES (9, 4, 'PERMAINAN DEWASA', 25.00);
INSERT INTO `hiburan_kategoris` VALUES (10, 4, 'PERMAINAN ANAK', 25.00);
INSERT INTO `hiburan_kategoris` VALUES (12, 4, 'SELUNCUR ES', 10.00);
INSERT INTO `hiburan_kategoris` VALUES (18, 7, 'MODERN', 25.00);
INSERT INTO `hiburan_kategoris` VALUES (19, 7, 'TRADISIONAL', 10.00);
INSERT INTO `hiburan_kategoris` VALUES (20, 2, 'KULINER MALAM', NULL);

-- ----------------------------
-- Table structure for hiburan_tarif_values
-- ----------------------------
DROP TABLE IF EXISTS `hiburan_tarif_values`;
CREATE TABLE `hiburan_tarif_values`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_id` bigint NULL DEFAULT NULL,
  `hiburan_tarif_id` bigint NULL DEFAULT NULL,
  `hiburan_tarif_value` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `hiburan_tarif_values_hiburan_tarif_id_hiburan_id_unique`(`hiburan_tarif_id`, `hiburan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hiburan_tarif_values
-- ----------------------------
INSERT INTO `hiburan_tarif_values` VALUES (1, 11, 1, 100000);
INSERT INTO `hiburan_tarif_values` VALUES (2, 11, 2, 50000);

-- ----------------------------
-- Table structure for hiburan_tarifs
-- ----------------------------
DROP TABLE IF EXISTS `hiburan_tarifs`;
CREATE TABLE `hiburan_tarifs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_jenis_id` bigint NULL DEFAULT NULL,
  `hiburan_tarif_deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hiburan_tarifs
-- ----------------------------
INSERT INTO `hiburan_tarifs` VALUES (1, 4, 'Dewasa');
INSERT INTO `hiburan_tarifs` VALUES (2, 4, 'Anak');

-- ----------------------------
-- Table structure for hiburan_tingkat_kunjungan_avgs
-- ----------------------------
DROP TABLE IF EXISTS `hiburan_tingkat_kunjungan_avgs`;
CREATE TABLE `hiburan_tingkat_kunjungan_avgs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_id` bigint NULL DEFAULT NULL,
  `situasi_kunjungan_weekends` int NULL DEFAULT 0,
  `situasi_kunjungan_weekdays` int NULL DEFAULT 0,
  `tingkat_kunjungan_weekends` int NULL DEFAULT 0,
  `tingkat_kunjungan_weekdays` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hiburan_tingkat_kunjungan_avgs
-- ----------------------------
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (1, 1, 100, 65, 600, 200);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (2, 2, 200, 50, 650, 200);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (3, 3, 150, 15, 1700, 150);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (4, 4, 150, 15, 1450, 100);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (5, 5, 200, 15, 600, 10);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (7, 7, 84, 208, 0, 0);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (8, 8, 0, 0, 0, 0);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (9, 9, 200, 65, 800, 100);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (10, 10, 165, 200, 760, 500);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (11, 11, 20, 100, 782, 200);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (12, 12, 100, 200, 140, 60);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (13, 13, 100, 200, 145, 66);
INSERT INTO `hiburan_tingkat_kunjungan_avgs` VALUES (14, 14, 105, 260, 25, 8);

-- ----------------------------
-- Table structure for hiburans
-- ----------------------------
DROP TABLE IF EXISTS `hiburans`;
CREATE TABLE `hiburans`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `hiburan_pemilik` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_npwpd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_kecamatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_kelurahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_rt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_rw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jumlah` int NULL DEFAULT NULL,
  `hiburan_kapasitas` int NULL DEFAULT NULL,
  `hiburan_tarif` int NULL DEFAULT NULL,
  `hiburan_durasi` double(8, 2) NULL DEFAULT NULL,
  `hiburan_jam_operasional` double(8, 2) NULL DEFAULT NULL,
  `hiburan_jam_weekdays` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_jam_weekends` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_potensi_pajak` double NULL DEFAULT NULL,
  `hiburan_persentase_pajak` double NULL DEFAULT NULL,
  `hiburan_telepon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_foto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `hiburan_latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hiburan_longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status_aktif_id` int NULL DEFAULT 1,
  `hiburan_jenis_id` int NULL DEFAULT NULL,
  `hiburan_kategori_id` int NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hiburans
-- ----------------------------
INSERT INTO `hiburans` VALUES (1, 'Ilham', '67812637812632132', 'Bioskop XXI Ciwastra', 'JL. GBI BLOK G8 NO. 89', 'BANTARGEBANG', 'CIKIWUL', '009', '001', 12, 600, 50000, NULL, NULL, '10:00 - 17:00', '10:00 - 14:00', 365000000, 10, '087822112222', '2022_BIOSKOP_0107252022.png', '-6.345326728078956', '106.98863983154298', 1, 1, NULL, 1, NULL, '2022-07-25 02:37:55', '2022-08-01 23:12:11');
INSERT INTO `hiburans` VALUES (2, 'Ilham', '127836217368123', 'Moxy', 'JL. SOEKARNO HATTA NO. 78', 'BEKASI BARAT', 'KOTABARU', '007', '008', NULL, 500, 100000, NULL, NULL, NULL, NULL, 1860000000, 40, '087822617777', '2022_DISKOTIK_0207252022.png', '-6.2471954994279555', '106.95326685905458', 1, 2, 1, 1, NULL, '2022-07-25 02:56:32', '2022-07-25 02:56:32');
INSERT INTO `hiburans` VALUES (3, 'Dodi', '7819263781623', 'Klub Alexis', 'JL. NAGREG NO. 89', 'BEKASI TIMUR', 'DURENJAYA', '001', '019', NULL, 1500, 200000, NULL, NULL, NULL, NULL, 9145000000, 40, '087822299001', '2022_DISKOTIK_0307252022.png', '-6.235613045988124', '107.03065395355226', 1, 2, 20, 1, NULL, '2022-07-25 03:01:24', '2022-07-25 03:14:24');
INSERT INTO `hiburans` VALUES (4, 'Ilham', '61728361273', 'Timezone Citayem', 'JL. CITAYEM', 'BANTARGEBANG', 'CIKIWUL', '030', '020', NULL, 678, 100000, NULL, NULL, NULL, NULL, 3390000000, 25, '087822217777', '2022_PERMAINAN_ANAK_0407252022.png', '-6.340549632917069', '106.99138641357422', 1, 4, 9, 1, NULL, '2022-07-25 03:57:37', '2022-07-25 03:58:52');
INSERT INTO `hiburans` VALUES (7, 'Ilham', '12783612783', 'Karaoke hamayat', 'KOMP. GBI BLOK G78 NO. 90', 'BEKASI BARAT', 'JAKASAMPURNA', '007', '009', 12, NULL, NULL, NULL, NULL, NULL, NULL, 273312000, 30, '087822918888', '2022_KARAOKE_0707272022.jpeg', '-6.222473157416403', '106.96323394775392', 1, 6, NULL, 1, NULL, '2022-07-27 02:24:57', '2022-08-02 02:31:29');
INSERT INTO `hiburans` VALUES (8, 'Ilham', '16278361723781', 'Ilham\'s Pijat Refleksi', 'KOMP. GBI BLOK G9 NO. 77', 'JATIASIH', 'JATIMEKAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7960650000, 30, '087821901111', '2022_PANTI_PIJAT_0807272022.jpg', '-6.346009166630132', '106.92890167236328', 1, 7, 18, 1, NULL, '2022-07-27 02:45:52', '2022-07-27 02:45:52');
INSERT INTO `hiburans` VALUES (9, 'Ilham', NULL, 'Hamayat ATV', 'KOMP. GBI BLOK G1 NO. 123', 'BEKASI SELATAN', 'KAYURINGINJAYA', NULL, NULL, NULL, 2000, 100000, NULL, NULL, NULL, NULL, 2315000000, 10, NULL, NULL, '-6.250459017393361', '106.98177337646486', 1, 3, 6, 1, NULL, '2022-07-27 02:54:57', '2022-07-27 02:54:57');
INSERT INTO `hiburans` VALUES (10, 'Hidayat', '12312671823617823', 'Bioskop CGV Ciwastra', 'JL. CIWASTRA NO. 888', 'BEKASI TIMUR', 'BEKASIJAYA', NULL, NULL, 10, 250, 40000, NULL, NULL, NULL, NULL, 901600000, 10, '087822291111', '2022_BIOSKOP_01008012022.jpg', '-6.240220461451296', '107.01885223388673', 1, 1, NULL, 1, NULL, '2022-08-01 19:58:45', '2022-08-01 19:58:45');
INSERT INTO `hiburans` VALUES (11, 'Ilham', '561725367125', 'Timezone', 'KOMP. GBI BLOK G8', 'BANTARGEBANG', 'BANTARGEBANG', '001', '020', NULL, 25, NULL, NULL, NULL, '10:00 - 15:00', '10:00 - 18:00', 1336500000, 25, '087811271118', '2022_PERMAINAN_ANAK_01108042022.jpg', '-6.337137394988534', '106.99413299560548', 1, 4, 9, 1, NULL, '2022-08-04 04:26:56', '2022-08-04 05:19:15');
INSERT INTO `hiburans` VALUES (12, 'Ilham', '123123123123123', 'Billiard 99', 'KOMP. GEDEBAGE NO. 15', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 56, 222, 120000, NULL, NULL, '00:00 - 23:59', '00:00 - 23:59', 17472000000, 10, '087824441827', '2022_BILLIARD_01208052022.jpg', '-6.3350900413976925', '106.99207305908203', 1, 9, NULL, 1, NULL, '2022-08-05 01:27:41', '2022-08-05 01:27:41');
INSERT INTO `hiburans` VALUES (13, 'Herjunot Ali', '263781623781263', 'Flying Fox Bekasi', 'KOMP. BANTARGEBANG', 'BANTARGEBANG', 'BANTARGEBANG', '09', '01', 5, 12, 5000, 3.50, NULL, '10:00 - 16:00', '10:00 - 15:00', 605937500, 25, '087828188899', '2022_WAHANA_KETANGKASAN_01308052022.jpg', '-6.338502292868852', '106.99619293212892', 1, 5, NULL, 1, NULL, '2022-08-05 03:04:00', '2022-08-05 03:04:00');
INSERT INTO `hiburans` VALUES (14, 'Deni Cagur', '1267381923', 'Arung Jeram', 'KOMP. GBI BLOK G1', 'BEKASI TIMUR', 'BEKASIJAYA', '07', '08', 3, 6, 15000, 2.00, NULL, '09:00 - 14:00', '09:00 - 14:00', 105862500, 25, '087827182222', '2022_WAHANA_KETANGKASAN_01408052022.jpg', '-6.243633335676945', '107.01610565185548', 1, 5, NULL, 1, NULL, '2022-08-05 03:13:22', '2022-08-05 03:13:22');

-- ----------------------------
-- Table structure for hotel_jenis_kamars
-- ----------------------------
DROP TABLE IF EXISTS `hotel_jenis_kamars`;
CREATE TABLE `hotel_jenis_kamars`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hotel_id` bigint NULL DEFAULT NULL,
  `hotel_jenis_kamar_deskripsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_jenis_kamar_tarif` double NULL DEFAULT 0,
  `hotel_jenis_kamar_jumlah` int NULL DEFAULT 0,
  `hotel_jenis_kamar_avg_penuh` int NULL DEFAULT 0,
  `hotel_jenis_kamar_avg_akhir_pekan` int NULL DEFAULT 0,
  `hotel_jenis_kamar_avg_normal` int NULL DEFAULT 0,
  `hotel_jenis_kamar_avg_sepi` int NULL DEFAULT 0,
  `hotel_jenis_kamar_potensi_pajak` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 165 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotel_jenis_kamars
-- ----------------------------
INSERT INTO `hotel_jenis_kamars` VALUES (1, 1, 'Deluxe', 600000, 20, 20, 20, 0, 0, 314400000);
INSERT INTO `hotel_jenis_kamars` VALUES (2, 1, 'Standar', 500000, 77, 77, 77, 50, 10, 1160200000);
INSERT INTO `hotel_jenis_kamars` VALUES (3, 1, 'Family', 1000000, 15, 15, 15, 0, 0, 393000000);
INSERT INTO `hotel_jenis_kamars` VALUES (4, 1, 'Superior', 800000, 10, 10, 10, 0, 0, 209600000);
INSERT INTO `hotel_jenis_kamars` VALUES (6, 2, 'Suite', 2500000, 2, 2, 0, 0, 0, 60000000);
INSERT INTO `hotel_jenis_kamars` VALUES (7, 2, 'Deluxe', 1000000, 60, 60, 30, 30, 15, 1312500000);
INSERT INTO `hotel_jenis_kamars` VALUES (8, 2, 'Eksekutif', 1500000, 40, 40, 20, 20, 10, 1312500000);
INSERT INTO `hotel_jenis_kamars` VALUES (10, 5, 'Standar', 350000, 30, 30, 30, 20, 6, 242970000);
INSERT INTO `hotel_jenis_kamars` VALUES (11, 6, 'Suite', 1100000, 6, 6, 2, 1, 0, 46530000);
INSERT INTO `hotel_jenis_kamars` VALUES (12, 6, 'Deluxe', 750000, 95, 95, 65, 55, 0, 1547625000);
INSERT INTO `hotel_jenis_kamars` VALUES (13, 6, 'Standar', 650000, 69, 69, 60, 50, 0, 1219920000);
INSERT INTO `hotel_jenis_kamars` VALUES (14, 22, 'STANDAR', 420000, 80, 80, 70, 40, 13, 752010000);
INSERT INTO `hotel_jenis_kamars` VALUES (15, 23, 'DELUXE', 350000, 3, 3, 3, 3, 0, 29792264.150943);
INSERT INTO `hotel_jenis_kamars` VALUES (16, 23, 'STANDAR', 300000, 25, 25, 15, 10, 5, 115491509.43396);
INSERT INTO `hotel_jenis_kamars` VALUES (17, 24, 'SUITE', 1550000, 20, 20, 13, 5, 2, 440010508.24176);
INSERT INTO `hotel_jenis_kamars` VALUES (18, 24, 'DELUXE', 1120000, 220, 220, 192, 177, 51, 6359984615.3846);
INSERT INTO `hotel_jenis_kamars` VALUES (19, 24, 'STANDAR', 1170000, 15, 15, 13, 10, 3, 412854107.14286);
INSERT INTO `hotel_jenis_kamars` VALUES (20, 24, 'HOLLYWOOD', 1170000, 10, 10, 10, 10, 2, 349148571.42857);
INSERT INTO `hotel_jenis_kamars` VALUES (22, 29, 'DELUXE', 600000, 20, 20, 20, 0, 0, 314400000);
INSERT INTO `hotel_jenis_kamars` VALUES (23, 29, 'STANDAR', 420000, 90, 90, 77, 65, 20, 1133160000);
INSERT INTO `hotel_jenis_kamars` VALUES (24, 29, 'FAMILY', 1000000, 15, 15, 15, 0, 0, 393000000);
INSERT INTO `hotel_jenis_kamars` VALUES (25, 29, 'SUPERIOR', 800000, 10, 10, 10, 0, 0, 209600000);
INSERT INTO `hotel_jenis_kamars` VALUES (26, 30, 'SUITE', 2500000, 2, 2, 0, 0, 0, 60000000);
INSERT INTO `hotel_jenis_kamars` VALUES (27, 30, 'DELUXE', 1000000, 105, 60, 30, 30, 15, 1312500000);
INSERT INTO `hotel_jenis_kamars` VALUES (28, 30, 'EKSEKUTIF', 1500000, 52, 40, 20, 20, 10, 1312500000);
INSERT INTO `hotel_jenis_kamars` VALUES (29, 31, 'EKSEKUTIF', 235000, 2, 2, 1, 0, 0, 3384000);
INSERT INTO `hotel_jenis_kamars` VALUES (30, 31, 'DELUXE', 179000, 21, 15, 12, 10, 2, 60036600);
INSERT INTO `hotel_jenis_kamars` VALUES (31, 31, 'STANDAR', 149000, 6, 6, 6, 6, 2, 27922600);
INSERT INTO `hotel_jenis_kamars` VALUES (62, 32, 'EKSEKUTIF', 235000, 2, 2, 1, 0, 0, 3713000);
INSERT INTO `hotel_jenis_kamars` VALUES (63, 32, 'DELUXE', 179000, 15, 15, 12, 10, 2, 54774000);
INSERT INTO `hotel_jenis_kamars` VALUES (64, 32, 'STANDAR', 149000, 6, 6, 6, 6, 2, 25657800);
INSERT INTO `hotel_jenis_kamars` VALUES (65, 34, 'IMPERIAL SUITE', 2600000, 2, 2, 2, 1, 1, 117000000);
INSERT INTO `hotel_jenis_kamars` VALUES (66, 34, 'JUNIOR SUTE', 2300000, 8, 8, 8, 7, 6, 584200000);
INSERT INTO `hotel_jenis_kamars` VALUES (67, 34, 'PREMIERE', 1020000, 16, 16, 15, 14, 13, 523464000);
INSERT INTO `hotel_jenis_kamars` VALUES (68, 34, 'DELUXE', 900000, 76, 76, 75, 73, 71, 2398680000);
INSERT INTO `hotel_jenis_kamars` VALUES (69, 34, 'SUPERIOR', 770000, 74, 74, 73, 72, 68, 2002154000);
INSERT INTO `hotel_jenis_kamars` VALUES (70, 35, 'DELUXE', 350000, 3, 3, 3, 3, 0, 29792264.150943);
INSERT INTO `hotel_jenis_kamars` VALUES (71, 35, 'STANDAR', 300000, 25, 25, 15, 10, 5, 115491509.43396);
INSERT INTO `hotel_jenis_kamars` VALUES (72, 37, 'SUITE', 1550000, 20, 18, 14, 10, 3, 574920123.62637);
INSERT INTO `hotel_jenis_kamars` VALUES (73, 37, 'DELUXE', 1120000, 200, 140, 120, 58, 24, 2979523076.9231);
INSERT INTO `hotel_jenis_kamars` VALUES (74, 37, 'STANDAR', 1170000, 15, 10, 8, 6, 2, 254822142.85714);
INSERT INTO `hotel_jenis_kamars` VALUES (75, 37, 'HOLLYWOOD', 1170000, 10, 7, 5, 3, 2, 155920178.57143);
INSERT INTO `hotel_jenis_kamars` VALUES (76, 38, 'SUITE', 300000, 2, 0, 2, 1, 0, 9720000);
INSERT INTO `hotel_jenis_kamars` VALUES (77, 38, 'DELUXE', 275000, 13, 0, 13, 7, 10, 84507500);
INSERT INTO `hotel_jenis_kamars` VALUES (78, 38, 'STANDAR', 225000, 13, 0, 13, 7, 7, 63337500);
INSERT INTO `hotel_jenis_kamars` VALUES (79, 38, 'FAMILY', 350000, 3, 0, 3, 2, 1, 23765000);
INSERT INTO `hotel_jenis_kamars` VALUES (80, 39, 'STANDAR', 300000, 154, 154, 154, 110, 75, 1149570000);
INSERT INTO `hotel_jenis_kamars` VALUES (81, 40, 'SUITE', 400000, 5, 5, 3, 0, 0, 22000000);
INSERT INTO `hotel_jenis_kamars` VALUES (82, 40, 'DELUXE', 350000, 38, 38, 0, 0, 0, 46550000);
INSERT INTO `hotel_jenis_kamars` VALUES (83, 40, 'STANDAR', 200000, 10, 10, 10, 10, 8, 69000000);
INSERT INTO `hotel_jenis_kamars` VALUES (84, 40, 'SUPERIOR', 250000, 2, 0, 20, 9, 0, 86125000);
INSERT INTO `hotel_jenis_kamars` VALUES (85, 41, 'AC', 195000, 40, 40, 30, 20, 10, 181155000);
INSERT INTO `hotel_jenis_kamars` VALUES (86, 41, 'NON AC', 170000, 23, 23, 15, 10, 0, 77724000);
INSERT INTO `hotel_jenis_kamars` VALUES (87, 42, 'STANDAR', 200000, 55, 55, 49, 22, 11, 213980000);
INSERT INTO `hotel_jenis_kamars` VALUES (88, 43, 'DELUXE', 200000, 10, 10, 8, 5, 3, 31700000);
INSERT INTO `hotel_jenis_kamars` VALUES (89, 43, 'STANDAR', 160000, 15, 15, 13, 10, 3, 35200000);
INSERT INTO `hotel_jenis_kamars` VALUES (90, 44, 'STANDAR', 250000, 55, 55, 50, 35, 20, 303000000);
INSERT INTO `hotel_jenis_kamars` VALUES (91, 45, 'DELUXE', 335000, 15, 15, 5, 1, 0, 30150000);
INSERT INTO `hotel_jenis_kamars` VALUES (92, 45, 'STANDAR', 295000, 50, 50, 30, 10, 8, 180304000);
INSERT INTO `hotel_jenis_kamars` VALUES (93, 45, 'SUPERIOR', 315000, 20, 20, 15, 5, 0, 76860000);
INSERT INTO `hotel_jenis_kamars` VALUES (94, 45, 'VIP', 375000, 3, 0, 0, 0, 0, 0);
INSERT INTO `hotel_jenis_kamars` VALUES (95, 46, 'AC', 225000, 10, 10, 5, 4, 2, 29017500);
INSERT INTO `hotel_jenis_kamars` VALUES (96, 47, 'AC', 325000, 60, 0, 60, 40, 10, 603909090.90909);
INSERT INTO `hotel_jenis_kamars` VALUES (97, 48, 'SUITE', 4500000, 15, 15, 3, 5, 5, 1014848746.0815);
INSERT INTO `hotel_jenis_kamars` VALUES (98, 48, 'DELUXE', 1400000, 22, 22, 22, 5, 0, 493859874.60815);
INSERT INTO `hotel_jenis_kamars` VALUES (99, 48, 'SUPERIOR', 800000, 112, 112, 127, 43, 22, 1871546081.5047);
INSERT INTO `hotel_jenis_kamars` VALUES (100, 48, 'JUNIOR SUTE', 3000000, 5, 5, 3, 1, 0, 198747648.90282);
INSERT INTO `hotel_jenis_kamars` VALUES (101, 48, 'PRESEIDENTIAL SUITE', 6000000, 1, 1, 1, 1, 0, 203896551.72414);
INSERT INTO `hotel_jenis_kamars` VALUES (102, 49, 'DELUXE', 1255000, 40, 40, 23, 6, 5, 499364500);
INSERT INTO `hotel_jenis_kamars` VALUES (103, 49, 'EKSEKUTIF', 4473000, 1, 1, 1, 0, 0, 38467800);
INSERT INTO `hotel_jenis_kamars` VALUES (104, 49, 'BISNIS', 4003000, 3, 3, 2, 0, 0, 80860600);
INSERT INTO `hotel_jenis_kamars` VALUES (105, 50, '2 DELUXE, 38 STANDART', 290000, 40, 15, 10, 7, 2, 121215322.58065);
INSERT INTO `hotel_jenis_kamars` VALUES (106, 51, 'STANDART', 270000, 0, 3, 3, 2, 0, 16425000);
INSERT INTO `hotel_jenis_kamars` VALUES (107, 52, 'Ekonomi', 75000, 20, 20, 15, 10, 5, 32287500);
INSERT INTO `hotel_jenis_kamars` VALUES (108, 52, 'Kelas III', 90000, 20, 20, 15, 10, 5, 38745000);
INSERT INTO `hotel_jenis_kamars` VALUES (109, 52, 'Kelas II', 120000, 5, 5, 5, 3, 1, 15420000);
INSERT INTO `hotel_jenis_kamars` VALUES (110, 52, 'Kelas I', 150000, 10, 10, 8, 5, 3, 34005000);
INSERT INTO `hotel_jenis_kamars` VALUES (111, 53, 'Deluxe', 250000, 5, 5, 5, 3, 1, 25725000);
INSERT INTO `hotel_jenis_kamars` VALUES (112, 53, 'Standar', 200000, 30, 0, 20, 15, 5, 83300000);
INSERT INTO `hotel_jenis_kamars` VALUES (113, 54, 'Standart', 270000, 10, 0, 3, 2, 1, 14850000);
INSERT INTO `hotel_jenis_kamars` VALUES (114, 54, 'Deluxe', 290000, 9, 0, 3, 2, 1, 15950000);
INSERT INTO `hotel_jenis_kamars` VALUES (115, 54, 'VIP', 310000, 3, 1, 3, 2, 1, 20925000);
INSERT INTO `hotel_jenis_kamars` VALUES (116, 55, 'Standar', 270000, 23, 0, 4, 4, 3, 31185000);
INSERT INTO `hotel_jenis_kamars` VALUES (117, 56, NULL, 100000, 0, 5, 5, 5, 3, 16950000);
INSERT INTO `hotel_jenis_kamars` VALUES (118, 57, NULL, 215000, 40, 25, 10, 19, 5, 120403071.42857);
INSERT INTO `hotel_jenis_kamars` VALUES (119, 58, NULL, 300000, 30, 100, 0, 0, 0, 230526315.78947);
INSERT INTO `hotel_jenis_kamars` VALUES (120, 59, 'Standar', 150000, 11, 2, 3, 2, 0, 12634615.384615);
INSERT INTO `hotel_jenis_kamars` VALUES (121, 60, 'Deluxe', 450000, 5, 5, 3, 2, 1, 61425000);
INSERT INTO `hotel_jenis_kamars` VALUES (122, 60, 'Superior', 350000, 65, 65, 50, 40, 10, 673750000);
INSERT INTO `hotel_jenis_kamars` VALUES (123, 61, 'STANDARD', 141000, 13, 7, 5, 2, 2, 21432000);
INSERT INTO `hotel_jenis_kamars` VALUES (124, 61, 'SUPERIOR', 190000, 15, 9, 3, 2, 1, 28120000);
INSERT INTO `hotel_jenis_kamars` VALUES (125, 61, 'DELUXE', 359000, 1, 0, 1, 0, 0, 2872000);
INSERT INTO `hotel_jenis_kamars` VALUES (126, 63, 'STANDARD', 170000, 15, 5, 3, 3, 1, 17833000);
INSERT INTO `hotel_jenis_kamars` VALUES (127, 63, 'SUPERIOR', 210000, 11, 5, 2, 3, 1, 20622000);
INSERT INTO `hotel_jenis_kamars` VALUES (128, 63, 'DELUXE', 270000, 12, 5, 2, 1, 1, 24084000);
INSERT INTO `hotel_jenis_kamars` VALUES (130, 73, 'STANDARD', 280000, 22, 2, 2, 1, 1, 11480000);
INSERT INTO `hotel_jenis_kamars` VALUES (131, 73, 'SUPERIOR', 210000, 11, 2, 2, 1, 1, 8610000);
INSERT INTO `hotel_jenis_kamars` VALUES (132, 73, 'DELUXE', 270000, 12, 2, 2, 1, 1, 11070000);
INSERT INTO `hotel_jenis_kamars` VALUES (133, 33, NULL, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `hotel_jenis_kamars` VALUES (134, 74, 'Standar', 300000, 40, 10, 15, 7, 2, 103440000);
INSERT INTO `hotel_jenis_kamars` VALUES (135, 75, 'Standar', 350000, 29, 18, 15, 14, 3, 163170000);
INSERT INTO `hotel_jenis_kamars` VALUES (136, 76, 'Standar', 300000, 42, 20, 14, 13, 5, 147960000);
INSERT INTO `hotel_jenis_kamars` VALUES (137, 77, 'Standar', 150000, 78, 2, 2, 1, 1, 6225000);
INSERT INTO `hotel_jenis_kamars` VALUES (138, 64, NULL, 100000, 10, 1, 1, 1, 0, 3000000);
INSERT INTO `hotel_jenis_kamars` VALUES (139, 65, NULL, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `hotel_jenis_kamars` VALUES (140, 67, 'SUPERIOR', 475000, 24, 10, 7, 5, 2, 110675000);
INSERT INTO `hotel_jenis_kamars` VALUES (141, 72, NULL, 200000, 8, 3, 3, 2, 1, 17300000);
INSERT INTO `hotel_jenis_kamars` VALUES (142, 78, 'Superior', 450000, 11, 5, 7, 4, 1, 34675000);
INSERT INTO `hotel_jenis_kamars` VALUES (143, 78, 'Deluxe', 500000, 133, 25, 35, 20, 10, 261076388.88889);
INSERT INTO `hotel_jenis_kamars` VALUES (144, 78, '1400000', 1400000, 1, 1, 1, 1, 0, 12775000);
INSERT INTO `hotel_jenis_kamars` VALUES (145, 79, 'DELUXE TWIN', 200000, 25, 25, 20, 15, 5, 119300000);
INSERT INTO `hotel_jenis_kamars` VALUES (146, 79, 'DELUXE DOUBLE', 200000, 25, 25, 20, 15, 5, 119300000);
INSERT INTO `hotel_jenis_kamars` VALUES (147, 80, 'HARRIS ROOM', 638000, 284, 250, 200, 150, 50, 3805670000);
INSERT INTO `hotel_jenis_kamars` VALUES (148, 80, 'HARRIS UNIQUE', 738000, 42, 40, 35, 25, 15, 764199000);
INSERT INTO `hotel_jenis_kamars` VALUES (149, 80, 'HARRIS SUITE', 1038000, 2, 2, 2, 2, 0, 65394000);
INSERT INTO `hotel_jenis_kamars` VALUES (150, 81, 'STANDART DOUBLE', 190000, 21, 19, 19, 15, 10, 102334000);
INSERT INTO `hotel_jenis_kamars` VALUES (151, 81, 'STANDART TWIN', 190000, 19, 19, 18, 15, 10, 101346000);
INSERT INTO `hotel_jenis_kamars` VALUES (152, 82, 'VIP', 300000, 7, 2, 1, 1, 1, 10950000);
INSERT INTO `hotel_jenis_kamars` VALUES (153, 82, 'Deluxe', 250000, 18, 3, 2, 1, 1, 10375000);
INSERT INTO `hotel_jenis_kamars` VALUES (154, 83, NULL, 200000, 10, 3, 3, 2, 1, 16931944.444444);
INSERT INTO `hotel_jenis_kamars` VALUES (155, 68, NULL, 200000, 7, 2, 2, 2, 1, 13300000);
INSERT INTO `hotel_jenis_kamars` VALUES (156, 69, NULL, 200000, 7, 3, 3, 2, 1, 17300000);
INSERT INTO `hotel_jenis_kamars` VALUES (157, 70, NULL, 300000, 10, 6, 5, 4, 0, 45000000);
INSERT INTO `hotel_jenis_kamars` VALUES (158, 66, 'SUPERIOR', 493680, 166, 30, 50, 20, 10, 525769200);
INSERT INTO `hotel_jenis_kamars` VALUES (159, 66, 'DELUXE', 735680, 9, 2, 2, 1, 1, 41565920);
INSERT INTO `hotel_jenis_kamars` VALUES (160, 66, 'FAMILY', 856680, 10, 3, 3, 2, 1, 74102820);
INSERT INTO `hotel_jenis_kamars` VALUES (161, 67, 'DELUXE', 575000, 25, 15, 7, 5, 2, 162725000);
INSERT INTO `hotel_jenis_kamars` VALUES (162, 67, 'SUITE', 950000, 1, 1, 1, 1, 0, 28500000);
INSERT INTO `hotel_jenis_kamars` VALUES (164, 71, 'STANDAR', 150000, 7, 2, 2, 1, 0, 7500000);

-- ----------------------------
-- Table structure for hotel_klasifikasis
-- ----------------------------
DROP TABLE IF EXISTS `hotel_klasifikasis`;
CREATE TABLE `hotel_klasifikasis`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `hotel_klasifikasi_deskripsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotel_klasifikasis
-- ----------------------------
INSERT INTO `hotel_klasifikasis` VALUES (1, 'Bintang 1');
INSERT INTO `hotel_klasifikasis` VALUES (2, 'Bintang 2');
INSERT INTO `hotel_klasifikasis` VALUES (3, 'Bintang 3');
INSERT INTO `hotel_klasifikasis` VALUES (4, 'Bintang 4');
INSERT INTO `hotel_klasifikasis` VALUES (5, 'Melati 1');
INSERT INTO `hotel_klasifikasis` VALUES (6, 'Melati 2');
INSERT INTO `hotel_klasifikasis` VALUES (7, 'Melati 3');
INSERT INTO `hotel_klasifikasis` VALUES (8, 'Melati 4');
INSERT INTO `hotel_klasifikasis` VALUES (9, 'GUEST HOUSE');

-- ----------------------------
-- Table structure for hotel_tingkat_hunian_avgs
-- ----------------------------
DROP TABLE IF EXISTS `hotel_tingkat_hunian_avgs`;
CREATE TABLE `hotel_tingkat_hunian_avgs`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hotel_id` bigint NULL DEFAULT NULL,
  `kunjungan_penuh` int NULL DEFAULT 0,
  `kunjungan_akhir_pekan` int NULL DEFAULT 0,
  `kunjungan_normal` int NULL DEFAULT 0,
  `kunjungan_sepi` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotel_tingkat_hunian_avgs
-- ----------------------------
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (1, 1, 192, 70, 50, 53);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (2, 2, 120, 70, 80, 95);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (3, 3, 48, 48, 190, 79);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (5, 5, 30, 98, 120, 117);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (6, 6, 2, 48, 315, 0);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (7, 7, 50, 120, 110, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (8, 8, 16, 40, 150, 59);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (9, 9, 20, 120, 141, 83);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (10, 10, 50, 120, 110, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (11, 11, 16, 40, 150, 59);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (12, 12, 20, 120, 141, 83);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (13, 13, 50, 120, 110, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (14, 14, 16, 40, 150, 59);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (15, 15, 20, 120, 141, 83);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (19, 19, 50, 120, 110, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (20, 20, 16, 40, 150, 59);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (21, 21, 20, 120, 141, 83);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (22, 22, 50, 120, 110, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (23, 23, 16, 40, 150, 59);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (24, 24, 20, 120, 141, 83);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (29, 29, 192, 70, 50, 53);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (30, 30, 120, 70, 80, 95);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (31, 31, 48, 48, 190, 79);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (32, 32, 30, 98, 120, 117);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (33, 33, 70, 100, 110, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (34, 34, 37, 48, 180, 100);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (35, 35, 16, 40, 150, 59);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (36, 36, 0, 0, 0, 0);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (37, 37, 40, 80, 161, 83);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (38, 38, 10, 55, 214, 86);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (39, 39, 10, 86, 96, 173);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (40, 40, 35, 125, 105, 100);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (41, 41, 84, 96, 120, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (42, 42, 24, 96, 180, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (43, 43, 20, 48, 55, 242);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (44, 44, 10, 101, 96, 158);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (45, 45, 20, 96, 120, 129);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (46, 46, 0, 80, 110, 110);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (47, 47, 0, 150, 50, 20);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (48, 48, 47, 47, 203, 22);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (49, 49, 30, 56, 96, 183);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (50, 50, 15, 6, 10, 0);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (51, 51, 96, 48, 144, 144);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (52, 52, 36, 144, 100, 85);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (53, 53, 20, 96, 100, 149);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (54, 54, 125, 125, 60, 55);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (55, 55, 0, 10, 50, 305);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (56, 56, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (57, 57, 95, 120, 80, 55);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (58, 58, 20, 30, 15, 30);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (59, 59, 10, 10, 5, 1);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (60, 60, 200, 70, 60, 35);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (61, 61, 110, 80, 75, 100);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (62, 62, 0, 0, 0, 0);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (63, 63, 115, 67, 45, 138);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (64, 64, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (65, 65, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (66, 66, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (67, 67, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (68, 68, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (69, 69, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (70, 70, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (71, 71, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (72, 72, 100, 100, 100, 65);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (73, 73, 22, 23, 20, 300);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (74, 74, 99, 112, 94, 60);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (75, 75, 103, 86, 90, 86);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (76, 76, 100, 95, 94, 76);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (77, 77, 30, 20, 25, 290);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (78, 78, 40, 30, 20, 270);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (79, 79, 50, 98, 167, 50);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (80, 80, 50, 98, 167, 50);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (81, 81, 52, 52, 160, 101);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (82, 82, NULL, 50, 150, 165);
INSERT INTO `hotel_tingkat_hunian_avgs` VALUES (83, 83, 100, 100, 75, 85);

-- ----------------------------
-- Table structure for hotels
-- ----------------------------
DROP TABLE IF EXISTS `hotels`;
CREATE TABLE `hotels`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hotel_klasifikasi_id` int NULL DEFAULT NULL,
  `hotel_pemilik` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_npwpd` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_alamat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `hotel_kecamatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_kelurahan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_rt` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_rw` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_jumlah_pegawai` int NULL DEFAULT NULL,
  `hotel_potensi_pajak` double NULL DEFAULT 0,
  `hotel_persentase_pajak` double(8, 2) NULL DEFAULT 10,
  `hotel_telepon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_foto` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `hotel_status_tapping_box` int NULL DEFAULT 0,
  `status_aktif_id` int NULL DEFAULT 1,
  `hotel_latitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hotel_longitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotels
-- ----------------------------
INSERT INTO `hotels` VALUES (1, 3, 'PT. HOTEL UTAMA BEKASI', '56712382783232', 'HOTEL SANTIKA', 'JL. JEND AHMAD YANI NO. 1 MEGA BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', '017', '008', 87, 2077200000, 10.00, '02129285777', '2021_HOTEL_0109242021.png', 0, 1, '-6.21206340201758', '106.9968366622925', 1, '2021-09-22 22:08:49', '2021-10-20 10:21:35', '2021-10-20 10:21:35');
INSERT INTO `hotels` VALUES (2, 4, 'AMALIA ROSENO', '678126328172637123', 'AMAROOSA', 'JL. A. YANI NO. 88', 'BEKASI SELATAN', 'JAKAMULYA', '007', '009', 80, 2685000000, 10.00, '02122100000', '2021_HOTEL_0209252021.jpeg', 0, 1, '-6.207967704098166', '107.01876640319826', 1, '2021-09-24 00:55:03', '2021-10-20 10:21:40', '2021-10-20 10:21:40');
INSERT INTO `hotels` VALUES (3, 9, 'CV. CABIN ONE BEKASI', '126378123812', 'HOTEL FRONT ONE BUDGET', 'JL. JENDRAL AHMAD YANI KAV. B NO5-6', 'BEKASI SELATAN', 'KAYURINGINJAYA', '006', '009', 70, 0, 10.00, '02189493333', '2021_HOTEL_0309242021.png', 0, 1, '-6.308814950267713', '106.92709922790529', 1, '2021-09-24 01:03:04', '2021-09-24 01:17:11', '2021-09-24 01:17:11');
INSERT INTO `hotels` VALUES (5, 7, 'PT. MUTIARA HIJAU HARMONI', '1263871236128172', 'THE GREEN HOTEL', 'JL. JEND. A. YANI SENTRA NIAGA KALIMALANG', 'BEKASI SELATAN', 'JAKAMULYA', '006', '008', 70, 242970000, 10.00, '02129257700', '2021_HOTEL_0509252021.jpg', 0, 1, '-6.267522831839373', '106.96246147155762', 1, '2021-09-24 01:12:21', '2021-10-20 10:21:51', '2021-10-20 10:21:51');
INSERT INTO `hotels` VALUES (6, 4, 'PT. MAKMUR ABADI MULIA', '71628371622132', 'HOTEL ASTON IMPERIAL', 'JL. KH. NOER ALI GEDUNG BCP LT GF', 'BEKASI SELATAN', 'JAKAMULYA', NULL, NULL, 87, 2814075000, 10.00, '02188968080', '2021_HOTEL_0609252021.jpg', 0, 1, '-6.206602464380227', '106.99632167816164', 1, '2021-09-24 01:15:31', '2021-10-20 10:21:56', '2021-10-20 10:21:56');
INSERT INTO `hotels` VALUES (22, 2, 'PT. MITRA SETIA TANEDA CHRISTY', '11', 'AMARIS', 'JL. JEND AHMAD YANI', 'BEKASI SELATAN', NULL, '4', '1', 0, 752010000, 10.00, '2188959091', 'uniknya-restoran-ini-bisa-makan-sambil-rendaman-kaki-netizen-awas-banjir-bandang-8BWwuXMmyR.jpg', 0, 1, NULL, NULL, 1, '2021-09-25 17:07:34', '2021-10-20 10:22:01', '2021-10-20 10:22:01');
INSERT INTO `hotels` VALUES (23, 2, 'LAUREN', '12', 'YUSRA INN', 'JL. RAYA PEKAYON NO.1', 'BEKASI SELATAN', NULL, '4', '1', 0, 145283773.58491, 10.00, '2182410000', NULL, 0, 1, NULL, NULL, 1, '2021-09-25 17:07:34', '2021-10-20 10:22:06', '2021-10-20 10:22:06');
INSERT INTO `hotels` VALUES (24, 4, 'PT. METROPOLITAN LAND, TBK', '13', 'HOTEL HORISON BEKASI', 'JL. KH NOER ALI', 'BEKASI SELATAN', NULL, NULL, NULL, 0, 7561997802.1978, 10.00, '218848888', NULL, 0, 1, NULL, NULL, 1, '2021-09-25 17:07:34', '2021-10-20 10:22:10', '2021-10-20 10:22:10');
INSERT INTO `hotels` VALUES (29, 3, 'PT. HOTEL UTAMA BEKASI', 'P.2.01.00023193.14.02', 'HOTEL SANTIKA', 'JL. JEND AHMAD YANI NO. 1 MEGA BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 50, 2050160000, 10.00, '02129285777', 'http://drive.google.com/uc?id=1c5QNmSVqQ5MuDWp8hGBKLjIwckMUjT5l', 0, 1, '-6.2497877', '106.9938928', 1, '2021-10-20 22:29:33', '2022-01-19 10:52:30', NULL);
INSERT INTO `hotels` VALUES (30, 4, 'AMALIA ROSENO', 'P.2.01.0002466.14.02', 'AMAROOSA', 'JL. A. YANI NO. 88', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 60, 2685000000, 10.00, '02122100000', 'http://drive.google.com/uc?id=1L1gqxy0gg2M7DYLzxENMGHCr0tdwIRSr', 0, 1, '-6.2504585', '106.9923018', 1, '2021-10-20 22:29:33', '2022-04-11 10:06:49', NULL);
INSERT INTO `hotels` VALUES (31, 9, 'CV. CABIN ONE BEKASI', 'P.2.01.0005315.14.02', 'HOTEL FRONT ONE BUDGET', 'JL. JENDRAL AHMAD YANI KAV. B NO5-6', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 13, 91343200, 10.00, '02189493333', 'http://drive.google.com/uc?id=1WeBV6GZ7h6-AptSSZOT_iARkK7YlXzMf', 0, 1, '-6.2436147', '106.9937422', 1, '2021-10-20 22:29:33', '2022-04-11 10:07:14', NULL);
INSERT INTO `hotels` VALUES (32, 7, 'PT. MUTIARA HIJAU HARMONI', 'P.2.01.0001683.14.05', 'THE GREEN HOTEL', 'JL. JEND. A. YANI SENTRA NIAGA KALIMALANG', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 17, 84144800, 10.00, '02129257700', 'http://drive.google.com/uc?id=1gUPBIUFmQwcZhIYvLY55gWr0SFmrGT0B', 0, 1, '-6.2440134', '106.9912952', 1, '2021-10-20 22:29:33', '2022-04-19 07:55:04', '2022-04-19 07:55:04');
INSERT INTO `hotels` VALUES (33, 2, 'PT. MITRA SETIA TANEDA CHRISTY', 'P.2.01.0002063.14.02', 'AMARIS', 'JL. JEND AHMAD YANI RT. 004/001', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 18, 0, 10.00, '02188959091', 'http://drive.google.com/uc?id=1rKhd3Mr54xJEP_2VL4CunVIx-rXcGl1p', 0, 1, '-6.2532202', '106.9916015', 1, '2021-10-20 22:29:33', '2022-04-11 10:07:49', NULL);
INSERT INTO `hotels` VALUES (34, 4, 'PT. MAKMUR ABADI MULIA', 'P.2.01.0002509.14.05', 'HOTEL ASTON IMPERIAL', 'JL. KH. NOER ALI GEDUNG BCP LT GF', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 74, 5625498000, 10.00, '02188968080', 'http://drive.google.com/uc?id=1GmX5MxyrMhaIVkXET2SZdykyfLVs7m93', 0, 1, NULL, NULL, 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (35, 2, 'LAUREN', 'P.2.01.0004989.14.01', 'YUSRA INN', 'JL. RAYA PEKAYON NO.1, RT.004/RW.001', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 23, 145283773.58491, 10.00, '02182410000', 'http://drive.google.com/uc?id=1gl9c7qUm-Y2GDGP_aQJLQycAViXyPaRz', 0, 1, '-6.2567745', '106.9904685', 1, '2021-10-20 22:29:33', '2022-04-19 07:55:31', '2022-04-19 07:55:31');
INSERT INTO `hotels` VALUES (36, 2, 'PT. IXO HOTEL', 'P.2.01.0002937.14.02', 'IXO HOTEL', 'JL. PRAMUKA NO. 23', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 15, 0, 10.00, '02128519797', 'http://drive.google.com/uc?id=1bmaSCYKCdPLvjYFJoCZftl4XHi-vtKln', 0, 1, '-6.2489574', '106.9927381', 1, '2021-10-20 22:29:33', '2021-10-20 22:29:33', NULL);
INSERT INTO `hotels` VALUES (37, 4, 'PT. METROPOLITAN LAND, TBK', 'P.2.01.0000001.14.01', 'HOTEL HORISON BEKASI', 'JL. KH NOER ALI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 73, 3965185521.978, 10.00, '0218848888', 'http://drive.google.com/uc?id=1yfUDewAKya4m36u6ZHByPqvtxyt0kvCy', 1, 1, '-6.24836', '106.99001', 1, '2021-10-20 22:29:33', '2022-04-11 10:08:37', NULL);
INSERT INTO `hotels` VALUES (38, 7, 'PRIHARTONO', 'P.2.01.0004136.11.01', 'UNGU VIVO HOTEL', 'JL. IR.H.JUANDA NO.139', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 5, 181330000, 10.00, '08161131000', 'http://drive.google.com/uc?id=1oOc_UVfzKS-yyVB4jVBLmE6HVE3UhMvG', 0, 1, NULL, NULL, 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (39, 2, 'PT. RED PLANET INDONESIA', 'P.2.01.0002181.11.02', 'RED PLANET', 'JL CHAIRIL ANWAR NO 27-36', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 25, 1149570000, 10.00, '02129689222', 'http://drive.google.com/uc?id=1xlu_gdqbjzdNrBfXfAQpavg9sHZCvqbO', 0, 1, '-6.2563', '107.00891', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (40, 1, 'ARIF SUBARJA', 'P.2.01.0000003.11.02', 'HOTEL BUNGA KARANG', 'JL. RA KARTINI NO 05 BEKASI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 15, 223675000, 10.00, '0218808136', 'http://drive.google.com/uc?id=1WcdRn004g8fP-wlZb3veXmBDys-lndtC', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (41, 6, 'AMANAH', 'P.2.01.0000007.11.02', 'HOTEL FAMILY BARU', 'JL IR. H. JUANDA NO 179', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 26, 258879000, 10.00, '0218808247', 'http://drive.google.com/uc?id=1cj2ND_ZhayiO806sgDO-G85fcegNsLyJ', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (42, 6, 'PUSAT KOPERASI PEGAWAI NEGERI', 'P.2.01.0000008.11.02', 'HOTEL WISMA CITRA', 'JL LAPANGAN MULTIGUNA NO 01', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 20, 213980000, 10.00, '0218817034', 'http://drive.google.com/uc?id=1r4NqsMKrJvT6eA1r4jDZBUNh1nwgpO1L', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (43, 2, 'WILLY TANTRI', 'P.2.01.0004079.11.02', 'HOTEL VERSA', 'JL. M. H JOYO MARTONO NO 20', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 15, 66900000, 10.00, '02182696969', 'http://drive.google.com/uc?id=1jNfc2LyINGA2Egu3uv9N_z7_dNygTNN8', 0, 1, '-6.25674', '107.02123', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (44, 2, 'PT. ADHI PERSADA PROPERTY', 'P.2.01.0004489.11.02', 'HOTEL GRAND DHIKA CITY / OYO', 'JL. HM. JOYOMARTONO', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 8, 303000000, 10.00, '081382411891', 'http://drive.google.com/uc?id=1UWT1e8sJ-rskU9tLpSVzbb024R1Cq1bU', 0, 1, '-6.26303', '107.01946', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (45, 4, 'LIM KHAN TJHEN', 'P.2.01.0000004.11.02', 'HOTEL SENTOSA', 'JL RAYA CUT MUTIA NO 30', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 20, 287314000, 10.00, '0218810026', 'http://drive.google.com/uc?id=101Rj3qZ-mm8LUkrBULODz2JulUR3mLgq', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:58', NULL);
INSERT INTO `hotels` VALUES (46, 5, 'PARAMITHA ARIMURTI', 'P.2.01.0005302.18.03', 'ARJUNA MOTEL', 'JL. AL. NO. 02 UJUNG ASPAL KP. PONDOK RANGON', 'JATISAMPURNA', 'JATIRANGON', NULL, NULL, 10, 29017500, 10.00, '0218450425', 'http://drive.google.com/uc?id=1PkdtC0hRuRFpGUPcTZj4W2qlhmt75GkZ', 0, 1, '-6.33799', '106.92688', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:59', NULL);
INSERT INTO `hotels` VALUES (47, 7, 'SETIAWAN WIJAYA', 'P.2.01.0000017.18.01', 'CIBUBUR INN', 'JL. ALTERNATIF CIBUBUR NO. 99', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 50, 603909090.90909, 10.00, '0218450303', 'http://drive.google.com/uc?id=1va4Pg6hD3mldbiPs_rLWgKnZH7GCAwst', 0, 1, '-6.37949', '106.92262', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:59', NULL);
INSERT INTO `hotels` VALUES (48, 4, 'STEFAN ONG', 'P.2.01.0004280.18.01', 'AVENZEL HOTEL AND CONVENTION', 'JL. RAYA KRANGGAN NO.69', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 92, 3782898902.8213, 10.00, '02180610500', 'http://drive.google.com/uc?id=1qSaitNWzJ0gP7Fl4XnulicEFuNT2j-Qx', 0, 1, '-6.37566', '106.91484', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:59', NULL);
INSERT INTO `hotels` VALUES (49, 4, 'PT. SINAR BAHANA MULYA', 'P.2.01.0002686.18.02', 'HOTEL CIPUTRA CIBUBUR', 'JL. ALTERNATIF CIBUBUR NO.KM. 4', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 47, 618692900, 10.00, '02129376828', 'http://drive.google.com/uc?id=1CSXsKyxIN31J3adxVpx2CnSGvgf2mue4', 0, 1, '-6.38245', '106.92558', 1, '2021-10-20 22:29:33', '2021-10-21 13:35:59', NULL);
INSERT INTO `hotels` VALUES (50, 6, 'STEVEN STEADY CHANDRA', 'P.2.01.0003219.18.04', 'KING STONE', 'JL. MENDU NO.09', 'JATISAMPURNA', 'JATIRANGGA', '002', '003', 12, 121215322.58065, 10.00, '02121384415', '2021_HOTEL_05012162021.jpg', 0, 4, '-6.371370032820585,', '106.9361087259715', 12, '2021-12-16 11:38:57', '2021-12-20 23:55:51', NULL);
INSERT INTO `hotels` VALUES (51, 5, 'ASEP MUH SARIP', 'P.2.01.0004322.18.05', 'ADAYA HOTEL', 'JL.RAYA KRANGGAN RUKO SAMPURNA SQUARE NO.20', 'JATISAMPURNA', 'JATIRADEN', '003', '009', 2, 16425000, 10.00, '02128678840', '2021_HOTEL_05112162021.jpg', 0, 4, '-6.354753532487551,', '106.92044091063096', 12, '2021-12-16 11:49:31', '2021-12-16 11:49:31', NULL);
INSERT INTO `hotels` VALUES (52, 7, 'Hj. Heryeti', 'P.2.01.0000005.11.02', 'Hotel Merdeka', 'JL. IR. H. JUANDA MARGAHAYU BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '01', '09', 12, 120457500, 10.00, '0218801472', '2021_HOTEL_05212222021.jpg', 0, 1, '6.249484', '107.014982', 10, '2021-12-22 11:56:05', '2022-04-14 09:47:22', NULL);
INSERT INTO `hotels` VALUES (53, 7, 'Siauw Alexander', 'P.2.01.0004959.11.02', 'Hotel Teratai', 'JL. M. OKING NO. 26 MARGAHAYU', 'BEKASI TIMUR', 'MARGAHAYU', '02', '01', 5, 109025000, 10.00, '082124638108', '2021_HOTEL_05312222021.jpeg', 0, 1, '6.244267', '107.002679', 10, '2021-12-22 12:16:59', '2022-04-18 10:59:44', NULL);
INSERT INTO `hotels` VALUES (54, 7, 'Hadi Susanto', 'P.2.01.0000011.19.03', 'Hotel gaharu', 'JL SILIWANGI NO 45 RAWALUMBU', 'RAWALUMBU', 'SEPANJANGJAYA', '002', '003', 7, 51725000, 10.00, '021-8203919', '2021_HOTEL_05412222021.jpg', 0, 1, '-6.261817180919646', '106.9950181245804', 19, '2021-12-22 15:23:33', '2022-05-12 09:42:28', NULL);
INSERT INTO `hotels` VALUES (55, 7, 'Abram Martono', 'P.2.01.0000012.19.03', 'Hotel Pinus', 'JL. SILIWANGI NO 47 RAWALUMBU', 'RAWALUMBU', 'SEPANJANGJAYA', '002', '003', 7, 31185000, 10.00, '021-8223356', '2021_HOTEL_05512222021.jpg', 0, 1, '-6.260868010511125', '106.99758768081666', 19, '2021-12-22 15:28:07', '2022-04-14 09:31:42', NULL);
INSERT INTO `hotels` VALUES (56, 7, 'BPK TOMY/ IBU GUNARDI', 'P.2.01.002370.15.04', 'WISMA SAKURA NAYUTA', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '09', '05', 6, 16950000, 10.00, '085956375625', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 10:04:20', '2022-04-13 09:30:42', NULL);
INSERT INTO `hotels` VALUES (57, 7, 'RAMLAN', 'P.2.01.0001098.15.01', 'LOSMEN KEBUN INDAH', 'JL WIBAWA MUKTI II NO 46', 'JATIASIH', 'JATISARI', '008', '002', 10, 120403071.42857, 10.00, '0813158222025', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 10:19:20', '2022-06-03 09:43:39', NULL);
INSERT INTO `hotels` VALUES (58, 6, 'jajajaja', 'p.21132538648', 'abcd', 'ASFSGWEH', 'PONDOKGEDE', 'JATIBENING', '01', '02', 10, 230526315.78947, 10.00, '02165', NULL, 0, 4, NULL, NULL, 18, '2022-01-06 11:48:10', '2022-01-06 11:48:29', '2022-01-06 11:48:29');
INSERT INTO `hotels` VALUES (59, 9, 'AGNES DIANA SUSANTI', 'P.2.01.0005287.22.03', 'WISMA MELATI 71', 'KOMP. WISMA MELATI JL.YUDISTIRA 29', 'PONDOKMELATI', 'JATIWARNA', '005', '08', 2, 12634615.384615, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-01-07 09:45:45', '2022-01-11 11:49:27', '2022-01-11 11:49:27');
INSERT INTO `hotels` VALUES (60, 2, 'Lukman Nelam', 'P.2.01.0003908.19.03', 'Hotel 88', 'JL. CUT MUTIA', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '002', 23, 735175000, 10.00, '021-82740888', '2022_HOTEL_06001102022.jpg', 0, 1, '-6.260993322433565', '107.00186580419543', 19, '2022-01-10 10:14:02', '2022-04-14 09:34:10', NULL);
INSERT INTO `hotels` VALUES (61, 6, 'SRIE MELANIE', 'P.2.01.0000013.17.01', 'HOTEL TRANSIT', 'JL.RAYA NAROGONG KM.11,7 PANGKALAN 1', 'BANTARGEBANG', 'BANTARGEBANG', '003', '005', 3, 52424000, 10.00, '081317679993', '2022_HOTEL_06101172022.jpg', 0, 1, '-6.307791218419804', '106.97902679443361', 13, '2022-01-17 12:35:50', '2022-04-18 08:34:10', NULL);
INSERT INTO `hotels` VALUES (62, 4, 'HANDJAJA SUSANTO', 'P.2.01.0004501.16.02', 'HANDJAJA SUSANTO', 'JL.RAYA CAMAN NO.21', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 30, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 09:11:36', '2022-01-18 09:12:59', '2022-01-18 09:12:59');
INSERT INTO `hotels` VALUES (63, 7, 'AYU INDRIATI', 'P.2.01.0000014.17.04', 'HOTEL GANDAMANAH', 'JL.RAYA NAROGONG KM.11 NO.26', 'BANTARGEBANG', 'BANTARGEBANG', '007', '003', 5, 62539000, 10.00, '0218250790', '2022_HOTEL_06301182022.jpg', 0, 1, '-6.343961848265028', '106.97010040283203', 13, '2022-01-18 11:10:16', '2022-04-18 08:35:52', NULL);
INSERT INTO `hotels` VALUES (64, 9, 'HJ.NUNUK SP', 'P.2.01.0004748.16.04', 'WISMA NURANI 1', 'JL.ANUGRAH RAYA', 'PONDOKGEDE', 'JATICEMPAKA', '003', '004', 0, 3000000, 10.00, NULL, NULL, 0, 1, '-6.260635', '106.9069637', 18, '2022-01-18 11:35:44', '2022-05-31 14:13:16', NULL);
INSERT INTO `hotels` VALUES (65, 7, 'BEKTI YULIANTO', 'P.2.01.0004514.16.02', 'WISMA BENING SYARIAH', 'JL.MASJID', 'PONDOKGEDE', 'JATIBENING', '007', '001', 0, 0, 10.00, NULL, '2022_HOTEL_06502152022.jpg', 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:35:44', '2022-05-31 09:23:47', '2022-05-31 09:23:47');
INSERT INTO `hotels` VALUES (66, 3, 'HANDJAJA SUSANTO', 'P.2.01.0004501.16.02', 'HOTEL IBIS / PT.MITRA GRAHA ANDALAN', 'JL.RAYA CAMAN NO.21', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 30, 641437940, 10.00, NULL, NULL, 1, 1, '-6.2607384', '106.9402406', 18, '2022-01-18 11:35:44', '2022-06-03 08:40:23', NULL);
INSERT INTO `hotels` VALUES (67, 3, 'HOTEL GRAND CAMAN / PT. MITRALAND SUKSES MANDIRI', 'P.2.01.0004201.16.05', 'HOTEL GRAND CAMAN / PT. MITRALAND SUKSES MANDIRI', 'JL.RAYA JATIBENING', 'PONDOKGEDE', 'JATIBENING', '001', '003', 0, 301900000, 10.00, NULL, '2022_HOTEL_06702152022.jpg', 0, 1, '-6.2619648', '106.9514752', 18, '2022-01-18 11:35:44', '2022-06-24 09:32:26', NULL);
INSERT INTO `hotels` VALUES (68, 9, 'H.AHMAD SUPRIANTO', 'P.2.01.0003417.16.04', 'WISMA NURANI 2', 'GG.H.MAHDI NO.6', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 5, 13300000, 10.00, NULL, NULL, 0, 1, '-6.260635', '106.9069637', 18, '2022-01-18 11:35:44', '2022-05-31 14:14:09', NULL);
INSERT INTO `hotels` VALUES (69, 7, 'ARNOLD POHAN', 'P.2.01.0003130.16.02', 'PENGINAPAN GENDIS', 'JL.CAMAN RAYA NO.34 A', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 5, 17300000, 10.00, NULL, NULL, 0, 1, '-6.2607384', '106.9402406', 18, '2022-01-18 11:35:44', '2022-05-31 14:14:29', NULL);
INSERT INTO `hotels` VALUES (70, 7, 'HOTEL FORTUNA', 'P.2.01.0000669.16.04', 'HOTEL FORTUNA', 'JL. RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 0, 45000000, 10.00, NULL, NULL, 0, 1, '-6.260635', '106.9069637', 18, '2022-01-18 11:35:44', '2022-05-31 14:14:48', NULL);
INSERT INTO `hotels` VALUES (71, 9, 'PENGINAPAN AL HAKIM', 'P.2.01.0000016.16.04', 'PENGINAPAN AL HAKIM', 'JL. ANUGRAH RAYA NO. 107', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 0, 7500000, 10.00, NULL, NULL, 0, 1, '-6.260635', '106.9069637', 18, '2022-01-18 11:35:44', '2022-06-24 09:32:47', NULL);
INSERT INTO `hotels` VALUES (72, 7, 'HOTEL MUTIARA', 'P.2.01.0000015.16.02', 'HOTEL MUTIARA', 'JL. RAYA CAMAN JATIBENING', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 0, 17300000, 10.00, NULL, '2022_HOTEL_07202152022.jpg', 0, 1, '-6.2607384', '106.9402406', 18, '2022-01-18 11:35:44', '2022-05-31 14:15:10', NULL);
INSERT INTO `hotels` VALUES (73, 5, 'MARTINA DWI MUSTIKA', 'P.2.01.0000756.17.01', 'HOTEL ROYAL', 'JL.RAYA NAROGONG NO.88', 'BANTARGEBANG', 'BANTARGEBANG', '002', '005', 5, 31160000, 10.00, '02182606884', '2022_HOTEL_07301182022.jpg', 0, 1, '-6.310179922919131', '106.98451995849611', 13, '2022-01-18 11:48:19', '2022-05-25 14:23:15', NULL);
INSERT INTO `hotels` VALUES (74, 7, 'YAMAN ZEBUA', 'P.2.01.0001058.12.05', 'HOTEL PHOENIX', 'JL. KH. NOER ALI 68 GH JAKA SAMPURNA', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 10, 103440000, 10.00, '081218232313', '2022_HOTEL_07402102022.jpg', 0, 1, '-6.226910039683643', '106.97902679443361', 11, '2022-02-10 11:14:31', '2022-04-07 12:47:26', NULL);
INSERT INTO `hotels` VALUES (75, 7, 'JOHANES BOYKE LEONARDO', 'P.2.01.0004196.12.05', 'HOTEL BI ONE / PT.SATU MAJU HOTELINDO', 'JL.INPEKSI TOL JORR KALIMALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 20, 163170000, 10.00, '081314267595', '2022_HOTEL_07502102022.jpg', 0, 1, '-6.224862252524702', '106.97628021240236', 11, '2022-02-10 12:05:53', '2022-04-07 12:33:57', NULL);
INSERT INTO `hotels` VALUES (76, 7, 'ASA BUDGET HOTEL/PT. ANUGRAH SADA PERARIH/ JAUHARI', 'P.2.01.0002127.12.05', 'ASA BUDGET HOTEL', 'JL. KH.NOER ALI KOMP. DUTA PERMAI BLOK C2 NO. 14-15', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 13, 147960000, 10.00, '081286315015', '2022_HOTEL_07602102022.jpg', 0, 1, '-6.2258861471022175', '106.97559356689455', 11, '2022-02-10 14:50:27', '2022-04-07 12:46:45', NULL);
INSERT INTO `hotels` VALUES (77, 9, 'RUDY WIJAYA', 'P.2.01.0004859.12.05', 'KOS KOSAN TUNAS PLAZA', 'KP.DUA RT.010 RW.003', 'BEKASI BARAT', 'JAKASAMPURNA', '010', '003', 17, 6225000, 10.00, '082122040340', '2022_HOTEL_07702102022.jpg', 0, 4, '-6.228275226686636', '106.97696685791017', 11, '2022-02-10 15:22:53', '2022-02-11 10:39:14', '2022-02-11 10:39:14');
INSERT INTO `hotels` VALUES (78, 4, 'Bangun Arilita', 'P.2.01.0002651.19.03', 'Hotel Merapi Merbabu', 'JL. CUT MUTIA 91 SEPANJANG JAYA RAWALUMBU BEKASI', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '002', 60, 308526388.88889, 10.00, '021-29487750', '2022_HOTEL_07803082022.jpg', 0, 1, '-6.260692040526723', '107.00220912694934', 19, '2022-03-08 14:35:38', '2022-04-14 09:42:25', NULL);
INSERT INTO `hotels` VALUES (79, 3, 'LEONARDO FREDERICK', 'P.2.01.0005326.13.05', 'HOTEL OYO / PATRALAND URBANO', 'JL. PINTU AIR NO. 29 RT. 003 RW. 001', 'BEKASI UTARA', 'MARGAMULYA', '003', '001', 7, 238600000, 10.00, '08815412894', '2022_HOTEL_07903312022.jpeg', 0, 4, '-6.234077231836084', '106.99866056442262', 14, '2022-03-31 11:13:46', '2022-03-31 11:30:13', NULL);
INSERT INTO `hotels` VALUES (80, 4, 'JOHANES MARDJUKI', 'P.2.01.0002536.13.05', 'HOTEL HARRIS', 'JL.BULEVAR UTARA SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 97, 4635263000, 10.00, '085695352587', NULL, 1, 1, '-6.224830255786985', '107.00180411338808', 14, '2022-03-31 11:43:55', '2022-05-31 08:17:12', NULL);
INSERT INTO `hotels` VALUES (81, 3, 'IR.TINAWATI S', 'P.2.01.0004549.13.03', 'HOTEL OYO / PT.BERKAT MANDIRI MAKMUR', 'PRIMA HARAPAN REGENCY RUKO BLOK.D 8-9', 'BEKASI UTARA', 'HARAPANBARU', '001', '002', 6, 203680000, 10.00, '085894044270', '2022_HOTEL_08104282022.jpeg', 1, 4, '-6.2200227238064425', '107.01529294252398', 14, '2022-04-28 09:47:51', '2022-04-28 09:50:25', NULL);
INSERT INTO `hotels` VALUES (82, 7, 'Yuli', 'P.2.01.0004782.19.03', 'New Pesona', 'CUT MUTIA BLOK H-Q NO.9', 'RAWALUMBU', 'SEPANJANGJAYA', '002', '01', 7, 21325000, 10.00, '021-82752760', '2022_HOTEL_08205172022.jpg', 0, 1, '-6.261155961266794', '106.99817776679994', 19, '2022-05-17 09:46:21', '2022-06-06 10:16:47', NULL);
INSERT INTO `hotels` VALUES (83, 7, 'HOTEL MUTIARA', 'P.2.01.0000015.16.02', 'HOTEL MUTIARA', 'JL. RAYA CAMAN JATIBENING', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 3, 16931944.444444, 10.00, NULL, NULL, 0, 4, '-6.253989139720905', '106.95160925388338', 18, '2022-05-31 09:17:01', '2022-05-31 09:18:53', '2022-05-31 09:18:53');

-- ----------------------------
-- Table structure for kecamatans
-- ----------------------------
DROP TABLE IF EXISTS `kecamatans`;
CREATE TABLE `kecamatans`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `kecamatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kecamatans
-- ----------------------------
INSERT INTO `kecamatans` VALUES (1, 'BEKASI TIMUR');
INSERT INTO `kecamatans` VALUES (2, 'BEKASI UTARA');
INSERT INTO `kecamatans` VALUES (3, 'BEKASI BARAT');
INSERT INTO `kecamatans` VALUES (4, 'BEKASI SELATAN');
INSERT INTO `kecamatans` VALUES (5, 'MEDANSATRIA');
INSERT INTO `kecamatans` VALUES (6, 'RAWALUMBU');
INSERT INTO `kecamatans` VALUES (7, 'JATIASIH');
INSERT INTO `kecamatans` VALUES (8, 'PONDOKGEDE');
INSERT INTO `kecamatans` VALUES (9, 'PONDOKMELATI');
INSERT INTO `kecamatans` VALUES (10, 'JATISAMPURNA');
INSERT INTO `kecamatans` VALUES (11, 'BANTARGEBANG');
INSERT INTO `kecamatans` VALUES (12, 'MUSTIKAJAYA');

-- ----------------------------
-- Table structure for kelurahans
-- ----------------------------
DROP TABLE IF EXISTS `kelurahans`;
CREATE TABLE `kelurahans`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `kecamatan_id` int NULL DEFAULT NULL,
  `kelurahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `kode_pos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `default_latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `default_longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kelurahans
-- ----------------------------
INSERT INTO `kelurahans` VALUES (1, 1, 'ARENJAYA', '17111', '-6.2405155', '107.0247582');
INSERT INTO `kelurahans` VALUES (2, 1, 'BEKASIJAYA', '17112', '-6.2347646', '107.0071627');
INSERT INTO `kelurahans` VALUES (3, 1, 'DURENJAYA', '17111', '-6.23769', '107.0151017');
INSERT INTO `kelurahans` VALUES (4, 1, 'MARGAHAYU', '17113', '-6.251072', '107.0030481');
INSERT INTO `kelurahans` VALUES (5, 2, 'HARAPANBARU', '17123', '-6.2155678', '107.0121816');
INSERT INTO `kelurahans` VALUES (6, 2, 'HARAPANJAYA', '17124', '-6.2083625', '106.9815363');
INSERT INTO `kelurahans` VALUES (7, 2, 'KALIABANG TENGAH', '17125', '-6.1890416', '106.9937272');
INSERT INTO `kelurahans` VALUES (8, 2, 'MARGAMULYA', '17142', '-6.2269911', '106.9935132');
INSERT INTO `kelurahans` VALUES (9, 2, 'PERWIRA', '17122', '-6.2084346', '107.0005342');
INSERT INTO `kelurahans` VALUES (10, 2, 'TELUK PUCUNG', '17121', '-6.210014', '107.0173702');
INSERT INTO `kelurahans` VALUES (11, 3, 'BINTARA', '17134', '-6.2271913', '106.9540861');
INSERT INTO `kelurahans` VALUES (12, 3, 'BINTARAJAYA', '17136', '-6.2401818', '106.9497011');
INSERT INTO `kelurahans` VALUES (13, 3, 'JAKASAMPURNA', '17145', '-6.2437026', '106.9565732');
INSERT INTO `kelurahans` VALUES (14, 3, 'KOTABARU', '17134', '-6.2145394', '106.9619727');
INSERT INTO `kelurahans` VALUES (15, 3, 'KRANJI', '17135', '-6.2281879', '106.9716997');
INSERT INTO `kelurahans` VALUES (16, 4, 'JAKAMULYA', '17146', '-6.2680621', '106.9529182');
INSERT INTO `kelurahans` VALUES (17, 4, 'JAKASETIA', '17147', '-6.2650391', '106.9653441');
INSERT INTO `kelurahans` VALUES (18, 4, 'KAYURINGINJAYA', '17144', '-6.238668', '106.9759767');
INSERT INTO `kelurahans` VALUES (19, 4, 'MARGAJAYA', '17141', '-6.245879', '106.9875147');
INSERT INTO `kelurahans` VALUES (20, 4, 'PEKAYONJAYA', '17148', '-6.2590246', '106.9737701');
INSERT INTO `kelurahans` VALUES (21, 5, 'HARAPANMULYA', '17143', '-6.2273428', '106.9857751');
INSERT INTO `kelurahans` VALUES (22, 5, 'KALIBARU', '17133', '-6.2191913', '106.9785081');
INSERT INTO `kelurahans` VALUES (23, 5, 'MEDANSATRIA', '17132', '-6.2036385', '106.9650814');
INSERT INTO `kelurahans` VALUES (24, 5, 'PEJUANG', '17131', '-6.185236', '106.9792367');
INSERT INTO `kelurahans` VALUES (25, 6, 'BOJONGMENTENG', '17117', '-6.2973413', '106.9810571');
INSERT INTO `kelurahans` VALUES (26, 6, 'BOJONG RAWALUMBU', '17116', '-6.2807826', '106.9820828');
INSERT INTO `kelurahans` VALUES (27, 6, 'PENGASINAN', '17115', '-6.2715671', '107.0000022');
INSERT INTO `kelurahans` VALUES (28, 6, 'SEPANJANGJAYA', '17114', '-6.2648076', '106.9877207');
INSERT INTO `kelurahans` VALUES (29, 7, 'JATIASIH', '17423', '-6.3101914', '106.9215729');
INSERT INTO `kelurahans` VALUES (30, 7, 'JATIKRAMAT', '17421', '-6.2780295', '106.9381343');
INSERT INTO `kelurahans` VALUES (31, 7, 'JATILUHUR', '17425', '-6.319541', '106.9424953');
INSERT INTO `kelurahans` VALUES (32, 7, 'JATIMEKAR', '17422', '-6.2953715', '106.9398842');
INSERT INTO `kelurahans` VALUES (33, 7, 'JATIRASA', '17424', '-6.2959666', '106.9604766');
INSERT INTO `kelurahans` VALUES (34, 7, 'JATISARI', '17426', '-6.337204', '106.9407462');
INSERT INTO `kelurahans` VALUES (35, 8, 'JATIBENING', '17412', '-6.2607384', '106.9402406');
INSERT INTO `kelurahans` VALUES (36, 8, 'JATIBENING BARU', '17412', '-6.2623302', '106.9263377');
INSERT INTO `kelurahans` VALUES (37, 8, 'JATICEMPAKA', '17411', '-6.260635', '106.9069637');
INSERT INTO `kelurahans` VALUES (38, 8, 'JATIMAKMUR', '17413', '-6.2823959', '106.9208923');
INSERT INTO `kelurahans` VALUES (39, 8, 'JATIWARINGIN', '17411', '-6.2763813', '106.9135676');
INSERT INTO `kelurahans` VALUES (40, 9, 'JATIMELATI', '17414', '-6.3156543', '106.9268416');
INSERT INTO `kelurahans` VALUES (41, 9, 'JATIMURNI', '17431', '-6.3276403', '106.9258177');
INSERT INTO `kelurahans` VALUES (42, 9, 'JATIRAHAYU', '17414', '-6.2925495', '106.9152097');
INSERT INTO `kelurahans` VALUES (43, 9, 'JATIWARNA', '17415', '-6.3053693', '106.9250822');
INSERT INTO `kelurahans` VALUES (44, 10, 'JATIKARYA', '17435', '-6.3865666', '106.9069922');
INSERT INTO `kelurahans` VALUES (45, 10, 'JATIRADEN', '17433', '-6.3540196', '106.9156308');
INSERT INTO `kelurahans` VALUES (46, 10, 'JATIRANGGA', '17434', '-6.3632276', '106.9316388');
INSERT INTO `kelurahans` VALUES (47, 10, 'JATIRANGGON', '17432', '-6.3393148', '106.9248351');
INSERT INTO `kelurahans` VALUES (48, 10, 'JATISAMPURNA', '17433', '-6.363886', '106.907566');
INSERT INTO `kelurahans` VALUES (49, 11, 'BANTARGEBANG', '17151', '-6.3361741', '106.9746189');
INSERT INTO `kelurahans` VALUES (50, 11, 'CIKETINGUDIK', '17153', '-6.3546456', '106.9785543');
INSERT INTO `kelurahans` VALUES (51, 11, 'CIKIWUL', '17152', '-6.3385602', '106.9763382');
INSERT INTO `kelurahans` VALUES (52, 11, 'SUMURBATU', '17154', '-6.3465231', '107.0009658');
INSERT INTO `kelurahans` VALUES (53, 12, 'CIMUNING', '17155', '-6.322546', '107.0145342');
INSERT INTO `kelurahans` VALUES (54, 12, 'MUSTIKAJAYA', '17158', '-6.2926436', '107.0186552');
INSERT INTO `kelurahans` VALUES (55, 12, 'MUSTIKASARI', '17157', '-6.2912301', '106.9990247');
INSERT INTO `kelurahans` VALUES (56, 12, 'PADURENAN', '17156', '-6.3164821', '106.9968412');

-- ----------------------------
-- Table structure for kostan_jenis_kamars
-- ----------------------------
DROP TABLE IF EXISTS `kostan_jenis_kamars`;
CREATE TABLE `kostan_jenis_kamars`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kostan_id` bigint NULL DEFAULT NULL,
  `kostan_jenis_kamar_deskripsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_jenis_kamar_tarif` double NULL DEFAULT 0,
  `kostan_jenis_kamar_jumlah` int NULL DEFAULT 0,
  `kostan_jenis_kamar_hunian_avg` int NULL DEFAULT 0,
  `kostan_jenis_kamar_potensi_pajak` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kostan_jenis_kamars
-- ----------------------------
INSERT INTO `kostan_jenis_kamars` VALUES (1, 1, 'Standar', 1300000, 14, 9, 14040000);
INSERT INTO `kostan_jenis_kamars` VALUES (3, 3, 'Standar 1', 2200000, 15, 5, 13200000);
INSERT INTO `kostan_jenis_kamars` VALUES (4, 3, 'Standar 2', 2400000, 27, 15, 43200000);
INSERT INTO `kostan_jenis_kamars` VALUES (5, 4, 'NON AC', 60000, 5, 3, 216000);
INSERT INTO `kostan_jenis_kamars` VALUES (6, 4, 'AC', 1200000, 29, 15, 21600000);
INSERT INTO `kostan_jenis_kamars` VALUES (7, 5, 'STANDAR 1', 1150000, 8, 5, 6900000);
INSERT INTO `kostan_jenis_kamars` VALUES (8, 5, 'STANDAR 2', 800000, 8, 5, 4800000);
INSERT INTO `kostan_jenis_kamars` VALUES (9, 5, 'STANDAR 3', 700000, 8, 5, 4200000);
INSERT INTO `kostan_jenis_kamars` VALUES (10, 12, 'STANDAR', 1300000, 14, 9, 14040000);
INSERT INTO `kostan_jenis_kamars` VALUES (11, 13, 'STANDAR', 1300000, 22, 18, 28080000);
INSERT INTO `kostan_jenis_kamars` VALUES (12, 23, 'Flat', 1400000, 15, 8, 13440000);
INSERT INTO `kostan_jenis_kamars` VALUES (13, 24, 'Standar', 150000, 11, 50, 9000000);
INSERT INTO `kostan_jenis_kamars` VALUES (14, 25, 'Standar', 200000, 10, 82, 19680000);
INSERT INTO `kostan_jenis_kamars` VALUES (15, 26, 'Standar', 175000, 12, 162, 34020000);
INSERT INTO `kostan_jenis_kamars` VALUES (16, 27, 'Standar', 1000000, 19, 110, 132000000);
INSERT INTO `kostan_jenis_kamars` VALUES (17, 28, 'Standar', 150000, 30, 36, 6480000);
INSERT INTO `kostan_jenis_kamars` VALUES (18, 29, 'Standar', 170000, 16, 307, 62628000);
INSERT INTO `kostan_jenis_kamars` VALUES (19, 30, 'Standar', 650000, 27, 8, 6240000);
INSERT INTO `kostan_jenis_kamars` VALUES (20, 31, 'Standar', 600000, 28, 7, 5040000);
INSERT INTO `kostan_jenis_kamars` VALUES (21, 32, 'Standar', 1800000, 12, 11, 23760000);
INSERT INTO `kostan_jenis_kamars` VALUES (22, 33, 'Kos', 750000, 10, 7, 6300000);
INSERT INTO `kostan_jenis_kamars` VALUES (23, 34, 'KOS', 750000, 10, 7, 6300000);
INSERT INTO `kostan_jenis_kamars` VALUES (24, 35, 'KOS', 700000, 10, 8, 6720000);
INSERT INTO `kostan_jenis_kamars` VALUES (25, 36, 'KOS', 1050000, 30, 12, 15120000);
INSERT INTO `kostan_jenis_kamars` VALUES (26, 37, 'KOS', 750000, 10, 7, 6300000);
INSERT INTO `kostan_jenis_kamars` VALUES (27, 38, 'SUITE ROOM', 2000000, 1, 0, 0);
INSERT INTO `kostan_jenis_kamars` VALUES (28, 38, 'DELUXE ROOM', 1700000, 4, 0, 0);
INSERT INTO `kostan_jenis_kamars` VALUES (29, 38, 'SUPERIOR ROOM', 1500000, 4, 1, 1800000);

-- ----------------------------
-- Table structure for kostans
-- ----------------------------
DROP TABLE IF EXISTS `kostans`;
CREATE TABLE `kostans`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kostan_pemilik` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_npwpd` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_alamat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `kostan_kecamatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_kelurahan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_rt` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_rw` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_jumlah_pegawai` int NULL DEFAULT NULL,
  `kostan_potensi_pajak` double NULL DEFAULT NULL,
  `kostan_persentase_pajak` double(8, 2) NULL DEFAULT 10,
  `kostan_telepon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_foto` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `status_aktif_id` int NULL DEFAULT 1,
  `kostan_latitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kostan_longitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kostans
-- ----------------------------
INSERT INTO `kostans` VALUES (1, 'FAJAR', '7189237192837', 'NAMOPARA HOUSE', 'PONDOK PEKAYON INDAH BB 17 NO 5 A', 'BEKASI SELATAN', 'JAKAMULYA', '006', '008', 5, 14040000, 10.00, '082210427010', '2021_KOSTAN_0109252021.jpeg', 1, '-6.266584336535263', '106.96190357208253', 1, '2021-09-25 06:39:48', '2021-10-20 10:23:02', '2021-10-20 10:23:02');
INSERT INTO `kostans` VALUES (3, 'GURITNO', '6178236182736812', 'G RESIDENCE', 'JL CHAIRIL ANWAR NO 3-4', 'BEKASI TIMUR', 'DURENJAYA', NULL, NULL, 10, 56400000, 10.00, '02188397462', '2021_KOSTAN_0309252021.jpg', 1, '-6.233394646324949', '107.03095436096193', 1, '2021-09-25 07:08:55', '2021-10-20 10:23:06', '2021-10-20 10:23:06');
INSERT INTO `kostans` VALUES (4, 'TRI NOVIANI', '9876', 'KOST KEISHA', 'KP. KALIMANGGIS', 'JATISAMPURNA', NULL, '1', '3', 30, 21816000, 10.00, '87888093879', NULL, 1, NULL, NULL, 1, '2021-09-26 17:44:27', '2021-10-20 10:23:10', '2021-10-20 10:23:10');
INSERT INTO `kostans` VALUES (5, 'CECEP', '98765', 'KOSAN 11A 11B', 'JL. SMAN 7 NO. II', 'JATISAMPURNA', NULL, NULL, NULL, 30, 15900000, 10.00, '82113517151', NULL, 1, NULL, NULL, 1, '2021-09-26 17:44:27', '2021-10-20 10:23:14', '2021-10-20 10:23:14');
INSERT INTO `kostans` VALUES (12, 'FAJAR', 'P.2.01.0005279.14.01', 'NAMOPARA HOUSE', 'PONDOK PEKAYON INDAH BB 17 NO 5 A', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 14040000, 10.00, '082210427010', 'http://drive.google.com/uc?id=1OjGpY_DDJV79_GOE7LUFcVW8Mqlp1eBi', 1, NULL, NULL, 1, '2021-10-21 13:48:38', '2021-10-22 09:23:33', NULL);
INSERT INTO `kostans` VALUES (13, 'SURAHNO', 'P.2.01.0005038.14.05', 'KAYURINGIN RESIDANCE', 'JL. LELE 2 RT.004/005', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 4, 28080000, 10.00, '02189457810', 'http://drive.google.com/uc?id=1vw-lGONk1CyD5qDFtlVu65fU5Fqi0T5I', 1, NULL, NULL, 1, '2021-10-21 13:48:38', '2021-10-22 09:23:33', NULL);
INSERT INTO `kostans` VALUES (14, 'GURITNO', 'P.2.01.0004749.11.02', 'G RESIDENCE', 'JL CHAIRIL ANWAR NO 3-4', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 4, NULL, 10.00, '02188397462', 'http://drive.google.com/uc?id=1FHeWlY1YGFfocKTl8kQnd2_rk5MWnnMx', 1, '-6.25395', '106.99947', 1, '2021-10-21 13:48:38', '2021-12-27 14:48:13', '2021-12-27 14:48:13');
INSERT INTO `kostans` VALUES (15, 'HENGKIE LIMINTO', 'P.2.01.0004564.18.01', 'BACKPACKER HOME STAY', 'JL. RAYA KRANGGAN RT.02/16', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 2, NULL, 10.00, '081311122128', 'http://drive.google.com/uc?id=1tUuxUbtq1YNxZkEsjYiiScejlSKDS_zS', 1, '-6.37566', '106.91484', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (16, 'TRIJONO', 'P.2.01.0005147.18.05', 'PENGINAPAN D\'BLESSING', 'JL. KRANGGAN PERMAI RAYA NO.82', 'JATISAMPURNA', 'JATI RADEN', NULL, NULL, 3, NULL, 10.00, '085692742890', 'http://drive.google.com/uc?id=16xaiNEcSHT13z3ATPgdJlCrjm4So4WfT', 1, '-6.37566', '106.91484', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (17, 'ASEP SULAIMAN', 'P.2.01.0004563.18.01', 'KOS PONDOK LDE', 'JL. MASJID MIFTAHUL HUDA NOM8', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 0, NULL, 10.00, '081398469899', 'http://drive.google.com/uc?id=1FuUlRn8Xl6KIa1mXKHd4LfJWWd_HgnB5', 1, '-6.37539', '106.9203', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (18, 'TRI NOVIANI', 'P.2.01.0055147.18.05', 'KOST KEISHA', 'KP. KALIMANGGIS, RT.001/RW.003', 'JATISAMPURNA', 'JATIKARYA', NULL, NULL, 0, NULL, 10.00, '087888093879', 'http://drive.google.com/uc?id=1u-UoTtLdOMuCq69IJV-hVINEwtPpeAbA', 1, '-6.37584', '106.9139', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (19, 'HJ. DEDI SOFYAN', 'P.2.01.0005383.11.02', 'KOST DEWI HOUSE', 'JL DEWI SARTIKA NO 23 RT 002 RW 005', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, NULL, 10.00, '081298337143', 'http://drive.google.com/uc?id=1ANLIh96lJ2R4x3k0klKtUlhMjVOE1goM', 1, '-6.251072', '107.0030481', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (20, 'BAMBANG', 'P.2.01.0005331.11.02', 'KOST RATU', 'JL RAWA SEMUT RT 03 RW 12', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, NULL, 10.00, '082211147772', 'http://drive.google.com/uc?id=1eimCboChWIsenLdnlp4EUTAcR9y2_Nnh', 1, '-6.251072', '107.0030481', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (21, 'CECEP', 'P.2.01.0004538.18.01', 'KOSAN 11A 11B', 'JL. SMAN 7 NO. II', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 2, NULL, 10.00, '082113517151', 'http://drive.google.com/uc?id=1yddgmLRAOvZHV7TsI9qub1RPjm898qFw', 1, '-6.36641', '106.92189', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (22, 'AHMAD NASRUDIN', 'P.2.01.0004565.18.01', 'KOST NAYRA', 'JL. SEPAKAT RT 02/07', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 1, NULL, 10.00, '087780482689', 'http://drive.google.com/uc?id=1rSINbPhFHhzTauf4LXrIbbYczrfvdL4I', 1, '-6.363886', '106.907566', 1, '2021-10-21 13:48:38', '2021-10-21 13:48:38', NULL);
INSERT INTO `kostans` VALUES (23, 'Guritno', 'P.2.01.0004749.11.02', 'G Residence', 'JL. CHAIRIL ANWAR NO. 3-4 MARGAHAYU BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '02', '04', 1, 13440000, 10.00, '02188397462', '2021_KOSTAN_02312212021.jpg', 1, '-6.25395', '106.99947', 10, '2021-12-21 11:30:38', '2021-12-21 11:39:14', NULL);
INSERT INTO `kostans` VALUES (24, 'AGNES DIANA SUSANTI', 'P.2.01.0005287.22.03', 'WISMA MELATI 71', 'KOMP. WISMA MELATI JL. YUDISTIRA 29', 'PONDOKMELATI', 'JATIWARNA', '08', '005', 2, 9000000, 10.00, NULL, NULL, 4, NULL, NULL, 20, '2022-01-07 09:34:00', '2022-01-19 10:01:55', NULL);
INSERT INTO `kostans` VALUES (25, 'ANI WULYANI WULANDARI', 'P.2.01.0004397.22.03', 'KOST ANCA HOUSE', 'JL.MASJID ASRORUL HUDA GG.H.SHOLEH 1', 'PONDOKMELATI', 'JATIWARNA', NULL, NULL, 1, 19680000, 10.00, NULL, NULL, 4, NULL, NULL, 20, '2022-01-07 11:30:39', '2022-01-07 11:30:39', NULL);
INSERT INTO `kostans` VALUES (26, 'H.EDDY PURWANTO', 'P.2.01.0004522.22.04', 'RUMAH KOST DAD & MAM', 'JL.RAYA HANKAM', 'PONDOKMELATI', 'JATIMURNI', '004', '005', 1, 34020000, 10.00, NULL, NULL, 4, NULL, NULL, 20, '2022-01-07 11:35:22', '2022-01-07 11:35:22', NULL);
INSERT INTO `kostans` VALUES (27, 'andhi', 'P.2.01.0004727.20.03', 'kenanga kost', 'JL KENANGA INDAH BLOK IA NO 20 HARAPAN INDAH', 'MEDANSATRIA', 'PEJUANG', '00', '00', 2, 132000000, 10.00, '081270281156', NULL, 4, NULL, NULL, 16, '2022-01-07 13:17:48', '2022-01-07 13:17:48', NULL);
INSERT INTO `kostans` VALUES (28, 'RUDY WIJAYA', 'P.2.01.0004859.12.05', 'KOS KOSAN TUNAS PLAZA', 'KP.DUA RT.010 RW.003', 'BEKASI BARAT', 'JAKASAMPURNA', '010', '003', 17, 6480000, 10.00, '082122040340', '2022_KOSTAN_02802112022.jpg', 1, '-6.2299817054481945', '106.96254730224611', 11, '2022-02-11 10:39:26', '2022-04-13 13:12:34', NULL);
INSERT INTO `kostans` VALUES (29, 'HERMAN WIJAYA', 'P.2.01.0005132.12.05', 'PENGINAPAN BRO N SIS', 'JALAN BUKIT BARISAN RT 06 / 09', 'BEKASI BARAT', 'JAKASAMPURNA', '006', '009', 11, 62628000, 10.00, '081219430558', '2022_KOSTAN_02902142022.jpg', 1, '-6.2299817054481945', '106.97559356689455', 11, '2022-02-14 11:28:44', '2022-04-13 13:13:34', NULL);
INSERT INTO `kostans` VALUES (30, 'FICO S RESIDENCE KOS KOSAN / ENDRU', 'P.2.01.0004838.12.05', 'FICO S RESIDENCE KOS KOSAN', 'JL.CEMARA RAYA NO.2', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 2, 6240000, 10.00, '081389869290', '2022_KOSTAN_03002152022.jpg', 1, '-6.2299817054481945', '106.97971343994142', 11, '2022-02-14 15:12:02', '2022-04-13 13:17:48', NULL);
INSERT INTO `kostans` VALUES (31, 'YUDI DJAHURI', 'P.2.01.0004837.12.05', 'KOS GALAXY A72', 'JL.TANGGUPAN PERAHU KAV.A72', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 3, 5040000, 10.00, '082122040340', '2022_KOSTAN_03102152022.jpg', 1, '-6.227251336767157', '106.97696685791017', 11, '2022-02-14 15:33:48', '2022-04-13 13:18:05', NULL);
INSERT INTO `kostans` VALUES (32, 'WILIAM SUHARTO SULAIMAN', 'P.2.01.0004780.12.05', 'KOST SYARIAH', 'GRAHA IMAN JL.TEMBUS KALIMALANG NO.1', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 2, 23760000, 10.00, '08999343491', '2022_KOSTAN_03202152022.jpg', 1, '-6.2258861471022175', '106.97422027587892', 11, '2022-02-15 09:42:08', '2022-04-13 13:18:21', NULL);
INSERT INTO `kostans` VALUES (33, 'Didin Muhtadin', 'p.2.01.0004643.13.04', 'Kos Serasi', 'VILLA INDAH PERMAI 07 NO 03 RT.003 RW.033 , TELUK PUCUNG BEKASI UTARA', 'BEKASI UTARA', 'TELUK PUCUNG', '03', '033', 1, 6300000, 10.00, '089636772699', NULL, 1, '-6.206431809166715', '106.98778152465822', 14, '2022-03-21 10:34:32', '2022-05-31 08:51:48', NULL);
INSERT INTO `kostans` VALUES (34, 'AHMAD SOFIAN', 'P.2.01.0004583.13.04', 'KOS GAMUR', 'JL.H.GAMUR KP.IRIAN RT.010 RW.04', 'BEKASI UTARA', 'TELUK PUCUNG', '04', '10', 2, 6300000, 10.00, '0816100563', NULL, 1, '-6.214623197035776', '107.01335906982422', 14, '2022-03-21 11:14:11', '2022-05-31 08:52:35', NULL);
INSERT INTO `kostans` VALUES (35, 'H.JAMAL UKAR', 'P.2.01.0004757.13.05', 'KOS.PUTRA UKAR MANDIRI', ': JL.PERJUANGAN GG.RAHAYU RT.004 RW.001', 'BEKASI UTARA', 'MARGAMULYA', '004', '001', 2, 6720000, 10.00, '08990076892', NULL, 1, NULL, NULL, 14, '2022-03-21 11:26:39', '2022-05-31 08:53:37', NULL);
INSERT INTO `kostans` VALUES (36, 'SUKAMTO MARTONO', 'P.2.01.0005338.13.02', 'RUMAH KOS SUKAMTO', 'JL. DAMAI IV NO. 5 RT. 003 RW. 020', 'BEKASI UTARA', 'PERWIRA', '003', '020', 2, 15120000, 10.00, '08129898201', NULL, 1, NULL, NULL, 14, '2022-03-21 11:39:14', '2022-05-31 08:54:19', NULL);
INSERT INTO `kostans` VALUES (37, 'HENDRIK', 'P.2.01.0004573.13.05', 'RUMAH PENGINAPAN HENDRIK', ': JL.PERJUANGAN NO.20', 'BEKASI UTARA', 'MARGAMULYA', NULL, NULL, 1, 6300000, 10.00, NULL, NULL, 1, NULL, NULL, 14, '2022-03-21 11:59:34', '2022-05-31 08:54:45', NULL);
INSERT INTO `kostans` VALUES (38, 'M. ZAENAL ARIFIN', 'P.2.01.0005383.11.02', 'DEWI HOUSE', 'JL.DEWI SARTIKA NO. 23 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '002', '005', 3, 1800000, 10.00, '0812-9833-7143', '2022_KOSTAN_03804182022.jpg', 4, '-6.254341084145042', '107.00469553470613', 10, '2022-04-18 10:48:01', '2022-04-18 10:50:34', NULL);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2021_07_07_143217_create_roles_table', 1);
INSERT INTO `migrations` VALUES (4, '2021_07_07_143953_create_accesses_table', 1);
INSERT INTO `migrations` VALUES (5, '2021_07_07_144017_create_role_features_table', 1);
INSERT INTO `migrations` VALUES (6, '2021_07_08_162422_create_user_accesses_table', 2);
INSERT INTO `migrations` VALUES (7, '2021_07_08_201239_alter_table_roles_add_color', 3);
INSERT INTO `migrations` VALUES (8, '2021_07_22_163957_create_pemohons_table', 4);
INSERT INTO `migrations` VALUES (9, '2021_07_22_164059_create_rencana_penggunaans_table', 4);
INSERT INTO `migrations` VALUES (10, '2021_07_22_164134_create_krks_table', 4);
INSERT INTO `migrations` VALUES (11, '2021_07_22_164144_create_krk_rjs_table', 4);
INSERT INTO `migrations` VALUES (12, '2021_07_22_164158_create_krk_gsbs_table', 4);
INSERT INTO `migrations` VALUES (13, '2021_07_22_164208_create_tapaks_table', 4);
INSERT INTO `migrations` VALUES (14, '2021_07_22_164221_create_rekomteks_table', 4);
INSERT INTO `migrations` VALUES (15, '2021_07_22_164236_create_prtbs_table', 4);
INSERT INTO `migrations` VALUES (16, '2021_07_22_164356_create_rhtls_table', 4);
INSERT INTO `migrations` VALUES (17, '2021_07_23_180338_create_kecamatans_table', 5);
INSERT INTO `migrations` VALUES (18, '2021_07_23_180400_create_kelurahans_table', 5);
INSERT INTO `migrations` VALUES (20, '2021_07_27_090626_alter_krks_add_rj_gsb', 6);
INSERT INTO `migrations` VALUES (21, '2021_07_27_092326_alter_kelurahans_add_kode_pos', 7);
INSERT INTO `migrations` VALUES (22, '2021_07_27_143812_alter_krks_add_created_by', 8);
INSERT INTO `migrations` VALUES (23, '2021_07_29_031138_create_krk_intensitas_pemanfaatan_ruangs_table', 9);
INSERT INTO `migrations` VALUES (25, '2021_07_30_224214_alter_table_tapaks_add_luas_awal', 10);
INSERT INTO `migrations` VALUES (26, '2021_11_04_204932_alter_table_restorans_add_status_tapping_box', 11);
INSERT INTO `migrations` VALUES (27, '2021_11_04_213252_alter_table_restorans_add_persentasi_pajak', 11);
INSERT INTO `migrations` VALUES (28, '2021_11_04_214818_alter_table_hotels_add_persentasi_pajak', 11);
INSERT INTO `migrations` VALUES (29, '2021_11_04_215020_alter_table_kostans_add_persentasi_pajak', 11);
INSERT INTO `migrations` VALUES (30, '2021_11_04_215343_alter_table_rusuns_add_persentasi_pajak', 11);
INSERT INTO `migrations` VALUES (31, '2021_11_04_215607_create_status_aktifs_table', 11);
INSERT INTO `migrations` VALUES (32, '2021_11_05_004257_create_user_logs_table', 11);
INSERT INTO `migrations` VALUES (33, '2021_11_26_141917_create_persentase_pajak', 11);
INSERT INTO `migrations` VALUES (34, '2022_07_24_215354_create_hiburan_kategoris_table', 12);
INSERT INTO `migrations` VALUES (35, '2022_07_24_215458_create_hiburans_table', 12);
INSERT INTO `migrations` VALUES (36, '2022_07_24_215748_create_hiburan_jenises_table', 12);
INSERT INTO `migrations` VALUES (37, '2022_07_24_221709_create_hiburan_jenis_ruangans_table', 12);
INSERT INTO `migrations` VALUES (38, '2022_07_24_224030_create_hiburan_tingkat_kunjungan_avgs_table', 12);
INSERT INTO `migrations` VALUES (39, '2022_07_24_225938_alter_hiburan_kategori_add_persentase', 13);
INSERT INTO `migrations` VALUES (40, '2022_07_24_231440_alter_hiburans_add_timestamps', 14);
INSERT INTO `migrations` VALUES (41, '2022_07_25_003350_alter_hiburans_add_have_ruangan', 15);
INSERT INTO `migrations` VALUES (42, '2022_07_25_003600_alter_hiburan_jenises_add_have_ruangan', 16);
INSERT INTO `migrations` VALUES (43, '2022_07_25_010128_alter_hiburan_jenises_add_slug', 17);
INSERT INTO `migrations` VALUES (44, '2022_07_25_012742_alter_hiburan_tingkat_kunjungan_add_situasi', 18);
INSERT INTO `migrations` VALUES (45, '2022_07_25_014134_alter_hiburans_rename_jumlah', 19);
INSERT INTO `migrations` VALUES (46, '2022_07_25_033527_alter_hiburan_jenises_add_icon', 20);
INSERT INTO `migrations` VALUES (47, '2022_08_01_193654_alter_hiburans_rename_situasi', 21);
INSERT INTO `migrations` VALUES (48, '2022_08_01_204220_alter_hiburans_add_jam_operasional', 22);
INSERT INTO `migrations` VALUES (49, '2022_08_04_031618_create_hiburan_jenises_add_multiple_htm', 23);
INSERT INTO `migrations` VALUES (50, '2022_08_04_041401_alter_hiburan_tarif_add_unique', 24);
INSERT INTO `migrations` VALUES (51, '2022_08_05_023450_alter_hiburans_add_hiburan_durasi_avg', 25);
INSERT INTO `migrations` VALUES (52, '2022_08_05_024123_alter_hiburan_jenises_add_durasi_unit', 26);
INSERT INTO `migrations` VALUES (53, '2022_08_05_035219_create_parkirs_table', 27);
INSERT INTO `migrations` VALUES (54, '2022_08_05_041557_alter_parkirs_add_potensi_motor_mobil', 28);
INSERT INTO `migrations` VALUES (55, '2022_08_05_055510_alter_parkirs_add_timestamp', 29);

-- ----------------------------
-- Table structure for parkir_tingkat_kunjungan_avgs
-- ----------------------------
DROP TABLE IF EXISTS `parkir_tingkat_kunjungan_avgs`;
CREATE TABLE `parkir_tingkat_kunjungan_avgs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parkir_id` bigint NULL DEFAULT NULL,
  `mobil_situasi_kunjungan_sepi` int NULL DEFAULT NULL,
  `mobil_situasi_kunjungan_normal` int NULL DEFAULT NULL,
  `mobil_situasi_kunjungan_ramai` int NULL DEFAULT NULL,
  `mobil_avg_kunjungan_sepi` double NULL DEFAULT NULL,
  `mobil_avg_kunjungan_normal` double NULL DEFAULT NULL,
  `mobil_avg_kunjungan_ramai` double NULL DEFAULT NULL,
  `motor_situasi_kunjungan_sepi` int NULL DEFAULT NULL,
  `motor_situasi_kunjungan_normal` int NULL DEFAULT NULL,
  `motor_situasi_kunjungan_ramai` int NULL DEFAULT NULL,
  `motor_avg_kunjungan_sepi` double NULL DEFAULT NULL,
  `motor_avg_kunjungan_normal` double NULL DEFAULT NULL,
  `motor_avg_kunjungan_ramai` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of parkir_tingkat_kunjungan_avgs
-- ----------------------------
INSERT INTO `parkir_tingkat_kunjungan_avgs` VALUES (1, 1, 200, 100, 65, 200, 432, 678, 200, 100, 65, 321, 555, 876);

-- ----------------------------
-- Table structure for parkirs
-- ----------------------------
DROP TABLE IF EXISTS `parkirs`;
CREATE TABLE `parkirs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parkir_pemilik` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_npwpd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_kecamatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_kelurahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_rt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_rw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_srp_motor` int NULL DEFAULT NULL,
  `parkir_srp_mobil` int NULL DEFAULT NULL,
  `parkir_tarif_motor` int NULL DEFAULT NULL,
  `parkir_tarif_mobil` int NULL DEFAULT NULL,
  `parkir_durasi_avg` double(8, 2) NULL DEFAULT NULL,
  `parkir_potensi_pajak` double NULL DEFAULT NULL,
  `parkir_potensi_pajak_mobil` double NULL DEFAULT NULL,
  `parkir_potensi_pajak_motor` double NULL DEFAULT NULL,
  `parkir_persentase_pajak` double NULL DEFAULT NULL,
  `parkir_telepon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_foto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `parkir_latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parkir_longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status_aktif_id` int NULL DEFAULT 1,
  `created_by` int NULL DEFAULT NULL,
  `updated_by` int NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of parkirs
-- ----------------------------
INSERT INTO `parkirs` VALUES (1, 'John cenas', '71829738912738912783', 'Parkir BEC', 'KOMP. GBI BLOK G6', 'JATISAMPURNA', 'JATIRANGGA', '07', '08', 40, 50, 2000, 5000, 6.00, 593778000, 381810000, 211968000, 10, '087811727722', '2022_PARKIR_0108052022.jpg', '-6.35897532723566', '106.92684173583984', 1, 1, NULL, NULL, '2022-08-05 05:55:53', '2022-08-05 05:57:11');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for persentase_pajaks
-- ----------------------------
DROP TABLE IF EXISTS `persentase_pajaks`;
CREATE TABLE `persentase_pajaks`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `persentase` double(8, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of persentase_pajaks
-- ----------------------------
INSERT INTO `persentase_pajaks` VALUES (1, 10.00);

-- ----------------------------
-- Table structure for restoran_klasifikasis
-- ----------------------------
DROP TABLE IF EXISTS `restoran_klasifikasis`;
CREATE TABLE `restoran_klasifikasis`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `restoran_klasifikasi_deskripsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of restoran_klasifikasis
-- ----------------------------
INSERT INTO `restoran_klasifikasis` VALUES (1, 'Atas');
INSERT INTO `restoran_klasifikasis` VALUES (2, 'Menengah');
INSERT INTO `restoran_klasifikasis` VALUES (3, 'Kecil');
INSERT INTO `restoran_klasifikasis` VALUES (4, '1');
INSERT INTO `restoran_klasifikasis` VALUES (5, NULL);
INSERT INTO `restoran_klasifikasis` VALUES (9, 'DSV');
INSERT INTO `restoran_klasifikasis` VALUES (10, 'A');
INSERT INTO `restoran_klasifikasis` VALUES (11, 'ASDG');
INSERT INTO `restoran_klasifikasis` VALUES (12, 'SS');
INSERT INTO `restoran_klasifikasis` VALUES (13, 'BAWAH');

-- ----------------------------
-- Table structure for restoran_tingkat_kunjungan_avgs
-- ----------------------------
DROP TABLE IF EXISTS `restoran_tingkat_kunjungan_avgs`;
CREATE TABLE `restoran_tingkat_kunjungan_avgs`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `restoran_id` bigint NULL DEFAULT NULL,
  `situasi_kunjungan_sepi` int NULL DEFAULT 0,
  `situasi_kunjungan_normal` int NULL DEFAULT 0,
  `situasi_kunjungan_ramai` int NULL DEFAULT 0,
  `avg_kunjungan_sepi` double NULL DEFAULT 0,
  `avg_kunjungan_normal` double NULL DEFAULT 0,
  `avg_kunjungan_ramai` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2305 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of restoran_tingkat_kunjungan_avgs
-- ----------------------------
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (457, 457, 133, 120, 112, 6, 24, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (458, 458, 125, 125, 115, 11, 20, 27);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (459, 459, 165, 120, 80, 12, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (460, 460, 35, 130, 200, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (461, 461, 30, 150, 185, 50, 230, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (462, 462, 67, 83, 215, 10, 30, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (463, 463, 40, 185, 140, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (464, 464, 73, 100, 192, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (465, 465, 65, 250, 50, 28, 70, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (466, 466, 75, 200, 90, 20, 50, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (467, 467, 90, 100, 175, 30, 120, 170);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (468, 468, 209, 96, 60, 65, 90, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (469, 469, 85, 120, 160, 170, 300, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (470, 470, 50, 147, 168, 600, 915, 1250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (471, 471, 90, 200, 75, 8, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (472, 472, 67, 100, 198, 50, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (473, 473, 168, 100, 97, 12, 55, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (474, 474, 269, 0, 96, 5, 0, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (475, 475, 33, 232, 100, 50, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (476, 476, 30, 150, 250, 27, 125, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (477, 477, 65, 125, 175, 16, 28, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (478, 478, 150, 115, 100, 5, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (479, 479, 101, 120, 144, 18, 29, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (480, 480, 60, 105, 200, 10, 50, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (481, 481, 14, 264, 87, 70, 109, 135);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (482, 482, 134, 135, 96, 77, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (483, 483, 169, 250, 400, 10, 120, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (484, 484, 70, 150, 350, 15, 120, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (485, 485, 48, 197, 120, 40, 70, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (486, 486, 95, 106, 164, 40, 65, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (487, 487, 138, 395, 712, 10, 250, 330);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (488, 488, 25, 75, 100, 7, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (489, 489, 318, 40, 7, 10, 30, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (490, 490, 144, 120, 101, 55, 80, 135);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (491, 491, 70, 120, 175, 25, 50, 102);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (492, 492, 30, 120, 140, 30, 70, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (493, 493, 27, 242, 96, 60, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (494, 494, 126, 90, 149, 65, 98, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (495, 495, 95, 250, 500, 20, 150, 280);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (496, 496, 66, 121, 178, 46, 60, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (497, 497, 61, 160, 144, 40, 50, 116);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (498, 498, 95, 250, 310, 20, 200, 315);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (499, 499, 80, 165, 120, 11, 20, 37);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (500, 500, 89, 116, 160, 15, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (501, 501, 0, 0, 6, 0, 0, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (502, 502, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (503, 503, 67, 128, 170, 11, 23, 33);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (504, 504, 244, 0, 121, 10, 0, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (505, 505, 179, 0, 96, 20, 0, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (506, 506, 221, 96, 48, 35, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (507, 507, 245, 96, 24, 5, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (508, 508, 192, 77, 96, 30, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (509, 509, 122, 144, 99, 10, 20, 31);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (510, 510, 24, 293, 48, 44, 50, 104);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (511, 511, 25, 280, 60, 40, 150, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (512, 512, 96, 195, 74, 110, 135, 255);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (513, 513, 150, 152, 63, 4, 10, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (514, 514, 221, 48, 96, 150, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (515, 515, 80, 225, 60, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (516, 516, 48, 47, 25, 15, 30, 48);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (517, 517, 59, 208, 98, 125, 300, 926);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (518, 518, 98, 208, 59, 60, 100, 260);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (519, 519, 193, 100, 72, 4, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (520, 520, 96, 168, 101, 50, 200, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (521, 521, 192, 75, 98, 80, 100, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (522, 522, 216, 48, 101, 30, 80, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (523, 523, 106, 105, 154, 20, 36, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (524, 524, 317, 0, 48, 10, 0, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (525, 525, 25, 240, 100, 90, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (526, 526, 99, 140, 126, 23, 38, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (527, 527, 60, 225, 80, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (528, 528, 82, 56, 112, 27, 48, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (529, 529, 88, 181, 96, 40, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (530, 530, 52, 217, 96, 41, 125, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (531, 531, 192, 72, 101, 45, 90, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (532, 532, 221, 48, 96, 19, 30, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (533, 533, 98, 159, 108, 79, 91, 123);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (534, 534, 112, 102, 151, 7, 15, 28);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (535, 535, 0, 253, 112, 0, 200, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (536, 536, 95, 130, 120, 40, 60, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (537, 537, 97, 104, 164, 16, 28, 59);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (538, 538, 150, 125, 90, 53, 125, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (539, 539, 90, 150, 125, 30, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (540, 540, 80, 135, 150, 10, 17, 48);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (541, 541, 17, 24, 55, 80, 158, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (542, 542, 48, 205, 112, 100, 160, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (543, 543, 70, 160, 135, 10, 20, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (544, 544, 65, 146, 154, 49, 67, 87);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (545, 545, 105, 100, 160, 20, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (546, 546, 35, 56, 67, 97, 117, 168);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (547, 547, 85, 106, 174, 35, 50, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (548, 548, 115, 100, 150, 15, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (549, 549, 89, 109, 167, 27, 46, 69);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (550, 550, 52, 56, 83, 20, 35, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (551, 551, 200, 130, 35, 50, 300, 700);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (552, 552, 65, 120, 180, 10, 40, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (553, 553, 36, 148, 181, 110, 150, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (554, 554, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (555, 555, 65, 80, 220, 30, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (556, 556, 120, 159, 86, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (557, 557, 105, 168, 92, 20, 40, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (558, 558, 61, 192, 112, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (559, 559, 105, 100, 160, 10, 25, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (560, 560, 48, 231, 86, 50, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (561, 561, 192, 61, 112, 8, 15, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (562, 562, 45, 170, 150, 38, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (563, 563, 96, 105, 164, 78, 90, 112);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (564, 564, 70, 104, 191, 20, 46, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (565, 565, 174, 75, 116, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (566, 566, 75, 150, 140, 30, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (567, 567, 45, 120, 200, 100, 230, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (568, 568, 50, 115, 200, 100, 600, 1000);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (569, 569, 149, 96, 120, 15, 25, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (570, 570, 92, 124, 149, 90, 156, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (571, 571, 105, 140, 120, 10, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (572, 572, 135, 70, 160, 10, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (573, 573, 48, 207, 110, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (574, 574, 40, 115, 210, 30, 250, 370);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (575, 575, 51, 135, 179, 80, 110, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (576, 576, 195, 70, 100, 20, 60, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (577, 577, 45, 170, 150, 20, 70, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (578, 578, 0, 221, 144, 0, 75, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (579, 579, 55, 160, 150, 15, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (580, 580, 81, 158, 126, 30, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (581, 581, 233, 36, 96, 45, 75, 144);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (582, 582, 55, 150, 160, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (583, 583, 55, 135, 175, 30, 50, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (584, 584, 53, 121, 191, 80, 100, 137);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (585, 585, 60, 193, 112, 20, 80, 140);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (586, 586, 52, 218, 95, 15, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (587, 587, 82, 121, 162, 48, 63, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (588, 588, 125, 110, 130, 7, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (589, 589, 221, 48, 96, 10, 20, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (590, 590, 88, 156, 121, 25, 54, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (591, 591, 55, 150, 160, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (592, 592, 109, 121, 135, 6, 17, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (593, 593, 99, 102, 164, 19, 33, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (594, 594, 65, 160, 140, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (595, 595, 55, 140, 170, 50, 100, 175);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (596, 596, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (597, 597, 185, 80, 40, 10, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (598, 598, 115, 130, 120, 15, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (599, 599, 70, 165, 130, 5, 10, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (600, 600, 120, 185, 60, 8, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (601, 601, 55, 160, 150, 20, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (602, 602, 50, 140, 175, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (603, 603, 171, 96, 98, 4, 9, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (604, 604, 155, 90, 120, 20, 35, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (605, 605, 109, 144, 112, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (606, 606, 45, 150, 170, 50, 80, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (607, 607, 78, 229, 58, 31, 44, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (608, 608, 60, 160, 145, 30, 60, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (609, 609, 170, 10, 2, 20, 50, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (610, 610, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (611, 611, 55, 190, 120, 50, 84, 102);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (612, 612, 29, 141, 124, 20, 70, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (613, 613, 160, 105, 100, 7, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (614, 614, 77, 124, 164, 23, 52, 88);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (615, 615, 128, 40, 160, 30, 79, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (616, 616, 160, 150, 55, 5, 11, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (617, 617, 108, 120, 137, 30, 44, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (618, 618, 103, 104, 158, 20, 33, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (619, 619, 50, 155, 160, 10, 20, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (620, 620, 98, 103, 164, 40, 54, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (621, 621, 75, 150, 140, 30, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (622, 622, 221, 48, 96, 20, 35, 44);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (623, 623, 35, 160, 170, 50, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (624, 624, 72, 245, 48, 5, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (625, 625, 30, 155, 180, 40, 90, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (626, 626, 65, 165, 135, 28, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (627, 627, 173, 132, 60, 15, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (628, 628, 65, 170, 130, 6, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (629, 629, 48, 220, 97, 45, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (630, 630, 125, 130, 110, 8, 15, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (631, 631, 95, 145, 125, 10, 30, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (632, 632, 155, 90, 120, 60, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (633, 633, 106, 121, 138, 20, 46, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (634, 634, 221, 48, 96, 20, 35, 44);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (635, 635, 70, 165, 130, 100, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (636, 636, 125, 108, 132, 8, 17, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (637, 637, 192, 61, 112, 50, 70, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (638, 638, 123, 95, 147, 10, 21, 33);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (639, 639, 169, 96, 100, 35, 55, 97);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (640, 640, 110, 125, 130, 4, 10, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (641, 641, 253, 0, 112, 10, 0, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (642, 642, 72, 102, 191, 30, 55, 145);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (643, 643, 253, 0, 112, 10, 0, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (644, 644, 96, 184, 85, 12, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (645, 645, 240, 25, 90, 50, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (646, 646, 83, 129, 153, 53, 80, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (647, 647, 48, 173, 144, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (648, 648, 180, 84, 101, 12, 28, 47);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (649, 649, 265, 52, 48, 40, 75, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (650, 650, 97, 153, 115, 10, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (651, 651, 0, 253, 112, 0, 90, 140);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (652, 652, 72, 106, 187, 76, 90, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (653, 653, 269, 96, 0, 30, 70, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (654, 654, 216, 48, 101, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (655, 655, 269, 0, 96, 10, 0, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (656, 656, 245, 0, 120, 5, 0, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (657, 657, 70, 160, 135, 40, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (658, 658, 128, 185, 52, 3, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (659, 659, 109, 144, 112, 30, 60, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (660, 660, 77, 153, 135, 40, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (661, 661, 150, 155, 60, 10, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (662, 662, 52, 153, 160, 70, 85, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (663, 663, 161, 144, 60, 20, 30, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (664, 664, 88, 152, 125, 6, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (665, 665, 58, 185, 122, 8, 18, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (666, 666, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (667, 667, 192, 24, 149, 120, 190, 240);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (668, 668, 169, 96, 100, 85, 100, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (669, 669, 253, 0, 112, 7, 0, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (670, 670, 126, 127, 112, 20, 45, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (671, 671, 253, 0, 112, 10, 0, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (672, 672, 221, 0, 144, 15, 0, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (673, 673, 168, 96, 101, 25, 45, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (674, 674, 0, 305, 60, 0, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (675, 675, 48, 197, 120, 100, 130, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (676, 676, 265, 4, 96, 40, 50, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (677, 677, 0, 0, 365, 0, 0, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (678, 678, 0, 253, 112, 0, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (679, 679, 18, 58, 89, 27, 40, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (680, 680, 53, 198, 114, 10, 25, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (681, 681, 215, 100, 50, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (682, 682, 0, 209, 156, 0, 100, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (683, 683, 157, 108, 100, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (684, 684, 300, 0, 0, 10, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (685, 685, 187, 102, 76, 3, 7, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (686, 686, 65, 144, 156, 15, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (687, 687, 29, 192, 144, 12, 30, 42);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (688, 688, 131, 63, 171, 18, 30, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (689, 689, 84, 152, 129, 10, 22, 48);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (690, 690, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (691, 691, 120, 155, 90, 40, 50, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (692, 692, 48, 219, 98, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (693, 693, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (694, 694, 265, 0, 100, 400, 0, 700);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (695, 695, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (696, 696, 96, 269, 0, 15, 30, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (697, 697, 126, 129, 110, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (698, 698, 269, 0, 96, 5, 0, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (699, 699, 110, 79, 176, 6, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (700, 700, 109, 144, 112, 40, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (701, 701, 63, 174, 128, 35, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (702, 702, 109, 144, 112, 50, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (703, 703, 48, 182, 135, 100, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (704, 704, 52, 167, 146, 45, 55, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (705, 705, 96, 157, 112, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (706, 706, 220, 0, 20, 10, 0, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (707, 707, 140, 65, 160, 22, 34, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (708, 708, 317, 0, 48, 5, 0, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (709, 709, 305, 0, 60, 5, 0, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (710, 710, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (711, 711, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (712, 712, 48, 201, 116, 35, 55, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (713, 713, 96, 168, 101, 60, 110, 170);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (714, 714, 160, 48, 97, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (715, 715, 96, 157, 112, 15, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (716, 716, 305, 0, 60, 15, 0, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (717, 717, 305, 0, 0, 20, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (718, 718, 0, 0, 365, 0, 0, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (719, 719, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (720, 720, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (721, 721, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (722, 722, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (723, 723, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (724, 724, 85, 125, 155, 40, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (725, 725, 109, 144, 112, 30, 90, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (726, 726, 0, 365, 0, 0, 25, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (727, 727, 157, 96, 112, 20, 50, 101);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (728, 728, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (729, 729, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (730, 730, 50, 165, 150, 5, 15, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (731, 731, 144, 130, 101, 35, 65, 170);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (732, 732, 73, 153, 139, 19, 30, 58);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (733, 733, 48, 121, 101, 10, 33, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (734, 734, 90, 148, 127, 24, 35, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (735, 735, 48, 167, 150, 7, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (736, 736, 92, 125, 148, 29, 38, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (737, 737, 48, 197, 120, 50, 65, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (738, 738, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (739, 739, 221, 48, 96, 0, 500, 1500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (740, 740, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (741, 741, 77, 144, 144, 100, 200, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (878, 878, 65, 140, 160, 40, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (879, 879, 55, 135, 175, 40, 60, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (880, 880, 95, 100, 170, 25, 50, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (881, 881, 60, 160, 145, 30, 70, 265);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (882, 882, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (883, 883, 30, 160, 175, 30, 150, 190);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (884, 884, 75, 150, 140, 4, 8, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (885, 885, 65, 130, 170, 150, 300, 800);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (886, 886, 65, 110, 190, 30, 70, 112);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (887, 887, 98, 151, 116, 45, 60, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (888, 888, 235, 0, 130, 30, 0, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (889, 889, 96, 154, 115, 60, 90, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (890, 890, 0, 253, 112, 0, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (891, 891, 205, 0, 160, 20, 0, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (892, 892, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (893, 893, 301, 0, 64, 10, 0, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (894, 894, 48, 214, 103, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (895, 895, 48, 287, 30, 100, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (896, 896, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (897, 897, 78, 227, 60, 20, 35, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (898, 898, 253, 0, 112, 60, 0, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (899, 899, 56, 193, 116, 90, 365, 420);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (900, 900, 0, 253, 112, 0, 50, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (901, 901, 48, 162, 155, 100, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (902, 902, 305, 0, 60, 30, 0, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (903, 903, 175, 90, 40, 4, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (904, 904, 132, 68, 165, 27, 49, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (905, 905, 68, 158, 139, 61, 270, 320);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (906, 906, 165, 120, 70, 86, 150, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (907, 907, 134, 64, 167, 80, 150, 220);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (908, 908, 0, 216, 149, 0, 80, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (909, 909, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (910, 910, 0, 173, 192, 0, 45, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (911, 911, 148, 79, 138, 80, 370, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (912, 912, 53, 131, 181, 40, 230, 320);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (937, 937, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (938, 938, 48, 221, 96, 15, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (939, 939, 269, 0, 96, 40, 0, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (940, 940, 144, 122, 99, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (941, 941, 155, 113, 97, 45, 80, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (942, 942, 310, 0, 55, 10, 0, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (943, 943, 48, 219, 98, 60, 80, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (944, 944, 192, 75, 98, 20, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (945, 945, 0, 265, 100, 0, 250, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (946, 946, 66, 135, 164, 30, 45, 105);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (947, 947, 0, 96, 144, 0, 79, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (948, 948, 64, 120, 181, 30, 45, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (949, 949, 31, 70, 60, 18, 27, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (950, 950, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (951, 951, 80, 154, 131, 30, 45, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (952, 952, 189, 45, 131, 18, 25, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (953, 953, 269, 96, 0, 45, 95, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (954, 954, 164, 74, 127, 35, 55, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (955, 955, 265, 0, 100, 40, 0, 105);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (956, 956, 75, 159, 131, 30, 44, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (957, 957, 88, 101, 176, 27, 55, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (958, 958, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (959, 959, 91, 105, 169, 45, 75, 96);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (965, 965, 96, 120, 149, 70, 85, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (966, 966, 99, 176, 90, 25, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (967, 967, 29, 144, 192, 25, 49, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (968, 968, 80, 225, 0, 30, 65, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (969, 969, 240, 110, 15, 5, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (970, 970, 96, 96, 173, 45, 80, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (971, 971, 131, 83, 151, 17, 30, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (972, 972, 200, 130, 20, 15, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (973, 973, 113, 90, 162, 40, 75, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (974, 974, 96, 77, 192, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (975, 975, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (976, 976, 157, 77, 131, 27, 45, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (977, 977, 114, 149, 102, 47, 65, 115);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (978, 978, 151, 87, 127, 15, 45, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (979, 979, 157, 67, 141, 36, 51, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (980, 980, 100, 140, 125, 25, 44, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (981, 981, 163, 97, 105, 19, 35, 58);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (982, 982, 149, 115, 101, 39, 52, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (983, 983, 106, 144, 115, 40, 61, 84);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (984, 984, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (985, 985, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (986, 986, 219, 96, 50, 20, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (987, 987, 48, 221, 96, 50, 100, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (988, 988, 77, 164, 124, 10, 22, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (989, 989, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (990, 990, 48, 173, 144, 30, 50, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (992, 992, 65, 121, 179, 80, 110, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (993, 993, 123, 91, 151, 45, 64, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (994, 994, 123, 192, 50, 10, 15, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (995, 995, 218, 0, 147, 100, 0, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (996, 996, 87, 167, 111, 25, 43, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (997, 997, 30, 234, 101, 160, 200, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (998, 998, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (999, 999, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1000, 1000, 66, 167, 132, 15, 25, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1075, 1075, 50, 160, 155, 20, 60, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1076, 1076, 65, 120, 180, 45, 120, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1077, 1077, 105, 162, 98, 5, 8, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1078, 1078, 55, 160, 150, 40, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1079, 1079, 96, 157, 112, 55, 122, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1080, 1080, 75, 170, 120, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1081, 1081, 98, 212, 55, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1082, 1082, 45, 150, 170, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1083, 1083, 0, 317, 48, 0, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1084, 1084, 45, 170, 150, 20, 40, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1085, 1085, 48, 221, 96, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1086, 1086, 48, 219, 98, 20, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1087, 1087, 35, 170, 160, 220, 307, 370);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1088, 1088, 98, 152, 115, 30, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1089, 1089, 253, 0, 112, 80, 0, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1090, 1090, 75, 120, 170, 30, 50, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1091, 1091, 365, 0, 0, 10, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1092, 1092, 253, 0, 112, 25, 0, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1093, 1093, 65, 120, 180, 100, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1094, 1094, 48, 197, 120, 8, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1095, 1095, 60, 205, 100, 106, 360, 430);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1096, 1096, 50, 130, 185, 42, 85, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1097, 1097, 157, 96, 112, 70, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1098, 1098, 48, 177, 140, 50, 70, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1099, 1099, 75, 120, 170, 40, 60, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1100, 1100, 48, 173, 144, 70, 220, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1101, 1101, 240, 77, 48, 15, 40, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1102, 1102, 70, 135, 160, 20, 40, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1103, 1103, 48, 220, 97, 25, 35, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1104, 1104, 0, 253, 112, 0, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1105, 1105, 80, 189, 96, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1106, 1106, 48, 187, 130, 60, 90, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1107, 1107, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1108, 1108, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1109, 1109, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1110, 1110, 309, 40, 16, 30, 40, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1111, 1111, 60, 145, 160, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1112, 1112, 50, 150, 165, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1113, 1113, 75, 140, 150, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1114, 1114, 95, 150, 120, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1115, 1115, 55, 170, 140, 20, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1116, 1116, 40, 150, 175, 50, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1117, 1117, 45, 150, 170, 40, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1118, 1118, 95, 120, 150, 50, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1119, 1119, 65, 165, 135, 20, 80, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1120, 1120, 180, 85, 100, 3, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1121, 1121, 60, 160, 145, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1122, 1122, 80, 150, 135, 10, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1123, 1123, 65, 160, 140, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1124, 1124, 48, 187, 130, 7, 12, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1125, 1125, 90, 275, 0, 30, 60, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1126, 1126, 180, 137, 48, 50, 90, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1127, 1127, 48, 219, 98, 50, 170, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1128, 1128, 54, 213, 98, 50, 75, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1129, 1129, 60, 140, 165, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1130, 1130, 60, 165, 140, 25, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1131, 1131, 48, 199, 118, 50, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1132, 1132, 65, 160, 140, 30, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1133, 1133, 267, 0, 98, 30, 0, 135);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1134, 1134, 0, 253, 112, 0, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1135, 1135, 0, 253, 112, 0, 60, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1136, 1136, 48, 182, 135, 35, 50, 97);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1137, 1137, 0, 253, 112, 0, 100, 371);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1138, 1138, 48, 172, 145, 25, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1139, 1139, 89, 120, 96, 25, 40, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1140, 1140, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1141, 1141, 76, 172, 117, 30, 60, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1142, 1142, 0, 221, 144, 0, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1143, 1143, 48, 263, 54, 25, 35, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1144, 1144, 245, 0, 120, 20, 0, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1145, 1145, 56, 157, 152, 65, 80, 134);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1146, 1146, 0, 293, 72, 0, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1147, 1147, 90, 180, 60, 53, 120, 290);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1148, 1148, 225, 100, 40, 80, 120, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1149, 1149, 157, 96, 112, 70, 100, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1150, 1150, 58, 182, 125, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1151, 1151, 98, 169, 98, 7, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1152, 1152, 237, 80, 48, 65, 80, 140);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1153, 1153, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1154, 1154, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1155, 1155, 96, 0, 269, 25, 0, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1156, 1156, 0, 253, 112, 0, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1157, 1157, 0, 205, 160, 0, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1158, 1158, 225, 100, 40, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1159, 1159, 140, 127, 98, 180, 248, 320);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1160, 1160, 79, 144, 142, 40, 90, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1161, 1161, 169, 100, 96, 170, 460, 520);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1162, 1162, 103, 150, 112, 73, 120, 175);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1163, 1163, 10, 10, 10, 4, 4, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1164, 1164, 65, 235, 65, 25, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1165, 1165, 217, 100, 48, 10, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1166, 1166, 144, 173, 48, 10, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1167, 1167, 120, 40, 120, 20, 55, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1168, 1168, 150, 94, 101, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1169, 1169, 101, 24, 240, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1170, 1170, 192, 48, 96, 4, 8, 16);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1171, 1171, 110, 175, 80, 80, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1172, 1172, 100, 94, 151, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1173, 1173, 30, 150, 185, 15, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1174, 1174, 240, 29, 96, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1175, 1175, 96, 123, 146, 23, 32, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1176, 1176, 20, 130, 215, 50, 90, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1177, 1177, 5, 5, 355, 30, 50, 220);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1178, 1178, 240, 29, 96, 2, 8, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1179, 1179, 240, 29, 96, 40, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1180, 1180, 240, 96, 29, 7, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1181, 1181, 96, 144, 95, 0, 1, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1182, 1182, 29, 240, 96, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1183, 1183, 125, 133, 107, 35, 58, 62);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1184, 1184, 30, 80, 255, 200, 400, 530);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1185, 1185, 200, 70, 95, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1186, 1186, 105, 139, 121, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1187, 1187, 160, 105, 100, 6, 8, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1188, 1188, 90, 110, 165, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1189, 1189, 144, 173, 48, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1190, 1190, 97, 96, 172, 15, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1191, 1191, 160, 100, 105, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1192, 1192, 132, 180, 53, 3, 6, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1193, 1193, 96, 125, 144, 6, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1194, 1194, 125, 150, 90, 15, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1195, 1195, 65, 100, 200, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1196, 1196, 65, 100, 200, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1197, 1197, 65, 100, 200, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1198, 1198, 65, 100, 200, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1199, 1199, 65, 100, 200, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1200, 1200, 65, 100, 200, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1201, 1201, 123, 135, 107, 25, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1202, 1202, 121, 139, 105, 30, 45, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1203, 1203, 121, 139, 105, 10, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1204, 1204, 121, 139, 105, 10, 17, 37);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1205, 1205, 123, 135, 107, 30, 45, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1206, 1206, 103, 120, 107, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1207, 1207, 143, 135, 87, 10, 14, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1208, 1208, 119, 140, 106, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1209, 1209, 121, 139, 105, 5, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1210, 1210, 123, 135, 107, 345, 382, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1211, 1211, 121, 139, 105, 20, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1212, 1212, 123, 135, 107, 125, 205, 285);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1213, 1213, 121, 139, 105, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1214, 1214, 119, 140, 106, 77, 110, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1215, 1215, 123, 135, 107, 155, 207, 305);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1216, 1216, 123, 135, 107, 55, 70, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1232, 1232, 165, 100, 100, 10, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1233, 1233, 165, 100, 100, 10, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1234, 1234, 165, 100, 100, 10, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1235, 1235, 165, 100, 100, 10, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1236, 1236, 100, 165, 100, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1237, 1237, 100, 165, 100, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1238, 1238, 119, 140, 106, 8, 12, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1239, 1239, 119, 140, 106, 42, 56, 63);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1240, 1240, 119, 125, 121, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1241, 1241, 117, 133, 115, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1242, 1242, 123, 135, 107, 35, 43, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1243, 1243, 125, 127, 113, 40, 56, 67);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1244, 1244, 123, 135, 107, 40, 56, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1245, 1245, 115, 133, 117, 62, 122, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1246, 1246, 121, 139, 105, 6, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1247, 1247, 123, 135, 107, 459, 515, 530);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1248, 1248, 173, 96, 97, 5, 15, 24);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1249, 1249, 105, 145, 115, 20, 33, 37);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1250, 1250, 100, 165, 100, 10, 15, 18);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1251, 1251, 122, 124, 119, 25, 27, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1252, 1252, 115, 145, 105, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1253, 1253, 100, 145, 120, 280, 300, 320);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1254, 1254, 112, 133, 120, 215, 285, 315);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1255, 1255, 121, 127, 117, 105, 175, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1256, 1256, 121, 139, 105, 55, 100, 127);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1257, 1257, 121, 139, 105, 10, 20, 480);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1258, 1258, 121, 139, 105, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1259, 1259, 121, 139, 105, 5, 10, 17);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1260, 1260, 121, 139, 105, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1261, 1261, 120, 130, 115, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1262, 1262, 121, 139, 105, 10, 15, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1263, 1263, 121, 139, 105, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1264, 1264, 121, 139, 105, 7, 11, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1265, 1265, 5, 10, 20, 115, 133, 117);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1266, 1266, 121, 139, 105, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1267, 1267, 121, 139, 105, 15, 20, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1268, 1268, 100, 165, 100, 10, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1269, 1269, 105, 144, 116, 10, 17, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1270, 1270, 100, 165, 100, 20, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1271, 1271, 100, 100, 165, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1272, 1272, 100, 155, 110, 400, 460, 485);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1273, 1273, 100, 150, 115, 146, 200, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1274, 1274, 102, 146, 117, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1275, 1275, 100, 148, 117, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1276, 1276, 65, 150, 150, 20, 45, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1277, 1277, 120, 136, 109, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1278, 1278, 65, 100, 200, 50, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1279, 1279, 120, 135, 110, 20, 35, 44);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1280, 1280, 65, 100, 200, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1281, 1281, 65, 120, 180, 50, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1282, 1282, 60, 115, 190, 70, 120, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1283, 1283, 110, 138, 117, 5, 12, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1284, 1284, 110, 138, 117, 137, 165, 185);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1285, 1285, 105, 147, 113, 51, 100, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1286, 1286, 65, 100, 200, 15, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1287, 1287, 100, 155, 110, 51, 82, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1288, 1288, 105, 140, 120, 7, 18, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1289, 1289, 113, 135, 117, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1290, 1290, 65, 100, 200, 40, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1291, 1291, 65, 120, 180, 25, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1292, 1292, 65, 120, 180, 50, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1293, 1293, 65, 110, 190, 40, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1294, 1294, 35, 100, 230, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1295, 1295, 65, 105, 195, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1296, 1296, 95, 120, 150, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1297, 1297, 65, 50, 250, 30, 50, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1298, 1298, 115, 100, 150, 15, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1299, 1299, 100, 165, 100, 15, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1300, 1300, 100, 165, 100, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1301, 1301, 100, 165, 100, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1302, 1302, 100, 165, 100, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1303, 1303, 100, 165, 100, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1304, 1304, 100, 115, 150, 30, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1305, 1305, 115, 100, 150, 40, 50, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1306, 1306, 65, 100, 200, 25, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1307, 1307, 217, 50, 98, 75, 100, 198);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1308, 1308, 170, 115, 80, 7, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1309, 1309, 0, 215, 150, 0, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1310, 1310, 195, 100, 70, 6, 9, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1311, 1311, 195, 100, 70, 6, 10, 14);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1312, 1312, 118, 165, 82, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1313, 1313, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1314, 1314, 100, 165, 100, 15, 30, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1315, 1315, 0, 200, 165, 150, 170, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1316, 1316, 56, 165, 144, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1317, 1317, 165, 120, 80, 6, 8, 12);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1318, 1318, 100, 165, 100, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1319, 1319, 0, 221, 144, 60, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1320, 1320, 60, 185, 120, 15, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1321, 1321, 0, 221, 144, 0, 120, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1322, 1322, 0, 253, 112, 0, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1323, 1323, 0, 253, 112, 0, 250, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1324, 1324, 48, 173, 144, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1325, 1325, NULL, 221, 144, 50, 120, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1326, 1326, 0, 253, 112, 90, 150, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1327, 1327, 48, 144, 173, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1328, 1328, 50, 170, 145, 75, 120, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1329, 1329, 100, 165, 100, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1330, 1330, 100, 165, 100, 40, 60, 84);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1331, 1331, 51, 170, 144, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1332, 1332, 41, 177, 147, 30, 75, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1333, 1333, 165, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1334, 1334, 165, 100, 100, 20, 50, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1335, 1335, 165, 100, 100, 20, 50, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1336, 1336, 48, 144, 173, 50, 120, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1337, 1337, 22, 33, 55, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1338, 1338, 144, 173, 48, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1339, 1339, 165, 56, 144, 20, 50, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1340, 1340, 48, 177, 140, 40, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1341, 1341, 108, 209, 48, 3, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1342, 1342, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1343, 1343, 0, 221, 144, NULL, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1344, 1344, 112, 151, 102, 5, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1345, 1345, 157, 112, 96, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1346, 1346, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1347, 1347, 15, 30, 50, 96, 221, 48);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1348, 1348, 345, 20, NULL, 1, 2, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1349, 1349, 0, 144, 221, 0, 210, 330);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1350, 1350, 200, 145, 20, 10, 2, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1351, 1351, 350, 10, 5, 1, 5, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1352, 1352, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1353, 1353, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1354, 1354, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1355, 1355, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1356, 1356, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1357, 1357, 200, 117, 48, 5, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1358, 1358, 0, 220, 145, 0, 70, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1359, 1359, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1360, 1360, NULL, 240, 125, NULL, 150, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1361, 1361, 0, 221, 144, NULL, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1362, 1362, 48, 173, 144, 25, 40, 68);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1363, 1363, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1364, 1364, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1365, 1365, 151, 102, 112, 10, 20, 38);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1366, 1366, 157, 96, 112, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1367, 1367, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1368, 1368, 48, 173, 144, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1369, 1369, 144, 173, 48, 15, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1370, 1370, 30, 75, 150, 21, 200, 144);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1371, 1371, 145, 172, 48, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1372, 1372, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1373, 1373, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1374, 1374, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1375, 1375, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1376, 1376, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1377, 1377, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1378, 1378, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1379, 1379, 145, 170, 50, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1380, 1380, 144, 173, 48, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1381, 1381, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1382, 1382, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1383, 1383, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1384, 1384, 0, 220, 145, 0, 115, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1385, 1385, 45, 170, 150, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1386, 1386, NULL, 221, 144, NULL, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1387, 1387, 48, 173, 144, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1388, 1388, 48, 173, 144, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1389, 1389, 48, 173, 144, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1390, 1390, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1391, 1391, 100, 165, 100, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1392, 1392, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1393, 1393, 300, 40, 25, 3, 5, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1394, 1394, 300, 40, 25, 3, 15, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1395, 1395, 300, 45, 20, 5, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1396, 1396, 300, 40, 25, 5, 4, 7);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1397, 1397, 300, 25, 40, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1398, 1398, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1399, 1399, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1400, 1400, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1401, 1401, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1402, 1402, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1403, 1403, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1404, 1404, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1405, 1405, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1406, 1406, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1407, 1407, 163, 100, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1408, 1408, 192, 48, 96, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1409, 1409, 300, 40, 25, 2, 3, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1410, 1410, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1411, 1411, 115, 100, 150, 2, 4, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1412, 1412, 115, 100, 150, 2, 5, 7);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1413, 1413, 300, 40, 25, 2, 3, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1414, 1414, 115, 100, 150, 10, 30, 41);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1415, 1415, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1416, 1416, 40, 75, 250, 1, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1417, 1417, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1418, 1418, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1419, 1419, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1420, 1420, 115, 100, 150, 2, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1421, 1421, 115, 95, 155, 6, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1422, 1422, 310, 25, 30, 4, 8, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1423, 1423, 115, 100, 150, 8, 20, 36);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1424, 1424, 115, 100, 150, 4, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1425, 1425, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1426, 1426, 101, 100, 164, 40, 402, 702);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1427, 1427, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1428, 1428, 115, 100, 150, 8, 180, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1429, 1429, 45, 170, 150, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1430, 1430, 220, 70, 75, 2, 4, 6);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1431, 1431, 115, 100, 150, 5, 200, 248);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1432, 1432, 230, 50, 85, 3, 4, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1433, 1433, 50, 50, 265, 2, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1434, 1434, 115, 90, 160, 5, 30, 33);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1435, 1435, 10, 100, 255, 5, 205, 365);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1436, 1436, 0, 221, 144, 0, 300, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1437, 1437, 115, 100, 150, 2, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1438, 1438, 115, 100, 150, 2, 9, 11);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1439, 1439, 15, 90, 260, 10, 100, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1440, 1440, 5, 60, 300, 20, 300, 337);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1441, 1441, 40, 75, 250, 10, 180, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1442, 1442, 48, 170, 147, 30, 60, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1443, 1443, 115, 80, 170, 10, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1444, 1444, 80, 120, 165, 5, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1445, 1445, 90, 115, 160, 20, 180, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1446, 1446, 0, 221, 144, 0, 250, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1447, 1447, 115, 100, 150, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1448, 1448, 20, 50, 295, 800, 1600, 2200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1449, 1449, 48, 173, 144, 40, 120, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1450, 1450, 165, 80, 120, 2, 5, 6);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1451, 1451, 0, 221, 144, 0, 150, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1452, 1452, 48, 173, 144, 30, 75, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1453, 1453, 115, 100, 150, 50, 205, 263);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1454, 1454, 80, 120, 165, 3, 10, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1455, 1455, 48, 173, 144, 30, 80, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1456, 1456, 115, 100, 150, 3, 6, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1457, 1457, 100, 115, 150, 3, 5, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1458, 1458, 100, 115, 150, 10, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1459, 1459, 0, 0, 0, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1460, 1460, 48, 175, 142, 10, 30, 42);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1461, 1461, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1462, 1462, 100, 145, 120, 80, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1463, 1463, 0, 0, 0, 0, 0, 0);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1464, 1464, 196, 173, 48, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1465, 1465, 100, 165, 100, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1466, 1466, 173, 144, 48, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1467, 1467, 100, 100, 165, 40, 70, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1468, 1468, 48, 173, 144, 20, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1469, 1469, 0, 0, 0, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1470, 1470, 0, 0, 0, 30, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1471, 1471, 0, 0, 0, 40, 70, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1472, 1472, 0, 0, 0, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1473, 1473, 0, 0, 0, 20, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1474, 1474, 0, 0, 0, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1475, 1475, 0, 0, 0, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1476, 1476, 165, 100, 100, 30, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1477, 1477, 80, 120, 165, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1478, 1478, 0, 221, 144, 0, 160, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1479, 1479, 0, 185, 180, 0, 120, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1480, 1480, 144, 173, 48, 40, 70, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1481, 1481, 96, 150, 119, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1482, 1482, 48, 175, 142, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1483, 1483, 48, 144, 173, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1484, 1484, 10, 15, 30, 221, 96, 48);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1485, 1485, 48, 173, 144, 30, 55, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1486, 1486, 144, 173, 48, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1487, 1487, 115, 100, 150, 2, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1488, 1488, 173, 48, 144, 50, 100, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1489, 1489, 89, 153, 125, 25, 40, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1490, 1490, 170, 65, 125, 12, 18, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1491, 1491, 0, 112, 253, 0, 400, 600);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1492, 1492, 110, 100, 155, 2, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1493, 1493, 48, 173, 144, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1494, 1494, 115, 100, 150, 2, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1495, 1495, 48, 215, 102, 20, 50, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1496, 1496, 115, 100, 150, 3, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1497, 1497, 201, 58, 106, 30, 65, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1498, 1498, 65, 100, 200, 30, 120, 220);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1499, 1499, 65, 100, 200, 2, 4, 9);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1500, 1500, 25, 100, 240, 5, 13, 23);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1501, 1501, 100, 165, 100, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1502, 1502, 15, 100, 250, 150, 250, 310);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1503, 1503, 100, 125, 140, 2, 5, 9);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1504, 1504, 204, 61, 100, 10, 35, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1505, 1505, 100, 90, 175, 10, 15, 21);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1506, 1506, 115, 100, 150, 10, 15, 23);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1507, 1507, 105, 180, 80, 50, 100, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1508, 1508, 210, 50, 105, 2, 3, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1509, 1509, 80, 100, 185, 6, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1510, 1510, 203, 62, 100, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1511, 1511, 180, 85, 100, 2, 4, 7);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1512, 1512, 115, 100, 150, 80, 180, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1513, 1513, 115, 100, 150, 3, 4, 9);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1514, 1514, 165, 180, 20, 4, 11, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1515, 1515, 15, 65, 275, 50, 160, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1516, 1516, 65, 100, 200, 55, 105, 215);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1517, 1517, 5, 100, 260, 40, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1518, 1518, 165, 180, 20, 4, 11, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1519, 1519, 5, 150, 210, 35, 100, 220);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1520, 1520, 315, 25, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1521, 1521, 5, 60, 300, 50, 100, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1522, 1522, 100, 96, 169, 70, 150, 275);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1523, 1523, 58, 100, 158, 50, 100, 190);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1524, 1524, 201, 58, 106, 35, 65, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1525, 1525, 203, 62, 100, 15, 25, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1526, 1526, 203, 62, 100, 50, 90, 185);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1527, 1527, 121, 100, 144, 20, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1528, 1528, 169, 52, 144, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1529, 1529, 169, 52, 144, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1530, 1530, 15, 50, 300, 50, 50, 255);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1531, 1531, 15, 150, 200, 15, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1532, 1532, 100, 100, 165, 5, 13, 27);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1533, 1533, 5, 150, 210, 35, 80, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1534, 1534, 5, 50, 310, 5, 70, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1535, 1535, 235, 50, 80, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1536, 1536, 315, 25, 25, 1, 2, 6);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1537, 1537, 100, 95, 170, 2, 5, 7);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1538, 1538, 123, 144, 150, 150, 220, 305);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1539, 1539, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1540, 1540, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1541, 1541, 15, 50, 300, 10, 70, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1542, 1542, 100, 165, 100, 4, 12, 27);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1543, 1543, 115, 100, 150, 20, 48, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1544, 1544, 270, 45, 50, 1, 2, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1545, 1545, 30, 150, 185, 64, 100, 235);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1546, 1546, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1547, 1547, 72, 95, 198, 90, 140, 225);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1548, 1548, 100, 165, 100, 2, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1549, 1549, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1550, 1550, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1551, 1551, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1552, 1552, 90, 100, 175, 50, 100, 185);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1553, 1553, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1554, 1554, 100, 165, 100, 8, 19, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1555, 1555, 123, 98, 144, 5, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1556, 1556, 100, 165, 100, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1557, 1557, 35, 165, 165, 200, 300, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1558, 1558, 48, 173, 144, 10, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1559, 1559, 51, 115, 164, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1560, 1560, 48, 173, 144, 75, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1561, 1561, 35, 165, 165, 200, 300, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1562, 1562, 169, 98, 98, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1563, 1563, 120, 175, 60, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1564, 1564, 73, 146, 146, 2, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1565, 1565, 0, 253, 112, 0, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1566, 1566, 144, 173, 48, 30, 70, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1567, 1567, 48, 173, 144, 30, 100, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1568, 1568, 115, 90, 160, 5, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1569, 1569, 50, 140, 175, 10, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1570, 1570, 175, 65, 125, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1571, 1571, 110, 75, 180, 80, 180, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1572, 1572, 60, 80, 225, 150, 345, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1573, 1573, 169, 98, 98, 25, 45, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1574, 1574, 169, 98, 98, 25, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1575, 1575, 55, 100, 210, 160, 210, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1576, 1576, 169, 98, 98, 25, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1577, 1577, 145, 100, 120, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1578, 1578, 115, 115, 135, 135, 227, 285);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1579, 1579, 75, 135, 155, 10, 70, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1580, 1580, 300, 40, 20, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1581, 1581, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1582, 1582, 285, 50, 30, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1583, 1583, 300, 40, 25, 2, 3, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1584, 1584, 200, 45, 20, 5, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1585, 1585, 144, 77, 144, 200, 300, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1586, 1586, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1587, 1587, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1588, 1588, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1589, 1589, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1590, 1590, 300, 25, 40, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1591, 1591, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1592, 1592, 300, 40, 25, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1593, 1593, 300, 40, 25, 300, 40, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1594, 1594, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1595, 1595, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1596, 1596, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1597, 1597, 300, 40, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1598, 1598, 250, 100, 15, 3, 5, 7);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1599, 1599, 270, 80, 15, 1, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1600, 1600, 165, 100, 100, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1601, 1601, 300, 25, 40, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1602, 1602, 300, 25, 40, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1603, 1603, 65, 105, 195, 10, 35, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1604, 1604, 107, 95, 163, 20, 85, 115);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1605, 1605, 105, 94, 166, 70, 95, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1606, 1606, 90, 130, 145, 65, 95, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1607, 1607, 167, 98, 100, 200, 350, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1608, 1608, 60, 120, 185, 70, 105, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1609, 1609, 135, 105, 125, 50, 94, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1610, 1610, 102, 90, 173, 66, 85, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1611, 1611, 40, 100, 225, 90, 145, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1612, 1612, 80, 155, 130, 40, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1613, 1613, 87, 110, 168, 78, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1614, 1614, 80, 80, 205, 250, 400, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1615, 1615, 147, 98, 120, 50, 80, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1616, 1616, 107, 100, 158, 50, 125, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1617, 1617, 121, 100, 144, 35, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1618, 1618, 60, 100, 205, 96, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1619, 1619, 48, 172, 145, 10, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1620, 1620, 0, 180, 215, 0, 75, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1621, 1621, 50, 150, 165, 30, 75, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1622, 1622, 0, 200, 165, 0, 155, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1623, 1623, 165, 100, 100, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1624, 1624, 45, 200, 120, 30, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1625, 1625, 150, 105, 110, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1626, 1626, 121, 196, 48, 5, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1627, 1627, 165, 100, 100, 0, 60, 130);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1628, 1628, 0, 253, 112, 0, 120, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1629, 1629, 120, 100, 145, 15, 26, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1630, 1630, 50, 120, 195, 250, 400, 1200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1631, 1631, 90, 120, 155, 75, 90, 145);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1632, 1632, 60, 155, 150, 90, 155, 186);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1633, 1633, 98, 169, 98, 250, 350, 510);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1634, 1634, 50, 155, 160, 55, 140, 165);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1635, 1635, 0, 0, 0, 0.001, 0.0025, 0.005);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1636, 1636, 65, 100, 200, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1637, 1637, 169, 98, 98, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1638, 1638, 100, 120, 145, 30, 50, 115);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1639, 1639, 173, 96, 96, 25, 35, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1640, 1640, 70, 140, 155, 100, 165, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1641, 1641, 169, 98, 98, 10, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1642, 1642, 169, 98, 98, 15, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1643, 1643, 75, 125, 165, 35, 80, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1644, 1644, 50, 165, 150, 15, 100, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1645, 1645, 100, 165, 100, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1646, 1646, 65, 100, 200, 50, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1647, 1647, 150, 95, 120, 15, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1648, 1648, 45, 120, 200, 20, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1649, 1649, 65, 100, 200, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1650, 1650, 65, 100, 200, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1651, 1651, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1652, 1652, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1653, 1653, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1654, 1654, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1655, 1655, 95, 120, 150, 25, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1656, 1656, 65, 100, 200, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1657, 1657, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1658, 1658, 75, 100, 190, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1659, 1659, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1660, 1660, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1661, 1661, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1662, 1662, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1663, 1663, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1664, 1664, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1665, 1665, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1666, 1666, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1667, 1667, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1668, 1668, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1669, 1669, 65, 130, 170, 25, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1670, 1670, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1671, 1671, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1672, 1672, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1673, 1673, 65, 100, 200, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1674, 1674, 65, 100, 200, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1675, 1675, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1676, 1676, 75, 140, 150, 20, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1677, 1677, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1678, 1678, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1679, 1679, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1680, 1680, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1681, 1681, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1682, 1682, 65, 100, 200, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1683, 1683, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1684, 1684, 250, 65, 50, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1685, 1685, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1686, 1686, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1687, 1687, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1688, 1688, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1689, 1689, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1690, 1690, 65, 120, 180, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1691, 1691, 65, 100, 200, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1692, 1692, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1693, 1693, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1694, 1694, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1695, 1695, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1696, 1696, 65, 100, 200, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1697, 1697, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1698, 1698, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1699, 1699, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1700, 1700, 65, 100, 200, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1701, 1701, 95, 120, 150, 25, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1702, 1702, 65, 100, 200, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1703, 1703, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1704, 1704, 75, 100, 190, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1705, 1705, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1706, 1706, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1707, 1707, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1708, 1708, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1709, 1709, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1710, 1710, 65, 100, 200, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1711, 1711, 170, 95, 100, 8, 9, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1712, 1712, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1713, 1713, 75, 100, 190, 10, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1714, 1714, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1715, 1715, 75, 100, 190, 25, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1716, 1716, 90, 120, 155, 30, 65, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1717, 1717, 173, 96, 96, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1718, 1718, 40, 115, 210, 85, 105, 160);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1719, 1719, 150, 98, 117, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1720, 1720, 169, 98, 98, 6, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1721, 1721, 169, 98, 98, 23, 35, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1722, 1722, 98, 169, 98, 8, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1723, 1723, 98, 169, 98, 12, 20, 28);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1724, 1724, 65, 120, 180, 20, 35, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1725, 1725, 98, 160, 107, 243, 300, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1726, 1726, 48, 173, 144, 25, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1727, 1727, 48, 173, 144, 15, 70, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1728, 1728, 151, 112, 102, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1729, 1729, 169, 98, 98, 25, 40, 74);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1730, 1730, 100, 150, 115, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1731, 1731, 160, 107, 98, 32, 60, 79);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1732, 1732, 169, 98, 98, 12, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1733, 1733, 169, 98, 98, 15, 23, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1734, 1734, 190, 10, 165, 1, 2, 2);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1735, 1735, 220, 20, 125, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1736, 1736, 115, 100, 150, 2, 4, 7);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1737, 1737, 115, 100, 150, 2, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1738, 1738, 158, 157, 50, 15, 22, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1739, 1739, 75, 192, 98, 80, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1740, 1740, 98, 169, 98, 12, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1741, 1741, 169, 98, 98, 30, 200, 385);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1742, 1742, 150, 95, 120, 30, 80, 135);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1743, 1743, 255, 98, 120, 4, 7, 11);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1744, 1744, 160, 85, 120, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1745, 1745, 120, 105, 140, 25, 50, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1746, 1746, 55, 125, 185, 100, 310, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1747, 1747, 149, 96, 120, 25, 40, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1748, 1748, 169, 98, 98, 4, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1749, 1749, 169, 98, 98, 161, 250, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1750, 1750, 109, 110, 146, 125, 250, 380);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1751, 1751, 65, 125, 175, 70, 150, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1752, 1752, 190, 75, 100, 10, 25, 51);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1753, 1753, 109, 110, 146, 18, 25, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1754, 1754, 30, 150, 185, 100, 225, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1755, 1755, 67, 100, 150, 75, 115, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1756, 1756, 64, 100, 201, 115, 275, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1757, 1757, 50, 140, 175, 150, 275, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1758, 1758, 77, 100, 188, 70, 200, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1759, 1759, 105, 50, 210, 8, 16, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1760, 1760, 285, 30, 50, 7, 20, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1761, 1761, 70, 120, 175, 300, 425, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1762, 1762, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1763, 1763, 15, 100, 250, 10, 100, 157);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1764, 1764, 15, 100, 250, 50, 70, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1765, 1765, 185, 70, 110, 30, 55, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1766, 1766, 169, 98, 98, 12, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1767, 1767, 100, 90, 175, 50, 175, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1768, 1768, 169, 98, 98, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1769, 1769, 169, 98, 98, 18, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1770, 1770, 169, 98, 98, 85, 200, 380);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1771, 1771, 300, 25, 45, 5, 7, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1772, 1772, 169, 98, 98, 100, 150, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1773, 1773, 170, 45, 150, 13, 23, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1774, 1774, 217, 50, 98, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1775, 1775, 200, 45, 120, 3, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1776, 1776, 119, 150, 96, 25, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1777, 1777, 205, 60, 100, 12, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1778, 1778, 73, 192, 100, 3, 5, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1779, 1779, 70, 100, 195, 100, 185, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1780, 1780, 55, 120, 190, 250, 350, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1781, 1781, 85, 200, 80, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1782, 1782, 200, 50, 115, 6, 10, 24);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1783, 1783, 98, 169, 98, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1784, 1784, 65, 125, 175, 75, 100, 145);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1785, 1785, 90, 110, 165, 85, 175, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1786, 1786, 145, 125, 100, 15, 40, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1787, 1787, 168, 85, 112, 40, 100, 185);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1788, 1788, 135, 95, 135, 60, 100, 166);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1789, 1789, 100, 97, 168, 50, 100, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1844, 1844, 61, 135, 169, 65, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1845, 1845, 60, 120, 185, 100, 185, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1846, 1846, 170, 85, 110, 30, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1847, 1847, 80, 100, 180, 70, 120, 165);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1848, 1848, 40, 120, 205, 185, 250, 385);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1849, 1849, 80, 120, 165, 40, 100, 205);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1850, 1850, 77, 100, 188, 30, 100, 145);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1851, 1851, 178, 75, 112, 40, 60, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1852, 1852, 48, 173, 144, 50, 70, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1853, 1853, 144, 173, 48, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1854, 1854, 48, 173, 144, 20, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1855, 1855, 0, 253, 112, 0, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1856, 1856, 0, 192, 173, 0, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1857, 1857, 50, 240, 75, 40, 60, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1858, 1858, 100, 165, 100, 15, 30, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1859, 1859, 169, 98, 98, 25, 50, 67);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1860, 1860, 169, 98, 98, 40, 65, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1861, 1861, 169, 98, 98, 40, 65, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1862, 1862, 169, 98, 98, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1863, 1863, 265, 50, 50, 10, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1864, 1864, 120, 118, 127, 60, 130, 190);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1865, 1865, 169, 98, 98, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1866, 1866, 120, 100, 145, 35, 80, 135);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1867, 1867, 169, 98, 98, 9, 16, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1868, 1868, 96, 125, 144, 0, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1869, 1869, 96, 77, 192, 4, 10, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1870, 1870, 169, 98, 98, 14, 22, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1871, 1871, 100, 165, 100, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1872, 1872, 169, 98, 98, 130, 175, 265);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1873, 1873, 100, 165, 100, 15, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1874, 1874, 169, 98, 98, 20, 35, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1875, 1875, 75, 200, 90, 100, 150, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1876, 1876, 169, 98, 98, 5, 8, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1877, 1877, 169, 98, 98, 25, 35, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1878, 1878, 217, 50, 98, 100, 150, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1879, 1879, 217, 50, 98, 14, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1880, 1880, 217, 50, 98, 150, 250, 390);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1881, 1881, 217, 50, 98, 110, 160, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1882, 1882, 217, 50, 98, 200, 350, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1883, 1883, 96, 96, 144, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1884, 1884, 190, 65, 110, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1885, 1885, 128, 70, 170, 20, 50, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1886, 1886, 77, 144, 144, 0, 1, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1887, 1887, 45, 120, 200, 105, 300, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1888, 1888, 72, 100, 193, 20, 95, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1889, 1889, 280, 35, 50, 3, 7, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1890, 1890, 67, 90, 208, 100, 300, 600);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1891, 1891, 96, 173, 96, 122, 200, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1892, 1892, 115, 100, 160, 20, 30, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1893, 1893, 170, 80, 115, 20, 30, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1894, 1894, 250, 50, 65, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1895, 1895, 140, 100, 125, 10, 50, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1896, 1896, 10, 90, 265, 100, 300, 460);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1897, 1897, 175, 75, 115, 15, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1898, 1898, 131, 100, 134, 20, 55, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1899, 1899, 180, 80, 105, 10, 30, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1900, 1900, 217, 50, 98, 10, 14, 23);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1901, 1901, 115, 95, 155, 50, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1902, 1902, 117, 50, 98, 10, 22, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1903, 1903, 109, 110, 146, 7, 10, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1904, 1904, 217, 50, 98, 12, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1905, 1905, 98, 169, 98, 20, 35, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1906, 1906, 100, 165, 100, 30, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1907, 1907, 100, 165, 100, 15, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1908, 1908, 65, 100, 200, 150, 250, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1909, 1909, 100, 165, 100, 250, 350, 560);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1910, 1910, 100, 165, 100, 125, 140, 172);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1911, 1911, 65, 150, 150, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1912, 1912, 169, 98, 98, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1913, 1913, 121, 98, 146, 100, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1914, 1914, 240, 72, 53, 12, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1915, 1915, 217, 50, 98, 200, 300, 410);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1916, 1916, 100, 165, 100, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1917, 1917, 217, 50, 98, 35, 100, 175);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1918, 1918, 100, 165, 100, 40, 70, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1919, 1919, 169, 98, 98, 200, 360, 500);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1920, 1920, 217, 50, 98, 9, 13, 18);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1921, 1921, 217, 50, 98, 16, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1922, 1922, 100, 165, 100, 20, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1923, 1923, 217, 50, 98, 150, 210, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1924, 1924, 217, 50, 98, 130, 170, 245);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1925, 1925, 217, 50, 98, 10, 18, 32);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1926, 1926, 217, 50, 98, 75, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1927, 1927, 217, 50, 98, 8, 12, 18);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1928, 1928, 217, 50, 98, 75, 150, 210);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1929, 1929, 217, 50, 98, 8, 12, 18);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1930, 1930, 65, 100, 200, 150, 250, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1931, 1931, 100, 165, 100, 67, 110, 287);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1932, 1932, 100, 165, 100, 30, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1933, 1933, 217, 50, 98, 27, 50, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1934, 1934, 215, 65, 85, 30, 50, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1935, 1935, 217, 50, 98, 33, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1936, 1936, 217, 50, 98, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1937, 1937, 320, 20, 25, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1938, 1938, 100, 165, 100, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1939, 1939, 100, 165, 100, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1940, 1940, 217, 50, 98, 60, 100, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1941, 1941, 217, 50, 98, 22, 34, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1942, 1942, 217, 50, 98, 75, 110, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1943, 1943, 217, 50, 98, 10, 15, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1944, 1944, 217, 50, 98, 48, 70, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1945, 1945, 115, 100, 150, 10, 80, 118);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1946, 1946, 115, 100, 150, 2, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1947, 1947, 100, 100, 165, 10, 140, 142);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1948, 1948, 100, 165, 100, 1, 8, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1949, 1949, 175, 120, 70, 15, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1950, 1950, 144, 96, 96, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1951, 1951, 192, 77, 96, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1952, 1952, 240, 48, 77, 20, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1953, 1953, 225, 62, 48, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1954, 1954, 173, 144, 48, 40, 75, 110);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1955, 1955, 48, 173, 144, 25, 50, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1956, 1956, 115, 100, 150, 2, 7, 9);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1957, 1957, 115, 100, 150, 2, 34, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1958, 1958, 80, 165, 120, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1959, 1959, 100, 165, 100, 30, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1960, 1960, 50, 165, 150, 100, 300, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1961, 1961, 115, 100, 150, 20, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1962, 1962, 65, 65, 235, 100, 150, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1963, 1963, 100, 165, 100, 15, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1964, 1964, 65, 150, 150, 100, 150, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1965, 1965, 85, 100, 180, 100, 150, 230);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1966, 1966, 115, 150, 100, 80, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1991, 1991, 100, 165, 100, 15, 27, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1992, 1992, 100, 165, 100, 30, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1993, 1993, 100, 165, 100, 10, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1994, 1994, 50, 165, 150, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1995, 1995, 100, 165, 100, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1996, 1996, 100, 115, 150, 8, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1997, 1997, 85, 90, 190, 10, 30, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1998, 1998, 75, 130, 160, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (1999, 1999, 135, 117, 113, 15, 20, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2000, 2000, 50, 100, 215, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2001, 2001, 50, 115, 200, 300, 350, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2002, 2002, 30, 100, 235, 200, 350, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2003, 2003, 65, 200, 100, 90, 120, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2004, 2004, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2005, 2005, 100, 115, 150, 12, 22, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2006, 2006, 100, 165, 100, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2007, 2007, 246, 46, 73, 1, 8, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2008, 2008, 65, 120, 180, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2009, 2009, 100, 165, 100, 80, 120, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2010, 2010, 100, 120, 145, 20, 30, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2011, 2011, 100, 165, 100, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2012, 2012, 77, 120, 168, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2013, 2013, 220, 50, 95, 0, 2, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2014, 2014, 265, 50, 50, 15, 18, 23);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2015, 2015, 215, 50, 50, 12, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2016, 2016, 215, 50, 50, 10, 13, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2017, 2017, 215, 50, 50, 13, 15, 18);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2018, 2018, 215, 50, 50, 15, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2019, 2019, 110, 182, 73, 1, 2, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2020, 2020, 273, 68, 24, 5, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2021, 2021, 48, 77, 240, 4, 6, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2022, 2022, 75, 130, 160, 3, 10, 17);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2023, 2023, 79, 110, 176, 2, 15, 28);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2024, 2024, 305, 24, 36, 1, 2, 3);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2025, 2025, 73, 100, 192, 10, 15, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2026, 2026, 96, 113, 156, 4, 8, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2027, 2027, 29, 96, 240, 1, 2, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2028, 2028, 100, 165, 100, 20, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2029, 2029, 100, 165, 100, 10, 20, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2030, 2030, 100, 165, 100, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2031, 2031, 165, 100, 100, 5, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2032, 2032, 100, 130, 135, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2033, 2033, 100, 165, 100, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2034, 2034, 110, 120, 135, 15, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2035, 2035, 150, 115, 100, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2036, 2036, 100, 150, 115, 10, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2037, 2037, 100, 115, 150, 60, 70, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2038, 2038, 100, 100, 165, 130, 140, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2039, 2039, 150, 115, 100, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2040, 2040, 50, 115, 200, 200, 250, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2041, 2041, 165, 100, 100, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2042, 2042, 150, 115, 100, 40, 60, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2043, 2043, 110, 120, 145, 15, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2044, 2044, 150, 115, 100, 20, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2045, 2045, 105, 130, 130, 300, 350, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2046, 2046, 150, 115, 100, 10, 15, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2047, 2047, 100, 115, 150, 60, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2048, 2048, 150, 115, 100, 10, 18, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2049, 2049, 150, 100, 115, 15, 18, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2050, 2050, 150, 115, 100, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2051, 2051, 150, 115, 100, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2052, 2052, 100, 100, 165, 70, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2053, 2053, 165, 100, 100, 15, 18, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2054, 2054, 125, 110, 130, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2055, 2055, 165, 100, 100, 20, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2056, 2056, 165, 100, 100, 15, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2057, 2057, 100, 115, 150, 80, 90, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2058, 2058, 150, 115, 100, 40, 50, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2059, 2059, 200, 95, 70, 17, 18, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2060, 2060, 165, 100, 100, 15, 18, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2061, 2061, 80, 120, 160, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2062, 2062, 80, 100, 180, 20, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2063, 2063, 140, 100, 120, 3, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2064, 2064, 125, 144, 96, 270, 360, 450);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2065, 2065, 100, 115, 150, 50, 250, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2066, 2066, 125, 100, 140, 60, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2067, 2067, 100, 115, 150, 50, 100, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2068, 2068, 165, 100, 100, 15, 20, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2069, 2069, 265, 50, 50, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2070, 2070, 300, 25, 40, 8, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2071, 2071, 60, 204, 96, 50, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2072, 2072, 100, 165, 100, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2073, 2073, 100, 165, 100, 40, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2074, 2074, 180, 85, 100, 2, 4, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2075, 2075, 48, 240, 48, 50, 60, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2076, 2076, 192, 48, 96, 6, 10, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2077, 2077, 144, 144, 48, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2078, 2078, 240, 48, 48, 50, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2079, 2079, 144, 144, 48, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2080, 2080, 289, 28, 48, 15, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2081, 2081, 144, 96, 125, 40, 60, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2082, 2082, 124, 68, 173, 15, 20, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2083, 2083, 144, 96, 125, 20, 35, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2084, 2084, 215, 48, 102, 3, 9, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2085, 2085, 144, 48, 173, 30, 55, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2086, 2086, 96, 96, 96, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2087, 2087, 48, 240, 48, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2088, 2088, 100, 110, 150, 8, 12, 24);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2089, 2089, 80, 100, 180, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2090, 2090, 80, 100, 180, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2091, 2091, 50, 150, 160, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2092, 2092, 90, 130, 140, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2093, 2093, 100, 120, 140, 4, 6, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2094, 2094, 165, 100, 100, 30, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2095, 2095, 85, 130, 150, 30, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2096, 2096, 100, 165, 100, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2097, 2097, 70, 130, 160, 10, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2098, 2098, 80, 130, 150, 10, 25, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2099, 2099, 100, 115, 150, 150, 170, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2100, 2100, 150, 115, 100, 500, 800, 1000);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2101, 2101, 50, 165, 150, 150, 250, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2102, 2102, 50, 150, 165, 200, 300, 350);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2103, 2103, 100, 115, 150, 100, 200, 400);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2104, 2104, 50, 150, 165, 100, 200, 300);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2105, 2105, 265, 50, 50, 20, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2106, 2106, 65, 140, 160, 8, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2107, 2107, 65, 140, 160, 20, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2108, 2108, 25, 160, 180, 300, 600, 1000);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2109, 2109, 65, 140, 160, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2110, 2110, 45, 140, 180, 32, 50, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2111, 2111, 65, 140, 160, 20, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2112, 2112, 65, 140, 160, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2113, 2113, 25, 160, 180, 100, 200, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2114, 2114, 25, 160, 180, 120, 150, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2115, 2115, 25, 160, 180, 200, 220, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2116, 2116, 165, 160, 40, 3, 6, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2117, 2117, 165, 100, 100, 20, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2118, 2118, 65, 140, 160, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2119, 2119, 65, 140, 160, 8, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2120, 2120, 65, 140, 160, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2121, 2121, 65, 140, 160, 6, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2122, 2122, 65, 140, 160, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2123, 2123, 65, 140, 160, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2124, 2124, 65, 140, 160, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2125, 2125, 65, 140, 160, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2126, 2126, 65, 140, 160, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2127, 2127, 65, 140, 160, 8, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2128, 2128, 65, 140, 160, 8, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2129, 2129, 65, 140, 160, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2130, 2130, 65, 140, 160, 8, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2131, 2131, 100, 165, 100, 30, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2132, 2132, 155, 90, 120, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2133, 2133, 115, 150, 100, 5, 15, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2134, 2134, 145, 100, 120, 2, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2135, 2135, 95, 100, 170, 25, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2136, 2136, 150, 65, 150, 5, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2137, 2137, 121, 100, 144, 2, 4, 6);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2138, 2138, 165, 100, 100, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2139, 2139, 121, 100, 144, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2140, 2140, 205, 70, 90, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2141, 2141, 115, 150, 100, 25, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2142, 2142, 115, 100, 150, 50, 100, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2143, 2143, 145, 100, 120, 20, 35, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2144, 2144, 121, 100, 144, 3, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2145, 2145, 73, 100, 192, 2, 3, 6);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2146, 2146, 225, 60, 80, 3, 7, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2147, 2147, 65, 100, 200, 70, 80, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2148, 2148, 65, 115, 185, 65, 80, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2149, 2149, 90, 125, 150, 90, 95, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2150, 2150, 70, 110, 185, 40, 45, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2151, 2151, 65, 135, 165, 65, 75, 85);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2152, 2152, 70, 120, 175, 25, 28, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2153, 2153, 70, 125, 170, 14, 17, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2154, 2154, 115, 100, 150, 10, 20, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2155, 2155, 80, 130, 155, 30, 35, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2156, 2156, 65, 140, 160, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2157, 2157, 65, 140, 160, 15, 20, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2158, 2158, 65, 140, 160, 30, 80, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2159, 2159, 65, 140, 160, 80, 120, 180);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2160, 2160, 29, 144, 192, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2161, 2161, 100, 105, 160, 25, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2162, 2162, 65, 140, 160, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2163, 2163, 65, 140, 160, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2164, 2164, 40, 160, 180, 30, 40, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2165, 2165, 200, 70, 95, 5, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2166, 2166, 65, 100, 200, 5, 10, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2167, 2167, 65, 140, 160, 100, 120, 150);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2168, 2168, 173, 96, 96, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2169, 2169, 183, 96, 96, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2170, 2170, 65, 140, 160, 8, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2171, 2171, 165, 80, 120, 5, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2172, 2172, 144, 125, 96, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2173, 2173, 73, 100, 192, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2174, 2174, 96, 125, 144, 3, 5, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2175, 2175, 73, 100, 192, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2176, 2176, 73, 100, 192, 5, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2177, 2177, 90, 130, 145, 28, 32, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2178, 2178, 15, 18, 20, 150, 180, 200);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2179, 2179, 5, 20, 30, 165, 80, 120);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2180, 2180, 90, 125, 150, 25, 30, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2181, 2181, 100, 100, 165, 10, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2182, 2182, 95, 125, 145, 27, 30, 32);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2183, 2183, 75, 125, 165, 9, 11, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2184, 2184, 75, 130, 160, 8, 10, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2185, 2185, 15, 50, 300, 15, 280, 480);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2186, 2186, 75, 135, 155, 5, 6, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2187, 2187, 70, 120, 175, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2188, 2188, 70, 130, 165, 50, 60, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2189, 2189, 65, 130, 170, 30, 35, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2190, 2190, 85, 130, 150, 10, 13, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2191, 2191, 90, 120, 155, 8, 9, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2192, 2192, 50, 60, 70, 8, 9, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2193, 2193, 90, 120, 155, 45, 50, 55);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2194, 2194, 65, 160, 140, 10, 20, 23);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2195, 2195, 120, 130, 115, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2196, 2196, 100, 100, 165, 20, 30, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2197, 2197, 180, 95, 90, 5, 6, 8);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2198, 2198, 265, 30, 70, 3, 8, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2199, 2199, 140, 125, 100, 8, 9, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2200, 2200, 115, 115, 135, 8, 10, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2201, 2201, 60, 125, 180, 60, 70, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2202, 2202, 65, 140, 160, 8, 10, 12);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2203, 2203, 105, 100, 160, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2204, 2204, 140, 100, 125, 5, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2205, 2205, 95, 120, 150, 45, 50, 65);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2206, 2206, 90, 125, 150, 8, 10, 12);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2207, 2207, 210, 75, 80, 6, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2208, 2208, 150, 100, 115, 8, 10, 14);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2209, 2209, 65, 130, 170, 20, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2210, 2210, 90, 135, 140, 12, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2211, 2211, 225, 250, 300, 23, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2212, 2212, 95, 120, 150, 15, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2213, 2213, 50, 130, 185, 20, 80, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2214, 2214, 145, 100, 120, 10, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2215, 2215, 65, 130, 170, 20, 40, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2216, 2216, 90, 75, 100, 15, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2217, 2217, 100, 115, 150, 10, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2218, 2218, 175, 80, 110, 5, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2219, 2219, 165, 80, 120, 10, 20, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2220, 2220, 335, 10, 20, 1, 5, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2221, 2221, 245, 50, 70, 1, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2222, 2222, 10, 160, 195, 20, 60, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2223, 2223, 295, 30, 40, 3, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2224, 2224, 185, 80, 100, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2225, 2225, 110, 115, 140, 15, 30, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2226, 2226, 195, 20, 40, 5, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2227, 2227, 115, 100, 150, 10, 30, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2228, 2228, 165, 80, 120, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2229, 2229, 145, 100, 120, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2230, 2230, 125, 96, 144, 25, 45, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2231, 2231, 70, 199, 96, 8, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2232, 2232, 210, 59, 96, 5, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2233, 2233, 173, 144, 48, 10, 20, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2234, 2234, 144, 173, 48, 10, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2235, 2235, 219, 98, 48, 5, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2236, 2236, 96, 144, 125, 5, 50, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2237, 2237, 105, 165, 95, 5, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2238, 2238, 192, 77, 96, 5, 15, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2239, 2239, 100, 144, 121, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2240, 2240, 221, 96, 48, 3, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2241, 2241, 221, 96, 48, 2, 3, 5);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2242, 2242, 125, 96, 144, 4, 6, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2243, 2243, 15, 100, 250, 25, 50, 95);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2244, 2244, 215, 50, 100, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2245, 2245, 5, 100, 260, 20, 50, 78);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2246, 2246, 15, 100, 250, 30, 60, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2247, 2247, 100, 115, 150, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2248, 2248, 85, 130, 150, 25, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2249, 2249, 145, 100, 120, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2250, 2250, 70, 115, 180, 30, 50, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2251, 2251, 85, 100, 180, 30, 60, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2252, 2252, 300, 25, 40, 5, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2253, 2253, 30, 135, 200, 30, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2254, 2254, 100, 165, 100, 50, 70, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2255, 2255, 215, 70, 80, 8, 10, 12);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2256, 2256, 225, 65, 75, 6, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2257, 2257, 65, 135, 165, 40, 50, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2258, 2258, 215, 70, 80, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2259, 2259, 175, 150, 140, 25, 30, 35);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2260, 2260, 55, 150, 160, 55, 65, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2261, 2261, 270, 50, 45, 8, 9, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2262, 2262, 100, 165, 100, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2263, 2263, 100, 165, 100, 50, 100, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2264, 2264, 100, 165, 100, 15, 25, 40);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2265, 2265, 235, 60, 70, 6, 8, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2266, 2266, 65, 140, 160, 35, 40, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2267, 2267, 30, 150, 185, 40, 60, 70);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2268, 2268, 260, 55, 50, 8, 10, 12);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2269, 2269, 90, 145, 130, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2270, 2270, 50, 165, 150, 75, 100, 125);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2271, 2271, 295, 20, 50, 3, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2272, 2272, 50, 165, 150, 50, 75, 100);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2273, 2273, 165, 80, 120, 10, 35, 45);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2274, 2274, 305, 20, 40, 3, 15, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2275, 2275, 100, 165, 100, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2276, 2276, 100, 165, 100, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2277, 2277, 100, 165, 100, 35, 50, 75);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2278, 2278, 100, 160, 105, 10, 20, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2279, 2279, 100, 155, 110, 15, 25, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2280, 2280, 100, 125, 140, 6, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2281, 2281, 100, 105, 160, 10, 15, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2282, 2282, 100, 140, 125, 20, 40, 48);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2283, 2283, 100, 125, 140, 2, 5, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2284, 2284, 100, 160, 105, 20, 30, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2285, 2285, 105, 135, 125, 30, 50, 80);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2286, 2286, 100, 130, 135, 5, 10, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2287, 2287, 105, 140, 120, 5, 10, 10);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2288, 2288, 100, 155, 110, 5, 10, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2289, 2289, 100, 155, 110, 5, 7, 15);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2290, 2290, 100, 150, 115, 20, 15, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2291, 2291, 100, 155, 110, 20, 33, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2292, 2292, 100, 160, 105, 10, 25, 30);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2293, 2293, 100, 135, 130, 50, 90, 140);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2294, 2294, 100, 155, 110, 15, 20, 25);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2295, 2295, 100, 145, 120, 5, 5, 12);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2296, 2296, 60, 140, 165, 40, 70, 90);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2297, 2297, 340, 10, 15, 2, 7, 13);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2298, 2298, 250, 95, 20, 1, 3, 4);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2299, 2299, 165, 80, 120, 10, 30, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2300, 2300, 165, 80, 120, 20, 35, 50);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2301, 2301, 325, 15, 25, 3, 10, 20);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2302, 2302, 135, 100, 120, 20, 40, 60);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2303, 2303, 105, 150, 110, 100, 173, 250);
INSERT INTO `restoran_tingkat_kunjungan_avgs` VALUES (2304, 2304, 100, 155, 110, 20, 30, 50);

-- ----------------------------
-- Table structure for restorans
-- ----------------------------
DROP TABLE IF EXISTS `restorans`;
CREATE TABLE `restorans`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `restoran_klasifikasi_id` int NULL DEFAULT NULL,
  `restoran_pemilik` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_npwpd` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_alamat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `restoran_kecamatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_kelurahan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_rt` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_rw` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_jumlah_pegawai` int NULL DEFAULT 0,
  `restoran_kapasitas_kursi` int NULL DEFAULT 0,
  `restoran_pengeluaran_avg` double NULL DEFAULT 0,
  `restoran_potensi_pajak` double NULL DEFAULT 0,
  `restoran_persentase_pajak` double(8, 2) NULL DEFAULT 10,
  `restoran_telepon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_foto` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `restoran_status_tapping_box` int NULL DEFAULT 0,
  `status_aktif_id` int NULL DEFAULT 1,
  `restoran_latitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `restoran_longitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2305 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of restorans
-- ----------------------------
INSERT INTO `restorans` VALUES (457, 2, 'RIFKI (LEADER KARYAWAN)', 'P.2.02.0000151.14.02', 'STEAK 21 GIANT BAWAH', 'JL. JENDRAL AHMAD YANI HYPERMEGA BEKASI', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 4, 49, 80000, 56304000, 10.00, '02188962468', 'http://drive.google.com/uc?id=1RxuxtHZgpaSAxO6eH5Ay6BdUlSpWcd6c', 0, 1, '-6.249059', '106.9930814', 1, '2021-10-20 10:56:27', '2022-01-25 09:05:35', '2022-01-25 09:05:35');
INSERT INTO `restorans` VALUES (458, 2, 'RIFKI (LEADER KARYAWAN)', 'P.2.02.0000126.14.02', 'STEAK 21', 'JL. JEND. A. YANI', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 5, 52, 100000, 69800000, 10.00, '0218896821', 'http://drive.google.com/uc?id=1P6VHmuLMhI9ZOaBQmZHigpfjgVnvSdk2', 0, 1, '-6.2493305', '106.9935298', 1, '2021-10-20 10:56:27', '2022-01-25 09:06:14', '2022-01-25 09:06:14');
INSERT INTO `restorans` VALUES (459, 2, 'EDI AMIN', 'P.2.02.0001535.14.02', 'BROOASTER CHIKEN', 'JL. AHMAD YANI PINTU RAJAWALI LANTAI UG', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 6, 52, 35000, 55930000, 10.00, '081316801328', 'http://drive.google.com/uc?id=1mulRMQeZm21v4_wrq9UNUljSXnW2CV4u', 0, 1, '-6.249738', '106.9930494', 1, '2021-10-20 10:56:27', '2022-05-19 11:51:41', NULL);
INSERT INTO `restorans` VALUES (460, 2, 'FERONIA WIBOWO', 'P.2.02.0004483.14.02', 'CHATIME', 'JL.AHMAD YANI BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 6, 16, 30000, 0, 10.00, '082310444888', 'http://drive.google.com/uc?id=1aKidGhVhNYmSQWOmsVUjdyzk7JAKTt3s', 0, 4, '-6.2535443', '106.9894611', 1, '2021-10-20 10:56:27', '2022-06-28 08:05:55', NULL);
INSERT INTO `restorans` VALUES (461, 3, 'CV. NUSA PRIMA PANGAN', 'P.2.02.0000134.14.02', 'SOLARIA MEGA BEKASI ATAS', 'JL. JEND. A. YANI HYPERMALL MEGA BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 14, 74, 50000, 550000000, 10.00, '02188951566', 'http://drive.google.com/uc?id=1DK3ClDyXwaXDdfkwii_-W8r0VAxjwOUQ', 0, 1, '-6.2496065', '106.9929706', 1, '2021-10-20 10:56:27', '2022-04-14 08:14:54', NULL);
INSERT INTO `restorans` VALUES (462, 2, 'PT. MAHKOTA DUTA BINTANG JAYA', 'P.2.02.0004988.14.01', 'YUSRA INN', 'JL RAYA PEKAYON NO 1 RT 004 RW 022', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 7, 110, 75000, 136575000, 10.00, '02182410000', 'http://drive.google.com/uc?id=1BfvgDa9N_jzxPmu3yInMiGcMjbmh9vZX', 0, 1, '-6.2569804', '106.9904348', 1, '2021-10-20 10:56:27', '2021-10-20 10:56:27', NULL);
INSERT INTO `restorans` VALUES (463, 1, 'JEO SASANTO', 'P.2.02.0000119.14.02', 'PIZZA HUT GIANT', 'JL. AHMAD YANI HYPERMEGA BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 30, 114, 160000, 0, 10.00, '08113249094', 'http://drive.google.com/uc?id=1NJPoLR06MkdoI3pfK2KhfEOwIQ0vAcQt', 0, 4, '-6.249738', '106.9930494', 1, '2021-10-20 10:56:27', '2022-06-28 08:09:09', NULL);
INSERT INTO `restorans` VALUES (464, 2, 'PT. KULINER SUKSES BERJAYA', 'P.2.02.0003386.14.01', 'THAI STREET RESTAURANT', 'GRAND METROPOLITAN MALL LT. 2 NO. 1', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 7, 60, 50000, 0, 10.00, '02129577772', 'http://drive.google.com/uc?id=1iKAnnlmG0PanF5vDYtjexS2AXU_mu7eP', 0, 4, '-6.2495301', '106.9846695', 1, '2021-10-20 10:56:27', '2022-06-28 08:16:37', NULL);
INSERT INTO `restorans` VALUES (465, 2, 'CV. MATA AIR BAHAGIA', 'P.2.02.0002028.14.02', 'HOP HOP BUBBLE DRINK GIANT', 'JL. AHMAD YANI HYPERMEGA BEKASI', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 2, 0, 23000, 61686000, 10.00, '081317038827', 'http://drive.google.com/uc?id=184aWD5AxCLee_RtMaZS2WPGvlqJkizQR', 0, 1, '-6.24946', '106.9925612', 1, '2021-10-20 10:56:27', '2021-10-20 10:56:27', NULL);
INSERT INTO `restorans` VALUES (466, 2, 'EDWARD DJAJA', 'P.2.02.0005314.14.02', 'HEY KAFE', 'JL. A. YANI MEGA BEKASI HYPERMALL', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 3, 0, 20000, 59000000, 10.00, '082116227979', 'http://drive.google.com/uc?id=1F5-eKsJ_qmxd0cnzUyD9ZYmrIKuCH7bb', 0, 1, '-6.2494042', '106.9926123', 1, '2021-10-20 10:56:27', '2021-10-20 10:56:27', NULL);
INSERT INTO `restorans` VALUES (467, 2, 'RUSMININGSIH', 'P.2.02.0001753.14.01', 'RM. PRAMBANAN GUDEG JOGJA', 'JL RAYA PEKAYON NO 6A', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 13, 60, 50000, 222250000, 10.00, '08161994121', 'http://drive.google.com/uc?id=1vVTDnq9m-GGg4yt2eGxIqsx6tO3vGvTQ', 0, 1, '-6.256731183429931', '106.9903915798677', 1, '2021-10-20 10:56:27', '2022-04-14 09:35:46', NULL);
INSERT INTO `restorans` VALUES (468, 2, 'PT. PIONERINDO GOURMENT INTERNATIONAL', 'P.2.02.0003134.14.01', 'CFC REVO', 'JL A. YANI REVO TOWN', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 50, 42000, 126105000, 10.00, '089607498857', 'http://drive.google.com/uc?id=17qOjG44qphAo00tLzmbcUE30ohl41kLV', 0, 1, '-6.2545529', '106.990133', 1, '2021-10-20 10:56:27', '2021-10-20 10:56:27', NULL);
INSERT INTO `restorans` VALUES (469, 1, 'PT. NUSANTARA SEJAHTERA RAYA', 'P.2.02.0002327.14.01', 'CAFE METROPOLITAN XXI', 'GRAND METROPOLITAN', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 5, 50, 50000, 652250000, 10.00, '089612186309', 'http://drive.google.com/uc?id=1G-N6pQ_-SM7Gj-wrg9u9lXdblzEdfWHz', 0, 1, '-6.2493336', '106.9845172', 1, '2021-10-20 10:56:27', '2021-10-20 10:56:27', NULL);
INSERT INTO `restorans` VALUES (470, 1, 'SELLA ANDIRA', 'P.2.02.0002197.14.01', 'MC DONALDS PEKAYON', 'JL RAYA PEKAYON NO 66', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 48, 158, 60000, 2247030000, 10.00, '08118468765', 'http://drive.google.com/uc?id=1i-UF9h3Kw3c8gkRzw6uu-Im7uqImMYS-', 0, 1, '-6.26945807485163', '106.98172086449439', 1, '2021-10-20 10:56:27', '2022-04-14 09:42:10', NULL);
INSERT INTO `restorans` VALUES (471, 3, 'CV. MATA AIR BAHAGIA', 'P.2.02.0001648.14.02', 'HOPHOP BUBBLE DRINK', 'JL. A. YANI MEGA BEKASI HYPERMALL', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 2, 0, 25000, 21175000, 10.00, '082116228001', 'http://drive.google.com/uc?id=1T67gLhU1Yb-l292EeTAhw2S3rwIVMCIG', 0, 1, '-6.2497084', '106.9939222', 1, '2021-10-20 10:56:27', '2021-10-20 10:56:27', NULL);
INSERT INTO `restorans` VALUES (472, 1, 'PT. PANCA BOGA PARA MITRA', 'P.2.02.0002408.14.01', 'ICHIBAN SUSHI', 'GRAND METMALL NO 11', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 12, 30, 75000, 434625000, 10.00, '02129579994', 'http://drive.google.com/uc?id=1ICKO6buw_IWhlnLrOF0LjE1tEUsjsO0Z', 0, 1, '-6.2542841', '106.9900796', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (473, 1, 'ANTHONY', 'P.2.02.0003331.14.01', 'WARUNG TEKO', 'REVO TOWN JL. JEND.A. YANI', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 8, 240, 180000, 257508000, 10.00, '02182436939 / 02182437840', 'http://drive.google.com/uc?id=1l28Ay8CEmwDwpJcYlIhGWYCPJ5Yj9rxJ', 0, 1, '-6.254245', '106.9900619', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (474, 3, 'MELIWATI', 'P.2.02.0003038.14.01', 'POTATO CORNER', 'REVO TOWN LT. DASAR', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 0, 32000, 11984000, 10.00, '081318416062', 'http://drive.google.com/uc?id=1GaA_IP0xKZ6JlpgVoYPgw1I4Vr1Cyaxx', 0, 1, '-6.254194', '106.990078', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (475, 1, 'ALIUYANTO', 'P.2.02.0002029.14.02', 'SOLARIA LT. 2', 'JL. JENDRAL AHMAD YANI HYPERMEGA BEKASI LT. 2', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 14, 50, 80000, 624400000, 10.00, '02188965042', 'http://drive.google.com/uc?id=1IP057Ay_bQSw0XfjWSVHKHD56L0_gPCz', 0, 1, '-6.2494504', '106.9931775', 1, '2021-10-20 10:56:28', '2022-04-18 08:50:19', NULL);
INSERT INTO `restorans` VALUES (476, 2, 'PT. PANCA BOGA PARAMITA', 'P.2.02.0005305.14.01', 'ICHIBAN SUSHI', 'REVO TOWN', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 12, 60, 45000, 313020000, 10.00, '02182430282', 'http://drive.google.com/uc?id=1hqbnECdNkuFzGKZY_69345KcOWyPvERp', 0, 1, '-6.2552383', '106.9892577', 1, '2021-10-20 10:56:28', '2022-04-18 08:55:47', NULL);
INSERT INTO `restorans` VALUES (477, 3, 'CHAROLINE', 'P.2.02.0005042.14.04', 'XI-BOBA', 'JL RAYA PEKAYON NO 46 RT 007 RW 001', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 6, 24000, 33996000, 10.00, '087771764970', 'http://drive.google.com/uc?id=1U8T6BYyNGa4WdnnbwIZvYD-idIDADEeC', 0, 1, '-6.274552073180829', '106.97731559415409', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (478, 3, 'PT. ARIF CIPTA MANDIRI', 'P.2.02.0002369.14.01', 'A FUNG BASO SAPI ASLI', 'GRAND METROPOLITAN LT. 3', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 3, 28, 68000, 33830000, 10.00, '08111635192', 'http://drive.google.com/uc?id=1K7jKccqwpHN8vSgtNM_rq14lmtWSo7ud', 0, 1, '-6.2491305', '106.9854342', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (479, 2, 'PT. NUSANTARA TIMUR LESTARI', 'P.2.02.0002209.14.01', 'KOPITIAM EASTERN', 'GRAND METROPOLITAN LT. 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 7, 35, 50000, 98490000, 10.00, '02129579981', 'http://drive.google.com/uc?id=1xUPJR9TdjypSLTXnGxpVzLTb9OeuX-yZ', 0, 1, '-6.853643', '107.564445', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (480, 3, 'AGUNG PRASETYO', 'P.2.02.0004478.14.04', 'AYAM GEPREK JUARA', 'JL RAYA PEKAYON NO 05', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 36, 16500, 34402500, 10.00, '081113505637', 'http://drive.google.com/uc?id=1i6L5GRrimamJd_Ev1WDN5c92jaaOiSW-', 0, 1, '-6.2491368', '106.9854455', 1, '2021-10-20 10:56:28', '2022-04-07 08:45:27', NULL);
INSERT INTO `restorans` VALUES (481, 1, 'CV NUSA PRIMA PANGAN', 'P.2.02.0000793.14.01', 'SOLARIA BEKASI SQUARE', 'REVO TOWN', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 12, 191, 145000, 601764500, 10.00, '02182437838', 'http://drive.google.com/uc?id=1LeMSiCvQ6IFBwxozRDkg1I8_Fu8cs6up', 0, 1, '-6.2538647', '106.9899981', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (482, 1, 'PT. PANCA BOGA PARAMITA', 'P.2.02.0001064.14.02', 'TA WAN', 'JL. A. YANI MEGA BEKASI HYPERMALL', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 14, 100, 120000, 793416000, 10.00, '02188956345', 'http://drive.google.com/uc?id=19kdI8bzgqBlVduU16FgEJYTYC210DJJx', 0, 1, '-6.2537977', '106.9902019', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (483, 3, 'PT. J.CO DONUTS & COFFEE', 'P.2.02.0000768.14.01', 'J. CO DONUTS & COFFEE', 'REVO TOWN', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 6, 55, 30000, 371070000, 10.00, '02182434825', 'http://drive.google.com/uc?id=1A_FnsPINF08FpCdHy11ZsOhWzrwP80LR', 0, 1, '-6.2495978', '106.993327', 1, '2021-10-20 10:56:28', '2022-04-18 08:58:30', NULL);
INSERT INTO `restorans` VALUES (484, 1, 'PT. PANCA BOGA PARAMITA', 'P.2.02.0002377.14.01', 'TA WAN', 'GRAND METROPOLITAN MALL LT. 3', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 17, 84, 80000, 852400000, 10.00, '02129579970', 'http://drive.google.com/uc?id=1cnDplK1UitN-ue_kIhz48CoeEPREVSgG', 0, 1, '-6.2495978', '106.993327', 1, '2021-10-20 10:56:28', '2022-04-18 09:02:42', NULL);
INSERT INTO `restorans` VALUES (485, 2, 'EDWARD  TIRTANANA', 'P.2.02.0004418.14.02', 'KOPI KENANGAN', 'MEGA BEKASI HIPERMALL LT. 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 4, 10, 35000, 109585000, 10.00, '08179876069', 'http://drive.google.com/uc?id=13MQhfMUAmEvCP9bojivjVVXdSvXdtQEM', 0, 1, '-6.2495978', '106.993327', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (486, 2, 'BENNY CHANDRA', 'P.2.02.0005261.14.04', 'RAJA CAFE GALAXY', 'GRAND GALAXY CITY BLOK RGB NO 6', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 22, 150, 30000, 71430000, 10.00, '02182732222', 'http://drive.google.com/uc?id=1lhbMn5v7z1YVfN-QsBDOnBqz_utKS0Re', 0, 1, '-6.278421854876076', '106.97418194174764', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (487, 2, 'PT. MARCHE MULTIRASA INDONESIA', 'P.2.02.0002142.14.01', 'EAT & EAT', 'GRAND METROPOLITAN MALL LT. 03', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 30, 500, 45000, 1507905000, 10.00, '02129579822', 'http://drive.google.com/uc?id=1nTgFUvKJchd2qtFIPZLS0GERUUtoYaJ2', 0, 1, '-6.2500252', '106.9934005', 1, '2021-10-20 10:56:28', '2022-05-19 12:03:12', NULL);
INSERT INTO `restorans` VALUES (488, 3, 'PT. ANUGRAH ANTAR ASIA', 'P.2.02.0003164.14.02', 'POTATO CORNER', 'GIANT HIPERMALL BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 1, 0, 22000, 15510000, 10.00, '085843129670', 'http://drive.google.com/uc?id=1Lh0xI6-DbksFwx_WNeQllPtFU5b_AP5R', 0, 1, '-6.2499722', '106.9935699', 1, '2021-10-20 10:56:28', '2022-05-19 12:04:58', NULL);
INSERT INTO `restorans` VALUES (489, 3, 'RUDIANTO INDRA', 'P.2.02.0004319.14.02', 'MOCHI MOCHIO', 'JL. A. YANI MEGA BEKASI HYPERMALL', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 1, 0, 30000, 14820000, 10.00, '08176009168', 'http://drive.google.com/uc?id=1FupH5-7dWyDV1efnWUKRAyjT1rvYBFqv', 0, 1, '-6.2549822', '106.9901869', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (490, 1, 'PT. KURNIA BOGA NARAYAN', 'P.2.02.0004775.14.01', 'JANJI JIWA JILID 556', 'REVO TOWN LT. 1', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 8, 55000, 171352500, 10.00, '081196900679', 'http://drive.google.com/uc?id=13QHxjM1GJA9uQclQI9FIE7DBnd9-kJeD', 0, 1, '-6.2699859822227335', '106.97186823012956', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (491, 1, 'STEFANUS BUDHI', 'P.2.02.0004420.14.04', 'POCHAJJANG', 'GRAND GALAXY BLOK RGK 586', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, 81, 100000, 256000000, 10.00, '087883366899', 'http://drive.google.com/uc?id=1gvV_LfPKX-zKMWGlplkvliazsL60xvTb', 0, 1, '-6.2549639', '106.9901737', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (492, 3, 'PT. SUMBER NATURAL INDONESIA', 'P.2.02.0004898.14.02', 'GOLDON LAMIAN', 'JL. JENDRAL AHMAD YANI MEGA BEKASI HIPERMALL LT. 3', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 11, 32, 80000, 175200000, 10.00, '081292822756', 'http://drive.google.com/uc?id=1jn8gjWin0bf5HjcXyrU4meim3GnbN3xQ', 0, 1, '-6.2499644', '106.9936273', 1, '2021-10-20 10:56:28', '2022-05-19 12:06:36', NULL);
INSERT INTO `restorans` VALUES (493, 1, 'JENES SUDARTO', 'P.2.02.0003978.14.02', 'SHIHLIN TAIWAN STREET SNACK', 'JL. A. YANI MEGA BEKASI HYPERMALL', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 5, 8, 50000, 225100000, 10.00, '081573972555', 'http://drive.google.com/uc?id=1Ckw9CSGKlQ5DlNdtmISOiZJYSJRQ50Ku', 0, 1, '-6.2499871', '106.9936361', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (494, 1, 'PT. BUMI BERKAH BOGA', 'P.2.02.0004388.14.01', 'KOPI KENANGAN', 'REVO TOWN LT.1', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 10, 35000, 189910000, 10.00, '08811652828', 'http://drive.google.com/uc?id=1fe89DsPYlk-B8jd4yQAsipOjYhVU4Ma5', 0, 1, '-6.2551189', '106.9902917', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (495, 2, 'CV. NUSA PRIMA PANGAN', 'P.2.02.0002173.14.01', 'SOLARIA GRAND METROPOLITAN', 'GRAND METROPOLITAN MALL LT. 02', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 12, 80, 32000, 574080000, 10.00, '02129579968', 'http://drive.google.com/uc?id=1pBB6FDxc0oZtVBrEPAZ-602Gxhfb8cOY', 0, 1, '-6.270125553734686', '106.97177016387799', 1, '2021-10-20 10:56:28', '2022-05-19 12:07:54', NULL);
INSERT INTO `restorans` VALUES (496, 1, 'WIDA HESTI PUTRI', 'P.2.02.0003245.14.04', 'DAPUR COKLAT', 'GRAND GALAXY BLOK RGJ NO 567', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 14, 2, 125000, 395700000, 10.00, '02182732482', 'http://drive.google.com/uc?id=14IkzWqLUeLmUtH9HxwQIpMUH5dl4ZC7U', 0, 1, '-6.270125553734686', '106.97177016387799', 1, '2021-10-20 10:56:28', '2022-04-07 10:21:11', NULL);
INSERT INTO `restorans` VALUES (497, 2, 'PT. JAYA WIRA JERINDO', 'P.2.02.0003796.14.01', 'SHIHLIN TAIWAN STREET SNACKS', 'GRAND METROPOLITAN MALL LT. 1 NO. 03', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 5, 13, 50000, 135720000, 10.00, '087771075845', 'http://drive.google.com/uc?id=1WSz-Z4vJabevxq4S2MOV48rnb5ARN1LN', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (498, 2, 'PT. MULTIRASA NUSANTARA', 'P.2.02.0002018.14.05', 'YOSHINOYA GRAND METROPOLITAN', 'GRAND METROPOLITAN MALL LT. 1', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 11, 108, 50000, 747750000, 10.00, '085714763571', 'http://drive.google.com/uc?id=1z68dhILXQ_gysK2Xlv7Q8i0zYy20pHPy', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2022-04-14 09:41:09', NULL);
INSERT INTO `restorans` VALUES (499, 2, 'HERNI (LEADER KARYAWAN)', 'P.2.02.0002266.14.01', 'STEAK 21', 'GRAND METROPOLITAN MALL LT. 1', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 7, 40, 80000, 68960000, 10.00, '02129579844', 'http://drive.google.com/uc?id=1q3E4qkSh4lEzgOZ7-WtR91qXFihv3x63', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (500, 3, 'BEDI', 'P.2.02.0003664.14.01', 'PECEL LELE LELA', 'JL BOULEVARD PULO SIRIH SELATAN BLOK AE GALAXY NO 279', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, 72, 30000, 40185000, 10.00, '081282795533', 'http://drive.google.com/uc?id=1u5K2_8HZNp5SRgu8LQIqA8lDm87gcs4Z', 0, 1, '-6.263434367856679', '106.97229378680777', 1, '2021-10-20 10:56:28', '2022-03-21 11:15:15', NULL);
INSERT INTO `restorans` VALUES (501, 3, 'PT. NUSANTARA SEJAHTERA RAYA', 'P.2.02.0000774.14.01', 'CAFE REVO TOWN XXI', 'REVO TOWN', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 4, 0, 20000, 960000, 10.00, '02182424801', 'http://drive.google.com/uc?id=15UgB8Yixm5YPljF5DRpeX7Ck892wye0T', 0, 1, '-6.2538543', '106.9894795', 1, '2021-10-20 10:56:28', '2022-04-14 09:40:22', NULL);
INSERT INTO `restorans` VALUES (502, 3, 'TIDAK DIKETAHUI', 'P.2.02.0001117.14.01', 'HOKA-HOKA BENTO BEKASI SQUARE', 'REVO TOWN', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1GUF8V0cmOVSxhOHsxJFyc4uCLUkzkDiS', 0, 1, '-6.2550931', '106.9902919', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (503, 3, 'RESTA', 'P.2.02.0005389.14.01', '2 KANG KOPI', 'JL PULO SIRIH UTAMA NO 141 B RT 008 RW 013', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 5, 27, 25000, 23227500, 10.00, '0811552739', 'http://drive.google.com/uc?id=1h_zKXRYjeVdE5l1zjc42HEmta2pyQc1z', 0, 1, '-6.266132537205151', '106.97205337723234', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (504, 3, 'KARINA', 'P.2.02.0003039.14.01', 'POTATO CORNER', 'REVO TOWN LT.3', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 0, 25000, 21225000, 10.00, '081318416062', 'http://drive.google.com/uc?id=18WZAdYgPhgP7kOc-Do-O1-sTmxCaFWIx', 0, 1, '-6.2544694', '106.9900675', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (505, 3, 'PT. DWIDAYA MITRA PERKASA', 'P.2.02.0004906.14.01', 'LAVISTA RESTO', 'REVO TOWN', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 15, 32, 30000, 25140000, 10.00, '02182434832', 'http://drive.google.com/uc?id=1TfAHFdejF_99oQEftOqwbu9wB8kGv8Aw', 0, 1, '-6.2549452', '106.9900853', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (506, 3, 'PT. INDOMARCO PRISMATAMA', 'P.2.02.0004307.14.04', 'POINT CAFE', 'RUKAN GALAXI', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 7, 25000, 43337500, 10.00, '082299155232', 'http://drive.google.com/uc?id=1owbIMT94CMCwxVoziJyR3tdnB6MGxI4C', 0, 1, '-6.2705796', '106.9715423', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (507, 3, 'IBU JULIANA', 'P.2.02.0005194.14.04', 'FAT BOBBA GRAND GALAXY', 'TAMAN GALAXY PARK', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 33, 25000, 9662500, 10.00, '081218913799', 'http://drive.google.com/uc?id=1yIKqnlxkI4KbKq63TeVyl_Nl__giT1VT', 0, 1, '-6.2718614', '106.9708935', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (508, 1, 'BAPAK HOLIS', 'P.2.02.0003572.14.04', 'NOMI NOMI DELIGHT', 'RUKAN SENTRA OFFICE', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 12, 60, 150000, 299700000, 10.00, '08111274413', 'http://drive.google.com/uc?id=1B-wmblUN3-cbGR02m8b3v5g6jT62W72J', 0, 1, '-6.2714114', '106.9714373', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (509, 2, 'JAMES KONG', 'P.2.02.0004277.14.04', 'BAMBO DIMSUM', 'RUKO GRAND GALAXY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 81, 130000, 93197000, 10.00, '088223834385', 'http://drive.google.com/uc?id=1YlUyF5hJsqnZXxDEoKw191lw3PV-odGw', 0, 1, '-6.887051591501334', '107.61552096981207', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (510, 2, 'ABIGAL', 'P.2.02.0001799.14.02', 'IMPERIAL KITCHEN DAN DIMSUM', 'MEGA BEKASI HIPERMALL LT. 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 13, 84, 70000, 144886000, 10.00, '02188951475', 'http://drive.google.com/uc?id=1u14q8uXfq0v-ElLHPdvZFyDufteLpY86', 0, 1, '-6.2752171', '106.9746232', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (511, 1, 'ALI BUDIMAN', 'P.2.02.0004101.14.01', 'RAA CHA SUKI', 'MEGA BEKASI HIPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 11, 104, 80000, 560000000, 10.00, '0895372514416', 'http://drive.google.com/uc?id=1KMz4sQoH8FEsz70Pmv-DX0GHRa5LRE6_', 0, 1, '-6.2498913', '106.9932888', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (512, 1, 'ERWIN', 'P.2.02.0004212.14.02', 'RICHEESE FACTORY', 'MEGA BEKASI HIPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 9, 80, 77629, 432820489.5, 10.00, '02189458912', 'http://drive.google.com/uc?id=1c8eYR0wBH7zO9qesC7M7bxK4kOXNph00', 0, 1, '-6.250003', '106.9937632', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (513, 3, 'AGUSWANTO', 'P.2.02.0004406.14.01', 'CHOP BUNTUT CAKYO', 'MEGA BEKASI HIPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 6, 94, 60000, 22170000, 10.00, '02189458911', 'http://drive.google.com/uc?id=14yHQ2d5jEYtoDN-gNy5KXT4duCLG5MlV', 0, 1, '-6.2498161', '106.9938706', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (514, 1, 'YANSEN', 'P.2.02.0004341.14.02', 'RAMEN YA', 'JL. A. YANI MEGA BEKASI HYPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 11, 36, 80000, 572400000, 10.00, '08811548531', 'http://drive.google.com/uc?id=1xmDpI2lfkHpQqWDMyBgDNZxGXi6pBXET', 0, 1, '-6.2499441', '106.9938393', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (515, 2, 'PT. PENDEKAR BODOH', 'P.2.02.0001610.14.02', 'D COST MEGA BEKASI', 'MEGA BEKASI HIPERMALL LT. 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 15, 84, 50000, 98250000, 10.00, '087898774013', 'http://drive.google.com/uc?id=1HNvHI3OJxuUPfphtQtKoKapCLYPsvIG1', 0, 1, '-6.2500798', '106.9934097', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (516, 3, 'BAPAK LEO & BAPAK BINTANG', 'P.2.02.0005411.14.04', 'HITS BURGER BEKASI', 'RUKAN SENTRA NIAGA', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 32, 85000, 28305000, 10.00, '081282064156', 'http://drive.google.com/uc?id=1dHTujBohmr6Bzyqq_oAMkFgrUP3V_44O', 0, 1, '-6.272903', '106.9735951', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (517, 1, 'ALI BUDIMAN', 'P.2.02.0000989.14.02', 'GOKANA TEPAN MEGA MALL', 'MEGA BEKASI HIPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 15, 172, 90000, 1444707000, 10.00, '0218894025', 'http://drive.google.com/uc?id=1qzV7OlDRSo5GX2ulA9kF60AaplSIirU2', 0, 1, '-6.2500882', '106.9936731', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (518, 1, 'ALI BUDIMAN', 'P.2.02.0000988.14.02', 'BAKSO MALANG KARAPITAN', 'MEGA BEKASI HIPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 15, 172, 38000, 159676000, 10.00, '0218894025', 'http://drive.google.com/uc?id=1pvSEi9sYh6eoA8bIK1Kw14_TD72iyXWQ', 0, 1, '-6.2500973', '106.9937192', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (519, 3, 'JONI TANDRIANTO', 'P.2.02.0004122.14.02', 'PEMPEK KHAS PALEMBANG 10 ULU', 'JL. A. YANI MEGA BEKASI HYPERMALL LT. 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 2, 18, 100000, 28520000, 10.00, '08119881677', 'http://drive.google.com/uc?id=1DOaTbPz68UGQ3DyLRvnN8_G2iFXIUavv', 0, 1, '-6.2498783', '106.993773', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (520, 1, 'PT. SUSHI TEI INDONESIA', 'P.2.02.0004226.14.04', 'TOM SUSHI', 'GRAND GALAXY PARK', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 29, 120, 250000, 1970000000, 10.00, '02182753040', 'http://drive.google.com/uc?id=1OA65FVpWR6qrBRqI_VFKg5Jc06vmULS5', 0, 1, '-6.2714282', '106.9720896', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (521, 1, 'CV. REZEKI ABADI', 'P.2.02.0004576.14.04', 'SHIHLIN TAIWAN STREET SNACKS', 'MALL GRAND GALAXY PARK LT. 3', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 250, 55000, 193105000, 10.00, '089643374465', 'http://drive.google.com/uc?id=1T0Zxthh5aaxzF9N3Z3b8vCKKg6IIR6zI', 0, 1, '-6.2713362', '106.972287', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (522, 2, 'CV. MATA AIR HIDUP', 'P.2.02.0003689.14.04', 'HOP HOP THE BUBBLE DRINK', 'MALL GRAND GALAXY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 0, 25000, 63675000, 10.00, '081285871262', 'http://drive.google.com/uc?id=16O3X_-7fYtQJpgPIlfQRv9RvLVnhF3G6', 0, 1, '-6.2713248', '106.9722758', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (523, 3, 'RIRIN EKAWATI', 'P.2.02.0005084.14.04', 'STREET BOBA', 'JL BOULEVARD RAYA GRAND GALAXY CITY BLOK RGA NO 20', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 10, 24000, 34488000, 10.00, '08111178725', 'http://drive.google.com/uc?id=1NyYyrNDtZABNDHUKLmhaUadxq8tvKT-H', 0, 1, '-6.2710505', '106.9723084', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (524, 3, 'BAPAK RUSDI', 'P.2.02.0004233.14.04', 'KEDAI MIE EXPRESS', 'MALL GRAND GALAXY PARK LT. 3', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 250, 25000, 12725000, 10.00, '081290768651', 'http://drive.google.com/uc?id=1967uHeVXDLGkomMjKbmiX6MUODNKqqml', 0, 1, '-6.278180528126528', '106.97419488367457', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (525, 1, 'LAURA', 'P.2.02.0002079.14.02', 'BURGER KING MEGA MALL BEKASI', 'JL. A. YANI MEGA BEKASI HYPERMALL', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 12, 50, 70000, 407750000, 10.00, '02188965567', 'http://drive.google.com/uc?id=1JMFycr8Q5X5CIKA-Rv-F-h4M7nybmSNJ', 0, 1, '-6.2714331', '106.9722877', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (526, 2, 'SELVI HAMZANO', 'P.2.02.0005103.14.04', 'RM. SEI SAPI KANA', 'JL BOULEVARD RAYA GRAND GALAXY CITY RGB 7', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 16, 36, 100000, 138970000, 10.00, '082171792288', 'http://drive.google.com/uc?id=12C9CbpjHb9cwAocU4E6Z6x-3W1SEmDWD', 0, 1, '-6.278239168084351', '106.97420686316461', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (527, 1, 'PT. NUSANTARA SEJAHTERA RAYA', 'P.2.02.0000729.14.02', 'CAFE GIANT XXI', 'MEGA BEKASI HIPERMALL LT 4', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 7, 0, 75000, 311250000, 10.00, '082248285721', 'http://drive.google.com/uc?id=1z6G-AoynV7J3J-kUSwW_7oC8KmrcA8DC', 0, 1, '-6.2493903', '106.9931745', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (528, 2, 'MUHAMMAD FAJRI', 'P.2.02.0005299.14.04', 'KOPI CHUSEYO', 'JL BOULEVARD BARAT RAYA BLOK RGA NO 62', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 6, 30, 50000, 60910000, 10.00, '081280163080', 'http://drive.google.com/uc?id=1DVAd3ercpoOK5GbOimxVPPF1nNKXzmPB', 0, 1, '-6.276015032110627', '106.97446323239724', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (529, 2, 'SHARON SUTANTO', 'P.2.02.0004497.14.02', 'KOPI LAKA LAKA', 'MEGA BEKASI HIPERMALL LT 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 2, 0, 39000, 93522000, 10.00, '082134965004', 'http://drive.google.com/uc?id=1S7gRFPBikBRA2IMBaptmM1IoHxYGP4Qt', 0, 1, '-6.2500224', '106.9930593', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (530, 1, 'PT. NUSA PRIMA PANGAN', 'P.2.02.0000878.14.01', 'SOLARIA MEGA SITTING AREA ATAS', 'MEGA BEKASI HIPERMALL LT 1', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 13, 53, 100000, 532570000, 10.00, '0218841587', 'http://drive.google.com/uc?id=1lz4AA26abqeRZxhrF0rq5TR7yh7FuBSJ', 0, 1, '-6.2493802', '106.9924842', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (531, 3, 'PT. SINEMA AGUNG MANDIRI', 'P.2.02.0003795.14.01', 'POJOK MINUMAN', 'MALL GRAND GALAXY PARK LT. 3', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 1, 250, 8000, 22196000, 10.00, 'TIDAK TERSEDIA', 'http://drive.google.com/uc?id=13-bLKoI8yw57pExoz_4pum3BrMfMhyUE', 0, 1, '-6.2714519', '106.972226', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (532, 2, 'PT. DUNIA MAKMUR JAYA', 'P.2.02.0002503.14.02', 'BREADLIFE', 'JL. A. YANI MEGA BEKASI HYPERMALL LT. UG', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 1, 19, 40000, 57116000, 10.00, '087775053665', 'http://drive.google.com/uc?id=1La4TPVEnsSAUlxKxppZ08E3HvqNKjwRK', 0, 1, '-6.274376122155504', '106.97415406718356', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (533, 1, 'ARFIANSYAH', 'P.2.02.0004947.14.04', 'GEROBAK KOPI BANG RADEN', 'JL BOULEVARD RAYA NO 87', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 30, 100, 60000, 212970000, 10.00, '081383068745', 'http://drive.google.com/uc?id=1JVnLX1Q956hCV0krtXKmenNq_Oj0Xy25', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (534, 3, 'CICILIA M. M', 'P.2.02.0003262.14.04', 'DAPUR KUKIS', 'JL GRAND GALAXY CITY BOULEVARD RUKO RGA NO 088', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 10, 20000, 13084000, 10.00, '02182734386', 'http://drive.google.com/uc?id=1hpK3JEHEo6Ftukk9Vny8Y3UPuB_Z6VKY', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (535, 1, 'ENDRA ARIFIN', 'P.2.02.0001721.14.02', 'HOKA-HOKA BENTO', 'JL. A. YANI MEGA BEKASI HYPERMALL LT. UG', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 13, 44, 60000, 572400000, 10.00, '02188852317', 'http://drive.google.com/uc?id=18Vr_Fiw9e89-sxBQZ58LZKBwMm9QqL4o', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (536, 1, 'PT. J. CO DONUTS & COFFEE', 'P.2.02.0002101.14.01', 'J. CO DONUTS & COFFEE', 'GRAND METROPOLITAN MALL LT GROUND', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 8, 75, 80000, 236800000, 10.00, '02129585662', 'http://drive.google.com/uc?id=1rlIx5B_17Re1KWeGMcAZWqxflfUN-CEO', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (537, 3, 'ELANG', 'P.2.02.0005316.14.04', 'CEREAL BOX', 'JL BOULEVARD RAYA BLOK RGF 15', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 10, 36, 30000, 42420000, 10.00, '081315248324', 'http://drive.google.com/uc?id=1fgMSfYWeWk6EMb83jzp6tCr1mqUu1WZJ', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (538, 1, 'PT. PRIMA USAHA ERA MANDIRI', 'P.2.02.0009138.14.02', 'A & W FAMILY GIANT', 'MEGA BEKASI HIPERMALL LT UG', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 23, 110, 160000, 636400000, 10.00, '0216623456', 'http://drive.google.com/uc?id=1XRJFVitgWtLW14b8_Q-0J4gHMQIVDyr5', 0, 1, '-6.2497027', '106.9939503', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (539, 1, 'PT. SARI COFFE INDONESIA', 'P.2.02.0002202.14.01', 'STARBUCKS GRAND METROPOLITAN', 'GRAND METROPOLITAN MALL LT. GROUND', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 4, 45, 125000, 302500000, 10.00, '02129579937', 'http://drive.google.com/uc?id=1ysIiP4LLaTAm0z-asZXKAuAEEjOu6Tx6', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (540, 1, 'PT. TRANS COFFEE', 'P.2.02.0002126.14.01', 'COFFEE BEAN & TEA LEAF', 'GRAND METROPOLITAN MALL GF NO. 27', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 3, 50, 150000, 154425000, 10.00, '02129579852', 'http://drive.google.com/uc?id=16uQQvP-014Vy9rUJX4vMRqDnewpUVAyj', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (541, 1, 'NAUFAL', 'P.2.02.0005339.14.01', 'REDDOG', 'JL BOULEVARD RAYA BEKASI SELATAN, NO 10 RT 007 RW 018', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, 12, 200000, 323040000, 10.00, '081235612385', 'http://drive.google.com/uc?id=1H3GuhIDTdys-ZCi7ZZdt3JOkxgjg9KJE', 0, 1, '-6.2728812750532015', '106.97323344810422', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (542, 1, 'JIMMY WANTONO', 'P.2.02.0002663.14.02', 'ROTI O', 'JL. A. YANI MEGA BEKASI HYPERMALL LT. GF', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 5, 0, 36000, 216000000, 10.00, '085710496560', 'http://drive.google.com/uc?id=1itU6UiP19pZYNmpZLuYHPcoCf2rj7MH3', 0, 1, '-6.2495197', '106.9933286', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (543, 3, 'BOY LEONARD', 'P.2.02.0004850.14.01', 'KOKUMI', 'GRAND METROPOLITAN MALL LT LG. 2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 5, 3, 30000, 44100000, 10.00, '08128395757', 'http://drive.google.com/uc?id=1bkzUFL6Mph61z9LFto8EHRnf4S6BTQFA', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (544, 2, 'WILLIAM', 'P.2.02.0005203.14.04', 'KOPI JANJI JIWA', 'JL BOULEVARD GALAXY CITY BLOK RGG NO 35', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 29, 55000, 145007500, 10.00, '081389514911', 'http://drive.google.com/uc?id=1gwZnzIicA15ljWERX_EJ_PDq3Sc-LhYC', 0, 1, '-6.27248082126335', '106.97248113647349', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (545, 3, 'CV. MATA AIR BAHAGIA', 'P.2.02.0002384.14.01', 'HOP-HOP', 'GRAND METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'BEKASI SELATAN /PEKAYON JAYA', NULL, NULL, 2, 0, 25000, 49750000, 10.00, '081285871220', 'http://drive.google.com/uc?id=1z8t9-q5LFH4lq4j_opRnS_NqSXZ2clrI', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (546, 2, 'EDWARD', 'P.2.02.0005255.14.04', 'KOPI KENANGAN RUKO GALAXY BEKASI', 'JL BOULEVARD RAYA RT 004/019', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 50, 25000, 53007500, 10.00, '08170739219', 'http://drive.google.com/uc?id=1qexrB_oBVdEsyMqNIM9f30BF2iINVgMl', 0, 1, '-6.271224205934246', '106.97179207991988', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (547, 2, 'AYUNI MIRLINA', 'P.2.02.0002423.14.04', 'RM. SERBA SAMBAL (SS)', 'JL RAYA GALAXY BV 24 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 14, 80, 40000, 99220000, 10.00, '02182733957', 'http://drive.google.com/uc?id=1NLqBDBO_XC8WpGVAAGAs3TY9jo-Yy7NR', 0, 1, '-6.2615306023460215', '106.97250894989942', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (548, 2, 'PT. EXCELSO MULTIRASA', 'P.2.02.0002254.14.01', 'REST EXCELSO', 'GRAND METROPOLITAN MALL LT GF', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 4, 56, 80000, 77800000, 10.00, '02129464643', 'http://drive.google.com/uc?id=1MgNVZZjJclq8ukGIy9tWRam3GdysXNxF', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (549, 2, 'MUHAMMAD IRIAN', 'P.2.02.0005473.14.04', 'BURGER LUMER', 'JL BOULEVARD RAYA BLOK EB NO 153B', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 16, 50000, 94700000, 10.00, '081280381433', 'http://drive.google.com/uc?id=1gxsgtQ8hgW7G1xJgfLpV3qXUVDFKj36X', 0, 1, '-6.259021276615467', '106.97268806860431', 1, '2021-10-20 10:56:28', '2022-04-13 12:44:53', NULL);
INSERT INTO `restorans` VALUES (550, 3, 'HAIRUDDIN MALIK', 'P.2.02.0005258.14.01', 'BANGI CAFE', 'JL PULO SIRIH UTAMA E NO 137 RT 007 RW 014', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 10, 60, 50000, 39900000, 10.00, '082210000447', 'http://drive.google.com/uc?id=1IuLnoE2zsh50M6a-Y2YXu0goOs6PzRYJ', 0, 1, '-6.260787470002198', '106.97258394056286', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (551, 2, 'PT. HOTEL UTAMA BEKASI', 'P.2.02.0003194.14.02', 'RESTO SANTIKA', 'JL. A. YANI MEGA BEKASI HAYPERMALL', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 7, 120, 200000, 1470000000, 10.00, '02129285777', 'http://drive.google.com/uc?id=1-xAKTNErFGcE7kqIBZ6bM33lASuKByN_', 0, 1, '-6.2497509', '106.9936807', 1, '2021-10-20 10:56:28', '2022-04-27 09:05:44', NULL);
INSERT INTO `restorans` VALUES (552, 2, 'PT. PENDEKAR BODOH', 'P.2.02.0002517.14.01', 'D COST VIP', 'GRAND METROPOLITAN MALL LT 1', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 11, 50, 40000, 129800000, 10.00, '02129464646', 'http://drive.google.com/uc?id=11m4gZMwkPsaLjzyNc5w5VrVTPORivNij', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (553, 1, 'CHONG KOK YEOW', 'P.2.02.0002630.14.04', 'RICHEESE FACTORY', 'JL RAYA PEKAYON', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 15, 72, 80000, 643680000, 10.00, '02182438492', 'http://drive.google.com/uc?id=1EemW-kHoBvplUcHtCKFgT9ZlmIM9gJKP', 0, 1, '-6.277637151075785', '106.97545568468698', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (554, 3, 'PT. NUSA ARTHA SELARAS', 'P.2.02.0004261.14.01', 'GIANT SHABU', 'GRAND METROPOLITAN MALL LT. 1.NO 18', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1ceRCX0qWOfgCLhI9Bqx7j_eYOvHWG18v', 0, 4, '-6.246792916063806', '107.00625321148428', 1, '2021-10-20 10:56:28', '2022-04-14 09:43:15', NULL);
INSERT INTO `restorans` VALUES (555, 1, 'AMALIA ROSENO', 'P.2.02.0002522.14.02', 'REST. ASTORIA COFFE SHOP', 'JL. AHMAD YANI NO. 88', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 9, 60, 200000, 575000000, 10.00, '02122100000', 'http://drive.google.com/uc?id=14T6ITmFyWSXqJVwwpYBxsVBF0a2VWsGM', 0, 1, '-6.25045', '106.99217', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (556, 3, 'JUSIMA SUWANTO', 'P.2.02.0003133.14.01', 'LA CREPES & JUICE', 'METROPOLITAN MALL LT. 1 JL. JEND. A. YANI', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 0, 48000, 45480000, 10.00, '081803051108', 'http://drive.google.com/uc?id=1-_VoSP7Xgq3-KYAbqrbSVZUueqJAbcwX', 0, 1, '-6.24804', '106.99175', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (557, 3, 'JONI ANDREAN', 'P.2.02.0000656.14.01', 'J.CO DONUTS & COFFE', 'METROPOLITAN MALL LT 1', 'BEKASI SELATAN', 'PEKAYON Y', NULL, NULL, 12, 45, 30000, 44400000, 10.00, '02188861839', 'http://drive.google.com/uc?id=1iRSO7DUBDLxmwFt18ZXlTrNQ-gVj5cst', 0, 1, '-6.24804', '106.99175', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (558, 2, 'JEREMY', 'P.2.02.0003658.14.01', 'HOKKAIDO BAKED CHEESE TART', 'JL. KH. NOER ALI METROPOLITAN MAL LT. DASAR', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 3, 6, 100000, 100500000, 10.00, '0218848563', 'http://drive.google.com/uc?id=1PGJ6S5esrd1iclsGLpLBzVzTFxN-Nx0G', 0, 1, '-6.24817', '106.99166', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (559, 2, 'PT. KYATI SELERA ABYUDAYA', 'P.2.02.0003859.14.01', 'PAN & FLIP RESTAURANT', 'MALL METROPOLITAN LT. II', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 12, 125, 60000, 93300000, 10.00, '0218853309', 'http://drive.google.com/uc?id=161FJUAw1lXNDxCxnecKvdsWdFmXy29LI', 0, 1, '-6.24824', '106.9912', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (560, 2, 'TEDI', 'P.2.02.0003967.14.01', 'KOI THE', 'METROPOLITAN MALL BEKASI', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 7, 14, 30000, 84975000, 10.00, '0218853955', 'http://drive.google.com/uc?id=1AyJgGeGithKmQCUClVQN4zN29PzPniOp', 0, 1, '-6.24804', '106.99175', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (561, 3, 'OKY', 'P.2.02.0001579.14.01', 'PAPABUNZ BAKERY', 'JL. KH. NOER ALI METROPOLITAN MAL LT. 2', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 2, 0, 22000, 17712200, 10.00, '085101552700', 'http://drive.google.com/uc?id=1pm2nnt-BOtdm0hEJ0iUdegV28FAY8ERA', 0, 1, '-6.24817', '106.99166', 1, '2021-10-20 10:56:28', '2022-04-14 09:37:55', NULL);
INSERT INTO `restorans` VALUES (562, 1, 'PT. KYATI SELERA PARAMA', 'P.2.02.0003860.14.01', 'BAKSO LAPANGAN TEMBAK SENAYAN', 'METROPOLITAN MALL LT 3 NO. 25', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 17, 148, 50000, 226550000, 10.00, '0218861365', 'http://drive.google.com/uc?id=1A6QRtHy5R25tzWRThLH-gkJ_jikyIAd5', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (563, 1, 'DENI GUNAWAN', 'P.2.02.0004396.14.04', 'KOI CAFE', 'GRAND GALAXY PARK MALL LT GF-D6', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, 40, 60000, 211836000, 10.00, '087848493661', 'http://drive.google.com/uc?id=1UHDpmGsXRH6jhNE3lEypH4CW64AbKU2I', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (564, 1, 'AGUS SUWANTO', 'P.2.02.0002334.14.01', 'STEAK 21', 'GRAND GALAXY PARK LT GF', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 6, 92, 80000, 171712000, 10.00, '02129613138', 'http://drive.google.com/uc?id=1r-MLsp1Gpd71ZoPp3PUzeNMTQQtLPzH4', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (565, 1, 'KOKO JULIUS', 'P.2.02.0005304.14.01', 'PENYETAN COK', 'METROPOLITAN MALL BEKASI LT 3', 'BEKASI SELATAN', 'KAYURINGINJAYA', NULL, NULL, 4, 11, 200000, 195800000, 10.00, '087887960866', 'http://drive.google.com/uc?id=1inrmp64x6QcLpxRm5254e-paPsz1yI4n', 0, 1, '-6.24804', '106.99175', 1, '2021-10-20 10:56:28', '2022-04-27 09:54:18', NULL);
INSERT INTO `restorans` VALUES (566, 2, 'PT. PANCA BOGA PARAMITHA', 'P.2.02.0000616.14.01', 'TA WAN', 'METROPOLITAN MALL LT. 2', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 19, 106, 50000, 371250000, 10.00, '0218847714', 'http://drive.google.com/uc?id=1ZbQ3MmulKHiIszP0wUes0LXQ_4YIdfS-', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2022-05-20 09:48:56', NULL);
INSERT INTO `restorans` VALUES (567, 1, 'JHONNY ANDREAN', 'P.2.02.0002225.14.04', 'J.CO DONUTS & COFFE GRAND GALAXY PARK', 'JL RAYA GALAXY LT GF', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 12, 64, 70000, 714700000, 10.00, '02129613135', 'http://drive.google.com/uc?id=1PqjuCeznDhdUUrs2aF6vFzvuNVxFiuSO', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2022-05-30 10:23:30', NULL);
INSERT INTO `restorans` VALUES (568, 1, 'PT. EKA BOGA INTI', 'P.2.02.0000091.14.01', 'HOKA HOKA BENTO', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 12, 100, 50000, 1370000000, 10.00, '02188350388', 'http://drive.google.com/uc?id=1QUkYRGARoclX8O72aQheQ51bX6LLEURL', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2022-05-30 10:08:43', NULL);
INSERT INTO `restorans` VALUES (569, 2, 'AGUSWANTO', 'P.2.02.0004229.14.01', 'CHOP BUNTUT', 'JL. KH. NOER ALI METROPOLITAN MAL LT. 1', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 6, 68, 50000, 65175000, 10.00, '02188861992', 'http://drive.google.com/uc?id=1w5N-J6fDk37sI637HN1a9k3ccRN2avpN', 0, 1, '-6.24817', '106.99166', 1, '2021-10-20 10:56:28', '2022-05-30 09:54:52', NULL);
INSERT INTO `restorans` VALUES (570, 1, 'PT. AGUNG MANDIRI LESTARI', 'P.2.02.0004526.14.04', 'GENKI SUSHI', 'GRAND GALAXY PARK GROUND FLOOR', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 22, 132, 200000, 1237880000, 10.00, '02182744890', 'http://drive.google.com/uc?id=10lVFSy_673P9ujV63xdU8xaFTWM1Zcjs', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (571, 2, 'AGUS SUWANTO', 'P.2.02.0000093.14.01', 'STEAK 21', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 9, 28, 87000, 174435000, 10.00, '0218848609', 'http://drive.google.com/uc?id=1C--pzZ79f5hkigP2iRCIs_vGmlgWJihY', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2022-05-24 10:07:23', NULL);
INSERT INTO `restorans` VALUES (572, 3, 'CAFETARIA GALAXY TIRTAMAS', 'P.2.02.0000612.14.04', 'KANTIN GALAXY TIRTAMAS WATERPARK', 'BOULEVARD BLOK D', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 8, 10000, 16050000, 10.00, '02182415372', 'http://drive.google.com/uc?id=1jtDr-zwZE7V_B2dM4lNnYVowXpznP1oE', 0, 1, '-6.27247', '106.9715', 1, '2021-10-20 10:56:28', '2022-05-24 12:02:43', NULL);
INSERT INTO `restorans` VALUES (573, 1, 'ALIYU', 'P.2.02.0000659.14.01', 'SOLARIA MM II', 'METROPOLITAN MALL 11 LT. 3', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 16, 50, 150000, 676500000, 10.00, '02188861810', 'http://drive.google.com/uc?id=1C237At-rvAipHmWOcwqeT_2wfbM3rv8x', 0, 1, '-6.24804', '106.99175', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (574, 1, 'CV. NUSA PRIMA PANGAN', 'P.2.02.0002172.14.04', 'SOLARIA GRAND GALAXY', 'JL BOULEVARD GRAND GALAXY LT GF', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 16, 128, 80000, 861200000, 10.00, '02129613176', 'http://drive.google.com/uc?id=1MN1WGKN7EEwZ-8fpEkXOqC9Ruh0Btfwk', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2022-05-24 11:54:39', NULL);
INSERT INTO `restorans` VALUES (575, 1, 'PT. SARI COFFE INDONESIA', 'P.2.02.0002203.14.04', 'STARBUCKS GRAND GALAXY PARK', 'JL RAYA GALAXY LT GF', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 130, 75000, 410475000, 10.00, '02129613081', 'http://drive.google.com/uc?id=1dpWcb9j_RPImKIb25tKZY82rsgu0vH3Y', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (576, 1, 'SANDI AJI', 'P.2.02.0005099.14.04', 'KITA STEAMBOAT', 'RUKO GRAND GALXY CITI BLOK RGA', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 16, 150, 115000, 185150000, 10.00, '081806949494', 'http://drive.google.com/uc?id=1BZofMiI-6uV3bcNFxhSqGsBG8Q8ZZCw2', 0, 1, '-6.27628', '106.97444', 1, '2021-10-20 10:56:28', '2022-05-24 11:49:04', NULL);
INSERT INTO `restorans` VALUES (577, 1, 'PT. PRIMA USAHA ERA MANDIRI', 'P.2.02.0000089.14.01', 'A & W FAMILY', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 17, 50, 48000, 205440000, 10.00, '0218843188', 'http://drive.google.com/uc?id=17XIy5ecd1TZrAB4s1tvTnMPbcnpskeZD', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (578, 2, 'YULIANTI SARMILI', 'P.2.02.0003613.14.04', 'BAKSO KEMON', 'BOULEVARD GRAND GALAXY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 11, 53, 35000, 118492500, 10.00, '02182732775', 'http://drive.google.com/uc?id=1zfptEKL49Zo77IHVR3AO0RGDQQnSud_i', 0, 1, '-6.26569', '106.97199', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (579, 2, 'PT. JAYA WIRA JERINDO', 'P.2.02.0004582.14.01', 'SHIHLIN TAIWAN STREET SNACKS', 'METROPOLITAN MALL LT. 02.03', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 5, 14, 50000, 104125000, 10.00, '081573972555', 'http://drive.google.com/uc?id=1H1Xe3uyqpBbD02aKF9RFK1P-itss2-fr', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (580, 3, 'JIMMY', 'P.2.02.0002662.14.04', 'ROTI O', 'JL GRAND GALAXY BOULEVARD LT 1', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 5, 12, 24000, 36120000, 10.00, '081398604258', 'http://drive.google.com/uc?id=1afThT0dyh0BkW13gY5eNtqJkUDrem5qJ', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (581, 2, 'TIDAK DIKETAHUI', 'P.2.02.0004448.14.04', 'ROPANG OTW', 'PULO SIRIH UTAMA BLOK FE', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 25, 90, 35000, 94531500, 10.00, '02182755310', 'http://drive.google.com/uc?id=13n-UOLi_sxXpu9S1b-4mRpSf-6FhreBz', 0, 1, '-6.26527', '106.97202', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (582, 2, 'PT. DONER CITARASA MEDITERANIA', 'P.2.02.0004113.14.01', 'DONER KEBAB', 'METROPOLITAN MALL LT. 2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 9, 50, 60000, 147600000, 10.00, '0218838603', 'http://drive.google.com/uc?id=1Si_FTIqeYXXyhE78ucKvx9swa0Wy7H29', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (583, 2, 'PT. KURNIA BOGA NARAYAN', 'P.2.02.0004774.14.01', 'JANJI JIWA JILID 505', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 5, 14, 50000, 120750000, 10.00, '0895602305425', 'http://drive.google.com/uc?id=1ud0bV2Jo-r38hXyoMSy9yRmYWu7Czt3-', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (584, 2, 'PT. FOODS BEVERAGES INDONESIA', 'P.2.02.0002184.14.04', 'CHATIME', 'GRAND GALAXY PARK LT 1', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 10, 3, 30000, 127521000, 10.00, '02129613025', 'http://drive.google.com/uc?id=1z8q3OQCteXLe5eMd7rVHV19FUrxlaFrW', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (585, 1, 'PT. GRIYA MIE SEJATI', 'P.2.02.0000683.14.05', 'BAKMI GM', 'JL. KH. NOER ALI METROPOLITAN MALL 2 LT. 2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 26, 110, 55000, 177760000, 10.00, '0218861848', 'http://drive.google.com/uc?id=1r10Rcw5xttOsVpZsiEVut5B79P6OIIin', 0, 1, '-6.24855', '106.99138', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (586, 2, 'MIKEL', 'P.2.02.0003429.14.01', 'HOP HOP THE BUBBLE DRINK', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 7, 50000, 54900000, 10.00, '02129617113', 'http://drive.google.com/uc?id=1dZ3t7svY2DauttD8OxiEX6eL0Zz1Jv17', 0, 1, '-6.24804', '106.99175', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (587, 2, 'ISWADY SUSINDRA', 'P.2.02.0004667.14.04', 'YAMMIE HOT PLATE', 'JL. BOULEVARD GALAXY LT 2', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, 250, 50000, 138795000, 10.00, '02182754900', 'http://drive.google.com/uc?id=10vroVQnT-JWBl0qyiLWq9OFDE4S_-eva', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (588, 3, 'PT. INDOSTERLING WAHANA BOGA', 'P.2.02.0004776.14.01', 'BAKMI TOPIA', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 6, 35, 50000, 38625000, 10.00, '087800158986', 'http://drive.google.com/uc?id=1v7kx1CXxCdjUXpOcBm0Wb8NVqOvp6ey3', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (589, 2, 'GRESI', 'P.2.02.0001573.14.01', 'HOP HOP BUBBLE DRINK', 'JL. KH. NOER ALI METROPOLITAN MALL 2 LT. 3', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 0, 50000, 54250000, 10.00, '085691053435', 'http://drive.google.com/uc?id=1I3WjTruJ_mku0h3GC32AkBapdm3gAi_k', 0, 1, '-6.24855', '106.99138', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (590, 2, 'FLOREN', 'P.2.02.0003718.14.04', 'WAFFELICIOUS', 'GRAND GALAXY PARK LT 2', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 2, 25000, 56810000, 10.00, '083874832351', 'http://drive.google.com/uc?id=1wM-EIFiBdU-uLfniIMpPqOHKiBO-0E6i', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (591, 1, 'PT. ADI BOGA CIPTA', 'P.2.02.0000135.14.01', 'REST. HANAMASA', 'METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 20, 50, 188500, 463710000, 10.00, '0218853959', 'http://drive.google.com/uc?id=1ExO_eNa8pQd9xIo0p7eXFX8OFxIF-eHb', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (592, 3, 'DICKY KUSWIRA', 'P.2.02.0004860.14.04', 'ONEZO', 'GRAND GALAXY PARK LT 2', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 3, 35000, 28388500, 10.00, '081284274430', 'http://drive.google.com/uc?id=1ba-9Z8VlYrA_VLK9f8da1daT_AWc8I1d', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (593, 2, 'PT. ANUGERAH ANTAR ASIA', 'P.2.02.0003163.14.04', 'POTATO CORNER', 'GRAND GALAXY PARK LT 2', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 0, 50000, 71335000, 10.00, '0895330036660', 'http://drive.google.com/uc?id=1qt7pYcwW3ifogJme2t1jhPTQGH6qGVqf', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (594, 3, 'SYAHDIAN', 'P.2.02.0001091.14.01', 'RM. YOGEN FRUZ', 'METROPOLITAN MALL LT. DASAR', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 2, 0, 30000, 39300000, 10.00, '085718578515', 'http://drive.google.com/uc?id=1yuq8uSpLHHnVubwMmC6fWov4RpvpJw74', 0, 1, '-6.24842', '106.99072', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (595, 1, 'PT. SARI COFFEE', 'P.2.02.0000855.14.01', 'STARBUCKS COFFEE', 'METROPOLITAN MALL LT GROUND', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 7, 35, 100000, 465000000, 10.00, '02188861895', 'http://drive.google.com/uc?id=1mNXaTqDVgAw2uYBtnP4IUUumwtogQGbp', 0, 1, '-6.24842', '106.99073', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (596, 3, 'TIDAK DIKETAHUI', 'P.2.02.0000121.14.02', 'FOOD COURT GIANT', 'JL. A. YANI. MEGA BEKASI HYPERMALL LT. UG', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1YdskKRzdX8B4QLYYvkBloULXisEn9sKB', 0, 1, '-6.24855', '106.99138', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (597, 3, 'PT. MEGA GUNA GAJENDRA', 'P.2.02.0004028.14.04', 'KEDAI MANIAC', 'BOULEVARD RAYA BLOK A1', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 12, 80, 35000, 20475000, 10.00, '02182742849', 'http://drive.google.com/uc?id=1Jmx-0JS98wjvflyFLlCgBkjA7OH78EbB', 0, 1, '-6.26689', '106.97192', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (598, 2, 'PT. TEKKO FOOD', 'P.2.02.0000980.14.05', 'TEKKO FOOD KALIMALANG', 'JL. KH. NOER ALI NO. 13-14', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 9, 70, 70000, 85925000, 10.00, '02188860608', 'http://drive.google.com/uc?id=1eju4XQ_EHw-FKCiRDUkla2xbP8MEJVPq', 0, 1, '-6.24799', '106.98309', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (599, 2, 'PT. TRANS ICE', 'P.2.02.0000979.14.01', 'BASKIN ROBBINS', 'METROPOLITAN MALL LT DASAR', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 2, 0, 150000, 88500000, 10.00, '08567176951', 'http://drive.google.com/uc?id=1piJKMUsK-iVSvay9It7Nh5cSs07BBCfg', 0, 1, '-6.24799', '106.98309', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (600, 3, 'LENGKOFUR GUNAWAN', 'P.2.02.0003530.14.05', 'BANGI KOPI', 'JL. KH. NOER ALI NO.8 RUKO', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 9, 125, 20000, 13520000, 10.00, '087886494919', 'http://drive.google.com/uc?id=1QkSw65zXLpRUve7ekSN8IULSA9_uMDj7', 0, 1, '-6.24908', '106.96902', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (601, 2, 'PT. CHAMP RESTO', 'P.2.02.0001081.14.01', 'GOKANA TEPPAN', 'METROPOLITAN MALL  2 LT 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 16, 120, 30000, 131700000, 10.00, '02188862010', 'http://drive.google.com/uc?id=1D5CF0yc1Rb4dbH-D8Uu0He-jkkeuHcAX', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (602, 2, 'PT. CHAMP RESTO', 'P.2.02.0000987.14.01', 'BAKSO MALANG KARAPITAN', 'METROPOLITAN MALL LANTAI 2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 10, 163, 50000, 127500000, 10.00, '02188862012', 'http://drive.google.com/uc?id=14v9sWpgu7HSxwyOzJZM_rXoFw31WbDpU', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (603, 3, 'IBU DEVI', 'P.2.02.0000896.14.02', 'KANTIN MITRA KELUARGA', 'JL. A. YANI (DI DALAM RS MITRA DEKAT PARKIRAN MOBIL)', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 7, 20, 46000, 12981200, 10.00, '0218853333', 'http://drive.google.com/uc?id=1SJWSs_-WPhOjh1YKVGgQ-C83M3-WD-YY', 0, 1, '-6.24099', '106.99262', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (604, 2, 'PT. CHAMP RESTO', 'P.2.02.0000986.14.01', 'PLATINUM RESTO', 'METROPOLITAN MALL 2 LANTAI 1', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 10, 108, 80000, 122000000, 10.00, '02188861815', 'http://drive.google.com/uc?id=1PtnZtmwdmJ-OZg7KfGEjKNMztrIqPY0m', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (605, 1, 'PT. MOUNT SCOPUS INDONESIA', 'P.2.02.0005199.14.05', 'THE HARVEST', 'JL. KH. NOER ALI NO.46, RT.004/RW.007, KAYURINGIN JAYA, KEC. BEKASI SEL., KOTA BEKASI, JAWA BARAT 17610', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 16, 10, 300000, 181500000, 10.00, '085258895853', 'http://drive.google.com/uc?id=1hwfEdNTLN4aTN5Tzl3wYWYa4TKx4YiM1', 0, 1, '-6.24823', '106.98534', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (606, 2, 'PT. BUMI BERKAH BOGA', 'P.2.02.0004387.14.01', 'KOPI KENANGAN', 'METROPOLITAN MALL 2 LANTAI 2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 5, 0, 20000, 113500000, 10.00, '08179876073', 'http://drive.google.com/uc?id=1UCQAghxVkuv8WO4LTjmx3ouBnLrm5nDz', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (607, 2, 'YANTI YOHANA', 'P.2.02.0003414.14.05', 'MANG KABAYAN', 'JL. KH. NOER ALI NO. 88', 'BEKASI SELATAN', 'KAYU RINGIN JAYA', NULL, NULL, 9, 200, 60000, 102804000, 10.00, '02188860788', 'http://drive.google.com/uc?id=1FarGHqLWMRdZvuXMxjqBvrStPTt6hE-q', 0, 1, '-6.24757', '106.97894', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (608, 1, 'PT. BROSTINDO PRIMA', 'P.2.02.0000696.14.01', 'ICHIBAN SUSHI', 'METROPOLITAN MALL 2 LANTAI 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 13, 60, 40000, 161600000, 10.00, '02188861801', 'http://drive.google.com/uc?id=1KXQej421s364beIMUGuwbJt0bduXBuWg', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (609, 3, 'PT. GRAHA LAYAR PRIMA', 'P.2.02.0001556.14.05', 'RESTO BLITZ MEGA PLEX (CGV)', 'JL.KH NOER ALI BEKASI CYBER PARK LT. 3', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 3, 0, 20000, 8160000, 10.00, '08978166773', 'http://drive.google.com/uc?id=1_2owqC_IVbgLDSeWkzNHrEpNYpghERXO', 0, 1, '-6.24687', '106.99182', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (610, 3, 'PT. EXERTAINMENT INDONESIA', 'P.2.02.0000981.14.01', 'KANTIN SELEBRITY FITNESS', 'METROPOLITAN MALL 2 LANTAI 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 0, 0, 0, 0, 10.00, '02188852222', 'http://drive.google.com/uc?id=1FlD1ZBH3QvPjLvIJCv8VdkCVjgTKchfg', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (611, 3, 'HATNET SING', 'P.2.02.0001570.14.05', 'DOMINO PIZZA BCP', 'JL. KH. NOER ALI NO. 177 LT.1', 'BEKASI SELATAN', 'KAYU RINGIN JAYA', NULL, NULL, 13, 8, 16000, 49520000, 10.00, '02188966745', 'http://drive.google.com/uc?id=1GdR5YVU-jFLzmGnQjQGwb510leh4A-2b', 0, 1, '-6.24962', '106.98586', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (612, 1, 'JACKY HASJEM', 'P.2.02.0005201.14.04', 'SOGOGI SHABU GALAXY', 'JL BOULEVARD RAYA RGF NO 87', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 9, 68, 108000, 313740000, 10.00, '082111865180', 'http://drive.google.com/uc?id=17yJeTkgHchmOrFXhFD-gDYWVDgo85grD', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (613, 3, 'TRI AMBARSARI', 'P.2.02.0004671.14.01', 'RAMEN N SOSI BOX BY TAXON', 'METROPOLITAN MALL 2 LANTAI 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 3, 10, 50000, 28475000, 10.00, '089512143671', 'http://drive.google.com/uc?id=1OLtV26WoBCM1mArJsE8VuCjvYh7niwyf', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (614, 1, 'HENDRY', 'P.2.02.0005317.14.04', 'SASUKI BARS & GRILL', 'JL BOULEVARD RAYA RUKO RGA NO 82', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 6, 60, 110000, 249161000, 10.00, '082244351811', 'http://drive.google.com/uc?id=1uDPK-t73Rsr3JchG_PG0BfVYm_RCYYhr', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (615, 2, 'PT BALATS DWI TUNGGAL', 'P.2.02.0003392.14.02', 'BAKSO LAPANGAN TEMBAK SENAYAN', 'JL. A. YANI NO 5', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 25, 140, 42000, 110040000, 10.00, '02189453732', 'http://drive.google.com/uc?id=1thSn4T2Moo6IIK9qVYPKo2iCmrE0SsIZ', 0, 1, '-6.24004', '106.99349', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (616, 3, 'EDRIC IRAWAN', 'P.2.02.0004294.14.01', 'GULU GULU', 'METROPOLITAN MALL 2 LT 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 3, 0, 30000, 10650000, 10.00, '08119849821', 'http://drive.google.com/uc?id=1v4W2tpVwxgRvT7WPOC9Qv1iURDFKM8TM', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (617, 2, 'ISMAIL HASAN', 'P.2.02.0005184.14.04', 'MAHARANI COFFE', 'JL BOULEVARD RAYA BLOK RGB NO 86', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 50, 30000, 50220000, 10.00, '081281887497', 'http://drive.google.com/uc?id=1Ad0yomZWDad5yewyRsy2Eu4kak9-idKT', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (618, 2, 'MUHAMMAD JUNI ALI AKBAR', 'P.2.02.0004167.14.04', 'MASTER CHEESE PIZZA', 'GRAND GALAXY CITY BOULEVAR RGB 60', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 40, 60000, 80352000, 10.00, '081310689232', 'http://drive.google.com/uc?id=1r0fHgjMmJXzhX22J87QB2wtHOjb_fY8g', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (619, 2, 'PT. PRETZELINDO SUKSES PRATAMA', 'P.2.02.0003620.14.01', 'AUNTIE ANNE S', 'METROPOLITAN MALL LT DASAR', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 4, 20, 52000, 85280000, 10.00, '087888452768', 'http://drive.google.com/uc?id=1TTeo2Fa3cf2n8Ij7awzrioy-ay-s4_Vm', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (620, 3, 'HESTI NOVIASARI', 'P.2.02.0004874.14.04', 'SOTO SEDAP BOYOLALI', 'JL GRAND GALAXY PARK NO 12 DAN 15', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 15, 60, 15000, 33903000, 10.00, '082325060786', 'http://drive.google.com/uc?id=1cDV979WgnCk06Q2AhwBdshIj-dGUvtMm', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (621, 2, 'PT. FORE COFFEE INDONESIA', 'P.2.02.0004720.14.01', 'FORE COFFEE', 'METROPOLITAN MALL LT DASAR', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 5, 15, 34000, 130050000, 10.00, '08881029952', 'http://drive.google.com/uc?id=1chfG_xwmoEol0flIyH2zQJ1BWuGMe1MU', 0, 1, '-6.24919', '106.98962', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (622, 2, 'PT. SARI COFFE INDONESIA', 'P.2.02.0003872.14.01', 'STARBUCK COFFE', 'MALL LAGOON LANTAI LG', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 6, 37, 78000, 80527200, 10.00, '02185761286', 'http://drive.google.com/uc?id=1Ls0TLRrv9vXJXfr9y_YZjSkuDKTvTHfc', 0, 1, '-6.25049', '106.97856', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (623, 1, 'PT. FOODS BEVERAGES INDONESIA', 'P.2.02.0002148.14.01', 'CHATIME', 'GRAND METROPOLITAN MALL LT. B2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 5, 4, 32000, 155360000, 10.00, '02129579938', 'http://drive.google.com/uc?id=1aqWLVhxang-g6mmTLXRxRaJSl8f1EQaT', 0, 1, '-6.24294', '106.98902', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (624, 3, 'PT. BUMI SUBUR JUNAWI', 'P.2.02.0004176.14.02', 'RESTORAN DELTA SPA', 'JL. JEND. A. YANI NO.12', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 24, 110000, 28105000, 10.00, '0218841308', 'http://drive.google.com/uc?id=167EK-sU6DXWWsnTVbmcBL-pOu1Pf0_m4', 0, 1, '-6.24699', '106.99253', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (625, 1, 'PT. KURNIA BOGA NARAYAN', 'P.2.02.0004578.14.01', 'JANJI JIWA JILID 515', 'GRAND METROPOLITAN MALL LT. UG', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 3, 14, 50000, 188250000, 10.00, '081196900570', 'http://drive.google.com/uc?id=1Ylff7z97ZcNw0hLX12yjGZSslrpzc3-E', 0, 1, '-6.24294', '106.98902', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (626, 2, 'CV. SARI RASA NUSANTARA', 'P.2.02.0002072.14.01', 'SATE KHAS SENAYAN', 'GRAND METROPOLITAN MALL LT. UG NO. 23', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 11, 68, 94000, 134843000, 10.00, '02129573952', 'http://drive.google.com/uc?id=1r5Psk_puBSUzv6qOcbeA-mHxBhiRflsl', 0, 1, '-6.24294', '106.98902', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (627, 3, 'H. BUSTAMAN', 'P.2.02.0000107.14.02', 'RM. PADANG SEDERHANA', 'JL. A. YANI BLOK A7 NO.1, RT.005/RW.002', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 18, 60, 30000, 26865000, 10.00, '088293632793', 'http://drive.google.com/uc?id=1QU2nsMIMBkh0MmXuukIi1AIyWknJnSDp', 0, 1, '-6.24444', '106.99289', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (628, 2, 'PT. TRANS ICE', 'P.2.02.0002167.14.01', 'BASKIN ROBBINS', 'GRAND METROPOLITAN MALL LT 1', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 2, 24, 85000, 69190000, 10.00, '082298579231', 'http://drive.google.com/uc?id=1O30qNfVfG-szqkndXGbokv8zCEVtUanK', 0, 1, '-6.24294', '106.98902', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (629, 2, 'DEVIN', 'P.2.02.0001919.14.01', 'CHATIME', 'JL. JENDERAL A. YANI LIVING PLAZA', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 5, 4, 30000, 81780000, 10.00, '085778454125', 'http://drive.google.com/uc?id=16sxKYzumtKOAX-33j5ukAkfWtHovc2vs', 0, 1, '-6.24084', '106.99362', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (630, 2, 'AGUS SUWANTO', 'P.2.02.0002267.14.01', 'RED SUKI', 'GRAND METROPOLITAN MALL LT 2', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 6, 50, 60000, 83700000, 10.00, '02129579926', 'http://drive.google.com/uc?id=1JXuNdXRtkdK_ymVlSsaTFXS7gfN7Z5_x', 0, 1, '-6.24929', '106.98464', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (631, 1, 'PT. PAO 24 INDONESIA', 'P.2.02.0004033.14.01', 'PHO 24 VIETNAMESE NOODLE', 'GRAND METROPOLITAN MALL LT 3', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 7, 30, 150000, 248250000, 10.00, '02129579803', 'http://drive.google.com/uc?id=1gDM6NMS6afyfmgeYzKwpxddL3fSBcK71', 0, 1, '-6.24929', '106.98464', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (632, 1, 'PT. CJ FOODVILLE BAKERY AND CAFE', 'P.2.02.0003515.14.01', 'TOUS LES JOURS', 'JL. KH NOER ALI METROPOLITAN MALL LT. DASAR', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 6, 2, 70000, 199500000, 10.00, '02188861986', 'http://drive.google.com/uc?id=19Mg4CeAagiDoDOovMhnomnZUNEnPJh49', 0, 1, '-6.25046', '106.99164', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (633, 2, 'MUH. SUDI', 'P.2.02.0002694.14.01', 'RM. SEAFOOD TIGA DARA', 'JL RAYA PEKAYON RT 004 RW 020', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 10, 50, 50000, 93630000, 10.00, '081318180823', 'http://drive.google.com/uc?id=10g5AzzWalajnEYWGbVfxaVjTCtXEHP8K', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (634, 3, 'PT. GRAHA LAYAR PRIMA', 'P.2.02.0003659.14.01', 'REST. CGV CINEMA', 'MALL LAVE BEKASI / LAGOON AVENUE LANTAI 1', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 3, 37, 18000, 18583200, 10.00, '085695907497', 'http://drive.google.com/uc?id=1IgequPJEB30BviNUTHqf8XgcIbLTSAqo', 0, 1, '-6.25179', '106.97879', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (635, 1, 'ABIGAL', 'P.2.02.0002602.14.01', 'REST. IMPERIAL GRAND MALL', 'GRAND MALL LANT. 2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 16, 80, 90000, 519750000, 10.00, '02129464710', 'http://drive.google.com/uc?id=1taUDL6xfSLp4dk8fkoPMcx2a9U92uyW8', 0, 1, '-6.24787', '106.99144', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (636, 3, 'FABIANUS ABRAHAM NUGROHO', 'P.2.02.0005275.14.04', 'TARIDA PORK FINEST', 'JL GARDENIA 1 RRG 9 NO 52 RT 003 RW 017', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 5, 36, 50000, 33980000, 10.00, '081382732818', 'http://drive.google.com/uc?id=1GjBbjLyKRQiZ_MeC6pX97PCO_X4ljkch', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (637, 1, 'PT. CHAMP RESTO INDONESIA', 'P.2.02.0002249.14.01', 'RAA CHA SUKI', 'JL. KH. NOER ALI GRAND METROPOLITAN MALL LT.2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 16, 105, 80000, 245360000, 10.00, '081382034426 / 083819702929 (PA DANI)', 'http://drive.google.com/uc?id=1Iaz00DWEBPsbQPcSCSFXf4tfMA_RV0zi', 0, 1, '-6.25046', '106.99164', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (638, 3, 'TIDAK DIKETAHUI', 'P.2.02.0003337.14.04', 'RUMAH MAKAN PADANG KLASIK', 'JL BOULEVARD RUKO RGK NO 652', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 24, 15000, 12114000, 10.00, '02122103763', 'http://drive.google.com/uc?id=1ym0M8fJx6KVOK16WEyV0DqzwZvxK_ZrD', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (639, 2, 'CV. INTRA REZEQI', 'P.2.02.0004001.14.01', 'SHIHLIN TAIWAN STREET SNACK', 'LAVE MALL / LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 5, 13, 50000, 104475000, 10.00, '02135761170', 'http://drive.google.com/uc?id=1O7uY13UUxAUYQrIU3-e42KnayoU-bdli', 0, 1, '-6.25179', '106.97881', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (640, 2, 'PT. HARMONI ROYAL UTAMA', 'P.2.02.0002824.14.01', 'REST. CHINCHILLA', 'GRAND METROPOLITAN LT. 3', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 3, 31, 100000, 55900000, 10.00, '02129577755', 'http://drive.google.com/uc?id=1vDBCwE-oE3jmm9mTbFiCWzoCJWFA1s9-', 0, 1, '-6.24787', '106.99144', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (641, 3, 'ESTER MELIANA', 'P.2.02.0004585.14.01', 'DUM DUM THAI', 'JL.KH. NOER ALI GRAND METROPOLITAN MALL LT. LG2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 1, 3, 23000, 18699000, 10.00, '085776013550', 'http://drive.google.com/uc?id=1dgOnBq0ExEbCsgnCxHHUzvT34K6I0jma', 0, 1, '-6.25046', '106.99164', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (642, 1, 'PT. EKA BOGAINTI', 'P.2.02.0001624.14.04', 'HOKA-HOKA BENTO', 'JL RAYA GALAXY 9B', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 23, 150, 60000, 212790000, 10.00, '02182409621', 'http://drive.google.com/uc?id=1zRf5YUsbnW6X_8GdWF5MAb9W-6iZvvmG', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (643, 3, 'PT. NIKMAT ABADI', 'P.2.02.0004163.14.01', 'KING MANGO THAI', 'JL. KH. NOER ALI GRAND METROPOLITAN MALL LT. LG2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 3, 5, 35000, 20615000, 10.00, '081213455821', 'http://drive.google.com/uc?id=19HVcAVoY0JsRZE08LA1GiCRWAMGTWg-e', 0, 1, '-6.25046', '106.99164', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (644, 3, 'DWI MELIANA', 'P.2.02.0004586.14.01', 'MONTATO', 'GRAND METROPOLITAN MALL LT B2', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 2, 0, 30000, 43386000, 10.00, '085710772099', 'http://drive.google.com/uc?id=1-RVtv1CRlOTSQlTkr_DYC8wCb6QZmUv6', 0, 1, '-6.24787', '106.99144', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (645, 1, 'PT. ADICIPTA BOGA INTIPRIMA', 'P.2.02.0004025.14.01', 'IMPERIAL KITCHEN', 'LAGOON AVENUE LANTAI GF NO 12 A', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 15, 80, 70000, 161000000, 10.00, '02135761221', 'http://drive.google.com/uc?id=1CYgo6mOaNsHt8L6MbKTi8-OxKaXOY3fj', 0, 1, '-6.25118', '106.97862', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (646, 1, 'JANI', 'P.2.02.0001640.14.04', 'BEBEK H. SLAMET', 'JL RAYA GALAXY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 60, 50000, 157745000, 10.00, '0218202538', 'http://drive.google.com/uc?id=1hlj0Ncy8l1TddMQKZzPgPrxeH6vOLyaR', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (647, 2, 'PT. INDOSTERLING WAHANA BOGA', 'P.2.02.0005044.14.01', 'BAKMITOPIA', 'LAGOON AVENUE LANTAI LG', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 6, 36, 30000, 72030000, 10.00, '0859109688986', 'http://drive.google.com/uc?id=1c5tplMoxxKEUnIWgg0ahujAMfVM0ojA3', 0, 1, '-6.25121', '106.97867', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (648, 3, 'MUHAMMAD IQBAL HASARIF', 'P.2.02.0005226.14.01', 'A2 HOUSE COFFE', 'JL BOULEVARD RAYA BLOK EB NO 152A', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 30, 35000, 32406500, 10.00, '02182758992', 'http://drive.google.com/uc?id=1TyEL8uYliTl0qtPRoxaYDxudxZmXVRYw', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (649, 2, 'PT. FOODS BEVERAGES INDONESIA', 'P.2.02.0003981.14.01', 'CHATIME', 'LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 5, 9, 30000, 60780000, 10.00, '02135761883', 'http://drive.google.com/uc?id=18Nx-vHnOEQdWRpekmPcg4OYlEkWE0QGS', 0, 1, '-6.25123', '106.97866', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (650, 3, 'RIA DAMAYANTI', 'P.2.02.0004127.14.04', 'TERRA COFFE', 'JL. RAYA TAMAN GALAXY NO.5', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 6, 50, 60000, 47190000, 10.00, '02182745829', 'http://drive.google.com/uc?id=182euz0t1xmDzvH9d-yr5EqssjBVk22Dx', 0, 1, '-6.24787', '106.99144', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (651, 1, 'PT. DOM PIZZA INDONESIA', 'P.2.02.0002731.14.04', 'DOMINO\'S PIZZA', 'JL. TAMAN GALAXY NO. 3, RT.001/RW.011', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 16, 30, 95000, 365275000, 10.00, '0211500366', 'http://drive.google.com/uc?id=1NTtFv_2I3h_GpM4AeJ0qaparYwgtINMb', 0, 1, '-6.25455', '106.96876', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (652, 1, 'PT. SARI MELATI KENCANA', 'P.2.02.0000717.14.04', 'PHD VILLA GALAXY', 'JL PULO RIBUNG BLOK AR1 NO 25', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 16, 4, 100000, 374520000, 10.00, '08113248429', 'http://drive.google.com/uc?id=1c00XgnzbXZkZHcWu8RmV0_55X7syYM63', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (653, 2, 'PT. NUSA PRIMA PANGAN', 'P.2.02.0003947.14.05', 'SOLARIA LAGOON AVENUE', 'LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 11, 92, 55000, 81345000, 10.00, '082258288261', 'http://drive.google.com/uc?id=1n4Slvq4V7nKM2Y0p0bD9iU9PHeThu7BI', 0, 1, '-6.25164', '106.97885', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (654, 3, 'ARIF SUNGGONO', 'P.2.02.0004773.14.01', 'A FUNG BASO SAPI ASLI', 'LAGOON AVENUE', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 5, 43, 60000, 46410000, 10.00, '081112207476', 'http://drive.google.com/uc?id=1lPqTWfj9cSChK6VDhi1450Gy_pb3ppAV', 0, 1, '-6.25115', '106.97872', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (655, 3, 'PT. EXCELSO MULTIRASA', 'P.2.02.0004354.14.01', 'EXCELSO KAMALA LAGOON', 'MALL LAGOON LANTAI G', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 80, 35000, 17815000, 10.00, '02135761174', 'http://drive.google.com/uc?id=1cYDcO2ilgRU6CPHUfe3BOYf-HTxGf07y', 0, 1, '-6.25115', '106.97865', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (656, 3, 'MARIA', 'P.2.02.0004521.14.04', 'RM. PONDOK KENANGAN BARU', 'JL. TAMAN ASTER, RT.006/RW.014', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 4, 35, 30000, 9075000, 10.00, '0218211466', 'http://drive.google.com/uc?id=1UBKF6nAarZkONhe6Bn4TTJyriLhzvtjA', 0, 1, '-6.25958', '106.97025', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (657, 2, 'HAZIZUL FAHMI', 'P.2.02.0002317.14.02', 'RM. PONDOK INDAH RAYA', 'JL. KEMAKMURAN NO. 71 MARGAJAYA', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 7, 80, 33000, 90750000, 10.00, '02188966628', 'http://drive.google.com/uc?id=1IFKL2nBq-kwKT0U0eRIA3fcYYMmKSwYp', 0, 1, '-6.2441', '106.99457', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (658, 3, 'GRACE LUKMAN', 'P.2.02.0002574.14.01', 'REST. YUMMY TUMMY', 'JL. A. YANI NO. 8 APARTEMEN MUTIARA', 'BEKASI SELATAN', 'KAYURINGINJAYA', NULL, NULL, 6, 30, 30000, 6597000, 10.00, '02129285393', 'http://drive.google.com/uc?id=1PUNewtUIvbLK8bCP9Em8jegEjBs5vGTS', 0, 1, '-6.2590199', '106.9920829', 1, '2021-10-20 10:56:28', '2021-10-20 11:37:35', NULL);
INSERT INTO `restorans` VALUES (659, 1, 'PURWANDI S', 'P.2.02.0002996.14.01', 'SOP JANDA', 'JL. RAYA PEKAYON NO.11, RT.003/RW.002', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 7, 80, 50000, 171550000, 10.00, '02182405503', 'http://drive.google.com/uc?id=11isAL-fxBRHofJu-CdMwCVTNszrF5eRr', 0, 1, '-6.25737', '106.98809', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (660, 2, 'EDWARD', 'P.2.02.0005049.14.01', 'KOPI KENANGAN', 'JL. RAYA PEKAYON NO.29. NAGA PEKAYON', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 3, 40000, 109160000, 10.00, '08170756876', 'http://drive.google.com/uc?id=1WWdY8FF8juWPRRqE6vE8QLocDxjNnr8X', 0, 1, '-6.2649', '106.98634', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (661, 3, 'ERIK WS', 'P.2.02.0004533.14.01', 'KEDAI BEBEK BKB', 'JL. RAYA PEKAYON NO. 5', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 10, 60, 30000, 18675000, 10.00, '082182739471', 'http://drive.google.com/uc?id=1gLgwGZQrEI4yGj3SEVCiG7S4JHDmJ2pz', 0, 1, '-6.26773', '106.98335', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (662, 1, 'PT. MITRA ADI PERKASA', 'P.2.02.0004937.14.01', 'STARBUCKS', 'JL. PEKAYON', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 9, 50, 60000, 195870000, 10.00, '02182410047', 'http://drive.google.com/uc?id=1FtnZ8d_5bnPpuTjlkCKevhmS9SycSmJ6', 0, 1, '-6.2649', '106.98634', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (663, 2, 'ALI HARAHAB', 'P.2.02.0004953.14.01', 'MASALALU CAFE', 'JL. PULO RIBUNG NO.112, RT.001/RW.014', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 4, 300, 40000, 58960000, 10.00, '082249320102', 'http://drive.google.com/uc?id=1wh2KcpVDJ4dWmKbzxEUSnm8L1nAyCL8Q', 0, 1, '-6.26773', '106.98335', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (664, 3, 'PT. EATLAH INDONESIA', 'P.2.02.0004336.14.04', 'EATLAH BEGGKASI', 'JL. PULO SIRIH BLOK.AR', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 6, 5, 34000, 15463200, 10.00, '081220425491', 'http://drive.google.com/uc?id=1L_xAFmK7bZF84UOy-7rDoaX4ACkF3lJW', 0, 1, '-6.26788', '106.98283', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (665, 3, 'LARAS EMANUELLA PONGRANTE KALALINGGI', 'P.2.02.0004075.14.04', 'AYAM GORENG KARAWACI', 'JL. PULO SIRIH UTAMA FE 227', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 6, 28, 54000, 40251600, 10.00, '081289738529', 'http://drive.google.com/uc?id=10MlAOFIZ-fazBz4lg-qn_jQ86KYlemQC', 0, 1, '-6.26358', '106.97304', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (666, 3, 'TIDAK DIKETAHUI', 'P.2.02.0004849.14.04', 'MASTERPIECE SIGNATURE', 'JL. PULO SIRIH UTAMA , RUKAN GRAND GALAXY', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1KZeM-flf3nmsUOQ0_wR4h91_0vIBH-S1', 0, 1, '-6.26898', '106.97176', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (667, 1, 'PT. SARI BURGER INDONESIA', 'P.2.02.0003955.14.01', 'BURGER KING LAGOON AVENUE MALL', 'JL. KH NOER ALI LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 12, 120, 75000, 475200000, 10.00, '02135761782', 'http://drive.google.com/uc?id=1w-S1Q5ZR5Wau8aJ0rJ-FhBS6VNefIttt', 0, 1, '-6.25005', '106.97814', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (668, 2, 'PT. BUMI BERKAH BOGA', 'P.2.02.0004952.14.01', 'KOPI KENANGAN', 'LAVE MALL LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 4, 35000, 139877500, 10.00, '08170110173', 'http://drive.google.com/uc?id=1UMWQzJb9IhUFHg6NmFPGi8FwU0Lml_Sq', 0, 1, '-6.25009', '106.97821', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (669, 3, 'RONALD SETIAWAN', 'P.2.02.0005026.14.04', 'IZAKAYA NINKI', 'JL. BOULEVARD RAYA NO.96, RT.001/RW.002', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 8, 36, 100000, 40110000, 10.00, '02182755543', 'http://drive.google.com/uc?id=1ix7rorycMLgZvidd5G6xHOYDerJT4GV1', 0, 1, '-6.2737', '106.97389', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (670, 1, 'PT. SINEMA AGUNG MANDIRI', 'P.2.02.0903577.14.04', 'RESTORAN FLIX', 'JL. BOULEVARD GRAND GALAXI PARK', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 9, 18, 125000, 214937500, 10.00, '082113073576', 'http://drive.google.com/uc?id=1U95ZSnye4QGPWWtD0-mmGU2X1_6Ag9n9', 0, 1, '-6.2655', '106.9716', 1, '2021-10-20 10:56:28', '2021-10-20 10:56:28', NULL);
INSERT INTO `restorans` VALUES (671, 3, 'FITRI', 'P.2.02.0001823.14.04', 'AYAM BAKAR MAS MONO', 'JL. TAMAN GALAXY RAYA G NO.11, RT.002/RW.014', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 4, 36, 29000, 17081000, 10.00, '085750988143', 'http://drive.google.com/uc?id=1KjPAPDRhVxSmSQedh4EM2aVKntV_hlUz', 0, 1, '-6.2737', '106.97389', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (672, 3, 'REZHA', 'P.2.02.0005145.14.01', 'KOPI KANTO', 'LAVE MALL LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 3, 6, 28000, 27426000, 10.00, '082113186228', 'http://drive.google.com/uc?id=1uQlatalJviqbmoxPZtrdL-n-c3lN67Q_', 0, 1, '-6.25044', '106.97825', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (673, 1, 'GERRY PRAWIRA', 'P.2.02.0005173.14.01', 'KOPI JANJI JIWA', 'LAVE MALL LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 4, 4, 150000, 218700000, 10.00, '0895323001823', 'http://drive.google.com/uc?id=1jotE9NUZw9CMv69ilJwHgZMu6QoNRbAf', 0, 1, '-6.25045', '106.97824', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (674, 3, 'SAMAHAH MAHRIN', 'P.2.02.0002005.14.04', 'RM. SARI RAOS', 'JL. TAMAN GALAXY RAYA NO.A29, RT.001/RW.014', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 12, 30, 50000, 21250000, 10.00, '02182431507', 'http://drive.google.com/uc?id=1Y1W_n6N9y9gABtVblBR6aMbrG2C6UPNa', 0, 1, '-6.25751', '106.96846', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (675, 1, 'PT. DONER CITRARASA MEDITERANIA', 'P.2.02.0004669.14.04', 'DONER KEBAB', 'GRAND GALAXY PARK LANTAI 2', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 10, 0, 50000, 272050000, 10.00, '02182754900', 'http://drive.google.com/uc?id=1nrlblQ8Ng2IUzx-GnqiXqPVAQ6htCHjM', 0, 1, '-6.2655', '106.9716', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (676, 2, 'PT. DONER CITRARASA MEDITERANIA', 'P.2.02.0004668.14.01', 'DONER KEBAB', 'LAVE MALL LAGOON AVENUE LANTAI GF', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 9, 12, 40000, 68160000, 10.00, '02129572632', 'http://drive.google.com/uc?id=1-LKN4zbh97Bzp9LmV8o3gBlYxmftIoZV', 0, 1, '-6.25115', '106.97867', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (677, 1, 'SYAFWIDI', 'P.2.02.0002753.14.04', 'DOUBLE U STEAK', 'JL. WIJAYA KUSUMA NO.183, RT.001/RW.011', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 25, 100, 150000, 1095000000, 10.00, '02182732151', 'http://drive.google.com/uc?id=1d46CyB8TOLvAZff01Ingd2YaaA78JVPR', 0, 1, '-6.25751', '106.96846', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (678, 3, 'PT. INSPIRASI BISNIS NUSANTARA', 'P.2.02.0005193.14.04', 'HAUS!', 'JL. PULO RIBUNG NO.4, RT.002/RW.017', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 4, 12, 10000, 15720000, 10.00, '081354271439', 'http://drive.google.com/uc?id=1ILBUuH1VTamBVfXPw2Y4wfpWQ0_m6MoL', 0, 1, '-6.26713', '106.97428', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (679, 3, 'AMRI HIDAYAT', 'P.2.02.0005276.14.04', 'DIBAWAH TANGGA', 'GRAND GALAXY CITY BLOK RGA 090', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 38, 25000, 24815000, 10.00, '081210774361', 'http://drive.google.com/uc?id=1MbFF_jMVGkVfOS2tiOwN_JTx_qiQ2NFU', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (680, 2, 'RADTYA CAHYA OTENTIO', 'P.2.02.0004368.14.04', '8 EIGHTBARS', 'RUKAN SENTRA NIAGA BLOK.RSMB NO.56 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 9, 83, 100000, 117500000, 10.00, '081237601687', 'http://drive.google.com/uc?id=11zU0XsVd15pZEGAmYT5A60Msnp4mtkUW', 0, 1, '-6.2655', '106.9716', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (681, 3, 'ANDY SUSANTO', 'P.2.02.0005202.14.04', 'KWETIAUW SAPI APOLLO', 'BOULEVARD RAYA BLOK RGF 006', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 32, 50000, 38250000, 10.00, '081287770910', 'http://drive.google.com/uc?id=1FeobF73EAT4Bwbv4PMesDnmyaJVLW_iQ', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (682, 1, 'H. MIOTO', 'P.2.02.0005186.14.03', 'SAUNG CIKUNIR', 'JL. CIKUNIR RAYA NO.88B, RT.002/RW.002', 'BEKASI SELATAN', 'JAKA MULYA', NULL, NULL, 21, 700, 50000, 494500000, 10.00, '082111779216', 'http://drive.google.com/uc?id=1PAO-phrJC7y2j1VrE_pmFHF_M8Iue483', 0, 1, '-6.27205', '106.96237', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (683, 3, 'PT. RABEL GOFOOD INDONESIA', 'P.2.02.0005129.14.04', 'FASSOS', 'GRAND GALAXY CITY RUKO RGA 002-003', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 13, 0, 35000, 11777500, 10.00, '085975280782', 'http://drive.google.com/uc?id=1IbzhOq1cl7szidDCgjQP4f6UIatz56GF', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (684, 3, 'CARLO ELDILIAWAN', 'P.2.02.0005230.14.04', 'ES COW BAR', 'JL. NUSA INDAH RAYA BLOK U NO.54', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 1, 35, 21000, 6300000, 10.00, '081213519369', 'http://drive.google.com/uc?id=13ew7EkUXkfNTD3jb7PlV38JJgX21-UfZ', 0, 1, '-6.27559', '106.9736', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (685, 3, 'PT. RABEL GOFOOD INDONESIA', 'P.2.02.0005128.14.04', 'BANZAI BEKASI SELATAN', 'GRAND GALAXY RUKO CITY RGA 002-003', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 17, 0, 35000, 7920500, 10.00, '085883367177', 'http://drive.google.com/uc?id=1gCgnfW7ap3lMnQRoLhbELC8aLibMA5Gm', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (686, 2, 'FAJAR PRATAMA', 'P.2.02.0005150.14.04', 'JANJIAN COFFEE', 'JL. PONDOK TIMUR MAS BLOK A/4, RT.001/RW.014', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 8, 60, 45000, 79447500, 10.00, '081212638313', 'http://drive.google.com/uc?id=1cRQZ9b3LP23pDNsblzFM5ZJGv71-SPvf', 0, 1, '-6.25557', '106.97112', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (687, 3, 'PT. INTI PRIMA RASA', 'P.2.02.0003150.14.05', 'DELICO BAKERY', 'JL NOER ALI KAV 17-18', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 4, 20, 30000, 36468000, 10.00, '08111143749', 'http://drive.google.com/uc?id=1U43J3IVoJK-Z88aSQPE5jURJdvFDva2F', 0, 1, '-6.24786', '106.98373', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (688, 3, 'HJ. ABDULLAH MUTHOLIB', 'P.2.02.0000154.14.04', 'RESTORAN SEDERHANA GALAXY', 'TAMAN GALAXY RAYA NO 7A-B', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 18, 25000, 34132500, 10.00, '0218228888', 'http://drive.google.com/uc?id=1yNFEofWjdDqmziWab88vsZJbGWQmp168', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (689, 2, 'GERRY', 'P.2.02.0005185.14.04', 'OPPA CORNDOG', 'TAMAN GALAXY RAYA NO 11A', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 12, 13, 50000, 51880000, 10.00, '08977518924', 'http://drive.google.com/uc?id=1L0CsgbhFydJ2YoDzUKrn5Lp-QP8LLmkD', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (690, 3, 'PT. RASA DAPUR SEDAP', 'P.2.02.0004347.14.04', 'AYAM MANTUL', 'JL RAYA GALAXY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1J-ePlTh42zzlu6FE1PT2H4GMG48RttBa', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (691, 2, 'HM DADANG SUPRIYATNA', 'P.2.02.0000099.14.02', 'RM. PONYO', 'JL. KEMAKMURAN 21', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 15, 100, 40000, 71800000, 10.00, '0218894515', 'http://drive.google.com/uc?id=1ha9hseV9MbohESAyPnNETYoLeooK36Mr', 0, 1, '-6.25661', '106.97251', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (692, 1, 'CV. NUSA PRIMA PANGAN', 'P.2.02.0001504.14.05', 'SOLARIA BCP', 'BCP JL KH NOE ALI LANTAI GF', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 13, 100, 50000, 219500000, 10.00, '082189908505', 'http://drive.google.com/uc?id=1EbLWeWADdSfVh-fhvZZ-GRwjD9wwfqdq', 0, 1, '-6.24668', '106.99196', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (693, 3, 'PT. CIPTA ADIDAYA SEMESTA', 'P.2.02.0002329.14.04', 'FIESTA STEAK', 'GRAND GALAXY PARK LT 1', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1aED0EvkOQCEHu0J4a0jVS3uYoKPGCZvK', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (694, 1, 'PT. REKSO NASIONAL FOOD', 'P.2.02.0000082.14.05', 'MC DONALD', 'BCP LANTAI GF', 'BEKASI SELATAN', 'KAYURINGIM JAYA', NULL, NULL, 25, 210, 38000, 668800000, 10.00, '08111927335', 'http://drive.google.com/uc?id=1OOjzi5BajogrmGA1PB5IngWsLr3TwNyA', 0, 1, '-6.24654', '106.99195', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (695, 3, 'PT. TRANS ICE', 'P.2.02.0002207.14.04', 'BASKIN ROBBINS', 'GRAND GALAXY PARK LT GF', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1bNAXr06eDHJLSxvTgxKrSjbzYqH-Kci_', 0, 1, '-6.2650391', '106.9653441', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (696, 3, 'PT. PEGADAIAN', 'P.2.02.0004530.14.02', 'THE GADE COFFE GOLD', 'JL. IR. H. JUANDA NO.28', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 5, 30, 50000, 47550000, 10.00, '081119666622', 'http://drive.google.com/uc?id=15oPSC-D0kEPUoZZXGC9O7Nn-ems7LZYU', 0, 1, '-6.2384467', '107.0014394', 1, '2021-10-20 10:56:29', '2021-10-20 11:37:19', NULL);
INSERT INTO `restorans` VALUES (697, 3, 'SAMSIR', 'P.2.02.0002006.14.02', 'RM. MINANG SAIYO', 'JL. KEMAKMURAN 43 RT 001/005', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 0, 9, 15000, 12480000, 10.00, '081289376735', 'http://drive.google.com/uc?id=15vQu-nsgZ75MQE_FRLWcIy54aRkAjgE-', 0, 1, '-6.23835', '107.00204', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (698, 3, 'H. HARTI SUGIARTI', 'P.2.02.0001186.14.02', 'REST. GRIYA WULAN SARI', 'JL. KEMAKMURAN NO.15', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 17, 500, 33000, 10774500, 10.00, '02188960333', 'http://drive.google.com/uc?id=1_hY1Alw8lbG6PbGBTkEzfk1004exBZRR', 0, 1, '-6.23677', '106.99904', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (699, 3, 'H. HARTIKA', 'P.2.02.0000142.14.02', 'REST. WULANSARI', 'JL. KEMAKMURAN', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 20, 100, 100000, 49700000, 10.00, '02188963737', 'http://drive.google.com/uc?id=1b3pQutgqFNpQHcgdVFDbi-p3b8BKaxc5', 0, 1, '-6.23792', '106.99516', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (700, 1, 'H. ZULFARJAIN', 'P.2.02.0003375.14.05', 'RESTORAN SIMPANG RAYA', 'JL. JEND. SUDIRMAN NO.1, RT.004/RW.016', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 23, 200, 100000, 256400000, 10.00, '0218890106', 'http://drive.google.com/uc?id=1nXj9CujiXdGUXun2PIrWU5i6zIhIRoId', 0, 1, '-6.23354', '106.99115', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (701, 2, 'TIDAK DIKETAHUI', 'P.2.02.0005100.14.05', 'SOP DJANDA', 'JL. JEND. SUDIRMAN NO.16A', 'BEKASI SELATAN', 'KAYU RINGIN JAYA', NULL, NULL, 7, 45, 50000, 99325000, 10.00, '083822660949', 'http://drive.google.com/uc?id=1kznhsjIZ1IcDfq5IR8WKZpwr7-rvbJPz', 0, 1, '-6.24312', '106.99451', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (702, 2, 'YOYOK HERI WAHYONO', 'P.2.02.0003653.14.05', 'WAROENG SPESIAL SAMBAL SS', 'JL. JEND. SUDIRMAN NO.16A, RT.005/RW.017', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 32, 42, 25000, 123625000, 10.00, '085287300747', 'http://drive.google.com/uc?id=1ElnxRv0pDqv-4VUPaT30aQluLMz_XVhR', 0, 1, '-6.22988', '106.98505', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (703, 1, 'HESTI NOVIASARI', 'P.2.02.0004050.14.05', 'SOTO SEDAAP HJ. WIDODO', 'JL. SUDIRMAN NO.16A', 'BEKASI SELATAN', 'KAYU RINGIN JAYA', NULL, NULL, 15, 40, 50000, 295500000, 10.00, '085728748842', 'http://drive.google.com/uc?id=18QXDMnqB6NlmezWcW7VJDfgoS07ZHhWd', 0, 1, '-6.22987', '106.9851', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (704, 3, 'PT. PLATINUM WAHAB NUSANTARA', 'P.2.02.0005140.14.05', 'TEGUK', 'JL. RAJAWALI', 'BEKASI SELATAN', 'KAYU RINGIN Y', NULL, NULL, 3, 3, 13000, 30166500, 10.00, '081314990415', 'http://drive.google.com/uc?id=1WJnJSLO-8b4KVBBdouoaHRa4RmiqssG0', 0, 1, '-6.23842', '106.98216', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (705, 3, 'PT. SEBASTIAN CITRA INDONESIA', 'P.2.02.0005334.14.05', 'ROTI O', 'JL. RAJAWALI RAYA, RT.006/RW.002', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 1, 0, 24000, 13332000, 10.00, '082260794055', 'http://drive.google.com/uc?id=1nUmD0JrWTRAXKld68gW0AjBHEL2XR8ot', 0, 1, '-6.23841', '106.98211', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (706, 3, 'CV. LUMBUNG BERKAT SEJAHTERA', 'P.2.02.0004490.14.05', 'DE KINCIR', 'BCP LT 2 JL. KH NOER ALI', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 10, 200, 20000, 5400000, 10.00, '081511614116', 'http://drive.google.com/uc?id=1ClKb0fYm2g7aJLsmSiSgo_ur2RyvT3li', 0, 1, '-6.24699', '106.99158', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (707, 3, 'GEDION ABEDNEGO', 'P.2.02.0003398.14.05', 'GEDION ABEDNEGO CYBER FOOD', 'BCP LANTAI 1', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 5, 250, 20000, 28180000, 10.00, '08156095139', 'http://drive.google.com/uc?id=1Gd5ES1VwPHjjztBNvOY09KICihGHHxMC', 0, 1, '-6.24691', '106.9916', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (708, 3, 'YUDI', 'P.2.02.0003008.14.05', 'GEROBAK RAMEN', 'JL. JEND. A.YANI RUKO SNK', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 2, 22, 20500, 5217250, 10.00, '081211151980', 'http://drive.google.com/uc?id=1SPCo2QIN4JbbD_lkQ3Kdkm_n1Rkri1Es', 0, 1, '-6.23842', '106.98216', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (709, 3, 'HANDRA', 'P.2.02.0003513.14.05', 'FRENCH BAKERY & CAFE', 'RUKO SENTRA NIAGA KALIMALANG, JL. A.YANI, RT.001/RW.005', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 15, 30, 20000, 4250000, 10.00, '0218845422', 'http://drive.google.com/uc?id=1_A5cIuraw_cuq3tJEknr4OQsIc7r-ibM', 0, 1, '-6.23841', '106.98211', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (710, 3, 'TIDAK DIKETAHUI', 'P.2.02.0000921.14.05', 'MINA BAKERY', 'JL. KH. NOER ALI', 'BEKASI SELATAN', 'KAYU RINGIN JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=16IcY7KVn7BN0yrma7R_3CEs_zbttU2ED', 0, 1, '-6.23842', '106.98216', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (711, 3, 'TIDAK DIKETAHUI', 'P.2.02.0002852.14.05', 'SATE MARANGGI', 'JL. KH NOER ALI', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1wsCUeE72snouIa3NB6rnIFUX8r3HXs8w', 0, 1, '-6.24737', '106.99045', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (712, 2, 'PT. FOODS BEVERAGES INDONESIA', 'P.2.02.0001918.14.01', 'CHATIME', 'JL. KH. NOER ALI', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 7, 0, 25000, 57937500, 10.00, '0218845647', 'http://drive.google.com/uc?id=1aBpUEy1nTQqYHubLKCuAyl7z_17m6XVC', 0, 1, '-6.24582', '106.99022', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (713, 2, 'PT. FORE KOPI INDONESIA', 'P.2.02.0004893.14.02', 'FORE COFFE MEGA BEKASI', 'MEGA BEKASI (BANGUNAN DI LUAR GEDUNG MALL)', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 4, 42, 32000, 132512000, 10.00, '08881594348', 'http://drive.google.com/uc?id=1Ax1q78xoQX90niwbH_XJqLQpLRsPguk-', 0, 1, '-6.24894', '106.99276', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (714, 3, 'PT. MEGA BEKASI SEJAHTERA', 'P.2.02.0002365.14.02', 'WARUNG TEKKO', 'HYPERMART BEKASI LANTAI 3', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 10, 100, 65000, 43907500, 10.00, '02188967532', 'http://drive.google.com/uc?id=1lT14okSZ_ndgM4N7uw7R7iasUUhTHGgS', 0, 1, '-6.25003', '106.99349', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (715, 3, 'ANITA FIRDAUS', 'P.2.02.0001973.14.04', 'EIGHT COFFEE', 'JL. PULO SIRIH BARAT RAYA BLOK FE NO. 425', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 7, 18, 40000, 37140000, 10.00, '0218222555', 'http://drive.google.com/uc?id=1C34yn5Mrw67VKA6ETAFx6vJBp1eCaBrD', 0, 1, '-6.26404', '106.97113', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (716, 2, 'ATMA PRADITA', 'P.2.02.0002823.14.03', 'CV. DAHA CIPTA CATERING', 'TAMAN PERMATA CIKUNIR JL. KOALA VII BLOK A.7/40A', 'BEKASI SELATAN', 'JAKA MULYA', NULL, NULL, 0, 0, 150000, 104625000, 10.00, '081399960606', 'http://drive.google.com/uc?id=1EpHAXxUFgsAwufMfPv0ymAaKjijIIsVD', 0, 1, '-6.26386', '106.97109', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (717, 1, 'ALI SUSANTO', 'P.2.02.0002877.14.01', 'SKIES CAFE', 'REVO TOWN MALL LANTAI DASAR', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 15, 30, 300000, 183000000, 10.00, '02182429907', 'http://drive.google.com/uc?id=1qIXIpYsMX8WEdXyFOKrodVTi5kg8H96v', 0, 1, '-6.25408', '106.98904', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (718, 3, 'PT. PESONA MEENUM INDONESIA', 'P.2.02.0005023.14.04', 'MEENUM', 'JL. TAMAN ASTER NO.11, RT.006/RW.014', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 5, 6, 5000, 27375000, 10.00, '08977793323', 'http://drive.google.com/uc?id=1MBhoLxqI33x8ivMt-jIOt1lytlnPh0eq', 0, 1, '-6.25954', '106.97006', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (719, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005120.14.04', 'BOX & CO', 'RUKO CITY RGA 002-003 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1SQypnuLuU9NI6G8_qtPTIX8Yqd5kvqdk', 0, 1, '-6.2786', '106.97404', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (720, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005119.14.04', 'NASI AYAM AMBYAR', 'RUKO CITY RGA 002-003 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=15i2T3XxJhjYfCTTLUEQ5jLo5YuoreNW5', 0, 1, '-6.27861', '106.97403', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (721, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005121.14.04', 'BURGER BROS', 'RUKO CITY RGA 002-003 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKA SETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1EA1NJ8FLpEtcZiaktbMhT-QfzJphI6cv', 0, 1, '-6.2776', '106.97373', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (722, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005025.14.04', 'MARUGAME UDON', 'RUKO CITY RGA 002-003 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1i_DV9GkNdTQrsNZpQSEVBYS1I8_eoY-w', 0, 1, '-6.27757', '106.97372', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (723, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005118.14.04', 'KOPI FEELING BREW', 'RUKO CITY RGA 002-003 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=17GtmvJjCEZ5kD5sugIjLe_5RNMm36hIp', 0, 1, '-6.27756', '106.97372', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (724, 2, 'PT. MITRA PERTIWI PROPERTINDO', 'P.2.02.0004851.14.02', 'KAWASAN KULINER KOTA BEKASI (APARTEMENT GRAND CENTER POINT)', 'JL. TERUSAN ASRAMA HAJI', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 360, 400, 40000, 110600000, 10.00, '02128088000', 'http://drive.google.com/uc?id=1Q-DjIQNtS90exxqk71S3Mw7ZDYiqwbSi', 0, 1, '-6.24454', '106.99409', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (725, 1, 'TONI NUGROHO', 'P.2.02.0000834.14.02', 'PEMPEK GABY', 'JL. IR. H. JUANDA NO.7, RT.003/RW.006', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 6, 28, 40000, 154520000, 10.00, '081574255609', 'http://drive.google.com/uc?id=1TYKacwyeVfhtNRovgRqp8KcTXIjiZJSN', 0, 1, '-6.23686', '106.9989', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (726, 2, 'AGUS SUWANTO', 'P.2.02.0002448.14.01', 'REST. RED SUKI', 'JL. JEND. A. YANI', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 6, 90, 60000, 54750000, 10.00, '0218848607', 'http://drive.google.com/uc?id=1NoA_40bCcU3lBdxgHPA1BsHhwBWqIAOV', 0, 1, '-6.25694', '106.99052', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (727, 3, 'PT. KURNIA BOGA NARAYAN', 'P.2.02.0004450.14.05', 'KOPI JANJI JIWA', 'JL. KH. NOER ALI NO.25, RT.001/RW.005', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 4, 30, 18000, 34653600, 10.00, '081214824833', 'http://drive.google.com/uc?id=1EwuI8hmuyHmde6m8GfFVQBqeA5FxHUht', 0, 1, '-6.24707', '106.99143', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (728, 3, 'TIDAK DIKETAHUI', 'P.2.02.0000737.14.02', 'J.CO DONUTS & COFFEE', 'JL. A.YANI NO.89-142, RT.004/RW.001', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1LqJkwI5DCgFGToLiHOfXhnDa1DYkmcoR', 0, 1, '-6.24915', '106.99241', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (729, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005363.14.02', 'LUV CAFE', 'JL. JEND. A. YANI', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=16qwd3Ct7ucrmjQoBfsxWe9ll4fAjwixN', 0, 1, '-6.24849', '106.99212', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (730, 2, 'PT. TIGA SAUDARA SEJAHTERA', 'P.2.02.0003006.14.01', '3 COOPS', 'JL. PEKAYON NO. 150', 'BEKASI SELATAN', 'PEKAYON', NULL, NULL, 8, 70, 50000, 51125000, 10.00, '02182736011', 'http://drive.google.com/uc?id=1VGWU3eIwizz1IhMoIn83CujAKn9ZEGUn', 0, 1, '-6.26272', '106.98689', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (731, 2, 'AGUS SUKMANA', 'P.2.02.0004928.14.04', 'SATE TAICHAN BENGAWAN', 'BOULEVARD RAYA TIMUR BLOK RGB NO 68', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 17, 63, 40000, 122640000, 10.00, '081294180735', 'http://drive.google.com/uc?id=1D3jRqcf9HSMR7qY8SXQWQ65J-LOkLmDL', 0, 1, '-6.27665', '106.973', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (732, 3, 'YUSUF TANJUNG', 'P.2.02.0003005.14.02', 'RM. SEDERHANA LINTAU', 'JL VETERAN RT 005/003', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 10, 90, 30000, 42117000, 10.00, '081280082403', 'http://drive.google.com/uc?id=1T8hnOgK6ipkG-fhn0IPtE6XIuRYiHEyp', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (733, 2, 'SAID BALDIE SOESMAN', 'P.2.02.0005242.14.04', 'PAPANUNS KITCHEN', 'BOULEVARD RAYA BLOK RGA NO 86', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 6, 62, 55000, 55154000, 10.00, '08212435144', 'http://drive.google.com/uc?id=1hDFqBcgp2Ie3CYFYIJexQvLPCEqD1GyY', 0, 1, '-6.27665', '106.973', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (734, 2, 'ERNA MELIASARI', 'P.2.02.0003884.14.02', 'LA CONE CAFE', 'JL VETERAN RT 005/003', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 4, 70, 60000, 89760000, 10.00, '02189455218', 'http://drive.google.com/uc?id=1vavfjD2ZrCYfA9jP59bySz8tF1b5tIn1', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (735, 2, 'DEPAT SETYAWAN', 'P.2.02.0002618.14.04', 'RAFFEL\'S RESTORAN / SANDWICH', 'BOULEVARD RAYA BLOK RGF 001', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 45, 70000, 57232000, 10.00, '02129571224', 'http://drive.google.com/uc?id=1O0u1MAVbW-wcEuQaIhhN7Q6a399vtyWq', 0, 1, '-6.27294', '106.97382', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (736, 3, 'WIDRA', 'P.2.02.0005141.14.05', 'MEENUM', 'JL GURAME RAYA NO 1 RT 07/03', 'BEKASI SELATAN', 'KAYURINGIN JAYA', NULL, NULL, 2, 5, 20000, 32596000, 10.00, '081283993496', 'http://drive.google.com/uc?id=1ReWm96sx85lZkFNXX9sAGjUpzx_ThtNt', 0, 1, NULL, NULL, 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (737, 1, 'AGUSTINA BATUBARA', 'P.2.02.0005260.14.02', 'SEAFOOD LARIS MANI', 'JL. HASIBUAN', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 13, 50, 200000, 496100000, 10.00, '081283419944', 'http://drive.google.com/uc?id=1CvN7PH4dYp_korL5IyM1xN-9zQj3nbtP', 0, 1, '-6.24883', '106.99748', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (738, 3, 'TIDAK DIKETAHUI', 'P.2.02.0005263.14.02', 'KOPI LAIN HATI', 'JL. MAYOR MADMUIN HASIBUAN NO.72', 'BEKASI SELATAN', 'MARGA JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1W0ZgdoV_Kgtnzno-eBQsbVHr0SJQqqm-', 0, 1, '-6.24325', '106.99994', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (739, 1, 'PT. METROPOLITAN LAND., TBK', 'P.2.02.0000002.14.01', 'GEDUNG PERTEMUAN HOTEL HORISON', 'JL. KH NOER ALI', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 73, 1000, 250000, 4200000000, 10.00, '0218848888', 'http://drive.google.com/uc?id=15iYJHHhRiQimt5wWI1EfY8llyhG_asOQ', 0, 1, '-6.24834', '106.98983', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (740, 3, 'PT. METROPOLITAN LAND., TBK', 'P.2.02.0000111.14.01', 'RESTORAN MALABAR HORISON', 'JL. KH NOER ALI KALIMALANG', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 0, 150, 0, 0, 10.00, '0218848888', 'http://drive.google.com/uc?id=13gGxBEnzV_lE-HRD5yHyTWiLcuAzdi-U', 0, 1, '-6.24836', '106.99002', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (741, 1, 'ANDREAS RESHA JUNIANTO', 'P.2.02.0005067.14.01', 'MOON CHICKEN BY HUNGRY', 'JL. PULO SIRIH SELATAN BOULEVARD BLOK AE', 'BEKASI SELATAN', 'PEKAYON JAYA', NULL, NULL, 20, 0, 70000, 658700000, 10.00, '081197301624', 'http://drive.google.com/uc?id=1UZkgdgn1Bj2EG2mE80pRQ-7n72i6NX9U', 0, 1, '-6.26445', '106.97238', 1, '2021-10-20 10:56:29', '2021-10-20 10:56:29', NULL);
INSERT INTO `restorans` VALUES (878, 2, 'PT. SARI COFFEE INDONESIA', 'P.2.02.0004883.11.02', 'STARBUCKS', 'JL. IR. H. JUANDA TRANSPARK JUANDA LT. 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 6, 50, 55000, 148500000, 10.00, '02129101079', 'http://drive.google.com/uc?id=1c7wv0gSOeJGD3PYxy6d1e3Sbqh6zVSvz', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (879, 1, 'PT. CHAMP RESTO', 'P.2.02.0004315.11.02', 'GOKANA TEPPAN', 'TRANSPARK JUANDA LT. 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 28, 100, 50000, 182750000, 10.00, '02182695199', 'http://drive.google.com/uc?id=1jtZKky-m6_mvTuSgrDSHVzuh1-M75qah', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (880, 1, 'PT. CHAMP RESTO', 'P.2.02.0004316.11.02', 'RAA CHA SUKI', 'TRANS PARK JUANDA LT. 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 12, 80, 60000, 197250000, 10.00, '02182695199', 'http://drive.google.com/uc?id=1nbrX-Rre4FZRUyENDF5iiDwM0IALGBb6', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (881, 1, 'PT. PENDEKQR BODOH', 'P.2.02.0004262.11.02', 'D COST', 'TRANSARK JUANDA LT. DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 10, 110, 60000, 308550000, 10.00, '0213523857', 'http://drive.google.com/uc?id=1dQzQ1Ov_p-HalRTkVgY6I4LXBDCH0jI3', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (882, 3, 'PT. KOI CAFE INDONESIA', 'P.2.02.0004914.11.02', 'KOI THE', 'TRANSPARK JUANDA LT. DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1xkEV2F0qwPFiCWMYa_2Myky1nRyGpRTO', 0, 4, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2022-06-07 12:30:12', NULL);
INSERT INTO `restorans` VALUES (883, 1, 'PT. FOOD BEVERAGES INDONESIA', 'P.2.02.0004862.11.02', 'CHATIME', 'TRANSPARK JUANDA LT. DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 7, 0, 30000, 174450000, 10.00, '02129291076', 'http://drive.google.com/uc?id=1LsEMUlsrX8eRny-7QGoz1Iohcn5-7J2_', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (884, 2, 'PT. TRANS ICE', 'P.2.02.0004258.11.02', 'BASKIN ROBBINS', 'TRANSPARK JUANDA LT DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 2, 15, 160000, 57600000, 10.00, '089611595437', 'http://drive.google.com/uc?id=196TPKmBDQaRZg1S-ytLc__8zNIQhtJS4', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (885, 1, 'PT. NUSANTARA SEJAHTERA RAYA', 'P.2.02.0004422.11.02', 'XXI RESTO TRANS PARKS JUANDA', 'TRANSPARK JUANDA LT 5', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 20, 30000, 554250000, 10.00, '02189992121', 'http://drive.google.com/uc?id=1-Q-naYk3hUrdrYFWcF32Dh03yVw6qFDi', 0, 1, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (886, 2, 'PT. BUMI BERKAH BOGA', 'P.2.02.0044862.11.02', 'KOPI KENANGAN', 'TRANSPARK JUANDA LT DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 0, 36000, 111348000, 10.00, '08179875904', 'http://drive.google.com/uc?id=1AGK3ja-C21G800BzF0pql3QU5z0GHijp', 0, 4, '-6.24984', '107.01654', 1, '2021-10-20 11:19:43', '2022-06-16 09:32:40', NULL);
INSERT INTO `restorans` VALUES (887, 3, 'PT. SARI BUGER INDONESIA', 'P.2.02.0004214.11.02', 'BURGER KING', 'TRANS MART LT. LOBI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 13, 33, 21000, 48993000, 10.00, '02182698685', 'http://drive.google.com/uc?id=18bpzD6iFlFQotyi6jTMb4KCtIBF44p1c', 0, 1, '-6.25136', '106.99152', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (888, 2, 'CV. SINAR SOLARIA', 'P.2.02.0004272.11.02', 'SOLARIA', 'TRANS MART LANTAI LOBI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 14, 50, 100000, 142000000, 10.00, '08121107151', 'http://drive.google.com/uc?id=16ZrJ_SmidvHCoNxHNRtlS9aVYj266IhF', 0, 1, '-6.25136', '106.99152', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (889, 2, 'HARGIANTO SALIM', 'P.2.02.0004260.11.02', 'YOSHINOYA', 'TRANS MART LANTAI LOBI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 8, 41, 40000, 133680000, 10.00, '081385161448', 'http://drive.google.com/uc?id=1PoPlKE-xARoKbmePfvhKY2Hb4-WfIGbd', 0, 1, '-6.25136', '106.99152', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (890, 1, 'ALAN', 'P.2.02.0004726.11.02', 'KRISPY KREME', 'JL. IR. H. JUANDA TRANS PARK LT. LOBY', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 4, 0, 108000, 233388000, 10.00, '02129101075', 'http://drive.google.com/uc?id=1HATio1WstnY9fXAxQzcmlDvWIIIhYiF2', 0, 1, '-6.24975', '107.01665', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (891, 2, 'PT. TRANS RETAIL', 'P.2.02.0004287.11.02', 'BAKSO BOEDJANGAN', 'JL. IR. H. JUANDA TRANS PARK LT. LOBBY', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 70, 35000, 70350000, 10.00, '087890736142', 'http://drive.google.com/uc?id=1iyluL0_mqLGtGRmnk-y8aeANSRmhv6jy', 0, 1, '-6.24975', '107.01665', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (892, 3, 'TIDAK DIKETAHUI', 'P.2.02.0004285.11.02', 'SAKURA JAVANESE', 'TRANS MART LT LOBI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1UKiAy5lgBWdtecCMYPogsOWCE2ukklsL', 0, 4, '-6.25136', '106.99152', 1, '2021-10-20 11:19:43', '2022-06-10 10:51:48', '2022-06-10 10:51:48');
INSERT INTO `restorans` VALUES (893, 3, 'PT. ALFA RETALINDO', 'P.2.02.0004289.11.02', 'FOOD BAR', 'JL. IR. H. JUANDA TRANS PARK LT. 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, 24, 20000, 8580000, 10.00, '083830294695', 'http://drive.google.com/uc?id=16pBWs3f_3c3IwsuqM6u-oJvO0YGfcnz7', 0, 1, '-6.24975', '107.01665', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (894, 3, 'PT. TRANS RETAIL', 'P.2.02.0004288.11.02', 'MAMI RESTO', 'TRANS MART LT. 3', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 7, 50, 30000, 32940000, 10.00, '081316826450', 'http://drive.google.com/uc?id=1Jk2irbXSKXd7Be59Ny_eXxUMRLw7eqFq', 0, 1, '-6.25136', '106.99152', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (895, 1, 'JAHRUDIN', 'P.2.02.0004394.11.02', 'CHATIME', 'BTC MALL LANTAI DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 7, 11, 30000, 161550000, 10.00, '02129566212', 'http://drive.google.com/uc?id=1zMErPNr6inirwOLsbc91fVH7x9YEvWW9', 0, 1, '-6.257484002323515', '107.02284197488406', 1, '2021-10-20 11:19:43', '2021-10-20 11:33:31', NULL);
INSERT INTO `restorans` VALUES (896, 3, 'PT. DOM PIZZA INDONESIA', 'P.2.02.0002968.11.02', 'DOMINO\'S PIZZA', 'JL. HM JOYOMARTONO, BTC 2 MALL LT. DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 11, 5, 0, 0, 10.00, '085697798544', 'http://drive.google.com/uc?id=1QVASjZDr2OzRH_-2pcA-7Nyauq6AzNAX', 0, 4, '-6.25955', '107.02018', 1, '2021-10-20 11:19:43', '2022-06-07 12:48:37', NULL);
INSERT INTO `restorans` VALUES (897, 1, 'OEY WIDIAWATI GUNARSO', 'P.2.02.0003246.11.02', 'MADAME CAFE', 'BTC LANTAI 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 78, 150000, 192075000, 10.00, '02129566208', 'http://drive.google.com/uc?id=1cGqpGxCManYZJNwiZw39vuYw0CEwIfsv', 0, 1, '6.258659807860439', '107.02053527513125', 1, '2021-10-20 11:19:43', '2021-10-20 11:34:09', NULL);
INSERT INTO `restorans` VALUES (898, 1, 'KANTI RAHAYU', 'P.2.02.0004724.11.02', 'WARUNG SATE DAN TONGSENG PAK H. BUDI', 'JL. HM JOYOMARTONO NO 125', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 11, 60, 50000, 243900000, 10.00, '02188356668', 'http://drive.google.com/uc?id=12vAFhfOncVAs3mGFUuErF2kujyq9HtRX', 0, 1, '-6.25603', '107.02177', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (899, 1, 'PT. EKA BOGA INTI', 'P.2.02.0000043.14.02', 'HOKA HOKA BENTO BTC', 'JL. M.H JOYOMARTONO LT 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 12, 138, 90000, 1117845000, 10.00, '02188350388', 'http://drive.google.com/uc?id=1EIceXC7YZoKqs1dPkfHc9QgpF__raUgC', 0, 1, '-6.25974', '107.02038', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (900, 1, 'JODY', 'P.2.02.0001030.11.02', 'WAROENG STEAK AND SHAKE', 'JL. IR. H. JUANDA NO. 189', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 14, 68, 80000, 217680000, 10.00, '085718812742', 'http://drive.google.com/uc?id=1UEo4b_8wsUkLUi_jGGx3hu8UNyP-DGEZ', 0, 1, '-6.24528', '107.00773', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (901, 1, 'SLAMET', 'P.2.02.0002907.11.02', 'BAKSO TITOTI', 'JL. IR. H. JUANDA NO.119', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 14, 24, 25000, 150250000, 10.00, '08136619092', 'http://drive.google.com/uc?id=16qvJe8CTTGyjHxiNb-LQWgrkCquhxZMh', 0, 1, '-6.25974', '107.02038', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (902, 3, 'HEVA', 'P.2.02.0002400.11.02', 'RM RESTU BUNDO', 'JL. MAYOR MADMUIN HASIBUAN NO.8, RT.008/RW.008', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 24, 20000, 25500000, 10.00, '0218807052', 'http://drive.google.com/uc?id=1CKzv-azeTVvun7I-1CvaX-Q1R2e-k22f', 0, 1, '-6.25539', '107.00422', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (903, 3, 'RAMADHAN', 'P.2.02.0005301.11.02', 'KOPI RAGA', 'JL. MAYOR MADMUIN HASIBUAN NO.72', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 100, 20000, 8200000, 10.00, '081295687672', 'http://drive.google.com/uc?id=1kJcWyUSoTjRruA9NhwtLfGJ1ImpmmQtG', 0, 4, '-6.25399', '107.00342', 1, '2021-10-20 11:19:43', '2022-06-07 12:50:41', NULL);
INSERT INTO `restorans` VALUES (904, 2, 'PT. INDOSTERLING WAHANA BOGA', 'P.2.02.0004061.11.02', 'BAKMITOPIA', 'BLU PLAZA UNIT GF NO 23-23A', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 8, 150, 70000, 146447000, 10.00, '081911888986', 'http://drive.google.com/uc?id=1OCFTeYKiM3EBjbxx7FOuqz6jxXtyRQWi', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (905, 1, 'CV. NUSA PRIMA PANGAN', 'P.2.02.0001611.11.02', 'SOLARIA CARREFOUR', 'JL. CUT MUTIAH LT DASAR 27-36', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 15, 180, 90000, 821592000, 10.00, '085951520841', 'http://drive.google.com/uc?id=10TV81qMxP5V_A-gStMfPaGf60Xz3graN', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (906, 1, 'PT. LANGIT BIRU KULINER', 'P.2.02.0001995.11.02', 'RM. TEKKO', 'BLU PLAZA LANTAI UG JL CHAIRIL ANWAR NO 27-36', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 7, 80, 65000, 322985000, 10.00, '02129085759', 'http://drive.google.com/uc?id=1sXKFzEJ7FYW4d8y826eNjAXMyFkq5HaF', 0, 4, '-6.2563', '107.00891', 1, '2021-10-20 11:19:43', '2022-06-07 12:53:42', NULL);
INSERT INTO `restorans` VALUES (907, 1, 'PT. PRIMA USAHA ERA MANDIRI', 'P.2.02.0001124.11.02', 'A & W BLU PLAZA', 'BLU PLAZA JL. CHAIRIL ANWAR LT UG NO 27-36', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 8, 86, 60000, 342360000, 10.00, '02129085652', 'http://drive.google.com/uc?id=1IPGzKKvXm33eePguHpNeikSIXSL9tdgH', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (908, 2, 'PT. BUMI BERKAH BOGA', 'P.2.02.0004385.11.02', 'KOPI KENANGAN', 'BLU PLAZA LANTAI UG JL CHAIRIL ANWAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 10, 20000, 70320000, 10.00, '08179876055', 'http://drive.google.com/uc?id=1SyE9Gswv37QXc4Nt6UHkoOq46wr7bSnx', 0, 1, '-6.2563', '107.00891', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (909, 3, 'PT. PENDEKAR BODOH', 'P.2.02.0002691.11.02', 'D COST BLU PLAZA', 'BLU PLAZA JL. CHAIRIL ANWAR LANTAI UP', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1LJtI4SXyTtgl84aLB4BSaCOqDZQuF_dZ', 0, 4, '-6.2563', '107.00891', 1, '2021-10-20 11:19:43', '2022-06-17 09:56:29', NULL);
INSERT INTO `restorans` VALUES (910, 2, 'PT. SUNSHINE FOOD INTERNATIONAL', 'P.2.02.0004785.11.02', 'PT. SUNSHINE FOOD INTERNATIONAL / CATERING', 'RS. SILOAM BEKASI TIMUR, MALL BLU PLAZA', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, 0, 35000, 67567500, 10.00, '02180611900', 'http://drive.google.com/uc?id=1TejhZt0VswJsqrZEqF0fKzocHCEo95Tr', 0, 1, '-6.2563', '107.00891', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (911, 1, 'PAULUS', 'P.2.02.0001129.11.02', 'HOKA-HOKA BENTO CARREFOUR', 'JL. CHAIRIL ANWAR LANTAI DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 9, 132, 90000, 928530000, 10.00, '02188359378', 'http://drive.google.com/uc?id=1llbtU--7srYvCPfeeY1N-3tLFm_nN77X', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (912, 1, 'JHONNY ANDREAN', 'P.2.02.0001575.11.02', 'J.CO DONUTS & COFFEE', 'JL. CHAIRIL ANWAR BLUE MALL LANTAI DASAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 11, 60, 90000, 811530000, 10.00, '02129085663', 'http://drive.google.com/uc?id=1hXLVOMIU3DZLQRo3cxoHUGN5VK0f8Jqx', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:19:43', '2021-10-20 11:19:43', NULL);
INSERT INTO `restorans` VALUES (937, 3, 'CHAIRUL TANJUNG', 'P.2.02.0001128.11.02', 'PT. TRANS RETAIL INDONESIA', 'JL. CHAIRIL ANWAR LANTAI UG', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1xI7DcvJ48pR_ZmwXDi09eilGBgV3gqV6', 0, 4, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2022-06-07 12:31:56', NULL);
INSERT INTO `restorans` VALUES (938, 3, 'DINTA', 'P.2.02.0001503.11.02', 'KANTIN RS MITRA KELUARGA BEKASI TIMUR', 'JL. RAYA PENGASINAN RT 04/ RW 12', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 6, 32, 20000, 19210000, 10.00, '085215030419', 'http://drive.google.com/uc?id=1ksFCzbp2246sv6dmg2s9XglSF1bg5a1m', 0, 1, '-6.2527', '107.00262', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (939, 2, 'RANGGA & HUSNUL', 'P.2.02.0004200.11.02', 'MAMAGAIO RESTO', 'JL. CHAIRIL ANWAR RT 03/12', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 11, 100, 45000, 91620000, 10.00, '081111360365', 'http://drive.google.com/uc?id=1y_pzjcQ6RkoGYTgxiplCEbXzeOU7eFO-', 0, 1, '-6.2527', '107.00262', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (940, 3, 'PT. INDOMARCO PRISMATAMA', 'P.2.02.0004308.11.02', 'POINT CAFE', 'JL. RAYA CHAIRIL ANWAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, 4, 30000, 30150000, 10.00, '085161284656', 'http://drive.google.com/uc?id=1Sh3tlevlW7zQdf4-pbQ6gtyc9zenTFUY', 0, 1, '-6.2527', '107.00262', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (941, 2, 'SATWIKA', 'P.2.02.0005312.11.04', 'LET\'S GO CHICKEN', 'JL. NUSANTARA RAYA / ALFAMIDI', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 2, 3, 22000, 58707000, 10.00, '081112522904', 'http://drive.google.com/uc?id=15rOSNyN6ygV_PaskCiQA3MnUusYQBRty', 0, 1, '-6.24297', '107.02745', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (942, 3, 'TIDAK DIKETAHUI', 'P.2.02.0004384.11.04', 'PEMPEK GABY', 'JL. NUSANTARA RAYA NO 30', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 2, 0, 20000, 8950000, 10.00, '085780728029', 'http://drive.google.com/uc?id=1LbwGpezGqTtAeN0kLvgArLJn_SFy_2Fd', 0, 1, '-6.24283', '107.03326', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (943, 1, 'PT. SARI MELATI KENCANA', 'P.2.02.0003876.11.04', 'PHD NUSANTARA', 'JL. NUSANTARA RAYA BLOK A2 / 35', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 16, 16, 120000, 397680000, 10.00, '08113077891', 'http://drive.google.com/uc?id=1D4uzs3dbL5RBEXnhBLAqMAi7JMphefOz', 0, 1, '-6.2429', '107.03601', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (944, 3, 'HENDRY', 'P.2.02.0004107.11.04', 'AYAM GEPREK BENSU', 'JL. NUSANTARA RAYA NO 25. PERUMNAS 3', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 7, 52, 15000, 21675000, 10.00, '087788036975', 'http://drive.google.com/uc?id=1Rj_0heV0wsE7gAsPO3uwygNcrqabXiPJ', 0, 1, '-6.24411', '107.03865', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (945, 1, 'PT. INSPIRASI BISNIS NUSANTARA', 'P.2.02.0004803.11.04', 'HAUS', 'JL. NUSANTARA RAYA NO 18 RT 07/09', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 5, 0, 35000, 354375000, 10.00, '087797899666', 'http://drive.google.com/uc?id=1IOX4cqdRsm7bvTyCEqBfONq-U3G9fJqt', 0, 1, '-6.24497', '107.0408', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (946, 2, 'MEYNDRASTA', 'P.2.02.0002228.11.02', 'BEBEK GORENG H. SLAMET', 'JL CHAIRIL ANWAR BLOK A NO 25 RT 001/004', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 12, 80, 35000, 88462500, 10.00, '02188352985', 'http://drive.google.com/uc?id=1X2EVouGFy0-Age57r7iTjKkCuHVFXm9f', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (947, 2, 'PT. SEBASTIAN CITRA INDONESIA', 'P.2.02.0005183.11.04', 'ROTI\'O', 'JL NUSANTARA NO 196', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 3, 6, 24000, 52761600, 10.00, '081310814498', 'http://drive.google.com/uc?id=1X6nz3-ByrKUIchhHl8yG6Sf-zjUmskFs', 0, 4, '-6.24369', '107.02919', 1, '2021-10-20 11:23:00', '2022-06-17 10:14:34', NULL);
INSERT INTO `restorans` VALUES (948, 2, 'MUHAMMAD ONIM', 'P.2.02.0002759.11.02', 'BAKMI TEGAL SARI', 'JL KARTINI NO 28', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 9, 60, 40000, 87200000, 10.00, '08159271292', 'http://drive.google.com/uc?id=1upeGFNJaj2mDPyP-SDGdNSb2NkFLn8a2', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (949, 3, 'PT. SEBASTIAN CITRA INDONESIA', 'P.2.02.0005269.11.02', 'ROTI O', 'JL RAYA KARTINI NO 16 RT', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 1, 1, 50000, 22740000, 10.00, '085893172656', 'http://drive.google.com/uc?id=18ArxNRTz1GyB5w8hUCtWD6G-0Fan1mZ9', 0, 4, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2022-06-17 10:14:54', NULL);
INSERT INTO `restorans` VALUES (950, 3, 'TIDAK DIKETAHUI', 'P.2.02.0002647.11.04', 'FITRI SEAFOOD 2', 'JL NUSANTARA RAYA', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1IthDx54SIjAD9AIK2AziXUBWia6J33NY', 0, 1, '-6.24296', '107.03283', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (951, 2, 'RIRI', 'P.2.02.0004139.11.02', 'SALERO RAJO', 'JL KARTINI NO 10A/B  RT003/003', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 9, 36, 50000, 92500000, 10.00, '08774306433', 'http://drive.google.com/uc?id=11fZ8Vb8vJc1ToGx1oh5CbPHyTUG7ExGE', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (952, 2, 'RISKA', 'P.2.02.0005191.11.02', 'GUDANG SHABU & SUKIYAKI', 'JL RA KARTINI NO 24', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 6, 16, 50000, 52110000, 10.00, '082112209682', 'http://drive.google.com/uc?id=1qKcddoK5VHziq8txhxRqhBXxNKGf0XEn', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (953, 2, 'TIDAK DIKETAHUI', 'P.2.02.0003197.11.03', 'WARUNG MAKAN BEBEK LALADA', 'JL RAYA PAHLAWAN RT 4/6', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 5, 150, 25000, 53062500, 10.00, '02122012856', 'http://drive.google.com/uc?id=1VjAc0EFozvUPkqskmCO1BNVj_9HcLKF3', 0, 1, '-6.2437', '107.02836', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (954, 2, 'PT. CITARASA PRIMA INDONESIA BERJAYA', 'P.2.02.0004059.11.02', 'BAKSO BOEDJANGAN', 'JL IR. HJ. JUANDA NO 84-86', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 8, 100, 60000, 127440000, 10.00, '08112106551', 'http://drive.google.com/uc?id=1w02LhHxw5N43Hh6LR9P_s79nvvcFZhh5', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (955, 2, 'MAY HENDRA', 'P.2.02.0003788.11.03', 'BEBEK GORENG H. SLAMET', 'JL. PAHLAWAN RT 06 RW 04', 'BEKASI TIMUR', 'AREN JAYA', NULL, NULL, 8, 120, 40000, 84400000, 10.00, '081380234200', 'http://drive.google.com/uc?id=1udtoUu5mEnwWSTsdo5xYriC5UKo4HFXl', 0, 1, '-6.2437', '107.02836', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (956, 2, 'HJ. BAHIR', 'P.2.02.0000025.11.02', 'RM. H. BAHIR', 'JL IR. H. JUANDA PERTOKOAN BEKASI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 15, 35, 50000, 88805000, 10.00, '081383100642', 'http://drive.google.com/uc?id=10EMSIpZQzmyhuyCv2lQnFU2yY121FYBm', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (957, 2, 'YANAH', 'P.2.02.0002133.11.02', 'RM. SIANG MALAM H. NANA', 'JL JUANDA BEKASI TIMUR NO 63-64', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 8, 36, 50000, 136455000, 10.00, '081294566665', 'http://drive.google.com/uc?id=1DdGXxwYdRe5hUGMFpCt0XnxwkN1oWQlI', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (958, 3, 'PT. PRIMA USAHA ERA MANDIRI', 'P.2.02.0002032.11.02', 'A & W BEKASI JUNCTION', 'JL IR. H. JUANDA BEKASI JUNCTION', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1ZFuH93l1iUAYlazKg6-9dFcUFYnddkWx', 0, 4, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2022-06-15 12:21:00', '2022-06-15 12:21:00');
INSERT INTO `restorans` VALUES (959, 2, 'ZAENUDIN', 'P.2.02.0001936.11.01', 'RM. TARWUD', 'JL IR. HJ. JUANDA NO 137', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 4, 20, 25000, 70485000, 10.00, '085215830505', 'http://drive.google.com/uc?id=17abIpqj2Bmw-05nFN9pDru8tbd5HsTI5', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:23:00', '2021-10-20 11:23:00', NULL);
INSERT INTO `restorans` VALUES (965, 1, 'PT. SARI MELATI KENCANA', 'P.2.02.0002501.11.02', 'PHD KARTINI', 'JL. RA. KARTINI RT 03/03 NO 2', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 25, 10, 100000, 318200000, 10.00, '08113248829', 'http://drive.google.com/uc?id=1rHVK7nC-LHIzaoR2B9bwPQHMX3DNLVON', 0, 1, '-6.24662', '107.00272', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (966, 1, 'H. IYUS RUSLAN', 'P.2.02.0000883.11.02', 'RM. CIBIUK', 'JL. RAYA KARTINI NO 11 B', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 15, 95, 80000, 176280000, 10.00, '081389222285', 'http://drive.google.com/uc?id=1v7ywGwxGAHNeHWl9oPCiTezObNC6EcZr', 0, 1, '-6.24521', '107.00444', 1, '2021-10-20 11:26:26', '2022-06-07 15:05:31', NULL);
INSERT INTO `restorans` VALUES (967, 3, 'NAJIB', 'P.2.02.0004825.11.02', 'TEGUK KARTINI', 'JL MAYOR OKING NO75A', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, 2, 15000, 34711500, 10.00, '082294781930', 'http://drive.google.com/uc?id=1e2y79L4PNLA8f1eMZ6bB2DkX1tkNrc5G', 0, 1, '-6.24479', '107.00393', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (968, 3, 'ERNITA NOVIANTI', 'P.2.02.0001829.11.03', 'CV. DIAZ PUTRA (CATERING)', 'JL. PAHLAWAN PERUM BUNGA RAYA BLOK B NO 11', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 8, 0, 25000, 42562500, 10.00, '087882858881', 'http://drive.google.com/uc?id=1U43TFPgaumDc85ScZTjBcjIClu8Gui0p', 0, 4, '-6.23474', '107.02702', 1, '2021-10-20 11:26:26', '2022-06-08 08:00:40', '2022-06-08 08:00:40');
INSERT INTO `restorans` VALUES (969, 3, 'TJAM ANEM', 'P.2.02.0003363.11.02', 'FOOD COURT CAFE KALIMAS', 'RUKO KALIMAS BLOK C NO 11. JL. CHAIRIL ANWAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, 60, 42000, 13230000, 10.00, '02188354323', 'http://drive.google.com/uc?id=13hsbqcE-RzGkLCIQdoiRRWx6egXndr_L', 0, 1, '-6.25941', '107.01534', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (970, 3, 'LIDIA', 'P.2.02.0001657.11.03', 'KANTIN BELLA', 'JL. IR. H. JUANDA NO 141', 'BEKASI TIMUR', 'DUREN JAYA', NULL, NULL, 2, 4, 10000, 33625000, 10.00, '089637458641', 'http://drive.google.com/uc?id=1JIlR-Yln1f9HUmeiXWga41tzsEZeHa02', 0, 1, '-6.24676', '107.01058', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (971, 3, 'ZAENURI', 'P.2.02.0005382.11.02', 'WINAZ COFFEE SHOP', 'JL CHAIRIL ANWAR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 6, 60, 30000, 34536000, 10.00, '087741452760', 'http://drive.google.com/uc?id=10PoY640Bw32hJ_oouxGu-_6T4gx2EhNT', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (972, 3, 'HON DJI LIONG', 'P.2.02.0002836.11.03', 'RM. ALIONG MY KITCHEN', 'JL. PROF. YAMIN NO 20', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 3, 32, 25000, 20250000, 10.00, '0218822673', 'http://drive.google.com/uc?id=1mwiBMkIfS3jV71igneqWbB6vbuEshKl0', 0, 4, '-6.23764', '107.01647', 1, '2021-10-20 11:26:26', '2022-06-08 08:15:33', '2022-06-08 08:15:33');
INSERT INTO `restorans` VALUES (973, 2, 'HJ. YATMIN', 'P.2.02.0002564.11.03', 'BAKSO H. YATMIN III', 'JL. IR. H. JUANDA RUKO MITRA BEKASI BLOK E NO 22', 'BEKASI TIMUR', 'DUREN JAYA', NULL, NULL, 4, 56, 25000, 66650000, 10.00, '082123720465', 'http://drive.google.com/uc?id=1rjF3dqm4od1M5HcMl80AM4LxZG7fw5Th', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (974, 3, 'VENY', 'P.2.02.0000029.11.02', 'VENY', 'JL. MAYOR OKING NO 25-27', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 0, 10000, 12100000, 10.00, '0218812352', 'http://drive.google.com/uc?id=1XbuaMl39QosYyJ_Hu8k_BrSEEuPFhube', 0, 1, '-6.24231', '107.0029', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (975, 3, 'TIDAK DIKETAHUI', 'P.2.02.0003021.11.02', 'MY KITCHEN ALIONG', 'JL. RA. KARTINI NO 48A', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1cpxgJsyjRkhrcS0FwvX764ZDP56ncXNy', 0, 1, '-6.24622', '107.00295', 1, '2021-10-20 11:26:26', '2022-06-16 10:09:44', '2022-06-16 10:09:44');
INSERT INTO `restorans` VALUES (976, 2, 'HJ. YATMIN', 'P.2.02.0002563.11.01', 'BAKSO H. YATMIN I', 'JL KH. AGUS SALIM NO 29', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 5, 72, 25000, 50372500, 10.00, '087884843994', 'http://drive.google.com/uc?id=1RaJjHcFek_S914_aJFMAYXUlNZE-lF_2', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (977, 2, 'MAULANA', 'P.2.02.0004827.11.01', 'TEGUK AGUS SALIM', 'KH. AGUS SALIM NO 71B', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 3, 3, 20000, 53546000, 10.00, '081310292254', 'http://drive.google.com/uc?id=16zhwuSRUBUDy0eMBccsH5UfEhrqR5t7e', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (978, 3, 'KURNIAWAN', 'P.2.02.0002888.11.01', 'KOPI BARIS', 'JL KH AGUS SALIM RT 009 RW 007', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 4, 46, 30000, 49020000, 10.00, '087855993020', 'http://drive.google.com/uc?id=1Ba5WrqgfRXsa3DWJGWTzWe3adxwpnGG2', 0, 4, NULL, NULL, 1, '2021-10-20 11:26:26', '2022-06-17 08:45:54', '2022-06-17 08:45:54');
INSERT INTO `restorans` VALUES (979, 2, 'VINA', 'P.2.02.0005164.11.01', '3 PLATES', 'JL MEKARSARI NO 03 RT 07 RW 03', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 9, 80, 30000, 61047000, 10.00, '087888414334', 'http://drive.google.com/uc?id=1hbVL2c8LHz-xvWMJZtkr7r7b-tbWOEQx', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (980, 2, 'EKO', 'P.2.02.0002469.11.01', 'RM. GUDEG LESEHAN BU SOEM', 'JL AGUS SALIM BEKASI TIMUR', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 4, 104, 40000, 69640000, 10.00, '02182671962', 'http://drive.google.com/uc?id=1r3rNtD56XsbL6vYHSNVBlgd2ZbVTwcmb', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (981, 3, 'NAYOMARNI', 'P.2.02.0002421.11.01', 'RM. SABANA SERO', 'JL. AGUS SALIM RT 07 RW 06', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 2, 16, 20000, 25164000, 10.00, '081287011190', 'http://drive.google.com/uc?id=13D0vmrvMWoqzzwbMIiOG5hEOMvqPv7WJ', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (982, 2, 'ORIEN', 'P.2.02.0002034.11.01', 'WARUNG ICE CREAM ORIN', 'JL KH. AGUS SALIM RT 003 RW 006', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 11, 30, 25000, 53465000, 10.00, '081818852880', 'http://drive.google.com/uc?id=1SwKtX4XDiwvoYR1z55soEH6w5aqAj4HC', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (983, 2, 'HJ. SARJAN', 'P.2.02.0001966.11.01', 'BAKSO SUPER 88', 'JL KH. AGUS SALIM NO 10 RT 04 RW 06', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 5, 20, 25000, 56710000, 10.00, '0218826647', 'http://drive.google.com/uc?id=1LzP_yjCPDTcr1TeVX2RsREdRfgH5bS-U', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (984, 3, 'TIDAK DIKETAHUI', 'P.2.02.0004487.11.01', 'KEDAI BOBOKO PENYET / CATERING', 'JL. MEKAR SARI NO 2', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 2, 4, 18000, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1PyjAFTNGxKz0X4QyZMbslnJDVcpQ2dV4', 0, 4, '-6.2315', '107.01381', 1, '2021-10-20 11:26:26', '2022-06-08 08:16:59', '2022-06-08 08:16:59');
INSERT INTO `restorans` VALUES (985, 3, 'PT. RASA DAPUR SEDAP', 'P.2.02.0004346.11.03', 'AYAM MANTUL', 'JL. PAHLAWAN NO 88', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1yeRQXIh6FQhiyixIam9CQcb7vBQgfgAT', 0, 4, '-6.24203', '107.027', 1, '2021-10-20 11:26:26', '2022-06-08 08:18:12', '2022-06-08 08:18:12');
INSERT INTO `restorans` VALUES (986, 3, 'MANGIRING', 'P.2.02.0005021.11.03', 'DOMINATE COFFE', 'JL. RAYA KARANG SATRIA NO 4 RT 03/ 16', 'BEKASI TIMUR', 'DUREN JAYA', NULL, NULL, 12, 200, 25000, 37850000, 10.00, '081284476423', 'http://drive.google.com/uc?id=1g_OTE-P9nSHxGRQIWxjwO_tmKpFTdqHf', 0, 1, '-6.22722', '107.03024', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (987, 1, 'TAYYEN', 'P.2.02.0001801.11.01', 'IKAN BAKAR BAMBOE KUNING', 'JL. MEKAR SARI NO 10', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 5, 70, 40000, 194000000, 10.00, '02188352269', 'http://drive.google.com/uc?id=1Iibwj3KE374jK1OjoMsGK9w58czP3z6A', 0, 1, '-6.23121', '107.01408', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (988, 3, 'DJONI', 'P.2.02.0002637.11.02', 'RM. AYAM GORENG VALENTINE', 'JL KARTINI BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 2, 32, 25000, 23345000, 10.00, '087877703070', 'http://drive.google.com/uc?id=1knSQY-9zHI2lm_hbS4O0SzpdHH6IvVvi', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (989, 3, 'TIDAK DIKETAHUI', 'P.2.02.0002038.11.01', 'FITRI SEAFOOD', 'JL MEKAR SARI RAYA NO 1', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1s07YQQamKuP6VOwyTsGkNoQ51RvdIL0x', 0, 1, NULL, NULL, 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (990, 3, 'BAPAK FEMI', 'P.2.02.0005030.11.03', 'NGIKAN (FEMI)', 'JL. SATRIA NO 15 RT 05 / 07', 'BEKASI TIMUR', 'DUREN JAYA', NULL, NULL, 5, 35, 23100, 48255900, 10.00, '082298462238', 'http://drive.google.com/uc?id=1LPkaXa00jSyulpg5cvHC1hwuwn2wBKEu', 0, 1, '-6.23237', '107.0226', 1, '2021-10-20 11:26:26', '2021-10-20 11:26:26', NULL);
INSERT INTO `restorans` VALUES (992, 1, 'PT. REKSO NASIONAL FOOD', 'P.2.02.0004523.11.03', 'MCD JUANDA', 'JL. IR. H. JUANDA NO 22', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 42, 140, 50000, 226800000, 10.00, '08119810841', 'http://drive.google.com/uc?id=18vTWRabfJIXo2X8POfboKZmcrOKArYmS', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:28:10', '2021-10-20 11:28:10', NULL);
INSERT INTO `restorans` VALUES (993, 2, 'CV. SUKSES AMANAH FOOD', 'P.2.02.0005190.11.02', 'AYAM GEPREK PANGERAN', 'JL CUT MUTIA RAYA RT 1 RW 9', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 5, 25, 25000, 58597500, 10.00, '081315126495', 'http://drive.google.com/uc?id=1Y667oqMRbfStEc7baZNeyasSIrUFuwWG', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:28:10', '2021-10-20 11:28:10', NULL);
INSERT INTO `restorans` VALUES (994, 3, 'WARSITO', 'P.2.02.0004901.11.02', 'COFFEE SHOP LAIN HATI', 'JL. MH. JOYOMARTONO NO B 1', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 2, 20, 20000, 12720000, 10.00, '089517847828', 'http://drive.google.com/uc?id=1d6m6zCv5oNhXSflfb2bF3kuA3kfMnxF1', 0, 1, '-6.25701', '107.02135', 1, '2021-10-20 11:28:10', '2021-10-20 11:28:10', NULL);
INSERT INTO `restorans` VALUES (995, 1, 'PT. GRAHA LAYAR PRIMA', 'P.2.02.0003581.11.02', 'CGV CINEMA', 'MALL BTC LT GF', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 2, 24, 50000, 403000000, 10.00, '089512625174', 'http://drive.google.com/uc?id=1FZqmiip6v1122rgQac64rP0SDWcMQ5Fs', 0, 1, '-6.25999', '107.02095', 1, '2021-10-20 11:28:10', '2021-10-20 11:28:10', NULL);
INSERT INTO `restorans` VALUES (996, 2, 'PT. PRIMA USAHA ERA MANDIRI', 'P.2.02.0004241.11.02', 'A & W RESTAURANT', 'JL IR. H. JUANDA NO 180 TRANSMART LANTAI GF UNIT GF-7', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 9, 46, 50000, 85630000, 10.00, '02182696338', 'http://drive.google.com/uc?id=1tV3kOe6pE209z0KGBVmALvxZc5oKnPTk', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:28:10', '2021-10-20 11:28:10', NULL);
INSERT INTO `restorans` VALUES (997, 1, 'PT. INSPIRASI BISNIS NUSANTARA', 'P.2.02.0004802.11.02', 'HAUS', 'JL RA KARTINI 7 NO 11', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 6, 10, 33000, 253605000, 10.00, '087797899666', 'http://drive.google.com/uc?id=1QNCaoX-qQbs_ZEuI4zo3UQA93oFkcnEO', 0, 1, '-6.24721', '107.00201', 1, '2021-10-20 11:28:10', '2021-10-20 11:28:10', NULL);
INSERT INTO `restorans` VALUES (998, 3, 'ARIF SUBARJA', 'P.2.02.0000040.11.02', 'RM. BUNGA KARANG', 'JL RA KARTINI NO 05', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1Zlivmx6NMUbihxzFd2jOPzF__-6oZVXe', 0, 4, '-6.251072', '107.0030481', 1, '2021-10-20 11:28:51', '2022-06-07 12:09:31', NULL);
INSERT INTO `restorans` VALUES (999, 3, 'PT. PRIMA USAHA ERA MANDIRI', 'P.2.02.0004885.11.02', 'A & W BOROBUDUR', 'JL. IR. H. JUANDA NO 56', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=12lwEMUyGNdhq3kWb1M93iI6PDLi9l0EH', 0, 1, '-6.251072', '107.0030481', 1, '2021-10-20 11:28:51', '2022-06-16 10:14:03', '2022-06-16 10:14:03');
INSERT INTO `restorans` VALUES (1000, 3, 'PT. CATUR KARDA DEPO BANGUNAN', 'P.2.02.0003946.11.01', 'KANTIN DEPO BANGUNAN DBANG', 'JL IR. H. JUANDA 99', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 4, 13, 25000, 27762500, 10.00, '85899215616', 'http://drive.google.com/uc?id=1jqazm0OCoG5VOX8qC894isALT_gTU2Si', 0, 1, '-6243692', '107.0060859', 1, '2021-10-20 11:30:54', '2021-10-20 11:30:54', NULL);
INSERT INTO `restorans` VALUES (1075, 1, 'IRDA', 'P.2.02.0003772.18.03', 'MISTER S', 'JL. RAYA HANKAM KAV. 69', 'JATISAMPURNA', 'JATIRANGON', NULL, NULL, 16, 30, 70000, 204400000, 10.00, '087784773417', 'http://drive.google.com/uc?id=1a-5kgVM9k2IbWhx4gHupnL1AWbpe3ixx', 0, 1, '-6.34128', '106.92306', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1076, 1, 'IRDA SUSANTI', 'P.2.02.0002198.18.03', 'TSAMARA', 'JL. RAYA HANKAM RT. 03/05', 'JATISAMPURNA', 'JATIRANGGON', NULL, NULL, 31, 120, 110000, 546975000, 10.00, '08111888862', 'http://drive.google.com/uc?id=19P1DdkI-oIKpF26g0vfhNZEx5SjxsiaM', 0, 1, '-6.34128', '106.92306', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1077, 3, 'NIKI KAMAJAYA', 'P.2.02.0005283.18.02', 'OPPA GALBY', 'RUKO MALL CIPUTRA', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 8, 50, 100000, 37810000, 10.00, '02122816289', 'http://drive.google.com/uc?id=1NnD9VolUTC2QwipUgPQCUwNbbhu9K7-6', 0, 1, '-6.3849029999999996', '106.9186', 1, '2021-10-20 11:47:53', '2021-10-20 11:52:07', NULL);
INSERT INTO `restorans` VALUES (1078, 3, 'DAVID', 'P.2.02.0005282.18.03', 'KOPI LAIN HATI HANKAM', 'JL. RAYA HANKAM KAV. 72 RT. 03/05', 'JATISAMPURNA', 'JATIRANGGON', NULL, NULL, 3, 16, 18000, 48240000, 10.00, '089629958434', 'http://drive.google.com/uc?id=1NFlC8lTtSgYnE1OyZGJB3y1ssCe4woNY', 0, 1, '-6.34155', '106.92312', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1079, 1, 'YOSEP', 'P.2.02.0002452.18.02', 'HOLYCOW STEAK HOUSE', 'RUKO CIPUTRA MALL BLOK RCW 6 NO.1 CITRA GRAND', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 19, 40, 150000, 668910000, 10.00, '087746590006', 'http://drive.google.com/uc?id=1XwQ_j4QruOqbFGpdKCv_vSN4eawI7-L4', 0, 1, '-6.3849029999999996', '106.9186', 1, '2021-10-20 11:47:53', '2021-10-20 21:41:27', NULL);
INSERT INTO `restorans` VALUES (1080, 3, 'ANTA GINTING', 'P.2.02.0004738.18.05', 'KOPI JANJI JIWA', 'JL. RAYA KRANGGAN RUKO SAMPURNA SQUARE', 'JATISAMPURNA', 'JATIRADEN', NULL, NULL, 4, 8, 18000, 16110000, 10.00, '081289194911', 'http://drive.google.com/uc?id=1JNnmISnhiFylyguEk0M54lVXAHpIgVE1', 0, 1, '-6.34155', '106.92312', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1081, 3, 'TIDAK DIKETAHUI', 'P.2.02 0004568.18.02', 'KOPI SOE', 'RUKO CITRA GRAND BLOK.CW.6.NO.10', 'JATISAMPURNA', 'JATIRADEN', NULL, NULL, 3, 10, 18000, 6183000, 10.00, '081366466014', 'http://drive.google.com/uc?id=19uonEPbGDldRV5jMWxoQqUl3t5rOcxL0', 0, 1, '-6.3849029999999996', '106.9186', 1, '2021-10-20 11:47:53', '2021-10-20 11:51:29', NULL);
INSERT INTO `restorans` VALUES (1082, 2, 'PT. AYAM GEPREK JUARA', 'P.2.02.0004566.18.05', 'AYAM GEPREK JUARA', 'JL. RAYA KRANGGAN NO. 52', 'JATISAMPURNA', 'JATIRADEN', NULL, NULL, 4, 16, 17000, 87125000, 10.00, '081113018686', 'http://drive.google.com/uc?id=1onDi7OKrkGEsyhu_HnLJz35gA4M4Banq', 0, 1, '-6.36317', '106.92044', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1083, 2, 'FONY MARIA', 'P.2.02.0004003.18.02', 'TESSA BAKERY & COFFEE', 'RUKO CITYWALK 1 NO. 28 CITRA GRAND CIBUBUR', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 15, 6, 100000, 114300000, 10.00, '081297285094', 'http://drive.google.com/uc?id=1eNtaJAlGuxeyBF3b_3x2mcrQC0gtVxM1', 0, 1, '-6.38295', '106.92398', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1084, 1, 'PT. MENSANA ANEKA PROPERTI', 'P.2.02.0004269.18.01', 'ALL DAY DAINING (AVENZEL)', 'JL. RAYA KRANGGAN NO 02/16', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 11, 100, 170000, 385900000, 10.00, '02180610500', 'http://drive.google.com/uc?id=1zdI3cOnb6PmZWrag4K5DAj-IPhnzkNAg', 0, 1, '-6.37452', '106.91774', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1085, 3, 'FITRI AGUSTINA', 'P.2.02.0004259.18.02', 'KULINER JOWO MAS HAFIZ', 'RUKO PERUMAHAN CITRA GRAND CW1/1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 3, 18, 30000, 13110000, 10.00, '083843856156', 'http://drive.google.com/uc?id=1I6U6_af5Ncq1EQFv38wz9vZy-owzHbTM', 0, 1, '-6.38234', '106.92492', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1086, 2, 'ANGGI', 'P.2.02.0003428.18.02', 'BFF KITCHEN', 'JL. ALTERNATIF CIBUBUR RUKO CITRA GRAND CW3/8', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 5, 52, 115000, 113447500, 10.00, '08111236316', 'http://drive.google.com/uc?id=1PzGRHfSIvPnVm5N1wxBq-sF9_8s5OOv0', 0, 1, '-6.38234', '106.92492', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1087, 1, 'PT. SARI BURGER INDONESIA', 'P.2.02.0001672.18.01', 'BURGER KINGS', 'JL. RAYA ALTERNATIF CIBUBUR', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 25, 100, 70000, 833630000, 10.00, '02184306841', 'http://drive.google.com/uc?id=1GqqSz1so75MnPSktH3S_YHo-cso_nozc', 0, 1, '-6.37949', '106.92262', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1088, 2, 'IRFAN TRY NANDA', 'P.2.02.0005170.18.02', 'DWENDAY CAFE', 'RUKO CITIWALK 2 NO.2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 9, 58, 55000, 81235000, 10.00, '08111818101', 'http://drive.google.com/uc?id=1Uv2AA_O8bzxSsFgEPca2QrvCVPFIy1me', 0, 1, '-6.38234', '106.92492', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1089, 2, 'NIA', 'P.2.02.0002045.18.02', 'CHATIME', 'TIMES SQUARE BLOK AL', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 6, 20, 30000, 121200000, 10.00, '081317275137', 'http://drive.google.com/uc?id=1__xsKZZPEaWIUh0rYqW8aeq-bbAn5B51', 0, 1, NULL, NULL, 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1090, 2, 'AULIA RACHMAN', 'P.2.02.0005274.18.04', 'KEBON IBU FOOD PARK&CAFE', 'JL. MASJID ATTAQWA NO. 88', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 12, 100, 35000, 118125000, 10.00, '081385747538', 'http://drive.google.com/uc?id=1_ajovbnZngEy-wQPmWfpdho4AF1SyJjF', 0, 1, '-6.37546', '106.93382', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1091, 3, 'YUIN', 'P.2.02.0000851.18.03', 'RESTO KOREA DONG IN', 'RUKO CIBUBUR TIME SQUARE, JL. ALTERNATIF CIBUBUR', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 2, 26, 88000, 32120000, 10.00, '02184305376', 'http://drive.google.com/uc?id=1mzsrmRds0ct5pKuFNuk4gKkEEKtVoP5o', 0, 1, '-6.37823', '106.91978', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1092, 3, 'EDWIN', 'P.2.02.0005265.18.02', 'BAKSO SOLO SAMRAT', 'JL. ALTERNATIF CIBUBUR KM.3', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 14, 80, 40000, 47700000, 10.00, '02128678448', 'http://drive.google.com/uc?id=15G94dsldvvhu6SXUlCu0YpmKkST_JLm9', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1093, 2, 'DIMAS', 'P.2.02.0004808.18.03', 'HAUS', 'JL. HANKAM NO. 02', 'JATISAMPURNA', 'JATIRANGGON', NULL, NULL, 5, 4, 10000, 84500000, 10.00, '089636709390', 'http://drive.google.com/uc?id=1xWlYLmyDe29YE7s8uD4WE4kvnUw4jtji', 0, 1, '-6.33415', '106.92341', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1094, 3, 'AGUS SUWANTO', 'P.2.02.0000725.18.02', 'STEAK 21', 'PLAZA CIBUBUR LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 4, 30, 75000, 43042500, 10.00, '02184597421', 'http://drive.google.com/uc?id=1Cf3N1Ac792FVJGxXo73OuqG_WP0maWR3', 0, 1, '-6.37588', '106.91458', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1095, 1, 'UNUS ARIFIN', 'P.2.02.0000660.18.02', 'HOKA-HOKA BENTO PLAZA CIBUBUR', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 20, 28, 100000, 1231600000, 10.00, '02184598009', 'http://drive.google.com/uc?id=1yNLWumJRYk8HgHNVo7_HcNrXmjWGr9in', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1096, 1, 'PT. MITRA ADI PERKASA', 'P.2.02.0003439.18.03', 'DOMINOS PIZZA', 'JL. RAYA HANKAM NO 59', 'JATISAMPURNA', 'JATIRANGGON', NULL, NULL, 12, 60, 110000, 368500000, 10.00, '082191031209', 'http://drive.google.com/uc?id=1XFmIg_m1GLbPqSoEe1N4voAAxnFSHlLA', 0, 1, '-6.33415', '106.92341', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1097, 2, 'EDWARD KINTANATA', 'P.2.02.0004977.18.02', 'KOPI KENANGAN', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR LT. GF)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 5, 2, 18000, 67302000, 10.00, '08174863037', 'http://drive.google.com/uc?id=1kCeJn6OhVtbZ_E1DS_wr9xe3EoZJy_1o', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1098, 2, 'PT. CHAMP RESTO INDONESIA', 'P.2.02.0000990.18.01', 'BAKSO MALANG KARAPITAN', 'PLAZA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 9, 125, 30000, 111570000, 10.00, '02184310314', 'http://drive.google.com/uc?id=1CCLFjSACeXlmQer3Rcu6VRaIuAj-7ImE', 0, 1, '-6.37588', '106.91458', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1099, 2, 'PT. GARINDO FOOD INTERNATIONAL', 'P.2.02.0003916.18.05', 'KEDAI STEAK NUSANTARA', 'JL. RAYA KRANGGAN NO. 45', 'JATISAMPURNA', 'JATIRADEN', NULL, NULL, 15, 40, 45000, 137700000, 10.00, '081283959532', 'http://drive.google.com/uc?id=1Qhuh-TaSgi5F15hlcxT5MD7JXYp4tx33', 0, 1, '-6.35138', '106.92144', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1100, 1, 'PT. NUSA PRIMA PANGAN', 'P.2.02.0000624.18.02', 'SOLARIA CIBUBUR PLAZA', 'PLAZA CIBUBUR LT.GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 12, 116, 70000, 592340000, 10.00, '02184597270', 'http://drive.google.com/uc?id=1LuRBq0vfmO5S-Wy5G5oKgF7OFtpw4PJY', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1101, 3, 'PT. MATA AIR BAHAGIA', 'P.2.02.0002022.18.02', 'HOP-HOP BUBBLE DRINK', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 2, 0, 25000, 31100000, 10.00, '081299036992', 'http://drive.google.com/uc?id=1TtWQeZSO-dc63To3hhr2ASypTHaMGpeu', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1102, 2, 'PT. AMARTHA BOGA LESTARI', 'P.2.02.0005009.18.01', 'NASI KAPAU JURAGAN', 'JL. ALTERNATIF CIBUBUR NO. 39', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 11, 70, 48000, 94080000, 10.00, '02122818428', 'http://drive.google.com/uc?id=1QO-XfxxZu2vaknA1o6ukxmoWFnVWbGlO', 0, 1, '-6.37767', '106.92082', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1103, 3, 'PT. USAHA PRIMA MANDIRI', 'P.2.02.0000252.18.01', 'A & W JATISAMPURNA', 'PLAZA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 6, 49, 28000, 41216000, 10.00, '02184597388', 'http://drive.google.com/uc?id=1c78DNA0TwUkaJY8a7jYgKA_trPbY7B4B', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1104, 3, 'WILLIAM', 'P.2.02.0004791.18.02', 'KOPI JANJI JIWA', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR LT. 2)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 1, 2, 18000, 21726000, 10.00, '081113907102', 'http://drive.google.com/uc?id=1Ou9VS_DOz9XsqgtRQMnaeBScW4BKv0oW', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1105, 2, 'PT. NUSANTARA SEJAHTERA RAYA', 'P.2.02.0002361.18.01', 'CAFE PLAZA CIBUBUR XXI', 'PLAZA CIBUBUR LT. 2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 6, 18, 35000, 72275000, 10.00, '089529574771', 'http://drive.google.com/uc?id=1bfqWStFOUtCTUVVNp2kIFSy_0kWirq8z', 0, 1, '-6.37588', '106.91458', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1106, 1, 'JOHNY ANDREAN', 'P.2.02.0003046.18.01', 'J.CO DONUT & COFFEE', 'PLAZA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 12, 40, 135000, 485460000, 10.00, '02184590669', 'http://drive.google.com/uc?id=1YKPP1WmpL4tsG6ugMlheVDq8iuCHCEKd', 0, 1, '-6.37588', '106.91458', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1107, 3, 'TIDAK DIKETAHUI', 'P.2.02.0000251.18.01', 'MC DONALD\'S JATISAMPURNA', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1v5-0Y30roSRr32y5pMLX9n8MePGbzaGJ', 0, 1, '-6.37585', '106.91498', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1108, 3, 'TIDAK DIKETAHUI', 'P.2.02.0001980.18.02', 'MC DONALD\'S KIOS PLAZA CIBUBUR', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR LT. GF)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1W23NVggA5Wt7pK-SM7tf-Gprtstuq6QV', 0, 1, '-6.37749', '106.91965', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1109, 3, 'TIDAK DIKETAHUI', 'P.2.02.0000861.18.01', 'COFFE TOP', 'PLAZA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1HgK75FpVQ5bMf_dl8siVnEHWRXeRT6qz', 0, 1, '-6.37566', '106.91484', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1110, 3, 'PT. FOOD BEVERAGES INDONESIA', 'P.2.02.0004181.18.02', 'CHATIME', 'JL. ALTERNATIF CIBUBUR (PLAZA CIBUBUR LT. GF)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 6, 4, 26000, 31590000, 10.00, '02184300712', 'http://drive.google.com/uc?id=1_nT3bIPj_eRY0S5clIBT_45tAE97qgLQ', 0, 1, '-6.37584', '106.91492', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1111, 1, 'PT. ABUBA STEAK', 'P.2.02.0004763.18.02', 'ABUBA STEAK', 'KAMPUNG KALIMANGGIS RT. 03/05,JL. ALTERNATIF CIBUBUR NO. 91', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 22, 144, 130000, 643500000, 10.00, '02122818685', 'http://drive.google.com/uc?id=1hMSn7qnA2u0KnjHTGLsed_I22cpXmjgR', 0, 1, '-6.3757', '106.91425', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1112, 1, 'PT. WARUNG STEAK INDONESIA', 'P.2.02.0005241.18.02', 'WARUNG STEAK AND SHAKE', 'JL. ALTERNATIF CIBUBUR NO. 27 RT. 01/01', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 12, 140, 65000, 328250000, 10.00, '085334902484', 'http://drive.google.com/uc?id=1F_D5ja0aw-ScD-sAkZ-gmwPAYCiUiJc8', 0, 1, '-6.3756', '106.91036', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1113, 3, 'CV. PALEM CITARASA MANDIRI', 'P.2.02.0002192.18.02', 'I STEAK U', 'JL. ALTERNATIF CIBUBUR NO 8B', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 4, 16, 55000, 26262500, 10.00, '081298027117', 'http://drive.google.com/uc?id=1RV-eSkYJqRBt-RW-4MoVBhbk0J6VhTgU', 0, 1, '-6.37526', '106.90941', 1, '2021-10-20 11:47:53', '2022-06-10 09:06:00', '2022-06-10 09:06:00');
INSERT INTO `restorans` VALUES (1114, 2, 'SANTOSI', 'P.2.02.0004236.18.01', 'UCOK DURIAN', 'JL. TRANSYOGI 6D ALTERNATIF CIBUBUR', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 2, 20, 130000, 139100000, 10.00, '083197033726', 'http://drive.google.com/uc?id=1qpqqcyy0EFnoRiH0JTmT8d5VGrnQ6pLJ', 0, 1, '-6.37526', '106.90941', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1115, 1, 'JUNITA', 'P.2.02.0002592.18.01', 'OL STAR', 'JL. ALTERNATIF CIBUBUR KM. 2', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 15, 100, 50000, 213500000, 10.00, '081298811229', 'http://drive.google.com/uc?id=1KCbztdUziEKJ6tBu9wGZod4TsQoEcoFR', 0, 1, '-6.37526', '106.90941', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1116, 2, 'FELINE CLAUDIA IBRAHIM', 'P.2.02.0003727.18.01', 'GEPREK BENSU', 'JL. ALTERNATIF RT. 02/16 NO. 88', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 11, 32, 35200, 105600000, 10.00, '081387870210', 'http://drive.google.com/uc?id=1sdpWj13yaZyiP-W46221QBKODEBVJwfD', 0, 1, '-6.37526', '106.90941', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1117, 2, 'PT. SUKATMAS', 'P.2.02.0000242.18.01', 'SARIMANDE', 'JL. ALTERNATIF CIBUBUR NO 45', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 20, 150, 30000, 90150000, 10.00, '02184598156', 'http://drive.google.com/uc?id=1oxnxER0CeNM0UvkqW2XlGYwB_Ws0BWri', 0, 1, '-6.37518', '106.91491', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1118, 1, 'DUDDY', 'P.2.02.0002723.18.05', 'WAROENG HOT PLATE ODON', 'JL. RAYA HANKAM NO. 56 RT. 03/07', 'JATISAMPURNA', 'JATIRADEN', NULL, NULL, 5, 70, 35000, 155225000, 10.00, '087786220153', 'http://drive.google.com/uc?id=1YhWB8bESKXW3xRHJ44O6J6TeKXjJZqk2', 0, 1, '-6.34796', '106.92255', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1119, 1, 'PT. NAILA KREASI MANDIRI', 'P.2.02.0005281.18.05', 'THE JOGLO GARDEN RESTAURANT&CAFE', 'JL. PERTAMINA B. NO. 25 RT. 01/03', 'JATISAMPURNA', 'JATIRADEN', NULL, NULL, 35, 300, 100000, 550000000, 10.00, '02128672384', 'http://drive.google.com/uc?id=1zvn3yjfwsGQWAOpET79oaq_bOSSee6P9', 0, 1, '-6.35324', '106.92636', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1120, 3, 'PT. NINA SEJAHTERA ABADI', 'P.2.02.0001746.18.01', 'KANTIN RS. MITRA CIBUBUR', 'JL. ALTERNATIF CIBUBUR', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 6, 20, 45000, 8842500, 10.00, '082112741576', 'http://drive.google.com/uc?id=1BFekFYCJQfEy285khgQOvuZh50FWDTIZ', 0, 1, '-6.35324', '106.92636', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1121, 1, 'TITI', 'P.2.02.0000249.18.01', 'AYAM GORENG SUHARTI', 'JL. ALTERNATIF CIBUBUR NO 41', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 15, 40, 70000, 336000000, 10.00, '081283777578', 'http://drive.google.com/uc?id=1D4X8ywyz11WmpZaeddzuH1Y_7eD9M_ZP', 0, 1, '-6.37974', '106.92186', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1122, 2, 'EUGEU', 'P.2.02.0004527.18.02', 'JIWAN COFFEE & THINGS', 'JL. RAYA KALIMANGGIS NO. 52', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 5, 59, 50000, 81250000, 10.00, '08988550660', 'http://drive.google.com/uc?id=1GHQ4cwZ4IwzvZwI-fSwrt7l_HBLOmUdx', 0, 1, '-6.38777', '106.91128', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1123, 1, 'PETRUS', 'P.2.02.0005058.18.02', 'COFFEE TOWER', 'JL. RAYA CIMATIS NO. 50 RT. 01/08', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 20, 200, 50000, 201250000, 10.00, '081319997679', 'http://drive.google.com/uc?id=16aw5x9bZocfV9G_KFBmk9ZHnubqzZBpF', 0, 1, '-6.39428', '106.90774', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1124, 2, 'KURNIANTO HERMANUS', 'P.2.02.0005059.18.01', 'MANSE KOREAN GRILL', 'JL. ALTERNATIF CIBUBUR RIKO KAW NIAGA CITRA GRAND', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 5, 60, 109000, 63547000, 10.00, '08999889905', 'http://drive.google.com/uc?id=19CLZIhsR1KPcQ3V2UmPhy4XqWY2by9li', 0, 1, '-6.37539', '106.9203', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1125, 3, 'ROBBY HERWANTO', 'P.2.02.0004430.18.01', 'KOPI JANJI JIWA', 'JL. ALTERNATIF CIBUBUR RUKO KAWASAN NIAGA CITRA GRAN', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 7, 16, 20000, 38400000, 10.00, '081510007708', 'http://drive.google.com/uc?id=1F4j_opgXXLdA7aZyRKa3ewjVc1ol-j3A', 0, 1, '-6.38183', '106.92599', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1126, 1, 'STEVAN', 'P.2.02.0005011.18.02', 'BAKMI SALOKA', 'RUKO GARDEN VALLEY BLOK I-01 JL. GREEN VALLEY', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 8, 30, 60000, 162540000, 10.00, '08125053099', 'http://drive.google.com/uc?id=17ymgzEK4R34rHS491-9UwwYoMl3FsWBy', 0, 1, '-6.39353', '106.91882', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1127, 1, 'CHEF UKI', 'P.2.02.0001025.18.02', 'UMAKU SUSHI RESTO', 'CITRA GRAND CWI NO.26', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 13, 25, 200000, 1184600000, 10.00, '081381996884', 'http://drive.google.com/uc?id=1BGtcFxWLBWj9XrGSGvTfAfQDQ8U6tFz3', 0, 1, '-6.38315', '106.92432', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1128, 2, 'PT. INDOMARCO PRISMATAMA', 'P.2.02.0004334.18.02', 'POINT CAFE', 'PERUM. CITRA GRAND CW.3.NO.16', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 3, 6, 35000, 103092500, 10.00, '081311855745', 'http://drive.google.com/uc?id=1PP5uUDI1Ei0W2EQ8W9hVnZja7_Y33M5M', 0, 1, '-6.38315', '106.92432', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1129, 1, 'PLAZA CIBUBUR', 'P.2.02.0003800.18.02', 'KEDAI KONGKOW KARAOKE (K3)', 'JL. ALTERNATIF CIBUBUR PLAZA CIBUBUR', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 20, 100, 43000, 215000000, 10.00, '081215550146', 'http://drive.google.com/uc?id=1d1XEwt5S6VQMeibJRPjUneY0Jr7tEkQO', 0, 1, '-6.37663', '106.91479', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1130, 2, 'KOPERASI AMALIYAH HUSADA', 'P.2.02.0004739.18.02', 'KOPERASI AMALIYAH HUSADA', 'JL. ALTERNATIF CIBUBUR NO 6A ( KANTIN RS. PERMATA CIBUBUR)', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 12, 15, 50000, 89500000, 10.00, '0218458806', 'http://drive.google.com/uc?id=12e3VSXmHvAGhajQGVI_9zAx7qew0FAzl', 0, 1, '-6.37609', '106.9116', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1131, 2, 'KWANG PETER HALIM', 'P.2.02.0004390.18.02', 'BANGI CAFFE', 'MALL CIPUTRA LTM DASAR', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 11, 46, 30000, 87375000, 10.00, '088291526164', 'http://drive.google.com/uc?id=1rO7-IJerh-ryt5OJeC0PH4I5arYUr33H', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1132, 1, 'PT. SINAR BAHANA MULYA', 'P.2.02.0002687.18.02', 'THE GALLERY', 'JL. ALTERNATIF CIBUBUR KM. 04 (MALL CIPUTRA)', 'JATISAMPURNA', 'JATISAMPURNA', NULL, NULL, 13, 90, 150000, 296250000, 10.00, '081298632877', 'http://drive.google.com/uc?id=1heO4oOOvsYhpyza5IcLSVG3w5EbejKO9', 0, 1, '-6.38223', '106.92572', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1133, 1, 'NYINYA SWAN', 'P.2.02.0004577.18.02', 'DAPUR SOLO', 'MALL CIPUTRA LTM GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 12, 54, 150000, 318600000, 10.00, '02129377373', 'http://drive.google.com/uc?id=1zo6fsYUAHVhoVtvnfXzYv7aXbFWVB98S', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1134, 2, 'BENI', 'P.2.02.0002073.18.01', 'SATE KHAS SENAYAN', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 15, 121, 100000, 106600000, 10.00, '02129377332', 'http://drive.google.com/uc?id=1e2yIF9e4m4CL2nvDNQN3OhSWPSpeg4Iy', 0, 1, '-6.38354', '106.92551', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1135, 1, 'PT. SUSHI TEI INDONESIA', 'P.2.02.0003548.18.02', 'SUSHI TEI', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 40, 123, 120000, 289680000, 10.00, '02129377388', 'http://drive.google.com/uc?id=1_n8B5YXsEpfaBdp6JazdrTFYeF_llpPr', 0, 1, '-6.38238', '106.92655', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1136, 1, 'ALUYANTO', 'P.2.02.0002075.18.02', 'SOLARIA', 'MALL CIPUTRA LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 17, 97, 75000, 179062500, 10.00, '081398392750', 'http://drive.google.com/uc?id=10fW_oWVJD-2BNO9Fe5xr2MgsU3SXnUij', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1137, 1, 'EDWARD TIRTANATA', 'P.2.02.0004984.18.02', 'KOPI KENANGAN', 'MALL CIPUTRA CIBUBUR LT. 1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 6, 3, 37000, 247352400, 10.00, '08174862898', 'http://drive.google.com/uc?id=1MlAA1aLV5allV0cn48l0tUOwc2hd0Ffe', 0, 1, '-6.38238', '106.92655', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1138, 2, 'ANGELINA', 'P.2.02.0004143.18.03', 'GULU GULU', 'MAL CIPUTRA LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 3, 7, 65000, 109070000, 10.00, '0895374422000', 'http://drive.google.com/uc?id=1RGgsk1czRxJ-99uXYoO23m1qpeKEp6Zz', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:53', '2021-10-20 11:47:53', NULL);
INSERT INTO `restorans` VALUES (1139, 2, 'HAYATI', 'P.2.02.0002171.18.02', 'RICE BOWL', 'MALL CIPUTRA CIBUBUR LT. 1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 5, 28, 70000, 102935000, 10.00, '02129377399', 'http://drive.google.com/uc?id=1CH1gcLbTz-KBR3s6n4YniMfbxr3J7nly', 0, 1, '-6.38238', '106.92655', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1140, 3, 'HAYATI', 'P.2.02.0004218.18.02', 'CUPPA COFFEE', 'MALL CIPUTRA CIBUBUR LT. 1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1-X0zr5fnc43U7jNgy_Wv45_-iArbBeoz', 0, 1, '-6.38253', '106.92652', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1141, 3, 'SUKO', 'P.2.02.0003362.18.02', 'MC. DONALDS', 'MALL CIPUTRA LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 9, 0, 10000, 26640000, 10.00, '08111927682', 'http://drive.google.com/uc?id=1jSShNMyYsHNG855TAuZUsSfSzMktNxKC', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1142, 2, 'FERONIA', 'P.2.02.0002124.18.02', 'CHATIME', 'MALL CIPUTRA CIBUBUR LT. 1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 10, 0, 20000, 59740000, 10.00, '02129376840', 'http://drive.google.com/uc?id=1i-Rabvi7uD-kmUwpA6n4xuVhOsAj6GkS', 0, 1, '-6.38242', '106.9262', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1143, 2, 'BONG FUHTONO', 'P.2.02.0002272.18 02', 'BAKSO A FUNG', 'MALL CIPUTRA LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 5, 17, 70000, 95515000, 10.00, '08111635196', 'http://drive.google.com/uc?id=1z52Hh6shLRFJavMH6RcwuXspwwPw0pv0', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1144, 3, 'TRI AMBARSARI', 'P.2.02.0002273.18.02', 'TAKO N SUSHI BOX', 'MALL CIPUTRA CIBUBUR LT. 2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 4, 9, 30000, 29100000, 10.00, '081388648010', 'http://drive.google.com/uc?id=18NXKh7A408PuiB-mexMztJYTewxsANGJ', 0, 1, '-6.38242', '106.9262', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1145, 1, 'PT. PENDEKAR BODOH', 'P.2.02.0002166.18.02', 'D COST', 'MALL CIPUTRA LT.2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 10, 71, 150000, 548520000, 10.00, '02184593193', 'http://drive.google.com/uc?id=1ZUyxixk5ew3t3BTppl6hN2ja3P6RqtMw', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1146, 2, 'DONI WANANDI', 'P.2.02.0002312.18.02', 'D CREPES', 'MALL CIPUTRA CIBUBUR LT. 2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 4, 4, 25000, 100250000, 10.00, '087786359275', 'http://drive.google.com/uc?id=1Aejsr0zmByWQrdLbdKz0Jw5CkECCxvsF', 0, 1, '-6.38242', '106.9262', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1147, 1, 'PT. NUSANTARA SEJAHTERA RAYA', 'P.2.02.0002235.18.02', 'CAFE XXI MALL CIPUTRA', 'MALL CIPUTRA LT.3', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 10, 0, 106000, 463962000, 10.00, '02129377408', 'http://drive.google.com/uc?id=1swCaVSGrRNQ0tkfe5rIxkSTHHykAR2ob', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1148, 1, 'JONI ANDREAN', 'P.2.02.0002102.18.01', 'J.CO DONUTS & COFFEE', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 15, 80, 60000, 252000000, 10.00, '02129377379', 'http://drive.google.com/uc?id=14BfSJvKxinCGwqA3JAQ7a5p2a5EqUS7f', 0, 1, '-6.38242', '106.9262', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1149, 2, 'PT. PANCA BOGA PARAMITA', 'P.2.02.0022192.18.02', 'ICHIBAN SUSHI', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 7, 80, 35000, 119105000, 10.00, '02129377476', 'http://drive.google.com/uc?id=10JCpIYcUWe-l4K21oEXdwp9OHRhtR4da', 0, 1, '-6.38242', '106.9262', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1150, 2, 'RONI RAHMAN', 'P.2.02.0003132.18.02', 'GEORGIA GRILL', 'CITRA GRAND RUKO CW.11/1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 6, 66, 50000, 56900000, 10.00, '02129824480', 'http://drive.google.com/uc?id=1tywlKpVeT073OaA5VPlBbkvCGyBZhTgc', 0, 1, '-6.38321', '106.92548', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1151, 3, 'DINA ALOISIA YUDIANTI', 'P.2.02.0002274.18.02', 'REST. SAINT CINNAMON', 'RUKO CITRA GRAND CWN10/17', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 3, 14, 50000, 30805000, 10.00, '02129376803', 'http://drive.google.com/uc?id=1X9j1rib86cjOuhBmx81KKFGGJFe9bsIt', 0, 1, '-6.38299', '106.92512', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1152, 2, 'JAIN HASIMAN', 'P.2.02.0002099.18.01', 'RESTO A & W CITRA GRAND', 'JL. ALTERNATIF CIBUBUR RUKO CITRA GRAND CITYWALK', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 14, 78, 45000, 128362500, 10.00, '02129066761', 'http://drive.google.com/uc?id=1IBqKegtRyX2bT_0rMGP9nfSpmEJSuRhW', 0, 1, '-6.38242', '106.9262', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1153, 3, 'PT. CIPTA ADIDAYA SEMESTA', 'P.2.02.0002160.18.02', 'FIESTA STEAK', 'MALL CIPUTRA LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 0, 0, 0, 0, 10.00, '0215492800', 'http://drive.google.com/uc?id=1OkoOB1YmGJfrBeVzYLrLRIy82frPJK95', 0, 1, '-6.38299', '106.92512', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1154, 3, 'PT. SARI COFFEE INDONESIA', 'P.2.02.0002121.18.02', 'STARBUCKS COFFEE', 'MALL CIPUTRA LT.1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 0, 0, 0, 0, 10.00, NULL, 'http://drive.google.com/uc?id=1XKQOrzjVUl312G-SP5uNSMWwH0Oktj17', 0, 1, '-6.38299', '106.92512', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1155, 2, 'JANE SUDARTO', 'P.2.02.0004985.18.02', 'SHIHLIN', 'MALL CIPUTRA CIBUBUR LT. 2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 5, 0, 33000, 65620500, 10.00, '02129377343', 'http://drive.google.com/uc?id=1mwtCxey9p--ZUdFcziZeYF0mVmKWr2-C', 0, 1, '-6.3829', '106.92669', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1156, 3, 'SANDI', 'P.2.02.0003697.18.02', 'HOP-HOP BUBBLE DRINK', 'MALL CIPUTRA CIBUBUR LT.2', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 2, 4, 25000, 26650000, 10.00, '089677695275', 'http://drive.google.com/uc?id=1qCAoxga-K8CFXS4zd-obLadLT4s1sjuY', 0, 1, '-6.38267', '106.9264', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1157, 2, 'JEEMY WANTONO', 'P.2.02.0004710.18.02', 'ROTI\'O', 'MALL CIPUTRA CIBUBUR LT. 1', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 4, 6, 24000, 116160000, 10.00, '085692721669', 'http://drive.google.com/uc?id=12_918ZuvGhnkoraWlC2LI41AqC01BTQc', 0, 1, '-6.38267', '106.9264', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1158, 3, 'CHOIRUL TANJUNG', 'P.2.02.0003382.18.02', 'BASKIN ROBBINS', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 2, 2, 85000, 24862500, 10.00, '0895619257485', 'http://drive.google.com/uc?id=10Nq4Qg-rqZ3wo6LyFwqc4xZAWEXCbWBm', 0, 1, '-6.38267', '106.9264', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1159, 1, 'PT. PANCA BOGA PARAMITA', 'P.2.02.0002215.18.02', 'TA WAN', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 25, 84, 90000, 792504000, 10.00, '02129377397', 'http://drive.google.com/uc?id=11SpGm5WbmgMwVZR0p8UIsaBMOAwPcfir', 0, 1, '-6.38267', '106.9264', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1160, 1, 'IMELDA', 'P.2.02.0004391.18.02', 'AUNTIE ANNE\'S', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 4, 10, 50000, 165800000, 10.00, '085215911501', 'http://drive.google.com/uc?id=1pE2blJZtM5y9tCGUVVjJM2SxcEJl2faE', 0, 1, '-6.38267', '106.9264', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1161, 1, 'BUDI PURNAMA', 'P.2.02.0002923.18.02', 'BAKMI GM', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 28, 150, 120000, 1495800000, 10.00, '02129067036', 'http://drive.google.com/uc?id=14K1E2P_z0e8VUKzOCdGPq5EiemU7HxMi', 0, 1, '-6.38245', '106.92558', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1162, 1, 'ASWIN', 'P.2.02.0002270.18.02', 'MARUGAME UDON', 'MALL CIPUTRA CIBUBUR LT. GF', 'JATISAMPURNA', 'JATI KARYA', NULL, NULL, 25, 50, 250000, 1127975000, 10.00, '02129376830', 'http://drive.google.com/uc?id=1sBXvypWdvF0EGkqwiZPyJkvN3tbK_zsm', 0, 1, '-6.38245', '106.92558', 1, '2021-10-20 11:47:54', '2021-10-20 11:47:54', NULL);
INSERT INTO `restorans` VALUES (1163, 1, 'asep', '3453252', 'aa', 'ASDFASF', 'BANTARGEBANG', 'BANTARGEBANG', NULL, '34', 2, 0, 2000000, 24000000, 10.00, '2352352', NULL, 0, 1, '-6.887049191714959', '107.6156952296473', 8, '2021-10-21 12:26:36', '2021-10-21 12:27:58', '2021-10-21 12:27:58');
INSERT INTO `restorans` VALUES (1164, 2, 'H. Abdullah Mutholib', 'P.2.02.0000189.19.01', 'Restoran Sederhana', 'JL. KEMANG PRATAMA RAYA AM 1B', 'RAWALUMBU', 'BOJONG RAWALUMBU', '003', '001', 14, 20, 50000, 89625000, 10.00, '021-8270851', '2021_RESTORAN_0116412152021.jpeg', 0, 1, '-6.276089189600075', '106.98820799589159', 19, '2021-12-15 11:33:10', '2022-04-14 13:49:01', NULL);
INSERT INTO `restorans` VALUES (1165, 3, 'DIDIN WAHYUDIN', 'P.2.02.0000917.21.03', 'YOKO BENTO', 'PERUM DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 2, 5, 15000, 7665000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2021-12-15 13:17:40', '2022-05-31 11:09:50', NULL);
INSERT INTO `restorans` VALUES (1166, 3, 'WIBOWO', 'P.2.02.0000923.21.01', 'WARUNG SATE BABE', 'JALAN RAYA MUSTIKAJAYA  SETU', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 5, 6, 40000, 21900000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2021-12-15 13:20:32', '2022-05-31 11:00:35', NULL);
INSERT INTO `restorans` VALUES (1167, 3, 'YUFRIZAL', 'P.2.02.0003235.18.02', 'RM. AMPERA RAYA', 'RUKO CITYWALK 1. NO.15 CITRA GRAND', 'JATISAMPURNA', 'JATIKARYA', '011', '005', 3, 20, 13000, 15340000, 10.00, NULL, '2021_RESTORAN_0116712152021.jpg', 0, 1, '-6.38245861200537', '106.92415497005742', 12, '2021-12-15 14:12:10', '2021-12-23 11:00:24', NULL);
INSERT INTO `restorans` VALUES (1168, 3, 'NURUL DINA RIANTI', 'P.2.02.0002506.18.03', 'SOP AYAM PAK MIN KLATEN', 'JL.RAYA HANKAM KRANGGAN NO.89', 'JATISAMPURNA', 'JATIRANGGON', '004', '008', 7, 10, 20000, 18740000, 10.00, '082112755624', '2021_RESTORAN_0116812152021.jpg', 0, 1, '-6.333504588559952', '106.92445534440644', 12, '2021-12-15 14:28:27', '2022-04-14 13:28:18', NULL);
INSERT INTO `restorans` VALUES (1169, 2, 'A.SYAMSARTIKA VIRAWATI', 'P.2.02.0003951.18.01', 'Pikot Coffee & Resto', 'JL. RAYA KRANGGAN NO.43,', 'JATISAMPURNA', 'JATISAMPURNA', '002', '005', 5, 20, 25000, 34325000, 10.00, NULL, '2021_RESTORAN_0116912152021.jpg', 0, 1, '-6.37084553281', '106.91866485323138', 12, '2021-12-15 14:35:42', '2022-04-14 13:34:43', NULL);
INSERT INTO `restorans` VALUES (1170, 2, 'MUHAMAD RIZAL', 'P.2.02.0004116.18.01', 'I STEAK U', 'JL. ALTERNATIF CIBUBUR NO.8B', 'JATISAMPURNA', 'JATISAMPURNA', '003', '018', 3, 12, 99000, 26611200, 10.00, '082113109880', '2021_RESTORAN_0117012152021.jpg', 0, 1, '-6.375209120454765', '106.9093200683013', 12, '2021-12-15 14:42:53', '2021-12-23 11:01:29', NULL);
INSERT INTO `restorans` VALUES (1171, 2, 'ADRIAN CHRISTOPER AGUS', 'P.2.02.0002958.18.02', 'PUYO', 'MALL CIPUTRA CIBUBUR LT.1', 'JATISAMPURNA', 'JATIKARYA', '05', '011', 3, 0, 12500, 63812500, 10.00, '08118074048', '2021_RESTORAN_0117112152021.jpg', 0, 1, '-6.3830440460776865', '106.92600029740723', 12, '2021-12-15 14:50:55', '2022-04-12 11:37:33', NULL);
INSERT INTO `restorans` VALUES (1172, 2, 'JEANY INGKIRIWANG', 'P.2.02.0004157.18.02', 'OLD CHANGKEE', 'RUKO MALL CIPUTRA BLOK.I NO.6-7', 'JATISAMPURNA', 'JATIKARYA', '05', '011', 3, 0, 20000, 22740000, 10.00, '+62877098615833', '2021_RESTORAN_0117212152021.jpeg', 0, 1, '-6.38054365280467', '106.92476801991631', 12, '2021-12-15 15:02:38', '2022-04-14 13:37:20', NULL);
INSERT INTO `restorans` VALUES (1173, 3, 'TONI ARIEFIN', 'P.2.02.0004512.18.02', 'KOPPI', 'MAL CIPUTRA CIBUBUR, JL. ALTERNATIF CIBUBUR NO.2', 'JATISAMPURNA', 'JATIKARYA', '005', '011', 2, 8, 20000, 29900000, 10.00, '0816-993-965', '2021_RESTORAN_0117312152021.jpg', 0, 1, '-6.382535621364113', '106.92647196830141', 12, '2021-12-15 15:09:59', '2022-04-14 14:10:28', NULL);
INSERT INTO `restorans` VALUES (1174, 2, 'TJIA MEI LIANG', 'P.2.02.0002535.18.01', 'YONG TOFU SINGAPURE', 'MALL CIPUTRA CIBUBUR, LANTAI 1, JL. RAYA ALTERNATIF CIBUBUR,', 'JATISAMPURNA', 'JATIKARYA', '005', '011', 3, 30, 75000, 87900000, 10.00, '+622129067032', '2021_RESTORAN_0117412152021.jpeg', 1, 1, '-6.382346097956274', '106.92605548364197', 12, '2021-12-15 15:18:29', '2022-04-12 11:40:43', NULL);
INSERT INTO `restorans` VALUES (1175, 2, 'Lisa', 'P.2.02.0003810.19.01', 'CV. Kemang Bistro', 'JL. KEMANG PRATAMA RAYA BLOK D NO 02', 'RAWALUMBU', 'BOJONG RAWALUMBU', '001', '021', 6, 32, 60000, 80664000, 10.00, '021-82738600', '2021_RESTORAN_0117512152021.jpeg', 0, 1, '-6.287390807413208', '106.97838038206102', 19, '2021-12-15 15:21:50', '2022-04-14 07:55:04', NULL);
INSERT INTO `restorans` VALUES (1176, 2, 'REST. A & W (PT. PRIMA USAHA ERA MANDIRI)', 'p.2.02.0005479.18.02', 'a&w resto', 'MAL CIPUTRA CIBUBUR, LANTAI DASAR, GF UNIT NO. G-36, JATISAMPURNA, BEKASI', 'JATISAMPURNA', 'JATISAMPURNA', '005', '011', 5, 40, 50000, 235500000, 10.00, '+62 813 8722 2037', '2021_RESTORAN_0117612152021.jpg', 0, 1, '-6.383076569008837', '106.92599416412675', 12, '2021-12-15 15:27:37', '2022-05-10 08:38:31', NULL);
INSERT INTO `restorans` VALUES (1177, 1, 'PT. FOODS BEVERAGES INDONESIA ( CHATIME )', 'p.2.02.0002141.18.02', 'chatime', 'L. RAYA ALTERNATIF CIBUBUR KM. 6 ( MALL GRAND CIPUTRA )', 'JATISAMPURNA', 'JATIKARYA', '005', '011', 8, 0, 50000, 392500000, 10.00, '0215829099', '2021_RESTORAN_0117712152021.jpeg', 0, 1, '-6.382986795381358', '106.92446331063108', 12, '2021-12-15 15:38:37', '2022-06-07 08:30:24', NULL);
INSERT INTO `restorans` VALUES (1178, 2, 'SANTI FARID HERAWATI', 'P.2.02.0002195.18.02', 'es teler 77', 'MALL CIPUTRA CIBUBUR, LANTAI 1, JL. ALTERNATIF CIBUBUR', 'JATISAMPURNA', 'JATIKARYA', '005', '011', 3, 20, 30000, 7896000, 10.00, '+6281807225577', '2021_RESTORAN_0117812152021.jpeg', 0, 4, '-6.3824049213478755', '106.92634975480671', 12, '2021-12-15 15:45:21', '2022-01-11 12:33:18', NULL);
INSERT INTO `restorans` VALUES (1179, 2, 'ASYUSYAFRI RUSLIM', 'P.2.02.0005608.18.03', 'ROPANG OTW KRANGGAN', 'JL. HANKAM RAYA NO.6', 'JATISAMPURNA', 'JATIRANGGON', '006', '005', 10, 96, 30000, 63690000, 10.00, '081211648443', '2021_RESTORAN_0117912152021.jpg', 0, 1, '-6.346472020130309', '106.92268131349462', 12, '2021-12-15 16:01:51', '2022-04-12 11:41:19', NULL);
INSERT INTO `restorans` VALUES (1180, 2, 'ENDAH HAYATI', 'P.2.02.0005607.18.05', 'SATE TEGAL SOHIB', 'JL. RAYA KRANGGAN NO.121', 'JATISAMPURNA', 'JATIRADEN', '001', '007', 4, 15, 50000, 13690000, 10.00, '08179119822', '2021_RESTORAN_0118012152021.jpg', 0, 1, '-6.351938521348525', '106.92155443946605', 12, '2021-12-15 16:08:32', '2022-04-12 11:42:05', NULL);
INSERT INTO `restorans` VALUES (1181, 3, 'ASEP MUH SARIP', 'P.2.02.0004323.18.05', 'ADAYA COFFEE', 'JL. RAYA KRANGGAN RUKO SAMPOERNA SQUARE', 'JATISAMPURNA', 'JATIRADEN', '003', '009', 1, 8, 20000, 858000, 10.00, '02128678840', '2021_RESTORAN_0118112152021.jpg', 0, 4, '-6.35475842122963', '106.92044351063088', 12, '2021-12-15 16:16:29', '2022-01-11 12:39:23', NULL);
INSERT INTO `restorans` VALUES (1182, 3, 'DRA.YUNITA SURYASARI', 'P.2.02.0003404.18.02', 'BEBEK NGAMBACK', 'ALAN CIMATIS NO.21, JAIKARYA', 'JATISAMPURNA', 'JATIKARYA', '002', '007', 4, 20, 25000, 15725000, 10.00, '083891658643', '2021_RESTORAN_0118212152021.jpg', 0, 1, '-6.392715057499385', '106.90910056830144', 12, '2021-12-15 16:24:20', '2022-04-12 11:42:37', NULL);
INSERT INTO `restorans` VALUES (1183, 1, 'ROPPAN/PT ROYAL', 'P.2.02.0004355.15.01', 'ROPPAN /PT ROYAL', 'JL KEBANTENAN 1 DSN 1', 'JATIASIH', 'JATIASIH', '002', '010', 8, 47, 55000, 102976500, 10.00, '02182756121', NULL, 0, 1, NULL, NULL, 15, '2021-12-16 11:19:04', '2021-12-28 09:29:11', NULL);
INSERT INTO `restorans` VALUES (1184, 2, 'RICHARDO GELAEL', 'P.2.02.0000238.18.01', 'KFC PLAZA CIBUBUR', 'JL. ALTERNATIF CIBUBUR KM 3 PLAZA CIBUBUR', 'JATISAMPURNA', 'JATIKARYA', '001', '003', 16, 160, 50000, 865750000, 10.00, '08117157137', '2021_RESTORAN_0118412162021.jpg', 0, 1, '-6.376030070921241', '106.91512840452012', 12, '2021-12-16 12:28:28', '2022-06-07 09:11:11', NULL);
INSERT INTO `restorans` VALUES (1185, 2, 'ADEL CANDRA', 'P.2.02.0000235.18.01', 'SIMPANG RAYA', 'JL. ALTERNATIF CIBUBUR NO.77', 'JATISAMPURNA', 'JATISAMPURNA', '002', '009', 8, 40, 17000, 13132500, 10.00, '0218452347', '2021_RESTORAN_0118512162021.jpg', 0, 1, '-6.375058105228969', '106.91701537479173', 12, '2021-12-16 12:36:42', '2022-04-14 14:13:32', NULL);
INSERT INTO `restorans` VALUES (1186, 2, 'SAAD', 'P.2.02.0005311.15.03', 'SABANA RESTORAN', 'JL JATIKRAMAT NO 52.A', 'JATIASIH', 'JATIKRAMAT', '01', '11', 3, 8, 22000, 18898000, 10.00, '081284344068', NULL, 0, 1, NULL, NULL, 15, '2021-12-16 13:55:16', '2021-12-27 10:28:15', NULL);
INSERT INTO `restorans` VALUES (1187, 2, 'Wanoa Plovia Wewengkang', 'P.2.02.0005251.19.03', 'Pizza Box', 'JL. TRISATYA NO 6', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '007', 3, 4, 25000, 8250000, 10.00, '088211630887', '2021_RESTORAN_0118712172021.jpg', 0, 1, '-6.273441712175833', '107.00067222118378', 19, '2021-12-17 09:23:52', '2022-04-14 07:56:58', NULL);
INSERT INTO `restorans` VALUES (1188, 3, 'IRFAN TRINANDA', 'P.2.02.0005170.18.02', 'DWENDAY CAFE', 'PERUM CITRA GRAN RUKO CITY WALK 2 NO 2,', 'JATISAMPURNA', 'JATIKARYA', '005', '011', 6, 50, 25000, 31125000, 10.00, '08111818101', '2021_RESTORAN_0118812172021.jpg', 0, 1, '-6.383032433054798', '106.92426666830131', 12, '2021-12-17 10:11:35', '2022-04-14 14:14:31', NULL);
INSERT INTO `restorans` VALUES (1189, 3, 'ARINTAMI RIZKI DETYA', 'P.2.02.0005436.18.02', 'MALIQ CORNER', 'JL. ALTERNATIF CIBUBUR RUKO MALL CIPUTRA BLOK CW9 NO.1', 'JATISAMPURNA', 'JATIKARYA', '005', '011', 3, 30, 30000, 9510000, 10.00, '02129824012', '2021_RESTORAN_0118912172021.jpg', 0, 1, '-6.383048170729213', '106.92500299713637', 12, '2021-12-17 10:20:34', '2022-04-14 14:15:33', NULL);
INSERT INTO `restorans` VALUES (1190, 2, 'YUSUF ANDI FRIYANTO', 'P.2.02.0004753.18.05', 'SOTO SEDAAP BOYOLALI', 'JL.RAYA KRANGGAN RT.01 RW.07', 'JATISAMPURNA', 'JATIRADEN', '001', '007', 6, 22, 20, 26830, 10.00, '081293731932', '2021_RESTORAN_0119012172021.jpeg', 0, 1, '-6.350723906412852', '106.92214169713633', 12, '2021-12-17 10:32:51', '2022-04-14 14:16:35', NULL);
INSERT INTO `restorans` VALUES (1191, 3, 'AGRI ALDILA PRATHITHA', 'P.2.02.0005606.18.05', 'TAGORA COFFEE DAN EATERY', 'JALAN RAYA KRANGGAN RT.003/RW.007', 'JATISAMPURNA', 'JATIRADEN', '003', '007', 3, 12, 20000, 18700000, 10.00, '081381740288', '2021_RESTORAN_0119112172021.jpg', 0, 1, '-6.360461321357789', '106.92043086632737', 12, '2021-12-17 10:41:09', '2022-04-14 14:18:16', NULL);
INSERT INTO `restorans` VALUES (1192, 2, 'PUDJI ASTUTI', 'P.2.02.0004762.18.02', 'AMAROO', 'RUKO TIME SQUARE BLOK B2 NO. 15, JALAN ALTERNATIF CIBUBUR', 'JATISAMPURNA', 'JATIKARYA', '001', '010', 4, 40, 50000, 10030000, 10.00, NULL, '2021_RESTORAN_0119212172021.jpg', 0, 4, '-6.378844683318415', '106.92052539713647', 12, '2021-12-17 10:54:15', '2022-01-11 12:56:34', NULL);
INSERT INTO `restorans` VALUES (1193, 2, 'AULIA RACHMAN', 'P.2.02.0005274.18.04', 'KEBON IBU FOOD PARK & CAFE', 'JL. MASJID AT TAQWA NO.88, RT.002/RW.001,', 'JATISAMPURNA', 'JATIRANGGA', '002', '001', 10, 90, 30000, 14118000, 10.00, '081510175000', '2021_RESTORAN_0119312172021.jpg', 0, 1, '106.93356336645543', '106.93356336645543', 12, '2021-12-17 11:03:51', '2022-04-12 12:02:49', NULL);
INSERT INTO `restorans` VALUES (1194, 2, 'AR. Sofyan', 'P.2.02.0005035.19.03', 'Cibiuk Resto Rawalumbu', 'JL. PRAMUKA JEMBATAN NOL', 'RAWALUMBU', 'SEPANJANGJAYA', '04', '02', 20, 170, 50000, 46875000, 10.00, '087883795538', '2021_RESTORAN_0119412202021.jpg', 0, 1, '-6.268941236310775', '107.0015546679497', 19, '2021-12-20 14:21:42', '2022-04-14 08:01:13', NULL);
INSERT INTO `restorans` VALUES (1195, 5, 'ABC', 'P.222222222', 'ABCD', 'ZQW', 'AABBCC', 'AABBCCDD', '1', '2', 10, 20, 50000, 0, 0.00, '123456', NULL, 0, 1, NULL, NULL, 1, '2021-12-21 15:09:26', '2022-01-12 14:54:41', '2022-01-12 14:54:41');
INSERT INTO `restorans` VALUES (1196, 5, 'ABCD', 'P.222222223', 'ABCD', 'ZQW', 'AABBCC', 'AABBCCDD', '1', '2', 10, 20, 50000, 0, 0.00, '123457', NULL, 0, 1, NULL, NULL, 1, '2021-12-21 15:09:26', '2022-01-12 14:55:08', '2022-01-12 14:55:08');
INSERT INTO `restorans` VALUES (1197, 5, 'ABCDED', 'P.222222224', 'ABCDED', 'ZQW', 'AABBCC', 'AABBCCDD', '1', '2', 10, 20, 50000, 0, 0.00, '123458', NULL, 0, 1, NULL, NULL, 1, '2021-12-21 15:09:26', '2022-01-12 14:55:19', '2022-01-12 14:55:19');
INSERT INTO `restorans` VALUES (1198, 5, 'ABC', 'P.22222222245345', 'ABCDegwegetg', 'ZQW', 'BANTARGEBANG', 'BANTARGEBANG', '1', '2', 10, 20, 50000, 0, 0.00, '123456', NULL, 0, 4, NULL, NULL, 10, '2021-12-21 15:15:14', '2021-12-21 15:18:16', '2021-12-21 15:18:16');
INSERT INTO `restorans` VALUES (1199, 5, 'ABCD', 'P.222222223', 'ABCD', 'ZQW', 'AABBCC', 'AABBCCDD', '1', '2', 10, 20, 50000, 0, 0.00, '123457', NULL, 0, 4, NULL, NULL, 10, '2021-12-21 15:15:14', '2021-12-21 15:18:48', '2021-12-21 15:18:48');
INSERT INTO `restorans` VALUES (1200, 5, 'ABCDED', 'P.222222224', 'ABCDED', 'ZQW', 'AABBCC', 'AABBCCDD', '1', '2', 10, 20, 50000, 0, 0.00, '123458', NULL, 0, 4, NULL, NULL, 10, '2021-12-21 15:15:14', '2021-12-21 15:19:06', '2021-12-21 15:19:06');
INSERT INTO `restorans` VALUES (1201, 3, 'TANTRI WULANDARI', 'P.2.02.000.52281505', 'COFFEIN', 'KAMPUNG PEDURENAN', 'JATIASIH', 'JATILUHUR', '05', '06', 6, -6, 25000, 31187500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:24:46', '2021-12-27 10:40:24', NULL);
INSERT INTO `restorans` VALUES (1202, 1, 'MEMUNAH', 'P.2.02.0003811.15.01', 'RM CIPUNJUR', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIRASA', '005', '004', 15, 56, 75000, 113512500, 10.00, '085770109290', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:29:15', '2021-12-27 10:20:24', NULL);
INSERT INTO `restorans` VALUES (1203, 3, 'YAJID', 'P.0.02.0004517.15.01', 'MEENUM JATIASIH', 'JL WIBAWA MUKTI', 'JATIASIH', 'JATIASIH', '04', '08', 3, 2, 5000, 3832500, 10.00, '085283385535', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:32:38', '2021-12-23 10:52:58', NULL);
INSERT INTO `restorans` VALUES (1204, 3, 'YAJID', 'P.2.02.0005018.15.04', 'MEENUM JATIRASA', 'JL RAYA JATIRASA', 'JATIASIH', 'JATIRASA', '05', '04', 3, 2, 5000, 3729000, 10.00, '085283385535', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:35:33', '2021-12-23 10:54:29', NULL);
INSERT INTO `restorans` VALUES (1205, 1, 'HJ EVI', 'P.2.02.0005244.15.01', 'RM SAUNG GANDASARI', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '03', '09', 8, 40, 30000, 50160000, 10.00, '081296406026', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:42:51', '2021-12-27 10:15:33', NULL);
INSERT INTO `restorans` VALUES (1206, 2, 'ACHMAD', 'P.2.02.0005549.15.01', 'RM.KEPALA MANYUN BU FAT', 'JL RAYA JATIASIH NO 80', 'JATIASIH', 'JATIASIH', '08', '11', 9, 40, 50000, 16600000, 10.00, '0811114544', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:46:05', '2021-12-27 10:34:55', NULL);
INSERT INTO `restorans` VALUES (1207, 2, 'DADANG', 'P.2.02.0004190.15.01', 'IKAN BAKAR ABAH', 'JL SWATANTRA JATIASIH', 'JATIASIH', 'JATIASIH', '03', '04', 10, 80, 55000, 27830000, 10.00, '087721065926', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:48:46', '2021-12-29 10:09:39', NULL);
INSERT INTO `restorans` VALUES (1208, 2, 'SITI ZULFA', 'P.2.02.0002589.15.01', 'HUK FAMILY RESTO', 'JL PARPOSTEL 3/2 JATILUHUR', 'JATIASIH', 'JATILUHUR', '01', '01', 5, 56, 40000, 47520000, 10.00, '085814063226', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:52:21', '2021-12-27 10:14:49', NULL);
INSERT INTO `restorans` VALUES (1209, 2, 'ANTO', 'P.2.02.0005625.15.01', 'KEDAI KOPI KULO', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '07', '08', 3, NULL, 17000, 8143000, 10.00, '081321117991', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 09:56:33', '2021-12-27 10:33:59', NULL);
INSERT INTO `restorans` VALUES (1210, 1, 'FACHRUDIN', 'P.2.02.0001884.15.01', 'MC DONALD\'S', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '005', '010', 53, 100, 175000, 2487712500, 10.00, '087883978741', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 10:29:25', '2021-12-27 11:10:27', NULL);
INSERT INTO `restorans` VALUES (1211, 2, 'JUGO WIDIJATNO', 'P.2.02.0004306.15.03', 'POINT CAFE /PT INDOMARKO JATIKRAMAT', 'JL RAYA JATIKRAMAT', 'JATIASIH', 'JATIKRAMAT', '06', '09', 2, 8, 15000, 14355000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-22 10:35:38', '2022-04-07 14:26:19', NULL);
INSERT INTO `restorans` VALUES (1212, 1, 'JCO DONUTS COFFE', 'P.2.02.0004552.15.01', 'JCO DONUTS & CAFFE', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '05', '10', 15, 64, 75000, 551587500, 10.00, '02182743109', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 10:38:42', '2021-12-27 11:12:28', NULL);
INSERT INTO `restorans` VALUES (1213, 1, 'DENNI HERYADI', 'P.2.02.00050.20.15.04', 'EPIC LOASTERY CAFE', 'JL RAYA PEKAYON NO 40', 'JATIASIH', 'JATIASIH', '007', '005', 6, 20, 15000, 6142500, 10.00, '081916797771', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 10:42:07', '2021-12-27 10:29:13', NULL);
INSERT INTO `restorans` VALUES (1214, 3, 'JYO WIDIJATNO', 'P.2.02.0004467.15.03', 'POINT CAFE / PT INDOMARCO RATNA', 'JL RAYA RATNA', 'JATIASIH', 'JATIKRAMAT', '001', '001', 20000, 8, 20000, 75626000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-22 10:56:03', '2021-12-29 10:35:22', NULL);
INSERT INTO `restorans` VALUES (1215, 1, 'BUDI HASANUDIN', 'P.2.02.0001941.15.01', 'PIZZA HUT JATIASIH', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '003', '004', 12, 42, 135000, 1075207500, 10.00, '08113249353', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 11:03:12', '2021-12-28 09:34:31', NULL);
INSERT INTO `restorans` VALUES (1216, 2, 'MELLY', 'P.2.02.0004035.15.01', 'REST PONDOK INDAH RAYA', 'JL WIBAWA MUKTI RUKO KOMSEN', 'JATIASIH', 'JATIASIH', '02', '11', 10, 44, 40000, 101240000, 10.00, '081288214235', NULL, 0, 1, NULL, NULL, 15, '2021-12-22 11:22:54', '2021-12-28 11:02:11', NULL);
INSERT INTO `restorans` VALUES (1232, 9, 'AAAA', '121232321', '1231SSAS', 'DQEF', 'EF', 'DGRTH', '1', '2', 5, 6, 50000, 0, 0.00, '123', NULL, 0, 4, NULL, NULL, 10, '2021-12-27 14:25:26', '2021-12-27 14:25:51', '2021-12-27 14:25:51');
INSERT INTO `restorans` VALUES (1233, 9, 'BBBBB', '111', 'ASASADS', 'DQEF', 'EF', 'DGRTH', '1', '2', 5, 6, 100000, 0, 0.00, '31333', NULL, 0, 4, NULL, NULL, 10, '2021-12-27 14:25:26', '2021-12-27 14:26:01', '2021-12-27 14:26:01');
INSERT INTO `restorans` VALUES (1234, 9, 'CCCC', '31313', 'DWCWEF', 'DQEF', 'EF', 'DGRTH', '1', '2', 5, 6, 75000, 0, 0.00, '3', NULL, 0, 4, NULL, NULL, 10, '2021-12-27 14:25:26', '2021-12-27 14:26:10', '2021-12-27 14:26:10');
INSERT INTO `restorans` VALUES (1235, 9, 'DDDDD', '222', '3232VVVV', 'DQEF', 'EF', 'DGRTH', '1', '2', 5, 6, 50000, 0, 0.00, '33333', NULL, 0, 4, NULL, NULL, 10, '2021-12-27 14:25:26', '2021-12-27 14:26:19', '2021-12-27 14:26:19');
INSERT INTO `restorans` VALUES (1236, 10, 'BB', 'AA', 'CC', 'ALAMAT', 'BKS', 'BKS', '2', '1', 5, 15, 50000, 0, 0.00, '2', NULL, 0, 4, '0', '111', 10, '2021-12-27 14:42:19', '2021-12-27 14:43:31', '2021-12-27 14:43:31');
INSERT INTO `restorans` VALUES (1237, 10, 'BC', 'AB', 'DD', 'ALAMAT', 'BKS', 'BKS', '2', '1', 4, 20, 50000, 0, 0.00, '3', NULL, 0, 4, '0', '112', 10, '2021-12-27 14:42:19', '2021-12-27 14:43:43', '2021-12-27 14:43:43');
INSERT INTO `restorans` VALUES (1238, 2, 'SIWI', 'P.2.02.0002799.15.01', 'BAKSO BALUNGAN', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', NULL, NULL, 10, 16, 30000, 12666000, 10.00, '081398105656', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 08:36:40', '2021-12-29 11:17:07', NULL);
INSERT INTO `restorans` VALUES (1239, 2, 'DIANA', 'P.2.02.0003528.15.01', 'FOOD COURT KOTA CINEMA MALL', 'JL PARPOSTEL 3/2 JATILUHUR', 'JATIASIH', 'JATILUHUR', '01', '01', 15, 56, 75000, 146370000, 10.00, '085814063226', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 08:47:57', '2021-12-29 11:17:38', NULL);
INSERT INTO `restorans` VALUES (1240, 2, 'FADIL', 'P.2.02.0005603.15.01', 'STREET BOBA JATIASIH', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '03', '05', 5, 3, 10000, 4265000, 10.00, '08561422918870', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 08:53:43', '2022-01-05 10:20:21', NULL);
INSERT INTO `restorans` VALUES (1241, 2, 'YUSLAM', 'P.2.02.0005604.15.01', 'GILDAK JATIASIH', 'JL WIBAWA MUKTI II RT03/05', 'JATIASIH', 'JATIASIH', '03', '05', 8, 16, 10000, 3640000, 10.00, '0861422918870', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 09:03:06', '2022-01-05 10:24:04', NULL);
INSERT INTO `restorans` VALUES (1242, 2, 'PUSPO WARDOYO', 'P.2.02.0002319.15.01', 'AYAM KQ5', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '003', '009', 12, 68, 35000, 54110000, 10.00, '021 82411402', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 09:06:11', '2021-12-29 10:49:56', NULL);
INSERT INTO `restorans` VALUES (1243, 2, 'CIPTO', 'P.2.02.0003453.15.01', 'FOOD COURT GS SUPERMARKET', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '001', '012', 4, 39, 30000, 59049000, 10.00, '081312822511', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 09:13:48', '2021-12-29 10:49:11', NULL);
INSERT INTO `restorans` VALUES (1244, 2, 'SITI ZULFA', 'P.2.02.000236.15.01', 'BEBEK BENTU', 'JL WIBAWA MUKTI II NO 43', 'JATIASIH', 'JATIASIH', '003', '005', 5, 43, 35000, 71767500, 10.00, '08381990881', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 09:19:32', '2021-12-29 11:16:12', NULL);
INSERT INTO `restorans` VALUES (1245, 1, 'PT DOM PIZZA INDONESIA/AUDI PRATAMA', 'P.2.02.0003143.15.01', 'DOMINAS PIZZA JATIASIH', 'JL WIBAWA MUKTI', 'JATIASIH', 'JATIASIH', '003', '005', 12, 5, 100000, 385660000, 10.00, '021 82732998', NULL, 0, 1, NULL, NULL, 15, '2021-12-28 09:38:41', '2021-12-29 11:18:33', NULL);
INSERT INTO `restorans` VALUES (1246, 3, 'ATMAJA', 'P.2.02.0002886.15.05', 'WARUNG GABUS BETAWI NANI', 'JL RAYA LEGOK', 'JATIASIH', 'JATILUHUR', '004', '003', 5, 36, 10000, 3691000, 10.00, '08788171785', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 11:03:58', '2022-01-11 08:27:04', NULL);
INSERT INTO `restorans` VALUES (1247, 2, 'RICARDO GELAEL', 'P.2.02.0002570.15.01', 'KFC', 'JL RAYA KOMSEN', 'JATIASIH', 'JATIASIH', '003', '005', 14, 60, 75000, 1370190000, 10.00, '08788413030', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 11:12:08', '2022-01-04 10:14:30', NULL);
INSERT INTO `restorans` VALUES (1248, 3, 'YUNADIE AHSAN', 'P.2.02.0005594.11.03', 'TJANGKIR KOPI', 'JL. PAHLAWAN NO. 27 A', 'BEKASI TIMUR', 'DURENJAYA', '006', '004', 4, 24, 30000, 13899000, 10.00, '081280015998', '2021_RESTORAN_0124812292021.jpg', 0, 1, '-6.2374901460653245', '107.02645897865297', 10, '2021-12-29 11:28:02', '2022-04-14 08:18:45', NULL);
INSERT INTO `restorans` VALUES (1249, 2, 'HJ MARYANI SIDIK', 'P.2.02.0005540.15.05', 'JOGLO KEMBAR /PT SHIDQIYA BERKAH MANDIRIZ', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATILUHUR', '15', '005', 14, 24, 55000, 61270000, 10.00, '085276370076', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 11:42:14', '2022-01-05 10:34:58', NULL);
INSERT INTO `restorans` VALUES (1250, 3, 'MUHAMMAD KURNIAWAN', 'P.2.02.0005496.11.01', 'WARUNG KOPI GEMPOL', 'JL. BAMBU RUNCING TELUK ANGSAN NO. 01', 'BEKASI TIMUR', 'BEKASIJAYA', '007', '006', 4, 18, 40000, 21100000, 10.00, '08118809500', '2021_RESTORAN_0125012292021.jpg', 0, 1, '-6.241500291891509', '107.03807830810548', 10, '2021-12-29 12:36:27', '2022-04-14 08:20:24', NULL);
INSERT INTO `restorans` VALUES (1251, 2, 'sriwahyuni', 'P.2.02.0004557.15.01', 'ROEMAH DAUN SALMA', 'JL SIROJIR MUNIR', 'JATIASIH', 'JATISARI', '001', '003', 6, 60, 35000, 34888000, 10.00, '08119990554', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 14:28:37', '2022-01-04 10:31:14', NULL);
INSERT INTO `restorans` VALUES (1252, 2, 'ALIF', 'P.2.02.0005597.15.01', 'GARDEN CAFE', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATISARI', '04', '05', 2, 60, 15000, 5400000, 10.00, '081294458499', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 14:31:53', '2022-01-05 10:24:45', NULL);
INSERT INTO `restorans` VALUES (1253, 1, 'HOKA-HOKA BENTO', 'P.2.02.0002777.15.01', 'HOKA-HOKA BENTO', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '008', '001', 15, 60, 125000, 1373750000, 10.00, '0895379221745', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 14:42:02', '2022-01-04 10:32:44', NULL);
INSERT INTO `restorans` VALUES (1254, 2, 'KOPI KENAGAN', 'P.2.02.00051061.15.04', 'KOPI KENANGAN', 'JL WIBAWA MUKTI II KOMSEN', 'JATIASIH', 'JATIASIH', '003', '005', 6, 20, 35000, 349247500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-29 14:50:50', '2022-01-04 10:36:56', NULL);
INSERT INTO `restorans` VALUES (1255, 1, 'ANTHONY', 'P.2.02.0003958.15.01', 'STARBUCK CAFE', 'JL. RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '005', '003', 10, 50, 75000, 437475000, 10.00, '087880795958', NULL, 1, 1, NULL, NULL, 15, '2021-12-29 14:57:17', '2022-01-05 12:57:39', NULL);
INSERT INTO `restorans` VALUES (1256, 1, 'MOHAMMAD FATURAHMAN', 'P.2.02.0005243.15.05', 'WARKOP KOPI TANJAKAN', 'JL. H. ABDUL ROJAK', 'JATIASIH', 'JATILUHUR', '009', '011', 10, 25, 10000, 33890000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:00:30', '2022-01-19 10:35:29', NULL);
INSERT INTO `restorans` VALUES (1257, 3, 'STEVEN', 'P.2.02.000.5175.15.01', 'XIBOBA', 'JL. RAYA KOMSEN JATIASIH', 'JATIASIH', 'JATIASIH', '04', '04', NULL, NULL, NULL, 0, 10.00, '08129593301', NULL, 0, 4, NULL, NULL, 15, '2021-12-29 15:08:16', '2022-01-05 11:18:43', '2022-01-05 11:18:43');
INSERT INTO `restorans` VALUES (1258, 3, 'EDY NURHAMID AMIN', 'P.2.02.0004161.15.01', 'CHESSE CHIKEN', 'JL. WIBAWA MUKTI II NO.75', 'JATIASIH', 'JATIKRAMAT', '002', '007', 3, 8, 10000, 4095000, 10.00, '085796740904', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:12:32', '2022-01-19 10:36:00', NULL);
INSERT INTO `restorans` VALUES (1259, 3, 'ULUL ALBAB', 'P.2.02.0003141.15.04', 'BEBEK H. SLAMET', 'JL. PONDOK GEDE PERMAI', 'JATIASIH', 'JATIRASA', '003', '004', 4, 24, 20000, 7560000, 10.00, '081288364088', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:16:35', '2022-01-19 10:37:05', NULL);
INSERT INTO `restorans` VALUES (1260, 3, 'CUCU SODIKIN/ANTO', 'P.2.02.0002826.15.03', 'FIT AND FOOD CANTEN', 'JL. RAYA PONDOK GEDE', 'JATIASIH', 'JATIKRAMAT', '007', '009', 3, 24, 15000, 8880000, 10.00, '081290900849', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:19:16', '2022-03-01 11:00:53', NULL);
INSERT INTO `restorans` VALUES (1261, 3, 'RAFDI AGUNG MAMANA', 'P.2.02.0000161.15.03', 'BAKMI VILLANI', 'JL. RAYA JATIKRAMAT NO. 99A', 'JATIASIH', 'JATIKRAMAT', '005', '001', 8, 30, 20000, 14500000, 10.00, '087898253222', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:24:29', '2022-04-07 09:07:51', NULL);
INSERT INTO `restorans` VALUES (1262, 3, 'TEGUH WAHYUDIYANTO', 'P.2.02.0005626.15.02', 'ESCAPE GARDEN', 'KP. RAWA BOGO RT.001/016 JATIMEKAR', 'JATIASIH', 'JATISARI', '001', '018', 8, 40, 18000, 17271000, 10.00, '08119625437', NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:29:26', '2022-03-01 11:03:06', NULL);
INSERT INTO `restorans` VALUES (1263, 3, 'BIMO SARASHADI', 'P.2.02.0005127.15.02', 'COFFE KITA', 'JL RAYA JATIMEKAR', 'JATIASIH', 'JATIMEKAR', '01', '02', 4, 60, 18000, 9711000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-29 15:32:43', '2022-01-05 10:25:21', NULL);
INSERT INTO `restorans` VALUES (1264, 3, 'BAPAK H.YUSUF', 'P.2.02.0000996', 'DAPUR BETAWI II', 'JL WIBAWA MUKTI', 'JATIASIH', 'JATILUHUR', '001', '011', 6, 24, 15000, 5926500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 08:25:26', '2022-01-11 09:09:24', NULL);
INSERT INTO `restorans` VALUES (1265, 3, 'DANAR HARYANTO', 'P.2.02.0003810.15.03', 'KIMO STREET FOOD', 'JL ALHUSNA NO 23', 'JATIASIH', 'JATIKRAMAT', '001', '001', 3, 16, 10000, 4245000, 10.00, '085776290297', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 08:29:50', '2022-01-05 08:52:50', NULL);
INSERT INTO `restorans` VALUES (1266, 3, 'RAFDI AGUNG MAULANA', 'P.2.02.0005541.15.01', 'MIE JAMUR VILANIE', 'JL WIBAWA MUKTI 2 NO 68', 'JATIASIH', 'JATIASIH', '003', '006', 5, 20, 15000, 5355000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 08:34:03', '2022-03-01 10:59:39', NULL);
INSERT INTO `restorans` VALUES (1267, 2, 'H,MUHAMMAD JAMALUDIN', 'P.2.02.000.5589.15.02', 'KOPI DUL', 'JL RAYA RATNA', 'JATIASIH', 'JATIMEKAR', '002', '003', 6, 30, 10000, 7220000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 08:46:08', '2022-01-05 10:08:41', NULL);
INSERT INTO `restorans` VALUES (1268, 3, 'YULIA ANGGRAENI', 'P.2.02.0005512.11.03', 'BENG BENG DRINK VOC', 'JL. KARANG SATRIA', 'BEKASI TIMUR', 'DURENJAYA', '005', '007', 5, 30, 30000, 19425000, 10.00, '085778834804', '2021_RESTORAN_0126812302021.jpg', 0, 1, '-6.223667706328529', '107.03893661499025', 10, '2021-12-30 08:51:25', '2022-04-14 08:22:03', NULL);
INSERT INTO `restorans` VALUES (1269, 1, 'VIQRI AL HUDA IN RAFSANJANI', 'P.2.02.0005569.15.02', 'STACO COFEE & EATERY', 'JL RAYA JATILUHUR', 'JATIASIH', 'JATILUHUR', '007', '017', 6, 35, 15000, 8727000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 08:53:35', '2022-01-05 10:18:05', NULL);
INSERT INTO `restorans` VALUES (1270, 3, 'KELVIN', 'P.2.02.0005511.11.01', 'NATURALIS KOFFIE', 'JL. KH AGUS SALIM', 'BEKASI TIMUR', 'BEKASIJAYA', '010', '007', 5, 140, 30000, 38850000, 10.00, '081285406438', '2021_RESTORAN_0127012302021.jpg', 0, 1, '-6.225843484867998', '107.01504349708559', 10, '2021-12-30 09:01:09', '2022-04-18 08:52:54', NULL);
INSERT INTO `restorans` VALUES (1271, 3, 'RUDIYANTO', 'P.2.02.0002033.11.02', 'SATE KANG RUDY', 'JL. RA KARTINI', 'BEKASI TIMUR', 'MARGAHAYU', '005', '001', 6, 40, 18000, 15210000, 10.00, '081233333996', '2021_RESTORAN_0127112302021.jpg', 0, 1, '-6.245425085742825', '107.00363874435425', 10, '2021-12-30 09:15:33', '2022-04-14 08:23:20', NULL);
INSERT INTO `restorans` VALUES (1272, 2, 'JAP JANTI KUSUMA JAYA', 'P.2.02.0004574.15.01', 'BURGER KING', 'JL RAYA JATIASIH NO 36', 'JATIASIH', 'JATIASIH', '005', '010', 22, 40, 65000, 1070225000, 10.00, NULL, NULL, 1, 1, NULL, NULL, 15, '2021-12-30 11:38:26', '2022-01-05 10:04:25', NULL);
INSERT INTO `restorans` VALUES (1273, 2, 'PHD WIBAWA MUKTI/PT SARI MELATIH', 'P2.02.0003556.15.05', 'PHD WIBAWA MUKTI', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '001', '009', 8, 4, 60000, 440100000, 10.00, '1500600', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 11:42:51', '2022-01-05 10:07:03', NULL);
INSERT INTO `restorans` VALUES (1274, 3, 'YOSUA JEMAN DAULIKA', 'P.02.0005612.15.03', 'KOPI DARI JATI BENING', 'JALAN ANTILOVE KAV 2', 'JATIASIH', 'JATIKRAMAT', '001', '001', 6, 20, 15000, 12817500, 10.00, '081281107500', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 11:54:59', '2022-03-01 11:04:41', NULL);
INSERT INTO `restorans` VALUES (1275, 1, 'RICARDO LUMALESIL ZAULFIKAR', 'P2.02.0005311.15.03', 'SABANA RESTO JATIKRAMAT', 'JL JATIKRAMAT NO 52 A', 'JATIASIH', 'JATIKRAMAT', '011', '01', 6, 6, 20000, 17280000, 10.00, '08111939038', NULL, 0, 4, NULL, NULL, 15, '2021-12-30 12:50:57', '2022-01-05 11:17:53', '2022-01-05 11:17:53');
INSERT INTO `restorans` VALUES (1276, 1, 'ABUBA STEAK / PT.BOGA BERSAMA MAKMUR', 'P.2.02.0003533.16.01', 'ABUBA STEAK / PT.BOGA BERSAMA MAKMUR', 'JL.JATIWARINGIN RAYA', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 20, 50, 400000, 622000000, 10.00, NULL, '2021_RESTORAN_0127612302021.png', 1, 1, '-6.280075044131616', '106.91365331411363', 18, '2021-12-30 12:53:11', '2022-05-30 15:00:28', NULL);
INSERT INTO `restorans` VALUES (1277, 3, 'PANJAITAN', 'P.2.02.0004554.15.01', 'SATE KILOAN', 'JL WIABAWA MUKTI II', 'JATIASIH', 'JATIASIH', '003', '005', 8, 12, 20000, 7190000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 12:55:42', '2022-01-05 12:21:00', NULL);
INSERT INTO `restorans` VALUES (1278, 2, 'RM.BEBEK KALEYO', 'P.2.02.0001970.16.01', 'RM.BEBEK KALEYO', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 40, 100, 200000, 585000000, 10.00, NULL, NULL, 0, 1, '-6.271895344517852', '106.91237658262254', 18, '2021-12-30 12:57:38', '2022-04-18 14:21:27', NULL);
INSERT INTO `restorans` VALUES (1279, 2, 'SUCI', 'P.2.02.0004507.15.01', 'SAHL KEBAB/ PT SAHARA AGRO UTAMA', 'JL WIBAWA MUKTI', 'JATIASIH', 'JATIASIH', '02', '05', 10, 12, 55000, 65807500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 13:01:22', '2022-01-05 10:26:38', NULL);
INSERT INTO `restorans` VALUES (1280, 2, 'SITI HARIANI NUR UTAMI', 'P.2.02.0002562.16.01', 'WAROENG STEAK AND SHAKE / PT. WAROENG STEAK INDONESIA', 'JL.RAYA JATIWARINGIN RT 02 / 15', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 40, 80, 200000, 865000000, 10.00, NULL, '2021_RESTORAN_0128012302021.png', 1, 1, '-6.27077022585626', '106.91178649663927', 18, '2021-12-30 13:09:18', '2022-04-18 14:21:58', NULL);
INSERT INTO `restorans` VALUES (1281, 2, 'ICHIBAN SUSHI / PT. PANCA BOGA PARAMITHA', 'P.2.02.0003507.16.01', 'ICHIBAN SUSHI / PT. PANCA BOGA PARAMITHA', 'PLAZA PONDOK GEDE 2 BLOK E NO.24', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 30, 40, 200000, 617000000, 10.00, NULL, '2021_RESTORAN_0128112302021.jpg', 1, 1, '-6.284308814721272', '106.91157460212709', 18, '2021-12-30 13:36:33', '2022-04-18 14:22:16', NULL);
INSERT INTO `restorans` VALUES (1282, 2, 'PT.CHAMPRESTO INDONESIA (GOKANA TEPPAN)', 'P.2.02.0001597.16.01', 'GOKANA TEPPAN PDK GEDE / PT. CHAMPRESTO', 'PLAZA PONDOK GEDE 2 LT DASAR BLOK E NO.183', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 30, 60, 80000, 372000000, 10.00, NULL, '2021_RESTORAN_0128212302021.jpg', 1, 1, '-6.283946226145309', '106.91212713718416', 18, '2021-12-30 13:43:34', '2022-05-31 10:11:00', NULL);
INSERT INTO `restorans` VALUES (1283, 3, 'TAMIT BIN RIMAN', 'P2.02.0004449.15.05', 'GABUS BETAWI TAMIT RIMAN', 'KP KEBANTENAN', 'JATIASIH', 'JATIASIH', '001', '09', 10, 28, 15000, 5941500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 13:57:56', '2022-01-05 12:22:00', NULL);
INSERT INTO `restorans` VALUES (1284, 2, 'PEMPEK GABY', 'P.2.02.000369815.01', 'PEMPEK GABY', 'JL WIBAWA MUKTI II', 'JATIASIH', 'JATIASIH', '003', '005', 20, 12, 55000, 327167500, 10.00, '081574255609', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 14:08:10', '2022-01-05 12:24:02', NULL);
INSERT INTO `restorans` VALUES (1285, 2, 'JOHANES JULIUS', 'P.2.02.000313.15.01', 'DUNKIN DONUTS JATIASIH', 'JL TERAS II KEBANTENAN', 'JATIASIH', 'JATIASIH', '005', '010', 15, 35, 65000, 211152500, 10.00, '081288214235', NULL, 0, 1, NULL, NULL, 15, '2021-12-30 14:13:57', '2022-01-05 12:53:02', NULL);
INSERT INTO `restorans` VALUES (1286, 3, 'TONY NUGROHO', 'P.2.02.0005628.16.01', 'PEMPEK GABY', 'JL.RAYA JATIWARINGIN NO 38 RT 001 RW 004', 'PONDOKGEDE', 'JATIWARINGIN', '001', '004', 6, 20, 50000, 79875000, 10.00, NULL, '2021_RESTORAN_0128612302021.png', 0, 1, '-6.271900676828014', '106.91236585378648', 18, '2021-12-30 14:17:29', '2022-04-18 14:22:51', NULL);
INSERT INTO `restorans` VALUES (1287, 2, 'DARMAWANGSA RESIDENCE CLUSTER', 'P2.02.0004114.15.01', 'BAKSO BOEDJANGAN', 'JL WIBAWA MUKTI II NO 24', 'JATIASIH', 'JATIASIH', '004', '010', 15, 32, 35000, 100835000, 10.00, NULL, NULL, 1, 1, NULL, NULL, 15, '2021-12-30 14:18:10', '2022-06-15 08:50:50', '2022-06-15 08:50:50');
INSERT INTO `restorans` VALUES (1288, 3, 'DWITIO SYAHPUTRA', 'P2.02.0004932.15.01', 'BAKSO ACI AKANG', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '004', '004', 8, 10, 20000, 10110000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 14:23:44', '2022-01-05 12:25:07', NULL);
INSERT INTO `restorans` VALUES (1289, 3, 'BU ISMI', 'P.02.0001001.15.05', 'PONDOK CITRA', 'JL RAYA PORPOSTEL NO 85', 'JATIASIH', 'JATILUHUR', '001', '007', 6, 24, 15000, 8242500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2021-12-30 14:34:27', '2022-04-07 14:30:58', '2022-04-07 14:30:58');
INSERT INTO `restorans` VALUES (1290, 1, 'ZAINA SIMAN', 'P.2.02.0000895.16.01', 'A & W PLAZA PONDOK GEDE / PT. PRIMA USAHA ERA MANDIRI', 'PLAZA PONDOK GEDE 2 BLOK E NO.8', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 40, 100000, 306000000, 10.00, NULL, '2021_RESTORAN_0129004272022.jpg', 1, 4, '-6.2836422917344725', '106.9115011456874', 18, '2021-12-31 10:23:41', '2022-05-20 13:25:11', '2022-05-20 13:25:11');
INSERT INTO `restorans` VALUES (1291, 2, 'PAIMAN', 'P.2.02.0003509.16.01', 'BAKMI NAGA', 'PLAZA PONDOK GEDE LT 1', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 15, 50, 150000, 330375000, 10.00, NULL, '2021_RESTORAN_0129112312021.jpg', 0, 1, '-6.284436787099513', '106.9114887714386', 18, '2021-12-31 10:27:07', '2022-04-18 14:23:12', NULL);
INSERT INTO `restorans` VALUES (1292, 2, 'RM. BEBEK MUDA', 'P.2.02.0005089.16.01', 'BEBEK MUDA', 'PONDOK GEDE MALL 2', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 25, 50, 150000, 453750000, 10.00, NULL, '2021_RESTORAN_0129212312021.jpg', 0, 1, '-6.284415458372004', '106.91211104393007', 18, '2021-12-31 10:33:59', '2022-04-18 14:23:33', NULL);
INSERT INTO `restorans` VALUES (1293, 2, 'CABE MERAH /PT. KYATI SELERA PROSPERA', 'P.2.02.0004093.16.01', 'CABE MERAH /PT. KYATI SELERA PROSPERA', 'PLAZA PONDOK GEDE LT 2', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 25, 50, 200000, 597000000, 10.00, NULL, '2021_RESTORAN_0129312312021.jpg', 0, 1, '-6.284415458372004', '106.91162288188936', 18, '2021-12-31 10:47:25', '2022-04-18 14:24:08', NULL);
INSERT INTO `restorans` VALUES (1294, 3, 'REST CHATIME ( PT. FOODS BEVERAGES INDONESIA )', 'P.2.02.0003323.16.01', 'CHATIME  / PT. FOODS BEVERAGES INDONESIA', 'PONDOK GEDE PLAZA BLOK A NO.2', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 8, 6, 50000, 71750000, 10.00, NULL, '2022_RESTORAN_0129401032022.jpg', 1, 1, '-6.2841701779426495', '106.91136538982393', 18, '2022-01-03 09:09:13', '2022-04-18 14:24:44', NULL);
INSERT INTO `restorans` VALUES (1295, 1, 'ADE WAHMADI', 'P.2.02.0002052.16.04', 'MC DONALDS JATIWARINGIN', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', '-', '-', 20, 30, 100000, 430000000, 10.00, '-', '2022_RESTORAN_0129501032022.jpeg', 0, 4, '-6.268349346192006', '106.91125810146333', 18, '2022-01-03 09:24:01', '2022-05-20 13:26:18', '2022-05-20 13:26:18');
INSERT INTO `restorans` VALUES (1296, 2, 'PT.PENDEKAR BODOH (REST. THE COST SEAFOOD)', 'P.2.02.0001738.16.01', 'THE COST SEAFOOD  / PT.PENDEKAR BODOH', 'PLAZA PONDOK GEDE 1 LT 3', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 25, 100, 90000, 353250000, 10.00, NULL, '2022_RESTORAN_0129601032022.jpg', 1, 1, '-6.283828918022517', '106.9116121530533', 18, '2022-01-03 09:26:14', '2022-05-31 11:07:04', NULL);
INSERT INTO `restorans` VALUES (1297, 1, 'DALIMIN JUWONO', 'P.2.02.0004019.16.01', 'KFC PONDOK GEDE PARKIR / PT.FAST FOOD INDONESIA', 'JL.RAYA PONDOK GEDE', 'PONDOKGEDE', 'JATIWARINGIN', '-', '-`', 15, 60, 185000, 776075000, 10.00, '-', '2022_RESTORAN_0129701032022.jpg', 0, 1, '-6.2843496948984505', '106.91303487984516', 18, '2022-01-03 09:44:37', '2022-06-29 09:35:37', NULL);
INSERT INTO `restorans` VALUES (1298, 1, 'WINDASARI', 'P.2.02.0003868.16.05', 'KITIRAN FAMILY RESTO & CAFE', 'KAWASAN SENTRA KOTA JATIBENING BLOK.C', 'PONDOKGEDE', 'JATIBENING BARU', '-', '-', 10, 60, 180000, 265050000, 10.00, '081290767314', '2022_RESTORAN_0129801032022.jfif', 0, 1, '-6.266917609208713', '106.94214910268785', 18, '2022-01-03 11:22:56', '2022-05-31 11:10:31', NULL);
INSERT INTO `restorans` VALUES (1299, 3, 'HARMON NOFER', 'P.2.02.0004276.11.01', 'RM PUTRA MINANG', 'JL. KH AGUS SALIM', 'BEKASI TIMUR', 'BEKASIJAYA', '001', '007', 7, 35, 25000, 22812500, 10.00, '08129368418', '2022_RESTORAN_0129901032022.jpg', 0, 1, '-6.236252967223976', '107.0067286491394', 10, '2022-01-03 11:35:08', '2022-04-14 08:24:11', NULL);
INSERT INTO `restorans` VALUES (1300, 3, 'BUDI ULTADRA', 'P.2.02.0005043.11.02', 'PONDOK SATE DANGUNG DANGUNG MACK UTIAH', 'JL. RA KARTINI NO. 07', 'BEKASI TIMUR', 'MARGAHAYU', '003', '003', 1, 8, 20000, 11950000, 10.00, '08128395724', '2022_RESTORAN_0130001032022.jpg', 0, 1, '-6.245083800488684', '107.00366020202638', 10, '2022-01-03 11:47:23', '2022-04-14 08:24:41', NULL);
INSERT INTO `restorans` VALUES (1301, 3, 'BP. ASIK', 'P.2.02.0002468.11.02', 'SOTO MIE BOGOR', 'JL. RA KARTINI', 'BEKASI TIMUR', 'MARGAHAYU', '001', '005', 3, 15, 20000, 14600000, 10.00, '089513913410', '2022_RESTORAN_0130101032022.jpg', 0, 1, '-6.24610765558366', '107.00323104858398', 10, '2022-01-03 12:10:34', '2022-04-14 08:25:18', NULL);
INSERT INTO `restorans` VALUES (1302, 3, 'SUGENG', 'P.2.02.0001902.11.04', 'RM SANJAYA', 'JL. NUSANTARA RAYA BLOK A2 NO. 24 PERUMNAS 3', 'BEKASI TIMUR', 'ARENJAYA', '004', '011', 8, 28, 25000, 18250000, 10.00, NULL, '2022_RESTORAN_0130201032022.jpeg', 0, 1, '-6.243505353294791', '107.02831506729127', 10, '2022-01-03 12:43:37', '2022-04-14 08:25:51', NULL);
INSERT INTO `restorans` VALUES (1303, 3, 'SHERLY SILVIA', 'P.2.02.0003458.11.04', 'ROPISBAK PLUS PLUS', 'JL. NUSANTARA RAYA PERUMNAS 3', 'BEKASI TIMUR', 'ARENJAYA', '003', '014', 4, 30, 25000, 19500000, 10.00, '087788288549', '2022_RESTORAN_0130301032022.jpg', 0, 1, '-6.243654666070923', '107.02934503555299', 10, '2022-01-03 12:49:28', '2022-04-14 08:26:19', NULL);
INSERT INTO `restorans` VALUES (1304, 1, 'BUDI SETIAWAN', 'P.2.02.0003875.16.01', 'PHD JATIWARINGIN / PT.SARI MELATI KENCANA', 'JL.RAYA JATIWARINGIN RT.006/003', 'PONDOKGEDE', 'JATIWARINGIN', '-', '-', 10, 6, 250000, 481250000, 10.00, '021500600', '2022_RESTORAN_0130401042022.jfif', 0, 1, '-6.275534633509132', '106.91266089677812', 18, '2022-01-04 14:39:18', '2022-05-31 11:12:46', NULL);
INSERT INTO `restorans` VALUES (1305, 1, 'BUDI SETIAWAN', 'P.2.02.0001566.16.03', 'PIZZA HUT DELIVERY /PT.SARIMELATI KENCANA', 'JL RAYA JATI MAKMUR BLOK A NO 5', 'PONDOKGEDE', 'JATIMAKMUR', '-', '-', 10, 4, 250000, 465000000, 10.00, '021500600', '2022_RESTORAN_0130501042022.jpg', 0, 1, '-6.285409909362635', '106.93560451269153', 18, '2022-01-04 14:45:21', '2022-05-31 11:13:29', NULL);
INSERT INTO `restorans` VALUES (1306, 1, 'PHD CAMAN JATIBENING/PT.SARI MELATI KENCANA', 'P.2.02.0001838.16.02', 'PHD CAMAN JATIBENING/PT.SARI MELATI KENCANA', 'JL.RAYA CAMAN RUKO EAST POINTNO.12', 'PONDOKGEDE', 'JATIBENING', '-', '-', 10, 4, 260000, 406250000, 10.00, '021500600', '2022_RESTORAN_0130601042022.jfif', 0, 1, '-6.252114765047347', '106.95309251546861', 18, '2022-01-04 14:57:27', '2022-05-31 11:14:00', NULL);
INSERT INTO `restorans` VALUES (1307, 2, 'SUMARNO NGADIMAN', 'P.2.02.0004939.13.05', 'DAPUR SOLO', 'SUMMARECON MALL BEKASI, JL. BULEVAR AHMAD YANI NO.1', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 8, 20, 60000, 244074000, 10.00, '(021) 29572327', '2022_RESTORAN_0130701052022.jpg', 1, 1, '-6.226995363975319', '107.00057029724123', 14, '2022-01-05 12:13:58', '2022-02-03 12:22:07', NULL);
INSERT INTO `restorans` VALUES (1308, 1, 'Yuli Endarwati', 'P.2.02.0001930.19.02', 'RM. Prambanan', 'JL. PENEGAK RAYA NO. 27', 'RAWALUMBU', 'PENGASINAN', '001', '005', 3, 20, 25000, 8850000, 10.00, '0818926560', '2022_RESTORAN_0130801062022.jpg', 0, 1, '-6.273772314321251', '107.00160294771196', 19, '2022-01-06 08:45:53', '2022-04-14 08:04:42', NULL);
INSERT INTO `restorans` VALUES (1309, 2, 'GABY OLIVIA', 'P.2.02.0005706.12.02', 'PEMPEK GABY', 'JL. JEND. SUDIRMAN NO.9 RT. 002 RW.003', 'BEKASI BARAT', 'KRANJI', '002', '003', 5, 40, 30000, 132000000, 10.00, NULL, '2022_RESTORAN_0130902092022.jpg', 0, 1, '-6.231688178661465', '106.97078704833984', 11, '2022-01-06 09:12:10', '2022-04-12 13:24:29', NULL);
INSERT INTO `restorans` VALUES (1310, 2, 'Hendi', 'P.2.02.0004069.19.01', 'Mpek Mpek Yenny', 'JL. TRISATYA', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '007', 3, 16, 22000, 6556000, 10.00, '08121000517', '2022_RESTORAN_0131001062022.jpg', 0, 1, '-6.285676517884164', '106.99262827634813', 19, '2022-01-06 14:43:36', '2022-04-14 08:06:17', NULL);
INSERT INTO `restorans` VALUES (1311, 2, 'Mariana', 'P. 2.02.0000253.19.02', 'RM. Singgalang Sila', 'JL. ANYELIR RAYA BLOK M2 NO 11', 'RAWALUMBU', 'PENGASINAN', '01', '14', 4, 22, 20000, 6300000, 10.00, '021-82420152', '2022_RESTORAN_0131101062022.jpeg', 0, 1, '-6.266251063648932', '107.00773984193803', 19, '2022-01-06 15:07:35', '2022-04-14 08:11:37', NULL);
INSERT INTO `restorans` VALUES (1312, 2, 'Edah', 'P. 2.02.0002286.19.01', 'RM. Ayam Bakar Sari Roso', 'JL. DASA DHARMA NO. 39', 'RAWALUMBU', 'BOJONG RAWALUMBU', '003', '007', NULL, NULL, 24000, 18072000, 10.00, '021-82433353', '2022_RESTORAN_0131201062022.jpeg', 0, 1, '-6.274812110024392', '107.00061857700348', 19, '2022-01-06 15:19:47', '2022-04-14 08:17:54', NULL);
INSERT INTO `restorans` VALUES (1313, 2, 'ADNA FARIS SADEWA', 'P.2.02.0005691.12.01', 'NYAPI', 'JL. BINTARA RAYA RT. 013 RW. 010', 'BEKASI BARAT', 'BINTARA', '013', '010', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-07 08:14:28', '2022-04-07 14:04:30', '2022-04-07 14:04:30');
INSERT INTO `restorans` VALUES (1314, 3, 'SYAHRIAL EFFENDI', 'P.2.02.0002627.11.02', 'RM AYAM KALASAN', 'JL. RA KARTINI', 'BEKASI TIMUR', 'MARGAHAYU', '001', '005', 3, 10, 23000, 22885000, 10.00, '0895332403345', '2022_RESTORAN_0131401072022.jpg', 0, 1, '-6.247515453069532', '107.00164318084718', 10, '2022-01-07 09:45:57', '2022-04-14 08:26:47', NULL);
INSERT INTO `restorans` VALUES (1315, 2, 'PT.SARI COFFE INDONESIA', 'P.2.02.0004178.22.01', 'STARBUCK COFFE', 'JL. RAYA HANKAM NO. 34', 'PONDOKMELATI', 'JATIMELATI', '005', '001', 13, 84, 100000, 752500000, 10.00, NULL, '2022_RESTORAN_0131501072022.jpg', 1, 1, '-6.311817955170796', '106.9244419034014', 20, '2022-01-07 10:12:50', '2022-04-08 14:31:16', NULL);
INSERT INTO `restorans` VALUES (1316, 2, 'SLAMET', 'P.2.02.0002907.11.02', 'BAKSO TITOTI', 'JL. IR. H. JUANDA NO. 119', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 15, 50, 25000, 102250000, 10.00, '08136619092', '2022_RESTORAN_0131601072022.png', 0, 1, '-6.248773935495239', '107.01288700103761', 10, '2022-01-07 10:39:30', '2022-04-14 08:29:30', NULL);
INSERT INTO `restorans` VALUES (1317, 3, 'Trisnadi', 'P. 2.02.0002794.19.03', 'Bakmi Kalimalang', 'JL PRAMUKA RUKO D MINIMALIST', 'RAWALUMBU', 'SEPANJANGJAYA', '04', '03', 6, 32, 25000, 7275000, 10.00, '087786685000', '2022_RESTORAN_0131701072022.jpg', 0, 1, '-6.269245179624252', '106.9952675700188', 19, '2022-01-07 10:58:09', '2022-04-14 08:20:16', NULL);
INSERT INTO `restorans` VALUES (1318, 2, 'JANUAR CHANDRA', 'P.2.02.0004830.11.02', 'CINEPOLIS RESTO BLU PLAZA', 'JL. CHAIRIL ANWAR MALL BLU PLAZA', 'BEKASI TIMUR', 'MARGAHAYU', '006', '009', 2, 0, 25000, 103750000, 10.00, '081394937646', '2022_RESTORAN_0131801072022.jpg', 0, 1, '-6.257764531180245', '107.01006531715394', 10, '2022-01-07 12:31:21', '2022-06-15 10:19:23', NULL);
INSERT INTO `restorans` VALUES (1319, 1, 'JOHANNES PAULUS ARIFIN', 'P.2.02.0005239.22.04', 'HOKA HOKA BENTO KITCHEN KRANGGAN', 'JL. RAYA HANKAM NO.4C', 'PONDOKMELATI', 'JATIMURNI', '004', '006', 10, 50, 120000, 743400000, 10.00, NULL, NULL, 0, 1, '-6.333155229177751', '106.92365058818909', 20, '2022-01-07 14:37:52', '2022-04-08 14:38:02', NULL);
INSERT INTO `restorans` VALUES (1320, 2, 'R. YUNAN HELMY', 'P.2.02.0004147.22.03', 'HABITAT KENZA / CV.HABITAT KENZA', 'JL.RAYA HANKAM NO.296', 'PONDOKMELATI', 'JATIWARNA', NULL, NULL, 9, 25, 100000, 155000000, 10.00, NULL, NULL, 1, 1, '-6.3157215', '106.9304075', 20, '2022-01-07 14:43:40', '2022-04-08 14:51:11', NULL);
INSERT INTO `restorans` VALUES (1321, 2, 'EDWARD TIRTANATA', 'P.2.02.0005054.22.02', 'KOPI KENANGAN / PT. BUMI BERKAH BOGA', 'JL. RAYA HANKAM', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 4, 0, 50000, 262200000, 10.00, NULL, NULL, 0, 1, '-6.3157386', '106.9304142', 20, '2022-01-07 14:49:09', '2022-04-11 09:54:04', NULL);
INSERT INTO `restorans` VALUES (1322, 2, 'PT.SARI MELATI KENCANA TBK', 'P.2.02.0004329.22.02', 'PIZZA HUT HANKAM', 'JL.RAYA HANKAM SAMPING NAGA SWALAYAN', 'PONDOKMELATI', 'JATIRAHAYU', '003', '008', 12, 20, 200000, 954000000, 10.00, NULL, NULL, 0, 1, '-6.2128128', '106.9940736', 20, '2022-01-07 14:55:28', '2022-04-11 09:58:38', NULL);
INSERT INTO `restorans` VALUES (1323, 1, 'PT.REKSO NASIONAL FOOD', 'P.2.02.0002053.22.01', 'MC D JATIWARNA', 'JL.RAYA HANKAM NO.61', 'PONDOKMELATI', 'JATIMELATI', '001', '005', 13, 50, 100000, 1080500000, 10.00, NULL, '2022_RESTORAN_0132301072022.png', 1, 1, '-6.311336947702352', '106.92444115877153', 20, '2022-01-07 15:32:52', '2022-04-11 10:03:24', NULL);
INSERT INTO `restorans` VALUES (1324, 1, 'PT.SARI MELATI KENCANA', 'P.2.02.0002804.22.01', 'PHD KRANGGAN', 'JL. RAYA HANKAM', 'PONDOKMELATI', 'JATIMELATI', '004', '005', 8, 0, 150000, 619500000, 10.00, NULL, NULL, 0, 1, '-6.2128128', '106.9940736', 20, '2022-01-08 08:29:35', '2022-04-11 10:08:02', NULL);
INSERT INTO `restorans` VALUES (1325, 2, 'RICHEESE FACTORY', 'P.2.02.0003320.22.04', 'RICHEESE FACTORY JATIMRUNI', 'JL.RAYA HANKAM', 'PONDOKMELATI', 'JATIMURNI', '004', '005', 12, 50, 100000, 625200000, 10.00, NULL, NULL, 0, 1, '-6.2128128', '106.9940736', 20, '2022-01-08 08:38:38', '2022-04-11 10:12:33', NULL);
INSERT INTO `restorans` VALUES (1326, 2, 'SOLARIA NAGA SWALAYAN HANKAM', 'P.2.02.0004209.22.02', 'SOLARIA NAGA SWALAYAN HANKAM', 'JL.RAYA HANKAM NAGA SWALAYAN HANKAM RT.003/008', 'PONDOKMELATI', 'JATIRAHAYU', '003', '008', 14, 25, 120000, 791400000, 10.00, NULL, NULL, 0, 1, '-6.2128128', '106.9940736', 20, '2022-01-08 09:52:24', '2022-04-11 10:15:02', NULL);
INSERT INTO `restorans` VALUES (1327, 2, 'PT.FOODS BEVERAGES INDONESIA', 'P.2.02.0004238.22.02', 'CHATIME', 'JL.RAYA HANKAM NAGA SWALAYAN HANKAM', 'PONDOKMELATI', 'JATIRAHAYU', '003', '008', 8, 5, 75000, 385500000, 10.00, NULL, NULL, 1, 1, '-6.2128128', '106.9940736', 20, '2022-01-08 10:01:02', '2022-04-11 10:25:44', NULL);
INSERT INTO `restorans` VALUES (1328, 2, 'PT.FATSFOOD INDONESIA', 'P.2.02.0004140.22.02', 'KFC NAGA HANKAM', 'JL.RAYA HANKAM', 'PONDOKMELATI', 'JATIRAHAYU', '003', '008', 12, 50, 110000, 584650000, 10.00, NULL, NULL, 0, 1, '-6.3157329', '106.9304101', 20, '2022-01-10 10:06:44', '2022-04-11 10:29:53', NULL);
INSERT INTO `restorans` VALUES (1329, 3, 'HON DJI LIONG', 'P.2.02.0002836.11.03', 'RM ALIONG MY KITCHEN', 'JL. PROF. M. YAMIN NO. 20', 'BEKASI TIMUR', 'DURENJAYA', '007', '005', 2, 24, 17000, 14110000, 10.00, '089695722629', '2022_RESTORAN_0132901102022.jpg', 0, 1, '-6.23764', '107.0165', 10, '2022-01-10 10:52:11', '2022-04-14 08:28:33', NULL);
INSERT INTO `restorans` VALUES (1330, 3, 'H. SARJAN', 'P.2.02.0001966.11.01', 'BAKSO SUPER 88', 'JL. KH AGUS SALIM NO. 50', 'BEKASI TIMUR', 'BEKASIJAYA', '004', '006', 4, 42, 19000, 42370000, 10.00, '0218826647', '2022_RESTORAN_0133001102022.png', 0, 1, '-6.238407362976775', '107.00541973114015', 10, '2022-01-10 11:56:06', '2022-04-14 08:30:11', NULL);
INSERT INTO `restorans` VALUES (1331, 2, 'PT.INDOMARCO PRISMATAMA', 'P.2.02.0004466.22.02', 'POINT CAFE', 'JL.RAYA HANKAM', 'PONDOKMELATI', 'JATIRAHAYU', '002', '018', 2, 4, 30000, 73290000, 10.00, NULL, '2022_RESTORAN_0133101102022.png', 0, 1, '-6.22592', '106.7876352', 20, '2022-01-10 14:42:15', '2022-04-11 10:32:11', NULL);
INSERT INTO `restorans` VALUES (1332, 2, 'PT. INDOMARCO PRISMATAMA', 'P.2.02.0005002.22.02', 'POINT CAFE', 'JL. PURI GADING RAYA BLOK PG1 NO.30-31', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 2, 4, 30000, 96435000, 10.00, '(021) 1500280', '2022_RESTORAN_0133201102022.png', 0, 1, NULL, NULL, 20, '2022-01-10 14:50:51', '2022-04-11 10:34:42', NULL);
INSERT INTO `restorans` VALUES (1333, 11, 'ASDGHJK', 'T', 'SDFGHJK', 'QERTYUI', 'SDFGHJ', 'ZXCVBNM', '99', '88', 99, 999, 200000, 0, 0.00, '987654', NULL, 0, 4, NULL, NULL, 9, '2022-01-10 14:54:38', '2022-01-10 14:55:15', '2022-01-10 14:55:15');
INSERT INTO `restorans` VALUES (1334, 11, 'UIYU', 'UTU', 'SDFGHJK', 'QERTYUI', 'SDFGHJ', 'ZXCVBNM', '99', '88', 99, 999, 200000, 0, 0.00, '5', NULL, 0, 4, NULL, NULL, 9, '2022-01-10 14:54:38', '2022-01-10 14:55:26', '2022-01-10 14:55:26');
INSERT INTO `restorans` VALUES (1335, 11, 'UTTT', 'PTYTY577457', 'SDFGHJK', 'QERTYUI', 'SDFGHJ', 'ZXCVBNM', '99', '88', 99, 999, 200000, 0, 0.00, '767', NULL, 0, 4, NULL, NULL, 9, '2022-01-10 14:54:38', '2022-01-10 14:55:35', '2022-01-10 14:55:35');
INSERT INTO `restorans` VALUES (1336, 2, 'PT. BUMI BERKAH BOGA', 'P.2.02.0005270.22.03', 'KOPI KENANGAN', 'JL. RAYA HANKAM (SPBU PERTAMINA JATIWARNA)', 'PONDOKMELATI', 'JATIMELATI', '006', '008', 7, 8, 50000, 254100000, 10.00, '0817-0739-134', NULL, 0, 1, '-6.3157356', '106.9304143', 20, '2022-01-10 14:59:27', '2022-04-11 10:42:36', NULL);
INSERT INTO `restorans` VALUES (1337, 2, 'riki', 'P.2.02.0000126.14.02', 'steak 21', 'DHDU', 'BEKASI SELATAN', 'MARGAJAYA', '0009', '000', 8, 22, 50000, 12650000, 10.00, '0870870', NULL, 0, 4, NULL, NULL, 9, '2022-01-10 14:59:34', '2022-01-10 15:12:56', '2022-01-10 15:12:56');
INSERT INTO `restorans` VALUES (1338, 2, 'RM. GUBUG GURAME CABANG BEKASI', 'P.2.02.0004993.22.01', 'RM. GUBUG GURAME CABANG BEKASI', 'JL. RAYA HANKAM', 'PONDOKMELATI', 'JATIMELATI', '005', '007', 9, 80, 150000, 122475000, 10.00, '0811-1747-700', '2022_RESTORAN_0133801102022.png', 0, 1, '-6.3157286', '106.9304113', 20, '2022-01-10 15:12:17', '2022-04-11 10:57:34', NULL);
INSERT INTO `restorans` VALUES (1339, 2, 'DANIEL KAMADJAJA', 'P.2.02.0004899.22.01', 'KOPI JANJI JIWA HANKAM RAYA', 'JL.RAYA HANKAM NO.36', 'PONDOKMELATI', 'JATIMELATI', '002', '005', 7, 0, 18000, 26532000, 10.00, '0882-2196-7109', '2022_RESTORAN_0133901102022.jpeg', 0, 1, '-6.3157384', '106.9304133', 20, '2022-01-10 15:25:35', '2022-04-11 11:09:53', NULL);
INSERT INTO `restorans` VALUES (1340, 2, 'HESTI NOVISARI', 'P.2.02.0003575.22.01', 'SOTO SEDAAP BOYOLALI HJ.WIDODO', 'RUKO PT.DUTA PUTRA PURI GADING BLOK.1/5', 'PONDOKMELATI', 'JATIMELATI', '003', '004', 6, 20, 30000, 87585000, 10.00, NULL, NULL, 0, 1, '-6.2291968', '106.9580288', 20, '2022-01-10 15:39:04', '2022-04-11 11:15:29', NULL);
INSERT INTO `restorans` VALUES (1341, 2, 'LENDY SUSANTO', 'P.2.02.0005476.22.04', 'DAPUR COKELAT PICK UP POINT HANKAM', 'JL. RAYA HANKAM', 'PONDOKMELATI', 'JATIMURNI', '007', '004', 2, 0, 150000, 27735000, 10.00, '0812-1092-6837', NULL, 0, 1, NULL, NULL, 20, '2022-01-10 15:47:19', '2022-04-11 11:31:28', '2022-04-11 11:31:28');
INSERT INTO `restorans` VALUES (1342, 1, 'wibowo', 'P.2.02.0000923.21.01', 'WARUNG SATE BABE', 'JLN. RAYA MUSTIKAJAYA', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:07:32', '2022-01-11 08:19:46', '2022-01-11 08:19:46');
INSERT INTO `restorans` VALUES (1343, 2, 'PT SARI MELATI KENCANA', 'P.2.02.0001877.21.01', 'PIZZA HUT DELIVERY VILLA ASRI', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 4, 10, 165000, 348645000, 10.00, NULL, NULL, 0, 1, '-6.2443628', '107.0057626', 17, '2022-01-11 08:10:16', '2022-05-31 11:09:00', NULL);
INSERT INTO `restorans` VALUES (1344, 3, 'FATIMAH JENONG', 'P.2.02.0002184.21.01', 'RM . ABIR', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 4, 6, 25000, 12162500, 10.00, NULL, NULL, 0, 1, '-6.244388', '107.0057839', 17, '2022-01-11 08:11:26', '2022-05-31 11:13:12', NULL);
INSERT INTO `restorans` VALUES (1345, 3, 'TUNAH', 'P.2.02.0002278.21.01', 'RM. UMAR ( WARUNG HIJAU )', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 4, 25000, 16725000, 10.00, NULL, NULL, 0, 1, '-6.2443569', '107.0057578', 17, '2022-01-11 08:12:32', '2022-05-31 11:24:46', NULL);
INSERT INTO `restorans` VALUES (1346, 1, 'TUTUT HANDAYANI', 'P.2.02.0002414.21.03', 'RM JOGLO', 'PERUMAHHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:13:28', '2022-01-11 09:10:01', NULL);
INSERT INTO `restorans` VALUES (1347, 1, 'H, AHMAD', 'P.2.02.0002417.21.01', 'RUMAH MAKAN SARIBUNGO MUTIARA GADING', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 5, 10, 20000, 20940000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:17:47', '2022-06-20 11:29:23', NULL);
INSERT INTO `restorans` VALUES (1348, 3, 'EKA NURANIAH', 'P.2.02.0002419.21.01', 'RM . GADING RAYA', 'PERUMAHAN MUTIARA GADING', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 2, 10000, 385000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:18:53', '2022-05-24 11:32:28', NULL);
INSERT INTO `restorans` VALUES (1349, 3, 'SUKOWATI SOSRODOJO', 'P.2.02.0002480.21.03', 'MCD MUSTIKAJAYA', 'JALAN RAYA BANTARGEBANG - SETU', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 10, 50, 165000, 1702305000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:26:46', '2022-05-31 11:45:03', NULL);
INSERT INTO `restorans` VALUES (1350, 3, 'ARYATI', 'P.2.02.0002714.21.01', 'RM . LEK NUR', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 4, 20000, 4780000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:27:53', '2022-06-30 08:39:11', NULL);
INSERT INTO `restorans` VALUES (1351, 3, 'IR. SUPRAPTO', 'P.2.02.0002810.21.01', 'RM AYAM TULANG LUNAK', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 4, 15000, 600000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:29:06', '2022-05-24 11:56:13', NULL);
INSERT INTO `restorans` VALUES (1352, 1, 'SADERAI', 'P.2.02.0002612.21.03', 'RUMAH MAKAN BEBEK PAK DHE', 'JALAN RAYA SETU BANTAR GEBANG PADURENAN', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:30:11', '2022-05-24 08:27:52', NULL);
INSERT INTO `restorans` VALUES (1353, 1, 'RATNASARI', 'P.2.02.0002856.21.01', 'BUBUR AYAM KAMPUNG NYEMPLUNG', 'RUKO MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:31:15', '2022-05-24 12:09:15', NULL);
INSERT INTO `restorans` VALUES (1354, 1, 'SARTINI', 'P.2.02.0002863.21.01', 'BAKSO SAHABAT', 'PERUM VILA ASRI', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:32:18', '2022-01-11 08:32:18', NULL);
INSERT INTO `restorans` VALUES (1355, 1, 'ANITA WIDYARINI', 'P.2.02.0002864.21.01', 'DONAT MADU CIHANJUANG', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:35:08', '2022-01-11 08:35:08', NULL);
INSERT INTO `restorans` VALUES (1356, 1, 'DRA.TRI RACHAYU', 'P.2.02.0002995.21.01', 'KANTIN MAHARANI', 'BKKBN NO 23', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:38:43', '2022-01-11 08:38:43', NULL);
INSERT INTO `restorans` VALUES (1357, 3, 'PARNAH', 'P.2.02.0003112.21.02', 'RUMAH MAKAN WARUNG BAMBU', 'JL.KEMUNING 1 RT,02/04', 'MUSTIKAJAYA', 'MUSTIKASARI', NULL, NULL, 5, 10, 25000, 9887500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:42:10', '2022-06-22 10:09:28', NULL);
INSERT INTO `restorans` VALUES (1358, 1, 'JAP JANTI KUSUMA JAYA', 'P.2.02.0003202.21.01', 'DOOM PIZZA/PT DOOM PIZA', 'MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 6, 15, 150000, 470250000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:44:20', '2022-06-27 10:18:39', NULL);
INSERT INTO `restorans` VALUES (1359, 1, 'JOKO SUSILO', 'P,2.02.00003205.21.01', 'IGA BAKAR SOLO PENYET', 'JL.RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:46:11', '2022-01-11 08:46:11', NULL);
INSERT INTO `restorans` VALUES (1360, 1, 'MUHAMAD YUSRON', 'P.2.02.0003339.21.03', 'KFC DUKUH ZAMRUD', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 15, 50, 150000, 1102500000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:47:38', '2022-06-27 10:19:53', NULL);
INSERT INTO `restorans` VALUES (1361, 1, 'FATHURI', 'P.2.02.0003390.21.04', 'NIKITA FRIED CHICKEN BEKASI TIMUR REGENCY', 'PERUMAHAN BEKASI TIMUR REGENCY', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 6, 20, 50000, 218500000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:48:47', '2022-06-27 10:20:26', NULL);
INSERT INTO `restorans` VALUES (1362, 2, 'IR MEYNFRASTA', 'P.2.02.0003395.21.01', 'BEBEK GORENG SLAMET', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 6, 20, 33000, 59109600, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:50:10', '2022-05-31 11:33:51', NULL);
INSERT INTO `restorans` VALUES (1363, 1, 'SITI RUSMINI', 'P.2.02.0003396.21.04', 'RM MAK IYUK', 'JALAN RAYA CIMUNING', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:51:09', '2022-01-11 08:51:09', NULL);
INSERT INTO `restorans` VALUES (1364, 1, 'CIKIYONG', 'P.2.02.0003606.21.01', 'MIE AYAM HIJAU', 'PERUM MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:52:09', '2022-01-11 08:52:09', NULL);
INSERT INTO `restorans` VALUES (1365, 3, 'ROZA FITRI', 'P.2.02.0003690.21.01', 'ORANGE JUICE', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 4, 5, 20000, 15612000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:53:13', '2022-05-31 11:51:32', NULL);
INSERT INTO `restorans` VALUES (1366, 2, 'GINA FIATY HARTONO', 'P.2.02.0003967.21.04', 'LOMBOK ABANG', 'JALAN RAYA  CIMUNING', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 10, 50, 100000, 90900000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:54:57', '2022-05-31 11:55:59', NULL);
INSERT INTO `restorans` VALUES (1367, 1, 'HARYONO', 'P.2.02.0003993.21.01', 'QUICK CHICKEN', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 08:56:03', '2022-01-11 08:56:03', NULL);
INSERT INTO `restorans` VALUES (1368, 1, 'FATHURI', 'P.2.02.0004062.21.01', 'NIKITA FRIED CHICKEN GRAND WISATA', 'RUKO LAMONTE GRAND WISATA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 6, 20, 50000, 121250000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:57:45', '2022-06-27 10:53:50', NULL);
INSERT INTO `restorans` VALUES (1369, 1, 'ANISES MASUDAH', 'P.2.02.0004158.21.03', 'NIKITA FRIED CHICKEN ZAMRUD', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 3, 12, 15000, 12030000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 08:59:16', '2022-06-27 10:51:53', NULL);
INSERT INTO `restorans` VALUES (1370, 1, 'BUDI SETIAWAN', 'P.2.02.0004266.21.03', 'PHD PADURENAN', 'JALAN RAYA POADURENAN', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 5, 6, 165000, 614295000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 09:03:09', '2022-06-27 10:24:26', NULL);
INSERT INTO `restorans` VALUES (1371, 1, 'ISA JUARSA', 'P.2.02.0004303.21.01', 'BAKSO RUSUK JOSS', 'MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 6, 20, 20000, 20920000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 09:04:00', '2022-06-27 10:25:37', NULL);
INSERT INTO `restorans` VALUES (1372, 1, 'GO CHICKEN', 'P.2.02.0004366.21.02', 'GO CHICKEN', 'JALLAN RAYA CIPETE RAYA', 'MUSTIKAJAYA', 'MUSTIKASARI', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:05:13', '2022-01-11 09:05:13', NULL);
INSERT INTO `restorans` VALUES (1373, 1, 'SATWIKA', 'P.2.02.0004367.21.01', 'GO CHICKEN', 'JALAN ASEM MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:06:01', '2022-01-11 09:06:01', NULL);
INSERT INTO `restorans` VALUES (1374, 1, 'ABDUK ROFIQ', 'P.2.02.0004371.21.04', 'BAKSO ACI AKANG', 'DUKUH ZAMRUD UTARA', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:06:47', '2022-01-11 09:06:47', NULL);
INSERT INTO `restorans` VALUES (1375, 1, 'SUSANTI', 'P.2.02.0004376.21.03', 'RUMAH MAKAN MAHAYUN', 'KAMPUNG PADURENAN', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, '-6.2443848', '107.005787', 17, '2022-01-11 09:07:34', '2022-01-12 10:41:56', NULL);
INSERT INTO `restorans` VALUES (1376, 2, 'TONY NUGROHO', 'P.2.02.0004556.21.03', 'PEMPEK GABY EXPRESS', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:08:42', '2022-01-11 09:13:02', NULL);
INSERT INTO `restorans` VALUES (1377, 2, 'ALDO DIMAS PRASETYA', 'P.2.02.0004558.21.01', 'KOPI JANJI JIWA MUTIARA GADING', 'RUKO PASADENA BLOK.R3 NOMOR 23 MUTIARA GADING TIMUR 2', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:11:29', '2022-01-11 09:17:54', NULL);
INSERT INTO `restorans` VALUES (1378, 2, 'DAHLIA', 'P.2.02.0004737.21.02', 'WARUNG BETAWI H.BAKA', 'KP.BABAKAN BONDOL', 'MUSTIKAJAYA', 'MUSTIKASARI', '01', '06', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:16:41', '2022-01-11 09:16:41', NULL);
INSERT INTO `restorans` VALUES (1379, 2, 'AGUS YAHYA SUKMANA', 'P.2.02.0004755.21.01', 'SATE TAICHAN BENGAWAN', 'JL.WESTERN BOULEVARD RUKO LAMONTE GRAND WISATA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 5, 15, 25000, 15875000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 09:22:57', '2022-06-27 10:26:14', NULL);
INSERT INTO `restorans` VALUES (1380, 2, 'KOPI JANI JIWA JILID 463', 'P.2.02.0004781.21.03', 'KOPI JANI JIWA JILID 463', 'DUKUH ZAMRUD BLOK.B 1 NOMOR 7', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 3, 8, 25000, 19212500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 09:27:34', '2022-06-27 10:26:50', NULL);
INSERT INTO `restorans` VALUES (1381, 2, 'TOPAN DERI NATALION,SE', 'P.2.02.0004831.21.01', 'BAKSO KEMON', 'MUTIARA GADING TIMUR 2', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:31:06', '2022-01-11 09:31:06', NULL);
INSERT INTO `restorans` VALUES (1382, 2, 'SITI PURWANINGSIH', 'P.2.02.0004949.21.03', 'CHINESE FOOD PAK SLAMET', 'RUKO DUKUH ZAMRUD BLOK.S1 NOMOR 56', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:37:51', '2022-01-11 09:37:51', NULL);
INSERT INTO `restorans` VALUES (1383, 2, 'SULTAN AKMAL FALAH', 'P.2.02.0005079.21.01', 'ROPANG OTW MUSTIKAJAYA', 'JL.RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', '01', '021', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:40:03', '2022-01-11 09:40:03', NULL);
INSERT INTO `restorans` VALUES (1384, 2, 'JOHANES PAULUS ARIFIN', 'P.2.02.0005177.21.04', 'HOKA HOKA BENTO KITCHEN', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 4, 8, 110000, 597300000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 09:42:25', '2022-06-27 10:42:48', NULL);
INSERT INTO `restorans` VALUES (1385, 2, 'CHAFID RACHMATSYAH', 'P.2.02.0005240.21.01', 'MAWAR RESTO', 'JL.BKKBN KAMPUNG CIKETING MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 8, 20, 125000, 168750000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 09:51:02', '2022-06-30 14:07:08', NULL);
INSERT INTO `restorans` VALUES (1386, 2, 'KOPI KENANGAN', 'P.2.02.0005271.21.03', 'KOPI KENANGAN', 'RUKO DUKUH ZAMRUD NOMOR 19', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 4, 6, 50000, 218500000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 09:54:59', '2022-06-30 13:59:52', NULL);
INSERT INTO `restorans` VALUES (1387, 2, 'NENENG CHAMIDAH', 'P.2.02.0005259.21.01', 'STREET BOBA', 'WESTERN BOULEVARD RUKO LAMONTE GRAND WISATA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 3, 6, 40000, 97960000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 10:02:56', '2022-06-27 11:30:35', NULL);
INSERT INTO `restorans` VALUES (1388, 2, 'ALTA HOEI', 'P.2.02.0005329.21.03', 'RED PINE', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 5, 6, 20000, 21610000, 10.00, NULL, NULL, 0, 4, '-6.2443849', '107.0057838', 17, '2022-01-11 10:23:10', '2022-06-27 11:32:32', NULL);
INSERT INTO `restorans` VALUES (1389, 2, 'ANDANU PRASETYO', 'P.2.02.0005360.21.03', 'TOKO KOPI TUKU', 'PERUMAHAN VIDA JL.ALUN ALUN UTARA I', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 6, 20, 40000, 66080000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-11 10:25:44', '2022-06-27 11:09:51', NULL);
INSERT INTO `restorans` VALUES (1390, 2, 'UNGGAR RETNOSARI', 'P.2.02.0005361.21.02', 'SAUNG KARAMA', 'JL.RAYA MUSTIKASARI NOMOFR 10', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 10:27:59', '2022-01-11 10:27:59', NULL);
INSERT INTO `restorans` VALUES (1391, 3, 'HON JIM JIM', 'P.2.02.0003021.11.02', 'RM MY KITCHEN ALIONG', 'JL. KARTINI RAYA NO. 48 B', 'BEKASI TIMUR', 'MARGAHAYU', '002', '003', 3, 18, 17000, 9307500, 10.00, '0218811401', '2022_RESTORAN_0139101112022.jpg', 0, 1, '-6.24622', '107.003', 10, '2022-01-11 10:30:10', '2022-04-14 08:31:07', NULL);
INSERT INTO `restorans` VALUES (1392, 2, 'AGUNG ARFIYANTO', 'P.2.02.0005362.21.04', 'FOODPEDIA ZAMRUD', 'DGREEN TERRACE BLOK D1 19-20 PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 10:30:57', '2022-01-11 10:30:57', NULL);
INSERT INTO `restorans` VALUES (1393, 2, 'MAULANA HAKIM', 'P.2.02.0005365.21.01', 'TEGUK MUSTIKAJAYA', 'JL. MUSTIKAJAYA NOMOR.95', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 0, 10000, 1300000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 10:52:44', '2022-06-30 07:49:47', NULL);
INSERT INTO `restorans` VALUES (1394, 2, 'TITIN KARTINI', 'P.2.02.0005373.21.03', 'REKAVIDA CIRCUIT COFFEE', 'PERUMAHAN VIDA JL.ALUN ALUN SELATAN', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 2, 3, 15000, 2550000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 10:55:39', '2022-06-30 07:48:58', NULL);
INSERT INTO `restorans` VALUES (1395, 2, 'MISWOYO', 'P.2.02.0005390.21.01', 'RM.BUKIT GAGOAN', 'PERUMAHAN GRAND WISATA JL.WESTERN BOULEVARD LAMONTE', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 5, 20000, 4030000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 10:58:34', '2022-06-30 07:47:44', NULL);
INSERT INTO `restorans` VALUES (1396, 2, 'LINTANG DWI CAHYO', 'P.2.02.0005392.21.01', 'RAJA SEI', 'PERUMAHAN GRAND WISATA RUKO LAMONTE NOMOR 25', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 4, 45000, 8257500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 11:01:50', '2022-06-30 08:25:09', NULL);
INSERT INTO `restorans` VALUES (1397, 2, 'MELATI UBAYA', 'P.2.02.0005396.21.01', 'BOBAL GRAND WISATA', 'GRAND WISATA WESTERN BOULEVARD', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 1, 15000, 1312500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 11:04:27', '2022-06-30 07:45:17', NULL);
INSERT INTO `restorans` VALUES (1398, 2, 'BAGUS WIRYOKO', 'P.2.02.0005397.21.04', 'KOPI SEGER', 'KAVLING KELAPA DUA MUSTIKAJAYA', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 11:06:48', '2022-01-11 11:06:48', NULL);
INSERT INTO `restorans` VALUES (1399, 2, 'DANURAGA ADIMAR MANAH', 'P.2.02.0005399.21.01', 'RUWAH KOPI', 'JL.MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 1, 10000, 455000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-11 11:10:03', '2022-06-30 07:44:29', NULL);
INSERT INTO `restorans` VALUES (1400, 12, 'CBNBCNBVBM', '12', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:23:33', '2022-01-18 09:23:33');
INSERT INTO `restorans` VALUES (1401, 12, 'CBNBCNBVBM', '31', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:23:57', '2022-01-18 09:23:57');
INSERT INTO `restorans` VALUES (1402, 12, 'CBNBCNBVBM', '22222', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:24:08', '2022-01-18 09:24:08');
INSERT INTO `restorans` VALUES (1403, 12, 'CBNBCNBVBM', '0', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:24:18', '2022-01-18 09:24:18');
INSERT INTO `restorans` VALUES (1404, 12, 'CBNBCNBVBM', '2102121', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:24:32', '2022-01-18 09:24:32');
INSERT INTO `restorans` VALUES (1405, 12, 'CBNBCNBVBM', '2121', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:24:40', '2022-01-18 09:24:40');
INSERT INTO `restorans` VALUES (1406, 12, 'CBNBCNBVBM', '1211', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:24:51', '2022-01-18 09:24:51');
INSERT INTO `restorans` VALUES (1407, 12, 'CBNBCNBVBM', '2412222', 'CBBCNBV', 'FSDHGEH', 'SDGSG', 'GDGDDG', '11', '11', 111, 12, 500000, 0, 0.00, '133', NULL, 0, 4, NULL, NULL, 18, '2022-01-11 11:24:48', '2022-01-18 09:25:00', '2022-01-18 09:25:00');
INSERT INTO `restorans` VALUES (1408, 2, 'ANTONIUS ALEXANDESA P.ST', 'P.2.02.0003359.22.04', 'LONTONG MEDAN / CV.HARMONI PRIMA ERSADA', 'JL.RAYA HANKAM NO.7', 'PONDOKMELATI', 'JATIMURNI', '004', '005', 18, 50, 50000, 45600000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-01-11 13:37:18', '2022-04-11 11:26:40', NULL);
INSERT INTO `restorans` VALUES (1409, 3, 'YAZIDUL HUSNA JAYA', 'P.2.020005404.21.03', 'MEENUM MUTIARA GADING', 'MUTIARA GADING TIMUR 2 NO.3', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 1, 10000, 820000, 10.00, NULL, NULL, 0, 4, '-6.322805749378362', '107.01541900634767', 17, '2022-01-12 08:23:42', '2022-06-30 07:43:46', NULL);
INSERT INTO `restorans` VALUES (1410, 2, 'JAJANG NURWANTO', 'P.2.02.0005482.21.04', 'POJOK AREA', 'JL.DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 1, 2, 10000, 455000, 10.00, NULL, NULL, 0, 4, '-6.309838680093361', '107.02571868896486', 17, '2022-01-12 08:27:07', '2022-06-30 07:42:59', NULL);
INSERT INTO `restorans` VALUES (1411, 2, 'INDRA KHARISMAN', 'P.2.02.0005010.12.03', 'BASO ACI KESULTANAN', 'KP. RAWA BEBEK', 'BEKASI BARAT', 'KOTABARU', '003', '008', 6, 10, 20000, 3660000, 10.00, '087832070040', '2022_RESTORAN_0141102092022.jpg', 0, 1, '-6.229640410139697', '106.9783401489258', 11, '2022-01-12 08:36:19', '2022-04-07 11:32:10', NULL);
INSERT INTO `restorans` VALUES (1412, 2, 'SAPTI YUNI ASTUTI / AMRI', 'P.2.02.0004204.12.03', 'SERUMPUN', 'JL. PERUM HARAPAN BARU I', 'BEKASI BARAT', 'KOTABARU', NULL, NULL, 7, 34, 20000, 3560000, 10.00, '081294049431', '2022_RESTORAN_0141202092022.jpg', 0, 1, '-6.230323000534752', '106.98108673095705', 11, '2022-01-12 08:39:40', '2022-04-07 13:05:10', NULL);
INSERT INTO `restorans` VALUES (1413, 2, 'INDRA WAHYUDIN', 'P.2.02.0005484.21.01', 'DR.STEAK GRILL', 'JL.GRAND WISATA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 2, 15000, 1230000, 10.00, NULL, NULL, 0, 4, '-6.313933579167068', '107.02503204345705', 17, '2022-01-12 08:42:45', '2022-06-30 07:42:09', NULL);
INSERT INTO `restorans` VALUES (1414, 2, 'ARIEF MUNANDAR', 'P.2.02.0004105.12.03', 'AYAM GEPREK JUARA', 'JL. HARAPAN BARU', 'BEKASI BARAT', 'KOTABARU', NULL, NULL, 4, 20, 17000, 17510000, 10.00, NULL, '2022_RESTORAN_0141402092022.jpg', 0, 1, '-6.229640410139697', '106.97559356689455', 11, '2022-01-12 08:43:07', '2022-04-07 13:10:32', NULL);
INSERT INTO `restorans` VALUES (1415, 3, 'RYAN MARTIAN', 'P.2.02.0005481.21.03', 'MEENUM DUKUH ZAMRUD', 'JL.ZAMRUD SELATAN NO.21', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 2, 0, 10000, 455000, 10.00, NULL, NULL, 0, 4, '-6.30847370654308', '107.0222854614258', 17, '2022-01-12 08:45:14', '2022-06-30 07:39:56', NULL);
INSERT INTO `restorans` VALUES (1416, 2, 'YOKO BENTO', 'P.2.02.0000049.12.03', 'RM.YOKO BENTO', 'PERUM.HARAPAN BARU', 'BEKASI BARAT', 'KOTABARU', NULL, NULL, 3, 8, 15000, 6810000, 10.00, '081295431336', '2022_RESTORAN_0141602092022.jpg', 0, 1, '-6.229640410139697', '106.97971343994142', 11, '2022-01-12 08:58:13', '2022-04-07 13:25:04', NULL);
INSERT INTO `restorans` VALUES (1417, 3, 'SOFFIE JULIANA HARTO', 'P.2.02.0005537.21.03', 'GEPREK BENSU PADURENAN', 'KP.KELAPA DUA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 4, 15000, 682500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-12 09:00:16', '2022-06-30 07:38:40', NULL);
INSERT INTO `restorans` VALUES (1418, 2, 'GABY OLIVIA', 'P.2.02.0005699.12.01', 'PEMPEK GABY / PT. GABY BERKAT SEJAHTERA', 'JL. PASAR PAGI BINTARA I GUSTI NGURAH RAI', 'BEKASI BARAT', 'BINTARA', '003', '015', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-12 09:08:23', '2022-01-14 09:39:59', '2022-01-14 09:39:59');
INSERT INTO `restorans` VALUES (1419, 2, 'ADNA FARIS SADEWA', 'P.2.02.0005691.12.01', 'NYAPI', 'JL. BINTARA RAYA', 'BEKASI BARAT', 'BINTARA', '013', '010', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-12 09:15:12', '2022-04-07 14:05:09', '2022-04-07 14:05:09');
INSERT INTO `restorans` VALUES (1420, 2, 'DONI TIRTANA', 'P.2.02.0005666.12.01', 'BEBEK DOWER', 'JL. BINTARA 4 BUNTU', 'BEKASI BARAT', 'BINTARA', '004', '001', 3, 11, 15000, 5220000, 10.00, '083806066421', '2022_RESTORAN_0142003082022.jpg', 0, 1, '-6.231688178661465', '106.9728469848633', 11, '2022-01-12 09:17:31', '2022-04-12 13:26:17', NULL);
INSERT INTO `restorans` VALUES (1421, 2, 'WAHYUDI PRAWIRO UTOMO', 'P.2.02.0005586.12.01', 'FLASH COFFEE', 'JL. BINTARA 5 NO. 10 B', 'BEKASI BARAT', 'BINTARA', '002', '002', 1, 2, 50000, 48700000, 10.00, '08119035049', '2022_RESTORAN_0142102182022.jpg', 0, 1, '-6.234418524258546', '106.97490692138673', 11, '2022-01-12 09:19:50', '2022-04-12 15:41:45', NULL);
INSERT INTO `restorans` VALUES (1422, 2, 'YUDASA NURIMAN BUWANA', 'P.2.02.0005543.12.01', 'KY STEAK & PASTA', 'JL. BINTARA RAYA NO. 11 BLOK AA 95', 'BEKASI BARAT', 'BINTARA', '001', '008', 4, 10, 25000, 4200000, 10.00, '081288731594', '2022_RESTORAN_0142203092022.jpg', 0, 1, '-6.232029472638188', '106.98040008544923', 11, '2022-01-12 09:23:12', '2022-04-12 15:43:06', NULL);
INSERT INTO `restorans` VALUES (1423, 2, 'REDI RAMADONA / MAULANA', 'P.2.02.0005542.12.01', 'NASI KEBULI GAZA', 'JL. BINTARA RAYA NO.11 BLOK AA 94', 'BEKASI BARAT', 'BINTARA', '001', '008', 5, 40, 15000, 12480000, 10.00, '081210016424', '2022_RESTORAN_0142302172022.jpg', 0, 1, '-6.224862252524702', '106.97765350341798', 11, '2022-01-12 09:25:56', '2022-04-12 15:44:19', NULL);
INSERT INTO `restorans` VALUES (1424, 2, 'ALI SUSANTO', 'P.2.02.0005527.12.01', 'ROTI O/ PT SEBASTIAN CITRA', 'JL. BINTARA RAYA NO.7', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 1, 6, 24000, 20304000, 10.00, '088512420695', '2022_RESTORAN_0142402082022.jpg', 0, 1, '-6.228275226686636', '106.98246002197267', 11, '2022-01-12 09:28:30', '2022-04-12 15:45:25', NULL);
INSERT INTO `restorans` VALUES (1425, 2, 'ARIMBI PUTIK APSARI', 'P.2.02.0005497.12.04', 'BOBA TIME / PT. LANGKAH INGIN TERDEPAN', 'JL. RAYA BINTARA JAYA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-12 09:31:21', '2022-01-14 10:22:05', '2022-01-14 10:22:05');
INSERT INTO `restorans` VALUES (1426, 2, 'JOHANNES PAULUS ARIFIN', 'P.2.02.0005457.12.01', 'HOKA HOKA BENTO KITCHEN BINTARA', 'JL. RAYA BINTARA RUKO KOMP. BINTARA BISNIS CENTER NO. 9A', 'BEKASI BARAT', 'BINTARA', '013', '010', 11, 6, 50000, 796840000, 10.00, '02189499661', '2022_RESTORAN_0142602162022.jpg', 0, 1, '-6.227592633628846', '106.97422027587892', 11, '2022-01-12 09:37:23', '2022-04-12 15:46:53', NULL);
INSERT INTO `restorans` VALUES (1427, 2, 'NUR HAYADI', 'P.2.02.0005418.12.01', 'HUNGRY PEDIA', 'JL. RAYA BINTARA RUKO PURI BINTARA REGENCY', 'BEKASI BARAT', 'BINTARA', '019', '002', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-12 09:39:57', '2022-03-14 09:59:53', '2022-03-14 09:59:53');
INSERT INTO `restorans` VALUES (1428, 2, 'HAIDHAR HIBATULLAH', 'P.2.02.0005401.12.01', 'ES TEH INDONESIA - BINTARA', 'JL. RAYA BINTARA NO. 50', 'BEKASI BARAT', 'BINTARA', '001', '002', 4, 8, 12500, 61150000, 10.00, '081511221810', '2022_RESTORAN_0142802172022.jpg', 0, 1, '-6.230323000534752', '106.97696685791017', 11, '2022-01-12 09:43:15', '2022-04-12 15:50:00', NULL);
INSERT INTO `restorans` VALUES (1429, 13, 'ANTO', 'P.2.02,0000123.1.02', 'KOPI', 'JL BUNTU', 'BEKASI UTARA', 'PERWIRA', '3', '12', 8, 20, 35000, 0, 0.00, '8131515231', NULL, 0, 4, '-6.2084346', '107.0005342', 14, '2022-01-12 09:44:11', '2022-01-12 09:45:49', '2022-01-12 09:45:49');
INSERT INTO `restorans` VALUES (1430, 2, 'OKTA WIRAWAN, SE', 'P.2.02.0005307.12.01', 'KEDAI ABUYA', 'JL. BINTARA RAYA', 'BEKASI BARAT', 'BINTARA', '013', '010', 7, 14, 35000, 4095000, 10.00, '08118888999', '2022_RESTORAN_0143002162022.jpg', 0, 1, '-6.231005590042038', '106.9728469848633', 11, '2022-01-12 09:45:44', '2022-04-12 15:51:52', NULL);
INSERT INTO `restorans` VALUES (1431, 2, 'GUFRON SYARIF / UFO', 'P.2.02.0005192.12.01', 'HAUS / PT. INSPIRASI BISNIS NUSANTARA', 'JL. BINTARA RAYA NO.24', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 8, 9, 40000, 231100000, 10.00, NULL, '2022_RESTORAN_0143102172022.jpg', 0, 1, '-6.226910039683643', '106.96529388427736', 11, '2022-01-12 09:49:47', '2022-04-12 13:28:53', NULL);
INSERT INTO `restorans` VALUES (1432, 3, 'WAHYUDI', 'P.2.02.0005024.12.04', 'PHAN - PHAN', 'JL. BINTARA RAYA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 4, 6, 15000, 1972500, 10.00, '081352055999', '2022_RESTORAN_0143202082022.jpg', 0, 1, '-6.247046187661611', '106.9563674926758', 11, '2022-01-12 09:54:29', '2022-04-11 11:05:40', NULL);
INSERT INTO `restorans` VALUES (1433, 2, 'EKO', 'P.2.02.0004978.12.01', 'PT. KEBAB MONSTER INDONESIA', 'JL. BINTARA 12, BEKASI BARAT', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 3, 0, 20000, 116200000, 10.00, NULL, NULL, 0, 1, '-6.225203550938972', '106.96941375732422', 11, '2022-01-12 09:59:07', '2022-04-11 11:21:23', NULL);
INSERT INTO `restorans` VALUES (1434, 2, 'RM. BEBEK GORENG HAJI SLAMET / ARIF', 'P.2.02.0004961.12.01', 'RM. BEBEK GORENG HAJI SLAMET', 'BINTARA IX / 1 RT. 001/001', 'BEKASI BARAT', 'BINTARA', '001', '001', 14, 12, 50000, 42775000, 10.00, '081298806856', '2022_RESTORAN_0143402162022.jpg', 0, 1, '-6.227592633628846', '106.97490692138673', 11, '2022-01-12 10:05:16', '2022-04-11 11:27:55', NULL);
INSERT INTO `restorans` VALUES (1435, 2, 'EDWARD TIRTANALA', 'P.2.02.0004923.12.01', 'KOPI KENAGAN / PT.BUMI BERKAH BOGA', 'JL.BINTARA RAYA NO.9 KOMP.RUKO BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 8, NULL, 50000, 568125000, 10.00, '08120017965', '2022_RESTORAN_0143502162022.jpg', 0, 1, '-6.228275226686636', '106.97902679443361', 11, '2022-01-12 10:14:57', '2022-04-11 11:35:20', NULL);
INSERT INTO `restorans` VALUES (1436, 1, 'PT EKA BOGA INTI', 'P.2.02.0001546.20.01', 'HOKA HOKA BENTO', 'JL RAYA HARAPAN INDAH 2B - 2C', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 30, 142, 150000, 1858500000, 10.00, '02188866314', '2022_RESTORAN_0143601122022.jpeg', 0, 1, '-6.199946870107371', '106.97490692138673', 16, '2022-01-12 10:15:32', '2022-03-24 12:18:55', NULL);
INSERT INTO `restorans` VALUES (1437, 2, 'TEGUK BINTARA / PT.PLATINUM WAHAB NUSANTARA / DIO', 'P.2.02.0004911.12.01', 'TEGUK BINTARA / PT.PLATINUM WAHAB NUSANTARA', 'JL. BINTARA RAYA 22-24', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 5, 4, 15000, 11595000, 10.00, NULL, '2022_RESTORAN_0143702182022.jpg', 0, 1, '-6.227592633628846', '106.96598052978517', 11, '2022-01-12 10:19:12', '2022-04-11 11:40:21', NULL);
INSERT INTO `restorans` VALUES (1438, 2, 'ALFAHMI SENTOSA', 'P.2.02.0004834.12.01', 'BAKSO ACI MANTAN CABANG 7 BINTARA', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 8, 12, 17000, 4726000, 10.00, '081774185622', '2022_RESTORAN_0143802082022.jpg', 0, 1, '-6.234077231836084', '106.97422027587892', 11, '2022-01-12 10:22:42', '2022-04-11 11:43:19', NULL);
INSERT INTO `restorans` VALUES (1439, 2, 'NGADI UTOMO / ERWIN LESMANA', 'P.2.02.0004500.12.01', 'RICHEESE FACTORY BINTARA / PT.REICHEESE KULINER INDONESIA', 'JL. BINTARA RAYA  NO.18', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 13, 68, 68000, 681020000, 10.00, '02188969476', '2022_RESTORAN_0143902182022.jpg', 0, 1, '-6.2337359391915435', '106.97765350341798', 11, '2022-01-12 10:25:53', '2022-04-11 11:46:35', NULL);
INSERT INTO `restorans` VALUES (1440, 2, 'HERU JANIS LO', 'P.2.02.0004125.12.01', 'AYAM BLENGER PSP SPESIAL GEPREK PEDAS', 'JL.BINTARA RAYA PERTOKOAN BISNIS CENTRE RT.013/010', 'BEKASI BARAT', 'BINTARA', '013', '010', 12, 14, 25000, 298000000, 10.00, '082165012774', '2022_RESTORAN_0144002082022.jpg', 0, 1, '-6.228616522882737', '106.9673538208008', 11, '2022-01-12 10:28:47', '2022-04-11 11:49:08', NULL);
INSERT INTO `restorans` VALUES (1441, 2, 'DANIS PONTOADI,SE', 'P.2.02.0004091.12.01', 'BAKSO BOEJANGAN / PT.CITARASA PRIMA INDONESIA BERJAYA', 'JL. BINTARA RAYA', 'BEKASI BARAT', 'BINTARA', '01', '07', 6, 80, 35000, 223650000, 10.00, '085646044855', '2022_RESTORAN_0144102082022.jpg', 0, 1, '-6.228616522882737', '106.96666717529298', 11, '2022-01-12 10:32:58', '2022-04-11 11:53:24', NULL);
INSERT INTO `restorans` VALUES (1442, 2, 'HENY TRIAPSILAWATI', 'P.2.02.0005707.20.01', 'RESTORAN SEDERHANA S.A', 'JL. RAYA HARAPAN INDAH KAV. SENTRA KULINER', 'MEDANSATRIA', 'MEDANSATRIA', NULL, NULL, 15, 160, 50000, 146400000, 10.00, '02188866400', '2022_RESTORAN_0144201122022.jpeg', 0, 4, '-6.170358325068032', '106.97416126728059', 16, '2022-01-12 10:37:25', '2022-04-11 12:00:59', NULL);
INSERT INTO `restorans` VALUES (1443, 2, 'GO. SUN LING', 'P.2.02.0003918.12.01', 'I AM GEPREK BENSU', 'JL.BINTARA RAYA RT.01/09', 'BEKASI BARAT', 'BINTARA', '01', '09', 5, 80, 50000, 114750000, 10.00, '081930807613', '2022_RESTORAN_0144302182022.jpg', 0, 1, '-6.224179655030904', '106.97010040283203', 11, '2022-01-12 10:40:16', '2022-04-11 12:47:45', NULL);
INSERT INTO `restorans` VALUES (1444, 2, 'DITA WULANDARI', 'P.2.02.0003742.12.12.01', 'RM. GEPREK BENSU', 'JL.I GUSTI NGURAH RAI JL.BARU NO.21 A', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 5, 6, 20000, 17150000, 10.00, NULL, '2022_RESTORAN_0144402182022.jpg', 0, 1, '-6.231005590042038', '106.98177337646486', 11, '2022-01-12 10:42:27', '2022-04-11 12:56:24', NULL);
INSERT INTO `restorans` VALUES (1445, 2, 'JAP JANTI KUSUMA JAYA', 'P.2.02.0003287.12.01', 'DOM PIZZA / PT.DOM PIZZA INDONESIA', 'JL.BINTARA RAYA KAVLING NO.1', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 13, 20, 65000, 406250000, 10.00, '02128519187', '2022_RESTORAN_0144502182022.jpg', 0, 1, '-6.231005590042038', '106.97147369384766', 11, '2022-01-12 10:45:03', '2022-04-11 13:04:44', NULL);
INSERT INTO `restorans` VALUES (1446, 1, 'GELAEL / FAST FOOD', 'P.2.02.0000864.20.01', 'KFC HARAPAN INDAH', 'JL RAYA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 25, 170, 150000, 1692750000, 10.00, '08117156885', '2022_RESTORAN_0144601122022.jpeg', 0, 1, '-6.186976752859924', '106.98863983154298', 16, '2022-01-12 10:47:40', '2022-03-24 12:19:27', NULL);
INSERT INTO `restorans` VALUES (1447, 2, 'LA DOE HAERUN GHONE', 'P.2.02.0003083.12.01', 'DCIKA CAKES & BAKERY/PT.DCIKA PRIMA MAHKOTA', 'KOMP.BINTARA BISNIS CENTER 9 D', 'BEKASI BARAT', 'BINTARA', '013', '010', 6, 0, 60000, 27450000, 10.00, NULL, '2022_RESTORAN_0144704082022.jpg', 0, 4, '-6.228957818856962', '106.97902679443361', 11, '2022-01-12 10:53:36', '2022-04-08 09:29:28', '2022-04-08 09:29:28');
INSERT INTO `restorans` VALUES (1448, 2, 'SUKOWATI SOSRODJOJO', 'P.2.02.0002246.12.01', 'MC DONALDS BINTARA', 'JL. BINTARA RAYA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 18, 50, 25000, 1862500000, 10.00, NULL, '2022_RESTORAN_0144802082022.jpg', 0, 1, '-6.2395378839383016', '106.96529388427736', 11, '2022-01-12 10:55:39', '2022-04-11 13:16:26', NULL);
INSERT INTO `restorans` VALUES (1449, 1, 'RUDY TANUDJAYA SAPUTRA', 'P.2.02.0000904.20.02', 'KFC GRANDMALL', 'GRANDMALL LT 3 B1 - 2', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 13, 148, 120000, 531360000, 10.00, '08117156886', '2022_RESTORAN_0144901122022.jpeg', 1, 1, '-6.202336067463098', '106.97559356689455', 16, '2022-01-12 10:56:25', '2022-03-24 12:19:48', NULL);
INSERT INTO `restorans` VALUES (1450, 2, 'TOFIK RIYADI', 'P.2.02.0002211.12.01', 'BAKSO RUSUK BINTARA', 'JL.I GUSTI RAI BINTARA', 'BEKASI BARAT', 'BINTARA', '010', '016', 6, 40, 30000, 4350000, 10.00, '085956302855', '2022_RESTORAN_0145002032022.jpg', 0, 1, '-6.228616522882737', '106.97628021240236', 11, '2022-01-12 11:04:08', '2022-04-11 13:19:06', NULL);
INSERT INTO `restorans` VALUES (1451, 1, 'PT SARI BURGER INDONESIA', 'P.2.02.0003680.20.03', 'BURGER KING', 'JL BOULEVARD HARAPAN INDAH BLOK KAV OIE', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 20, 100, 125000, 864375000, 10.00, '02122100894', '2022_RESTORAN_0145101122022.jpeg', 1, 1, '-6.182539534382483', '106.98246002197267', 16, '2022-01-12 11:06:57', '2022-03-24 12:20:29', NULL);
INSERT INTO `restorans` VALUES (1452, 1, 'PT AGUNG MANDIRI', 'P.2.02.0005410.20.01', 'GENKI SUSHI', 'JL HARAPAN INDAH BOULEVARD', 'MEDANSATRIA', 'MEDANSATRIA', '005', '010', 15, 45, 200000, 633900000, 10.00, '02189252020', '2022_RESTORAN_0145201122022.jpeg', 0, 1, '-6.207114429689079', '106.9728469848633', 16, '2022-01-12 11:13:28', '2022-03-24 12:20:52', NULL);
INSERT INTO `restorans` VALUES (1453, 2, 'PT.SARI MELATI KENCANA / PHD BINTARA', 'P.2.02.0001883.12.01', 'PHD BINTARA /PT.SARI MELATI KENCANA', 'JL.BINTARA RAYA RT.001/002 BINTARA', 'BEKASI BARAT', 'BINTARA', '001', '002', 6, 0, 100000, 657000000, 10.00, NULL, '2022_RESTORAN_0145304082022.jpg', 0, 1, '-6.2337359391915435', '106.97559356689455', 11, '2022-01-12 11:15:23', '2022-04-11 13:23:48', NULL);
INSERT INTO `restorans` VALUES (1454, 2, 'HERONIMUS KRISTANIJO', 'P.2.02.0001090.12.01', 'RM AUTO FOOD', 'JL. BINTARA RAYA NO.2', 'BEKASI BARAT', 'BINTARA', '002', '006', 5, 25, 35000, 12547500, 10.00, NULL, '2022_RESTORAN_0145404082022.jpg', 0, 1, '-6.231005590042038', '106.9783401489258', 11, '2022-01-12 11:18:06', '2022-04-11 13:36:19', NULL);
INSERT INTO `restorans` VALUES (1455, 1, 'PT PREMIER DOUGHNUT INDONESIA', 'P.2.02.0004888.20.01', 'KRISPY KREME', 'JL RAYA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 6, 10, 120000, 442560000, 10.00, '02189550176', '2022_RESTORAN_0145501122022.jpeg', 0, 1, '-6.1832221858026', '106.98314666748048', 16, '2022-01-12 11:19:39', '2022-03-24 12:26:15', NULL);
INSERT INTO `restorans` VALUES (1456, 2, 'JONNY SARTUNI,SE', 'P.2.02.0000806.12.01', 'RM SALSABIL', 'PERUM PONDOK CIPTA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 4, 26, 17000, 3646500, 10.00, '081280217500', '2022_RESTORAN_0145602082022.jpg', 0, 1, '-6.229299114609273', '106.97559356689455', 11, '2022-01-12 11:21:37', '2022-04-11 13:42:04', NULL);
INSERT INTO `restorans` VALUES (1457, 2, 'SUGITO', 'P.2.02.0000070.12.01', 'RM OJOLALI', 'JL.RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 4, 15, 15000, 2437500, 10.00, NULL, '2022_RESTORAN_0145704082022.jpg', 0, 1, '-6.231688178661465', '106.97628021240236', 11, '2022-01-12 11:44:50', '2022-04-11 13:46:04', NULL);
INSERT INTO `restorans` VALUES (1458, 2, 'MUSLIM', 'P.2.02.000062.12.01', 'RM TANAMO', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 8, 30, 25000, 20937500, 10.00, NULL, '2022_RESTORAN_0145804082022.jpg', 0, 1, '-6.228957818856962', '106.98177337646486', 11, '2022-01-12 11:47:10', '2022-04-11 13:52:57', NULL);
INSERT INTO `restorans` VALUES (1459, 2, 'REZA', 'P.2.02.0001961.20.03', 'NASI UDUK BANG JALI KEBON KACANG', 'BULEVARD HIJAU BLOK.B.8', 'MEDAN SATRIA', 'PEJUANG', '0', '0', 5, 24, 40000, 0, 0.00, '082211353203', NULL, 0, 4, '-6.185236', '106.9792367', 16, '2022-01-12 11:53:08', '2022-01-12 11:53:08', NULL);
INSERT INTO `restorans` VALUES (1460, 2, 'JIMMY SURYA SUSANTO', 'P.2.02.0005077.20.01', 'RM. TELAGA SEAFOOD/CV. TELAGA SWARNA CIPTA', 'RAYA HARAPAN INDAH MELI MELO 3', 'BANTARGEBANG', 'BANTARGEBANG', '0', '0', 18, 40, 150000, 175410000, 10.00, '082250959988', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 11:53:08', '2022-06-06 08:09:38', '2022-06-06 08:09:38');
INSERT INTO `restorans` VALUES (1461, 2, 'PT.SURYA LESTARI FOOD', 'P.2.02.0001853.20.01', 'PT.SURYA LESTARI FOOD', 'KAV.BLOK 14 KOTA HARAPAN INDAH KEL.MEDAN SATRIA', 'MEDAN SATRIA', 'MEDAN SATRIA', '0', '0', 21, 110, 70000, 0, 0.00, '088866005', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 11:53:08', '2022-01-12 11:53:08', NULL);
INSERT INTO `restorans` VALUES (1462, 2, 'HARIJADI SURYA', 'P.2.02.0005078.20.01', 'MR. SUMO', 'JL. RAYA HARAPAN INDAH MELI MELO 3', 'BANTARGEBANG', 'BANTARGEBANG', '0', '0', 22, 60, 119000, 639625000, 10.00, '082298110050', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 11:53:08', '2022-05-10 08:50:46', '2022-05-10 08:50:46');
INSERT INTO `restorans` VALUES (1463, 2, 'DEWI JULIANA', 'P.2.02.0002405.20.03', 'RM. PONDOK LEZAT', 'BOULEVARD HIJAU RAYA BLOK C5 NO.6', 'MEDAN SATRIA', 'PEJUANG', '0', '0', 14, 50, 100000, 0, 0.00, '08119006865', NULL, 0, 4, '-6.185236', '106.9792367', 16, '2022-01-12 11:53:08', '2022-01-12 11:53:08', NULL);
INSERT INTO `restorans` VALUES (1464, 2, 'MERYANA ROSALENE', 'P.2.02.0005211.20.03', 'SEAFOOD GEPREK', 'RUKO SENTRA NIAGA JL BOULEVARD HIJAU B1 NO 63', 'MEDANSATRIA', 'PEJUANG', '00', '00', 3, 24, 20000, 6860000, 10.00, '081284330460', '2022_RESTORAN_0146401122022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-12 13:42:14', '2022-06-06 12:06:34', NULL);
INSERT INTO `restorans` VALUES (1465, 3, 'JASWADI', 'P.2.02.0005595.11.03', 'BAKSO SUBUR', 'JL. KARANG SATRIA', 'BEKASI TIMUR', 'DURENJAYA', '001', '008', 10, 60, 15000, 19162500, 10.00, '082122840889', '2022_RESTORAN_0146501122022.jpg', 0, 4, '-6.22452095388867', '107.04209089279176', 10, '2022-01-12 13:55:22', '2022-01-12 13:55:22', NULL);
INSERT INTO `restorans` VALUES (1466, 3, 'WACHIDIN SLAMET', 'P.2.02.0004480.20.03', 'BASO GEPENG SUPER SI KUMIS', 'BOULEVARD HIJAU BLOK.B', 'MEDANSATRIA', 'PEJUANG', '0', '0', 4, 20, 18000, 8730000, 10.00, '081885012221', NULL, 0, 1, '-6.185236', '106.9792367', 16, '2022-01-12 14:31:48', '2022-06-06 12:08:21', NULL);
INSERT INTO `restorans` VALUES (1467, 2, 'TONI ISTANTO', 'P.2.02.0004412.20.01', 'AYAM BAKAR KQ LIMA', 'JL.RAYA HARAPAN INDAH MELI MELO 3', 'MEDAN SATRIA', 'MEDAN SATRIA', '0', '0', 5, 96, 30000, 0, 0.00, '02188895850', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 14:31:48', '2022-01-12 14:31:48', NULL);
INSERT INTO `restorans` VALUES (1468, 2, 'PT MOUND SCOPUS INDONESIA', 'P.2.02.0003551.20.03', 'HARVEST  / PT.MOUNT SCOPUS INDONESIA', 'RUKO SENTRA NIAGA SN.2 NO.1 JL.BOULEVARD HIJAU', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 19, 0, 200000, 514800000, 10.00, '082221999140', '2022_RESTORAN_0146801122022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-12 14:33:52', '2022-03-24 12:32:21', NULL);
INSERT INTO `restorans` VALUES (1469, 2, 'WIRI TJANDRA', 'P.2.02.0005348.20.01', 'PT. FAJAR MITRA INDAH / FAMILY HARAPAN INDAH', 'RUKO BOULEVAR HIJAU BLOK B8 NO. 45-46', 'MEDAN SATRIA', 'PEJUANG', '0', '0', 9, 24, 40000, 0, 0.00, '081113901395', NULL, 0, 4, '-6.185236', '106.9792367', 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1470, 2, 'CAFE RESTO JAYA', 'P.2.02.0003153.20.03', 'CAFE RESTO JAYA', 'RUKO HARAPAN INDAH BLOK.EB NO.35', 'MEDAN SATRIA', 'PEJUANG', '0', '0', 10, 44, 50000, 0, 0.00, '08881822217', NULL, 0, 4, '-6.185236', '106.9792367', 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1471, 1, 'HARDJANTO SALIM', 'P.2.02.0002479.20.01', 'REST.YOSHINOYA/PT.MULTI RASA NUSANTARA', 'SENTRA KULINER 3 KAV.26 B NO.01 KOTA HARAPAN INDAH', 'MEDAN SATRIA', 'MEDAN SATRIA', '0', '0', 13, 96, 30000, 0, 0.00, '081398196710', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1472, 2, 'PT SARI MELATI KENCANA', 'P.2.02.0000969.20.03', 'PIZZA HUT DELIVERY RUKO SENTRA NIAGA', 'RUKO SENTRA NIAGA BULEVER HIJAU BLOK 1', 'MEDAN SATRIA', 'PEJUANG', '0', '0', 20, 6, 50000, 0, 0.00, '08113249420', NULL, 0, 4, '-6.185236', '106.9792367', 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1473, 1, 'PT SARI MELATI KENCANA', 'P.2.02.0001675.20.01', 'PIZZA HUT DELIVERY SENTRA KULINER', 'KAV.SENTRA KULINER 2 C HARAPAN INDAH', 'MEDAN SATRIA', 'MEDAN SATRIA', '0', '0', 55, 52, 100000, 0, 0.00, '08113249325', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1474, 1, 'SUMARNO NGADIMAN', 'P.2.02.0002457.20.01', 'TA WAN/PT.PANCA BOGA PARAMITA', 'RUKO PURI SENTRA NIAGA BLOK. T5 NO.20', 'MEDAN SATRIA', 'MEDAN SATRIA', '0', '0', 16, 48, 39000, 0, 0.00, '02188866172', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1475, 1, 'SUMARNO NGADIMAN', 'P.2.02.0002221.20.01', 'ICHIBAN SUSHI/PT.PANCA BOGA PARAMITA', 'HARAPAN INDAH RAYA', 'MEDAN SATRIA', 'MEDAN SATRIA', '0', '0', 9, 6, 100000, 0, 0.00, '02188866071', NULL, 0, 4, NULL, NULL, 16, '2022-01-12 14:36:21', '2022-01-12 14:36:21', NULL);
INSERT INTO `restorans` VALUES (1476, 2, 'WACHIDIN SLAMET', 'P.222222222222', 'BASO GEPENG SUPER SI KUMIS', 'BOULEVARD HIJAU BLOK.B', 'MEDANSATRIA', 'PEJUANG', '0', '0', 4, 44, 50000, 104750000, 10.00, '081885012221', NULL, 0, 1, '-6.185236', '106.9792367', 1, '2022-01-12 14:43:39', '2022-02-03 10:06:35', '2022-02-03 10:06:35');
INSERT INTO `restorans` VALUES (1477, 2, 'TONI ISTANTO', 'P.2.02.0004412.20.01', 'AYAM BAKAR KQ LIMA', 'JL.RAYA HARAPAN INDAH MELI MELO 3', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 5, 96, 30000, 74700000, 10.00, '02188895850', NULL, 0, 1, NULL, NULL, 1, '2022-01-12 14:43:39', '2022-02-03 10:33:00', NULL);
INSERT INTO `restorans` VALUES (1478, 2, 'NGADI UTOMO', 'P.2.02.0003408.20.03', 'RICHEESE FACTORY /PT.RICHEESE KULINER INDONESIA', 'RUKO BOULEVARD HIJAU CI NO.32A', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 20, 60, 120000, 942720000, 10.00, '087722466296', '2022_RESTORAN_0147801122022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-12 15:09:23', '2022-03-24 12:37:31', NULL);
INSERT INTO `restorans` VALUES (1479, 2, 'PELLY', 'P.2.02.0004987.20.01', 'BAKMI GM / PT GRIYA MIE SEJATI', 'LIVING PLAZA HARAPAN INDAH RT. 005/010', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 20, 34, 120000, 590400000, 10.00, '02188892866', '2022_RESTORAN_0147901122022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-12 15:14:05', '2022-04-14 13:35:33', NULL);
INSERT INTO `restorans` VALUES (1480, 2, 'RM.WARUNG BU KRIS', 'P.2.02.0001899.20.01', 'RM.WARUNG BU KRIS', 'JL.SENTRA KULINER BLOK.10-I P', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 15, 20, 50000, 125350000, 10.00, '081905097000', '2022_RESTORAN_0148001122022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-12 15:16:44', '2022-03-24 14:57:09', NULL);
INSERT INTO `restorans` VALUES (1481, 2, 'KHAW THOMAS YONATHAN', 'P.2.02.0002661.20.03', 'RM SOTO BETAWI SENEN', 'RUKO GRIYA HARPAN PERMAI BLOK A1 NO.1', 'MEDANSATRIA', 'PEJUANG', NULL, NULL, 4, 20, 30000, 34230000, 10.00, '081281963250', '2022_RESTORAN_0148101122022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-12 15:30:13', '2022-04-26 11:21:21', NULL);
INSERT INTO `restorans` VALUES (1482, 2, 'MARTIN', 'P.2.02.0004436.20.02', 'BAKSO SOLO SAMRAT', 'KOMPLEK GRAHA BOULEVARD  6B . B02', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 10, 40, 70000, 169050000, 10.00, '085100882238', '2022_RESTORAN_0148201132022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-13 08:26:02', '2022-06-06 12:12:40', NULL);
INSERT INTO `restorans` VALUES (1483, 2, 'NIKO AL HAKIM', 'P.2.02.0003898.20.02', 'SATE TAICHAN GORENG', 'RUKO GRAHA SUMARECON B07', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 14, 25, 50000, 129700000, 10.00, '087788236343', '2022_RESTORAN_0148301132022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-13 08:31:43', '2022-06-06 12:17:07', NULL);
INSERT INTO `restorans` VALUES (1484, 3, 'ETTI MARLIANA', 'P.2.02.0004795.20.04', 'SUMBER REZEKI', 'JL SULTAN AGUNG', 'MEDANSATRIA', 'MEDANSATRIA', '005', '003', 4, 10, 15000, 7635000, 10.00, '081206168019', '2022_RESTORAN_0148401132022.jpeg', 0, 4, NULL, NULL, 16, '2022-01-13 08:40:15', '2022-06-06 14:17:41', NULL);
INSERT INTO `restorans` VALUES (1485, 1, 'MUHAMAD ALIARIANSYAH', 'P.2.02.0004353.20.01', 'ABUBA STEAK', 'KOTA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 14, 40, 200000, 507100000, 10.00, '02188893555', '2022_RESTORAN_0148501132022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-13 08:47:39', '2022-03-24 15:11:41', NULL);
INSERT INTO `restorans` VALUES (1486, 2, 'PT PANGANDARAN MAKMUR SEJAHTERA', 'P.2.02.0002105.20.01', 'PONDOK PAGANDARAN', 'JL RAYA HARAPAN INDAH KAV I H', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 14, 50, 100000, 177700000, 10.00, '02188865997', '2022_RESTORAN_0148601132022.jpeg', 1, 1, NULL, NULL, 16, '2022-01-13 08:53:53', '2022-03-24 15:15:10', NULL);
INSERT INTO `restorans` VALUES (1487, 3, 'ALI SUSANTO', 'P.2.02.0003436.12.02', 'ROTI\'O', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARAJAYA', '001', '012', 1, 6, 24000, 5352000, 10.00, '089512420695', '2022_RESTORAN_0148702082022.jpg', 0, 4, '-6.230323000534752', '106.9728469848633', 11, '2022-01-13 08:55:30', '2022-03-14 09:58:30', '2022-03-14 09:58:30');
INSERT INTO `restorans` VALUES (1488, 1, 'BENNY GUNAWAN', 'P.2.02.0002413.20.01', 'RESTORAN SANTIKA', 'JL RAYA HARAPAN INDAH NO 10 - 12', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 10, 140, 300000, 1699500000, 10.00, '087883012137', '2022_RESTORAN_0148801132022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-13 08:57:46', '2022-06-06 14:18:17', NULL);
INSERT INTO `restorans` VALUES (1489, 1, 'PT MASTER BOGA SUKSES MAKMUR', 'P.2.02.0001819.20.01', 'BUMBU DESA', 'JL HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 26, 300, 130000, 230360000, 10.00, '08564874794', '2022_RESTORAN_0148901132022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-13 08:59:21', '2022-06-06 14:20:41', NULL);
INSERT INTO `restorans` VALUES (1490, 3, 'ARIMBI PUTIK APSARI', 'P.2.02.0005497.12.04', 'BOBA TIME / PT. LANGKAH INGIN TERDEPAN', 'JL. RAYA BINTARA JAYA', 'BEKASI BARAT', 'BINTARAJAYA', NULL, NULL, 3, 4, 20000, 13920000, 10.00, '02173663895', '2022_RESTORAN_0149002082022.jpg', 0, 1, '-6.238172726245215', '106.9680404663086', 11, '2022-01-13 09:02:58', '2022-04-11 14:04:13', NULL);
INSERT INTO `restorans` VALUES (1491, 1, 'PT REKSO NASIONAL FOOD', 'P.2.02.0001016.20.01', 'MCDONALD\'S KOTA HARAPAN INDAH', 'JL BOULEVARD KAV HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '0', '0', 30, 72, 150000, 2949000000, 10.00, '08111977665', '2022_RESTORAN_0149101132022.jpeg', 1, 1, NULL, NULL, 16, '2022-01-13 09:04:26', '2022-04-11 13:44:40', NULL);
INSERT INTO `restorans` VALUES (1492, 2, 'SATWIKA ARY SAPUTRA', 'P.2.02.0004918.12.04', 'LTSGO CHICKEN / PT.INSPIRASI KULINER INDONESIA', 'KOMPLEK RUKO ALFAMIDI', 'BEKASI BARAT', 'BINTARAJAYA', NULL, NULL, 2, 2, 20000, 4940000, 10.00, NULL, '2022_RESTORAN_0149202082022.jpg', 0, 1, '-6.231005590042038', '106.98108673095705', 11, '2022-01-13 09:08:19', '2022-04-11 14:09:40', NULL);
INSERT INTO `restorans` VALUES (1493, 2, 'CHANDRA ANDHIKIN', 'P.2.02.0001987.20.03', 'NASI UDUK KEBON KACANG', 'JL BOULEVARD RAYA KOTA HARAPAN INDAH', 'MEDANSATRIA', 'PEJUANG', '0', '0', 10, 28, 150000, 619500000, 10.00, '0895346032587', '2022_RESTORAN_0149301132022.jpeg', 0, 4, NULL, NULL, 16, '2022-01-13 09:08:19', '2022-04-25 11:28:37', NULL);
INSERT INTO `restorans` VALUES (1494, 2, 'SPV TRIONO', 'P.2.02.0005699.12.01', 'PEMPEK GABY / PT. GABY BERKAT SEJAHTERA', 'JL. PASAR PAGI BINTARA I GUSTI NGURAH RAI RT. 003 RW. 015', 'BEKASI BARAT', 'BINTARA', '003', '015', 2, 8, NULL, 0, 10.00, NULL, NULL, 0, 4, '-6.228616522882737', '106.97490692138673', 11, '2022-01-13 09:13:36', '2022-03-15 11:01:57', '2022-03-15 11:01:57');
INSERT INTO `restorans` VALUES (1495, 2, 'DEVIN WIDYA KRISNADI', 'P.2.02.0005690.12.05', 'CHATIME X CUPBOB', 'JL. KH. NOER ALI NO. 12-15', 'BEKASI BARAT', 'JAKASAMPURNA', '005', '002', 12, 48, 50000, 119750000, 10.00, '082299226424', NULL, 0, 1, '-6.2444044', '107.0057195', 11, '2022-01-13 09:15:49', '2022-04-12 13:35:19', NULL);
INSERT INTO `restorans` VALUES (1496, 2, 'WAHYUDI PRAWIRO UTOMO', 'P.2.02.0005585.12.05', 'FLASH COFFEE', 'KOMPLEK B. WALK GRAND BINTANG JL. KH. NOER ALI', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 3, 12, 20000, 12690000, 10.00, '085710908091', '2022_RESTORAN_0149602032022.jpg', 1, 1, '-6.231005590042038', '106.98246002197267', 11, '2022-01-13 09:18:21', '2022-04-11 14:14:01', NULL);
INSERT INTO `restorans` VALUES (1497, 3, 'MEINDRASTA', 'P.2.02.0003171.13.03', 'BEBEK GORENG H.SLAMET', 'RUKO DUTA HARAPAN BLOK I NO.1', 'BEKASI UTARA', 'HARAPANBARU', '01', '014', 8, 38, 28000, 55636000, 10.00, '08119423452', '2022_RESTORAN_0149701132022.jpeg', 0, 1, '-6.213303304284343', '107.01962739229204', 14, '2022-01-13 09:21:21', '2022-02-15 11:47:51', NULL);
INSERT INTO `restorans` VALUES (1498, 1, 'ROBERT SUTEJA', 'P.2.02.0005571.12.05', 'PT. JCO DONUT & COFFEE', 'JL. KH. NOER ALI KALIMALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 12, 31, 30000, 173850000, 10.00, '081808810663', '2022_RESTORAN_0149801312022.jpg', 0, 1, '-6.237831436266373', '106.95980072021486', 11, '2022-01-13 09:21:33', '2022-04-11 14:24:58', NULL);
INSERT INTO `restorans` VALUES (1499, 3, 'GILANG RAMADAN', 'P.2.02.0005440.12.05', 'SEBLAK GARAGE', 'JL. BINTARA RAYA RT 01/19 JAKASAMPURNA', 'BEKASI BARAT', 'JAKASAMPURNA', '01', '19', 4, 32, 16000, 3728000, 10.00, '081221492372', '2022_RESTORAN_0149901312022.jpg', 0, 1, '-6.232370766392908', '106.96666717529298', 11, '2022-01-13 09:25:14', '2022-04-12 08:35:37', NULL);
INSERT INTO `restorans` VALUES (1500, 2, 'TEDDY HARSONO', 'P.2.02.0005439.12.05', 'RAMEN JOU / PT. TORICO MAJU MAKMUR', 'JL. KH. NOER ALI KALI MALANG JAKSEM', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 5, 44, 20000, 13890000, 10.00, '081287066618', NULL, 0, 1, '-6.2443906', '107.0057837', 11, '2022-01-13 09:28:02', '2022-04-12 08:57:04', NULL);
INSERT INTO `restorans` VALUES (1501, 3, 'NURUL HADI', 'P.2.02.0003092.11.04', 'BEBEK GORENG BULAK KAPAL', 'JL. IR. H. JUANDA NO. 155', 'BEKASI TIMUR', 'ARENJAYA', NULL, NULL, 6, 52, 21000, 44625000, 10.00, '081310238555', '2022_RESTORAN_0150101132022.jpg', 0, 1, '-6.251013600122098', '107.02799320220949', 10, '2022-01-13 09:31:32', '2022-06-15 10:21:07', NULL);
INSERT INTO `restorans` VALUES (1502, 1, 'KALVIN PRATAMA LIE', 'P.2.02.0005336.12.05', 'TALAGA SAMPIREUN / PT. KULINER INDONESIA SENTOSA', 'JL. KH. NOER ALI KOMPLEK KOTA BINTANG BOULEVARD KAV. 3', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 50, 144, 300000, 3142500000, 10.00, '081210130780', '2022_RESTORAN_0150201272022.jpg', 0, 1, '-6.221790556818842', '106.96392059326173', 11, '2022-01-13 09:35:57', '2022-04-12 09:30:25', NULL);
INSERT INTO `restorans` VALUES (1503, 3, 'MAHMUD', 'P.2.02.0005273.12.05', 'WARUNG KOPI REMAN KALIMALANG', 'JL. CAMARA RAJA NO. 3 KALIMALANG RAYA', 'BEKASI BARAT', 'JAKASAMPURNA', '005', '006', 2, 26, 20000, 4170000, 10.00, '082299414144', '2022_RESTORAN_0150301312022.jpg', 0, 1, '-6.247046187661611', '106.95705413818361', 11, '2022-01-13 09:39:27', '2022-04-12 10:03:10', NULL);
INSERT INTO `restorans` VALUES (1504, 3, 'HIDAYAT WIDIYATMOKO', 'P.2.02.0005051.13.03', 'AYAM KEPREK SULTAN', 'JL.DANAU DUTA BARAT', 'BEKASI UTARA', 'HARAPANBARU', '03', '011', 4, 20, 17000, 18147500, 10.00, '081389552178', '2022_RESTORAN_0150401132022.jpeg', 0, 1, '-6.214705856875704', '107.01906949281694', 14, '2022-01-13 09:41:23', '2022-02-15 11:43:45', NULL);
INSERT INTO `restorans` VALUES (1505, 2, 'HJ. RODHIYAH NAJIBHAH', 'P.2.02.0005249.12.05', 'NASI KAPAU UDA JHON', 'JL. KH. NOER ALI NO. 14', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 6, 40, 50000, 30125000, 10.00, '085780909035', '2022_RESTORAN_0150501272022.jpg', 0, 1, '-6.226568742378317', '106.97353363037111', 11, '2022-01-13 09:41:54', '2022-04-12 10:15:10', NULL);
INSERT INTO `restorans` VALUES (1506, 2, 'LUTHFI SHEBUBAKAR', 'P.2.02.0005221.12.05', 'NATRABU MINANG RESTAURANT', 'JL. KH NOER ALI ALI KALIMALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 12, 72, 50000, 30500000, 10.00, '08111471912', '2022_RESTORAN_0150601262022.jpg', 0, 1, '-6.229640410139697', '106.97353363037111', 11, '2022-01-13 09:43:58', '2022-04-12 10:17:51', NULL);
INSERT INTO `restorans` VALUES (1507, 2, 'H. BUSTAMAN', 'P.2.02.0004207.11.02', 'REST. SEDERHANA H. BUSTAMAN', 'JL. CUT MEUTIA RUKO CBD BETOS BLOK A1 & A2', 'BEKASI TIMUR', 'MARGAHAYU', '003', '009', 15, 72, 30000, 112950000, 10.00, '02189992869', '2022_RESTORAN_0150701132022.jpg', 0, 1, '-6.2528906449946025', '107.01110601425172', 10, '2022-01-13 09:44:46', '2022-04-18 10:22:54', NULL);
INSERT INTO `restorans` VALUES (1508, 3, 'SUNDARI DWI SAPUTRA SPSI / PRAKYONO', 'P.2.02.0004936.12.05', 'MY BUBLE', 'JL.CENDANA XIX NO.35', 'BEKASI BARAT', 'JAKASAMPURNA', '008', '010', 4, 40, 16000, 1584000, 10.00, '08122734979', '2022_RESTORAN_0150801312022.jpg', 0, 1, '-6.231688178661465', '106.96048736572267', 11, '2022-01-13 09:45:38', '2022-04-12 10:24:30', NULL);
INSERT INTO `restorans` VALUES (1509, 2, 'GAEMBULL ZENTRUM KITCHEN', 'P.2.02.0004858.12.05', 'GAEMBULL RESTO', 'JL.KH.NOER ALI KALIMALANG KOTA BINTANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 6, 40, 30000, 29640000, 10.00, '087776164377', '2022_RESTORAN_0150901272022.jpg', 0, 1, '-6.229640410139697', '106.98177337646486', 11, '2022-01-13 09:48:03', '2022-04-12 10:31:52', NULL);
INSERT INTO `restorans` VALUES (1510, 3, 'SONY SUHARMAN', 'P.2.02.0005286.13.03', 'FANOTA', 'JL.DUTA UTAMA 1', 'BEKASI UTARA', 'HARAPANBARU', '003', '010', 5, 20, 10000, 10920000, 10.00, '081993210494', '2022_RESTORAN_0151001132022.jpeg', 0, 1, '-6.21722297610436', '107.02031940221788', 14, '2022-01-13 09:50:36', '2022-02-03 10:59:22', NULL);
INSERT INTO `restorans` VALUES (1511, 3, 'LIEBE GOKLAS MANURUNG', 'P.2.02.0004839.12.05', 'MR CRISPY', 'JL.PEMUDA PATRIOT', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 3, 60, 10000, 1400000, 10.00, '08111545417', '2022_RESTORAN_0151101272022.jpg', 0, 1, '-6.2347598164589035', '106.97696685791017', 11, '2022-01-13 09:53:04', '2022-04-12 10:37:15', NULL);
INSERT INTO `restorans` VALUES (1512, 2, 'EDWARD TIRTANATA', 'P.2.02.0004812.12.05', 'KOPI KENANGAN', 'JL.KH NOER ALI X MALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 7, 6, 50000, 361000000, 10.00, '081318640326', '2022_RESTORAN_0151201272022.jpg', 0, 1, '-6.2299817054481945', '106.98177337646486', 11, '2022-01-13 09:56:59', '2022-04-12 10:43:18', NULL);
INSERT INTO `restorans` VALUES (1513, 3, 'FARUK FAHRANY AL.KATIRI.SH', 'P.2.02.0004801.12.05', 'SAYA KOPI NUANSA', 'JL.CEMARA RAYA NO.1', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 5, 8, 20000, 4190000, 10.00, '081382185280', '2022_RESTORAN_0151301312022.jpg', 0, 1, '-6.230323000534752', '106.97422027587892', 11, '2022-01-13 09:59:07', '2022-04-12 10:45:24', NULL);
INSERT INTO `restorans` VALUES (1514, 3, 'M. NUR KHAPANDI', 'P.2.02.0000037.11.04', 'YOKOBENTO I', 'JL. NUSANTARA RAYA BLOK B2 NO. 2', 'BEKASI TIMUR', 'ARENJAYA', '002', '002', 5, 14, 25000, 7350000, 10.00, '081211882021', '2022_RESTORAN_0151401132022.jpg', 0, 1, '-6.24460', '107.03969', 10, '2022-01-13 09:59:34', '2022-04-14 08:33:43', NULL);
INSERT INTO `restorans` VALUES (1515, 1, 'HARDJANTO SALIM', 'P.2.02.0004227.12.05', 'YOSHINOYA / PT.MULTIRASA NUSANTARA', 'KOTA BINTANG BOULEVARD NO.A1& A2', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 10, 28, 150000, 827250000, 10.00, '085693974550', '2022_RESTORAN_0151501262022.jpg', 0, 1, '-6.2391965948484', '106.97696685791017', 11, '2022-01-13 10:01:55', '2022-04-12 10:52:25', NULL);
INSERT INTO `restorans` VALUES (1516, 1, 'PT. SARI COFFE INDONESIA', 'P.2.02.0004177.12.05', 'STARBUCKS COFFEE / PT. SARI COFFE INDONESIA', 'GRAND KOTA BINTANG NO.UNIT W-2 K.H. NOER ALI W2', 'BEKASI BARAT', 'JAKASAMPURNA', '004', '002', 13, 42, 150000, 856125000, 10.00, '081385560101', '2022_RESTORAN_0151602022022.jpg', 0, 1, '-6.229640410139697', '106.95293426513673', 11, '2022-01-13 10:09:24', '2022-04-12 10:55:38', NULL);
INSERT INTO `restorans` VALUES (1517, 2, 'TONY NUGROHO', 'P.2.02.0004043.12.05', 'PEMPEK GABY KOTA BINTANG', 'RUKO GRAND BINTANG BLOK.B NO.5', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 5, 16, 70000, 218400000, 10.00, '081318640326', '2022_RESTORAN_0151701272022.jpg', 0, 1, '-6.231346884462741', '106.98177337646486', 11, '2022-01-13 10:12:35', '2022-04-12 13:39:14', NULL);
INSERT INTO `restorans` VALUES (1518, 3, 'M. NUR KHAPANDI', 'P.2.02.0000033.11.01', 'YOKOBENTO II', 'JL. KH AGUS SALIM NO. 81', 'BEKASI TIMUR', 'BEKASIJAYA', '005', '007', 3, 14, 25000, 7350000, 10.00, '081285963684', '2022_RESTORAN_0151801132022.jpg', 0, 1, '-6.23407', '107.00807', 10, '2022-01-13 10:13:26', '2022-04-14 08:34:04', NULL);
INSERT INTO `restorans` VALUES (1519, 1, 'DALIMIN JUWONO', 'P.2.02.0004018.12.05', 'KFC GRAND KOTA BINTANG / PT.FAST FOOD INDONESIA', 'GRAND KOTA BINTANG JL.KH.NOER ALI', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 18, 62, 230000, 1411625000, 10.00, '082122653787', '2022_RESTORAN_0151901262022.jpg', 0, 1, '-6.2361249830392875', '106.97628021240236', 11, '2022-01-13 10:15:17', '2022-04-12 11:33:40', NULL);
INSERT INTO `restorans` VALUES (1520, 3, 'SUGITO', 'P.2.02.0004008.12.05', 'BAKSO OJOLALI JAKASAMPURNA', 'JL.BINTARA RAYA RT.001/019', 'BEKASI BARAT', 'JAKASAMPURNA', '001', '019', 3, 32, 26000, 1144000, 10.00, '085773461963', '2022_RESTORAN_0152001282022.jpg', 0, 1, '-6.2395378839383016', '106.9783401489258', 11, '2022-01-13 10:17:20', '2022-04-12 11:34:18', NULL);
INSERT INTO `restorans` VALUES (1521, 1, 'JAP JANTI KUSUMA JAYA', 'P.2.02.0003954.12.05', 'BURGER KING GRAND KOTA BINTANG / PT.SARI BURGER INDONESIA', 'JL.KH.NOER ALI KALIMALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 21, 200, 125000, 678125000, 10.00, '08886128151', '2022_RESTORAN_0152101262022.jpg', 1, 1, '-6.229640410139697', '106.98108673095705', 11, '2022-01-13 10:20:11', '2022-04-12 11:36:11', NULL);
INSERT INTO `restorans` VALUES (1522, 2, 'EDWARD TIRTANATA', 'P.2.02.0005214.13.03', 'KOPI KENANGAN', 'JL. PERJUANGAN NO. 26-27 RT. 004/008', 'BEKASI UTARA', 'HARAPANBARU', '004', '008', 5, 2, 29000, 196837500, 10.00, '08170731621', '2022_RESTORAN_0152201132022.jpeg', 0, 1, '-6.221126620230828', '107.01880127191546', 14, '2022-01-13 10:22:18', '2022-02-15 11:46:39', NULL);
INSERT INTO `restorans` VALUES (1523, 2, 'DALIMIN JUWONO', 'P.2.02.0003715.13.03', 'KFC BOX NAGA WISMA ASRI', 'JL.PERJUANGAN NO.88', 'BEKASI UTARA', 'HARAPANBARU', '004', '008', 6, 15, 42000, 180264000, 10.00, '08117156892', '2022_RESTORAN_0152301132022.jpeg', 0, 1, '-6.2210946232656505', '107.018720805645', 14, '2022-01-13 10:36:01', '2022-02-15 11:49:14', NULL);
INSERT INTO `restorans` VALUES (1524, 3, 'JIMMY WANTONO', 'P.2.02.0005268.13.03', 'ROTI O', 'JL. PERJUANGAN NO 59', 'BEKASI UTARA', 'HARAPANBARU', '001', '003', 3, 6, 12000, 23778000, 10.00, '089670971219', '2022_RESTORAN_0152401132022.jpeg', 0, 1, '-6.22232117220383', '107.02321618795396', 14, '2022-01-13 10:47:02', '2022-02-03 11:02:30', NULL);
INSERT INTO `restorans` VALUES (1525, 3, 'HIDAYAT WIDIYATMOKO', 'P.2.02.0002933.13.03', 'AYAM GORENG IPPO', 'PRIMA HARAPAN REGENCY BLOK.L6 NO.56', 'BEKASI UTARA', 'HARAPANBARU', '009', '012', 4, 20, 15000, 15142500, 10.00, '081398382401', '2022_RESTORAN_0152501132022.jpg', 0, 1, '-6.216548368001026', '107.01426833868028', 14, '2022-01-13 10:59:12', '2022-02-15 11:54:05', NULL);
INSERT INTO `restorans` VALUES (1526, 2, 'ZAINA SIMAN', 'P.2.02.0003974.13.03', 'A & W RESTAURAN', 'RUKO PRIMA ORCHAD BEKASI NO.D1,D2,D3', 'BEKASI UTARA', 'HARAPANBARU', '009', '012', 7, 26, 58000, 198534000, 10.00, '021 88383667', '2022_RESTORAN_0152601132022.jpg', 0, 1, '-6.2204253529641', '107.01473772525789', 14, '2022-01-13 11:06:58', '2022-02-15 11:57:04', NULL);
INSERT INTO `restorans` VALUES (1527, 3, 'RM. SEDERHANA KALIABANG', 'P.2.02.0002936.13.06', 'SEDERHANA KALIABANG', 'JL.PELANGI RT.001/020 HARPAN JAYA', 'BEKASI UTARA', 'HARAPANJAYA', '001', '020', 10, 20, 18000, 34092000, 10.00, '021 88883113', '2022_RESTORAN_0152701132022.jpg', 0, 1, '-6.20254938812913', '107.00128108263017', 14, '2022-01-13 11:27:14', '2022-02-15 11:59:03', NULL);
INSERT INTO `restorans` VALUES (1528, 3, 'RENDRA SEPPI IRAWAN', 'P.2.02.0004715.13.01', 'NASI BODAS', 'JL.RAYA KALIABANG TENGAH NO.22A', 'BEKASI UTARA', 'KALIABANG TENGAH', '003', '006', 2, 6, 8000, 4856000, 10.00, '087878788701', '2022_RESTORAN_0152801132022.jpeg', 0, 1, '-6.179110264311233', '106.99911385774614', 14, '2022-01-13 11:36:07', '2022-03-17 09:00:43', NULL);
INSERT INTO `restorans` VALUES (1529, 3, 'RENDRA SEPPI IRAWAN', 'P.2.02.0004715.13.01', 'NASI BODAS', 'JL.RAYA KALIABANG TENGAH NO.22A', 'BEKASI UTARA', 'KALIABANG TENGAH', '003', '006', 2, 6, 13000, 9165000, 10.00, '087878788701', '2022_RESTORAN_0152901132022.jpeg', 0, 4, '-6.2061911', '107.0039218', 14, '2022-01-13 11:36:51', '2022-01-13 11:37:51', '2022-01-13 11:37:51');
INSERT INTO `restorans` VALUES (1530, 1, 'MUHAMMAD ALI ARIYANSYAH', 'P.2.02.0003915.12.05', 'ABUBA KALIMALANG / PT. ABUBA', 'JL.KH.NOER ALI BLOK.A10', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 14, 56, 70000, 558250000, 10.00, '08561800559', '2022_RESTORAN_0153002022022.jpg', 1, 1, '-6.231346884462741', '106.98040008544923', 11, '2022-01-14 08:10:01', '2022-04-12 11:37:51', NULL);
INSERT INTO `restorans` VALUES (1531, 1, 'NIKO WIJASIN', 'P.2.02.0003767.12.05', 'RM. TEKKO / CV.UTAMA RASA PRIMA', 'RUKO GRAND KOTA BINTANG KH. NOER ALI', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 15, 172, 150000, 472125000, 10.00, '081213669425', '2022_RESTORAN_0153101262022.jpg', 1, 1, '-6.226910039683643', '106.95911407470705', 11, '2022-01-14 08:15:35', '2022-04-12 11:38:56', NULL);
INSERT INTO `restorans` VALUES (1532, 3, 'IBU MELIANA', 'P.2.02.0003743.12.05', 'WARUNG SEBLAK JELETET', 'JL.KH.NOER ALI', 'BEKASI BARAT', 'JAKASAMPURNA', '002', '016', 3, 44, 20000, 12510000, 10.00, '087887717022', '2022_RESTORAN_0153201312022.jpg', 0, 1, '-6.233053353236314', '106.96941375732422', 11, '2022-01-14 08:19:39', '2022-04-12 11:42:19', NULL);
INSERT INTO `restorans` VALUES (1533, 1, 'JEO SASANTO', 'P.2.02.0003504.12.05', 'PIZZA HUT KOTA BINTANG / PT.SARIMELATI KENCANA', 'JL.KH.NOER ALIE B WALK KALIMALANG UNIT 3 KAWASAN GRAND KOTA BINTANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 35, 120, 195000, 1056412500, 10.00, '081389630994', '2022_RESTORAN_0153301262022.jpg', 0, 1, '-6.230323000534752', '106.9680404663086', 11, '2022-01-14 08:25:23', '2022-04-12 11:43:59', NULL);
INSERT INTO `restorans` VALUES (1534, 2, 'SETO HARYO AJI WICAKSONO', 'P.2.02.0003452.12.05', 'WARUNG UPNORMAL / PT.CITA RASA FAVORIT', 'JL.KH.NOER ALIE NO.86-86D KALIMALANG CAMAN RT.002/016', 'BEKASI BARAT', 'JAKASAMPURNA', '002', '016', 6, 33, 35000, 153387500, 10.00, '089508537735', '2022_RESTORAN_0153402022022.jpg', 1, 1, '-6.232712059925625', '106.97490692138673', 11, '2022-01-14 08:30:12', '2022-04-12 11:48:07', NULL);
INSERT INTO `restorans` VALUES (1535, 3, 'SYAIPUL ANWAR', 'P.2.02.0003424.12.05', 'BAKSO MUKIDI', 'JL.BINTARA RAYA RT.013/05', 'BEKASI BARAT', 'JAKASAMPURNA', '013', '005', 6, 32, 35000, 3570000, 10.00, '081314840960', '2022_RESTORAN_0153501312022.jpg', 0, 1, '-6.2258861471022175', '106.97422027587892', 11, '2022-01-14 08:32:48', '2022-04-12 11:48:18', NULL);
INSERT INTO `restorans` VALUES (1536, 3, 'SULARNO', 'P.2.02.0003296.12.05', 'SINAR MINANG', 'JL.CEMARA RAYA BLOK.A1 NO.4', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 2, 32, 20000, 1030000, 10.00, '081387371329', '2022_RESTORAN_0153601282022.jpg', 0, 1, '-6.2299817054481945', '106.97353363037111', 11, '2022-01-14 08:34:40', '2022-04-12 11:50:34', NULL);
INSERT INTO `restorans` VALUES (1537, 3, 'KEMIS', 'P.2.02.0003255.12.05', 'WAHYU BAKERY', 'PATRIOT RAYA RUKO PATRIOT SQUARE KAV.04', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 4, 2, 20000, 3730000, 10.00, '081315494958', '2022_RESTORAN_0153701272022.jpg', 0, 1, '-6.240220461451296', '106.97353363037111', 11, '2022-01-14 08:36:19', '2022-04-12 11:50:47', NULL);
INSERT INTO `restorans` VALUES (1538, 1, 'HM. TOHIR MUSTADO', 'P.2.02.0001103.13.06', 'RM. SATE ANDA', 'JL. KALIABANG BUNGUR RT 03/18', 'BEKASI UTARA', 'HARAPANJAYA', '003', '018', 17, 80, 53000, 508164000, 10.00, '082122038848', '2022_RESTORAN_0153801142022.jpg', 0, 1, '-6.198024305001334', '106.98779493570329', 14, '2022-01-14 08:36:48', '2022-02-15 12:00:48', NULL);
INSERT INTO `restorans` VALUES (1539, 2, 'PT. REKSO NASIONAL FOOD (MCD KOTA BINTANG)', 'P.2.08.0003106.12.05', 'PT. REKSO NASIONAL FOOD (MCD KOTA BINTANG)', 'JL. KH. NOER ALI KP. DUA RT.04/02 KEL. JAKASAMPURNA KEC. BEKASI BARAT', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 08:55:06', '2022-01-14 09:41:52', '2022-01-14 09:41:52');
INSERT INTO `restorans` VALUES (1540, 2, 'CV. DIRONT CATERING', 'P.2.02.0002778.12.05', 'CV. DIRONT CATERING', 'JL.KH.NOER ALIE NO.68 G-H', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 08:58:00', '2022-01-14 09:43:10', '2022-01-14 09:43:10');
INSERT INTO `restorans` VALUES (1541, 1, 'SUKOWATI SOSRODJOJO', 'P.2.02.0002737.12.05', 'MC DONAL JAKASAMPURNA', 'JL. KH. NOER ALI KP. DUA RT.04/02 KEL. JAKASAMPURNA KEC. BEKASI BARAT', 'BEKASI BARAT', 'JAKASAMPURNA', '004', '002', 20, 112, 230000, 2153950000, 10.00, '085777992004', '2022_RESTORAN_0154102032022.jpg', 1, 1, '-6.231688178661465', '106.97765350341798', 11, '2022-01-14 09:00:31', '2022-04-12 11:53:28', NULL);
INSERT INTO `restorans` VALUES (1542, 3, 'DAVID SUSANTO', 'P.2.02.0001959.11.02', 'SAUNG KEPITING', 'JL. M. HASIBUAN NO. 11', 'BEKASI TIMUR', 'MARGAHAYU', '001', '024', 3, 24, 30000, 15240000, 10.00, '087878363713', '2022_RESTORAN_0154201142022.jpg', 0, 1, '-6.250341701740784', '106.99916481971742', 10, '2022-01-14 09:02:15', '2022-04-14 08:34:55', NULL);
INSERT INTO `restorans` VALUES (1543, 2, 'PAUW JOE MAY / MARIA', 'P.2.02.0002259.12.05', 'RM.PONDOK KENANGA', 'JL.KENANGA RAYA NO.9', 'BEKASI BARAT', 'JAKASAMPURNA', '001', '006A', 15, 16, 50000, 88000000, 10.00, '087883973462', '2022_RESTORAN_0154301312022.jpg', 0, 1, '-6.229640410139697', '106.98246002197267', 11, '2022-01-14 09:02:44', '2022-04-12 11:56:28', NULL);
INSERT INTO `restorans` VALUES (1544, 3, 'YEK HUA', 'P.2.02.0002123.12.05', 'RM. TENDA BIRU', 'JL.BUKIT BARISAN GALAXI RAYA NO.87C', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 3, 16, 20000, 1120000, 10.00, '081317489277', '2022_RESTORAN_0154402022022.jpg', 0, 1, '-6.222131857228453', '106.96941375732422', 11, '2022-01-14 09:05:29', '2022-04-12 11:56:48', NULL);
INSERT INTO `restorans` VALUES (1545, 1, 'PT.WANATA JAYA CIPTA', 'P.2.02.0002346.13.05', 'NANNYS PAVILLON', 'SUMMARECON MALL BEKASI FB.109', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 16, 46, 95000, 573752500, 10.00, '021 29572705', '2022_RESTORAN_0154501142022.jpeg', 1, 1, '-6.222537151176969', '107.00200796127321', 14, '2022-01-14 09:06:09', '2022-02-15 12:03:00', NULL);
INSERT INTO `restorans` VALUES (1546, 2, 'CV.MUSTIKKA (CATERING)', 'P.2.02.0001887.12.05', 'CV.MUSTIKKA (CATERING)', 'JL.BOROBUDUR 1 BLOK.D JAKASAMPURNA', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 09:11:11', '2022-01-14 09:44:42', '2022-01-14 09:44:42');
INSERT INTO `restorans` VALUES (1547, 1, 'PT.PANCA BOGA PARAMITA', 'P.2.02.0003694.13.05', 'ICHIBAN SUSHI', 'JL.BOULEVAR A.YANI BLOK.M LT.1F UNIT 136', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 18, 80, 88000, 566104000, 10.00, '021 89454300', '2022_RESTORAN_0154701142022.jpeg', 1, 1, '-6.226451421378377', '107.00101017951967', 14, '2022-01-14 09:11:52', '2022-02-15 12:04:02', NULL);
INSERT INTO `restorans` VALUES (1548, 3, 'TJIN TJIE FEN', 'P.2.02.0003016.11.02', 'RM 889 CHINESSE FOOD', 'JL. MAYOR OKING NO. 65', 'BEKASI TIMUR', 'MARGAHAYU', '004', '001', 2, 24, 30000, 15525000, 10.00, '081255502999', '2022_RESTORAN_0154801142022.jpg', 0, 1, '-6.242556149651', '107.00268387794496', 10, '2022-01-14 09:13:31', '2022-04-18 10:15:18', NULL);
INSERT INTO `restorans` VALUES (1549, 2, 'CATERING BKR GELORA', 'P.2.02.0001854.12.05', 'CATERING BKR GELORA', 'JL.AL FATAH KP.DUA RT.01/02 JAKA SAMPURNA', 'BEKASI BARAT', 'JAKASAMPURNA', '01', '02', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 09:13:34', '2022-01-14 09:44:23', '2022-01-14 09:44:23');
INSERT INTO `restorans` VALUES (1550, 2, 'WULAN CATERING', 'P.2.02.0001837.12.05', 'WULAN CATERING', 'JL.PERSADA KEMALA BLOK 7/5', 'BEKASI BARAT', 'JAKASAMPURNA', '005', '013', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 09:15:48', '2022-01-14 09:49:30', '2022-01-14 09:49:30');
INSERT INTO `restorans` VALUES (1551, 2, 'DAPUR MENAK CATERING', 'P.2.02.0001828.12.05', 'DAPUR MENAK CATERING', 'KOMP.PUSKOPAD PERMAI BLOK.A NO.39 RT.001/017', 'BEKASI BARAT', 'JAKASAMPURNA', '001', '017', NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 09:18:15', '2022-04-08 10:22:07', '2022-04-08 10:22:07');
INSERT INTO `restorans` VALUES (1552, 2, 'OKTAF FANTIHE IRWAN', 'P.2.02.0002103.13.05', 'REST. EXCELSO MULTIRASA', 'SUMARECON MALL BEKASI LANTAI DASAR FB-107', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, 48, 50000, 234375000, 10.00, '08118968664', '2022_RESTORAN_0155201262022.jpg', 1, 1, '-6.226078127113293', '107.00078487396242', 14, '2022-01-14 09:18:43', '2022-02-15 12:17:17', NULL);
INSERT INTO `restorans` VALUES (1553, 2, 'PIZZA HUT KALIMALANG', 'P.2.02.0000059.12.05', 'PIZZA HUT KALIMALANG', 'JL.RAYA KALIMALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 11, '2022-01-14 09:20:27', '2022-01-14 09:25:56', '2022-01-14 09:25:56');
INSERT INTO `restorans` VALUES (1554, 2, 'DONNY/CV DOWER JUANDA BERJAYA', 'P.2.02.0004314.11.02', 'BEBEK DOWER', 'JL. IR. H. JUANDA TRANSPARK BEKASI', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 6, 26, 25000, 16087500, 10.00, '083806066421', '2022_RESTORAN_0155401142022.jpg', 0, 1, '-6.24984', '107.0165', 10, '2022-01-14 09:21:40', '2022-04-14 08:35:37', NULL);
INSERT INTO `restorans` VALUES (1555, 3, 'MARYANTO', 'P.2.02.0005295.13.01', 'BAKSO SBY', 'PERMATA HIJAU PERMAI BLOK BR NO. 11 RT. 010/017', 'BEKASI UTARA', 'KALIABANG TENGAH', '010', '017', 6, 18, 7000, 5330500, 10.00, NULL, '2022_RESTORAN_0155501142022.jpeg', 0, 1, '-6.203453333493536', '107.00442463159563', 14, '2022-01-14 09:30:09', '2022-02-03 11:03:33', NULL);
INSERT INTO `restorans` VALUES (1556, 2, 'PT TRANS BURGER INDONESIA', 'P.2.02.0004884.11.02', 'WENDYS', 'JL. IR. H. JUANDA TRANSPARK BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 4, 18, 25000, 36500000, 10.00, NULL, '2022_RESTORAN_0155601142022.jpg', 0, 1, '-6.24984', '107.0165', 10, '2022-01-14 09:35:06', '2022-04-14 08:35:56', NULL);
INSERT INTO `restorans` VALUES (1557, 3, 'EDWARD TIRTANATA', 'P.2.02.0005503.11.03', 'KOPI KENANGAN SUPERINDO CREWED', 'JL. KARANG SATRIA NO. 88', 'BEKASI TIMUR', 'DURENJAYA', '003', '007', 2, 0, 15000, 183750000, 10.00, '08170994001', '2022_RESTORAN_0155701142022.jpg', 0, 1, '-', '-', 10, '2022-01-14 09:57:26', '2022-04-18 09:10:25', NULL);
INSERT INTO `restorans` VALUES (1558, 2, 'ARIANTO HENDRY', 'P.2.02.0005222.20.01', 'BEBEK BKB', 'CENTRA KULINER MELI MELO 3', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 11, 40, 60000, 68580000, 10.00, '081280577531', '2022_RESTORAN_0155801142022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-14 10:13:38', '2022-04-11 13:51:43', NULL);
INSERT INTO `restorans` VALUES (1559, 2, 'YUNUS CIPTAWILANGGA', 'P.2.02.0032340.03.03', 'RAJA SUNDA', 'JL JEND SUDIRMAN KM 34 NO 1', 'MEDANSATRIA', 'HARAPANMULYA', '0', '0', 15, 90, 180000, 695700000, 10.00, '02188852777', '2022_RESTORAN_0155901142022.jpeg', 1, 1, NULL, NULL, 16, '2022-01-14 10:34:02', '2022-04-11 13:56:52', NULL);
INSERT INTO `restorans` VALUES (1560, 2, 'SUKOWATI SOSRODJOJO', 'P.2.02.0000840.20.02', 'MC\'DONALDS GRANDMALL', 'GRANDMALL BEKASI', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 15, NULL, 110000, 467500000, 10.00, '08111927437', NULL, 0, 1, NULL, NULL, 16, '2022-01-14 10:50:55', '2022-04-11 14:02:43', NULL);
INSERT INTO `restorans` VALUES (1561, 2, 'EDWARD TIRTANATA/PT BUMI BERKAH BOGA', 'P.2.02.0005451.11.02', 'KOPI KENANGAN BULAK KAPAL', 'JL. HM JOYOMARTONO NO. 8', 'BEKASI TIMUR', 'MARGAHAYU', '008', '013', 2, 0, 15000, 171375000, 10.00, NULL, '2022_RESTORAN_0156101142022.jpg', 0, 1, '-6.2517494878351565', '107.02355146408082', 10, '2022-01-14 10:51:03', '2022-04-18 10:30:57', NULL);
INSERT INTO `restorans` VALUES (1562, 3, 'JIMMY WANTONO', 'P.2.02.0005613.13.01', 'ROTI O', 'JL. PONDOK UNGU PERMAI BLOK GG4/20 RT.001/RW.022', 'BEKASI UTARA', 'KALIABANG TENGAH', '001', '022', 1, 5, 12000, 10686000, 10.00, NULL, '2022_RESTORAN_0156201142022.jpg', 0, 1, '-6.180062248978045', '107.00172632932664', 14, '2022-01-14 11:19:39', '2022-02-15 12:18:43', NULL);
INSERT INTO `restorans` VALUES (1563, 2, 'JIMMY SURYA SUSANTO', 'P.2.02.0005077.20.01', 'RM TELAGA SEAFOOD', 'CENTRA CULINER MELIMELO 3', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 18, 60, 110000, 188650000, 10.00, '082250959988', '2022_RESTORAN_0156301142022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-14 11:21:31', '2022-04-11 14:10:43', NULL);
INSERT INTO `restorans` VALUES (1564, 3, 'MIAN LIAN', 'P.2.02.0004940.13.06', 'ROPANG OTW', 'JL.CEMARA PERMAI NO.162', 'BEKASI UTARA', 'HARAPANJAYA', '002', '010', 3, 20, 20000, 16352000, 10.00, '081385490048', '2022_RESTORAN_0156401142022.jpeg', 0, 1, '-6.214903173860447', '106.98603004217149', 14, '2022-01-14 11:36:13', '2022-02-15 12:20:06', NULL);
INSERT INTO `restorans` VALUES (1565, 2, 'PT CHAMP RESTO INDONESIA', 'P.2.02.0004930.20.01', 'GOKANA', 'COURTS KOTA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 14, 80, 100000, 238500000, 10.00, '085710096661', '2022_RESTORAN_0156501142022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-14 11:37:53', '2022-04-11 14:14:15', NULL);
INSERT INTO `restorans` VALUES (1566, 2, 'PT CHAMP RESTO INDONESIA', 'P.2.02.0004931.20.01', 'RAA CHA', 'COURTS KOTA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 13, 80, 110000, 249370000, 10.00, '085710096661', '2022_RESTORAN_0156601142022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-14 11:47:28', '2022-04-11 14:24:01', NULL);
INSERT INTO `restorans` VALUES (1567, 2, 'RIZKI YANUARSYAH', 'P.2.02.0004815.20.01', 'CAFE XXI COURTS', 'COURTS KOTA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 4, 12, 50000, 223300000, 10.00, '02188899021', '2022_RESTORAN_0156701142022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-14 11:49:46', '2022-04-11 14:28:06', NULL);
INSERT INTO `restorans` VALUES (1568, 3, 'SUKOTJO', 'P.2.02.0004191.13.05', 'HOKAIDO ICE CREAM PUFF', 'SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '000', 4, NULL, 35000, 39462500, 10.00, NULL, '2022_RESTORAN_0156801142022.jpeg', 0, 1, '-6.225747494828353', '107.00111746788026', 14, '2022-01-14 15:25:37', '2022-05-24 10:59:41', NULL);
INSERT INTO `restorans` VALUES (1569, 3, 'KONTA BUNYAMIN', 'P.2.02.0002935.13.05', 'PAPABUNZ', 'JL.BULEVAR MALL SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, 2, 40000, 40500000, 10.00, '085101552700', '2022_RESTORAN_0156901142022.jpeg', 0, 1, '-6.225976804338411', '107.00096189975739', 14, '2022-01-14 15:31:15', '2022-03-29 11:46:34', NULL);
INSERT INTO `restorans` VALUES (1570, 3, 'ANITA SAPUTRA', 'P.2.02.0004265.13.05', 'HOLDAK', 'BOULEVARD SUMMARECON MALL LT.2', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 8, 24, 35000, 47600000, 10.00, '021 29572506', '2022_RESTORAN_0157001142022.jpeg', 0, 1, '-6.225864815985541', '107.0005488395691', 14, '2022-01-14 15:37:52', '2022-02-15 12:22:15', NULL);
INSERT INTO `restorans` VALUES (1571, 2, 'KUSNADI PRAHARDJA', 'P.2.02.0003522.13.05', 'PEPPER LUNCH', 'JL.BOULEVARD BLOK.M SUMMARECON MALL BEKASI LT.2F-102 & 2F-1C15', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 18, 45, 80000, 538400000, 10.00, NULL, '2022_RESTORAN_0157101142022.jpeg', 1, 1, '-6.225720830925347', '107.00110137462617', 14, '2022-01-14 15:46:33', '2022-02-15 12:24:20', NULL);
INSERT INTO `restorans` VALUES (1572, 2, 'PT.FOODS BEVERAGES INDONESIA', 'P.2.02.0002351.13.05', 'CHATIME', 'BULEVAR A.YANI SUMMARECON MALL LANTAI GF UNIT NO.1', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 12, NULL, 45000, 670950000, 10.00, NULL, '2022_RESTORAN_0157201142022.jpeg', 1, 1, '-6.225528850783666', '107.00123012065889', 14, '2022-01-14 15:53:44', '2022-02-15 12:25:31', NULL);
INSERT INTO `restorans` VALUES (1573, 3, 'DONNY WAHYU HIDAYAT', 'P.2.02.0001171.13.01', 'REST DONS BURGER', 'RUKO PONDOK UNGU PERMAI BLOK BB 1 NO 23', 'BEKASI UTARA', 'KALIABANG TENGAH', '013', '010', 3, 2, 20000, 31970000, 10.00, '021 888777619', '2022_RESTORAN_0157301172022.jpeg', 0, 1, '-6.17843827410359', '107.00088679790498', 14, '2022-01-17 09:02:53', '2022-02-15 12:26:30', NULL);
INSERT INTO `restorans` VALUES (1574, 3, 'M.TEGUH SANTOSO', 'P.2.02.0002866.13.01', 'RM SATE ANDA', 'PONDOK UNGU PERMAI BLK.C.1/7', 'BEKASI UTARA', 'KALIABANG TENGAH', '003', '018', 5, 20, 25000, 35062500, 10.00, '021 888977701', '2022_RESTORAN_0157401172022.jpeg', 0, 1, '-6.176390298685035', '107.0004951953888', 14, '2022-01-17 09:15:35', '2022-02-15 12:27:31', NULL);
INSERT INTO `restorans` VALUES (1575, 1, 'PT. SARI MELATI KENCANA', 'P.2.02.0002035.13.05', 'PIZZA HUT SUMMARECON', 'BOULEVARD A. YANI SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 120, 125000, 1160000000, 10.00, '08113249363', '2022_RESTORAN_0157501172022.jpeg', 1, 1, '-6.225811488190076', '107.00103163719179', 14, '2022-01-17 09:31:44', '2022-02-15 12:28:47', NULL);
INSERT INTO `restorans` VALUES (1576, 3, 'MAULANA HAKIM', 'P.2.02.0005309.13.03', 'TEGUK DUTA HARAPAN', 'DUTA BOULEVARD BARAT RT/RW. 001/011', 'BEKASI UTARA', 'HARAPANBARU', '001', '011', 4, NULL, 10000, 15005000, 10.00, NULL, '2022_RESTORAN_0157601172022.jpeg', 0, 1, '-6.212127397044769', '107.02143251895906', 14, '2022-01-17 09:50:02', '2022-02-03 11:04:44', NULL);
INSERT INTO `restorans` VALUES (1577, 3, 'NAUFAL MUZAKKI AZHAR', 'P.2.02.0005548.13.05', 'TRAFFIC BUN SUMMARECON MALL BEKASI', 'SUMMARECON MALL BEKASI LANTAI GF-135A JL. BULEVAR AHMAD YANI BLOK M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 9, 4, 25000, 29750000, 10.00, '081295332241', '2022_RESTORAN_0157701172022.jpeg', 0, 1, '-6.225854150426878', '107.00098872184755', 14, '2022-01-17 09:58:26', '2022-03-28 09:54:02', NULL);
INSERT INTO `restorans` VALUES (1578, 1, 'PT.SARI MELATI KENCANA', 'P.2.02.0001909.13.06', 'PHD KALI ABANG', 'JL.KALI ABANG TENGAH NO.77', 'BEKASI UTARA', 'HARAPANJAYA', '001', '020', 17, NULL, 75000, 600787500, 10.00, '08113248525', '2022_RESTORAN_0157801172022.jpeg', 0, 1, '-6.201994754217926', '107.00033426284791', 14, '2022-01-17 10:09:52', '2022-03-28 10:16:25', NULL);
INSERT INTO `restorans` VALUES (1579, 2, 'MUHAMMAD PRIYADI', 'P.2.02.0004735.13.05', 'PIZZA MARZANO', 'BOULEVAR AHMAD YANI MALL SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 11, 30, 120000, 280500000, 10.00, '021 29572516', '2022_RESTORAN_0157901172022.jpeg', 1, 1, '-6.226078127113293', '107.00099945068361', 14, '2022-01-17 10:15:40', '2022-03-28 10:31:09', NULL);
INSERT INTO `restorans` VALUES (1580, 3, 'AGUS ERWIN WIJAYA', 'P.2.02.0005538.21.04', 'SEAFOOD LEGENDARIS', 'PERUM DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 1, 1, 15000, 660000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:23:44', '2022-06-30 07:37:57', NULL);
INSERT INTO `restorans` VALUES (1581, 1, 'WIDRA YONI S.KOM', 'P.2.02.0005559.21.04', 'MEENUM BEKASI TIMUR REGENCY', 'BEKASI TIMUR REGENCY', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 2, 4, 10000, 455000, 10.00, NULL, NULL, 0, 4, '-6.309156193767633', '107.02022552490236', 17, '2022-01-17 10:26:12', '2022-06-30 07:37:01', NULL);
INSERT INTO `restorans` VALUES (1582, 3, 'FAUZI KURNIAWAN', 'P.2.02.0005579.21.01', 'STEAKY STEAK BEKASI', '.RUKO GRAND WISATA', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 3, 6, 20000, 1740000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:28:14', '2022-05-23 08:09:18', NULL);
INSERT INTO `restorans` VALUES (1583, 3, 'EDWHIN SETIAWAN', 'P.2.02.0005576.21.01', 'FUKU ICHI GRAND WISATA', 'RUKO GRAND WISATA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 1, 15000, 1230000, 10.00, NULL, NULL, 0, 4, '-6.305743748658542', '107.02022552490236', 17, '2022-01-17 10:30:32', '2022-06-30 07:35:58', NULL);
INSERT INTO `restorans` VALUES (1584, 3, 'RICKI PRASATYA', 'P.2.02.0005577.21.03', 'PENGEN AYAM GEPREK', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 3, 10, 15000, 2272500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:31:57', '2022-06-30 07:34:58', NULL);
INSERT INTO `restorans` VALUES (1585, 1, 'PT.SARI BURGER INDONESIA', 'P.2.02.0004117.13.05', 'BURGER KING', 'JL.BOULEVARD TIMUR VA NO.22', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 18, 60, 81000, 886950000, 10.00, '021 89459698', '2022_RESTORAN_0158501172022.jpeg', 1, 1, '-6.224691603234402', '107.00308084487916', 14, '2022-01-17 10:32:36', '2022-02-15 12:32:05', NULL);
INSERT INTO `restorans` VALUES (1586, 3, 'INDRIATI LESTARI MANURUNG', 'P.2.02.0005583.21.01', 'KOPI DARI HATI CIKETING', 'JALAN RAYA ASEM', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 4, 10000, 455000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:33:14', '2022-06-30 07:34:39', NULL);
INSERT INTO `restorans` VALUES (1587, 1, 'ABDUL MALIK FAJAR BAHARI', 'P.2.02.0005583.21.01', 'SOTO AYAM SURABAYA', 'PERUM MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 1, 10000, 455000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:35:12', '2022-06-30 07:33:51', NULL);
INSERT INTO `restorans` VALUES (1588, 3, 'MOH ALIN MAGHRIBI', 'P.2.02.0005616.21.01', 'RM. WARBET BU OOM', 'JALAN GONDANG', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 1, 15000, 682500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:36:40', '2022-06-30 07:33:02', NULL);
INSERT INTO `restorans` VALUES (1589, 3, 'ANDI JUADI', 'P.2.02.0005617.21.01', 'PECEL LELE SINAR CIREMAI', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 1, 10000, 455000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:37:57', '2022-06-30 07:30:44', NULL);
INSERT INTO `restorans` VALUES (1590, 1, 'DWI ANRIANI', 'P.2.02.0005624.21.04', 'WARUNG PRAMBANAN', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 2, 10000, 470000, 10.00, NULL, NULL, 0, 4, '-6.2444029', '107.0057722', 17, '2022-01-17 10:39:48', '2022-06-30 07:30:01', NULL);
INSERT INTO `restorans` VALUES (1591, 1, 'SUPARMAN', 'P.2.02.0005631.21.03', 'DAPUR ASAP MAMA VIKA', 'PERUM DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 1, 1, 15000, 682500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:40:59', '2022-06-30 07:29:10', NULL);
INSERT INTO `restorans` VALUES (1592, 3, 'DEDE SUNARYA', 'P.2.02.0005632.21.01', 'SOTO MIE BOGOR PAK DEDE', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 1, 4, NULL, 0, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:42:28', '2022-06-30 07:28:08', NULL);
INSERT INTO `restorans` VALUES (1593, 1, 'HENDRICK KRISTANTO', 'P.2.02.0005640.21.01', 'SEIKO W COFFEE', 'JALAN ASEM JAYA NO 40', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 4, 15000, 138337500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:43:39', '2022-06-30 07:27:16', NULL);
INSERT INTO `restorans` VALUES (1594, 3, 'HARDIANTO CATUR PAMUNGKAS', 'P.2.02.0005650.21.01', 'WARUNG BEBEBK MADU 88', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 4, 10000, 455000, 10.00, NULL, NULL, 0, 4, '-6.311886133676643', '107.01816558837892', 17, '2022-01-17 10:44:49', '2022-06-30 07:26:09', NULL);
INSERT INTO `restorans` VALUES (1595, 3, 'YUNADIE AHSAN', 'P.2.02.0005675.21.01', 'TJANGKIR KOPI', 'JALAN RAYA MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 3, 10000, 455000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:45:58', '2022-06-30 07:24:56', NULL);
INSERT INTO `restorans` VALUES (1596, 3, 'LEILA FLORENTINA', 'P.2.02.0005676.21.01', 'ES TEH INDONESIA MUTIARA GADING TIMUR', 'PERUMAHAN MUTIARA GADING TIMUR', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 2, 2, 15000, 682500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:47:06', '2022-06-30 07:23:59', NULL);
INSERT INTO `restorans` VALUES (1597, 3, 'ABDUR ROFIEQ', 'P.2.02.0005677.21.04', 'ES TEH INDONESIA DUKUH ZAMRUD', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 3, 2, 15000, 682500, 10.00, NULL, NULL, 0, 4, '-6.3173459703266115', '107.01953887939455', 17, '2022-01-17 10:48:19', '2022-06-30 07:22:18', NULL);
INSERT INTO `restorans` VALUES (1598, 2, 'ASEP NURDIN TOHA', 'P.2.02.0005678.21.03', 'SAUNG KOPI( NYOPEE )', 'JALAN CIMANNGIS', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 2, 4, 10000, 1355000, 10.00, NULL, NULL, 0, 4, '-6.327732297405808', '106.99785053730011', 17, '2022-01-17 10:50:01', '2022-05-20 08:22:59', NULL);
INSERT INTO `restorans` VALUES (1599, 1, 'FACHRIZAL HUDA', 'P.2.02.0005679.21.04', 'BAKSO ACI MANTAN ZAMRUD', 'PERUM DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 2, 4, 15000, 877500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-01-17 10:51:24', '2022-06-30 07:17:30', NULL);
INSERT INTO `restorans` VALUES (1600, 1, 'GABY OLIVIA', 'P.2.02.0005702.21.03.', 'PEMPEK GABY / PT', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 4, 10, 25000, 14125000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 17, '2022-01-17 10:52:25', '2022-06-27 10:59:33', NULL);
INSERT INTO `restorans` VALUES (1601, 2, 'JENITA RAHMAYANTI', 'P.2.02.0005735.21.04', 'STREET BOBA & LAIN HATI', 'PERUMAHAN DUKUH ZAMRUD', 'MUSTIKAJAYA', 'CIMUNING', NULL, NULL, 2, 8, 20000, 4200000, 10.00, NULL, NULL, 0, 4, '-6.315298538330033', '107.02091217041017', 17, '2022-01-17 10:53:34', '2022-06-30 08:39:58', NULL);
INSERT INTO `restorans` VALUES (1602, 1, 'PT KURNIA BOGA NARAYAN / WILLIAM', 'P.2.02.00005736.21.03', 'JANJI JIWA JILID 463 / PT', 'PERUM DUKUH ZAMRUD BLOK B', 'MUSTIKAJAYA', 'PADURENAN', NULL, NULL, 3, 2, 15000, 3150000, 10.00, NULL, NULL, 0, 4, '-6.31826304661537', '107.02311158180238', 17, '2022-01-17 10:55:42', '2022-06-30 08:38:08', NULL);
INSERT INTO `restorans` VALUES (1603, 2, 'EDWARD SUBRATA H. KUSUMA', 'P.2.02.0002041.13.05', 'TAMANI CAFE', 'SUMMARECON MALL BEKASI LT.DASAR FB-117 JL. BOULEVARD AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 30, 40, 63000, 94815000, 10.00, '021 29572370', '2022_RESTORAN_0160301172022.jpeg', 0, 1, '-6.225870148764796', '107.0011067390442', 14, '2022-01-17 11:10:12', '2022-03-28 10:38:14', NULL);
INSERT INTO `restorans` VALUES (1604, 2, 'MICHAEL FEBRIANTO', 'P.2.02.0004138.13.05', 'PHO STREET KITCHEN', 'JL.BOULEVARD SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 11, 16, 75000, 217200000, 10.00, '081387892882', '2022_RESTORAN_0160401172022.jpeg', 1, 1, '-6.225843484867998', '107.00107455253602', 14, '2022-01-17 11:25:50', '2022-03-28 10:46:57', NULL);
INSERT INTO `restorans` VALUES (1605, 3, 'STENLY RAMON MARCELUS', 'P.2.02.0004187.13.05', 'FRITATO', 'MALL SUMMARECON LT.DASAR', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, 20, 10000, 36200000, 10.00, '081284962637', '2022_RESTORAN_0160501172022.jpeg', 1, 1, '-6.225747494828353', '107.00120329856874', 14, '2022-01-17 11:38:53', '2022-03-28 10:54:38', NULL);
INSERT INTO `restorans` VALUES (1606, 2, 'CHRISTOPHER ADITYA', 'P.2.02.0002135.13.05', 'FIESTA STEAK', 'SUMMARECON MALL BEKASI BLK. FB-103', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 15, 28, 110000, 455400000, 10.00, '021 29572424', '2022_RESTORAN_0160601172022.jpeg', 1, 1, '-6.226323434803093', '107.00082242488863', 14, '2022-01-17 11:52:57', '2022-03-28 11:00:58', NULL);
INSERT INTO `restorans` VALUES (1607, 1, 'JOHANES PAULUS ARIFIN', 'P.2.02.0004325.13.05', 'HOKA-HOKA BENTO', 'JL.BOULEVARD TIMUR BLOK.WA NO.19', 'BEKASI UTARA', 'MARGAMULYA', '003', '002', 31, 70, 150000, 1765500000, 10.00, '021 89464957', '2022_RESTORAN_0160701172022.jpeg', 1, 1, '-6.22529954107803', '107.00329542160036', 14, '2022-01-17 11:53:26', '2022-03-17 09:23:58', NULL);
INSERT INTO `restorans` VALUES (1608, 1, 'MARIANY', 'P.2.02.0004198.13.05', 'GYU KAKU JAPANESE', 'DWONTOAN WALK UNIT FB 102-FBI 102 SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 23, 90, 185000, 995300000, 10.00, '021 29572518', '2022_RESTORAN_0160802032022.jpeg', 1, 1, '-6.226728725517812', '107.00087606906892', 14, '2022-01-17 12:07:06', '2022-03-28 11:07:02', NULL);
INSERT INTO `restorans` VALUES (1609, 3, 'DAHNIAR NASUTION', 'P.2.02.0003968.13.05', 'GEPREK BENSU', 'JL.PERJUANGAN NO.48 RT.003/009', 'BEKASI UTARA', 'MARGAMULYA', '003', '009', 4, 28, 16000, 50592000, 10.00, '081340168155', '2022_RESTORAN_0160901172022.jpeg', 0, 1, '-6.223577048693812', '107.0111382007599', 14, '2022-01-17 14:18:15', '2022-03-28 11:12:14', NULL);
INSERT INTO `restorans` VALUES (1610, 2, 'MARYANI', 'P.2.02.0004144.13.05', 'SHABU SHABU ON YASAI', 'DWONTOAN WALK UNIT FB 102-FBI 102 JL.BOULEVARD A.YANI BLOK.M,K', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 17, 80, 100000, 316820000, 10.00, '021 29572546', '2022_RESTORAN_0161001172022.jpeg', 1, 1, '-6.226547411289362', '107.00057566165925', 14, '2022-01-17 14:37:53', '2022-03-29 08:36:35', NULL);
INSERT INTO `restorans` VALUES (1611, 1, 'ZAINAL ARIFIN', 'P.2.02.0002067.13.05', 'SOLARIA SUMMARECON', 'BOULEVAR AHMAD YANI SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 21, 115, 135000, 1155600000, 10.00, '0811173020', '2022_RESTORAN_0161101172022.jpeg', 1, 1, '-6.225854150426878', '107.00136691331866', 14, '2022-01-17 14:47:29', '2022-03-29 08:44:46', NULL);
INSERT INTO `restorans` VALUES (1612, 2, 'IBIN BACHTIAR', 'P.2.02.0002242.13.05', 'THE DUCK KING', 'JL.BULEVAR AHMAD YANI, SUMMARECON MALL LT.DW UNIT 122,123 &AMP; GF 143', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 25, 100, 70000, 312900000, 10.00, '081262323360', '2022_RESTORAN_0161201172022.jpeg', 1, 1, '-6.226008801006283', '107.00129181146623', 14, '2022-01-17 15:11:59', '2022-03-29 08:59:16', NULL);
INSERT INTO `restorans` VALUES (1613, 2, 'ALVIN ADHITYA ARIF', 'P.2.02.0002247.13.05', 'MUJIGAE SUMMARECON MALL', 'SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 13, 80, 70000, 359702000, 10.00, '082113010503', '2022_RESTORAN_0161301172022.jpeg', 1, 1, '-6.2266434011828045', '107.001069188118', 14, '2022-01-17 15:20:04', '2022-03-29 09:08:35', NULL);
INSERT INTO `restorans` VALUES (1614, 1, 'JEONG SOOWON', 'P.2.02.0003514.13.05', 'TOUS LES JOURS', 'SUMMARECON MALL BEKASI JL.BOULEVARD AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 14, 16, 55000, 849750000, 10.00, '021 29572491', '2022_RESTORAN_0161401172022.jpeg', 1, 1, '-6.2268247153781', '107.00032621622088', 14, '2022-01-17 15:32:12', '2022-03-29 09:13:41', NULL);
INSERT INTO `restorans` VALUES (1615, 2, 'TAN PO LIAN', 'P.2.02.0005601.13.04', 'DUNKIN', 'JL. LINGKAR UTARA', 'BEKASI UTARA', 'TELUK PUCUNG', '008', '037', 10, 30, 56000, 185864000, 10.00, NULL, '2022_RESTORAN_0161501172022.jpeg', 0, 1, '-6.207263752810436', '107.02037572860718', 14, '2022-01-17 15:32:19', '2022-03-29 09:19:02', NULL);
INSERT INTO `restorans` VALUES (1616, 2, 'HENDRY H.BATUBARA', 'P.2.02.0003829.13.05', 'KRISPY KREME', 'FOOD HALL F &AMP; B 03 SUMARECON MALL BEKASI JL.BOULEVARD AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, 15, 50000, 207750000, 10.00, '021 29572519', '2022_RESTORAN_0161601172022.jpeg', 1, 1, '-6.227144681452389', '107.00076878070833', 14, '2022-01-17 15:46:01', '2022-03-29 09:24:13', NULL);
INSERT INTO `restorans` VALUES (1617, 2, 'ALI GUNAWAN BUDIMAN', 'P.2.02.0002883.13.05', 'BAKSO MALANG KARAPITAN', 'JL.BOULEVARD AHMAD YANI BLOK M LT.2 NO.101A', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, 68, 55000, 114152500, 10.00, '021 29572473', '2022_RESTORAN_0161701172022.jpeg', 1, 1, '-6.2262914381543935', '107.00113356113435', 14, '2022-01-17 15:55:34', '2022-03-29 09:43:35', NULL);
INSERT INTO `restorans` VALUES (1618, 1, 'SUMARNO NGADIMAN', 'P.2.02.0003693.13.05', 'TA WAN SUMMARECON', 'JL.BOULEVARD A.YANI BLOK.M LT.1F UNIT 136A', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 22, 96, 110000, 679360000, 10.00, '089602788628', '2022_RESTORAN_0161801172022.jpeg', 1, 1, '-6.2262914381543935', '107.00097262859344', 14, '2022-01-17 16:05:05', '2022-03-29 09:56:24', NULL);
INSERT INTO `restorans` VALUES (1619, 3, 'TOKO LIUS', 'P.2.02.0003151.20.03', 'TOKO LIUS', 'HARAPAN INDAH SEKTOR TIMUR BLOK CA/07A', 'MEDANSATRIA', 'PEJUANG', '00', '00', 4, 12, 20000, 14820000, 10.00, '0218873693', '2022_RESTORAN_0161901182022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-18 08:04:32', '2022-06-06 14:22:32', NULL);
INSERT INTO `restorans` VALUES (1620, 2, 'JCO DONUTS & COFFE', 'P.2.02.0001712.20.01', 'JCO DONUTS & COFFE', 'HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', NULL, 10, 110000, 503250000, 10.00, '089680219361', '2022_RESTORAN_0162001182022.jpeg', 0, 4, '-6.2443883', '107.0057698', 16, '2022-01-18 08:08:00', '2022-04-22 10:16:26', '2022-04-22 10:16:26');
INSERT INTO `restorans` VALUES (1621, 2, 'AGUNG WAHYU ISLAMI', 'P.2.02.0004842.20.02', 'KOPI KENANGAN', 'JL JEND. SUDIRMAN', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 3, 5, 40000, 130200000, 10.00, '081213020630', '2022_RESTORAN_0162101182022.jpeg', 0, 1, '-6.2443884', '107.0057702', 16, '2022-01-18 08:12:41', '2022-06-06 14:26:40', NULL);
INSERT INTO `restorans` VALUES (1622, 2, 'JAG GROUP', 'P.2.02.0003794.20.02', 'JCO DONUTS & COFFE', 'SUMARECON BEKASI', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 30, 50, 150000, 960000000, 10.00, '02189456391', '2022_RESTORAN_0162201182022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-18 08:24:44', '2022-06-06 14:36:31', NULL);
INSERT INTO `restorans` VALUES (1623, 2, 'BENNY LIONG', 'P.2.02.0004340.20.02', 'POCHAJJANG', 'SUMARECON BEKASI', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 8, 12, 110000, 84150000, 10.00, '081380385511', '2022_RESTORAN_0162301182022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-18 08:29:35', '2022-06-06 14:33:04', NULL);
INSERT INTO `restorans` VALUES (1624, 2, 'GUFRON SYARIF', 'P.2.02.0005288.20.03', 'HAUS / PT INSPIRASI BISNIS NUSANTARA', 'SENTRA NIAGA BLOK B 8 /48', 'MEDANSATRIA', 'PEJUANG', '00', '00', 7, 5, 30000, 118050000, 10.00, '08872277256', '2022_RESTORAN_0162401182022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-18 08:51:21', '2022-06-06 14:32:31', NULL);
INSERT INTO `restorans` VALUES (1625, 1, 'AMALDA RAMDHANI', 'P.2.02.0005210.20.03', 'MARTABAK ORIENT', 'JL BOULEVARD HIJAU RAYA BLOK B8 NO 7', 'MEDANSATRIA', 'PEJUANG', '00', '00', 4, 4, 35000, 24150000, 10.00, '081290311268', '2022_RESTORAN_0162501182022.jpeg', 0, 4, NULL, NULL, 16, '2022-01-18 08:56:32', '2022-06-06 14:40:06', NULL);
INSERT INTO `restorans` VALUES (1626, 3, 'SUSAN', 'P.2.02.0002595.20.02', 'RM MANADO CAKALANG', 'BOULEVARD HIJAU BLOK C1/33', 'MEDANSATRIA', 'PEJUANG', '00', '00', 3, 10, 15000, 8947500, 10.00, '081319012730', '2022_RESTORAN_0162601182022.jpeg', 0, 4, NULL, NULL, 16, '2022-01-18 09:00:35', '2022-06-06 14:31:21', NULL);
INSERT INTO `restorans` VALUES (1627, 2, 'ANGGIT MURDIWIBOWO', 'P.2.02.0005134320.01', 'BEND AND BREAK KITCHEN AND LOUNGE', 'JL SENTRA KULINER MELI MELO 2 BLOK I N', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 24, 85, 40000, 76000000, 10.00, '082211145733', '2022_RESTORAN_0162701182022.jpeg', 0, 4, NULL, NULL, 16, '2022-01-18 09:04:40', '2022-05-18 09:11:58', NULL);
INSERT INTO `restorans` VALUES (1628, 2, 'EDWARD TIRTANATA', 'P.2.02.0004975.20.01', 'KOPI KENANGAN', 'MALL LIVING PLAZA', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 5, 6, 40000, 211040000, 10.00, '08170018187', '2022_RESTORAN_0162801182022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-18 09:11:42', '2022-06-06 14:28:14', NULL);
INSERT INTO `restorans` VALUES (1629, 2, 'SLAMET ADI SUSANTO', 'P.2.02.0005102.13.05', 'SEI SAPI KANA', 'JL. BULEVAR SELATAN RUKO EMERALD COMMERCIAL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, 20, 45000, 45900000, 10.00, '085253136161', '2022_RESTORAN_0162901182022.jpeg', 1, 1, '-6.2267073944353575', '107.00297355651857', 14, '2022-01-18 09:17:10', '2022-03-29 10:02:47', NULL);
INSERT INTO `restorans` VALUES (1630, 1, 'PT. PASUNDAN BOGA MANDIRI', 'P.2.02.0003419.13.05', 'GUBUG MAKAN MANG ENGKING', 'JL. BULEVAR UTARA BLOK L', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 80, 150, 97000, 2856650000, 10.00, '081398127787', '2022_RESTORAN_0163001182022.jpeg', 1, 1, '-6.223814358351543', '107.00186043977739', 14, '2022-01-18 09:33:22', '2022-02-15 12:34:57', NULL);
INSERT INTO `restorans` VALUES (1631, 2, 'JANES SUDARTO', 'P.2.02.0004130.13.05', 'SHIHLIN TAIWAN STREET SNACKS', 'SUMMARECON MALL LT.3 NO.R05 S/D NO.R-05 O', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 7, 8, 35000, 140087500, 10.00, '087882340299', '2022_RESTORAN_0163101182022.jpeg', 1, 1, '-6.225726163706053', '107.00154125690462', 14, '2022-01-18 09:42:16', '2022-03-29 10:08:48', NULL);
INSERT INTO `restorans` VALUES (1632, 2, 'ISWADY SUSINDRA', 'P.2.02.0002128.13.05', 'YAMMIE HOTPLATE', 'SUMMARECON MALL BEKASI LT. III', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, 4, 35000, 200637500, 10.00, '021 29572639', '2022_RESTORAN_0163201182022.jpeg', 1, 1, '-6.225864815985541', '107.00144469738008', 14, '2022-01-18 09:55:11', '2022-03-29 10:19:32', NULL);
INSERT INTO `restorans` VALUES (1633, 1, 'DALIMIN JUWONO', 'P.2.02.0003464.13.04', 'KFC GOLDEN CITY', 'GOLDEN CITY VILLA INDAH PERMAI', 'BEKASI UTARA', 'TELUK PUCUNG', '008', '037', 21, 100, 100000, 1336300000, 10.00, '082125113700', '2022_RESTORAN_0163301182022.jpeg', 0, 1, '-6.207778383957948', '107.02089339494708', 14, '2022-01-18 10:00:27', '2022-03-17 10:36:09', NULL);
INSERT INTO `restorans` VALUES (1634, 2, 'ISWADY SUSINDRA', 'P.2.02.0002129.13.05', 'DONER KEBAB', 'SUMMARECON MALL BEKASI LT. III', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, NULL, 50000, 254250000, 10.00, '021 29572632', '2022_RESTORAN_0163401182022.jpeg', 1, 1, '-6.226056796004414', '107.0013749599457', 14, '2022-01-18 10:08:52', '2022-03-29 10:27:23', NULL);
INSERT INTO `restorans` VALUES (1635, 3, 'RIZKY AGUNG KUMORO', 'P.2.02.0005734.16.02', 'MENANTEA', 'JL.JATIBENING 2 NO.225 RT.003/RW.003', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 4, 6, 2, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 10:11:09', '2022-01-18 10:12:58', '2022-01-18 10:12:58');
INSERT INTO `restorans` VALUES (1636, 3, 'RIZKY AGUNG KUMORO', 'P.2.02.0005734.16.02', 'MENANTEA', 'JL.JATIBENING 2 NO.225 RT.003/RW.003', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 4, 6, 20000, 0, 0.00, NULL, NULL, 2, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 10:15:06', '2022-01-18 10:16:13', '2022-01-18 10:16:13');
INSERT INTO `restorans` VALUES (1637, 3, 'MADSURI HANDJAJA. M.SC', 'P.2.02.0005468.13.0', 'BAKSO RUSUK SOLO GOLDEN CITY BEKASI', 'RUKO GREEN WOOD BLOK C 1 NO. 16 JL. NUSANTARA RAYA', 'BEKASI UTARA', 'KALIABANG TENGAH', '008', '037', 5, 60, 25000, 49425000, 10.00, '021 8880777', '2022_RESTORAN_0163701182022.jpeg', 0, 1, '-6.208079696261734', '107.02163636684419', 14, '2022-01-18 10:15:08', '2022-03-29 10:30:10', NULL);
INSERT INTO `restorans` VALUES (1638, 2, 'EDWARD TIRTANATA', 'P.2.02.0005459.13.05', 'CHIGO', 'JL. BOULEVARD RAYA MALL SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, 4, 48500, 124523750, 10.00, '08170739162', '2022_RESTORAN_0163801182022.jpeg', 0, 1, '-6.225384865631351', '107.00178802013399', 14, '2022-01-18 10:21:46', '2022-03-29 10:33:16', NULL);
INSERT INTO `restorans` VALUES (1639, 3, 'EKO', 'P.2.02.0003959.13.04', 'AYAM GEPREK JUARA', 'JL.RAYA PERJUANGAN NO.21-22', 'BEKASI UTARA', 'TELUK PUCUNG', '02', '034', 4, 10, 17000, 22856500, 10.00, '0895376890894', '2022_RESTORAN_0163901182022.jpeg', 0, 1, '-6.221926543727364', '107.02549070119859', 14, '2022-01-18 10:26:35', '2022-03-17 10:37:53', NULL);
INSERT INTO `restorans` VALUES (1640, 2, 'EDWARD DJAJA', 'P.2.02.0004702.13.05', 'GOLDEN LAMIAN SMB', 'JL.BOULEVARD AHMAD YANI SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 11, 8, 30000, 174000000, 10.00, '08119566003', '2022_RESTORAN_0164001182022.jpeg', 0, 1, '-6.225608842517886', '107.00148224830629', 14, '2022-01-18 10:32:02', '2022-03-29 10:41:20', NULL);
INSERT INTO `restorans` VALUES (1641, 3, 'MAMUN', 'P.2.02.0001694.13.04', 'RM.PECEL LELE LELA', 'JL.PERJUANGAN RAYA NO.09', 'BEKASI UTARA', 'TELUK PUCUNG', '001', '034', 4, 10, 15000, 9150000, 10.00, '08776607608', '2022_RESTORAN_0164101202022.jpeg', 0, 1, '-6.2221105259593505', '107.02451437711719', 14, '2022-01-18 10:43:34', '2022-02-15 12:36:08', NULL);
INSERT INTO `restorans` VALUES (1642, 3, 'RIZKI AMALIA', 'P.2.02.0005179.13.04', 'FOODPEDIA ONE N ONLY', 'RUKO GREENWOOD BLOK C2 NO. 16', 'BEKASI UTARA', 'TELUK PUCUNG', '006', '037', 3, 30, 12000, 11862000, 10.00, '082211438853', '2022_RESTORAN_0164201182022.jpeg', 0, 1, '-6.203645321689933', '107.02209502458574', 14, '2022-01-18 10:58:33', '2022-02-15 12:37:07', NULL);
INSERT INTO `restorans` VALUES (1643, 3, 'WONG SIAN TZEN', 'P.2.02.0002175.13.05', 'REST. KOI TEPPANYAKI', 'SUMMARECON MALL BEKASI LT.II R.12', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 50, 45500, 147533750, 10.00, '08788474-77', '2022_RESTORAN_0164301182022.jpeg', 1, 1, '-6.2259074782180175', '107.00113356113435', 14, '2022-01-18 10:59:39', '2022-03-30 10:37:26', NULL);
INSERT INTO `restorans` VALUES (1644, 2, 'RM.MANG KABAYAN', 'P.2.02.0004040.17.01', 'RM. MANG KABAYAN', 'JL.TIRTA RAYA VIDA BEKASI', 'BANTARGEBANG', 'BANTARGEBANG', '001', '005', 5, 12, 35800, 115455000, 10.00, '02182626200', '2022_RESTORAN_0164401252022.jpg', 1, 1, '-6.333383907200814', '106.97902679443361', 13, '2022-01-18 11:07:08', '2022-04-14 09:54:35', NULL);
INSERT INTO `restorans` VALUES (1645, 3, 'RIZKY AGUNG KUMORO', 'P.2.02.0005734.16.02', 'MENANTEA', 'JL.JATIBENING 2 NO.225 RT.003/RW.003', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 6, 10000, 4150000, 10.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-04-25 10:21:50', '2022-04-25 10:21:50');
INSERT INTO `restorans` VALUES (1646, 2, 'REKO SETYO PRABOWO', 'P.2.02.0005733.16.01', 'BOLEKAKA PUSAT DIMSUM INDONESIA / PT. FOODINA RETAIL INDONESIA', 'JL. RAYA JATIWARINGIN NO. 19-238', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 10, 40000, 123000000, 10.00, NULL, '2022_RESTORAN_0164604272022.png', 0, 1, '-6.27502984481357', '106.91252595497453', 18, '2022-01-18 11:17:10', '2022-06-27 12:32:39', NULL);
INSERT INTO `restorans` VALUES (1647, 3, 'UJANG SUGANDI', 'P.2.02.0005723.16.02', 'WARUNG NASI WARGI SUNDA', 'JL. CAMAN RAYA JATIBENING RT. 002 RW. 003', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 6, 25, 20000, 21250000, 10.00, NULL, '2022_RESTORAN_0164704272022.png', 0, 1, '-6.2598779566099125', '106.94878585252219', 18, '2022-01-18 11:17:10', '2022-05-31 11:27:44', NULL);
INSERT INTO `restorans` VALUES (1648, 2, 'SITI ROCHMAT HIDAYATI', 'P.2.02.0005722.16.04', 'NYAPII JATI CEMPAKA', 'JL. RAYA JATIWARINGIN NO. 12 RT. 006 RW. 005', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 10, 20, 100000, 139000000, 10.00, NULL, NULL, 0, 1, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-06-27 14:16:16', NULL);
INSERT INTO `restorans` VALUES (1649, 2, 'SULIANTO', 'P.2.02.0005712.16.01', 'CHICK AND WHIZ / PT. HARMONIS KULINER INDONESIA', 'JL. RAYA JATIWARINGIN NO. 3 RT. 008 RW. 015', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 40, 30000, 79875000, 10.00, NULL, '2022_RESTORAN_0164904272022.jpeg', 0, 1, '-6.271515861855718', '106.91195252305432', 18, '2022-01-18 11:17:10', '2022-06-02 14:27:55', NULL);
INSERT INTO `restorans` VALUES (1650, 2, 'SULIANTO', 'P.2.02.0005711.16.02', 'CHICK AND WHIZ / PT. HARMONIS KULINER INDONESIA', 'JL. CAMAN RAYA NO. 88 D RT. 013 RW. 008', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 10, 40, 30000, 79875000, 10.00, NULL, '2022_RESTORAN_0165004272022.jpeg', 0, 1, '-6.265736489894389', '106.94373963562221', 18, '2022-01-18 11:17:10', '2022-06-02 14:28:44', NULL);
INSERT INTO `restorans` VALUES (1651, 2, 'EDWARD TIRTANATA', 'P.2.02.0005688.16.02', 'KOPI KENANGAN SUPERINDO JATIBENING/PT.BUMI BERKAH BOGA', 'DR.RATNA RT.001/RW.001', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1652, 2, 'KOPI KENANGAN JATIMAKMUR/PT.BUMI BERKAH BOGA', 'P.2.02.0005687.16.03', 'KOPI KENANGAN JATIMAKMUR/PT.BUMI BERKAH BOGA', 'RAYA JATIMAKMUR BLOK A NO.13', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1653, 2, 'WILLIAM', 'P.2.02.0005661.16.05', 'JANJI JIWA JILID 26 / PT. KURNIA BOGA NARAYAN', 'JL. KINCAN RAYA NO. 22 RT. 001 RW. 002', 'PONDOK GEDE', 'JATIBARU', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, NULL, NULL, 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1654, 2, 'WILLIAM', 'P.2.02.0005659.16.01', 'JANJI JIWA JILID 194 / PT. KURNIA BOGA NARAYAN', 'JL. RAYA JATIWARINGIN NO. 2 RT. 003 RW. 003', 'PONDOK GEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2763813', '106.9135676', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1655, 2, 'ELISA SUTEJA', 'P.2.02.0005646.16.01', 'FORE COFFEE/PT.FORE KOPI INDONESIA', 'RAYA JATIWARINGIN NO.53 RT.002/RW.002', 'PONDOK GEDE', 'JATIWARINGIN', NULL, NULL, 8, 20, 150, 0, 0.00, NULL, NULL, 0, 4, '-6.2763813', '106.9135676', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1656, 3, 'CV LALEINA ABADI', 'P.2.02.0005489.16.04', 'CV LALEINA ABADI', 'JL. MERAK BLOK A2 NO. 20', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 5, 10, 75, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-04-27 13:31:15', '2022-04-27 13:31:15');
INSERT INTO `restorans` VALUES (1657, 3, 'SUKARTINI', 'P.2.02.0005598.16.01', 'SABANA JATIWARINGIN', 'JL. RAYA GAMPRIT', 'PONDOK GEDE', 'JATIWARINGIN', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2763813', '106.9135676', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1658, 3, 'WILLIAM WINATA', 'P.2.02.0005567.16.04', 'TRAFFIC BUNN', 'JL. RAYA JATIWARINGIN RT. 001 RW. 006', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 6, 10, 100, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1659, 3, 'ANKUSH GROVER', 'P.2.02.0005566.16.03', 'BROS FRIED CHICKEN / PT. REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5-58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1660, 3, 'ANKUSH GROVER', 'P.2.02.0005565.16.03', 'OVEN STORY / PT. REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5-58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1661, 3, 'ANKUSH GROVER', 'P.2.02.0005564.16.03', 'BOOM BURGER / PT. REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5-58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1662, 3, 'ALFIAN AFDAL MALIK', 'P.2.02.0005563.16.04', 'COTTA COFFEE', 'JL. KEMANG RAYA NO. 19 B RT. 002 RW. 002', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1663, 3, 'WINDIANTO', 'P.2.08.0005561.16.05', 'PT. ADHI COMMUTER PROPERTI', 'JL. KAPIN RT. 009 RW. 004', 'PONDOK GEDE', 'JATIBARU', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, NULL, NULL, 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1664, 3, 'WINCE SUDARTO', 'P.2.02.0005535.16.02', 'SHIHLIN TAIWAN STREET SNACKS/CV. REJEKI ABADI', 'REST AREA KM 6B', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1665, 3, 'FREDI LINNEN', 'P.2.02.0005533.16.01', 'COFFEE FIRST', 'JL. JATIWARINGIN NO.25 RT 002/ RW 006', 'PONDOK GEDE', 'JATIWARINGIN', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2763813', '106.9135676', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1666, 2, 'M. DEDY SURYADI', 'P.2.02.0005532.16.01', 'WARUNG BAKMI DKI', 'RUKO PASAR PONDOK GEDE', 'PONDOK GEDE', 'JATIWARINGIN', NULL, NULL, 8, 40, 100, 0, 0.00, NULL, NULL, 0, 4, '-6.2763813', '106.9135676', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1667, 2, 'RIO ARPAN SAPUTRA', 'P.2.02.0005531.16.04', 'KEBULI GAZA', 'JL. RAYA JATIWARINGIN RT 007/ RW 005', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 6, 15, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1668, 3, 'POINT CAFE INDOMARET/PT. INDOMARCO PRISMATAMA', 'P.2.02.0005495.16.03', 'POINT CAFE INDOMARET/PT. INDOMARCO PRISMATAMA', 'DUTA INDAH RAYA NO. 3 RT. 006/020', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 6, 20, 100, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1669, 2, 'KOPI KENANGAN SPBU JATIWARINGIN', 'P.2.02.0005485.16.01', 'KOPI KENANGAN SPBU JATIWARINGIN', 'JL. RAYA JATIWARINGIN NO. 234 RT. 003/006', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 4, 125000, 271562500, 10.00, NULL, '2022_RESTORAN_0166906102022.jpg', 0, 4, '-6.279882195618675', '106.91373869498658', 18, '2022-01-18 11:17:10', '2022-06-30 08:20:17', NULL);
INSERT INTO `restorans` VALUES (1670, 3, 'ALI SUSANTO', 'P.2.02.0005482.16.03', 'ROTI O / PT. SEBASTIAN CITRA INDONESIA', 'JL. RAYA JATI MAKMUR NO. 14 RT. 004 RW. 007', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1671, 3, 'ANGGARA SOEKOWATI LUKMANA', 'P.2.02.0005481.16.05', 'SMOOLY JUICE', 'JL. CAMAN RAYA NO. 59 RT. 001 RW. 003', 'PONDOK GEDE', 'JATIBARU', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, NULL, NULL, 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1672, 2, 'LIBERTY SUNTORY', 'P.2.02.0005477.16.05', 'STARBUCKS / PT. SARI COFFEE INDONESIA', 'REST AREA JATI BENING BARU', 'PONDOK GEDE', 'JATIBARU', NULL, NULL, 15, 35, 200, 0, 0.00, NULL, NULL, 0, 4, NULL, NULL, 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1673, 3, 'MARBIO SUSTANU', 'P.2.02.0005465.16.05', 'YUMMY KITCHEN 32 PONDOK GEDE', 'JL. KINCAN RAYA NO. 22 RT. 001 RW. 002', 'PONDOK GEDE', 'JATIBARU', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, NULL, NULL, 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1674, 3, 'HADI SETIADARMA HO', 'P.2.02.0005458.16.03', 'FAMILY MART CLOUD KITCHEN / PT. FAJAR MITRA INDAH', 'JL. JATI MAKMUR KAV NO. 3 RT. 001 RW. 005', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1675, 3, 'SUPARJO', 'P.2.02.0005448.16.04', 'GOLD CHICKEN', 'JL RAYA JATIWARINGIN RT 001/ RW 010', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1676, 3, 'ALI MUHARAM', 'P.2.02.0005447.16.01', 'MAKARONI FOXTROT NGEHE', 'JL RAYA JATIWARINGIN NO 260 RT 001/ RW 004', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 2, 4, 30000, 28500000, 10.00, NULL, '2022_RESTORAN_0167606102022.jpg', 0, 1, '-6.270304536655078', '106.91205451924817', 18, '2022-01-18 11:17:10', '2022-06-29 15:11:58', NULL);
INSERT INTO `restorans` VALUES (1677, 2, 'M FARHAN FADHIILAH', 'P.2.02.0005446.16.03', 'TALK KOPI BEKASI', 'JL KEMANG SARI RAYA NO 4 RT 004/011', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1678, 2, 'STARBUCKS JATIWARINGIN/PT. SARI COFFE INDONESIA', 'P.2.02.0005434.16.04', 'STARBUCKS JATIWARINGIN/PT. SARI COFFE INDONESIA', 'JL. RAYA JATIWARINGIN', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 2, 4, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1679, 2, 'JAESAN GRILL', 'P.2.02.0005433.16.01', 'JAESAN GRILL', 'JL. RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 15, 35, 95000, 105925000, 10.00, NULL, '2022_RESTORAN_0167904272022.jpeg', 0, 1, '-6.27838916902864', '106.913323960036', 18, '2022-01-18 11:17:10', '2022-06-02 14:31:25', NULL);
INSERT INTO `restorans` VALUES (1680, 3, 'VETIKA RIANA', 'P.2.02.0005403.16.02', 'KOPI DARI HATI', 'JL. CAMAN RAYA NO. 57', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 20, 50, 80000, 89200000, 10.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-05-31 14:23:03', '2022-05-31 14:23:03');
INSERT INTO `restorans` VALUES (1681, 3, 'H. M. SHOLEH, SE', 'P.2.02.0005395.16.05', 'COFFEE KENYANG INC', 'JL. RAYA KEMANG SARI NO. 13 RT. 003 RW. 011', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 2, 4, 50000, 55750000, 10.00, NULL, '2022_RESTORAN_0168104272022.jpeg', 0, 4, '-6.269489577436821', '106.93940708643564', 18, '2022-01-18 11:17:10', '2022-06-06 08:10:27', '2022-06-06 08:10:27');
INSERT INTO `restorans` VALUES (1682, 2, 'JOHANNES PAULUS ARIFIN', 'P.2.02.0005380.16.02', 'HOKA HOKA BENTO KITCHEN JATIBENING', 'JL. RAYA JATIBENING II NO. 3 RT. 004 RW. 003', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 10, 40, 200000, 532500000, 10.00, NULL, '2022_RESTORAN_0168204272022.jpeg', 1, 1, '-6.2657391554300315', '106.94378308289392', 18, '2022-01-18 11:17:10', '2022-06-02 14:33:04', NULL);
INSERT INTO `restorans` VALUES (1683, 3, 'ZHEREND THERESA KEZIA', 'P.2.02.0005375.16.02', 'GILDAK', 'JL. CAMAN RAYA KOMPLEK RUKO APARTEMENT GRAND ICON RT. 008 RW. 001', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 5, 15000, 38812500, 10.00, NULL, '2022_RESTORAN_0168304272022.jpeg', 0, 1, '-6.252366281594579', '106.95260235989205', 18, '2022-01-18 11:17:10', '2022-06-27 14:17:00', NULL);
INSERT INTO `restorans` VALUES (1684, 3, 'LEO MAREN PRASASTI', 'P.2.02.0005367.16.01', 'GULU GULU', 'PLAZA PONDOK GEDE LT. 2 BLOK 2', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 20000, 5300000, 10.00, NULL, '2022_RESTORAN_0168404272022.jpeg', 0, 1, '-6.283785371384753', '106.91170866603026', 18, '2022-01-18 11:17:10', '2022-06-02 14:34:46', NULL);
INSERT INTO `restorans` VALUES (1685, 3, 'ADI SUGIARTO TIRTORAHARDJO', 'P.2.02.0005325.16.01', 'KEDAI KOPI KULO', 'JL. PONDOK GEDE RAYA NO. 1', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 5000, 12937500, 10.00, NULL, '2022_RESTORAN_0168504272022.jpeg', 0, 1, '-6.283753378578544', '106.91167147561103', 18, '2022-01-18 11:17:10', '2022-06-27 14:18:30', NULL);
INSERT INTO `restorans` VALUES (1686, 3, 'EDWARD DJAJA', 'P.2.02.0005313.16.01', 'HEY KAFE / PT. TUJUH RITEL INDONESIA', 'JL. JATIWARINGIN RAYA NO. 209A.', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 28000, 72450000, 10.00, NULL, '2022_RESTORAN_0168604272022.jpeg', 0, 4, '-6.260419197788717', '106.91040513880733', 18, '2022-01-18 11:17:10', '2022-06-30 08:23:14', NULL);
INSERT INTO `restorans` VALUES (1687, 3, 'EKA WIDYANINGSIH. A.', 'P.2.02.0005294.16.01', 'GILDAK', 'JL. RAYA JATIWARINGIN RT. 02/03', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 11000, 28462500, 10.00, NULL, '2022_RESTORAN_0168704272022.jpeg', 0, 1, '-6.2804171953254055', '106.91343070796341', 18, '2022-01-18 11:17:10', '2022-06-27 14:19:43', NULL);
INSERT INTO `restorans` VALUES (1688, 3, 'ALDIA PUTRA', 'P.2.02.0005293.16.02', 'AYAM PAHA DADA CAMAN JATIBENING', 'JL. CAMAN RAYA NO. 7 D RT. 007/003', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 5, 10000, 25875000, 10.00, NULL, '2022_RESTORAN_0168804272022.jpeg', 0, 1, '-6.259938390738358', '106.94876286870081', 18, '2022-01-18 11:17:10', '2022-06-27 14:22:16', NULL);
INSERT INTO `restorans` VALUES (1689, 3, 'WING FERGUUSANNY S', 'P.2.02.0005250.16.02', 'NARA COFFEE EASTON / PT. SAYAP BOGA WIDIPA', 'JL. JATIBENING NO. 225 RT. 003/003', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 5, 20000, 51750000, 10.00, NULL, '2022_RESTORAN_0168904272022.jpeg', 0, 1, '-6.2614056959359745', '106.94423288550877', 18, '2022-01-18 11:17:10', '2022-06-02 14:47:44', NULL);
INSERT INTO `restorans` VALUES (1690, 3, 'ALI SUSANTO', 'P.2.02.0005236.16.01', 'ROTI O / PT. SEBASTIAN CITRA INDONESIA', 'JL. RAYA JATIWARINGIN NO.192 005/003', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 15000, 38437500, 10.00, NULL, '2022_RESTORAN_0169004272022.jpeg', 0, 1, '-6.282223038149904', '106.9138922278402', 18, '2022-01-18 11:17:10', '2022-06-02 14:49:24', NULL);
INSERT INTO `restorans` VALUES (1691, 2, 'SELVY HAMZANO', 'P.2.02.0005234.16.01', 'SEÍ SAPI KANA / PT. KONGKOW KITCHEN', 'JL. RAYA JATIWARINGIN RT. 009/015', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 15, 30, 60000, 78900000, 10.00, NULL, '2022_RESTORAN_0169104272022.jpeg', 0, 1, '-6.277179637114968', '106.91292325923521', 18, '2022-01-18 11:17:10', '2022-06-02 14:52:04', NULL);
INSERT INTO `restorans` VALUES (1692, 3, 'LANNY ISKANDAR', 'P.2.02.0005229.16.02', 'XI BOBA', 'JL. RATNA NO. 56 RT. 01/01', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 5, 8000, 20700000, 10.00, NULL, '2022_RESTORAN_0169204272022.jpeg', 0, 1, '-6.263039190951698', '106.94571340113943', 18, '2022-01-18 11:17:10', '2022-06-27 14:22:34', NULL);
INSERT INTO `restorans` VALUES (1693, 2, 'RUMAH MAKAN REVINA ABAH WIRO', 'P.2.02.0005219.16.01', 'RUMAH MAKAN REVINA ABAH WIRO', 'JL. RAYA JATIWARINGIN NO. 39', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 20, 50, 13000, 14495000, 10.00, NULL, '2022_RESTORAN_0169304272022.jpeg', 0, 1, '-6.277418699767013', '106.913243682384', 18, '2022-01-18 11:17:10', '2022-06-02 14:56:04', NULL);
INSERT INTO `restorans` VALUES (1694, 3, 'MULYANI', 'P.2.02.0005216.16.02', 'BANG BUY COFFEE', 'KOMP. SENTRA KOTA JATIBENING BLOK C. 12 RT. 001/003', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 5, 50000, 129375000, 10.00, NULL, '2022_RESTORAN_0169404272022.jpeg', 0, 1, '-6.266835845627364', '106.94215611901491', 18, '2022-01-18 11:17:10', '2022-06-27 14:23:26', NULL);
INSERT INTO `restorans` VALUES (1695, 3, 'HOLY ANGEL SIWU', 'P.2.02.0005212.16.01', 'DUM DUM', 'COUNTER LANTAI DASAR PLAZA PONDOK GEDE 2 (DEPAN KFC)', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 50000, 129375000, 10.00, NULL, '2022_RESTORAN_0169504272022.jpeg', 0, 1, '-6.283753378578544', '106.91166608315257', 18, '2022-01-18 11:17:10', '2022-05-17 16:02:34', NULL);
INSERT INTO `restorans` VALUES (1696, 2, 'DANIEL IVAN', 'P.2.02.0005181.16.04', 'CV. OMG JATIWARINGIN', 'JL. JATIWARINGIN RAYA 48 RT. 001/01', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 10, 40, 55000, 146437500, 10.00, NULL, '2022_RESTORAN_0169604272022.jpeg', 0, 1, '-6.268924350620187', '106.91181814687386', 18, '2022-01-18 11:17:10', '2022-06-02 14:59:26', NULL);
INSERT INTO `restorans` VALUES (1697, 3, 'LUKI DANARDI', 'P.2.02.0005158.16.02', 'NYAPII', 'CAMAN RAYA RT 02/03', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 5, 50000, 129375000, 10.00, NULL, '2022_RESTORAN_0169704272022.jpeg', 0, 4, '-6.2588461298092595', '106.94927759691679', 18, '2022-01-18 11:17:10', '2022-05-24 10:47:14', '2022-05-24 10:47:14');
INSERT INTO `restorans` VALUES (1698, 3, 'DARMAWAN ALAN AR', 'P.2.02.0005151.16.05', 'KUPA NGUPI', 'KOMPLEK SENTRA KOTA BLOK C7', 'PONDOK GEDE', 'JATIBARU', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, NULL, NULL, 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1699, 3, 'MERRY CH MARPAUNG', 'P.2.02.0005148.16.02', 'STREET BOBA', 'JL. CAMAN RAYA BLOK. C NO. 100 RT. 003/03', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1700, 2, 'ANDI YOHANES', 'P.2.02.0005138.16.04', 'RAMPA RAMPA', 'JL. JATIWARINGIN RAYA NO.52A RT.001/04', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 10, 40, 200, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1701, 3, 'DARMADI KURNIAWAN', 'P.2.02.0005137.16.04', 'OVER GOOD', 'JL.RAYA JATIWARINGIN NO.147 RT.07/09', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1702, 3, 'ANKUSH GROVER', 'P.2.02.0005116.16.03', 'KOPI FEELING BREW / PT REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5-58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1703, 3, 'ANKUSH GROVER', 'P.2.02.0005115.16.03', 'NASI AYAM AMBYAR / PT REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5-58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1704, 2, 'ANKUSH GROVER', 'P.2.02.0005114.16.03', 'BURGER BROS / PT REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5-58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 15, 8, 150, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1705, 2, 'ANKUSH GROVER', 'P.2.02.0005113.16.03', 'BOX & CO / PT REBEL GOFOOD INDONESIA', 'JL. JATI MAKMUR 5- 58', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 15, 8, 150, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1706, 3, 'ISTANBUL KEBAB', 'P.2.02.0005111.16.04', 'ISTANBUL KEBAB', 'JL. RAYA JATIWARINGIN NO. 9C RT.01/04', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1707, 3, 'AYAM PODOMORO', 'P.2.02.0005110.16.04', 'AYAM PODOMORO', 'JL. RAYA JATIWARINGIN RT. 03/01', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1708, 3, 'ES TEH INDONESIA', 'P.2.02.0005109.16.04', 'ES TEH INDONESIA', 'JL. RAYA JATIWARINGIN NO. 57A RT. 007/009', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1709, 2, 'RM. FISH STREAT', 'P.2.02.0005105.16.01', 'RM. FISH STREAT', 'JL. JATIWARINGIN NO. 57.C RT. 07/09', 'PONDOK GEDE', 'JATIWARINGIN', NULL, NULL, 15, 30, 150, 0, 0.00, NULL, NULL, 0, 4, '-6.2763813', '106.9135676', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1710, 2, 'DINO ARIO', 'P.2.02.0005096.16.03', 'NGIKAN JATIMAKMUR', 'JALAN RAYA JATIMAKMUR', 'PONDOK GEDE', 'JATIMAKMUR', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2823959', '106.9208923', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1711, 3, 'RM. STREET BOBA', 'P.2.02.0005094.16.01', 'RM. STREET BOBA', 'JL. RAYA JATIWARINGIN NO. 165 RT. 01/02', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 5, 18000, 5787000, 10.00, NULL, '2022_RESTORAN_0171106102022.jpg', 0, 1, '-6.270671577570294', '106.91183077545033', 18, '2022-01-18 11:17:10', '2022-06-29 15:15:46', NULL);
INSERT INTO `restorans` VALUES (1712, 3, 'KALIBRASI COFFE & EATERY', 'P.2.02.0005093.16.02', 'KALIBRASI COFFE & EATERY', 'JL. KEMANG SARI NO. 65', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1713, 2, 'DE HALU CAFE', 'P.2.02.0005092.16.01', 'DE HALU CAFE', 'JL. JATIWARINGIN NO. 227 RT. 001/004', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 15, 30, 125000, 117500000, 10.00, NULL, '2022_RESTORAN_0171306102022.jpg', 1, 1, '-6.2707382322506255', '106.91216285445222', 18, '2022-01-18 11:17:10', '2022-06-27 14:24:23', NULL);
INSERT INTO `restorans` VALUES (1714, 3, 'RM. ROPANG OTW SENTRA KOTA', 'P.2.02.0005091.16.02', 'RM. ROPANG OTW SENTRA KOTA', 'KOMPLEK SENTRA KOTA UTAMA NO. C03 RT.001/003', 'PONDOK GEDE', 'JATIBENING', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.2607384', '106.9402406', 18, '2022-01-18 11:17:10', '2022-01-18 11:17:10', NULL);
INSERT INTO `restorans` VALUES (1715, 3, 'WOY MAKARONI', 'P.2.02.0005090.16.04', 'WOY MAKARONI', 'JL. RAYA JATIWARINGIN NO. 209A', 'PONDOK GEDE', 'JATICEMPAKA', NULL, NULL, 4, 5, 50, 0, 0.00, NULL, NULL, 0, 4, '-6.260635', '106.9069637', 18, '2022-01-18 11:17:10', '2022-04-25 10:20:07', '2022-04-25 10:20:07');
INSERT INTO `restorans` VALUES (1716, 2, 'SUHUD SETIA', 'P.2.02.0005290.13.05', 'CHANTEL FOOD SPACE / ASIAN VILLAGE', 'JL. BOULEVARD BCBD NO. 56A / 56 B', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, 72, 50000, 137750000, 10.00, NULL, '2022_RESTORAN_0171601182022.jpeg', 1, 1, '-6.223497056650201', '106.99741065502168', 14, '2022-01-18 11:17:49', '2022-03-30 10:47:48', NULL);
INSERT INTO `restorans` VALUES (1717, 3, 'MUHAMMAD SUBHI SE', 'P.2.02.0000640.13.04', 'RM. MA OMAH 1', 'JL.LINGKAR LUAR UTARA', 'BEKASI UTARA', 'HARAPANBARU', '008', '037', 5, 10, 15000, 16710000, 10.00, '081387226396', '2022_RESTORAN_0171701182022.jpeg', 0, 1, '-6.20871965102539', '107.02303379774095', 14, '2022-01-18 11:35:34', '2022-02-15 12:38:12', NULL);
INSERT INTO `restorans` VALUES (1718, 2, 'EDWARD KUSUMA', 'P.2.02.0003475.17.01', 'LITTLE TALK', 'JL.TIRTA UTAMA NO.10', 'BANTARGEBANG', 'BANTARGEBANG', '002', '004', 2, 10, 65000, 318987500, 10.00, '08210207585', '2022_RESTORAN_0171801182022.jpg', 0, 1, '-6.3190521574698915', '106.98177337646486', 13, '2022-01-18 12:02:31', '2022-05-25 15:15:04', NULL);
INSERT INTO `restorans` VALUES (1719, 3, 'LIOE TJU MIE', 'P.2.02.0004701.13.05', 'SAY CHIIZU HOKKAIDO CHEESE TOAST', 'BOULEVARD SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, NULL, 32000, 32928000, 10.00, NULL, '2022_RESTORAN_0171901182022.jpeg', 0, 1, '-6.226568742378317', '107.00089752674104', 14, '2022-01-18 14:13:49', '2022-03-30 10:59:07', NULL);
INSERT INTO `restorans` VALUES (1720, 3, 'MUH.ARIFIN', 'P.2.02.0002938.13.04', 'MASTER PENYET', 'JL.RAYA PERJUANGAN RUKO TAMAN WISMA ASRI BLOK.B27/39', 'BEKASI UTARA', 'TELUK PUCUNG', '002', '031', 3, 16, 11000, 4349400, 10.00, '08111046900', '2022_RESTORAN_0172001182022.jpeg', 0, 1, '-6.221915878088742', '107.0241764187813', 14, '2022-01-18 14:23:18', '2022-02-03 11:07:00', NULL);
INSERT INTO `restorans` VALUES (1721, 3, 'RENALDI SUSANTO', 'P.2.02.0004921.13.04', 'NINA CAFETARIA RS. AWAL BROS', 'JL.KALIABANG VILLA INDAH PERMAI', 'BEKASI UTARA', 'TELUK PUCUNG', '001', '033', 2, 10, 20000, 25414000, 10.00, '081316099010', '2022_RESTORAN_0172101182022.jpeg', 0, 1, '-6.207125095627716', '107.0185571908951', 14, '2022-01-18 14:33:48', '2022-03-17 10:39:55', NULL);
INSERT INTO `restorans` VALUES (1722, 3, 'FERDY HERMAWAN', 'P.2.02.0004867.13.04', 'COLD TAMAN WISMA ASRI', 'TAMAN WISMA ASRI KAVLING M', 'BEKASI UTARA', 'TELUK PUCUNG', '001', '015', 2, 2, 8000, 4615200, 10.00, NULL, '2022_RESTORAN_0172201182022.jpeg', 0, 1, '-6.218382873389548', '107.0242676138878', 14, '2022-01-18 14:48:13', '2022-03-30 11:07:58', NULL);
INSERT INTO `restorans` VALUES (1723, 3, 'NOOR HASAN DWIYANTO', 'P.2.02.0003957.13.04', 'BAKSO SRI RAJA', 'JL.MANGGA RAYA BLOK.R NO.3-4 RT.002/14', 'BEKASI UTARA', 'TELUK PUCUNG', '001', '014', 6, 14, 10000, 7300000, 10.00, '081387295524', '2022_RESTORAN_0172301182022.jpeg', 0, 1, '-6.217364297059867', '107.02482014894487', 14, '2022-01-18 15:00:40', '2022-03-30 11:16:50', NULL);
INSERT INTO `restorans` VALUES (1724, 3, 'NURYANTI', 'P.2.02.0003586.13.04', 'BAKSO TITOTI', 'JL.PERJUANGAN BLOK.M NO.01', 'BEKASI UTARA', 'TELUK PUCUNG', '001', '031', 13, 16, 10000, 13600000, 10.00, '085311737131', '2022_RESTORAN_0172401202022.jpeg', 0, 1, '-6.221870549122229', '107.0244660973549', 14, '2022-01-18 15:09:18', '2022-03-30 11:21:45', NULL);
INSERT INTO `restorans` VALUES (1725, 1, 'FEDRICK ESTRADA CADION', 'P.2.02.0004730.13.04', 'PIZZA HUT GOLDEN CITY BEKASI', 'KAVLING KOMERSIL GOLDEN CITY BLOK.B NO.1', 'BEKASI UTARA', 'TELUK PUCUNG', '008', '037', 35, 120, 95000, 1088833000, 10.00, '08113603265', '2022_RESTORAN_0172501182022.jpeg', 0, 1, '-6.2084210055657785', '107.02234178781511', 14, '2022-01-18 15:22:15', '2022-03-30 11:27:15', NULL);
INSERT INTO `restorans` VALUES (1726, 2, 'PT INDOMARCO PRISMATAMA', 'P.2.02.0004440.20.03', 'POINT CAFE', 'JL BOULEVAR HIJAU  HARAPAN INDAH', 'MEDANSATRIA', 'PEJUANG', '00', '00', 3, 10, 30000, 85725000, 10.00, NULL, '2022_RESTORAN_0172601192022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-19 09:04:42', '2022-06-06 14:28:45', NULL);
INSERT INTO `restorans` VALUES (1727, 2, 'RIZKI YANUARSYAH', 'P.2.02.0004815.20.01', 'CAFE XXI', 'COURTS MEGASTORE KOTA HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 4, 12, 40000, 120440000, 10.00, '02188899021', '2022_RESTORAN_0172701192022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-19 09:14:26', '2022-06-06 14:29:23', NULL);
INSERT INTO `restorans` VALUES (1728, 2, 'KLINSMAN', 'P.2.02.0004777.20.03', 'AYAM KEPRABON', 'JL BOULEVAR HIJAU', 'MEDANSATRIA', 'PEJUANG', '00', '00', 6, 13, 20000, 18290000, 10.00, '081280809773', '2022_RESTORAN_0172801192022.jpeg', 0, 1, NULL, NULL, 16, '2022-01-19 09:23:18', '2022-05-30 15:17:23', NULL);
INSERT INTO `restorans` VALUES (1729, 3, 'FERRY HELLYANTO SUSILA', 'P.2.02.0004411.13.05', 'COFFE JANJI JIWA', 'MALL SUMMARECON LT.2F IC-21', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, NULL, 15000, 23095500, 10.00, NULL, '2022_RESTORAN_0172901192022.jpeg', 0, 1, '-6.226059462393069', '107.00121670961381', 14, '2022-01-19 09:25:27', '2022-03-31 09:31:59', NULL);
INSERT INTO `restorans` VALUES (1730, 2, 'SUHAILI', 'P.2.02.0004017.20.03', 'SERBA SAMBAL', 'BOULEVAR HIJAU RAYA C5 NO 8', 'MEDANSATRIA', 'PEJUANG', '00', '00', 8, 20, 25000, 26250000, 10.00, '02188389599', NULL, 0, 1, NULL, NULL, 16, '2022-01-19 09:39:55', '2022-05-30 14:38:06', NULL);
INSERT INTO `restorans` VALUES (1731, 3, 'FERRY HELLYANTO SUSILA', 'P.2.02.0005178.13.05', 'JIWA TOAST', 'MALL SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, NULL, 20000, 38564000, 10.00, NULL, '2022_RESTORAN_0173101192022.jpeg', 0, 1, '-6.2488576', '106.9940736', 14, '2022-01-19 09:43:10', '2022-03-31 09:37:34', NULL);
INSERT INTO `restorans` VALUES (1732, 3, 'MARGONO', 'P.2.02.0003238.13.02', 'BEBEK TOP PAS 2', 'JL.KH.MUCTAR TABRANI RT.003/004', 'BEKASI UTARA', 'PERWIRA', '003', '004', 6, 10, 20000, 15816000, 10.00, '085730557047', '2022_RESTORAN_0173201192022.jpeg', 0, 1, '-6.2107888327722724', '107.00363606214526', 14, '2022-01-19 10:04:25', '2022-03-17 10:41:23', NULL);
INSERT INTO `restorans` VALUES (1733, 3, 'RENY OKTAVITASARI', 'P.2.02.0003963.13.02', 'AYAM KEPABRON PERWIRA', 'JL.RAYA KALIABANG TENGAH NO.12', 'BEKASI UTARA', 'PERWIRA', '006', '024', 4, 10, 18000, 14794200, 10.00, '081256168967', '2022_RESTORAN_0173301192022.jpeg', 0, 1, '-6.205669193005951', '107.00838625431062', 14, '2022-01-19 10:35:11', '2022-03-31 09:39:41', NULL);
INSERT INTO `restorans` VALUES (1734, 3, 'SUGITO', 'P.2.02.0002097.12.02', 'BAKSO OJOLALI (CAB. KRANJI)', 'JL. PEMUDA KRANJI', 'BEKASI BARAT', 'KRANJI', NULL, NULL, 3, 28, 23000, 1242000, 10.00, '081905617928', '2022_RESTORAN_0173402092022.jpg', 0, 1, '-6.228957818856962', '106.97765350341798', 11, '2022-01-19 13:47:30', '2022-04-12 12:33:20', NULL);
INSERT INTO `restorans` VALUES (1735, 2, 'ADE IRAWAN', 'P.2.02.0000916.12.02', 'CHOPPER ROAD HOOSE STEAK', 'JL.PEMUDA NO.1 KRANJI', 'BEKASI BARAT', 'KRANJI', NULL, NULL, 4, 24, 25000, 1587500, 10.00, NULL, '2022_RESTORAN_0173502092022.jpg', 0, 1, '-6.226579407922465', '106.97961419820787', 11, '2022-01-19 13:52:47', '2022-04-12 12:37:42', NULL);
INSERT INTO `restorans` VALUES (1736, 2, 'FERDI', 'P.2.02.0003179.12.02', 'KEDAI KOPI', 'JL.BINTARA RAYA', 'BEKASI BARAT', 'KRANJI', '1', '12', 9, 50, 24000, 4032000, 10.00, NULL, '2022_RESTORAN_0173602092022.jpg', 0, 1, '-6.234109228010118', '106.9732949137688', 11, '2022-01-19 13:55:49', '2022-04-12 12:38:52', NULL);
INSERT INTO `restorans` VALUES (1737, 3, 'BURHANUDIN', 'P.2.02.0003178.12.02', 'ARABIAN KEBAB', 'JL.NANGKA RAYA NO.38', 'BEKASI BARAT', 'KRANJI', NULL, NULL, 3, 14, 15000, 3795000, 10.00, NULL, '2022_RESTORAN_0173702092022.jpg', 0, 1, '-6.232370766392908', '106.98040008544923', 11, '2022-01-19 13:59:08', '2022-04-12 12:43:04', NULL);
INSERT INTO `restorans` VALUES (1738, 3, 'SATWIKA ARY SAPUTRA', 'P.2.02.0003832.13.01', 'LETS GO CHICKEN', 'JL.RAYA KALI ABANG TENGAH NO.4', 'BEKASI UTARA', 'KALIABANG TENGAH', '003', '015', 3, NULL, 9000, 6816600, 10.00, NULL, '2022_RESTORAN_0173801192022.jpeg', 0, 1, '-6.189872657812013', '106.99938207864763', 14, '2022-01-19 14:05:02', '2022-03-31 09:43:20', NULL);
INSERT INTO `restorans` VALUES (1739, 1, 'GITA SYAMPE BULO,SE', 'P.2.02.0005681.13.05', 'PELETON BIKE DAN CAFE', 'BOULUVARD SUMMARECON', 'BEKASI UTARA', 'HARAPANBARU', '006', '002', 24, 100, 80000, 590400000, 10.00, '081234553644', '2022_RESTORAN_0173901192022.jpeg', 0, 1, '-6.223385067768684', '106.99662744998933', 14, '2022-01-19 14:35:39', '2022-03-17 09:05:03', NULL);
INSERT INTO `restorans` VALUES (1740, 3, 'DRS.MURDIANTO', 'P.2.02.0003943.13.06', 'BAKSO JAYA', 'HARAPAN JAYA II RT.01/19', 'BEKASI UTARA', 'HARAPANJAYA', '001', '019', 5, 26, 8000, 5996800, 10.00, '087782770787', '2022_RESTORAN_0174001202022.jpeg', 0, 1, '-6.217273638338063', '106.99155002832416', 14, '2022-01-20 09:02:21', '2022-02-03 11:08:40', NULL);
INSERT INTO `restorans` VALUES (1741, 2, 'CHEN MING SHAN', 'KSO KOTA CINEMA MALL', 'KSO KOTA CINEMA MALL', 'JL.RAYA SASAK BAMBU RT.003 RW/02', 'BEKASI UTARA', 'TELUK PUCUNG', '003', '002', 13, 30, 20000, 124800000, 10.00, '021 22144941', '2022_RESTORAN_0174101202022.jpeg', 0, 1, '-6.211322125718987', '107.03182071447374', 14, '2022-01-20 09:29:39', '2022-03-17 10:44:14', NULL);
INSERT INTO `restorans` VALUES (1742, 2, 'BUDI HARTO WONGSO SUDIRO', 'P.2.02.0003966.13.05', 'DYNAMIC NATURAL', 'BULEVARD A.YANI BLOK.GF 160 SMB', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, NULL, 30000, 84900000, 10.00, '021 29572339', '2022_RESTORAN_0174201202022.jpeg', 0, 1, '-6.225662170333935', '107.00134813785553', 14, '2022-01-20 09:56:21', '2022-02-03 11:10:20', NULL);
INSERT INTO `restorans` VALUES (1743, 3, 'FEMY', 'P.2.02.0005015.13.04', 'NGIKAN WISMA ASRI', 'JL.SALAK RAYA N0.13', 'BEKASI UTARA', 'TELUK PUCUNG', '001', '013', 4, 5, 16000, 4841600, 10.00, '082298962238', '2022_RESTORAN_0174301202022.jpeg', 0, 1, '-6.215956418675925', '107.02538073062898', 14, '2022-01-20 10:14:12', '2022-03-31 09:49:36', NULL);
INSERT INTO `restorans` VALUES (1744, 2, 'LIOE TJU MIE', 'P.2.02.0004701.13.05', 'SAY CHIIZU HOKKAIDO CHEESE TOAST', 'BOULEVARD SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, NULL, 28000, 54460000, 10.00, '087886277911', '2022_RESTORAN_0174401202022.jpeg', 0, 4, '-6.225784824290302', '107.00145810842515', 14, '2022-01-20 10:19:37', '2022-01-21 13:00:09', '2022-01-21 13:00:09');
INSERT INTO `restorans` VALUES (1745, 2, 'NATALIA DEBORAH', 'P.2.02.0005370.13.05', 'LETS GO GELATO', 'MALL SUMMARECON BEKASI LANTAI 2', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, NULL, 20000, 41700000, 10.00, '0895324951010', '2022_RESTORAN_0174501202022.jpeg', 0, 1, '-6.225704832582874', '107.00139105319978', 14, '2022-01-20 10:26:48', '2022-03-31 09:54:46', NULL);
INSERT INTO `restorans` VALUES (1746, 2, 'RUDY TANUDJAYA', 'P.2.02.0002143.13.05', 'KFC SUMMARECON', 'JL.BOULEVAR AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 15, 54, 50000, 637500000, 10.00, '08117156887', '2022_RESTORAN_0174601202022.jpeg', 0, 1, '-6.225640839208175', '107.00156271457674', 14, '2022-01-20 10:33:15', '2022-03-31 10:00:11', NULL);
INSERT INTO `restorans` VALUES (1747, 3, 'RAGA PRABHANTARA', 'P.2.02.0005627.13.03', 'BURGER BANGOR', 'JL. PERJUANGAN RT. 001 RW. 003', 'BEKASI UTARA', 'HARAPANBARU', '001', '003', 4, 4, 30000, 46095000, 10.00, '081319877784', '2022_RESTORAN_0174701202022.jpeg', 0, 1, '-6.222270510456547', '107.02379554510118', 14, '2022-01-20 10:40:44', '2022-03-17 10:29:24', NULL);
INSERT INTO `restorans` VALUES (1748, 3, 'KAREL AWUY KALALO', 'P.2.02.0002880.13.04', 'BEBEK BAKAR JOJO', 'JL.PERJUANGAN NO.150 RT003/001', 'BEKASI UTARA', 'TELUK PUCUNG', '003', '001', 2, 16, 12000, 2810400, 10.00, NULL, '2022_RESTORAN_0174801202022.jpeg', 0, 1, '-6.2390272', '106.9449216', 14, '2022-01-20 10:53:17', '2022-02-03 11:12:15', NULL);
INSERT INTO `restorans` VALUES (1749, 1, 'KUSNADI RAHARDJA', 'P.2.02.0005622.13.05', 'KIMUKATSU/PT.BOGA MAKMUR DINASTI', 'SUMMARECON MAL BEKASI JL. BOULEVARD AHMAD YANI RT.006/RW.002', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 22, 80, 50000, 479045000, 10.00, '021 29572428', '2022_RESTORAN_0174901202022.jpeg', 0, 1, '-6.22621144652414', '107.00092971324922', 14, '2022-01-20 11:02:15', '2022-03-17 10:45:51', NULL);
INSERT INTO `restorans` VALUES (1750, 2, 'GURFON SYARIF', 'P.2.02.0004809.13.01', 'HAUS / PT.INSPIRASI BISNIS NUSANTARA', 'JL.PONDOK UNGU PERMAI BLOK.GG7 NO.25', 'BEKASI UTARA', 'KALIABANG TENGAH', '004', '011', 4, 2, 18000, 173889000, 10.00, '081378058324', '2022_RESTORAN_0175001202022.jpeg', 0, 1, '-6.180011583170581', '107.0036628842354', 14, '2022-01-20 11:59:38', '2022-02-03 11:13:27', NULL);
INSERT INTO `restorans` VALUES (1751, 2, 'REST. A&W SUMMARECON', 'P.2.02.0002600.13.05', 'A & W SUMMARECON', 'JL.BULEVARD A.YANI SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 12, 38, 53000, 355365000, 10.00, '081808494308', '2022_RESTORAN_0175101202022.jpeg', 1, 1, '-6.225758160389179', '107.00144469738008', 14, '2022-01-20 14:11:06', '2022-03-31 10:04:17', NULL);
INSERT INTO `restorans` VALUES (1752, 3, 'STEVIE MICHAEL KRISTEDI', 'P.2.02.0005562.13.05', 'MOMOTORI', 'KIRANA TWO TOWER 10 A JL. BOULEVARD TIMUR NO. 88 MALL SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, NULL, 11500, 10206250, 10.00, '081219115370', '2022_RESTORAN_0175201202022.jpeg', 0, 1, '-6.226398093642464', '107.00107991695405', 14, '2022-01-20 14:19:39', '2022-03-31 10:11:52', NULL);
INSERT INTO `restorans` VALUES (1753, 3, 'MUHAMAD FAJRUL IMAN', 'P.2.02.0005070.13.06', 'ZEGAR SEROJA', 'JL. RAYA SEROJA RT. 003/028', 'BEKASI UTARA', 'HARAPANJAYA', '003', '028', 2, NULL, 12500, 14102500, 10.00, '082298246601', '2022_RESTORAN_0175301212022.jpeg', 0, 1, '-6.202928032098739', '106.98918700218202', 14, '2022-01-20 14:24:48', '2022-02-03 12:28:36', NULL);
INSERT INTO `restorans` VALUES (1754, 1, 'KENTJANA INDRIAWATI', 'P.2.02.0003687.13.05', 'GENGKI SUSHI', 'JL. BOULEVARD AHMAD YABI UNIT A LT.1 SMB', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 22, 44, 75000, 761250000, 10.00, '021 29572511', '2022_RESTORAN_0175401202022.jpeg', 1, 1, '-6.2268247153781', '107.00079560279846', 14, '2022-01-20 14:31:06', '2022-02-15 12:39:55', NULL);
INSERT INTO `restorans` VALUES (1755, 2, 'HENDRIX ALXANDER W MBOI', 'P.2.02.0004555.13.05', 'CHOPSTIX', 'JL.BOULEVARD AHMAD YANI BLOK.M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 9, 62, 26500, 115341250, 10.00, '081318105722', '2022_RESTORAN_0175501202022.jpeg', 1, 1, '-6.2263341003522275', '107.00111746788026', 14, '2022-01-20 14:42:10', '2022-06-13 11:21:33', '2022-06-13 11:21:33');
INSERT INTO `restorans` VALUES (1756, 1, 'ALI GUNAWAN BUDIMAN', 'P.2.02.0002767.13.05', 'RAA CHA SUKI', 'JL.BULEVARD AHMAD YANI BLOK.M SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 66, 72000, 757512000, 10.00, '081318105722', '2022_RESTORAN_0175601202022.jpeg', 1, 1, '-6.226056796004414', '107.00153589248657', 14, '2022-01-20 14:48:45', '2022-03-17 10:51:12', NULL);
INSERT INTO `restorans` VALUES (1757, 2, 'SISCA PAMUDJI', 'P.2.02.0002065.13.05', 'REST. YURAKU', 'JL. BOULEVARD BARAT BLOK C NO.25', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 72, 58000, 622050000, 10.00, '021 29572552', '2022_RESTORAN_0175701212022.jpeg', 1, 1, '-6.226110123774982', '107.00169146060944', 14, '2022-01-21 08:30:14', '2022-03-17 10:52:25', NULL);
INSERT INTO `restorans` VALUES (1758, 1, 'ALI GUNAWAN BUDIMAN', 'P.2.02.0002248.13.05', 'GOKANA TEPPAN SMB', 'SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 22, 132, 67000, 673953000, 10.00, NULL, '2022_RESTORAN_0175801212022.jpeg', 1, 1, '-6.226248775953112', '107.00109601020814', 14, '2022-01-21 08:39:54', '2022-02-03 12:26:59', NULL);
INSERT INTO `restorans` VALUES (1759, 2, 'TEDDY HARSONO', 'P.2.02.0005439.12.02', 'RAMEN JOU', 'JL. KH. NOER ALI KALIMALANG', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 5, 44, 20000, 13780000, 10.00, '081287066618', '2022_RESTORAN_0175901272022.jpg', 0, 1, '-6.229299114609273', '106.96392059326173', 11, '2022-01-21 08:50:26', '2022-04-12 12:45:31', NULL);
INSERT INTO `restorans` VALUES (1760, 3, 'CRISTY APRIYANTO', 'P.2.02.0005573.13.05', 'TOKYO GORILLA SMB', 'MALL SUMMARECON BEKASI LANTAI II', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, NULL, 23000, 11143500, 10.00, '081908320192', '2022_RESTORAN_0176001212022.jpg', 0, 1, '-6.225928809332964', '107.00114965438843', 14, '2022-01-21 08:51:40', '2022-03-31 10:31:29', NULL);
INSERT INTO `restorans` VALUES (1761, 1, 'WISNU HARDI WINTORO, SE', 'P.2.02.0002070.13.05', 'CAFE SUMMARECON XXI', 'BOULEVARD SUMMARECON MALL LT.3', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, 24, 38000, 606100000, 10.00, '021 29572421', '2022_RESTORAN_0176101212022.jpeg', 1, 1, '-6.226142120434725', '107.00114428997041', 14, '2022-01-21 08:59:41', '2022-03-31 10:33:33', NULL);
INSERT INTO `restorans` VALUES (1762, 1, 'WAHYUDI PRAWIRO UTOMO', 'P.2.02.0005585.12.05', 'FLASH COFFEE', 'KOMPLEK B. WALK GRAND BINTANG \r\nJL. KH. NOER ALI', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 3, 12, NULL, 0, 10.00, '085710908091', NULL, 0, 4, NULL, NULL, 11, '2022-01-21 09:00:53', '2022-04-11 08:04:29', '2022-04-11 08:04:29');
INSERT INTO `restorans` VALUES (1763, 2, 'BARYANTO', 'P.2.02.0004302.12.04', 'MBAH BERES', 'KOMPLEK INKOPOL E2 JL.PATRIOT', 'BEKASI BARAT', 'JAKASAMPURNA', NULL, NULL, 22, 48, 70000, 345800000, 10.00, '081290153659', '2022_RESTORAN_0176302022022.jpg', 0, 1, '-6.226568742378317', '106.97078704833984', 11, '2022-01-21 09:03:34', '2022-04-12 12:47:38', NULL);
INSERT INTO `restorans` VALUES (1764, 2, 'ANDRE', 'P.0.02.0002048.12.05', 'BEBEK KALEYO', 'KOMP.RUKO DUTA PERMAI', 'BEKASI BARAT', 'JAKASAMPURNA', '09', '06', 21, 80, 85000, 320875000, 10.00, '08118116445', '2022_RESTORAN_0176401272022.jpg', 0, 1, '-6.229299114609273', '106.98246002197267', 11, '2022-01-21 09:08:14', '2022-04-12 12:50:50', NULL);
INSERT INTO `restorans` VALUES (1765, 2, 'TNJUNG PAULUS', 'P.2.02.0004954.13.05', 'SUSHIGO', 'MALL SUMMARECON LT.2 UNIT.2F NO.119 &AMP; 1190', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 50, 37000, 65305000, 10.00, '021 89491688', '2022_RESTORAN_0176501212022.jpeg', 0, 1, '-6.226099458221306', '107.00114965438843', 14, '2022-01-21 09:10:47', '2022-03-31 10:34:52', NULL);
INSERT INTO `restorans` VALUES (1766, 3, 'HENDRY WIDJAYA', 'P.2.02.0005075.13.05', 'KOPI KURANG LEBIH', 'RUKO EMERALD JL.BULEVARD SELATAN SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, 8, 15000, 10392000, 10.00, '081211237500', '2022_RESTORAN_0176601212022.jpeg', 0, 1, '-6.227115351237036', '107.00487524271014', 14, '2022-01-21 09:25:44', '2022-02-18 09:46:50', NULL);
INSERT INTO `restorans` VALUES (1767, 2, 'PT.MULTI BUAH SUKSES', 'P.2.02.0003752.13.05', 'REST. VITAMIN', 'RUKO CLUSTER RUBY COMMERCIAL BLOK.TA/1 SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 60, 30000, 193500000, 10.00, '081246753388', '2022_RESTORAN_0176701212022.jpeg', 0, 1, '-6.226568742378317', '107.00062394142152', 14, '2022-01-21 09:35:52', '2022-02-15 12:41:11', NULL);
INSERT INTO `restorans` VALUES (1768, 3, 'BENNY ISKANDAR', 'P.2.02.0005060.13.02', 'XI BOBA KALIABANG', 'JL. LKR UTARA NO.10', 'BEKASI UTARA', 'PERWIRA', '004', '006', 3, NULL, 20000, 15850000, 10.00, '08119985553', '2022_RESTORAN_0176801212022.jpeg', 0, 1, '-6.204498601716782', '107.0054814219475', 14, '2022-01-21 09:39:03', '2022-02-03 12:25:04', NULL);
INSERT INTO `restorans` VALUES (1769, 3, 'SAMUEL PANDHEGA', 'P.2.02.0004192.13.05', 'YOBE CHEESE TEA', 'JL.BOLEVARD AHMAD YANI BLOK.M SENTRA SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, NULL, 25000, 27205000, 10.00, NULL, '2022_RESTORAN_0176901212022.jpeg', 0, 1, '-6.226083459890372', '107.00125157833101', 14, '2022-01-21 09:57:05', '2022-02-15 12:42:30', NULL);
INSERT INTO `restorans` VALUES (1770, 1, 'FRANSISCA', 'P.2.02.0003652.13.05', 'PANCIOUS PANCAKE HOUSE', 'SUMMARECON MALL LT.1 UNIT IF 118A', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 100, 100000, 712050000, 10.00, '021 29572477', '2022_RESTORAN_0177001212022.jpeg', 1, 1, '-6.225419528727176', '107.00195699930192', 14, '2022-01-21 10:08:36', '2022-02-15 12:43:32', NULL);
INSERT INTO `restorans` VALUES (1771, 2, 'SHARUL RAMDANI GUCHI', 'P.2.02.0002664.17.01', 'RM.DANGAU BASAMO', 'JL.RAYA NAROGONG KM.10 NO.58', 'BANTARGEBANG', 'BANTARGEBANG', '002', '004', 1, 8, 20000, 4250000, 10.00, '0218250460 / 08121967259', '2022_RESTORAN_0177101212022.jpg', 0, 1, '-6.329630392120957', '106.98726654052736', 13, '2022-01-21 10:11:15', '2022-04-14 10:10:05', NULL);
INSERT INTO `restorans` VALUES (1772, 1, 'ADRIAN CHRISTOPHER AGUS', 'P.2.02.0003407.13.05', 'PUYO / PT.BENAYA MULTI KARYA', 'BULEVAR A.YANI BLOK.M SUMMARECON MALL LT.IF-IC 07', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, NULL, 50000, 270700000, 10.00, '085218087016', '2022_RESTORAN_0177201212022.jpeg', 1, 1, '-6.225902145439156', '107.00126230716707', 14, '2022-01-21 10:20:25', '2022-02-15 12:44:46', NULL);
INSERT INTO `restorans` VALUES (1773, 2, 'GATOT SEWAN DHONO', 'P.2.02.0003751.17.02', 'RM. SALERO RASO', 'JL.RAYA NAROGONG KM.12,5 NO.168', 'BANTARGEBANG', 'BANTARGEBANG', '003', '006', 1, 10, 15000, 12742500, 10.00, '0218250708', '2022_RESTORAN_0177301212022.jpg', 0, 1, '-6.336454944694203', '106.97696685791017', 13, '2022-01-21 10:25:22', '2022-05-25 15:02:25', NULL);
INSERT INTO `restorans` VALUES (1774, 3, 'ERWIN PARAPAT', 'P.2.02.0002951.13.05', 'FRUITY INDONESIA', 'SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, 4, 16000, 15448000, 10.00, NULL, NULL, 0, 1, '-6.225870148764796', '107.00136959552765', 14, '2022-01-21 10:34:33', '2022-02-15 12:47:21', NULL);
INSERT INTO `restorans` VALUES (1775, 2, 'ROBY BERLIANTO', 'P.2.02.0001111.17.02', 'RM.IBU ENUNG', 'JL.RAYA NAROGONG KM.12', 'BANTARGEBANG', 'BANTARGEBANG', '005', '001', 1, 8, 20000, 5700000, 10.00, '081399860999', '2022_RESTORAN_0177501212022.jpg', 0, 1, '-6.330995309852224', '106.97765350341798', 13, '2022-01-21 10:44:40', '2022-04-14 09:59:45', NULL);
INSERT INTO `restorans` VALUES (1776, 3, 'VINA', 'P.2.02.0002943.13.05', 'EGGO', 'BULEVARD A.YANI BLOK M LT.3 IF-1C09 SMB', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, NULL, 20000, 31390000, 10.00, NULL, '2022_RESTORAN_0177601212022.jpeg', 0, 1, '-6.2266913961229475', '107.00064808130267', 14, '2022-01-21 10:59:42', '2022-03-31 10:37:18', NULL);
INSERT INTO `restorans` VALUES (1777, 3, 'GABRILIEA MAYASITA', 'P.2.02.0003026.13.05', 'ROLLYS', 'JL.BULEVARD A.YANI SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, NULL, 20000, 15320000, 10.00, '08999118728', '2022_RESTORAN_0177701212022.jpeg', 0, 1, '-6.226568742378317', '107.00064808130267', 14, '2022-01-21 11:14:52', '2022-02-18 09:39:40', NULL);
INSERT INTO `restorans` VALUES (1778, 2, 'SUROTO', 'P.2.02.0005291.17.01', 'BASO SUKOWATI', 'JL.RAYA NAROGONG KM.11', 'BANTARGEBANG', 'BANTARGEBANG', '003', '009', 1, 4, 15000, 3718500, 10.00, '081315536087', '2022_RESTORAN_0177801212022.jpg', 0, 1, '-6.337819844380109', '106.98040008544923', 13, '2022-01-21 11:25:58', '2022-05-25 15:05:39', NULL);
INSERT INTO `restorans` VALUES (1779, 1, 'REST. ABUBA STEAK', 'P.2.02.0002174.13.05', 'REST. ABUBA STEAK', 'BOULEVARD SELATAN RUKAN SINPASA BLOK.SA.32-33', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 21, 130, 125000, 1050000000, 10.00, '021 29572233', '2022_RESTORAN_0177901212022.jpeg', 1, 1, '-6.228765839898766', '107.00126230716707', 14, '2022-01-21 11:48:09', '2022-02-15 12:48:41', NULL);
INSERT INTO `restorans` VALUES (1780, 1, 'NGADI UTOMO', 'P.2.02.0004038.13.05', 'RICHEESE FACTORY', 'BULEVARD TIMUR BLOK.VA/23', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 150, 73000, 1100475000, 10.00, '021 89461256', '2022_RESTORAN_0178001212022.jpeg', 0, 1, '-6.2247982590473345', '107.00267583131792', 14, '2022-01-21 11:56:42', '2022-02-15 12:49:55', NULL);
INSERT INTO `restorans` VALUES (1781, 3, 'AGUS SUSANTO', 'P.2.02.0002038.11.01', 'FITRI SEA FOOD 2', 'JL. NUSANTARA RAYA', 'BEKASI TIMUR', 'ARENJAYA', '009', '015', 12, 80, 50000, 58500000, 10.00, '0813-9898-9850', '2022_RESTORAN_0178101212022.jpg', 0, 1, '-6.243633335676945', '107.02863693237306', 10, '2022-01-21 12:06:25', '2022-04-14 08:36:56', NULL);
INSERT INTO `restorans` VALUES (1782, 2, 'ENTIN KARTINI', 'P.2.02.0003979.17.01', 'RM. MAK ENTIN', 'JL.RAYA BANTARGEBANG', 'BANTARGEBANG', 'BANTARGEBANG', '004', '001', 1, 8, 15000, 6690000, 10.00, '087771391690', '2022_RESTORAN_0178201212022.jpg', 0, 1, '-6.313933579167068', '106.98726654052736', 13, '2022-01-21 12:26:34', '2022-05-25 15:03:18', NULL);
INSERT INTO `restorans` VALUES (1783, 3, 'FERDY HERMAWAN', 'P.2.02.0004866.13.05', 'COLD RAWA BUGEL', 'JL.RAWA BUGEL RT.006 RW.003', 'BEKASI UTARA', 'MARGAMULYA', '006', '003', 4, 4, 8000, 5840000, 10.00, '081246753388', NULL, 0, 1, '-6.221766559125463', '107.00301915407182', 14, '2022-01-21 13:33:41', '2022-02-15 12:52:24', NULL);
INSERT INTO `restorans` VALUES (1784, 2, 'LIZA LUCIANA SSUWANDI', 'P.2.02.0002057.13.05', 'EASTERN KOPI TM/PT. NUANSA TMR L', 'JL. BOULEVARD AHMAD YANI BLK. M DW-102,103', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 16, 64, 30000, 128250000, 10.00, '081387226485', '2022_RESTORAN_0178401212022.jpeg', 0, 1, '-6.226632735639955', '107.0005649328232', 14, '2022-01-21 14:38:16', '2022-02-15 12:55:12', NULL);
INSERT INTO `restorans` VALUES (1785, 1, 'ABIGAIL DJOJONEGORO', 'P.2.02.0004389.13.05', 'IMPERIAL KITCHEN & DIMSUM', 'JL.BOULEVAR MALL SUMMARECON LT.DASAR DW-105', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 14, 30, 79000, 538385000, 10.00, '08119266717', '2022_RESTORAN_0178501212022.jpeg', 1, 1, '-6.226867377532614', '107.00092434883119', 14, '2022-01-21 14:47:26', '2022-02-15 12:56:20', NULL);
INSERT INTO `restorans` VALUES (1786, 2, 'HESTIYANI', 'P.2.02.0004938.13.05', 'BAKMI GOCIT', 'BULEVAR AHMAD YANI BLOK.M DWONTOWN WALK SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 20, 45000, 61537500, 10.00, '08998712925', '2022_RESTORAN_0178601212022.jpeg', 0, 1, '-6.226771387680112', '107.00068295001985', 14, '2022-01-21 15:00:18', '2022-02-15 12:58:35', NULL);
INSERT INTO `restorans` VALUES (1787, 2, 'FRANSEDA NATALIO', 'P.2.02.0004865.13.05', 'YOGURTLAND', 'MALL SUMMARECON DWONTW WALK LT.DASAR', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, 8, 35000, 125790000, 10.00, '089514527288', '2022_RESTORAN_0178701212022.jpeg', 0, 1, '-6.226515414654314', '107.00046837329866', 14, '2022-01-21 15:07:30', '2022-02-15 12:59:46', NULL);
INSERT INTO `restorans` VALUES (1788, 1, 'FRANCISKA R HIDAYAT', 'P.2.02.0005253.13.05', 'TALIWANG BALI', 'MALL SUMMARECON MAL BEKASI / DOWNTOWN WALK UNIT DW-110A', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 11, 58, 75000, 300075000, 10.00, '0816815769', '2022_RESTORAN_0178801212022.jpeg', 0, 1, '-6.226547411289362', '107.00092434883119', 14, '2022-01-21 15:14:11', '2022-02-18 09:42:17', NULL);
INSERT INTO `restorans` VALUES (1789, 1, 'HENKY RUSLI', 'P.2.02.0003123.13.05', 'FISH N CO', 'DWONTON WALK UNIT DW-III A SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 9, 60, 70000, 314580000, 10.00, '021 29285570', '2022_RESTORAN_0178901212022.jpeg', 1, 1, '-6.226526080199554', '107.0008385181427', 14, '2022-01-21 15:36:38', '2022-02-15 13:00:54', NULL);
INSERT INTO `restorans` VALUES (1844, 2, 'DOM PIZZA INDONESIA', 'P.2.02.0002969.13.05', 'DOM PIZZA INDONESIA', 'BOULEVARD SELATAN RUKAN SINPASA', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 12, 20, 80000, 464120000, 10.00, '08985531056', '2022_RESTORAN_0184401252022.jpeg', 1, 1, '-6.228195235358585', '107.001970410347', 14, '2022-01-25 09:03:52', '2022-02-15 13:01:57', NULL);
INSERT INTO `restorans` VALUES (1845, 1, 'WIDADA BASUKI RAHMAD', 'P.2.02.0004759.13.05', 'RAMEN YA', 'SUMMARECON MALL BEKASI DOWNTOWN WALK 119 JL.BOULEVARD AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 21, 30, 70000, 521150000, 10.00, '02189469998', '2022_RESTORAN_0184501252022.jpeg', 0, 1, '-6.2263181020284435', '107.00129449367525', 14, '2022-01-25 09:33:35', '2022-02-15 13:03:29', NULL);
INSERT INTO `restorans` VALUES (1846, 2, 'PT. SUPER TEA INDONESIA', 'P.2.02.0005366.13.05', 'R & B TEA', 'BOULEVARD MALL SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, 8, 23000, 46805000, 10.00, NULL, '2022_RESTORAN_0184601252022.jpeg', 0, 1, '-6.226008801006283', '107.00124084949495', 14, '2022-01-25 09:49:24', '2022-03-31 10:39:36', NULL);
INSERT INTO `restorans` VALUES (1847, 2, 'MARTINUS TARA KARYADI', 'P.2.02.0003333.13.05', 'AUNTIE ANNE S', 'JL.BOULEVARD AHMAD YANI BLOK.M SMB GF-135', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, 8, 35000, 165550000, 10.00, NULL, '2022_RESTORAN_0184701252022.jpeg', 1, 1, '-6.2259981354505465', '107.00131595134735', 14, '2022-01-25 10:01:17', '2022-02-15 13:06:44', NULL);
INSERT INTO `restorans` VALUES (1848, 1, 'JEO SASANTO', 'P.2.02.0002685.13.05', 'MARUGAME UDON SUMMARECON', 'BOULEVARD A.YANI BLOK.M SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 35, 130, 125000, 1454062500, 10.00, '08113248866', '2022_RESTORAN_0184801252022.jpeg', 0, 1, '-6.226494083563208', '107.0010530948639', 14, '2022-01-25 10:17:53', '2022-02-15 13:08:48', NULL);
INSERT INTO `restorans` VALUES (1849, 2, 'STANLEY RAMON MARCELLIUS', 'P.2.02.0003583.13.05', 'KOBA BBQ', 'BOULEVARD AHMAD YANI BLOK.M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 15, 76, 45000, 220612500, 10.00, '021 2957270', '2022_RESTORAN_0184901252022.jpeg', 1, 1, '-6.22625944150376', '107.00096726417543', 14, '2022-01-25 10:31:18', '2022-03-31 10:42:19', NULL);
INSERT INTO `restorans` VALUES (1850, 2, 'HENDRY H.BATUBARA', 'P.2.02.0003829.13.05', 'KRISPY KREME', 'FOOD HALL F &AMP; B 03 SUMARECON MALL BEKASI JL.BOULEVARD AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, 15, 60000, 237420000, 10.00, '021 29572519', '2022_RESTORAN_0185001252022.jpeg', 1, 4, '-6.22625944150376', '107.0012676715851', 14, '2022-01-25 10:39:49', '2022-01-31 22:22:20', '2022-01-31 22:22:20');
INSERT INTO `restorans` VALUES (1851, 2, 'RIZVI NANDO', 'P.2.02.0003158.13.05', 'MOKKA COFFE CABANA', 'JL.BOULEVARD AHMAD YANI SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 20, 13000, 28938000, 10.00, '089691364502', '2022_RESTORAN_0185101252022.jpeg', 0, 1, '-6.226270107054192', '107.00067758560182', 14, '2022-01-25 11:06:59', '2022-02-18 09:43:35', NULL);
INSERT INTO `restorans` VALUES (1852, 2, 'WILLIAM', 'P.2.02.0005426.20.02', 'PT KURNIA BOGO NARAYAM / JANJI JIWA', 'LA TERAZZA SUMARECON BEKASI', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 11, 40, 50000, 158950000, 10.00, '089507743538', '2022_RESTORAN_0185201252022.jpeg', 0, 1, '-6.181868', '106.9712906', 16, '2022-01-25 11:18:57', '2022-05-30 14:36:01', NULL);
INSERT INTO `restorans` VALUES (1853, 2, 'A LOEBY FAJAR TANJUNG', 'P.2.02.0004962.20.03', 'BAKSO AGUNG / CV TRIANTRA CIPTARASA AGUNG', 'JL BOULEVAR HIJAU SN 1 NO 3', 'MEDANSATRIA', 'PEJUANG', '00', '00', 7, 64, 20000, 16330000, 10.00, '02188897434', '2022_RESTORAN_0185301252022.jpeg', 0, 1, '-6.181868', '106.9712906', 16, '2022-01-25 11:22:47', '2022-05-30 14:29:27', NULL);
INSERT INTO `restorans` VALUES (1854, 2, 'DOMINO PIZZA', 'P.2.02.0001719.20.01', 'DOMINO PIZZA', 'JL BOULEVARD HIJAU HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 11, 20, 115000, 296010000, 10.00, '02188866388', '2022_RESTORAN_0185401252022.jpeg', 0, 1, '-6.181868', '106.9712906', 16, '2022-01-25 11:29:38', '2022-05-30 14:14:29', NULL);
INSERT INTO `restorans` VALUES (1855, 2, 'KONG NAI TING', 'P.2.02.0003557.20.02', 'RM SEDERHANA', 'BOULEVARD BARAT RUKO TOPAZ B19', 'MEDANSATRIA', 'HARAPANMULYA', '00', '00', 13, 30, 55000, 331925000, 10.00, '081383399919', '2022_RESTORAN_0185501252022.jpeg', 0, 1, '-6.181868', '106.9712906', 16, '2022-01-25 11:31:56', '2022-05-30 14:11:10', NULL);
INSERT INTO `restorans` VALUES (1856, 2, 'HENRY BATUBARA', 'P.2.02.0004036.20.01', 'STARBUCK CAFFE / PT CAFFE INDONESIA', 'JL HARAPAN INDAH', 'MEDANSATRIA', 'MEDANSATRIA', '00', '00', 13, 78, 120000, 760800000, 10.00, '02188889222', '2022_RESTORAN_0185601252022.jpeg', 0, 1, '-6.181868', '106.9712906', 16, '2022-01-25 11:35:18', '2022-04-25 10:56:41', NULL);
INSERT INTO `restorans` VALUES (1857, 2, 'FARIDA UDIANA', 'P.2.02.0002038.11.01', 'FITRI SEA FOOD', 'JL. MEKARSARI RAYA NO. 1', 'BEKASI TIMUR', 'BEKASIJAYA', '03', '07', 13, 80, 50000, 112000000, 10.00, '0812-3454-6795', '2022_RESTORAN_0185701252022.jpg', 0, 1, '-6.231981478186119', '107.01017796993257', 10, '2022-01-25 12:43:23', '2022-04-14 08:37:15', NULL);
INSERT INTO `restorans` VALUES (1858, 3, 'HJ. CUCU SUMARNI', 'P.2.02.0001997.11.02', 'RM SOTO BANDUNG', 'JL. RA KARTINI NO. 9', 'BEKASI TIMUR', 'MARGAHAYU', '01', '05', 2, 20, 20000, 25900000, 10.00, '-', '2022_RESTORAN_0185801252022.jpg', 0, 1, '-6.244209256009597', '107.00477600097658', 10, '2022-01-25 12:59:57', '2022-06-15 10:22:47', NULL);
INSERT INTO `restorans` VALUES (1859, 3, 'IR. HJ. FINDARTI RAHAYU', 'P.2.02.0004951.13.05', 'TRUDISH KITCHEN & COFFEE', 'JL.PERJUANGAN SISI BARAT', 'BEKASI UTARA', 'MARGAMULYA', '001', '002', 7, 40, 30000, 47073000, 10.00, '08111691988', '2022_RESTORAN_0185901262022.jpeg', 0, 1, '-6.224310308526095', '107.00886100530627', 14, '2022-01-26 15:53:41', '2022-02-16 12:00:09', NULL);
INSERT INTO `restorans` VALUES (1860, 3, 'ABU JUANAEDI', 'P.2.02.0003025.13.02', 'RM. KARYA MINANG', 'JL.LINGKAR UTARA BLOK.A NO.1', 'BEKASI UTARA', 'PERWIRA', '007', '006', 10, 60, 13000, 29809000, 10.00, '081291137857', '2022_RESTORAN_0186001272022.jpeg', 0, 1, '-6.205439874643849', '107.00677692890169', 14, '2022-01-27 10:39:07', '2022-03-17 09:29:46', NULL);
INSERT INTO `restorans` VALUES (1861, 3, 'ROBET SUTANTO', 'P.2.02.0003855.13.02', 'I AM GEPREK BENSU', 'JL.KALIABANG TENGAH NO.9B -9C', 'BEKASI UTARA', 'PERWIRA', NULL, NULL, 6, 40, 15000, 34395000, 10.00, '087875975523', '2022_RESTORAN_0186101272022.jpeg', 0, 1, '-6.202773374735554', '107.00163781642915', 14, '2022-01-27 10:50:29', '2022-03-17 09:31:30', NULL);
INSERT INTO `restorans` VALUES (1862, 3, 'LINDA', 'P.2.02.0004731.13.02', 'BAKSO MUKIDI', 'LINGKAR UTARA', 'BEKASI UTARA', 'PERWIRA', NULL, NULL, 5, 10, 12000, 6144000, 10.00, '087818211018', '2022_RESTORAN_0186201272022.jpeg', 0, 1, '-6.205861180395137', '107.01022356748584', 14, '2022-01-27 11:02:27', '2022-03-17 09:34:07', NULL);
INSERT INTO `restorans` VALUES (1863, 3, 'SATWIKA ARI SAPUTRA', 'P.2.02.0003905.13.02', 'LET S GO CHICKEN', 'JL.KH.MUCHTAR TABRANI', 'BEKASI UTARA', 'PERWIRA', '003', '001', 2, NULL, 12000, 6480000, 10.00, NULL, '2022_RESTORAN_0186301272022.jpeg', 0, 1, '-6.218084233413543', '107.00248807668687', 14, '2022-01-27 11:15:39', '2022-03-17 09:40:16', NULL);
INSERT INTO `restorans` VALUES (1864, 3, 'WILLIAM', 'P.2.02.0005500.13.05', 'KOPI JANJI JIWA RUKAN PERJUANGAN', 'JL. PERJUANGAN NO. 12 RT. 004 RW. 001', 'BEKASI UTARA', 'MARGAMULYA', '004', '001', 8, 14, 20000, 93340000, 10.00, NULL, '2022_RESTORAN_0186401272022.jpeg', 0, 1, '-6.233263995090686', '107.00118452310564', 14, '2022-01-27 11:28:50', '2022-03-31 10:59:31', NULL);
INSERT INTO `restorans` VALUES (1865, 3, 'FATURAHMAN', 'P.2.02.0005572.13.05', 'KEDAI KOPI SINAR CAHAYA', 'JL. KH. MUKHTAR TABRANI', 'BEKASI UTARA', 'PERWIRA', '004', '002', 3, 12, 10000, 10375000, 10.00, '085158361551', '2022_RESTORAN_0186501272022.jpeg', 0, 1, '-6.2233717357574', '107.00360387563708', 14, '2022-01-27 11:42:15', '2022-04-08 08:43:20', NULL);
INSERT INTO `restorans` VALUES (1866, 2, 'ALDI CRISTIAN WEN', 'P.2.02.0004142.13.05', 'CHOP BUNTUT CAK YO', 'BOULEVAR AHMAD YANI BLOK.M SMB GROUND FLOOR UNIT 145-IF 145', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 7, 26, 63000, 200182500, 10.00, '021 89459392', '2022_RESTORAN_0186601282022.jpeg', 1, 1, '-6.2264834180173185', '107.00070977211', 14, '2022-01-28 09:12:06', '2022-02-16 12:01:36', NULL);
INSERT INTO `restorans` VALUES (1867, 3, 'ANDRI TAHAR', 'P.2.02.0004797.13.02', 'MEENUM', 'JL.KALIABANG', 'BEKASI UTARA', 'PERWIRA', '004', '006', 1, 3, 8000, 4431200, 10.00, '085695524016', '2022_RESTORAN_0186701282022.jpeg', 0, 1, '-6.203069356890938', '107.00264900922777', 14, '2022-01-28 10:30:21', '2022-03-18 10:24:39', NULL);
INSERT INTO `restorans` VALUES (1868, 3, 'SUSHI BOX / CV. KREASI JAWARA JAYA', 'P.2.02.0005452.14.04', 'SUSHI BOX / CV. KREASI JAWARA JAYA', 'TAMAN ASTER RT. 005/014', 'BEKASI SELATAN', 'JAKASETIA', '005', '014', 11, 18, 70000, 14455000, 10.00, NULL, '2022_RESTORAN_0186801312022.jpg', 0, 1, '-6.259630886939775', '106.97149246931079', 9, '2022-01-31 09:00:44', '2022-04-13 09:25:30', NULL);
INSERT INTO `restorans` VALUES (1869, 3, 'ANDREAS STEFANO HAMONANGAN SITORUS', 'P.2.02.0005471.14.04', 'PEMERINTAH KOPI', 'JL, NUSA INDAH RAYA RUKO TAMAN GALAXY NO. U62 RT. 007 RW. 014', 'BEKASI SELATAN', 'JAKASETIA', '007', '014', 4, 36, 30000, 20742000, 10.00, NULL, '2022_RESTORAN_0186901312022.jpeg', 0, 1, '-6.256652713223406', '106.97222203016284', 9, '2022-01-31 09:17:12', '2022-04-13 09:37:53', NULL);
INSERT INTO `restorans` VALUES (1870, 3, 'H.SUDARJI', 'P.2.02.0004540.13.04', 'MIE AYAM SUPER JUDES', 'JL.BOULEVARD GOLDEN CITY', 'BEKASI UTARA', 'TELUK PUCUNG', '01', '033', 4, 10, 8000, 6753600, 10.00, '082112925047', '2022_RESTORAN_0187001312022.jpeg', 0, 1, '-6.205293217499493', '107.02157467603685', 14, '2022-01-31 14:02:17', '2022-05-19 08:36:19', NULL);
INSERT INTO `restorans` VALUES (1871, 3, 'SITI AISYAH', 'P.2.02.0002473.11.02', 'RM BATANG MANGAU', 'JL. HM JOYOMARTONO NO. 47', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 1, 24, 15000, 10950000, 10.00, '0813-2714-1590', '2022_RESTORAN_0187101312022.jpg', 0, 1, '-6.258383095542092', '107.02059030532838', 10, '2022-01-31 14:03:40', '2022-06-15 10:23:35', NULL);
INSERT INTO `restorans` VALUES (1872, 2, 'ANDREAS RESHA JUNIANTO', 'P.2.02.0005223.13.05', 'HANGRY', 'RUKO EMERALD SMB UB 18', 'BEKASI UTARA', 'MARGAMULYA', '004', '011', 17, NULL, 60000, 390540000, 10.00, NULL, '2022_RESTORAN_0187202022022.jpg', 0, 1, '-6.227376656734327', '107.00430124998095', 14, '2022-01-31 14:33:01', '2022-03-18 10:22:04', NULL);
INSERT INTO `restorans` VALUES (1873, 3, 'ENDEN SITI NINGSIH', 'P.2.02.0003149.11.02', 'AYAM KALASAN', 'JL. KELURAHAN MARGAHAYU', 'BEKASI TIMUR', 'MARGAHAYU', NULL, NULL, 3, 28, 23000, 24035000, 10.00, '0895-3324-0345', '2022_RESTORAN_0187301312022.jpg', 0, 1, '-6.249456500968677', '107.00769424438478', 10, '2022-01-31 14:55:17', '2022-04-18 09:59:35', NULL);
INSERT INTO `restorans` VALUES (1874, 3, 'KELVIN SUBOWO', 'P.2.02.0005324.13.05', 'DAILY BOX / PT. SENDOK GARPU INTERNASIONAL', 'JL. PERJUANGAN NO. 3 RT. 001 RW. 001', 'BEKASI UTARA', 'MARGAMULYA', '001', '001', NULL, 3, 25000, 32950000, 10.00, NULL, '2022_RESTORAN_0187402022022.jpeg', 0, 1, '-6.23567703814686', '107.00009822845459', 14, '2022-02-02 08:48:14', '2022-05-24 08:51:58', NULL);
INSERT INTO `restorans` VALUES (1875, 2, 'EDWARD TIRTANATA', 'P.2.02.0005256.13.05', 'KOPI KENANGAN DAPUR KITCHEN BEKASI / PT. BUMI BERKAH BOGA', 'JL. PERJUANGAN 3', 'BEKASI UTARA', 'MARGAMULYA', '001', '001', 5, NULL, 30000, 174600000, 10.00, '021 50811057', '2022_RESTORAN_0187502022022.jpeg', 0, 1, '-6.235842351187423', '107.00026452541351', 14, '2022-02-02 09:07:11', '2022-05-17 09:28:07', NULL);
INSERT INTO `restorans` VALUES (1876, 3, 'ANANTO TANAMAS', 'P.2.02.0005663.13.05', 'SALAD STOP / PT. SALAD SEGAR LESTARI', 'JL. PERJUANGAN NO. 3 RT. 001 RW. 001', 'BEKASI UTARA', 'MARGAMULYA', '001', '001', 5, NULL, 76000, 27276400, 10.00, '021 3143778', '2022_RESTORAN_0187602022022.jpeg', 0, 1, '-6.235869014576184', '107.00022697448732', 14, '2022-02-02 09:23:10', '2022-05-24 08:54:40', NULL);
INSERT INTO `restorans` VALUES (1877, 3, 'WAHYUDI PRAWIRO UTOMO', 'P.2.02.0005587.13.05', 'FLASH COFFEE / PT. SEMBILAN PULUH ENAM DERAJAT', 'JL. BOULEVARD AHMAD YANI - SPRINGLAKE SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '005', '003', 3, 4, 18000, 25245000, 10.00, '085710908091', '2022_RESTORAN_0187702022022.jpeg', 0, 4, '-6.2230650994042565', '106.9993418455124', 14, '2022-02-02 09:53:05', '2022-02-14 15:05:02', '2022-02-14 15:05:02');
INSERT INTO `restorans` VALUES (1878, 1, 'BENNY HADISURJO', 'P.2.02.0002040.13.05', 'SATE KHAS SENAYAN / CV. SARI RASA NUSANTARA', 'SUMMARECON MALL BEKASI LT. DASAR FB-106', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 17, 50, 100000, 537000000, 10.00, '021 29572368', '2022_RESTORAN_0187802102022.jpeg', 1, 1, '-6.226558076833942', '107.00035572052003', 14, '2022-02-02 10:19:41', '2022-02-16 12:06:00', NULL);
INSERT INTO `restorans` VALUES (1879, 3, 'RIZVI NANDO', 'P.2.02.0003158.13.05', 'MOKKA COFFE CABANA /PT. MARCHE INTERNATIONAL', 'JL.BOULEVARD AHMAD YANI SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 20, 50000, 47190000, 10.00, '089691364502', NULL, 0, 4, '-6.226254108728462', '107.00092971324922', 14, '2022-02-02 10:33:59', '2022-02-02 10:42:53', '2022-02-02 10:42:53');
INSERT INTO `restorans` VALUES (1880, 1, 'PETRUS LEONARDUS SUDJONO', 'P.2.02.0004037.13.05', 'SERIBU RASA / PT.ARENA MULTIBOGA', 'BULEVAR TIMUR BLOK.VA NO.25', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 20, 30, 250000, 2081750000, 10.00, '021  8860296', '2022_RESTORAN_0188002022022.jpeg', 1, 1, '-6.224483624336903', '107.00236201286317', 14, '2022-02-02 10:55:10', '2022-02-16 12:06:56', NULL);
INSERT INTO `restorans` VALUES (1881, 1, 'ALIUYANTO', 'P.2.02.0002178.13.05', 'SOLARIA SUMMARECON 2 / CV. NUSA PRIMA PANGAN', 'JL. BOULEVARD AHMAD YANI SUMMARECON MALL', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 16, 90, 120000, 735240000, 10.00, '0811173020', '2022_RESTORAN_0188102102022.jpeg', 0, 1, '-6.225512852435354', '107.00185775756836', 14, '2022-02-02 11:27:45', '2022-03-18 10:26:56', NULL);
INSERT INTO `restorans` VALUES (1882, 1, 'WILLY EFFENDY', 'P.2.02.0002042.13.05', 'FOOD COURT/PT. MAKMUR ORIENT JAYA', 'FOOD COURT/PT. MAKMUR ORIENT JAYA', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 85, 350, 172000, 1890280000, 10.00, NULL, '2022_RESTORAN_0188202102022.jpeg', 1, 1, '-6.225352868925477', '107.00207233428956', 14, '2022-02-02 11:41:23', '2022-03-18 10:28:32', NULL);
INSERT INTO `restorans` VALUES (1883, 2, 'CIERTYAWATI LEO', 'P.2.02.0004836.14.01', 'KAIZA JAPANESE TACO', 'JL.AHMAD YANI METROPOLITAN MALL LT.2 KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 4, 23, 200000, 72000000, 10.00, NULL, '2022_RESTORAN_0188302022022.jpeg', 0, 1, '-6.248416654775247', '106.99072659015657', 9, '2022-02-02 14:14:48', '2022-04-13 09:46:28', NULL);
INSERT INTO `restorans` VALUES (1884, 2, 'MUHAMMAD RIVAI', 'P.2.02.0002490.13.05', 'WARUNG TEKKO', 'JL.BOULEVAR AHMAD YANI SMB UNIT BEC.01', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 7, 50, 68000, 122740000, 10.00, '021 29572366', '2022_RESTORAN_0188402022022.jpeg', 0, 1, '-6.226678064195566', '107.0007285475731', 14, '2022-02-02 14:24:46', '2022-03-18 10:30:26', NULL);
INSERT INTO `restorans` VALUES (1885, 2, 'PT.SAMALA CALAIS PEMENANG', 'P.2.02.0004572.13.05', 'CALAIS NU', 'DOWNTOWN LT.2 MALL SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, 6, 28000, 76468000, 10.00, '081388283011', '2022_RESTORAN_0188502022022.jpeg', 1, 1, '-6.2264834180173185', '107.00077414512636', 14, '2022-02-02 14:30:25', '2022-03-18 10:31:55', NULL);
INSERT INTO `restorans` VALUES (1886, 3, 'SABTA WEDYA SAHASRA SURYA', 'P.2.02.0004843.14.04', 'NGUNYA BBQ & SUKI / CV. TRITAWA SEMESTA', 'RUKAN GRAND GALAXY BLOK.RGA NO.051 KEL. JAKASETIA', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 48, 100000, 5760000, 10.00, NULL, '2022_RESTORAN_0188602022022.jpeg', 0, 1, '-6.277099653267252', '106.97459846735002', 9, '2022-02-02 14:33:19', '2022-04-13 09:51:53', NULL);
INSERT INTO `restorans` VALUES (1887, 1, 'HENDRY H BATUBARA', 'P.2.02.0003466.13.05', 'STARBUCKS COFFEE SUMMARECON BEKASI', 'JL.BOULEVARD A.YANI,SUMMARECON MALL LT.DASAR FB-119 DOWNTOWN WALK AREA', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 14, 90, 63000, 823567500, 10.00, '021 29572640', '2022_RESTORAN_0188702022022.jpeg', 1, 1, '-6.226387428094628', '107.00074732303621', 14, '2022-02-02 14:53:54', '2022-02-18 09:45:02', NULL);
INSERT INTO `restorans` VALUES (1888, 2, 'SOEGIANTO MAGARIA', 'P.2.02.0004135.13.05', 'BREWOK S', 'BULEVARD AHMAD YANI BLOK.M DWONTOWNK WALK UNIT FB.1-107 LEVEL 2', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 35, 45000, 205560000, 10.00, '021 29572828', '2022_RESTORAN_0188802022022.jpeg', 1, 1, '-6.226248775953112', '107.00103163719179', 14, '2022-02-02 15:14:39', '2022-03-18 10:33:51', NULL);
INSERT INTO `restorans` VALUES (1889, 1, 'MOERREATTA WIHARJANTO', 'P.2.02.0004246.13.050', 'NEMU CAFE', 'CLUSTER RUBY BLOK.TC 23', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, 6, 19500, 3578250, 10.00, '087780976834', '2022_RESTORAN_0188902022022.jpeg', 0, 1, '-6.226099458221306', '107.00102090835573', 14, '2022-02-02 15:25:59', '2022-05-17 09:35:54', NULL);
INSERT INTO `restorans` VALUES (1890, 1, 'SUNNY KURNIAWAN', 'P.2.02.0002201.13.05', 'REST.SUSHI TEI', 'JL.BULEVAR A.YANI BLOK.M SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 68, 144, 151000, 2393350000, 10.00, '021 29572712 / 021 72801149', '2022_RESTORAN_0189002022022.jpeg', 1, 1, '-6.226174117092508', '107.00109064579011', 14, '2022-02-02 15:44:42', '2022-02-16 12:11:03', NULL);
INSERT INTO `restorans` VALUES (1891, 2, 'TAN ALEX', 'P.2.02.0004733.13.05', 'KOI CAFE', 'JL.BULEVARD AHMAD YANI BLOK.M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 8, 50, 35000, 279692000, 10.00, '021 5818717', '2022_RESTORAN_0189102022022.jpeg', 1, 1, '-6.226419424737475', '107.00068831443788', 14, '2022-02-02 15:54:10', '2022-02-16 12:12:30', NULL);
INSERT INTO `restorans` VALUES (1892, 3, 'WAHYUDI PRAWIRO UTOMO', 'P.2.02.0005587.13.05', 'FLASH COFFEE', 'JL. BOULEVARD AHMAD YANI - SPRINGLAKE SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, NULL, 31000, 48670000, 10.00, '081119035048', '2022_RESTORAN_0189202032022.jpeg', 0, 1, '-6.22363837591901', '107.00092166662218', 14, '2022-02-03 08:53:07', '2022-05-17 09:33:06', NULL);
INSERT INTO `restorans` VALUES (1893, 3, 'INDRA. W', 'P.2.02.0005580.13.05', 'BURGER BANGOR', 'RUKO APARTEMENT SPRINGLAKE SMB', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, 3, 26000, 36010000, 10.00, '085157109988', '2022_RESTORAN_0189302032022.jpeg', 0, 1, '-6.2234570606238275', '107.00077146291734', 14, '2022-02-03 08:59:05', '2022-05-17 09:39:33', NULL);
INSERT INTO `restorans` VALUES (1894, 3, 'ARIANI', 'P.2.02.0002744.13.05', 'MIE KANGKUNG BETAWI', 'RUKO SINPANSA A-25 SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, 24, 12000, 6540000, 10.00, '021 29572226', '2022_RESTORAN_0189402032022.jpeg', 0, 1, '-6.228381881771756', '107.00209379196168', 14, '2022-02-03 09:41:40', '2022-05-17 09:41:56', NULL);
INSERT INTO `restorans` VALUES (1895, 2, 'ARIFIN KARTASASMITA', 'P.2.02.0005069.13.05', 'REST. CHLOE FAMILY KARAOKE & LOUNGE', 'RUKO SINPASA JL. BOULEVARD SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 7, 15, 40000, 68100000, 10.00, NULL, '2022_RESTORAN_0189502032022.jpeg', 0, 1, '-6.228224565513622', '107.00193017721178', 14, '2022-02-03 09:47:18', '2022-02-16 12:16:21', NULL);
INSERT INTO `restorans` VALUES (1896, 1, 'JOHANES MARDJUKI', 'P.2.02.0002537.13.05', 'HARRIS CAFFE', 'JL.BULEVAR UTARA SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 97, 120, 255000, 3822450000, 10.00, '085695352587', '2022_RESTORAN_0189602032022.jpeg', 1, 1, '-6.224963575514577', '107.00169146060944', 14, '2022-02-03 09:53:33', '2022-02-16 12:17:34', NULL);
INSERT INTO `restorans` VALUES (1897, 2, 'WIDJAYA DINATA', 'P.2.02.0002112.13.05', 'RM. SHARETEA', 'FOOD HALL SUMMARECON JL.BOULEVARD A.YANI BLOK.M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, 4, 38000, 59185000, 10.00, '085717596063', '2022_RESTORAN_0189702032022.jpeg', 0, 1, '-6.226120789328442', '107.00093507766725', 14, '2022-02-03 10:02:25', '2022-05-17 09:44:02', NULL);
INSERT INTO `restorans` VALUES (1898, 2, 'HENDRY H.BATUBARA', 'P.2.02.0003828.13.05', 'COLD STONE', 'FOOD HALLF &AMP; B02 SUMMARECON MALL BEKASI JL.BOULEVARD AHMAD YANI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, 12, 45000, 108900000, 10.00, '021 29572515', '2022_RESTORAN_0189802032022.jpeg', 1, 1, '-6.226728725517812', '107.00079560279846', 14, '2022-02-03 10:07:40', '2022-02-16 12:20:21', NULL);
INSERT INTO `restorans` VALUES (1899, 2, 'RUDIYANTO INDRA', 'P.2.02.0002961.13.05', 'MOCHI MOCHI', 'JL.BULEVAR A.YANI BLOK.M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, NULL, 30000, 29925000, 10.00, '081288300078', '2022_RESTORAN_0189902032022.jpeg', 0, 1, '-6.226515414654314', '107.00079560279846', 14, '2022-02-03 10:15:48', '2022-02-16 12:21:58', NULL);
INSERT INTO `restorans` VALUES (1900, 3, 'SALLY', 'P.2.02.0002043.13.05', 'FOODHALL/PT.PANEN LESTARI INTERNUSA', 'BOULEVAR AHMAD YANI BLOK.M LT.DASAR GF.SUMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 3, 24, 25000, 12810000, 10.00, '081998807730', '2022_RESTORAN_0190002032022.jpeg', 0, 4, '-6.226963367367572', '107.00081169605257', 14, '2022-02-03 10:15:56', '2022-05-23 09:22:30', NULL);
INSERT INTO `restorans` VALUES (1901, 1, 'SUHUD SETIA', 'P.2.02.0005422.13.05', 'SHUKAKU', 'BOULEVARD BCBD LA SPEZIA NO. 56 A-B', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 40, 68, 66000, 184140000, 10.00, '081388638690', '2022_RESTORAN_0190102032022.jpeg', 1, 1, '-6.222665138674714', '106.99741601943971', 14, '2022-02-03 10:22:17', '2022-02-18 09:19:40', NULL);
INSERT INTO `restorans` VALUES (1902, 3, 'VARIAN ERWANSA', 'P.2.02.0005318.13.05', 'SOP IKAN BATAM', 'JL. BOULEVARD SELATAN', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 7, NULL, 59000, 39412000, 10.00, '081219791802', '2022_RESTORAN_0190202032022.jpeg', 0, 1, '-6.226963367367572', '107.00076878070833', 14, '2022-02-03 10:45:34', '2022-05-18 09:01:42', NULL);
INSERT INTO `restorans` VALUES (1903, 3, 'FIKRI AL ANSTIAR', 'P.2.02.0004247.13.02', 'WARUNG NON STOP', 'JL.LINGKAR UTARA RT.007/06', 'BEKASI UTARA', 'PERWIRA', '007', '006', 5, 26, 9500, 5237350, 10.00, '081934128093', '2022_RESTORAN_0190302032022.jpeg', 0, 1, '-6.20547187256084', '107.00670182704927', 14, '2022-02-03 11:06:39', '2022-05-24 09:05:02', NULL);
INSERT INTO `restorans` VALUES (1904, 3, 'PT. KULINER DAPUR BERSAMA', 'P.2.02.0005490.13.05', 'OPPA CORNDOG', 'DAPUR KITCHEN / JL. PERJUANGAN 3', 'BEKASI UTARA', 'MARGAMULYA', '001', '001', 4, NULL, 13000, 8507200, 10.00, '081285599198', '2022_RESTORAN_0190402032022.jpeg', 0, 1, '-6.2357410302977705', '107.00003385543825', 14, '2022-02-03 11:31:42', '2022-02-18 09:27:11', NULL);
INSERT INTO `restorans` VALUES (1905, 3, 'ALI SUSANTO', 'P.2.02.0005335.13.02', 'ROTI O / PT. SEBASTIAN CITRA INDONESIA', 'KH. MUCHTAR TABRANI RT. 002 RW. 004', 'BEKASI UTARA', 'PERWIRA', '002', '004', 1, NULL, 12000, 16506000, 10.00, NULL, '2022_RESTORAN_0190502032022.jpeg', 0, 1, '-6.211860751046828', '107.00364410877229', 14, '2022-02-03 11:40:48', '2022-05-17 09:46:44', NULL);
INSERT INTO `restorans` VALUES (1906, 3, 'SUKATMI', 'P.2.02.0005161.11.02', 'BAKSO LUWES', 'JL. MAYOR OKING NO. 9B', 'BEKASI TIMUR', 'MARGAHAYU', '003', '001', 3, 100, 15000, 27375000, 10.00, NULL, '2022_RESTORAN_0190602032022.jpg', 0, 1, '-6.241553618092015', '107.00345635414125', 10, '2022-02-03 12:04:24', '2022-06-15 10:24:56', NULL);
INSERT INTO `restorans` VALUES (1907, 3, 'CARTIM/MIRRA MARYANTI', 'P.2.02.0002472.11.02', 'RM ASLI KAPAU', 'JL. HM JOYOMARTONO NO. 27 BULAK KAPAL', 'BEKASI TIMUR', 'MARGAHAYU', '002', '021', 3, 20, 15000, 15675000, 10.00, '0813-8813-9988 , 0821-1365-9555', '2022_RESTORAN_0190702042022.jpg', 0, 1, '-6.252943970034613', '107.02289700508119', 10, '2022-02-04 10:00:03', '2022-04-18 10:28:47', NULL);
INSERT INTO `restorans` VALUES (1908, 2, 'RUDI TANUJAYA', 'P.2.02.0000021.11.02', 'KFC PRATAMA', 'JL. IR. H. JUANDA BLOK A NO. 151', 'BEKASI TIMUR', 'DURENJAYA', NULL, NULL, 11, 584, 56000, 530600000, 10.00, '0812-8087-2867', '2022_RESTORAN_0190802042022.jpg', 0, 1, '-6.248773935495239', '107.01289772987367', 10, '2022-02-04 10:11:04', '2022-06-15 10:28:27', NULL);
INSERT INTO `restorans` VALUES (1909, 1, 'DALIMIN JUWONO', 'P.2.02.0005731.11.02', 'KFC JUANDA', 'JL. CUT MEUTIA', 'BEKASI TIMUR', 'MARGAHAYU', '001', '009', 23, 150, 50000, 693750000, 10.00, '0819-0531-6166', '2022_RESTORAN_0190902042022.jpg', 0, 1, '-6.249285859683794', '107.01613783836366', 10, '2022-02-04 10:29:55', '2022-04-18 10:17:15', NULL);
INSERT INTO `restorans` VALUES (1910, 1, 'RICARDO GELAEL', 'P.2.02.0000600.11.02', 'KFC CARREFOUR', 'JL. CHAIRIL ANWAR BLU PLAZA', 'BEKASI TIMUR', 'MARGAHAYU', '004', '009', 4, 120, 56639, 299053920, 10.00, '0878-8782-8513', '2022_RESTORAN_0191002042022.jpg', 0, 1, '-6.2572846100502', '107.00898170471193', 10, '2022-02-04 10:36:43', '2022-04-18 09:55:10', NULL);
INSERT INTO `restorans` VALUES (1911, 1, 'Toni', 'p.2.12345.123', 'Roti', 'JL SWATANTRA', 'JATIASIH', 'JATIASIH', '01', '01', 8, 20, 25000, 20375000, 10.00, '081800000', NULL, 0, 4, NULL, NULL, 1, '2022-02-07 07:43:52', '2022-02-07 07:47:46', '2022-02-07 07:47:46');
INSERT INTO `restorans` VALUES (1912, 3, 'OPPA CORNDOG/PT. KULINER DAPUR BERSAMA', 'P.2.02.0005513.13.01', 'OPPA CORNDOG/PT. KULINER DAPUR BERSAMA', 'JL. RAYA PD. UNGU PERMAI NO. 10 RT. 003/016', 'BEKASI UTARA', 'KALIABANG TENGAH', '003', '016', 4, NULL, 13000, 11576500, 10.00, '088212279038', '2022_RESTORAN_0191202072022.jpeg', 0, 1, '-6.180038249385634', '107.00365751981738', 14, '2022-02-07 09:03:43', '2022-05-17 09:49:13', NULL);
INSERT INTO `restorans` VALUES (1913, 2, 'IR. NATHAN CHRISTIANTO', 'P.2.02.0005602.13.05', 'SIMETRI COFFEE ROASTERS', 'KAVLING CBD SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 25, 110, 83000, 626650000, 10.00, '081295644473', '2022_RESTORAN_0191302072022.jpeg', 0, 1, '-6.223209085192365', '106.99640214443208', 14, '2022-02-07 09:23:49', '2022-05-17 09:55:38', NULL);
INSERT INTO `restorans` VALUES (1914, 3, 'DIAN PRIYADI', 'P.2.02.0004981.13.05', 'VOGEL / CV. MAJU UNGGUL PERDANA', 'JL. PERJUANGAN BARU NO.88K', 'BEKASI UTARA', 'MARGAMULYA', '003', '008', 6, 14, 18000, 9990000, 10.00, '021 89469516', '2022_RESTORAN_0191402072022.jpeg', 0, 1, '-6.2310589173099', '107.00336515903474', 14, '2022-02-07 09:34:57', '2022-05-17 09:57:19', NULL);
INSERT INTO `restorans` VALUES (1915, 2, 'EDWARD TIRTANATA', 'P.2.02.0004525.13.05', 'KOPI KENANGAN / PT.BUMI BERKAH BOGA', 'JL.BOULEVARD AHMAD YANI MALL SUMMARECON DOWNTOWN WALK', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 10, 6, 50000, 492900000, 10.00, '08170739109', '2022_RESTORAN_0191502072022.jpeg', 1, 1, '-6.225640839208175', '107.0015734434128', 14, '2022-02-07 09:48:20', '2022-05-17 09:59:00', NULL);
INSERT INTO `restorans` VALUES (1916, 3, 'RAHMA YUNITA', 'P.2.02.0005718.11.02', 'BURGER BANGOR & KOHVI', 'JL. KH AGUS SALIM NO. 80', 'BEKASI TIMUR', 'BEKASIJAYA', '008', '007', 4, 20, 18000, 26280000, 10.00, '0812-833-1463', '2022_RESTORAN_0191602072022.jpg', 0, 1, '-6.231528197033447', '107.00986683368684', 10, '2022-02-07 10:03:11', '2022-04-18 09:41:39', NULL);
INSERT INTO `restorans` VALUES (1917, 3, 'M IKHSAN SANDY TOLUHULA', 'P.2.02.0005160.13.05', 'REDDOG', 'JL. BULEVAR AHMAD YANI BLOK M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 7, NULL, 30000, 89235000, 10.00, '081226811157', '2022_RESTORAN_0191702072022.jpeg', 0, 1, '-6.225726163706053', '107.00139105319978', 14, '2022-02-07 10:05:05', '2022-05-17 10:00:25', NULL);
INSERT INTO `restorans` VALUES (1918, 2, 'EDWARD DJAJA', 'P.2.02.0005673.11.02', 'GOLDEN LAMIAN', 'JL. IR. H. JUANDA TRANSPARK', 'BEKASI TIMUR', 'MARGAHAYU', '003', '011', 10, 40, 50000, 137750000, 10.00, '0822-9820-4551', '2022_RESTORAN_0191802072022.jpg', 0, 1, '-6.247984718056692', '107.01910972595216', 10, '2022-02-07 10:24:45', '2022-04-18 09:43:21', NULL);
INSERT INTO `restorans` VALUES (1919, 1, 'PEILY DIAN LIE', 'P.2.02.0003330.13.05', 'BAKMI GM / PT.GRIYA MIESEJATI', 'BOULEVARD SELATAN TB.001', 'BEKASI UTARA', 'MARGAMULYA', '003', '005', 15, 30, 100000, 1180800000, 10.00, NULL, '2022_RESTORAN_0191902072022.jpeg', 1, 1, '-6.228077914722054', '107.00223058462146', 14, '2022-02-07 10:25:48', '2022-02-18 09:28:28', NULL);
INSERT INTO `restorans` VALUES (1920, 3, 'JAMIYO', 'P.2.02.0003798.13.02', 'BAKSO TIMBUL', 'JL.MUATIARA TENGAH', 'BEKASI UTARA', 'PERWIRA', '008', '009', 2, 26, 9500, 4148650, 10.00, '081210909564', '2022_RESTORAN_0192002072022.jpeg', 0, 1, '-6.2069117768138105', '107.00914531946184', 14, '2022-02-07 10:46:19', '2022-05-17 10:02:32', NULL);
INSERT INTO `restorans` VALUES (1921, 3, 'LEE HYUNG GEOL', 'P.2.02.0005045.13.05', 'HALO DAKGALBI INDONESIA', 'JL. BULEVAR A. YANI BLOK M SMB LT.3 UNIT R16', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 6, 40, 62000, 67282400, 10.00, '081296092253', '2022_RESTORAN_0192102072022.jpeg', 0, 1, '-6.225448859037246', '107.00162976980211', 14, '2022-02-07 11:10:47', '2022-05-17 10:04:10', NULL);
INSERT INTO `restorans` VALUES (1922, 3, 'HJ. KEMIH', 'P.2.02.0005623.11.03', 'WARUNG GABUS PUCUNG HJ. KEMIH', 'JL. PAHLAWAN GG. KENARI', 'BEKASI TIMUR', 'DURENJAYA', '006', '004', 3, 10, 20000, 23900000, 10.00, '0895-2533-9843', '2022_RESTORAN_0192202072022.jpg', 0, 1, '-6.2356983688646945', '107.02664673328401', 10, '2022-02-07 11:18:24', '2022-04-18 09:44:04', NULL);
INSERT INTO `restorans` VALUES (1923, 2, 'JUGO WIDIJATNO', 'P.2.02.0004468.13.05', 'POINT CAFE / PT.INDOMARCO PRISMATAMA', 'JL. BOULEVARD SELATAN SUMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, NULL, 22000, 159390000, 10.00, '085809037980', '2022_RESTORAN_0192302072022.jpeg', 0, 1, '-6.229043142815837', '106.99994266033173', 14, '2022-02-07 11:31:13', '2022-05-17 10:05:57', NULL);
INSERT INTO `restorans` VALUES (1924, 2, 'DEVIN WIDYA KRISNADI', 'P.2.02.0005494.13.02', 'CHATIME / PT. FOODS BEVERAGES INDONESIA', 'JL. KALIABANG NO. 67 RT. 001 RW. 006', 'BEKASI UTARA', 'PERWIRA', '001', '006', 9, NULL, 34000, 206448000, 10.00, '081284252127', '2022_RESTORAN_0192402072022.jpeg', 0, 1, '-6.203402669930042', '107.00329810380937', 14, '2022-02-07 13:41:09', '2022-05-24 09:06:18', NULL);
INSERT INTO `restorans` VALUES (1925, 3, 'JAMALUDIN HIDAYAT', 'P.2.02.0005664.13.05', 'SUPERBEE CAT CAFE', 'RUKO RUBY COMERCIAL BLOK TD 17 SMB', 'BEKASI UTARA', 'MARGAMULYA', '005', '003', 4, 10, 20000, 12412000, 10.00, '081398855440', '2022_RESTORAN_0192502092022.jpeg', 0, 1, '-6.2294164349728876', '107.00215280056001', 14, '2022-02-07 14:12:22', '2022-02-18 09:30:39', NULL);
INSERT INTO `restorans` VALUES (1926, 2, 'EKA SETIA WIJAYA', 'P.2.02.0005053.13.05', 'PT. ANEKA BINTANG BEKASI / HOLYWINGS', 'BULEVAR SMB', 'BEKASI UTARA', 'MARGAMULYA', '003', '002', 35, 270, 85000, 368687500, 10.00, NULL, '2022_RESTORAN_0192602072022.jpeg', 0, 1, '-6.225032901759547', '107.00328737497331', 14, '2022-02-07 14:28:33', '2022-05-24 09:08:48', NULL);
INSERT INTO `restorans` VALUES (1927, 3, 'BARRY WONG', 'P.2.02.0005398.13.05', 'KOPI SANJUNGAN', 'RUKO SUMMARECON BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '003', '005', 2, 10, 20000, 8200000, 10.00, '0817788993', '2022_RESTORAN_0192702072022.jpeg', 0, 1, '-6.229267118141929', '106.99954569339754', 14, '2022-02-07 14:45:20', '2022-05-24 09:10:38', NULL);
INSERT INTO `restorans` VALUES (1928, 2, 'NERISSA ARVIANNA EDISUN', 'P.2.02.0005057.13.05', 'FAT BUBBLE', 'RUKO SPRING LAKE SUMMARECON BEKASI UNIT FR.03', 'BEKASI UTARA', 'MARGAMULYA', '005', '003', 18, 50, 50000, 221775000, 10.00, '021 89465767', '2022_RESTORAN_0192802072022.jpeg', 0, 1, '-6.222627808991094', '107.00124353170396', 14, '2022-02-07 15:08:15', '2022-05-19 08:42:34', NULL);
INSERT INTO `restorans` VALUES (1929, 3, 'MUKMIN GULTOM', 'P.2.02.0005680.13.05', 'MARTABAK DJUARA', 'RAYA PERJUANGAN', 'BEKASI UTARA', 'MARGAMULYA', '001', '002', 2, 2, 30000, 12300000, 10.00, '0816843578', NULL, 0, 1, '-6.226766054910005', '107.00626462697984', 14, '2022-02-07 15:30:57', '2022-02-18 09:35:57', NULL);
INSERT INTO `restorans` VALUES (1930, 2, 'DALIMIN JUWONO/PT FAST FOOD INDONESIA', 'P.2.02.0002471.11.02', 'KFC BTC', 'JL. HM JOYOMARTONO', 'BEKASI TIMUR', 'MARGAHAYU', '003', '021', 12, 80, 55000, 521125000, 10.00, '0896-3122-5459', '2022_RESTORAN_0193002082022.jpg', 0, 4, '-6.259737535638927', '107.01989293098451', 10, '2022-02-08 08:51:32', '2022-06-10 14:04:16', NULL);
INSERT INTO `restorans` VALUES (1931, 2, 'DALIMIN JUWONO/PT FAST FOOD INDONESIA', 'P.2.02.0004364.11.02', 'KFC TRANSMART', 'JL. IR. H. JUANDA NO. 180', 'BEKASI TIMUR', 'MARGAHAYU', '003', '011', 7, 44, 53000, 283815000, 10.00, '0857-7489-0997', '2022_RESTORAN_0193102082022.jpg', 1, 1, '-6.248155359765886', '107.0180368423462', 10, '2022-02-08 09:04:29', '2022-06-10 11:15:49', NULL);
INSERT INTO `restorans` VALUES (1932, 2, 'YOPI EKA PURNAMA', 'P.2.02.00004285.11.02', 'SAKURA JAPANESSE', 'JL. IR. H. JUANDA NO. 180 TRANSPARK', 'BEKASI TIMUR', 'MARGAHAYU', '003', '011', 2, 0, 30000, 68700000, 10.00, '-', '2022_RESTORAN_0193202082022.jpg', 0, 1, '-6.248496643017333', '107.01786518096925', 10, '2022-02-08 09:28:59', '2022-06-10 10:53:11', NULL);
INSERT INTO `restorans` VALUES (1933, 3, 'BUDI HARTO WONGSO SUDIRO', 'P.2.02.0003966.13.05', 'DYNAMIC NATURAL / PT.DYNAMIC NATURAL DAMAI', 'BULEVARD A.YANI BLOK.GF 160 SMB', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 5, NULL, 56000, 112666400, 10.00, '021 29572339', '2022_RESTORAN_0193302082022.jpeg', 0, 1, '-6.226206113748358', '107.00085997581483', 14, '2022-02-08 11:08:27', '2022-05-24 09:12:13', NULL);
INSERT INTO `restorans` VALUES (1934, 3, 'MARINA KARNADI', 'P.2.02.0004646.13.05', 'HOP HOP MALL SUMMARECON', 'JL.BOULEVARD SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, NULL, 18000, 30465000, 10.00, '08595333334510', '2022_RESTORAN_0193402082022.jpeg', 0, 1, '-6.226632735639955', '107.00095117092134', 14, '2022-02-08 11:11:48', '2022-02-18 09:37:12', NULL);
INSERT INTO `restorans` VALUES (1935, 3, 'HENDRIX ALXANDER W MBOI', 'P.2.02.0004555.13.05', 'CHOPSTIX / PT. CHAMP RESTO INDONESIA', 'JL.BOULEVARD AHMAD YANI BLOK.M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 9, 60, 50000, 97305000, 10.00, '081318105722', '2022_RESTORAN_0193502082022.jpeg', 0, 1, '-6.225864815985541', '107.0011818408966', 14, '2022-02-08 11:26:04', '2022-05-19 08:45:18', NULL);
INSERT INTO `restorans` VALUES (1936, 3, 'DWI MARCH ABROR', 'P.2.02.0004819.13.05', 'ARCAIC CAFFE', 'KP. TELUK BUYUNG JL.RAYA PERJUANGAN', 'BEKASI UTARA', 'MARGAMULYA', '003', '008', 5, 30, 20000, 12220000, 10.00, '081290977900', '2022_RESTORAN_0193602092022.jpeg', 0, 1, '-6.2307816154578175', '107.00288772583008', 14, '2022-02-08 11:37:59', '2022-05-19 08:46:21', NULL);
INSERT INTO `restorans` VALUES (1937, 3, 'SUGITO', 'P.2.02.0004509.12.02', 'BAKSO OJOLALI LAMPU MERAH KRANJI', 'JL.PEMUDA KRANJI', 'BEKASI BARAT', 'KRANJI', NULL, NULL, 3, 17, 23000, 1000500, 10.00, NULL, '2022_RESTORAN_0193702092022.jpg', 0, 1, '-6.2371488556420704', '106.97422027587892', 11, '2022-02-09 11:03:35', '2022-04-12 12:52:38', NULL);
INSERT INTO `restorans` VALUES (1938, 3, 'NINDY NURFAUZIA', 'P.2.02.0005618.11.02', 'NEKAT COFFEE 168', 'JL. M. HASIBUAN', 'BEKASI TIMUR', 'MARGAHAYU', '005', '008', 4, 40, 25000, 24062500, 10.00, '0811-1687-699', '2022_RESTORAN_0193802092022.jpg', 0, 1, '-6.251493527008922', '107.00114965438843', 10, '2022-02-09 11:13:05', '2022-04-18 09:46:40', NULL);
INSERT INTO `restorans` VALUES (1939, 3, 'RICO PANGESTU', 'P.2.02.0005554.11.03', 'CAVEIN CAFE', 'JL. KARANG SATRIA NO. 15', 'BEKASI TIMUR', 'DURENJAYA', '005', '007', 3, 50, 25000, 28625000, 10.00, '0813-8104-8585', '2022_RESTORAN_0193902092022.jpg', 0, 1, '-', '-', 10, '2022-02-09 11:33:42', '2022-04-18 09:47:33', NULL);
INSERT INTO `restorans` VALUES (1940, 2, 'LEE JUNG HO', 'P.2.02.0005254.13.05', 'RESTAURANT DOOKKI / PT. BONG FOOD WORLD', 'JL. BOULEVARD AHMAD YANI BLOK M', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 16, 80, 110000, 446160000, 10.00, '081213301123', '2022_RESTORAN_0194002092022.jpeg', 0, 1, '-6.225736829267311', '107.00121939182283', 14, '2022-02-09 12:10:23', '2022-05-24 09:14:03', NULL);
INSERT INTO `restorans` VALUES (1941, 3, 'BUCCEK LUMER', 'P.2.02.0005080.13.05', 'PT. BURGER LUMER INDONESIA', 'SUMMARECON MALL BEKASI, LOBBY BASEMENT OVAL BF - IC 06 RT. 006/002', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 2, NULL, 20000, 24708000, 10.00, '081385638673', '2022_RESTORAN_0194102092022.jpeg', 0, 1, '-6.226355431449834', '107.00102627277376', 14, '2022-02-09 12:18:54', '2022-05-19 08:47:58', NULL);
INSERT INTO `restorans` VALUES (1942, 3, 'DRS. MARADUN', 'P.2.02.0005006.13.05', 'PT. PELEPAS DAHAGA ABADI / XING FU TANG', 'JL. BOULEVARD SUMMARECON MALL BEKASI', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 4, NULL, 25000, 103437500, 10.00, '08999812229', '2022_RESTORAN_0194202092022.jpeg', 0, 1, '-6.2265047491088685', '107.00046837329866', 14, '2022-02-09 12:41:39', '2022-05-19 08:49:27', NULL);
INSERT INTO `restorans` VALUES (1943, 3, 'NY. MARDIANA', 'P.2.02.0005406.13.02', 'THE BOBA TIME INDONESIA PERWIRA/ PT LANGKAH INGIN TERDEPAN', 'KH. MUCHTAR TABRANI RT 03 RW 03', 'BEKASI UTARA', 'PERWIRA', '003', '003', 2, NULL, 28000, 20524000, 10.00, '081277915001', '2022_RESTORAN_0194302092022.jpeg', 0, 1, '-6.214516539158612', '107.00330883264543', 14, '2022-02-09 12:57:15', '2022-05-24 09:15:20', NULL);
INSERT INTO `restorans` VALUES (1944, 2, 'ARDIANTO KRESNAWAN', 'P.2.02.0003861.13.05', 'BAKSO LAPANGAN TEMBAK SENAYAN / PT.KYATI SELERA YASA', 'JL.BOULEVARD AHMAD YANI BLOK.M SUMMARECON', 'BEKASI UTARA', 'MARGAMULYA', '006', '002', 8, 60, 50000, 123480000, 10.00, NULL, '2022_RESTORAN_0194402102022.jpeg', 1, 1, '-6.22523021486825', '107.00192481279375', 14, '2022-02-10 08:47:54', '2022-05-24 09:15:58', NULL);
INSERT INTO `restorans` VALUES (1945, 2, 'JEMMY WANTONO', 'P.2.02.0004471.12.02', 'ROTI O', 'JL.JENDRAL SUDIRMAN STASIUN KRANJI', 'BEKASI BARAT', 'KRANJI', NULL, NULL, 2, 10, 15000, 40275000, 10.00, NULL, '2022_RESTORAN_0194502102022.jpg', 0, 1, '-6.228616522882737', '106.98246002197267', 11, '2022-02-10 09:14:09', '2022-04-12 12:53:52', NULL);
INSERT INTO `restorans` VALUES (1946, 2, 'OKTA WIRAWAN, SE', 'P.2.02.0005307.12.01', 'KEDAI ABUYA', 'L. BINTARA RAYA RT. 013/010', 'BEKASI BARAT', 'BINTARA', '013', '010', 7, 14, 35000, 7805000, 10.00, '08118888999', NULL, 0, 4, '-6.229299114609273', '106.97490692138673', 11, '2022-02-16 08:50:38', '2022-02-16 09:09:02', '2022-02-16 09:09:02');
INSERT INTO `restorans` VALUES (1947, 2, 'FAN ANDREW', 'P.2.02.0005785.12.01', 'KEBAB MONSTER / PT. BERKARYA INDONESIA SEJAHTERA ANDAL', 'JL. BINTARA NO. 12 RT. 004 RW. 013', 'BEKASI BARAT', 'BINTARA', '004', '013', 2, 0, 25000, 96075000, 10.00, '08211523322', '2022_RESTORAN_0194702182022.jpg', 0, 1, '-6.231005590042038', '106.97971343994142', 11, '2022-02-18 12:18:54', '2022-04-12 13:41:14', NULL);
INSERT INTO `restorans` VALUES (1948, 3, 'ANKUSH GROVER/MAHARDIKA', 'P.2.02.0005694.11.02', 'DAPUR BERSAMA BEKASI TIMUR/PT REBEL GO FOOD INDONESIA', 'JL. CUT MEUTIA BLOK B1-B3', 'BEKASI TIMUR', 'MARGAHAYU', '001', '009', 13, 0, 116005, 33873460, 10.00, '0856-9431-4437', '2022_RESTORAN_0194802222022.jpg', 0, 1, '-6.250970939933065', '107.01383113861085', 10, '2022-02-22 14:39:55', '2022-04-18 09:48:10', NULL);
INSERT INTO `restorans` VALUES (1949, 1, 'ARIEF DIMAS DWIPUTRO', 'P.2.02.0005579.22.04', 'YAMBOK', 'JL. RAYA HANKAM NO. 365', 'PONDOKMELATI', 'JATIMURNI', '003', '005', 6, 50, 55000, 57337500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-02-23 10:29:59', '2022-04-11 11:28:15', NULL);
INSERT INTO `restorans` VALUES (1950, 2, 'LENDY SUSANTO', 'P.2.02.0005476.22.04', 'DAPUR COKELAT PICK UP POINT HANKAM', 'JL. RAYA HANKAM', 'PONDOKMELATI', 'JATIMURNI', '007', '004', 2, 0, 130000, 62400000, 10.00, NULL, NULL, 0, 1, '-6.3157324', '106.9304111', 20, '2022-02-23 10:40:39', '2022-04-11 11:32:01', NULL);
INSERT INTO `restorans` VALUES (1951, 2, 'PT. SEBATISAN CITRA INDONESIA', 'P.2.02.0005267.22.01', 'ROTI O', 'JL. RAYA KP. SAWAH NO. 13', 'PONDOKMELATI', 'JATIMELATI', '001', '004', 2, 2, 30000, 29970000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-02-23 10:50:22', '2022-04-11 11:37:33', NULL);
INSERT INTO `restorans` VALUES (1952, 2, 'AYAM MANTUL / PT.RASA DAPUR SEDAP', 'P.2.02.0004348.22.01', 'AYAM MANTUL / PT.RASA DAPUR SEDAP', 'PERUM. PURIGADING', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 1, 20, 52000, 56472000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-02-23 10:59:01', '2022-04-11 11:35:43', NULL);
INSERT INTO `restorans` VALUES (1953, 2, 'JANJI JIWA PURI GADING', 'P.2.02.0005620.22.01', 'JANJI JIWA PURI GADING', 'JL. RAYA PURIGADING', 'PONDOKMELATI', 'JATIMELATI', '004', '007', 4, 25, 50000, 62000000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-02-23 11:04:45', '2022-02-23 11:04:45', NULL);
INSERT INTO `restorans` VALUES (1954, 2, 'SOTO SEDAAP BOYOLALI HJ.WIDODO', 'P.2.02.0003575.22.01', 'SOTO SEDAAP BOYOLALI HJ.WIDODO', 'RUKO PT.DUTA PUTRA PURI GADING BLOK.1/5', 'PONDOKMELATI', 'JATIMELATI', '004', '007', 12, 12, 30000, 69000000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-02-23 11:39:04', '2022-04-11 11:38:14', NULL);
INSERT INTO `restorans` VALUES (1955, 2, 'SEA FOOD 99 JT.RAHAYU', 'P.2.02.0000312.22.04', 'SEA FOOD 99 JT.RAHAYU', 'JL. RAYA PONDOK GEDE (PASAR)', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 18, 50, 60000, 123900000, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-02-23 11:50:14', '2022-04-11 11:41:51', NULL);
INSERT INTO `restorans` VALUES (1956, 2, 'HUSNI ROHMAN AZIZ', 'P.2.02.0003055.12.05', 'WARUNG SEBLAK ABDUL', 'BINTARA RAYA NO.23', 'BEKASI BARAT', 'BINTARA', '004', '013', 8, 40, 15000, 3420000, 10.00, NULL, '2022_RESTORAN_0195602242022.jpg', 0, 1, '-6.2299817054481945', '106.97559356689455', 11, '2022-02-24 10:48:21', '2022-04-12 12:55:54', NULL);
INSERT INTO `restorans` VALUES (1957, 2, 'MARSHA', 'P.2.02.0003425.12.02', 'SARI IDAMAN BINTARA', 'JL.BINTARA RAYA 0-1', 'BEKASI BARAT', 'KRANJI', NULL, NULL, 6, 40, 70000, 77910000, 10.00, NULL, '2022_RESTORAN_0195704012022.jpg', 0, 1, '-6.2361249830392875', '106.9680404663086', 11, '2022-02-24 12:26:35', '2022-04-12 12:57:17', NULL);
INSERT INTO `restorans` VALUES (1958, 2, 'JOHANNES PAULUS ARIFIN', 'P.2.02.0005752.11.02', 'HOKBEN KITCHEN KARTINI', 'JL. RA KARTINI RT 04/03 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '004', '003', 8, 14, 37000, 142450000, 10.00, '0815-1558-2790', '2022_RESTORAN_0195803082022.jpg', 0, 1, '-6.2515255221190476', '106.99939012527467', 10, '2022-03-08 11:32:01', '2022-04-18 09:48:49', NULL);
INSERT INTO `restorans` VALUES (1959, 2, 'ISHAK ROHATTA BESTELINE', 'P.2.02.0002986.11.01', 'RUMAH MAKAN KOMA/KOMA JUNKYARD', 'JL. BARU PATAL BEKASI TIMUR', 'BEKASI TIMUR', 'BEKASIJAYA', '06', '07', 12, 60, 25000, 45625000, 10.00, '0899-7861-371/0878-8805-6782', '2022_RESTORAN_0195903092022.jpeg', 0, 1, '-6.23456', '107.0064', 10, '2022-03-09 11:21:41', '2022-04-14 08:39:37', NULL);
INSERT INTO `restorans` VALUES (1960, 2, 'JOHANNES PAULUS ARIFIN/HENDRA ARIFIN', 'P.2.02.0005456.11.04', 'HOKA HOKA BENTO KITCHEN PERUMNAS 3', 'JL. NUSANTARA RAYA BLOK A4 NO. 10 AREN JAYA', 'BEKASI TIMUR', 'ARENJAYA', '009', '004', 8, 0, 40000, 428000000, 10.00, '021-82781110', '2022_RESTORAN_0196003092022.jpg', 0, 1, '-6.243654666070923', '107.02917337417604', 10, '2022-03-09 11:45:32', '2022-04-18 09:31:46', NULL);
INSERT INTO `restorans` VALUES (1961, 2, 'SPV TRIYONO', 'P.2.02.0004333.12.01', 'PEMPEK GABY EXSPRESS ST.CAKUNG', 'JL.PASAR PAGI BINTARA I GUSTI NGURAHRAY RT.03/015', 'BEKASI BARAT', 'BINTARA', '03', '015', 2, 8, 50000, 89000000, 10.00, '081381154672', '2022_RESTORAN_0196103102022.jpg', 0, 1, '-6.229299114609273', '106.9783401489258', 11, '2022-03-10 10:40:22', '2022-04-12 13:43:26', NULL);
INSERT INTO `restorans` VALUES (1962, 2, 'Hendry', 'P.2.02.0003361.19.01', 'Chatttime', 'LINCS SQUARE BOJONG RAWALUMBU', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 8, 6, 50000, 351500000, 10.00, '081394537748', '2022_RESTORAN_0196203142022.jpg', 1, 1, '-6.277632878686719', '106.99054956436159', 19, '2022-03-14 09:16:15', '2022-04-14 08:23:44', NULL);
INSERT INTO `restorans` VALUES (1963, 3, 'BU LENI', 'P.2.02.0003222.11.02', 'NASI KAPAU PAK THAMRIN', 'JL. MAYOR OKING NO. 10 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '002', '002', 3, 20, 20000, 17250000, 10.00, '0813-1833-9322', '2022_RESTORAN_0196303142022.jpg', 0, 1, '-6.243185397202558', '107.00200796127321', 10, '2022-03-14 12:44:55', '2022-04-18 09:32:35', NULL);
INSERT INTO `restorans` VALUES (1964, 1, 'PT Sari Melati Kencana', 'P.2.02.0000671.19.01', 'Pizza Hut Kemang Pratama', 'GD. LINCSQUARE LT. 2 PERUM KEMANG PRATAMA BLOK AN-45', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 26, 108, 150000, 885000000, 10.00, '08113249210', '2022_RESTORAN_0196403142022.jpg', 1, 1, '-6.2778888266941735', '106.9910216331482', 19, '2022-03-14 14:23:08', '2022-04-14 08:25:44', NULL);
INSERT INTO `restorans` VALUES (1965, 1, 'PT. Sari Coffee Indonesia', 'P.2.02.0003569.19.01', 'Starbucks Coffee', 'RUKO KEMANG PRATAMA 1 BEKASI', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 10, 50, 75000, 486750000, 10.00, '021-82425794', '2022_RESTORAN_0196503142022.jpg', 1, 1, '-6.277931484683192', '106.99089288711549', 19, '2022-03-14 14:38:41', '2022-04-14 08:31:20', NULL);
INSERT INTO `restorans` VALUES (1966, 1, 'Zaina Siman', 'P.2.02.0003661.19.01', 'A & W Restoran', 'JL. RAYA PEMUDA SILIWANGI BEKASI 17116', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 10, 82, 100000, 392000000, 10.00, '081808494308', '2022_RESTORAN_0196603142022.jpg', 0, 1, '-6.277931484683192', '106.99115037918092', 19, '2022-03-14 14:51:59', '2022-04-14 08:34:40', NULL);
INSERT INTO `restorans` VALUES (1991, 3, 'WILLIAM', 'P.2.02.0001978.11.02', 'RESTORAN AFUI', 'JL. RA KARTINI NO. 30 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '003', '003', 4, 24, 25000, 26137500, 10.00, '021-8803844/0813-1774-0834', '2022_RESTORAN_0199103212022.jpg', 0, 1, '-6.245126461157626', '107.0037889480591', 10, '2022-03-21 12:31:12', '2022-04-18 09:33:36', NULL);
INSERT INTO `restorans` VALUES (1992, 2, 'HERI LISMANTO', 'P.2.02.0004065.11.02', 'BAKSO RAKSASA', 'JL. HM JOYOMARTONO NO. 20 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '002', '021', 6, 32, 25000, 48125000, 10.00, '0813-2880-0705', '2022_RESTORAN_0199203212022.jpg', 0, 1, '-6.2513122213478685', '107.0236372947693', 10, '2022-03-21 12:35:26', '2022-04-18 09:34:22', NULL);
INSERT INTO `restorans` VALUES (1993, 3, 'BPK. SAIMAN/IBU EVA', 'P.2.02.0001967.11.04', 'RUMAH MAKAN SEA FOOD 99', 'JL. NUSANTARA RAYA NO. 16 BEKASI TIMUR', 'BEKASI TIMUR', 'ARENJAYA', '004', '011', 3, 12, 20000, 15600000, 10.00, '0819-3248-6522', '2022_RESTORAN_0199303232022.jpg', 0, 1, '-6.243292049255019', '107.02776789665224', 10, '2022-03-23 15:23:13', '2022-04-18 09:34:59', NULL);
INSERT INTO `restorans` VALUES (1994, 3, 'EDWARD DJAJA', 'P.2.02.0005716.11.02', 'WOY MAKARONI/PT TUJUH RITEL INDONESIA', 'JL. IR. H. JUANDA RAMAYANA BEKASI TIMUR', 'BEKASI TIMUR', 'DURENJAYA', '001', '001', 2, 0, 15000, 62250000, 10.00, '0822-9820-4551/021-88079677', '2022_RESTORAN_0199403252022.jpg', 0, 1, '-6.2482193503924846', '107.01211452484132', 10, '2022-03-25 12:25:46', '2022-04-18 09:52:15', NULL);
INSERT INTO `restorans` VALUES (1995, 3, 'EDWARD DJAJA', 'P.2.02.0005717.11.02', 'HEY KAFE', 'JL. IR. H. JUANDA RAMAYANA BEKASI TIMUR', 'BEKASI TIMUR', 'DURENJAYA', '001', '001', 2, 0, 15000, 54750000, 10.00, '0822-9820-4551', '2022_RESTORAN_0199503252022.jpg', 0, 1, '-6.248496643017333', '107.0123291015625', 10, '2022-03-25 12:34:06', '2022-04-18 09:52:53', NULL);
INSERT INTO `restorans` VALUES (1996, 2, 'EDWARD DJAJA', 'P.2.02.0005854.12.01', 'HEY CAFE', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 4, 0, 50000, 42625000, 10.00, NULL, '2022_RESTORAN_0199604012022.jpg', 0, 1, '-6.230323000534752', '106.97490692138673', 11, '2022-04-01 14:22:37', '2022-06-09 08:52:35', '2022-06-09 08:52:35');
INSERT INTO `restorans` VALUES (1997, 2, 'YOSHUA EDWARD MANGIRI', 'P.2.02.0005658.14.01', 'KALA BUMI BKS', 'JL. IRIGASI NO. 53 RT. 005 RW. 012  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', '005', '012', 5, 30, 30000, 50550000, 10.00, NULL, '2022_RESTORAN_0199704042022.jpg', 0, 1, '-6.265795145995659', '106.98130667209627', 9, '2022-04-04 09:36:54', '2022-04-13 09:58:37', NULL);
INSERT INTO `restorans` VALUES (1998, 2, 'PT. TRANS BURGER', 'P2.02.0001787.14.01', 'WENDY\'S', 'JL.A.YANI PEKAYON JAYA  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 4, 156, 40000, 39000000, 10.00, '021 8848260', '2022_RESTORAN_0199804052022.jfif', 0, 1, NULL, NULL, 9, '2022-04-05 11:56:53', '2022-04-13 10:05:46', NULL);
INSERT INTO `restorans` VALUES (1999, 3, 'BU ISMI', 'P.02.0001001.15.05', 'PONDOK CITRA', 'JL RAYA PORPOSTEL NO 85', 'JATIASIH', 'JATILUHUR', '001', '007', 8, 24, 15000, 8242500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 15, '2022-04-07 14:49:46', '2022-04-13 08:58:08', NULL);
INSERT INTO `restorans` VALUES (2000, 2, 'NDI ISVANDIAR MULUK', 'P.2.02.0005855.17.02', 'KOKUJA COFFEE', 'JL. RAYA NAROGONG KM.12,5', 'BANTARGEBANG', 'BANTARGEBANG', '002', '001', 5, 10, 20000, 26500000, 10.00, NULL, '2022_RESTORAN_0200006072022.jpeg', 0, 1, '-6.346691604277331', '106.98554992675783', 13, '2022-04-08 09:04:48', '2022-06-08 08:00:19', NULL);
INSERT INTO `restorans` VALUES (2001, 1, 'PT Rekso Nasional Food', 'P.2.02.0001886.19.03', 'Mc Donald\'s', 'JL RAYA CUT MUTIA', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '001', 40, 184, 150000, 2028750000, 10.00, NULL, '2022_RESTORAN_0200104132022.jpg', 1, 1, '-6.260284109880297', '107.00216084718706', 19, '2022-04-13 08:41:53', '2022-04-21 13:20:19', NULL);
INSERT INTO `restorans` VALUES (2002, 1, 'Tony Nugroho', 'P.2.02.0005696.19.03', 'Pempek Gaby', 'JL CUT MUTIA', 'RAWALUMBU', 'SEPANJANGJAYA', '004', '001', 106, 120, 100000, 1350000000, 10.00, '081574255609', '2022_RESTORAN_0200204132022.jpg', 0, 1, '-6.25940959081958', '106.99532657861711', 19, '2022-04-13 09:00:55', '2022-04-21 13:21:27', NULL);
INSERT INTO `restorans` VALUES (2003, 1, 'PT Sari Burger Indonesia', 'P.2.02.0004363.19.03', 'Burger King / PT. Sari Burger Indonesia', 'JL CUT MUTIA', 'RAWALUMBU', 'SEPANJANGJAYA', '003', '001', 18, 150, 100000, 448500000, 10.00, NULL, '2022_RESTORAN_0200304132022.jpg', 0, 1, '-6.2836961', '106.965341', 19, '2022-04-13 09:19:37', '2022-04-21 13:22:28', NULL);
INSERT INTO `restorans` VALUES (2004, 2, 'EDWARD', 'P.2.02.0005865.12.01', 'WOY MACARONI / PT TUJUH RITEL INDONESIA', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, NULL, NULL, NULL, 0, 10.00, NULL, NULL, 0, 4, '-6.2299817054481945', '106.98108673095705', 11, '2022-04-18 09:18:08', '2022-04-18 09:22:33', '2022-04-18 09:22:33');
INSERT INTO `restorans` VALUES (2005, 2, 'EDWARD DJAJA', 'P.2.02.0005865.12.01', 'WOY MACARONI / PT. TUJUH RITEL INDONESIA', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 4, 0, 25000, 24325000, 10.00, NULL, '2022_RESTORAN_0200504182022.jpg', 0, 1, '-6.2204253529641', '106.96392059326173', 11, '2022-04-18 09:29:47', '2022-06-08 09:43:42', NULL);
INSERT INTO `restorans` VALUES (2006, 2, 'dewi', 'p.werf3f', 'uptdselatan', 'BEKASI', 'BEKASI SELATAN', 'PEKAYONJAYA', '22', '12', 22, 50, 100000, 202500000, 10.00, '1234', NULL, 0, 4, '-6.2685184', '106.9645824', 9, '2022-04-18 10:31:03', '2022-04-18 10:48:27', '2022-04-18 10:48:27');
INSERT INTO `restorans` VALUES (2007, 3, 'BANGKIT LUHUR GUMILAR', 'P.2.02.0005725.14.02', 'RAGIL COFFEE & ROASTERY', 'JL. AHMAD YANI NO.5', 'BEKASI SELATAN', 'MARGAJAYA', '004', '005', 2, 16, 15000, 1468500, 10.00, NULL, '2022_RESTORAN_0200704182022.jpg', 0, 1, NULL, NULL, 9, '2022-04-18 10:39:44', '2022-05-10 08:29:58', NULL);
INSERT INTO `restorans` VALUES (2008, 2, 'PRAWIRA', 'P.2.02.0005530.14.04', 'PT BELAH DOEREN INTERNASIONAL/BELAH DOEREN', 'RUKAN GALAXY BLOK RGA NO.056', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 8, 100000, 51250000, 10.00, NULL, '2022_RESTORAN_0200804182022.jfif', 0, 1, NULL, NULL, 9, '2022-04-18 11:00:55', '2022-05-10 08:39:51', NULL);
INSERT INTO `restorans` VALUES (2009, 3, 'SUKOWATI SOSRODJOJO', 'P.2.02.0005619.11.02', 'MC DONALDS TRANSPARK JUANDA', 'JL. IR. H. JUANDA NO. 180 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '003', '001', 2, 0, 15000, 64200000, 10.00, NULL, '2022_RESTORAN_0200904182022.jpg', 0, 1, '-6.248198020184479', '107.0181441307068', 10, '2022-04-18 11:24:53', '2022-06-15 10:32:03', NULL);
INSERT INTO `restorans` VALUES (2010, 2, 'ATJEP LUKMAN HAKIM', 'P.2.02.0004776.14.01', 'BAKMI TOPIA / PT.INDOSTERLING WAHANA BOGA', 'JL.A.YANI METROPOLITAN MALL LT.II KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 7, 21, 53000, 83475000, 10.00, '087800158986', '2022_RESTORAN_0201004182022.jpg', 0, 1, NULL, NULL, 9, '2022-04-18 11:37:54', '2022-05-10 08:36:47', NULL);
INSERT INTO `restorans` VALUES (2011, 1, 'PT SARI COFFEE INDONESIA', 'P.2.02.0005841.11.01', 'STARBUCKS JUANDA', 'JL. IR. H. JUANDA NO. 98 B BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '001', '005', 10, 50, 100000, 365000000, 10.00, '021-82679888', '2022_RESTORAN_0201104182022.jpg', 0, 4, '-6.243612005282088', '107.00576305389406', 10, '2022-04-18 11:59:00', '2022-04-18 12:07:13', NULL);
INSERT INTO `restorans` VALUES (2012, 2, 'ATJEP LUKMAN HAKIM', 'P.2.02.0004776.14.01', 'BAKMI TOPIA / PT.INDOSTERLING WAHANA BOGA', 'JL.A.YANI METROPOLITAN MALL LT.II KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', '008', '002', 7, 21, 50000, 63850000, 10.00, '0', '2022_RESTORAN_0201204202022.jpg', 1, 4, '-6.248348019021307', '106.9913322929552', 9, '2022-04-20 09:39:33', '2022-04-20 09:40:07', '2022-04-20 09:40:07');
INSERT INTO `restorans` VALUES (2013, 3, 'SHELLY SILVANA', 'P.2.02.0005637.14.04', 'JENIUS KOPI', 'GRAND GALAXY RSK 2 NO. 63', 'BEKASI SELATAN', 'JAKASETIA', '004', '017', 2, 20, 25000, 1437500, 10.00, '0', '2022_RESTORAN_0201304202022.jpg', 0, 1, '-6.273686108834853', '106.97549373381123', 9, '2022-04-20 09:52:10', '2022-05-10 08:40:53', NULL);
INSERT INTO `restorans` VALUES (2014, 3, 'Elliyati Salim', 'P.2.02.0000670.19.01', 'Bubur Ayam Jakarta', 'RUKO KEMANG PRATMA BLOK AL NO 2-3', 'RAWALUMBU', 'BOJONG RAWALUMBU', NULL, NULL, 14, 32, 25000, 15062500, 10.00, '021-8209713', '2022_RESTORAN_0201404222022.jpg', 0, 1, '-6.277190301627075', '106.98981463909149', 19, '2022-04-22 07:47:47', '2022-04-25 13:15:01', NULL);
INSERT INTO `restorans` VALUES (2015, 3, 'Ir. Norman Syafri', 'P.2.02.0000261.19.01', 'Restoran Empal Gentong', 'JL KEMANG PRATAMA RAYA RUKO KEMANG PRATAMA BLOK AL-6', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 6, 44, 25000, 10825000, 10.00, '021-82422666', '2022_RESTORAN_0201504222022.jpg', 0, 1, '-6.277414256330768', '106.99029743671419', 19, '2022-04-22 08:00:43', '2022-04-25 13:14:31', NULL);
INSERT INTO `restorans` VALUES (2016, 3, 'Hayati', 'P.2.02.0000270.19.02', 'Rumah Makan Ibu Wati', 'RAWAPANJANG', 'RAWALUMBU', 'SEPANJANGJAYA', '01', '04', 4, 20, 35000, 12425000, 10.00, '087878233339', '2022_RESTORAN_0201604222022.jpg', 0, 1, '-6.25756723032459', '106.9963163137436', 19, '2022-04-22 08:20:25', '2022-04-25 13:20:26', NULL);
INSERT INTO `restorans` VALUES (2017, 3, 'H. Sardi', 'P.2.02.0000267.19.01', 'Soto Kudus Semarak', 'KEMANG PRATAMA RAYA BLOK AN NO.37', 'RAWALUMBU', 'BOJONG RAWALUMBU', '04', '01', 8, 25, 25000, 11112500, 10.00, '08128021173', '2022_RESTORAN_0201704222022.jpg', 0, 1, '-6.277712862452568', '106.99011504650117', 19, '2022-04-22 08:28:46', '2022-04-25 13:23:08', NULL);
INSERT INTO `restorans` VALUES (2018, 3, 'R. Okie Rachmayanto', 'P.2.02.0004473.19.01', 'Janji Jiwa  Rawalumbu', 'JL. DASA DARMA NO. 7B', 'RAWALUMBU', 'PENGASINAN', '001', '004', 5, 10, 20000, 13450000, 10.00, '085289692294', '2022_RESTORAN_0201804222022.jpg', 0, 1, '-6.272881820967404', '107.00136959552765', 19, '2022-04-22 09:21:47', '2022-04-25 13:30:50', NULL);
INSERT INTO `restorans` VALUES (2019, 3, 'SRI HARTANTO', 'P.2.02.0002734.14.01', 'SOTO KWALI SEGER', 'JL.PEKAYON JAYA KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', '004', '020', 4, 12, 25000, 2097500, 10.00, '081315876098', '2022_RESTORAN_0201904252022.jfif', 0, 1, NULL, NULL, 9, '2022-04-25 08:29:00', '2022-05-10 08:41:47', NULL);
INSERT INTO `restorans` VALUES (2020, 3, 'H, GUNTUR', 'P.2.02.0002762.14.01', 'RM.KHAS JAKARTA', 'JL.PEKAYON  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', '001', '002', 4, 40, 50000, 15525000, 10.00, '081296967381', '2022_RESTORAN_0202004252022.jfif', 0, 1, NULL, NULL, 9, '2022-04-25 08:39:33', '2022-05-10 08:42:57', NULL);
INSERT INTO `restorans` VALUES (2021, 2, 'DALIMIN JUWON', 'P.2.02.0004185.14.01', 'KFC LAGOON AVENUE / PT.FAST FOOD INDONESIA', 'JL.KH.NOER ALI  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', '006', '003', 7, 48, 38000, 20725200, 10.00, '0', '2022_RESTORAN_0202104252022.jpg', 1, 1, '-6.251524633257522', '106.97863931087218', 9, '2022-04-25 09:29:53', '2022-05-10 08:44:36', NULL);
INSERT INTO `restorans` VALUES (2022, 2, 'KUSNADI RAHARDJA', 'P.2.02.0002078.14.05', 'PEPPER LUNCH / PT. BOGA MAKMUR PRIMA', 'GRAND METROPOLTAN JL. KH. NOER ALI', 'BEKASI SELATAN', 'PEKAYONJAYA', '007', '003', 15, 70, 120000, 50940000, 10.00, '0', '2022_RESTORAN_0202204252022.jfif', 0, 1, '-6.249284970004777', '106.98420444560362', 9, '2022-04-25 09:36:58', '2022-05-10 08:46:19', NULL);
INSERT INTO `restorans` VALUES (2023, 2, 'JASON J LAMUDA', 'P.2.02.0005461.14.01', 'D\'COST MALL METROPOLITAN / PT. PENDEKAR BODOH', 'MALL METROPOLITAN JL. KH. NOER ALI', 'BEKASI SELATAN', 'PEKAYONJAYA', '008', '002', 14, 56, 50000, 33680000, 10.00, '0', '2022_RESTORAN_0202304252022.jfif', 1, 1, '-6.248561521655079', '106.99071630931316', 9, '2022-04-25 09:56:23', '2022-05-10 08:47:21', NULL);
INSERT INTO `restorans` VALUES (2024, 3, 'SARDIWAN', 'P.2.02.0002817.14.01', 'RM.BEBEK OBAMA', 'PULO RIBUNG BLOK.AE NO.3', 'BEKASI SELATAN', 'PEKAYONJAYA', '011', '013', 7, 28, 15000, 691500, 10.00, '085210041182', '2022_RESTORAN_0202404262022.jpg', 0, 1, '-6.26676030453337', '106.97320640087129', 9, '2022-04-26 08:43:37', '2022-05-10 08:49:12', NULL);
INSERT INTO `restorans` VALUES (2025, 2, 'DALIMIN JUWONO', 'P.2.02.0004184.14.05', 'KFC CYBER PARK / PT.FAST FOOD INDONESIA', 'JL.KH.NOER ALI', 'BEKASI SELATAN', 'KAYURINGINJAYA', '001', '005', 7, 130, 65000, 58175000, 10.00, '08117156851', '2022_RESTORAN_0202504262022.jpg', 1, 1, '-6.246758229134829', '106.99127912521364', 9, '2022-04-26 08:55:57', '2022-05-10 08:50:42', NULL);
INSERT INTO `restorans` VALUES (2026, 2, 'DALIMIN JUWONO', 'P.2.02.0003722.14.01', 'KFC BOX NAGA PEKAYON / PT.FAST FOOD INDONESIA', 'JL.RAYA PEKAYON NO.29 KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 7, 40, 50000, 16580000, 10.00, '08117156864', '2022_RESTORAN_0202604262022.jpg', 0, 1, NULL, NULL, 9, '2022-04-26 08:57:35', '2022-05-10 08:52:16', NULL);
INSERT INTO `restorans` VALUES (2027, 3, 'PT USAHA SARI BOGA / BROOASTER CHICKEN', 'P.2.02.0001535.14.02', 'BROOASTER CHICKEN / PT USAHA SARI BOGA', 'LG FLOOR PINTU GELATIK MEGA BEKASI HYPERMALL KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 5, 48, 20000, 2842000, 10.00, '087721813306', '2022_RESTORAN_0202704262022.jpg', 0, 1, NULL, NULL, 9, '2022-04-26 09:16:07', '2022-05-10 08:53:11', NULL);
INSERT INTO `restorans` VALUES (2028, 2, 'GIOVANI ANGGASTA', 'P.2.02.0005842.11.02', 'DEAR BUTTER', 'JL. IR. H. JUANDA TRANSPARK BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '003', '011', 3, 0, 30000, 28875000, 10.00, '0878-8075-8889', '2022_RESTORAN_0202804262022.jpg', 0, 1, '-6.248411322225335', '107.01760768890382', 10, '2022-04-26 11:12:40', '2022-06-15 12:13:34', NULL);
INSERT INTO `restorans` VALUES (2029, 2, 'ANDRIES', 'P.2.02.0005592.11.02', 'SAUNG LESUNG', 'JL. HM JOYOMARTONO NO. 47 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '003', '021', 5, 24, 30000, 20400000, 10.00, '0859-2063-5665', '2022_RESTORAN_0202904262022.jpg', 0, 1, '-6.260014822154807', '107.01957106590272', 10, '2022-04-26 11:53:50', '2022-06-15 12:12:51', NULL);
INSERT INTO `restorans` VALUES (2030, 3, 'IPIK SUHENDAR', 'P.2.02.0002027.11.02', 'SOTO KUDUS KARTINI', 'JL. RA KARTINI BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '006', '001', 3, 24, 20000, 15600000, 10.00, '021-8826424', '2022_RESTORAN_0203004262022.jpg', 0, 1, '-6.2540371321563235', '106.99802219867708', 10, '2022-04-26 12:11:27', '2022-06-15 10:37:28', NULL);
INSERT INTO `restorans` VALUES (2031, 3, 'Ani Setyowati', 'P.2.02.0004123.19.01', 'Bakso Rusuk Joss', 'JL TRISATYA NO. 28 PERUMAHAN RAWALUMBU BEKASI JEMBATAN 3', 'RAWALUMBU', 'BOJONG RAWALUMBU', '007', '006', 5, 50, 30000, 12975000, 10.00, '08161669198', '2022_RESTORAN_0203105102022.jpg', 0, 1, '-6.270988850999508', '107.00167536735536', 19, '2022-05-10 14:52:59', '2022-05-17 09:16:37', NULL);
INSERT INTO `restorans` VALUES (2032, 3, 'Ani Setyowati', 'P.2.02.0004864.19.01', 'Princess Place', 'RUKO GARDENIA RESIDENCE BLOK RA 39-40 KAWASAN PESONA METROPOLITAN BEKASI JL. RAYA NAROGONG KM 7', 'RAWALUMBU', 'BOJONG RAWALUMBU', '005', '002', 3, 50, 30000, 8670000, 10.00, '08161669198', '2022_RESTORAN_0203205102022.jpg', 0, 1, '-6.2914885496840665', '106.98614269495012', 19, '2022-05-10 15:03:08', '2022-05-17 09:16:54', NULL);
INSERT INTO `restorans` VALUES (2033, 3, 'Nuryanto', 'P.2.02.0004132.19.02', 'Lets Go Chicken Pramuka', 'JL PRAMUKA 27 RAWALUMBU', 'RAWALUMBU', 'PENGASINAN', '001', '008', 2, 0, 12000, 6570000, 10.00, '081288115680', '2022_RESTORAN_0203305102022.jpg', 0, 1, '-6.274766785639544', '107.00489133596422', 19, '2022-05-10 15:12:10', '2022-05-17 09:20:38', NULL);
INSERT INTO `restorans` VALUES (2034, 3, 'Nuryanto', 'P.2.02.0004134.19.04', 'Lets go Chicken Kemuning', 'KEMUNING V 48 RAWALUMBU', 'RAWALUMBU', 'BOJONGMENTENG', '004', '005', 2, 0, 12000, 10440000, 10.00, '081288115680', '2022_RESTORAN_0203405102022.jpg', 0, 1, '-6.288174633091327', '106.99478209018709', 19, '2022-05-10 15:20:28', '2022-05-17 09:29:09', NULL);
INSERT INTO `restorans` VALUES (2035, 3, 'Nuryanto', 'P.2.02.0004133.19.01', 'Lets Go Chicken Dasa Darma', 'JL DASA DHARMA 5 RAWALUMBU', 'RAWALUMBU', 'BOJONG RAWALUMBU', '002', '004', 2, 0, 12000, 6270000, 10.00, '081288115680', '2022_RESTORAN_0203505102022.jpg', 0, 1, '-6.276489109491626', '106.99984878301622', 19, '2022-05-10 15:25:11', '2022-05-17 09:39:01', NULL);
INSERT INTO `restorans` VALUES (2036, 3, 'Nuryanto', 'P.2.02.0004131.19.01', 'Lets Go Chicken Kemang Pratama', 'JL KEMANG PRATAMA RAYA NO 3', 'RAWALUMBU', 'BOJONG RAWALUMBU', '001', '011', 2, 0, 12000, 9840000, 10.00, '0812881158680', '2022_RESTORAN_0203605102022.jpg', 0, 1, '-6.272620538197658', '106.98741674423219', 19, '2022-05-10 15:31:13', '2022-05-17 09:50:24', NULL);
INSERT INTO `restorans` VALUES (2037, 2, 'Rico Fabio', 'P.2.02.0004324.19.01', 'Upnormal Kemang Pratama', 'RUKO KEMANG PRATAMA BLOK AK. 3-4', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 8, 240, 25000, 68875000, 10.00, '021-82752242', '2022_RESTORAN_0203705102022.jpg', 0, 1, '-6.276870366169049', '106.98938548564912', 19, '2022-05-10 15:38:21', '2022-05-17 10:01:46', NULL);
INSERT INTO `restorans` VALUES (2038, 1, 'Rony Hartono ST', 'P.2.02.0004309.19.03', 'Point Cafe', 'JL. RAYA KEMANG PRATMA BLOK A NO 1', 'RAWALUMBU', 'SEPANJANGJAYA', '011', '001', 3, 8, 17000, 87975000, 10.00, '081292298419', '2022_RESTORAN_0203805112022.jpg', 0, 1, '-6.274284214003607', '106.98720216751099', 19, '2022-05-11 13:58:35', '2022-05-17 10:04:20', NULL);
INSERT INTO `restorans` VALUES (2039, 3, 'Jessi sudisaputra', 'P.2.02.0002788.19.03', 'Mie Odos', 'JL. TRISATYA NO. 19', 'RAWALUMBU', 'SEPANJANGJAYA', '01', '06', 4, 20, 20000, 13600000, 10.00, '08118602344', '2022_RESTORAN_0203905112022.jpg', 0, 1, '-6.27334573086854', '107.00059175491334', 19, '2022-05-11 14:07:34', '2022-05-17 10:10:08', NULL);
INSERT INTO `restorans` VALUES (2040, 2, 'PT. Dapur Awan Yumindo / Marbio Suntanu', 'P.2.02.0005671.19.03', 'Yummy Kitchen 38 Shell Cut Mutia 2', 'SPBU SHELL CUT MUTIA 2 JL. CUT MUTIA NO. 139B', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '002', 7, 7, 20000, 197500000, 10.00, '081297973833', '2022_RESTORAN_0204005112022.jpg', 0, 1, '-6.260862678088219', '107.00209915637971', 19, '2022-05-11 14:28:58', '2022-05-17 10:12:35', NULL);
INSERT INTO `restorans` VALUES (2041, 3, 'Hj. Yanti Wagianti', 'P.2.02.0000268.19.03', 'Rasa Kuring Sukawening', 'JL. PRAMUKA NO. 24', 'RAWALUMBU', 'SEPANJANGJAYA', '002', '004', 8, 20, 50000, 37375000, 10.00, '021-82400070', '2022_RESTORAN_0204105112022.jpg', 0, 1, '-6.269266508972935', '106.99789345264436', 19, '2022-05-11 14:35:54', '2022-05-17 10:14:16', NULL);
INSERT INTO `restorans` VALUES (2042, 2, 'Zulkarnain Halim', 'P.2.02.0000258.19.01', 'Mie Pangsit SIMPUR', 'JL. KEMANG PRATAMA RAYA AM-7D RAWALUMBU KOTA BEKASI 17116', 'RAWALUMBU', 'BOJONG RAWALUMBU', '06', '20', 12, 135, 50000, 114500000, 10.00, '08111044985', '2022_RESTORAN_0204205112022.jpg', 0, 1, '-6.277099653267252', '106.98934793472291', 19, '2022-05-11 14:40:59', '2022-05-17 10:17:32', NULL);
INSERT INTO `restorans` VALUES (2043, 3, 'Rachmat Meugah A', 'P.2.02.0005303.19.02', 'KOP SURAT', 'JL PRAMUKA RAYA NO. 6', 'RAWALUMBU', 'PENGASINAN', '10', '8', 3, 40, 12000, 10800000, 10.00, '081991262264', '2022_RESTORAN_0204305112022.jpg', 1, 1, '-6.269365157199233', '106.99607223272325', 19, '2022-05-11 14:51:18', '2022-05-17 10:22:50', NULL);
INSERT INTO `restorans` VALUES (2044, 3, 'Rikjik Supriyadi', 'P.2.02.0005400.19.02', 'Atas Nama Kopi', 'JL PRAMUKA NO. 1F', 'RAWALUMBU', 'PENGASINAN', '001', '008', 3, 48, 15000, 13312500, 10.00, '0818218665', '2022_RESTORAN_0204405112022.jpg', 0, 1, '-6.2703916308791765', '107.00427174568178', 19, '2022-05-11 14:58:26', '2022-05-17 10:24:50', NULL);
INSERT INTO `restorans` VALUES (2045, 2, 'Johanes Paulus Arifin', 'P.2.02.0005379.19.02', 'Hokben Kitchen Rawalumbu', 'JL PRAMUKA RUKO NO. 4', 'RAWALUMBU', 'PENGASINAN', '010', '008', 9, 0, 50000, 645000000, 10.00, '021-82769916', '2022_RESTORAN_0204505112022.jpg', 0, 1, '-6.270306313663281', '107.00502276420593', 19, '2022-05-11 15:04:17', '2022-06-06 09:01:54', NULL);
INSERT INTO `restorans` VALUES (2046, 3, 'Maria Manopo', 'P.2.02.0005754.19.02', 'Burger Bangor Pengasinan', 'JL. PENGASINAN NO. 39', 'RAWALUMBU', 'PENGASINAN', '003', '028', 4, 4, 30000, 20175000, 10.00, '081519373337', '2022_RESTORAN_0204605112022.jpg', 0, 1, '-6.268989227372042', '107.0064014196396', 19, '2022-05-11 15:14:43', '2022-05-31 14:41:31', NULL);
INSERT INTO `restorans` VALUES (2047, 2, 'Bangi Kopi', 'P.2.02.0003035.19.01', 'Bangi Kopi', 'JL. KEMANG PRATAMA BLOK AM NO. 1A', 'RAWALUMBU', 'BOJONG RAWALUMBU', '003', '001', 11, 50, 50000, 151000000, 10.00, '021-8220549', '2022_RESTORAN_0204705112022.jpg', 1, 1, '-6.27617183973617', '106.98822140693666', 19, '2022-05-11 15:22:50', '2022-05-17 10:35:14', NULL);
INSERT INTO `restorans` VALUES (2048, 3, 'Gina Fandari', 'P.2.02.0005486.19.03', 'Street Boba Cut Mutia', 'RUKO SOHO CBD VILLA MEUTIA KIRANA BLOK A16 BEKASI', 'RAWALUMBU', 'SEPANJANGJAYA', '002', '01', 5, 4, 20000, 11140000, 10.00, '08131819880', '2022_RESTORAN_0204805122022.jpg', 0, 1, '-6.2613159338402316', '107.00042009353639', 19, '2022-05-12 08:09:28', '2022-05-17 10:37:05', NULL);
INSERT INTO `restorans` VALUES (2049, 3, 'Gina Fandari', 'P.2.02.0005487.19.03', 'Traffic Bun Cut Mutia', 'RUKO SETIA CBD VILLA MEUTIA KIRANA', 'RAWALUMBU', 'SEPANJANGJAYA', '002', '01', 6, 10, 20000, 12700000, 10.00, '08131819880', '2022_RESTORAN_0204905122022.jpg', 0, 1, '-6.260676043252471', '107.0011067390442', 19, '2022-05-12 08:16:37', '2022-06-06 09:02:10', NULL);
INSERT INTO `restorans` VALUES (2050, 3, 'Glegar Panglima Nusantara', 'P.2.02.0005610.19.01', 'Street boba Kemang Pratama', 'JL. KEMANG PRATAMA RAYA BEKASI RUKO AK 12 BOJONG RAWALUMBU', 'RAWALUMBU', 'BOJONG RAWALUMBU', NULL, NULL, 3, 8, 15000, 11325000, 10.00, '085641027499', '2022_RESTORAN_0205005122022.jpg', 0, 1, '-6.276939685534962', '106.9890582561493', 19, '2022-05-12 09:11:59', '2022-05-17 10:38:49', NULL);
INSERT INTO `restorans` VALUES (2051, 3, 'Gelgar Panglima Nusantara', 'P.2.02.0005609.19.01', 'Gildak Kemang Pratama', 'JL. KEMANG PRATAMA RAYA BEKASI RUKO AK 12 BOJONG RAWALUMBU', 'RAWALUMBU', 'BOJONG RAWALUMBU', NULL, NULL, 10, 5, 15000, 11325000, 10.00, '085641027499', '2022_RESTORAN_0205105122022.jpg', 0, 1, '-6.2768330403528045', '106.98892951011658', 19, '2022-05-12 09:22:08', '2022-05-17 10:40:41', NULL);
INSERT INTO `restorans` VALUES (2052, 3, 'PT. Barokah Dunia Akhirat', 'P.2.02.0005819.19.03', 'Animo Bakery Bekasi', 'JL. CUT MUTIA NO.139B', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '002', 5, 4, 20000, 63000000, 10.00, '081380838279', '2022_RESTORAN_0205205122022.jpg', 0, 1, '-6.2608893402021755', '107.00097799301149', 19, '2022-05-12 09:37:30', '2022-06-06 07:31:41', NULL);
INSERT INTO `restorans` VALUES (2053, 3, 'Jani', 'P.2.02.0002617.19.01', 'RM. Ayam Penyet Ibu Yani', 'JALAN KEMANG PRATAMA RAYA BLOK A12 KEMANG PRATAMA BEKASI', 'RAWALUMBU', 'BOJONG RAWALUMBU', '01', '011', 4, 24, 20000, 12550000, 10.00, '021-8201826', '2022_RESTORAN_0205305122022.jpg', 0, 1, '-6.270818216749224', '106.98753476142883', 19, '2022-05-12 09:44:23', '2022-05-17 10:43:50', NULL);
INSERT INTO `restorans` VALUES (2054, 3, 'Teddy Budi Laksoni', 'P.2.02.0004473.19.01', 'Kopi Janji Jiwa Kemang Pratama', 'JALAN KEMANG PRATAMA RAYA BLOK A 12 KEMANG PRATAMA BEKASI', 'RAWALUMBU', 'BOJONG RAWALUMBU', '01', '011', 4, 12, 15000, 12937500, 10.00, '081285895201', '2022_RESTORAN_0205405122022.jpg', 0, 1, '-6.2709701878811135', '106.98748379945756', 19, '2022-05-12 09:50:36', '2022-05-17 10:50:44', NULL);
INSERT INTO `restorans` VALUES (2055, 3, 'Siti Cholifah', 'P.2.02.0002323.19.01', 'Soto Ayam Gondrong', 'JL. KEMANG PRATAMA RAYA, RUKO KEMANG PRATAMA BLOK MM 2 L', 'RAWALUMBU', 'BOJONG RAWALUMBU', '007', '020', 3, 20, 15000, 13200000, 10.00, '081213351622', '2022_RESTORAN_0205505122022.jpg', 0, 1, '-6.275894561808461', '106.98740601539613', 19, '2022-05-12 12:02:46', '2022-05-17 10:53:24', NULL);
INSERT INTO `restorans` VALUES (2056, 3, 'Endang Setiyowati', 'P.2.02.0005726.19.01', 'Soto Mie Pak Kadir', 'JL. KEMANG PRATAMA RAYA BLOK AM NO. 74', 'RAWALUMBU', 'BOJONG RAWALUMBU', '001', '20', 5, 15, 15000, 11962500, 10.00, '021-82783473', '2022_RESTORAN_0205605122022.jpg', 0, 1, '-6.276315810909654', '106.98852717876436', 19, '2022-05-12 12:09:19', '2022-06-06 07:32:49', NULL);
INSERT INTO `restorans` VALUES (2057, 2, 'Ratna Savitri Handayani', 'P.2.02.0000262.19.01', 'Hema Resto', 'JL. KEMANG PRATAMA RAYA BLOK MM 19-20 BEKASI', 'RAWALUMBU', 'BOJONG RAWALUMBU', '001', '001', 7, 110, 50000, 181750000, 10.00, '021-82412761', '2022_RESTORAN_0205705122022.jpg', 1, 1, '-6.2756386128211545', '106.98749184608461', 19, '2022-05-12 12:15:58', '2022-05-17 10:59:40', NULL);
INSERT INTO `restorans` VALUES (2058, 3, 'Ir. Meyndrasta S Hartantya', 'P.2.02.0001929.19.02', 'RM. Bebek Goreng H. Slamet', 'JL. DASA DARMA 1 NO. 9 JEMBATAN KOSONG', 'RAWALUMBU', 'PENGASINAN', '01', '017', 8, 96, 30000, 53250000, 10.00, '081318361454', '2022_RESTORAN_0205805172022.jpg', 0, 1, '-6.270071691247613', '107.00289845466614', 19, '2022-05-17 09:09:00', '2022-05-17 11:15:07', NULL);
INSERT INTO `restorans` VALUES (2059, 3, 'Andri', 'P.2.02.0005728.19.03', 'Sop Janda', 'JL. CUT MEUTIA', 'RAWALUMBU', 'SEPANJANGJAYA', '04', '01', 5, 10, 20000, 13020000, 10.00, '083872078032', '2022_RESTORAN_0205905172022.jpg', 0, 1, '-6.259385594849094', '106.99545264244081', 19, '2022-05-17 09:25:15', '2022-06-06 07:33:56', NULL);
INSERT INTO `restorans` VALUES (2060, 3, 'Ariani', 'P.2.02.0000846.19.01', 'Mie Kangkung Betawi Ariyani', 'KEMANG PRATAMA AL NO. 4', 'RAWALUMBU', 'BOJONG RAWALUMBU', NULL, NULL, 3, 20, 20000, 12550000, 10.00, NULL, '2022_RESTORAN_0206005172022.jpg', 0, 1, '-6.2832131', '106.994906', 19, '2022-05-17 09:32:57', '2022-05-17 11:15:21', NULL);
INSERT INTO `restorans` VALUES (2061, 3, 'HERIN AMBARATI', 'P.2.02.0004076.14.02', 'MH COFFE', 'JL.AHMAD YANI HYPERMEGA MALL LT.3 KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 2, 30, 70000, 33600000, 10.00, '085607204734', '2022_RESTORAN_0206105172022.jpg', 0, 1, NULL, NULL, 9, '2022-05-17 09:38:36', '2022-05-19 11:50:31', NULL);
INSERT INTO `restorans` VALUES (2062, 1, 'J.CO DONUTS & COFFEE', 'P.2.02.0000737.14.02', 'J.CO DONUTS & COFFEE', 'JL. IR. JUANDA NO.1 GIANT HYPERMART KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 15, 52, 141000, 346860000, 10.00, '021 88956375', '2022_RESTORAN_0206205172022.jpg', 0, 1, NULL, NULL, 9, '2022-05-17 10:18:32', '2022-05-19 11:52:44', NULL);
INSERT INTO `restorans` VALUES (2063, 3, 'O CRAPES / CV.ANUGRAH SEJATI', 'P.2.02.0004813.14.02', 'O CRAPES / CV.ANUGRAH SEJATI', 'JL.A.YANI NO.1 KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 3, 4, 30000, 11460000, 10.00, '087777834381', '2022_RESTORAN_0206305172022.jpg', 0, 1, NULL, NULL, 9, '2022-05-17 10:42:55', '2022-05-19 11:53:25', NULL);
INSERT INTO `restorans` VALUES (2064, 2, 'Ricardo Gelael', 'P.2.02.0002906.19.01', 'KFC Kemang Pratama', 'JL. KEMANG PRATAMA RAYA NO. 12', 'RAWALUMBU', 'SEPANJANGJAYA', '003', '021', 16, 100, 77700, 1000698300, 10.00, '08117156859', '2022_RESTORAN_0206405172022.jpg', 1, 1, '-6.270204999451279', '106.98692858219148', 19, '2022-05-17 12:10:13', '2022-05-17 13:27:10', NULL);
INSERT INTO `restorans` VALUES (2065, 2, 'PT. DOM Pizza Indonesia', 'P.2.02.0002119.19.01', 'Dominos Pizza', 'JL. PRATAMA RAYA BLOK MM NO. 4', 'RAWALUMBU', 'BOJONG RAWALUMBU', '007', '20', 12, NULL, 50000, 393750000, 10.00, '021-82415155', '2022_RESTORAN_0206505172022.jpg', 0, 1, '-6.275782584141988', '106.98763668537141', 19, '2022-05-17 12:15:51', '2022-05-17 13:27:42', NULL);
INSERT INTO `restorans` VALUES (2066, 3, 'Bangun Arilita', 'P.2.02.0002865.19.03', 'Restoran Hotel Merapi Merbabu', 'JL. CUT MUTIA 91 SEPANJANG JAYA RAWALUMBU BEKASI', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '002', 60, 60, 30000, 88500000, 10.00, '021-29487750', '2022_RESTORAN_0206605172022.jpg', 0, 1, '-6.261998482936267', '107.00046300888062', 19, '2022-05-17 14:15:40', '2022-05-17 16:00:30', NULL);
INSERT INTO `restorans` VALUES (2067, 3, 'Dr. Darmalia Ulfa', 'P.2.02.0005762.19.03', 'Flip Burger XPRSS', 'JL. CUT MUTIA NO. 139B', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '002', 4, 5, 20000, 78000000, 10.00, '08111693350', '2022_RESTORAN_0206705172022.jpg', 0, 1, '-6.2616252140099125', '107.00111746788026', 19, '2022-05-17 14:19:04', '2022-06-06 07:34:54', NULL);
INSERT INTO `restorans` VALUES (2068, 3, 'Aryo Seno Prayuda SE', 'P.2.02.0000934.19.03', 'Sederhana Lintau', 'JL. PRAMUKA KAV 64 BEKASI', 'RAWALUMBU', 'SEPANJANGJAYA', '04', '02', 4, 55, 20000, 13950000, 10.00, '021-82435588', '2022_RESTORAN_0206805172022.jpg', 0, 1, '-6.269378488039195', '106.99891805648805', 19, '2022-05-17 14:25:07', '2022-05-17 16:00:49', NULL);
INSERT INTO `restorans` VALUES (2069, 3, 'Adi Ardiantomo ST', 'P.2.02.0005065.19.02', 'Meenum Rawalumbu', 'JL. DASA DARMA NO. 22', 'RAWALUMBU', 'BOJONG RAWALUMBU', '001', '005', 2, NULL, 10000, 4400000, 10.00, '081212956631', '2022_RESTORAN_0206905172022.jpg', 0, 1, '-6.284980669355888', '106.99395060539247', 19, '2022-05-17 14:54:45', '2022-05-17 16:01:19', NULL);
INSERT INTO `restorans` VALUES (2070, 2, 'RUDY HARTONO HUSIN', 'P.2.02.0005758.21.01', 'SUNNY CHICK', 'JL BAYAN MUSTIKAJAYA', 'MUSTIKAJAYA', 'MUSTIKAJAYA', NULL, NULL, 3, 8, 25000, 7500000, 10.00, '00', NULL, 0, 4, NULL, NULL, 17, '2022-05-18 10:07:29', '2022-06-30 08:35:06', NULL);
INSERT INTO `restorans` VALUES (2071, 3, 'Maulana Hakim', 'P.2.02.0004750.19.04', 'Teguk Kemuning', 'KEMUNING V NO. 48 BOJONG MENTENG', 'RAWALUMBU', 'BOJONGMENTENG', '001', '007', 4, 1, 15000, 41850000, 10.00, '081288078425', '2022_RESTORAN_0207105182022.jpg', 0, 1, '-6.301878061053125', '106.99155271053314', 19, '2022-05-18 10:26:04', '2022-05-31 10:19:43', NULL);
INSERT INTO `restorans` VALUES (2072, 3, 'INDRAWAN DWI PRASANTO', 'P.2.02.0005770.11.01', 'MANGUT LELE PAK GIANTO', 'JL. KH AGUS SALIM NO. 97 BEKASI TIMUR', 'BEKASI TIMUR', 'BEKASIJAYA', '010', '007', 12, 48, 25000, 31937500, 10.00, '0811-914-4420', '2022_RESTORAN_0207205182022.jpg', 0, 1, '-6.225918143775599', '107.01331615448', 10, '2022-05-18 10:38:07', '2022-06-15 10:39:08', NULL);
INSERT INTO `restorans` VALUES (2073, 2, 'ALVIN ADHITYA ARIEF', 'P.2.02.0005840.11.04', 'MUJIGAE', 'JL. NUSANTARA RAYA NO. 19 BEKASI TIMUR', 'BEKASI TIMUR', 'ARENJAYA', '007', '009', 3, 0, 50000, 127750000, 10.00, '0878-8071-1150', '2022_RESTORAN_0207305182022.jpg', 0, 1, '-6.242694797481528', '107.03346490859987', 10, '2022-05-18 10:49:33', '2022-06-15 10:41:20', NULL);
INSERT INTO `restorans` VALUES (2074, 2, 'STEAK 21 GIANT', 'P.2.02.0000126.14.02', 'STEAK 21 GIANT', 'JL.JEND.A.YANI HYPERMEGA BEKASI', 'BEKASI SELATAN', 'MARGAJAYA', '001', '004', 4, 84, 75000, 11250000, 10.00, '02188962468', '2022_RESTORAN_0207405182022.jpg', 1, 1, '-6.249504493820022', '106.9926953315735', 9, '2022-05-18 11:54:49', '2022-05-19 11:55:13', NULL);
INSERT INTO `restorans` VALUES (2075, 2, 'ANDREAS RESHA JUNIANTO', 'P.2.02.0005605.22.02', 'PT MODULAR KULINER INDONESIA', 'JL. PONDOK GEDE 50B - JATIRAHAYU', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 13, 0, 18000, 36288000, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 14:21:09', '2022-05-18 14:21:09', NULL);
INSERT INTO `restorans` VALUES (2076, 2, 'PT. DUNKINDO LESTARI', 'P.2.05.0000525.22.04', 'DUNKIN DONUTS', 'JL. PONDOK GEDE - JATIRAHAYU', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 4, 24, 39900, 18002880, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 14:23:30', '2022-05-18 14:23:30', NULL);
INSERT INTO `restorans` VALUES (2077, 1, 'ALEXANDER BAGUS PRASETYO', 'P.2.02.0005584.22.01', 'AYAM GEPREK KD 7', 'JL. RAYA PONDOK GEDE NO. 14', 'PONDOKMELATI', 'JATIRAHAYU', '003', '001', 12, 6, 20000, 12480000, 10.00, NULL, NULL, 0, 1, '-6.1571072', '106.9252608', 20, '2022-05-18 14:29:45', '2022-06-07 13:56:45', NULL);
INSERT INTO `restorans` VALUES (2078, 2, 'SHERLI BAHARI', 'P.2.02.0005046.22.02', 'BUBE PONDOK GEDE', 'RAYA HANKAM NO. 28', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 3, 3, 16000, 32256000, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 14:37:23', '2022-05-18 14:37:23', NULL);
INSERT INTO `restorans` VALUES (2079, 1, 'NGIKAN', 'P.2.02.0005033.22.02', 'NGIKAN JATI RAHAYU', 'JL. RAYA HANKAM NO. 96', 'PONDOKMELATI', 'JATIRAHAYU', '005', '006', 4, 10, 25000, 19200000, 10.00, NULL, NULL, 0, 1, '-6.3157213', '106.9304254', 20, '2022-05-18 14:42:45', '2022-06-07 11:59:39', NULL);
INSERT INTO `restorans` VALUES (2080, 1, 'SEDERHANA PONDOK MELATI', 'P.2.02.0000315.22.04', 'SEDERHANA PONDOK MELATI', 'JL.RAYA PONDOK GEDE (PASAR)', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 4, 20, 20000, 12670000, 10.00, NULL, NULL, 0, 1, '-6.3157204', '106.9304213', 20, '2022-05-18 14:46:01', '2022-06-07 14:29:39', NULL);
INSERT INTO `restorans` VALUES (2081, 2, 'JAMALUDIN', 'P.2.02.0003609.22.02', 'WAROENG KAMPOENG', 'JL.RAYA HANKAM SENGON', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 10, 35, 32500, 69940000, 10.00, NULL, NULL, 0, 1, '-6.1571072', '106.9252608', 20, '2022-05-18 14:48:51', '2022-06-07 14:30:06', NULL);
INSERT INTO `restorans` VALUES (2082, 2, 'PT.INSPIRASI KULINER INDONESIA', 'P.2.02.0004206.22.02', 'GO CHICKEN', 'JL. RAYA HANKAM ALFAMIDI SENGON', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 3, 0, 14000, 12985000, 10.00, NULL, NULL, 0, 1, '-6.1571072', '106.9252608', 20, '2022-05-18 14:51:21', '2022-06-07 14:30:18', NULL);
INSERT INTO `restorans` VALUES (2083, 2, 'PT.PLATINUM WAHAB NUSANTARA', 'P.2.02.0004868.22.02', 'TEGUK HANKAM', 'JL.RAYA HANKAM NO.112', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 6, 0, 12000, 15738000, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 14:53:40', '2022-06-07 14:20:37', NULL);
INSERT INTO `restorans` VALUES (2084, 1, 'SYAHRIZAL', 'P.2.02.0004015.22.02', 'RUMOH ACEH', 'JL.RAYA JATIMAKMUR', 'PONDOKMELATI', 'JATIRAHAYU', NULL, NULL, 2, 10, 26000, 6247800, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 14:57:31', '2022-06-07 14:22:58', NULL);
INSERT INTO `restorans` VALUES (2085, 2, 'SOFFIE JULIANA HARTO', 'P.2.02.0004579.22.03', 'AYAM GEPREK BENSU', 'JL.RAYA HANKAM', 'PONDOKMELATI', 'JATIWARNA', '006', '009', 6, 20, 35000, 69772500, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 15:00:37', '2022-06-07 14:27:21', NULL);
INSERT INTO `restorans` VALUES (2086, 1, 'DEWA MADE NADYAINDRIAWATI', 'P.2.02.0005248.22.03', 'NAGINI COFFEE', 'JL. ALTERNATIF JORR NO. 2', 'PONDOKMELATI', 'JATIWARNA', '001', '009', 4, 14, 40000, 13440000, 10.00, NULL, NULL, 0, 4, '-6.315719', '106.9304216', 20, '2022-05-18 15:05:31', '2022-05-18 15:05:31', NULL);
INSERT INTO `restorans` VALUES (2087, 2, 'SURADI', 'P.2.02.0003599.22.03', 'SOTO KUDUS GARUDA', 'JL.ARTERI JORR', 'PONDOKMELATI', 'JATIWARNA', NULL, NULL, 6, 16, 30000, 20160000, 10.00, NULL, NULL, 0, 4, '-6.1571072', '106.9252608', 20, '2022-05-18 15:42:55', '2022-05-18 15:42:55', NULL);
INSERT INTO `restorans` VALUES (2088, 2, 'STEAK 21 GIANT', 'P.2.02.0000151.14.02', 'STEAK 21 GIANT BAWAH', 'JL.JEND.A.YANI HYPERMEGA BEKASI KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 4, 52, 155000, 88660000, 10.00, '021 88962468', '2022_RESTORAN_0208805192022.jpg', 0, 1, NULL, NULL, 9, '2022-05-19 08:56:49', '2022-05-19 11:56:32', NULL);
INSERT INTO `restorans` VALUES (2089, 2, 'KUSNADI RAHARDJA', 'P.2.02.0004550.14.01', 'KIMUKATSU / PT.BOGA MAKMUR DINASTI', 'GRAND METROPOLITAN LT.GF NO.25 JL.KH.NOER ALI KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 20, 60, 90000, 45000000, 10.00, '081293659924', '2022_RESTORAN_0208905192022.jpg', 0, 1, NULL, NULL, 9, '2022-05-19 09:03:39', '2022-05-19 12:10:42', NULL);
INSERT INTO `restorans` VALUES (2090, 2, 'ANDRIAN CHRISTOPER AGUS', 'P.2.02.0004443.14.02', 'PUYO DESSERT / PT.PUYO INDONESIA KREASI', 'JL.AHMAD YANI NO.1 MEGA BEKASI HYPERMART KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 3, NULL, 149000, 44700000, 10.00, '085218087016', '2022_RESTORAN_0209005192022.jpg', 0, 1, NULL, NULL, 9, '2022-05-19 09:10:07', '2022-05-19 12:11:33', NULL);
INSERT INTO `restorans` VALUES (2091, 2, 'DUNKIN DONUTS MEGA', 'P.2.02.0000157.14.02', 'DUNKIN DONUTS MEGA', 'JL.JEND.A.YANI HYPERMEGA BEKASI KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 4, 40, 110000, 182600000, 10.00, '089613749250', '2022_RESTORAN_0209105192022.jpg', 0, 1, NULL, NULL, 9, '2022-05-19 09:18:55', '2022-05-19 12:12:12', NULL);
INSERT INTO `restorans` VALUES (2092, 3, 'YASMEEN FIRYAALIA', 'P.2.02.0005695.14.05', 'AYAM GORENG SUHARTI', 'JL. KALIMALANG JEMBATAN 2 NO. 253', 'BEKASI SELATAN', 'KAYURINGINJAYA', NULL, NULL, 13, 24, 59000, 45430000, 10.00, '0218851046', '2022_RESTORAN_0209205192022.jpg', 0, 1, NULL, NULL, 9, '2022-05-19 09:26:47', '2022-05-19 12:12:52', NULL);
INSERT INTO `restorans` VALUES (2093, 3, 'BAKSO LAPANGAN TEMBAK SENAYAN', 'P.2.02.0003540.14.05', 'BAKSO LAPANGAN TEMBAK SENAYAN', 'JL.KH.NOER ALI NO.177, BEKASI CYBER PARK KEL. KAYURINGIN JAYA', 'BEKASI SELATAN', 'KAYURINGINJAYA', NULL, NULL, 6, 80, 40000, 10080000, 10.00, '089504960504', '2022_RESTORAN_0209305192022.jpg', 0, 1, NULL, NULL, 9, '2022-05-19 09:35:15', '2022-05-19 12:13:26', NULL);
INSERT INTO `restorans` VALUES (2094, 3, 'Lies', 'P.2.02.0001084.19.01', 'RM Pawon BuLies', 'JALAN DUTA 1 BLOK CC 1, JL. KEMANG PRATAMA RAYA', 'RAWALUMBU', 'BOJONG RAWALUMBU', '04', '022', 5, 15, 30000, 41850000, 10.00, '8219637', '2022_RESTORAN_0209405192022.jpg', 0, 1, '-6.272316596851724', '106.98645651340486', 19, '2022-05-19 10:01:10', '2022-05-31 10:27:12', NULL);
INSERT INTO `restorans` VALUES (2095, 3, 'Nurul Fitri', 'P.2.02.0005238.19.01', 'Foresthree Coffee Kemang Pratama', 'JL. KEMANG PRATAMA RAYA BLOK MM 20A', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '022', 4, 30, 15000, 22875000, 10.00, '081808373443', '2022_RESTORAN_0209505192022.jpg', 0, 1, '-6.275894561808461', '106.98740601539613', 19, '2022-05-19 10:09:42', '2022-05-31 10:39:21', NULL);
INSERT INTO `restorans` VALUES (2096, 3, 'BILLY KURNIAWAN/PT KURNIA BOGA NARAYAN', 'P.2.02.0005737.11.01', 'JANJI JIWA JILID 161', 'JL. KH AGUS SALIM NO. 181 BEKASI TIMUR', 'BEKASI TIMUR', 'BEKASIJAYA', '009', '007', 6, 0, 20000, 19250000, 10.00, '0896-5513-3017', '2022_RESTORAN_0209605192022.jpg', 0, 1, '-6.226910039683643', '107.01172828674318', 10, '2022-05-19 10:21:14', '2022-06-15 10:49:23', NULL);
INSERT INTO `restorans` VALUES (2097, 2, 'ATJEP LUKMAN HAKIM', 'P.2.02.0004776.14.01', 'BAKMI TOPIA / PT.INDOSTERLING WAHANA BOGA', 'JL.A.YANI METROPOLITAN MALL LT.II KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 7, 21, 53000, 35245000, 10.00, '087800158986', '2022_RESTORAN_0209705202022.jpg', 0, 1, NULL, NULL, 9, '2022-05-20 08:17:23', '2022-05-20 09:23:53', NULL);
INSERT INTO `restorans` VALUES (2098, 2, 'EMIL ZAM HARIRA', 'P.2.02.0005788.14.01', 'KABOBS PREMIUM KEBAB / PT. TATA JAGO UTAMA', 'JL. KH. NOER ALI RT. 007 RW. 003', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 5, 24, 40000, 37200000, 10.00, '085770518995', '2022_RESTORAN_0209805202022.jpg', 0, 1, NULL, NULL, 9, '2022-05-20 08:30:54', '2022-05-20 09:24:38', NULL);
INSERT INTO `restorans` VALUES (2099, 2, 'Hendra Arifin', 'P.2.02.0005550.19.01', 'Hoka Hoka Bento Kemang Pratama', 'KOMPLEK RUKO KEMANG PRATAMA JL. KEMANG PRATAMA RAYA BLOK AM 6C', 'RAWALUMBU', 'BOJONG RAWALUMBU', '005', '001', 11, 0, 100000, 645500000, 10.00, '021-82769666', '2022_RESTORAN_0209905202022.jpg', 0, 1, '-6.276395794877724', '106.98857545852661', 19, '2022-05-20 09:47:14', '2022-06-06 08:33:04', NULL);
INSERT INTO `restorans` VALUES (2100, 3, 'Budi Riyanto', 'P.2.02.0004429.19.02', 'Geprek Bensu', 'JL. PENGASINAN RUKO PUTRA 3B', 'RAWALUMBU', 'PENGASINAN', '009', '019', 6, 16, 20000, 534000000, 10.00, '021-82751768', '2022_RESTORAN_0210005232022.jpg', 0, 1, '-6.2655818510503405', '107.00858473777772', 19, '2022-05-23 09:32:30', '2022-05-31 11:37:24', NULL);
INSERT INTO `restorans` VALUES (2101, 2, 'PT. Inspirasi Bisnis Nusantara', 'P.2.02.0004807.19.01', 'Haus Rawalumbu', 'JALAN MERANTI RAYA NO.17 RT 06/11 BOJONG MENTENG', 'RAWALUMBU', 'BOJONGMENTENG', NULL, NULL, 5, NULL, 15000, 151875000, 10.00, '087797899666', '2022_RESTORAN_0210105232022.jpg', 0, 1, '-6.295847530881324', '106.99381113052368', 19, '2022-05-23 09:35:49', '2022-05-31 10:55:04', NULL);
INSERT INTO `restorans` VALUES (2102, 2, 'PT. Bumi Berkah Boga', 'P.2.02.0005123.19.01', 'Kopi Kenangan Kemang Pratama', 'RUKO KEMANG PRATAMA BEKASI, JL. KEMANG PRATAMA RAYA BLOK AN-41', 'RAWALUMBU', 'BOJONG RAWALUMBU', '004', '001', 6, NULL, 40000, 451000000, 10.00, '08170731607', '2022_RESTORAN_0210205232022.jpg', 0, 1, '-6.278166103560302', '106.98982000350954', 19, '2022-05-23 09:47:22', '2022-06-06 09:02:27', NULL);
INSERT INTO `restorans` VALUES (2103, 2, 'PT. Bumi Berkah Boga', 'P.2.02.0005484.19.02', 'Kopi Kenangan Pengasinan', 'JL. RAYA PENGASINAN NO.RT 04, RT.004/RW.003, PENGASINAN, KEC. RAWALUMBU, KOTA BKS, JAWA BARAT 17115', 'RAWALUMBU', 'PENGASINAN', '004', '003', 6, NULL, 30000, 279000000, 10.00, '08170925997', '2022_RESTORAN_0210305232022.jpg', 0, 1, '-6.2774515821053605', '107.01530098915102', 19, '2022-05-23 09:55:36', '2022-06-06 09:02:41', NULL);
INSERT INTO `restorans` VALUES (2104, 2, 'PT. Bumi Berkah Boga', 'P.2.02.0005917.19.03', 'Kopi Kenangan Pramuka', 'SPBU PERTAMINA JL. PRAMUKA NO 39', 'RAWALUMBU', 'SEPANJANGJAYA', '004', '003', 6, NULL, 30000, 253500000, 10.00, '08170731607', '2022_RESTORAN_0210405232022.jpg', 0, 1, '-6.2690798771424046', '106.99999094009401', 19, '2022-05-23 10:00:53', '2022-05-31 14:21:59', NULL);
INSERT INTO `restorans` VALUES (2105, 3, 'Maulana Hakim', 'P.2.02.0004847.19.02', 'Teguk Pramuka', 'JL. PRAMUKA RAYA', 'RAWALUMBU', 'SEPANJANGJAYA', '001', '017', 4, 1, 15000, 21450000, 10.00, '081288078425', '2022_RESTORAN_0210505232022.jpg', 0, 1, '-6.267906761249918', '107.00456142425539', 19, '2022-05-23 10:09:20', '2022-05-31 10:59:04', NULL);
INSERT INTO `restorans` VALUES (2106, 2, 'AGUS SWANTO', 'P.2.02.0004030.14.01', 'STEAK 21 LAGOON', 'KH.NOER ALIE NO.3 KALIMALANG KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 8, 30, 150000, 64800000, 10.00, '087871793392', '2022_RESTORAN_0210605232022.jfif', 0, 1, NULL, NULL, 9, '2022-05-23 10:53:10', '2022-06-08 09:07:33', NULL);
INSERT INTO `restorans` VALUES (2107, 2, 'DUNKIN DONUTS MET.MAL', 'P.2.02.0000110.14.01', 'DUNKIN DONUTS MET.MAL', 'JL.JEND.A.YANI MET.MAL KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 4, 18, 110000, 123200000, 10.00, '0218866953', '2022_RESTORAN_0210705232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 10:56:41', '2022-06-08 09:09:21', NULL);
INSERT INTO `restorans` VALUES (2108, 1, 'KFC MET.MAL', 'P.2.02.0000109.14.01', 'KFC MET.MAL', 'JL.JEND.A.YANI MET.MAL KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 18, 300, 50000, 1417500000, 10.00, '08117156849', '2022_RESTORAN_0210805232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 11:01:38', '2022-06-08 09:10:31', NULL);
INSERT INTO `restorans` VALUES (2109, 3, 'TAN ENG SOEN', 'P.2.02.0004217.14.01', 'O CREPES / CV.ANUGRAH SEJATI', 'JL.AHMAD YANI REVO TWON BEKASI GF-ME 28 LT.DASAR  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 4, NULL, 31000, 25575000, 10.00, NULL, '2022_RESTORAN_0210905232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 11:49:27', '2022-06-08 09:22:05', NULL);
INSERT INTO `restorans` VALUES (2110, 1, 'KFC GIANT', 'P.2.02.0000108.14.02', 'KFC GIANT', 'JL.JEND.A.YANI HYPERMEGA BEKASI KEL. MARGAJAYA', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 8, 144, 50000, 132200000, 10.00, '08117156848', '2022_RESTORAN_0211005232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 11:58:38', '2022-06-08 09:22:43', NULL);
INSERT INTO `restorans` VALUES (2111, 2, 'GABY OLIVIA', 'P.2.02.0005697.14.02', 'PEMPEK GABY / PT. GABY BERKAT SEJAHTERA', 'JL. IR. H. JUANDA NO. 6', 'BEKASI SELATAN', 'MARGAJAYA', '001', '004', 5, 48, 50000, 97500000, 10.00, '02182421594', '2022_RESTORAN_0211105232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 12:27:31', '2022-06-08 09:23:36', NULL);
INSERT INTO `restorans` VALUES (2112, 3, 'LEONARDUS HERMAWAN ANDROMEDA', 'P.2.02.0005545.14.02', 'BURGER BANGOR / PT. KEMAKMURAN SEJAHTERA ABADI', 'JL. KEMAKMURAN NO. 65', 'BEKASI SELATAN', 'MARGAJAYA', '004', '003', 5, 21, 50000, 20625000, 10.00, '081319177866', '2022_RESTORAN_0211205232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 12:35:22', '2022-06-08 09:24:25', NULL);
INSERT INTO `restorans` VALUES (2113, 1, 'DALIMIN JOWONO', 'P.2.02.0002447.14.01', 'KFC GRAND METROPOLITAN MALL/PT.FASTFOOD INDONESIA', 'GRAND METROPOLITAN MALL JL.KH.NOER ALI INPEKSI KALIMALANG  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 9, 58, 50000, 397500000, 10.00, '08117156867', '2022_RESTORAN_0211305232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 12:43:19', '2022-06-08 09:25:10', NULL);
INSERT INTO `restorans` VALUES (2114, 1, 'EDWARD DJAJA', 'P.2.02.0005455.14.01', 'GOLDEN LAMIAN / PT. SUMBER NATURAL INDONESIA', 'GRAND METROPOLITAN BEKASIJL. KH. NOER ALI', 'BEKASI SELATAN', 'PEKAYONJAYA', '007', '003', 11, 128, 60000, 356400000, 10.00, '081315247265', '2022_RESTORAN_0211405232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 12:49:07', '2022-06-08 10:02:07', NULL);
INSERT INTO `restorans` VALUES (2115, 1, 'SANTOSO', 'P.2.02.0005674.14.01', 'PAN & CO / PT. SUMBER SELERA INDONESIA', 'GRAND METROPOLITAN MALL LANTAI 2 NO. 20 JL. KH. NOER ALI', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 22, 56, 70000, 596400000, 10.00, '081294490063', '2022_RESTORAN_0211505232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 12:58:44', '2022-06-08 10:02:59', NULL);
INSERT INTO `restorans` VALUES (2116, 3, 'YULI HANTORO IR.', 'P.2.02.0005430.14.04', 'BAKSO RUSUK TOP', 'JL. RAYA PEKAYON RT.', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 2, 36, 24000, 4452000, 10.00, '02182748390', '2022_RESTORAN_0211605232022.jpg', 0, 1, NULL, NULL, 9, '2022-05-23 13:04:59', '2022-06-08 10:03:55', NULL);
INSERT INTO `restorans` VALUES (2117, 3, 'Adang Wijaya', 'P.2.02.0004811.19.01', 'Dudung Roxy', 'JL. KEMANG PRATAMA RAYA NO.1', 'RAWALUMBU', 'BOJONG RAWALUMBU', '04', '01', 3, 16, 50000, 61500000, 10.00, '085283886862', '2022_RESTORAN_0211705242022.jpg', 0, 1, '-6.278614012032211', '106.99081778526308', 19, '2022-05-24 07:48:15', '2022-05-31 11:34:53', NULL);
INSERT INTO `restorans` VALUES (2118, 3, 'SINGGIH ANDI P', 'P.2.02.0005518.14.04', 'CETROO COFFEE', 'JL. BOULEVARD RAYA RUKAN RGB NO. 58', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 3, 52, 25000, 7612500, 10.00, '081392420460', '2022_RESTORAN_0211805242022.jpeg', 0, 1, NULL, NULL, 9, '2022-05-24 08:41:14', '2022-06-08 10:05:51', NULL);
INSERT INTO `restorans` VALUES (2119, 3, 'RANDY ANGKOUW', 'P.2.02.0005519.14.04', 'TAWA COFFEE AND MOJITO', 'JL. NAKULA RAYA C NO. 153', 'BEKASI SELATAN', 'JAKASETIA', '003', '007', 4, 36, 30000, 12960000, 10.00, NULL, '2022_RESTORAN_0211905242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 08:45:17', '2022-06-08 10:08:40', NULL);
INSERT INTO `restorans` VALUES (2120, 3, 'DANIEL HENDRAWAN DH', 'P.2.02.0005510.14.04', 'TRUFFLE BELLY, BAE BAE GALBI, OIOI SODA', 'RUKAN GRAND GALAXY CITY, BLOK RGB NO. 99', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, NULL, 50000, 20625000, 10.00, '089684090162', '2022_RESTORAN_0212005242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 08:49:45', '2022-06-08 10:09:53', NULL);
INSERT INTO `restorans` VALUES (2121, 3, 'AGUS MOHAMAD ARIEF', 'P.2.02.0005508.14.04', 'STEAK PAHLAWAN', 'RUKO TAMAN GALAXY BLOK G NO. 8', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 48, 110000, 34210000, 10.00, NULL, '2022_RESTORAN_0212105242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 08:52:58', '2022-06-08 10:11:19', NULL);
INSERT INTO `restorans` VALUES (2122, 3, 'LAXMI JUNITA', 'P.2.02.0005507.14.04', 'BAKSO AGUNG GALAXY', 'JL. TAMAN GALAXY RAYA BLOK G NO. 7 RT. 002 RW. 014', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 5, 20, 30000, 9135000, 10.00, NULL, '2022_RESTORAN_0212205242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 08:56:46', '2022-06-08 10:13:50', NULL);
INSERT INTO `restorans` VALUES (2123, 2, 'WENDRA NORMAL', 'P.2.02.0005505.14.04', 'DAWEND COFFEE & STEAK', 'JL. GARDENIA UTARA BLOK AAI NO. 32', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 10, 30, 80000, 105400000, 10.00, '081213396822', '2022_RESTORAN_0212305242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:01:56', '2022-06-08 10:14:41', NULL);
INSERT INTO `restorans` VALUES (2124, 3, 'RONY HANDOKO', 'P.2.02.0005654.14.01', 'WONG KOPI 88', 'RUKO PENINSULA NO.1E JL. PULO RIBUNG', 'BEKASI SELATAN', 'PEKAYONJAYA', '001', '021', 4, 34, 80000, 24360000, 10.00, '081289389549', '2022_RESTORAN_0212405242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:10:19', '2022-06-08 10:15:21', NULL);
INSERT INTO `restorans` VALUES (2125, 3, 'TANG ENG SOEN', 'P.2.02.0004215.14.01', 'O CREPES / CV.ANUGRAH SEJATI', 'KEMALA LAGON LT.2 JL.KH.NOER ALI NO.3 KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 2, 4, 30000, 17850000, 10.00, NULL, '2022_RESTORAN_0212505242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:14:55', '2022-06-08 10:16:03', NULL);
INSERT INTO `restorans` VALUES (2126, 2, 'ANDREAS STEFANO HAMONANGAN SITORUS', 'P.2.02.0005471.14.04', 'PEMERINTAH KOPI', 'JL, NUSA INDAH RAYA RUKO TAMAN GALAXY NO. U62', 'BEKASI SELATAN', 'JAKASETIA', '007', '014', 7, 46, 30000, 17850000, 10.00, '081291765594', '2022_RESTORAN_0212605242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:22:57', '2022-06-08 10:18:10', NULL);
INSERT INTO `restorans` VALUES (2127, 3, 'YASMEEN FIRYAALIA', 'P.2.02.0005695.14.05', 'AYAM GORENG SUHARTI', 'JL. KALIMALANG JEMBATAN 2 NO. 253', 'BEKASI SELATAN', 'KAYURINGINJAYA', NULL, NULL, 12, 30, 100000, 43200000, 10.00, '02188851046', '2022_RESTORAN_0212705242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:29:19', '2022-06-08 10:19:05', NULL);
INSERT INTO `restorans` VALUES (2128, 2, 'ES TELER 77 MET.MAL', 'P.2.02.0000092.14.01', 'ES TELER 77 MET.MAL', 'JL.JEND.A.YANI MET.MAL KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 8, 36, 38000, 16416000, 10.00, NULL, '2022_RESTORAN_0212805242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:37:55', '2022-06-08 10:20:06', NULL);
INSERT INTO `restorans` VALUES (2129, 3, 'LINDA MONICA', 'P.2.02.0005428.14.04', 'NASI UDUK BANG SAID', 'RUKAN GRAND GALAXY CITY BLOK RGA NO. 10', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, 40, 70000, 21315000, 10.00, '087875715705', '2022_RESTORAN_0212905242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:45:36', '2022-06-08 10:21:05', NULL);
INSERT INTO `restorans` VALUES (2130, 3, 'DYAMOND CAFE', 'P.2.02.0005515.14.04', 'DYAMOND CAFE', 'JL. BOULEVARD RAYA BARAT BLOK RGA NO. 28 RUKO GRAND GALAXY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 40, 50000, 21600000, 10.00, '081290563363', '2022_RESTORAN_0213005242022.jpg', 0, 1, NULL, NULL, 9, '2022-05-24 09:51:58', '2022-06-08 10:22:40', NULL);
INSERT INTO `restorans` VALUES (2131, 2, 'INDRY CHERIL PANDEIROOT', 'P.2.02.0005821.11.01', 'RESTORAN TEMU KAMU', 'JL. IR. H. JUANDA NO. 167 BEKASI TIMUR', 'BEKASI TIMUR', 'BEKASIJAYA', '004', '001', 8, 40, 50000, 91250000, 10.00, '0878-8218-6711/0877-6789-8866', '2022_RESTORAN_0213105242022.jpg', 0, 1, '-6.246278297904818', '107.0087242126465', 10, '2022-05-24 11:28:54', '2022-06-15 10:50:49', NULL);
INSERT INTO `restorans` VALUES (2132, 2, 'PT.RABIA SAFARI OPTIMA', 'P.2.02.0003927.16.05', 'ARUNG COFFE', 'RUKO ROSEWOOD BOULEVARD', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 3, 15, 25000, 21500000, 10.00, '08161150203', '2022_RESTORAN_0213205242022.jpg', 0, 1, '-6.260547176682845', '106.94382774609282', 18, '2022-05-24 11:47:10', '2022-06-02 15:02:03', NULL);
INSERT INTO `restorans` VALUES (2133, 3, 'EDWARD TIRTANATA', 'P.2.02.0005688.16.02', 'KOPI KENANGAN SUPERINDO JATIBENING', 'JL.RAYA DR.RATNA', 'PONDOKGEDE', 'JATIBENING', '001', '001', 5, 8, 35000, 23887500, 10.00, NULL, '2022_RESTORAN_0213305242022.jpg', 0, 4, '-6.259491354913087', '106.95117112796531', 18, '2022-05-24 14:32:34', '2022-06-30 08:25:49', NULL);
INSERT INTO `restorans` VALUES (2134, 3, 'MARCEL JANUAR HARSANTO', 'P.2.02.0005357.14.04', 'WABEGA KOREAN BBQ', 'JL. BOULEVAR RAYA, RUKO RGG 32', 'BEKASI SELATAN', 'JAKASETIA', '007', '018', 7, 40, 99000, 19701000, 10.00, '0', '2022_RESTORAN_0213405242022.jpg', 0, 1, '-6.272829386789069', '106.97269382906013', 9, '2022-05-24 14:39:28', '2022-06-08 10:23:35', NULL);
INSERT INTO `restorans` VALUES (2135, 2, 'JULIUS SETYO BINTARO', 'P.2.02.0004225.16.05', 'LAWSON CAFE', 'REST AREA KM.06 JL.TOL JAKARTA CIKAMPEK', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 5, 15, 110000, 182325000, 10.00, NULL, '2022_RESTORAN_0213505242022.jpg', 0, 1, '-6.258605280946611', '106.9262405955641', 18, '2022-05-24 14:41:55', '2022-06-02 15:05:36', NULL);
INSERT INTO `restorans` VALUES (2136, 3, 'RIZKI AGUNG KUMORO', 'P.2.02.0005734.16.02', 'MENANTEA', 'JL.JATIBENING 2 NO 225', 'PONDOKGEDE', 'JATIBENING', '003', '003', 8, 10, 20000, 19750000, 10.00, NULL, '2022_RESTORAN_0213605242022.png', 0, 1, '-6.26244373909228', '106.9449489034785', 18, '2022-05-24 14:42:29', '2022-06-27 14:27:53', NULL);
INSERT INTO `restorans` VALUES (2137, 3, 'WILSON ADITYA HARTONO', 'P.2.02.0005358.14.04', 'KOPI KONNICHIWA/ PT. WIRATAMA KARYA USAHA', 'JL. BOULEVAR RAYA RGG 29', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, 29, 19000, 2861400, 10.00, '0', '2022_RESTORAN_0213705242022.jpg', 0, 1, '-6.272857825779196', '106.9728090655789', 9, '2022-05-24 14:49:17', '2022-06-08 10:25:13', NULL);
INSERT INTO `restorans` VALUES (2138, 3, 'NASI UDUK SPESIAL II', 'P.2.02.0000171.16.01', 'NASI UDUK SPESIAL II', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 6, 10, 15000, 13725000, 10.00, NULL, '2022_RESTORAN_0213805242022.png', 0, 1, '-6.258463081934087', '106.91003387748674', 18, '2022-05-24 14:55:23', '2022-06-02 15:10:20', NULL);
INSERT INTO `restorans` VALUES (2139, 3, 'MEILINA KARTIKA KADIR', 'P.2.02.0005233.14.04', 'NASI KULIT GOSKIN', 'JL. BOULEVARD RAYA NO. 52 RT. 001/002', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 5, 18, 38500, 4858700, 10.00, '0', '2022_RESTORAN_0213905242022.jpg', 0, 1, '-6.272624982488428', '106.97304666892826', 9, '2022-05-24 14:57:38', '2022-06-08 10:27:27', NULL);
INSERT INTO `restorans` VALUES (2140, 2, 'CAFE SORGA', 'P.2.02.0004474.16.05', 'RATNA SARI SILABAN', 'REST AREA KM.6', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 5, 15, 20000, 12300000, 10.00, NULL, '2022_RESTORAN_0214005242022.jpg', 0, 1, '-6.2819561', '106.9140227', 18, '2022-05-24 14:58:33', '2022-06-27 14:28:47', NULL);
INSERT INTO `restorans` VALUES (2141, 2, 'EKO INDRAYANTO', 'P.2.02.0003923.16.01', 'AYAM GEPREK JUARA', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 8, 15, 25000, 34687500, 10.00, NULL, '2022_RESTORAN_0214105242022.png', 0, 1, '-6.280342544361419', '106.91344227969509', 18, '2022-05-24 15:02:47', '2022-06-02 15:12:57', NULL);
INSERT INTO `restorans` VALUES (2142, 2, 'ROBET  SUTEJA', 'P.2.02.0004032.16.04', 'JCO DONUTS  & COFFEE', 'JL.RAYA JATIWARINGIN N0 15', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 10, 95000, 434625000, 10.00, NULL, '2022_RESTORAN_0214205242022.png', 0, 1, '-6.26819381896377', '106.91150950856479', 18, '2022-05-24 15:12:17', '2022-06-02 15:15:26', NULL);
INSERT INTO `restorans` VALUES (2143, 2, 'HENDRIK ALEXANDER W.BOI', 'P.2.02.0004404.16.05', 'GOKANA TEPPAN & RAMEN REST AREA', 'REST.AREA KM.6', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 5, 15, 120000, 177600000, 10.00, NULL, '2022_RESTORAN_0214305242022.jpg', 0, 1, '-6.2585732862698045', '106.92638286513095', 18, '2022-05-24 15:17:00', '2022-06-02 15:17:42', NULL);
INSERT INTO `restorans` VALUES (2144, 3, 'EKO WIBISONO, SP', 'P.2.02.0005520.14.04', 'WOODFIRE GOURMET BURGER', 'RUKO RGM 19 JL. PULO SIRIH BARAT RAYA', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 7, 52, 49000, 11284700, 10.00, NULL, '2022_RESTORAN_0214405242022.jpg', 0, 1, '-6.2661213099443005', '106.97087477530947', 9, '2022-05-24 15:20:28', '2022-06-08 10:28:17', NULL);
INSERT INTO `restorans` VALUES (2145, 3, 'FARUK FAHRANY AL KATIRI, SH', 'P.2.02.0005524.14.01', 'SAYA KOPI', 'JL. IRIGASI', 'BEKASI SELATAN', 'PEKAYONJAYA', '001', '021', 6, 40, 20000, 3196000, 10.00, NULL, '2022_RESTORAN_0214505242022.jpg', 0, 1, '-6.267212666329461', '106.98148160139966', 9, '2022-05-24 15:26:58', '2022-06-08 10:29:17', NULL);
INSERT INTO `restorans` VALUES (2146, 3, 'KOPI STUDIO', 'P.2.02.0004437.16.05', 'KOPI STUDIO', 'JL.MARNA PUTRA ATAS NO.9A', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 5, 20, 20000, 6190000, 10.00, NULL, '2022_RESTORAN_0214605242022.jpg', 0, 1, '-6.259610447346965', '106.93034254987718', 18, '2022-05-24 15:30:10', '2022-06-02 15:19:05', NULL);
INSERT INTO `restorans` VALUES (2147, 1, 'DALAMIN JUWONO', 'P.2.02.0000715.16.01', 'KFC PONDOK GEDE PLAZA II', 'JL. RAYA PONDOK GEDE', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 20, 250000, 763750000, 10.00, NULL, NULL, 0, 1, '-6.283093075558117', '106.91300153732301', 18, '2022-05-24 15:32:35', '2022-06-27 14:29:15', NULL);
INSERT INTO `restorans` VALUES (2148, 1, 'ZAINA SIMAN', 'P.2.02.0000895.16.01', 'A & W PLAZA PONDOK GEDE / PT.PRIMA USAHA ERA MANDIRI', 'PLAZA PONDOK GEDE 2 BLOK.E NO.8', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 20, 150000, 423375000, 10.00, NULL, '2022_RESTORAN_0214805252022.jpg', 1, 4, '-6.283707166328016', '106.91165524215471', 18, '2022-05-25 10:19:55', '2022-06-29 15:50:15', NULL);
INSERT INTO `restorans` VALUES (2149, 2, 'HOKA-HOKA BENTO PONDOK GEDE (PT.EKA BOGA INTI )', 'P.2.02.0001923.16.01', 'HOKA-HOKA BENTO PONDOK GEDE (PT.EKA BOGA INTI )', 'PONDOK GEDE PLAZZA', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 20, 290000, 1014275000, 10.00, NULL, '2022_RESTORAN_0214905252022.jpg', 1, 1, '-6.283777373427477', '106.9116286919633', 18, '2022-05-25 11:01:42', '2022-06-27 14:29:56', NULL);
INSERT INTO `restorans` VALUES (2150, 1, 'SUPRIYATNO', 'P.2.02.0000733.16.01', 'CAFE PONDOK GEDE XXI', 'JL. RAYA PONDOK GEDE PLAZA PD. GEDE', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 8, 10, 150000, 255000000, 10.00, NULL, '2022_RESTORAN_0215005252022.jpg', 0, 1, '-6.283764042955975', '106.91148933308865', 18, '2022-05-25 11:34:16', '2022-06-27 14:31:30', NULL);
INSERT INTO `restorans` VALUES (2151, 1, 'ZAINAL ARIFIN', 'P.2.02.0000734.16.01', 'SOLARIA PONDOK GEDE II/CV. NUSA PRIMA PANGAN', 'JL. RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 8, 20, 200000, 567500000, 10.00, NULL, '2022_RESTORAN_0215105252022.jpg', 1, 1, '-6.284492775167832', '106.9116207192697', 18, '2022-05-25 11:49:49', '2022-06-27 14:32:11', NULL);
INSERT INTO `restorans` VALUES (2152, 2, 'DONNY WAHYU HIDAYAT', 'P.2.02.0002271.16.01', 'DONS BURGER/PT.DONS BOGATAMA', 'GEDUNG PLAZA PONDOK GEDE LT.1 BLOK T NO.15', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 6, 16, 30000, 31080000, 10.00, NULL, '2022_RESTORAN_0215205252022.jpg', 0, 1, '-6.283936450740635', '106.91140701381187', 18, '2022-05-25 12:05:21', '2022-06-27 14:32:52', NULL);
INSERT INTO `restorans` VALUES (2153, 3, 'RM.SOTO KUDUS II', 'P.2.02.0000180.16.01', 'RM.SOTO KUDUS II', 'JL.RAYA PONDOK GEDE', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 20, 10000, 6505000, 10.00, NULL, '2022_RESTORAN_0215305252022.jpg', 0, 1, '-6.283019313623055', '106.91214871655141', 18, '2022-05-25 12:21:54', '2022-06-29 15:16:03', NULL);
INSERT INTO `restorans` VALUES (2154, 3, 'RM.BAKSO TEBET', 'P.2.02.0000186.16.01', 'RM.BAKSO TEBET', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 10, 10000, 10650000, 10.00, NULL, '2022_RESTORAN_0215405252022.jpg', 0, 4, '-6.284512326281548', '106.91234654639594', 18, '2022-05-25 14:00:39', '2022-06-30 08:44:45', NULL);
INSERT INTO `restorans` VALUES (2155, 2, 'RM.COZY', 'P.2.02.0000196.16.01', 'RM.COZY', 'JL.JATIWARINGIN PERT.PD.GEDE', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 20, 35000, 46025000, 10.00, NULL, '2022_RESTORAN_0215505252022.jpg', 1, 1, '-6.282997984511985', '106.91242138186405', 18, '2022-05-25 14:41:16', '2022-06-27 14:33:35', NULL);
INSERT INTO `restorans` VALUES (2156, 3, 'ZAKI KHAMNEI HARARAP', 'P.2.02.0004953.14.01', 'KOPI MASALALU', 'JL.PULO RIBUNG NO.112 KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 3, 10, 50000, 20625000, 10.00, '081282924442', '2022_RESTORAN_0215605272022.jpg', 0, 1, NULL, NULL, 9, '2022-05-27 10:11:25', '2022-06-08 10:34:22', NULL);
INSERT INTO `restorans` VALUES (2157, 2, 'DALIMIN JUWONO', 'P.2.02.0003721.14.01', 'KFC BOX TOWN BEKASI / PT.FAST FOOD INDONESIA', 'JL.AHMAD YANI  KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 5, 52, 100000, 77750000, 10.00, NULL, '2022_RESTORAN_0215705272022.jpg', 0, 1, NULL, NULL, 9, '2022-05-27 10:16:50', '2022-06-08 10:35:13', NULL);
INSERT INTO `restorans` VALUES (2158, 2, 'ISWADY SUSINDRA', 'P.2.02.0004667.14.04', 'YUMMY HOT PLAT / PT.YUMMY CITRARASA ASIA', 'JL.BOULEVAR GALAXI', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, NULL, 45000, 167175000, 10.00, '085770085907', '2022_RESTORAN_0215805272022.jpg', 0, 1, NULL, NULL, 9, '2022-05-27 10:29:47', '2022-06-08 10:36:24', NULL);
INSERT INTO `restorans` VALUES (2159, 2, 'TONG TJI / PT. CAHAYA TIRTA RASA', 'P.2.02.0003539.14.04', 'TONG TJI / PT. CAHAYA TIRTA RASA', 'JL. GRAND GALAXY BOULEVARD NO.1 KEL. JAKASETIA', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 4, NULL, 22000, 111760000, 10.00, NULL, '2022_RESTORAN_0215905272022.jpg', 0, 1, NULL, NULL, 9, '2022-05-27 10:45:28', '2022-06-08 10:40:02', NULL);
INSERT INTO `restorans` VALUES (2160, 2, 'SHABURI & KINTAN BUFFET / PT.BOGA MAKMUR WIJAYA', 'P.2.02.0004092.14.01', 'SHABURI & KINTAN BUFFET / PT.BOGA MAKMUR WIJAYA', 'GRAND METROPOLITAN LT.UG NO.19 JL.KH.NOER ALI', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 32, 120, 150000, 94350000, 10.00, NULL, '2022_RESTORAN_0216005272022.jpeg', 1, 1, '-6.24930718984745', '106.98423564434052', 9, '2022-05-27 11:03:14', '2022-06-08 10:41:25', NULL);
INSERT INTO `restorans` VALUES (2161, 2, 'KFC BOX GIANT BEKASI / PT.FAST FOOD INDONESIA', 'P.2.02.0003401.14.02', 'KFC BOX GIANT BEKASI / PT.FAST FOOD INDONESIA', 'JL.AHMAD YANI', 'BEKASI SELATAN', 'MARGAJAYA', NULL, NULL, 5, 24, 100000, 179000000, 10.00, NULL, '2022_RESTORAN_0216105272022.jpg', 1, 1, '-6.249781785763812', '106.99275434017183', 9, '2022-05-27 11:16:36', '2022-06-08 10:42:12', NULL);
INSERT INTO `restorans` VALUES (2162, 2, 'ANDRIAN CHRISTOPHER AGUS', 'P.2.02.0004442.14.01', 'PUYO DESSERT / PT.PUYO INDONESIA KREASI', 'JL.NOER ALI NO.3 RUKO BSD SEKTOR VII LAGOON EVENUE KEL. PEKAYON JAYA', 'BEKASI SELATAN', 'PEKAYONJAYA', NULL, NULL, 2, NULL, 100000, 165000000, 10.00, '08118074058', '2022_RESTORAN_0216205302022.jpg', 0, 1, NULL, NULL, 9, '2022-05-30 14:07:53', '2022-06-08 10:44:01', NULL);
INSERT INTO `restorans` VALUES (2163, 3, 'WENNY APRILIA', 'P.2.02.0005419.14.04', 'HAPPY LEMON', 'JL. BOULEVARD RAYA BLOK RSOA NO', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 2, 12, 55000, 16747500, 10.00, '081291399313', '2022_RESTORAN_0216305302022.jpg', 0, 1, NULL, NULL, 9, '2022-05-30 14:25:26', '2022-06-08 10:45:33', NULL);
INSERT INTO `restorans` VALUES (2164, 2, 'ANDRIAN CHIRSTAPER AGUS', 'P.2.02.0003600.14.04', 'PUYO / PT.PUYO INDONESIA KREASI', 'GRAND GALAXY PARK JL.BOULEVARD RAYA TIMUR  KEL. JAKASETIA', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 3, NULL, 100000, 166000000, 10.00, NULL, '2022_RESTORAN_0216405302022.jpg', 0, 1, NULL, NULL, 9, '2022-05-30 14:31:44', '2022-06-08 10:47:24', NULL);
INSERT INTO `restorans` VALUES (2165, 2, 'NURMALIK', 'P.2.02.0004723.16.05', 'CIGANEA', 'REST AREA KM.06', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 4, 15, 25000, 9875000, 10.00, NULL, '2022_RESTORAN_0216505312022.jpg', 0, 1, '-6.258576841017011', '106.92627444580559', 18, '2022-05-31 10:03:47', '2022-06-02 15:30:34', NULL);
INSERT INTO `restorans` VALUES (2166, 2, 'ANDI MOCH.APRILLAH', 'P.2.02.0004933.16.01', 'LUBERGER', 'JL.JATIWARINGIN NO.V3', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 8, 10, 50000, 36625000, 10.00, NULL, '2022_RESTORAN_0216605312022.png', 1, 1, '-6.260987101166513', '106.9107752628076', 18, '2022-05-31 10:14:11', '2022-06-27 14:34:25', NULL);
INSERT INTO `restorans` VALUES (2167, 2, 'SWADY SUSINDRA', 'P.2.02.0004667.14.04', 'YUMMY HOT PLAT / PT.YUMMY CITRARASA ASIA', 'JL.BOULEVAR GALAXI', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 8, NULL, 50000, 236500000, 10.00, '085770085907', '2022_RESTORAN_0216705312022.jpg', 0, 1, NULL, NULL, 9, '2022-05-31 10:20:01', '2022-06-08 10:48:21', NULL);
INSERT INTO `restorans` VALUES (2168, 3, 'ZONI BANGUN', 'P.2.02.0005159.14.04', 'FORESTHREE COFFEE', 'JL. BOULEVARD RAYA RUKO RGB NO. 56.', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 2, 10, 19000, 2116600, 10.00, NULL, '2022_RESTORAN_0216805312022.jpg', 1, 1, '-6.276694401583371', '106.97464942932129', 9, '2022-05-31 10:20:41', '2022-06-08 10:58:08', NULL);
INSERT INTO `restorans` VALUES (2169, 1, 'ADI MUDA SIMARMATA', 'P.2.02.0004557.14.04', 'GILGALBI KOREAN BBQ', 'BOULEVARD RAYA TIMUR RGB032', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 14, 56, 98000, 11113200, 10.00, NULL, '2022_RESTORAN_0216905312022.jpg', 0, 1, '-6.277230293464137', '106.97448541850007', 9, '2022-05-31 10:36:02', '2022-06-08 10:59:23', NULL);
INSERT INTO `restorans` VALUES (2170, 2, 'TOGAR LEONARD TAMPUBOLON', 'P.2.02.0005506.14.04', 'PINUS', 'RUKAN CORDOVA RGC 3 NO. 02 GRAND GALAXY CITY', 'BEKASI SELATAN', 'JAKASETIA', NULL, NULL, 9, 20, 65000, 28080000, 10.00, '082125000874', '2022_RESTORAN_0217005312022.jpg', 0, 1, NULL, NULL, 9, '2022-05-31 10:39:58', '2022-06-08 11:01:04', NULL);
INSERT INTO `restorans` VALUES (2171, 2, 'IR. HERIANTO LEMENA', 'P.2.02.0005061.16.05', 'CAFE JALAN JALAN GRAND  CAMAN', 'JL. RAYA JATIBENING RT 001 RW 003', 'PONDOKGEDE', 'JATIBENING BARU', '1', '3', 4, 20, 40000, 24100000, 10.00, NULL, '2022_RESTORAN_0217105312022.jpg', 0, 1, '-6.264189210389294', '106.94488996596311', 18, '2022-05-31 11:01:25', '2022-06-27 14:35:02', NULL);
INSERT INTO `restorans` VALUES (2172, 3, 'JOHAR BARU', 'P.2.02.0005467.14.04', 'TRAFFIC BUN / PT. JCR KARYA CIPTA MANDIRI', 'JL. BOULEVARD RAYA GRAND GALAXY CITY RGA. 20', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 10, 2, 30000, 3429000, 10.00, NULL, '2022_RESTORAN_0217205312022.jpg', 0, 1, '-6.278122556855643', '106.97392158912454', 9, '2022-05-31 11:20:52', '2022-06-08 11:02:49', NULL);
INSERT INTO `restorans` VALUES (2173, 2, 'HAUS! / PT. INSPIRASI BISNIS NUSANTARA', 'P.2.02.0005193.14.04', 'HAUS! / PT. INSPIRASI BISNIS NUSANTARA', 'RUKO GRIYA ALIFA NO. A2 JL. PULO RIBUNG GALAXY', 'BEKASI SELATAN', 'PEKAYONJAYA', '002', '017', 7, 2, 15000, 4627500, 10.00, NULL, '2022_RESTORAN_0217305312022.jpg', 0, 1, '-6.267168230281639', '106.97405678044166', 9, '2022-05-31 11:48:13', '2022-06-08 11:03:49', NULL);
INSERT INTO `restorans` VALUES (2174, 3, 'FINDAL DARMAJA', 'P.2.02.0005438.14.04', 'GILDAK GRAND GALAXI', 'GRAND GALAXI CITYJL. BOULEVARD RAYA RT. 017 RW. 018', 'BEKASI SELATAN', 'JAKASETIA', '007', '018', 4, 15, 20000, 4130000, 10.00, NULL, '2022_RESTORAN_0217406062022.jpg', 0, 1, '-6.278088785987477', '106.97392338137658', 9, '2022-05-31 12:03:10', '2022-06-08 11:04:43', NULL);
INSERT INTO `restorans` VALUES (2175, 2, 'MICHAEL MULYADI', 'P.2.02.0005441.14.04', 'SUSHIMAS', 'JL. PULO RIBUANG NO.21', 'BEKASI SELATAN', 'JAKASETIA', '001', '019', 20, 26, 90000, 54630000, 10.00, NULL, '2022_RESTORAN_0217505312022.jpg', 0, 1, '-6.268202706644349', '106.97127446212147', 9, '2022-05-31 12:13:05', '2022-06-08 11:05:40', NULL);
INSERT INTO `restorans` VALUES (2176, 3, 'RAHMAT SYAHRULLAH', 'P.2.02.0005429.14.04', 'KOPI KOUP+', 'JL. TAMAN ASTER BLOK P1 NO. 23 RT. 008 RW. 014', 'BEKASI SELATAN', 'JAKASETIA', '008', '014', 8, 23, 60000, 18510000, 10.00, NULL, '2022_RESTORAN_0217605312022.jpg', 0, 1, '-6.259640662962941', '106.9717964937976', 9, '2022-05-31 12:20:12', '2022-06-08 11:07:28', NULL);
INSERT INTO `restorans` VALUES (2177, 2, 'RM. RAJA GURAME', 'P.2.02.0000627.16.01', 'RM. RAJA GURAME', 'RUKO PONDOK GEDE PLAZA BLOK A NO. 27', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 20, 45000, 52897500, 10.00, NULL, '2022_RESTORAN_0217705312022.jpg', 1, 1, '-6.283752490097376', '106.91262355751016', 18, '2022-05-31 14:10:17', '2022-06-29 09:37:02', NULL);
INSERT INTO `restorans` VALUES (2178, 1, 'RM. RAJA GURAME', 'P.2.02.0000627.16.01', 'RM. RAJA GURAME', 'RUKO PONDOK GEDE PLAZA BLOK A NO. 27', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 8, 20, 50000, 47450000, 10.00, NULL, '2022_RESTORAN_0217805312022.jpg', 1, 4, '-6.2819568', '106.9140047', 18, '2022-05-31 14:14:58', '2022-05-31 14:19:43', '2022-05-31 14:19:43');
INSERT INTO `restorans` VALUES (2179, 2, 'WINCE SUDARTO', 'P.2.02.0005535.16.02', 'SHIHLIN', 'REST AREA KM 6B', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 4, 3, 50000, 30125000, 10.00, NULL, '2022_RESTORAN_0217905312022.jpg', 0, 4, '-6.264409393841187', '106.9116761640255', 18, '2022-05-31 14:29:06', '2022-06-06 08:08:56', '2022-06-06 08:08:56');
INSERT INTO `restorans` VALUES (2180, 2, 'RM PADANG TARASO', 'P.2.02.0001136.16.01', 'RM PADANG TARASO', 'JL RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 20, 45000, 50625000, 10.00, NULL, '2022_RESTORAN_0218005312022.jpg', 0, 1, '-6.2751898131322905', '106.91261733468066', 18, '2022-05-31 14:31:54', '2022-06-27 14:35:33', NULL);
INSERT INTO `restorans` VALUES (2181, 2, 'PT. AKANG BERSAMA CISE', 'P.2.02.0005798.16.02', 'BAKSO ACI AKANG', 'JL. RAYA CAMAN NO. 89D', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 3, 15, 60000, 70500000, 10.00, NULL, '2022_RESTORAN_0218105312022.jpg', 0, 1, '-6.264957074158932', '106.94417668964762', 18, '2022-05-31 14:41:41', '2022-06-27 14:36:17', NULL);
INSERT INTO `restorans` VALUES (2182, 1, 'SEJENIWATI GUSMA', 'P.2.02.0002493.16.01', 'DOM PIZZA/PT.DOM PIZZA INDONESIA', 'JL.JATIWARINGIN PLAZA PONDOK GEDE2', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 20, 150000, 164325000, 10.00, NULL, '2022_RESTORAN_0218205312022.jpg', 0, 1, '-6.28376226550551', '106.91170736514067', 18, '2022-05-31 14:43:01', '2022-06-27 14:36:56', NULL);
INSERT INTO `restorans` VALUES (2183, 3, 'ANIMAR', 'P.2.02.0002544.16.01', 'RM.PADANG SARI RASO', 'RUKO PONDOK GEDE MALL', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 14, 15000, 6292500, 10.00, NULL, '2022_RESTORAN_0218305312022.jpg', 0, 1, '-6.283852023736078', '106.91146262465597', 18, '2022-05-31 14:50:26', '2022-06-27 15:22:42', NULL);
INSERT INTO `restorans` VALUES (2184, 3, 'NASIRAN', 'P.2.02.0002305.16.04', 'RM.PADANG MINANG BARU', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 10, 15000, 5970000, 10.00, NULL, '2022_RESTORAN_0218405312022.jpg', 0, 1, '-6.260444971241675', '106.91033079086927', 18, '2022-05-31 14:56:38', '2022-06-27 15:22:59', NULL);
INSERT INTO `restorans` VALUES (2185, 1, 'SUKOWATI SOSRODJOJO', 'P.2.02.0002052.16.04', 'MC DONALDS JATIWARINGIN', 'JL. RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', '1', '9', 10, 50, 170000, 2689825000, 10.00, NULL, '2022_RESTORAN_0218505312022.jpg', 0, 1, '-6.2682462549101', '106.91138409121285', 18, '2022-05-31 15:01:05', '2022-06-27 14:37:34', NULL);
INSERT INTO `restorans` VALUES (2186, 3, 'R.TUBAGUS RAHMAN', 'P.2.02.0003802.16.01', 'SUKA SUNDA', 'JL.JATIWARINGIN RUKO PONDOK GEDE G/7 RT.04/01', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 10, 15000, 3637500, 10.00, NULL, '2022_RESTORAN_0218605312022.jpg', 0, 4, '-6.283660065266608', '106.91217554481058', 18, '2022-05-31 15:13:06', '2022-06-30 08:47:09', NULL);
INSERT INTO `restorans` VALUES (2187, 2, 'WINCE SUDARTO', 'P.2.02.0005535.16.02', 'SHIHLIN TAIWAN STREAT SNACKS', 'REST AREA KM 6B', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 4, 6, 70000, 91350000, 10.00, NULL, '2022_RESTORAN_0218705312022.jpg', 0, 1, '-6.2584310875740385', '106.9276823441548', 18, '2022-05-31 15:20:55', '2022-06-27 14:38:43', NULL);
INSERT INTO `restorans` VALUES (2188, 1, 'INDRAJITH SANJEVA S GUNAWARDENA', 'P.2.02.0003669.16.01', 'THE HARVEST / PT.MOUNT SCOPUS INDONESIA', 'THE HARVEST / PT.MOUNT SCOPUS INDONESIA', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 6, 10, 325000, 742625000, 10.00, NULL, '2022_RESTORAN_0218805312022.jpg', 0, 1, '-6.269913498042298', '106.9116518460826', 18, '2022-05-31 15:34:52', '2022-06-27 15:36:03', NULL);
INSERT INTO `restorans` VALUES (2189, 1, 'ARDIANTO KRESNAWAN', 'P.2.02.0003885.16.01', 'BAKSO LAPANGAN TEMBAK', 'PLAZA PONDOK GEDE BLOK.E NO.9 JL. JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 10, 20, 125000, 166250000, 10.00, NULL, '2022_RESTORAN_0218905312022.jpg', 1, 1, '-6.283654732751403', '106.91234144088402', 18, '2022-05-31 15:48:01', '2022-06-27 15:30:26', NULL);
INSERT INTO `restorans` VALUES (2190, 3, 'IR.RATNA SARI', 'P.2.02.0004169.16.01', 'BAKSO ACI AKANG', 'JL.RAYA JATIWARINGIN NO.103', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 10, 15000, 7185000, 10.00, NULL, '2022_RESTORAN_0219006022022.jpg', 0, 1, '-6.271257244234234', '106.91189657170601', 18, '2022-06-02 14:14:32', '2022-06-27 15:29:52', NULL);
INSERT INTO `restorans` VALUES (2191, 3, 'DRS. SOEBANDIONO', 'P.2.02.0004298.16.01', 'WAROENG KEBON', 'JL.JATIWARINGIN ASRI G-19 NO.1', 'BANTARGEBANG', 'BANTARGEBANG', NULL, NULL, 4, 10, 12000, 4020000, 10.00, NULL, '2022_RESTORAN_0219106022022.jpg', 0, 4, '-6.2855636', '106.924067', 18, '2022-06-02 14:18:28', '2022-06-06 08:06:56', '2022-06-06 08:06:56');
INSERT INTO `restorans` VALUES (2192, 3, 'DRS. SOEBANDIONO', 'P.2.02.0004298.16.01', 'WAROENG KEBON', 'JL.JATIWARINGIN ASRI G-19 NO.1', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 10, 20000, 3280000, 10.00, NULL, '2022_RESTORAN_0219206022022.jpg', 0, 4, '-6.269346492069964', '106.9217558622702', 18, '2022-06-02 14:20:43', '2022-06-03 11:49:59', '2022-06-03 11:49:59');
INSERT INTO `restorans` VALUES (2193, 2, 'JUGO WIDIJANTO', 'P.2.02.0004310.16.01', 'POINT CAFE / PT.INDOMARCO PRISMATAMA', 'KP.KEMANG RT.008/007', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 6, 165000, 306487500, 10.00, NULL, '2022_RESTORAN_0219306022022.jpg', 0, 1, '-6.277727082546829', '106.91329326453156', 18, '2022-06-02 14:28:37', '2022-06-27 15:34:53', NULL);
INSERT INTO `restorans` VALUES (2194, 2, 'HENRY MULYADI CHANDRA', 'P.2.02.0004380.16.01', 'LEHA LEHA COFFE SHOP', 'JL.JATIWARINGIN RAYA NO.200', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 20, 30000, 21210000, 10.00, NULL, '2022_RESTORAN_0219406022022.jpg', 0, 1, '-6.281377884033905', '106.91381404836194', 18, '2022-06-02 14:41:46', '2022-06-27 15:35:10', NULL);
INSERT INTO `restorans` VALUES (2195, 2, 'VINNA KARINDAH', 'P.2.02.0004409.16.01', 'KOPI JANJI JIWA JILID 244', 'RUKO PLAZA PONDOK GEDE BLOK.G NO.25', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 10, 20000, 10900000, 10.00, NULL, '2022_RESTORAN_0219506022022.jpg', 0, 1, '-6.2819572', '106.9140026', 18, '2022-06-02 14:46:28', '2022-06-27 15:35:38', NULL);
INSERT INTO `restorans` VALUES (2196, 1, 'JUGO WIDIJATNO', 'P.2.02.0004439.16.01', 'POINT CAFE / PT.INDOMARCO PRISMATAMA', 'JL.RAYA JATIWARINGIN NO.66', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 10, 68000, 78880000, 10.00, NULL, '2022_RESTORAN_0219606022022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-02 14:51:53', '2022-06-27 15:37:04', NULL);
INSERT INTO `restorans` VALUES (2197, 3, 'BAKMI JOGJA KONDE', 'P.2.02.0004299.16.01', 'BAKMI JOGJA KONDE', 'JL.RAYA JATIWARINGIN NO.200', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 6, 17000, 3723000, 10.00, NULL, '2022_RESTORAN_0219706022022.jpg', 0, 1, '-6.281790241901649', '106.91389364135962', 18, '2022-06-02 14:56:29', '2022-06-27 15:37:20', NULL);
INSERT INTO `restorans` VALUES (2198, 2, 'H. M. SHOLEH, SE', 'P.2.02.0005395.16.05', 'coffee kenyang inc', 'JL. RAYA KEMANG SARI NO. 13', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 4, 10, 15000, 3127500, 10.00, NULL, '2022_RESTORAN_0219806022022.jpg', 0, 1, '-6.27565994125731', '106.93423837633651', 18, '2022-06-02 14:57:10', '2022-06-27 14:39:28', NULL);
INSERT INTO `restorans` VALUES (2199, 2, 'YOGA PRAMADHANA', 'P.2.02.0004736.16.01', 'UNCLE BREW FEAT WARMEAL', 'JL.RAYA JATIWARINGIN RT.003 RW.003', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 10, 30000, 9735000, 10.00, NULL, '2022_RESTORAN_0219906022022.jpg', 0, 1, '-6.279835093885687', '106.91329971785369', 18, '2022-06-02 15:03:31', '2022-06-27 15:44:21', NULL);
INSERT INTO `restorans` VALUES (2200, 3, 'FEINDRYANI CATRINE', 'P.2.02.0004771.16.01', 'PEMPEK MUSI RAYA 2', 'L.RAYA JATIWARINGIN NO.134', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 2, 12, 25000, 9562500, 10.00, NULL, '2022_RESTORAN_0220006022022.jpg', 0, 1, '-6.282288802054931', '106.9138512800008', 18, '2022-06-02 15:07:31', '2022-06-27 15:44:48', NULL);
INSERT INTO `restorans` VALUES (2201, 2, 'GUFRON SYARIF', 'P.2.02.0004804.16.01', 'HAUS / PT.INSPIRASI BISNIS NUSANTARA', 'JL.JATIWARINGIN RAYA NO.165', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 6, 105000, 280875000, 10.00, NULL, '2022_RESTORAN_0220106022022.jpg', 0, 1, '-6.271125714281363', '106.91191113011857', 18, '2022-06-02 15:16:26', '2022-06-27 15:45:15', NULL);
INSERT INTO `restorans` VALUES (2202, 2, 'WILLIAM WINATA', 'P.2.02.0004935.16.01', 'XIBOBA', 'JL.RAYA JATIWARINGIN NO.234', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 6, 30000, 11520000, 10.00, NULL, '2022_RESTORAN_0220206022022.jpg', 0, 1, '-6.283013092293409', '106.9138001776865', 18, '2022-06-02 15:31:14', '2022-06-27 15:47:52', NULL);
INSERT INTO `restorans` VALUES (2203, 1, 'LIBERTY SUNTORY', 'P.2.02.0005477.16.05', 'STARBUCKS / PT. SARI COFFEE', 'REST AREA JATI BENING BARU', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 6, 20, 150000, 141750000, 10.00, NULL, '2022_RESTORAN_0220306022022.jpg', 0, 1, '-6.258421311202755', '106.92770058100764', 18, '2022-06-02 15:36:12', '2022-06-27 14:40:03', NULL);
INSERT INTO `restorans` VALUES (2204, 3, 'ANGGARA SOEKOWATI LUKMANA', 'P.2.02.0005481.16.05', 'SMOOLY JUICE', 'JL. CAMAN RAYA NO. 59', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 3, 3, 20000, 12900000, 10.00, NULL, '2022_RESTORAN_0220406022022.jpg', 0, 1, '-6.265761374410277', '106.94377638337676', 18, '2022-06-02 15:48:06', '2022-06-27 14:40:37', NULL);
INSERT INTO `restorans` VALUES (2205, 2, 'KOPI KENANGAN PLAZA PONDOK GEDE', 'P.2.02.0004976.16.01', 'KOPI KENANGAN PLAZA PONDOK GEDE', 'PLAZA PONDOK GEDE LT2. JL.RAYA PONDOK GEDE', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 3, 65000, 130162500, 10.00, NULL, '2022_RESTORAN_0220506022022.jpg', 0, 1, '-6.283798702506601', '106.91174296576006', 18, '2022-06-02 15:50:03', '2022-06-27 15:50:46', NULL);
INSERT INTO `restorans` VALUES (2206, 2, 'RISKA PERMATASARI', 'P.2.02.0004945.16.01', 'XIBOBA PLAZA PONDOK GEDE', 'PLAZA PONDOK GEDE LT.2', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 2, 3, 32000, 12064000, 10.00, NULL, '2022_RESTORAN_0220606022022.jpg', 0, 1, '-6.284232386866623', '106.91251548869039', 18, '2022-06-02 15:57:45', '2022-06-27 15:59:23', NULL);
INSERT INTO `restorans` VALUES (2207, 2, 'GALIH LUTHFI PRATAMA', 'P.2.02.0004964.16.01', '9O BUN', 'JL.JATIWARINGIN RAYA NO.95A', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 12, 50000, 13300000, 10.00, NULL, '2022_RESTORAN_0220706022022.jpg', 0, 1, '-6.279875085763751', '106.91337536098037', 18, '2022-06-02 16:01:39', '2022-06-27 15:59:41', NULL);
INSERT INTO `restorans` VALUES (2208, 2, 'KEDAI LOKL', 'P.2.02.0004997.16.01', 'KEDAI LOKL', 'JL. JATIWARINGIN RAYA NO. 41', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 10, 23000, 8763000, 10.00, NULL, '2022_RESTORAN_0220806022022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-02 16:04:44', '2022-06-27 15:59:57', NULL);
INSERT INTO `restorans` VALUES (2209, 2, 'MARBIO SUSTANU', 'P.2.02.0005465.16.05', 'YUMMY KITCHEN 32', 'JL. KINCAN RAYA NO. 22', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 5, 10, 80000, 147200000, 10.00, NULL, '2022_RESTORAN_0220906022022.jpg', 0, 1, '-6.256688263103321', '106.94198360773223', 18, '2022-06-02 16:05:05', '2022-06-27 14:41:17', NULL);
INSERT INTO `restorans` VALUES (2210, 1, 'STEVAN LIE', 'P.2.02.0005040.16.01', 'RM. ONO STEIK/PT. ONO ST', 'JL. RAYA JATIWARINGIN NO. 63 RT. 002/003', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 6, 20, 125000, 73812500, 10.00, NULL, '2022_RESTORAN_0221006022022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-02 16:09:09', '2022-06-27 16:00:13', NULL);
INSERT INTO `restorans` VALUES (2211, 1, 'DE HALU CAFE', 'P.2.02.0005092.16.01', 'DE HALU CAFE', 'JL. JATIWARINGIN NO. 227 RT. 001/004', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 16, 60000, 122550000, 10.00, NULL, '2022_RESTORAN_0221106022022.jpg', 0, 4, '-6.2855636', '106.924067', 18, '2022-06-02 16:12:57', '2022-06-10 13:04:30', '2022-06-10 13:04:30');
INSERT INTO `restorans` VALUES (2212, 2, 'WILLIAM', 'P.2.02.0004703.16.05', 'JANJI JIWA JILID 26', 'JL. KINCAN RAYA NO. 22', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 5, 15, 110000, 137775000, 10.00, NULL, '2022_RESTORAN_0221206032022.jpg', 0, 1, '-6.256606498733894', '106.94129337603819', 18, '2022-06-03 08:22:46', '2022-06-27 14:42:23', NULL);
INSERT INTO `restorans` VALUES (2213, 1, 'DALIMIN JUWONO', 'P.2.02.0003723.16.04', 'KFC REST AREA KM 6', 'REST AREA KM.6', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 15, 30, 190000, 568100000, 10.00, NULL, '2022_RESTORAN_0221306032022.jpg', 0, 1, '-6.258442641481916', '106.92773020508747', 18, '2022-06-03 08:31:04', '2022-06-27 14:42:58', NULL);
INSERT INTO `restorans` VALUES (2214, 3, 'MELANIE MUHDIN', 'P.2.02.0005924.16.05', 'ROTI BOY', 'JL. KINCAN NO. 22', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 3, 2, 25000, 21875000, 10.00, NULL, '2022_RESTORAN_0221406032022.jpg', 0, 1, '-6.255427132506439', '106.94404290184856', 18, '2022-06-03 08:56:10', '2022-06-27 14:43:35', NULL);
INSERT INTO `restorans` VALUES (2215, 1, 'WAHYU WISMA I', 'P.2.02.0002553.16.02', 'RM SEDERHANA', 'JL. RAYA JATIBENING', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 10, 50, 270000, 496800000, 10.00, NULL, '2022_RESTORAN_0221506032022.jpg', 0, 1, '-6.257969830477421', '106.95011531603791', 18, '2022-06-03 09:06:25', '2022-06-27 14:44:14', NULL);
INSERT INTO `restorans` VALUES (2216, 3, 'SUPARJO', 'P.2.02.0005385.16.05', 'AYAM GEPREK GOLD CHICK', 'JL. RAYA JATIBENING NO. 57 D', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 6, 20000, 16450000, 10.00, NULL, '2022_RESTORAN_0221606032022.jpg', 0, 4, '-6.27008502206951', '106.92218123238058', 18, '2022-06-03 09:27:38', '2022-06-03 09:30:47', NULL);
INSERT INTO `restorans` VALUES (2217, 2, 'RM SARIBUNGO', 'P.2.02.0000173.16.02', 'REST.SARIBUNGO', 'JL.RAYA CAMAN NO.34', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 7, 25, 150000, 187875000, 10.00, NULL, '2022_RESTORAN_0221706032022.jpg', 0, 1, '-6.254275316553675', '106.95190445876217', 18, '2022-06-03 09:45:31', '2022-06-27 14:44:42', NULL);
INSERT INTO `restorans` VALUES (2218, 3, 'GUDANG ROTTIE', 'P.2.02.0001734.16.02', 'GUDANG ROTTIE', 'VILLA JATI BENING TOL.BLOK.A NO.4', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 10, 20000, 10750000, 10.00, NULL, '2022_RESTORAN_0221806032022.jpg', 0, 1, '-6.258814134821751', '106.94961275354449', 18, '2022-06-03 09:57:30', '2022-06-27 14:45:08', NULL);
INSERT INTO `restorans` VALUES (2219, 2, 'RM. ANTON', 'P.2.02.0002187.16.02', 'RM. ANTON', 'JL. RAYA CAMAN NO.26.', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 10, 50000, 40250000, 10.00, NULL, '2022_RESTORAN_0221906032022.jpg', 0, 1, '-6.262259770700478', '106.94685743672682', 18, '2022-06-03 13:32:36', '2022-06-29 15:16:33', NULL);
INSERT INTO `restorans` VALUES (2220, 3, 'FLAMBOYAN MIE', 'P.2.02.0003209.16.02', 'FLAMBOYAN MIE', 'JL.RAYA CAMAN NO.168 B', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 3, 10, 15000, 1027500, 10.00, NULL, '2022_RESTORAN_0222006032022.jpg', 0, 1, '-6.2593233829601695', '106.94879285197855', 18, '2022-06-03 13:39:11', '2022-06-29 15:17:16', NULL);
INSERT INTO `restorans` VALUES (2221, 2, 'RM. SAMBAL HIJAU', 'P.2.02.0002190.16.02', 'RM. SAMBAL HIJAU', 'JL. RAYA DR. RATNA', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 15, 45000, 10777500, 10.00, NULL, '2022_RESTORAN_0222106032022.jpg', 0, 1, '-6.261325709669128', '106.95088530831775', 18, '2022-06-03 13:51:05', '2022-06-29 15:17:32', NULL);
INSERT INTO `restorans` VALUES (2222, 1, 'ERWIN LESMANA', 'P.2.02.0002808.16.02', 'RICHEESE FACTORY', 'JL.RAYA CAMAN', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 10, 15, 200000, 547000000, 10.00, NULL, '2022_RESTORAN_0222206032022.jpg', 0, 1, '-6.262720135654217', '106.94629968175433', 18, '2022-06-03 14:00:36', '2022-06-29 15:18:09', NULL);
INSERT INTO `restorans` VALUES (2223, 3, 'RM. AUTO CAFE', 'P.2.02.0002840.16.02', 'RM. AUTO CAFE', 'JL.RAYA CAMAN NO.45', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 10, 20000, 3970000, 10.00, NULL, '2022_RESTORAN_0222306032022.jpg', 0, 1, '-6.253574981835694', '106.95165831709606', 18, '2022-06-03 14:23:41', '2022-06-29 15:18:24', NULL);
INSERT INTO `restorans` VALUES (2224, 3, 'RAFLI INDRA MAHARY', 'P.2.02.0003554.16.02', 'BAKSO GARUDA RATNA', 'JL.RATNA RAYA JATIBENING NO.22', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 3, 10, 20000, 10100000, 10.00, NULL, '2022_RESTORAN_0222406032022.jpg', 0, 1, '-6.2610226514024205', '106.95066119298399', 18, '2022-06-03 14:29:34', '2022-06-29 15:19:06', NULL);
INSERT INTO `restorans` VALUES (2225, 2, 'BRENDA KALALO', 'P.2.02.0003869.16.02', 'RESTORAN ROA MANADO', 'JL.CAMAN RAYA NO.21', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 5, 15, 100000, 114000000, 10.00, NULL, '2022_RESTORAN_0222506062022.jpg', 1, 1, '-6.2512428982530475', '106.95308574038164', 18, '2022-06-06 09:43:37', '2022-06-29 15:18:43', NULL);
INSERT INTO `restorans` VALUES (2226, 3, 'SUGANDI TANUDJAJA', 'P.2.02.0003849.16.02', 'BAKMI CAHAYA', 'JL.CAMAN RAYA NO.7', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 10, 20000, 3950000, 10.00, NULL, '2022_RESTORAN_0222606062022.jpg', 0, 4, '-6.2517228252549435', '106.95226517201395', 18, '2022-06-06 09:55:24', '2022-06-13 08:37:38', NULL);
INSERT INTO `restorans` VALUES (2227, 1, 'ANNUR', 'P.2.02.0003940.16.02', 'SIMPANG RAYA', 'REST.AREA KM.6', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 8, 25, 150000, 163500000, 10.00, NULL, '2022_RESTORAN_0222706062022.jpg', 1, 1, '-6.258427532500367', '106.92756409328777', 18, '2022-06-06 10:10:42', '2022-06-29 15:20:28', NULL);
INSERT INTO `restorans` VALUES (2228, 2, 'AANG ABDUL BASIR', 'P.2.02.0003912.16.02', 'GS SUPERMAKET', 'JL.RAYA CAMAN', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 8, 70000, 70350000, 10.00, NULL, '2022_RESTORAN_0222806062022.jpg', 0, 1, '-6.266415478190966', '106.94395523581977', 18, '2022-06-06 10:19:48', '2022-06-29 15:20:44', NULL);
INSERT INTO `restorans` VALUES (2229, 2, 'BONG FUHTONO', 'P.2.02.0004016.16.02', 'A FUNG BASO SAPI ASLI', 'REST AREA KM.G TOL CIKAMPEK JAKARTA', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 4, 10, 100000, 104500000, 10.00, NULL, '2022_RESTORAN_0222906062022.jpg', 1, 1, '-6.258512851657966', '106.92719617700484', 18, '2022-06-06 10:57:09', '2022-06-29 15:21:21', NULL);
INSERT INTO `restorans` VALUES (2230, 2, 'MIKA MAULANA S', 'P.2.02.0005651.22.01', 'BURGER BANGOR', 'JL.RAYA HANKAM', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 3, 5, 1250000, 2280625000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:19:44', '2022-06-07 09:19:44', NULL);
INSERT INTO `restorans` VALUES (2231, 2, 'KARTO', 'P.2.02.0002425.22.01', 'RM. D YUDIS RESTO', 'JL.RAYA HANKAM NO.45', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 5, 30, 55000, 32697500, 10.00, NULL, NULL, 0, 1, NULL, NULL, 20, '2022-06-07 09:22:27', '2022-06-07 13:31:07', NULL);
INSERT INTO `restorans` VALUES (2232, 1, 'SAMAN SURATMAN', 'P.2.02.0003166.22.01', 'LESEHAN KAI JISIN', 'JL.RAYA HANKAM PONDOK MELATI NO.34', 'PONDOKMELATI', 'JATIMELATI', '002', '05', 6, 14, 45000, 17347500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:26:16', '2022-06-07 09:26:16', NULL);
INSERT INTO `restorans` VALUES (2233, 2, 'SRI YUNINGSIH', 'P.2.02.0003517.22.01', 'SATE BAROKAH GERBANG PURI GADING', 'JL.KP.SAWAH GERBANG PURI GADING', 'PONDOKMELATI', 'JATIMELATI', '001', '04', 3, 16, 50000, 26650000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:29:01', '2022-06-07 09:29:01', NULL);
INSERT INTO `restorans` VALUES (2234, 2, 'HERU SUTRISNA', 'P.2.02.0004907.22.01', 'AYAM KEPREK SULTAN', 'PURI GADING', 'PONDOKMELATI', 'JATIMELATI', '005', '11', 3, 10, 25000, 13687500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:31:37', '2022-06-07 09:31:37', NULL);
INSERT INTO `restorans` VALUES (2235, 2, 'BONG TJIN ION', 'P.2.02.0003602.22.01', 'BAKMI KALIMANTAN', 'RUKO PURI GADING', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 3, 14, 50000, 20025000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:34:40', '2022-06-07 09:34:40', NULL);
INSERT INTO `restorans` VALUES (2236, 2, 'RIRIH WIDAYATI', 'P.2.02.0003564.22.03', 'BAKSO KOTA CAK MAN', 'RUKO PURI GADING PG 2/30', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 4, 12, 25000, 28575000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:39:04', '2022-06-07 09:39:04', NULL);
INSERT INTO `restorans` VALUES (2237, 2, 'DIAN WIDYANINGRUM', 'P.2.02.0003591.22.01', 'OTO BENTO', 'RUKO PURI GADING PG 1 NO.9', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 3, 10, 30000, 16125000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:46:40', '2022-06-07 09:46:40', NULL);
INSERT INTO `restorans` VALUES (2238, 2, 'MUHAMMAD SADIM', 'P.2.02.0002585.22.01', 'RM.LESEHAN SATE GOMBONG', 'JL.ALTERNATIF JORR KP.SAWAH', 'PONDOKMELATI', 'JATIMELATI', NULL, NULL, 10, 20, 45000, 31117500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 20, '2022-06-07 09:53:52', '2022-06-07 09:53:52', NULL);
INSERT INTO `restorans` VALUES (2239, 3, 'ANDREAS PRANAJAYA IRAWAN', 'P.2.02.0005568.14.04', 'DEAR BUTTER', 'GRAND GALAXY CITY RSNB - 15', 'BEKASI SELATAN', 'JAKASETIA', '001', '002', 3, 2, 86000, 10638200, 10.00, '081222899967', '2022_RESTORAN_0223906072022.jpg', 0, 1, '-6.2754599816825785', '106.97401167093227', 9, '2022-06-07 11:32:22', '2022-06-08 11:08:18', NULL);
INSERT INTO `restorans` VALUES (2240, 3, 'RM. SARI RAOS', 'P.2.02.0002005.14.04', 'RM. SARI RAOS', 'RUKO TAMAN GALAXY BLOK.A NO.20', 'BEKASI SELATAN', 'JAKASETIA', '001', '014', 10, 30, 150000, 24345000, 10.00, NULL, '2022_RESTORAN_0224006072022.jpg', 0, 1, '-6.257581450154318', '106.96796523060948', 9, '2022-06-07 11:47:10', '2022-06-08 11:08:58', NULL);
INSERT INTO `restorans` VALUES (2241, 3, 'RM.MASTER PENYET', 'P.2.02.0002720.14.04', 'RM.MASTER PENYET', 'RUKO TAMAN GALAXY BLOK.H.NO.18', 'BEKASI SELATAN', 'JAKASETIA', '004', '014', 3, 24, 39000, 3783000, 10.00, NULL, '2022_RESTORAN_0224106072022.jpg', 0, 1, '-6.258984772508523', '106.96882225945791', 9, '2022-06-07 11:52:06', '2022-06-08 11:10:43', NULL);
INSERT INTO `restorans` VALUES (2242, 2, 'JUNI PARK', 'P.2.02.0005546.14.04', 'JUNI PARK', 'KP. UTAN RT. 006 RW. 002', 'BEKASI SELATAN', 'JAKASETIA', '006', '002', 6, 40, 50000, 12580000, 10.00, NULL, '2022_RESTORAN_0224206072022.jpg', 0, 4, '-6.2624792884153555', '106.98038659780671', 9, '2022-06-07 12:04:25', '2022-06-09 14:02:50', NULL);
INSERT INTO `restorans` VALUES (2243, 1, 'ZAINAL ARIFIN', 'P.2.02.0004057.16.02', 'SOLARIA REST AREA KM 6', 'JL.TOL JAKARTA TIMUR JATIBENING BARU UNIT BLOK.D 8', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 10, 25, 200000, 582500000, 10.00, NULL, '2022_RESTORAN_0224306082022.jpg', 1, 1, '-6.258488855809029', '106.9279188450479', 18, '2022-06-08 08:09:36', '2022-06-29 15:21:36', NULL);
INSERT INTO `restorans` VALUES (2244, 2, 'ARIANE F', 'P.2.02.0004084.16.02', 'JAVALAND CAFE', 'JL.DR.RATNA NO.19', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 5, 15, 22000, 13530000, 10.00, NULL, '2022_RESTORAN_0224406082022.jpg', 0, 1, '-6.260339211696241', '106.95108340791086', 18, '2022-06-08 08:20:51', '2022-06-29 15:22:05', NULL);
INSERT INTO `restorans` VALUES (2245, 1, 'FERONIA PUTRI WIBOWO', 'P.2.02.0004395.16.02', 'CHATIME', 'JL.CAMAN RAYA NO.21', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 6, 8, 140000, 355320000, 10.00, NULL, '2022_RESTORAN_0224506082022.jpg', 0, 1, '-6.251058037706815', '106.9529558927337', 18, '2022-06-08 08:33:36', '2022-06-29 15:22:21', NULL);
INSERT INTO `restorans` VALUES (2246, 1, 'RESTO HOTEL IBIS', 'P.2.02.0004502.16.02', 'RESTO HOTEL IBIS', 'JL.RAYA CAMAN NO.21', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 10, 30, 300000, 868500000, 10.00, NULL, '2022_RESTORAN_0224606082022.jpg', 1, 1, '-6.251286447607286', '106.95294907871805', 18, '2022-06-08 08:58:20', '2022-06-29 15:22:44', NULL);
INSERT INTO `restorans` VALUES (2247, 2, 'EDWARD DJAJA', 'P.2.02.0005854.12.01', 'HEY KAFE & WOY MAKARONI', 'JL. RAYA BINTARA', 'BEKASI BARAT', 'BINTARA', NULL, NULL, 4, 0, 25000, 33812500, 10.00, NULL, '2022_RESTORAN_0224706082022.jpg', 0, 1, '-6.228957818856962', '106.98108673095705', 11, '2022-06-08 09:06:21', '2022-06-08 09:46:46', NULL);
INSERT INTO `restorans` VALUES (2248, 3, 'POINT CAFE', 'P.2.02.0004469.16.02', 'POINT CAFE', 'JL.CAMAN RAYA', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 3, 5, 57000, 109012500, 10.00, NULL, '2022_RESTORAN_0224806082022.jpg', 0, 1, '-6.251663278549636', '106.9524837646884', 18, '2022-06-08 09:36:38', '2022-06-29 15:22:58', NULL);
INSERT INTO `restorans` VALUES (2249, 1, 'MAKFUT FAUZI', 'P.2.02.0004515.16.02', 'KAMPUNG KECIL', 'JL.RAYA RATNA JATIBENING', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 15, 30, 230000, 217925000, 10.00, NULL, '2022_RESTORAN_0224906082022.jpg', 0, 1, '-6.261275941271032', '106.95065129414589', 18, '2022-06-08 09:51:54', '2022-06-29 15:23:25', NULL);
INSERT INTO `restorans` VALUES (2250, 1, 'KEVIN BUDIMAN', 'P.2.02.0004778.16.02', 'JANJI JIWA JILID 500', 'JL.CAMAN RAYA NO.21', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 5, 10, 100000, 204500000, 10.00, NULL, '2022_RESTORAN_0225006082022.jpg', 0, 1, '-6.2513673239469405', '106.95290207563731', 18, '2022-06-08 10:12:10', '2022-06-29 15:23:59', NULL);
INSERT INTO `restorans` VALUES (2251, 3, 'GUFRON SYARIF', 'P.2.02.0004805.16.02', 'HAUS', 'JL.RAYA JATIBENING NO.94', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 3, 2, 70000, 160650000, 10.00, NULL, '2022_RESTORAN_0225106082022.jpg', 0, 1, '-6.265320564298055', '106.94394865697019', 18, '2022-06-08 11:10:53', '2022-06-29 15:23:42', NULL);
INSERT INTO `restorans` VALUES (2252, 3, 'JANJI JIWA', 'P.2.02.0005014.16.02', 'JANJI JIWA', 'JL. RATNA NO. 36 RT. 01/01', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 3, 10, 25000, 8000000, 10.00, NULL, '2022_RESTORAN_0225206082022.jpg', 0, 1, '-6.260354320297039', '106.95108444185662', 18, '2022-06-08 11:29:34', '2022-06-29 15:24:32', NULL);
INSERT INTO `restorans` VALUES (2253, 1, 'EDWARD TIRTANATA', 'P.2.02.0005066.16.02', 'KOPI KENANGAN GRAND ICON CAMAN', 'JL. CAMAN RAYA NO. 1 JATIBENING', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 5, 8, 95000, 288325000, 10.00, NULL, '2022_RESTORAN_0225306102022.jpg', 0, 1, '-6.25127844817534', '106.95294796794254', 18, '2022-06-10 08:47:11', '2022-06-29 15:24:47', NULL);
INSERT INTO `restorans` VALUES (2254, 2, 'PT PRIMA USAHA ERA MANDIRI/ZAINA SIMAN', 'P.2.02.0002032.11.02', 'A&W BEKASI JUNCTION', 'JL. IR. H. JUANDA BEKASI JUNCTION BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '001', '001', 4, 32, 45000, 119475000, 10.00, '021-883-43091', '2022_RESTORAN_0225406102022.jpg', 0, 1, '-6.240775055025891', '107.00344562530519', 10, '2022-06-10 14:34:53', '2022-06-23 10:35:53', NULL);
INSERT INTO `restorans` VALUES (2255, 2, 'FREDI LINNEN', 'P.2.02.0005533.16.01', 'COFFEE FIRST', 'JL. JATIWARINGIN NO.25', 'PONDOKGEDE', 'JATIWARINGIN', '002', '006', 4, 10, 20000, 6760000, 10.00, NULL, '2022_RESTORAN_0225506132022.png', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-13 11:43:07', '2022-06-29 15:25:03', NULL);
INSERT INTO `restorans` VALUES (2256, 3, 'SUKARTINI', 'P.2.02.0005598.16.01', 'SABANA JATIWARINGIN', 'JL. RAYA GAMPRIT', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 2, 4, 15000, 3930000, 10.00, NULL, '2022_RESTORAN_0225606132022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-13 11:51:41', '2022-06-29 15:25:34', NULL);
INSERT INTO `restorans` VALUES (2257, 2, 'ELISA SUTEJA', 'P.2.02.0005646.16.01', 'FORE COFFEE/PT.FORE KOPI INDONESIA', 'RAYA JATIWARINGIN NO.53', 'PONDOKGEDE', 'JATIWARINGIN', '002', '002', 5, 10, 125000, 240625000, 10.00, NULL, '2022_RESTORAN_0225706132022.png', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-13 11:57:18', '2022-06-29 15:26:06', NULL);
INSERT INTO `restorans` VALUES (2258, 1, 'M. DEDY SURYADI', 'P.2.02.0005532.16.01', 'WARUNG BAKMI DKI', 'RUKO PASAR PONDOK GEDE', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 4, 10, 25000, 12000000, 10.00, NULL, '2022_RESTORAN_0225806132022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-13 12:01:41', '2022-06-29 15:25:49', NULL);
INSERT INTO `restorans` VALUES (2259, 2, 'REIGITA ISMI APRILIANA', 'P.2.02.0005743.16.01', 'FLASH COFFEE / PT. SEMBILAN PULUH ENAM DERAJAT', 'JL. JATIWARINGIN RAYA NO. 199', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 3, 6, 50000, 68875000, 10.00, NULL, '2022_RESTORAN_0225906132022.JPG', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-13 14:51:56', '2022-06-29 15:26:37', NULL);
INSERT INTO `restorans` VALUES (2260, 1, 'EDWARD JAJA', 'P.2.02.0005756.16.01', 'GOLDEN LAMIAN/PT.SUMBER NATURAL INDONESIA', 'JL.RAYA JATIWARINGIN', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 5, 20, 170000, 421175000, 10.00, NULL, '2022_RESTORAN_0226006132022.jpg', 0, 4, '-6.2855636', '106.924067', 18, '2022-06-13 14:56:55', '2022-06-13 14:59:32', NULL);
INSERT INTO `restorans` VALUES (2261, 2, 'BRYAN DJON', 'P.2.02.0005797.16.01', 'DEAR BUTTER', 'JL. JATIWARINGIN NO. 5', 'PONDOKGEDE', 'JATIWARINGIN', '003', '006', 2, 2, 30000, 9180000, 10.00, NULL, '2022_RESTORAN_0226106132022.jpg', 0, 1, '-6.2682404', '106.9238364', 18, '2022-06-13 15:02:48', '2022-06-29 15:27:25', NULL);
INSERT INTO `restorans` VALUES (2262, 3, 'MICHAEL SUTEDJO', 'P.2.02.0005943.11.01', 'MENANTEA AGUS SALIM', 'JL. KH AGUS SALIM BEKASI TIMUR', 'BEKASI TIMUR', 'BEKASIJAYA', '10', '07', 5, 8, 18000, 22995000, 10.00, '0812-878-2643/0812-8512-8002', '2022_RESTORAN_0226206152022.jpg', 0, 1, '-6.225800822630331', '107.01299428939821', 10, '2022-06-15 10:17:34', '2022-06-15 11:35:35', NULL);
INSERT INTO `restorans` VALUES (2263, 3, 'HAIDHAR HIBATULLAH WURJANTO', 'P.2.02.0005870.11.02', 'ES TEH INDONESIA', 'JL. RA KARTINI NO. 35 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '004', '003', 4, 5, 38000, 129200000, 10.00, NULL, '2022_RESTORAN_0226306152022.jpg', 0, 1, '-6.246406279609171', '107.00268387794496', 10, '2022-06-15 10:28:29', '2022-06-15 11:35:57', NULL);
INSERT INTO `restorans` VALUES (2264, 3, 'MAULANA HIDAYAT', 'P.2.02.0005889.11.02', 'BALE KOPI THE RIVERS', 'JL. M. HASIBUAN BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '004', '024', 9, 40, 25000, 24062500, 10.00, '0812-1066-1315', '2022_RESTORAN_0226406152022.jpg', 0, 1, '-6.2291968', '106.971136', 10, '2022-06-15 11:06:49', '2022-06-15 11:36:17', NULL);
INSERT INTO `restorans` VALUES (2265, 3, 'RM. BAKMI & KURSIN', 'P.2.02.0001732.16.04', 'RM. BAKMI & KURSIN', 'JL.JATIWARINGIN RAYA NO.73 RT.003/006 JATI CEMPAKA', 'PONDOKGEDE', 'JATIWARINGIN', '003', '006', 3, 10, 25000, 6475000, 10.00, NULL, NULL, 0, 1, '-6.2855636', '106.924067', 18, '2022-06-17 09:45:25', '2022-06-29 15:27:46', NULL);
INSERT INTO `restorans` VALUES (2266, 2, 'RESTO NUSANTARA', 'P.2.02.0001014.16.04', 'RESTO NUSANTARA', 'JL. RAYA JATIWARINGIN NO.54', 'PONDOKGEDE', 'JATIWARINGIN', NULL, NULL, 6, 20, 260000, 391950000, 10.00, NULL, '2022_RESTORAN_0226606172022.jpg', 0, 1, '-6.2819823', '106.9140044', 18, '2022-06-17 09:55:23', '2022-06-29 15:31:43', NULL);
INSERT INTO `restorans` VALUES (2267, 1, 'ERWIN LESYANA', 'P.2.02.0002546.16.04', 'RICHEESE FACTORY', 'JL.RAYA JATIWARINGIN NO.185', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 6, 20, 262000, 606530000, 10.00, NULL, '2022_RESTORAN_0226706172022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-17 10:05:06', '2022-06-29 15:32:27', NULL);
INSERT INTO `restorans` VALUES (2268, 3, 'PADANG JASO BUNDO', 'P.2.02.0003837.16.04', 'PADANG JASO BUNDO', 'JL.RAYA JATIWARINGIN NO.10 RT.007/05', 'PONDOKGEDE', 'JATICEMPAKA', '007', '005', 2, 10, 17000, 5491000, 10.00, NULL, '2022_RESTORAN_0226806172022.jpg', 0, 1, '-6.2855636', '106.924067', 18, '2022-06-17 10:22:18', '2022-06-29 15:32:43', NULL);
INSERT INTO `restorans` VALUES (2269, 2, 'KIKI CATERING/PT.KIKI PUSPA DEWI', 'P.2.02.0003102.16.04', 'KIKI CATERING/PT.KIKI PUSPA DEWI', 'JL.ELANG MALINDO NO.10', 'PONDOKGEDE', 'JATICEMPAKA', NULL, NULL, 10, 10, 70000, 39725000, 10.00, NULL, NULL, 0, 4, '-6.2855636', '106.924067', 18, '2022-06-17 10:30:32', '2022-06-17 11:03:11', NULL);
INSERT INTO `restorans` VALUES (2270, 2, 'EDWARD TIRTANATA', 'P.2.02.0005918.11.04', 'KOPI KENANGAN NUSANTARA', 'JL. NUSANTARA RAYA BEKASI TIMUR', 'BEKASI TIMUR', 'ARENJAYA', '001', '010', 3, 8, 45000, 175500000, 10.00, '0817-6562-128', '2022_RESTORAN_0227006172022.jpg', 0, 1, '-6.243633335676945', '107.03816413879395', 10, '2022-06-17 10:36:22', '2022-06-23 10:45:36', NULL);
INSERT INTO `restorans` VALUES (2271, 3, 'KALIBRASI COFFE & EATERY', 'P.2.02.0005093.16.02', 'KALIBRASI COFFE & EATERY', 'JL. KEMANG SARI NO. 65', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 4, 10, 30000, 7305000, 10.00, NULL, '2022_RESTORAN_0227106172022.jpg', 0, 1, '-6.261211951673076', '106.92149414539023', 18, '2022-06-17 10:41:43', '2022-06-29 15:33:30', NULL);
INSERT INTO `restorans` VALUES (2272, 2, 'EDWARD TIRTANATA', 'P.2.02.0005919.11.02', 'KOPI KENANGAN KARTINI', 'JL. RA KARTINI NO. 6 BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '003', '003', 3, 8, 35000, 104562500, 10.00, '0817-6562-130', '2022_RESTORAN_0227206172022.jpg', 1, 1, '-6.247366141394469', '107.00179338455202', 10, '2022-06-17 10:55:36', '2022-06-23 10:52:08', NULL);
INSERT INTO `restorans` VALUES (2273, 3, 'MERRY CH MARPAUNG', 'P.2.02.0005148.16.02', 'STREET BOBA', 'JL. CAMAN RAYA BLOK. C NO. 100', 'PONDOKGEDE', 'JATIBENING', NULL, NULL, 4, 3, 35000, 34475000, 10.00, NULL, '2022_RESTORAN_0227306172022.jpg', 0, 1, '-6.270767559695409', '106.92218123238058', 18, '2022-06-17 11:14:52', '2022-06-29 15:36:34', NULL);
INSERT INTO `restorans` VALUES (2274, 3, 'MULYANI', 'P.2.02.0005216.16.02', 'BANG BUY COFFEE', 'KOMP. SENTRA KOTA JATIBENING BLOK C. 12', 'PONDOKGEDE', 'JATIBENING BARU', NULL, NULL, 3, 6, 25000, 5537500, 10.00, NULL, '2022_RESTORAN_0227406172022.jpg', 0, 1, '-6.2819801', '106.9139907', 18, '2022-06-17 11:28:02', '2022-06-29 15:40:24', NULL);
INSERT INTO `restorans` VALUES (2275, 3, 'DARMAWAN', 'P.2.02.0005839.11.02', 'HAPPY SEA FOOD', 'JL. CHAIRIL ANWAR BLU PLAZA BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '006', '009', 5, 20, 20000, 25550000, 10.00, '0813-8750-0063', '2022_RESTORAN_0227506172022.jpg', 0, 1, '-6.2567726936923105', '107.00739383697511', 10, '2022-06-17 11:29:35', '2022-06-23 11:11:12', NULL);
INSERT INTO `restorans` VALUES (2276, 3, 'LEONARDUS HERMAWAN ANDROMEDA', 'P.2.02.0005553.11.04', 'BURGER BANGOR', 'JL. NUSANTARA RAYA NO. A1/3 BEKASI TIMUR', 'BEKASI TIMUR', 'ARENJAYA', '007', '014', 5, 20, 30000, 38325000, 10.00, '0812-1350-8329', '2022_RESTORAN_0227606172022.jpg', 0, 4, '-6.24367599646405', '107.02940404415132', 10, '2022-06-17 14:46:54', '2022-06-17 14:46:54', NULL);
INSERT INTO `restorans` VALUES (2277, 2, 'PT TRANS RASA ORIENTAL', 'P.2.02.0004257.11.02', 'TASTY KITCHEN', 'JL. IR. H. JUANDA TRANSPARK BEKASI TIMUR', 'BEKASI TIMUR', 'MARGAHAYU', '003', '011', 5, 50, 50000, 96250000, 10.00, '0888-0907-9466', '2022_RESTORAN_0227706172022.jpg', 1, 1, '-6.248667284559598', '107.01717853546144', 10, '2022-06-17 15:14:18', '2022-06-23 11:17:11', NULL);
INSERT INTO `restorans` VALUES (2278, 2, 'FILBERT', 'P.2.02.0005971.15.01', 'AYAM CRISBAR/PT.REKA CIPTA SELERA', 'JL WIBAWA MUKTI II NO KAVLING 01', 'JATIASIH', 'JATIASIH', '002', '007', 5, 10, 25000, 18375000, 10.00, '082121214145', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 11:04:10', '2022-06-30 10:26:28', NULL);
INSERT INTO `restorans` VALUES (2279, 2, 'HENRI AL AZWAR', 'P2.02.0005978.15.02', 'KYAN CAFE', 'JL PALEM RAYA NO 9', 'BANTARGEBANG', 'BANTARGEBANG', '005', '007', 4, 8, 40000, 43500000, 10.00, '089608750598', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 12:28:16', '2022-06-30 10:24:26', NULL);
INSERT INTO `restorans` VALUES (2280, 2, 'LENDY SUSANTO', 'P.2.02.0005968.15.02', 'DAPUR CEKOLAT PICK UP JATIASIH/PT.SUMBER CEMERLANG MANDIRI', 'JL RAYA JATIMEKAR  NO 23', 'JATIASIH', 'JATIASIH', '001', '012', 4, 4, 100000, 39500000, 10.00, '081286489569', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 12:57:48', '2022-06-24 09:07:44', NULL);
INSERT INTO `restorans` VALUES (2281, 2, 'SATRIO ADIWIJOYO', 'P2.02.0005954.15.06', 'SRUMA COFFEE AND EATERY', 'JL WIBAWA MUKTI II BLOK B8 NO  08', 'JATIASIH', 'JATISARI', '004', '004', 8, 40, 25000, 14437500, 10.00, '08118842606', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 13:05:30', '2022-06-30 10:22:17', NULL);
INSERT INTO `restorans` VALUES (2282, 1, 'DAFRISAL', 'P.2.02.0005941.15.01', 'CHATIME', 'JL RAYA JATIASIH NO 14', 'JATIASIH', 'JATIASIH', '005', '010', 4, 12, 35000, 47600000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-20 13:21:50', '2022-06-24 09:05:59', NULL);
INSERT INTO `restorans` VALUES (2283, 1, 'FITRI USMAN', 'P2.02.0005932.15.01', 'TENTANG KOPI JATIASIH', 'JL RAYA SAKURA REGENCY', 'JATIASIH', 'JATIASIH', '007', '005', 2, 8, 17000, 3782500, 10.00, '081287290545', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 13:35:56', '2022-06-27 09:28:04', NULL);
INSERT INTO `restorans` VALUES (2284, 1, 'ANDREAS RESHA JUNIANTO', 'P2.02.0005931.15.01', 'OUTRET HANGRY JATIASIH/PT MODULAR KULINER INDONESIA', 'JL WIBAWA MUKTI', 'JATIASIH', 'JATIASIH', '001', '007', 4, 8, 250000, 327500000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-20 13:46:42', '2022-06-27 09:46:13', NULL);
INSERT INTO `restorans` VALUES (2285, 2, 'ERIKA PEBRIANA', 'P2.02.0005888.15.03', 'MEMBARA COFFE AND GRILL/PT JIWA MEMBARA PEMUDA', 'JL RATNA NO 79', 'JATIASIH', 'JATIKRAMAT', '001', '001', 10, 30, 50000, 99500000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-20 13:53:27', '2022-06-30 10:18:53', NULL);
INSERT INTO `restorans` VALUES (2286, 2, 'FAIZ MUTTAQIN  AMRULLOH', 'P2.02.0005856.15.01', 'MENANTEA', 'JL RAYA JATIASIH NO 39 A', 'JATIASIH', 'JATIASIH', '003', '004', 4, 6, 20000, 6300000, 10.00, '081380337235', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 14:03:53', '2022-06-23 11:12:55', NULL);
INSERT INTO `restorans` VALUES (2287, 2, 'DENNI SATRIA', 'P2.02.0005820.15.01', 'ORIBEAN COFFEE', 'JL PARPOSTEL RUKO SAKURA REGENCY KM 8  NO 11', 'JATIASIH', 'JATIASIH', '001', '017', 2, 18, 20000, 6250000, 10.00, '081513621137', NULL, 0, 4, NULL, NULL, 15, '2022-06-20 14:09:07', '2022-06-23 11:10:55', NULL);
INSERT INTO `restorans` VALUES (2288, 2, 'HENDRO PRASETYO', 'P2.02.0005817.15.02', 'ATAF CAFE', 'JL RAYA JATIMEKAR  NO 29', 'JATIASIH', 'JATIMEKAR', '003', '012', 5, 20, 15000, 5550000, 10.00, '081285470428', NULL, 0, 4, NULL, NULL, 15, '2022-06-22 07:59:35', '2022-06-30 14:15:57', NULL);
INSERT INTO `restorans` VALUES (2289, 3, 'HADI KURNIAWAN', 'P2.02.0005790.15.01', 'MIE TUJU', 'RUKO JATIASIH NO 7 JL RAYA PEKAYON', 'JATIASIH', 'JATIASIH', '006', '004', 2, 12, 15000, 4852500, 10.00, '081281087767', NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:05:06', '2022-06-30 14:11:27', NULL);
INSERT INTO `restorans` VALUES (2290, 2, 'SAIDINUR', 'P2.02.0005755.15.01', 'WING STOP / PT WIRYAMANTA SADINA', 'JL RAYA JATIASIH NO  80', 'JATIASIH', 'JATIASIH', '008', '011', 5, 10, 60000, 46200000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:11:26', '2022-06-22 08:11:26', NULL);
INSERT INTO `restorans` VALUES (2291, 2, 'REIGITA ISMI APRILIANA', 'P2.02.0005741.15.01', 'FLASH COFFEE/PT SEMBILAN PULUH ENAM DERAJAT', 'JL WIBAWA MUKTI NO 75', 'JATIASIH', 'JATIASIH', '003', '005', 2, 4, 60000, 82290000, 10.00, '081119052487', NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:15:09', '2022-06-30 14:06:52', NULL);
INSERT INTO `restorans` VALUES (2292, 1, 'YOHANA CANDRAIRAWAN', 'P2.02.0005724.15.01', 'BURGER BANGOR', 'WIBAWA MUKTI II NO 45', 'JATIASIH', 'JATIASIH', '003', '005', 3, 16, 20000, 16300000, 10.00, '085771156855', NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:22:59', '2022-06-30 13:59:58', NULL);
INSERT INTO `restorans` VALUES (2293, 1, 'BEBEK KALEYO / PT PAYUNG TEDUH BERDUA', 'P.2.02.0005667.15.01', 'BEBEK KALEYO', 'JL RAYA JATIASIH', 'JATIASIH', 'JATIASIH', '004', '010', 15, 40, 125000, 441875000, 10.00, '081196012639', NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:26:06', '2022-06-30 13:56:55', NULL);
INSERT INTO `restorans` VALUES (2294, 2, 'BUDI RIYANTO', 'P2.02.0005786.15.05', 'GEPREK BENSU JATIASIH', 'JL PARPOSTEL KAV.28 NO 1', 'JATIASIH', 'JATILUHUR', '003', '007', 4, 10, 20000, 14700000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:35:21', '2022-06-30 13:03:28', NULL);
INSERT INTO `restorans` VALUES (2295, 2, 'STEVEN', 'P2.02.0005775.1.01', 'XIBOBA / PT BOGA DAHGA SEKAWAN', 'JL RAYA KOMSEN JATIASIH', 'JATIASIH', 'JATIASIH', '004', '004', 8, 6, 15000, 3997500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-22 08:40:49', '2022-06-30 13:30:27', NULL);
INSERT INTO `restorans` VALUES (2296, 1, 'DJAP JANTI KUSUMA JAYA', 'P.2.02.0003286.16.03', 'DOM PIZZA / PT.DOM PIZZA INDONESIA', 'JL.JATIMAKMUR RESIDENCE BLOK.A NO.14', 'PONDOKGEDE', 'JATIMAKMUR', NULL, NULL, 6, 6, 143000, 386815000, 10.00, NULL, '2022_RESTORAN_0229606242022.jpg', 0, 1, '-6.2819819', '106.9139984', 18, '2022-06-24 10:42:29', '2022-06-29 15:40:56', NULL);
INSERT INTO `restorans` VALUES (2297, 3, 'AGUS PRAMONO', 'P.2.02.0002543.16.03', 'MIE AYAM ALEX', 'JL.RAYA JATIMAKMUR', 'PONDOKGEDE', 'JATIMAKMUR', NULL, NULL, 4, 10, 13000, 1228500, 10.00, NULL, '2022_RESTORAN_0229706242022.jpg', 0, 1, '-6.268037403832118', '106.92355540636129', 18, '2022-06-24 11:21:55', '2022-06-29 15:41:21', NULL);
INSERT INTO `restorans` VALUES (2298, 3, 'ARLON SITINJAK', 'P.2.02.0006038.21.02', 'WARUNG NASI TIMBEL DADAKAN', 'JL. MUSTIKASARI RAYA NO. 555 RT. 001 RW. 003', 'MUSTIKAJAYA', 'MUSTIKASARI', '001', '003', 4, 10, 15000, 922500, 10.00, NULL, NULL, 0, 4, NULL, NULL, 17, '2022-06-30 08:19:02', '2022-06-30 08:20:08', NULL);
INSERT INTO `restorans` VALUES (2299, 2, 'DAILIO SPECIALTY COFFEE', 'P.2.02.0003910.16.03', 'DAILIO SPECIALTY COFFEE', 'JL.RAYA JATIMAKMUR', 'PONDOKGEDE', 'JATIMAKMUR', NULL, NULL, 4, 8, 30000, 30150000, 10.00, NULL, '2022_RESTORAN_0229906302022.jpg', 0, 4, '-6.265307233679866', '106.92355540636129', 18, '2022-06-30 09:23:16', '2022-06-30 09:24:21', NULL);
INSERT INTO `restorans` VALUES (2300, 2, 'MUHAMAD ABDUL AZIZ', 'P.2.02.0003880.16.03', 'SABANAKU RESTO', 'JL.RAYA JATIMAKMUR NO.45', 'PONDOKGEDE', 'JATIMAKMUR', NULL, NULL, 5, 5, 50000, 60500000, 10.00, NULL, '2022_RESTORAN_0230006302022.jpg', 0, 4, '-6.261894500905023', '106.92355540636129', 18, '2022-06-30 09:30:28', '2022-06-30 09:31:28', NULL);
INSERT INTO `restorans` VALUES (2301, 3, 'ITA EKAWATI', 'P.2.02.0003982.16.03', 'AYAM GEPUK PAK GEMBUS', 'JL.KELURAHAN JATIMAKMUR BLOK.E NO.12', 'PONDOKGEDE', 'JATIMAKMUR', NULL, NULL, 3, 10, 15000, 2437500, 10.00, NULL, '2022_RESTORAN_0230106302022.jpg', 0, 4, '-6.2819715', '106.9140021', 18, '2022-06-30 09:54:57', '2022-06-30 09:59:25', NULL);
INSERT INTO `restorans` VALUES (2302, 2, 'MUHAMMAD MULKY THALIB', 'P.2.02.0004339.16.03', 'UP NORMAL / PT.PROPERTI PRIORITAS UTAMA', 'JL.RAYA JATIMAKMUR NO.8', 'PONDOKGEDE', 'JATIMAKMUR', NULL, NULL, 5, 10, 31000, 43090000, 10.00, NULL, '2022_RESTORAN_0230206302022.jpg', 0, 4, '-6.2819715', '106.9140021', 18, '2022-06-30 10:06:40', '2022-06-30 10:13:00', NULL);
INSERT INTO `restorans` VALUES (2303, 2, 'ANDANU PRASETYO', 'P2.02.0005913.15.01', 'TOKO KOPI TUKU/PT KARYA TETANGGA TUKU', 'JL WIBAWA MUKTI II NO 75', 'JATIASIH', 'JATIASIH', '003', '005', 4, 12, 65000, 415675000, 10.00, '08170731591', NULL, 0, 4, NULL, NULL, 15, '2022-06-30 12:11:21', '2022-06-30 12:44:15', NULL);
INSERT INTO `restorans` VALUES (2304, 3, 'YUMMY KITCHEN 39 JATIMEKAR', 'P2.02.0005670.05.02', 'YUMMY KITCHEN 39 JATIMEKAR', 'JL RAYA JATIMEKAR', 'JATIASIH', 'JATIASIH', '004', '017', 4, 0, 55000, 66825000, 10.00, NULL, NULL, 0, 4, NULL, NULL, 15, '2022-06-30 12:51:38', '2022-06-30 12:57:12', NULL);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin', 'success');
INSERT INTO `roles` VALUES (2, 'Surveyor', 'warning');
INSERT INTO `roles` VALUES (3, 'Pimpinan', 'info');

-- ----------------------------
-- Table structure for rusun_jenis_kamars
-- ----------------------------
DROP TABLE IF EXISTS `rusun_jenis_kamars`;
CREATE TABLE `rusun_jenis_kamars`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rusun_id` bigint NULL DEFAULT NULL,
  `rusun_jenis_kamar_deskripsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_jenis_kamar_tarif` double NULL DEFAULT 0,
  `rusun_jenis_kamar_jumlah` int NULL DEFAULT 0,
  `rusun_jenis_kamar_hunian_avg` int NULL DEFAULT 0,
  `rusun_jenis_kamar_potensi_pajak` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rusun_jenis_kamars
-- ----------------------------
INSERT INTO `rusun_jenis_kamars` VALUES (1, 1, 'Lantai 1', 200000, 24, 24, 5760000);
INSERT INTO `rusun_jenis_kamars` VALUES (2, 1, 'Lantai 2', 180000, 24, 24, 5184000);
INSERT INTO `rusun_jenis_kamars` VALUES (3, 1, 'Lantai 3', 165000, 24, 24, 4752000);
INSERT INTO `rusun_jenis_kamars` VALUES (4, 1, 'Lantai 4', 150000, 24, 24, 4320000);
INSERT INTO `rusun_jenis_kamars` VALUES (5, 2, 'LANTAI 1', 200000, 24, 24, 5760000);
INSERT INTO `rusun_jenis_kamars` VALUES (6, 2, 'LANTAI 2', 180000, 24, 24, 5184000);
INSERT INTO `rusun_jenis_kamars` VALUES (7, 2, 'LANTAI 3', 165000, 24, 24, 4752000);
INSERT INTO `rusun_jenis_kamars` VALUES (8, 2, 'LANTAI 4', 150000, 24, 24, 4320000);
INSERT INTO `rusun_jenis_kamars` VALUES (9, 3, 'LANTAI 1', 200000, 24, 24, 57600000);
INSERT INTO `rusun_jenis_kamars` VALUES (10, 3, 'LANTAI 2', 180000, 24, 24, 51840000);
INSERT INTO `rusun_jenis_kamars` VALUES (11, 3, 'LANTAI 3', 165000, 24, 24, 47520000);
INSERT INTO `rusun_jenis_kamars` VALUES (12, 3, 'LANTAI 4', 150000, 24, 24, 43200000);
INSERT INTO `rusun_jenis_kamars` VALUES (13, 4, 'LANTAI 1', 250000, 24, 24, 72000000);
INSERT INTO `rusun_jenis_kamars` VALUES (14, 4, 'LANTAI 2', 225000, 24, 19, 51300000);
INSERT INTO `rusun_jenis_kamars` VALUES (15, 4, 'LANTAI 3', 200000, 24, 19, 45600000);
INSERT INTO `rusun_jenis_kamars` VALUES (16, 4, 'LANTAI 4', 175000, 24, 19, 39900000);

-- ----------------------------
-- Table structure for rusuns
-- ----------------------------
DROP TABLE IF EXISTS `rusuns`;
CREATE TABLE `rusuns`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rusun_pemilik` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_npwpd` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_alamat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `rusun_kecamatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_kelurahan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_rt` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_rw` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_jumlah_pegawai` int NULL DEFAULT 0,
  `rusun_potensi_pajak` double NULL DEFAULT 0,
  `rusun_telepon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_foto` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `status_aktif_id` int NULL DEFAULT 1,
  `rusun_latitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rusun_longitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rusuns
-- ----------------------------
INSERT INTO `rusuns` VALUES (1, 'PEMKOT KOTA BEKASI', '12763817263', 'RUSUNAWA 2 KOTA BEKASI', 'JL. BARU UNDERPASS SAMOING PERUM EMERAL', 'BEKASI TIMUR', 'DURENJAYA', NULL, NULL, 200, 20016000, '02182692853', '2021_RUSUN_0109252021.jpg', 1, '-6.234589170386484', '107.03524589538576', 1, '2021-09-25 07:16:05', '2021-10-20 10:23:25', '2021-10-20 10:23:25');
INSERT INTO `rusuns` VALUES (2, 'PEMKOT KOTA BEKASI', '333', 'RUSUNAWA 1 KOTA BEKASI', 'JL. BARU UNDERPASS SAMOING PERUM EMERAL', 'BEKASI TIMUR', NULL, NULL, NULL, 100, 20016000, '2182692853', NULL, 1, NULL, NULL, 1, '2021-09-26 18:00:27', '2021-10-20 10:23:38', '2021-10-20 10:23:38');
INSERT INTO `rusuns` VALUES (3, 'PEMKOT KOTA BEKASI', '12345', 'RUSUNAWA KOTA BEKASI', 'JL. BARU UNDERPASS SAMOING PERUM EMERAL', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 16, 200160000, '02182692853', 'http://drive.google.com/uc?id=1vLbATW0G8Mcm0gQdukODIu-JuiVFJnRG', 1, '-6.23604', '107.01532', 1, '2021-10-21 13:50:01', '2021-10-22 09:25:06', NULL);
INSERT INTO `rusuns` VALUES (4, 'PEMKOT KOTA BEKASI', '12346', 'RUSUNAWA KOTA BEKASI / TOWER 2', 'JL. BARU UNDERPASS SAMPING PERUM EMERAL', 'BEKASI TIMUR', 'BEKASI JAYA', NULL, NULL, 16, 208800000, '02182692853', 'http://drive.google.com/uc?id=1e0K_npKox-_T0zAHLlz_2XvDIBXrqjHZ', 1, '-6.23605', '107.01537', 1, '2021-10-21 13:50:01', '2021-10-22 09:25:06', NULL);

-- ----------------------------
-- Table structure for status_aktifs
-- ----------------------------
DROP TABLE IF EXISTS `status_aktifs`;
CREATE TABLE `status_aktifs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `status_aktif_deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of status_aktifs
-- ----------------------------
INSERT INTO `status_aktifs` VALUES (1, 'Aktif');
INSERT INTO `status_aktifs` VALUES (2, 'Tidak Aktif (Tutup Sementara)');
INSERT INTO `status_aktifs` VALUES (3, 'Tidak Aktif (Tutup Permanen)');
INSERT INTO `status_aktifs` VALUES (4, 'Belum Diverifikasi');

-- ----------------------------
-- Table structure for user_accesses
-- ----------------------------
DROP TABLE IF EXISTS `user_accesses`;
CREATE TABLE `user_accesses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `access_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_accesses
-- ----------------------------
INSERT INTO `user_accesses` VALUES (1, 2, 1);
INSERT INTO `user_accesses` VALUES (2, 2, 2);
INSERT INTO `user_accesses` VALUES (6, 4, 3);
INSERT INTO `user_accesses` VALUES (7, 4, 4);
INSERT INTO `user_accesses` VALUES (9, 2, 3);
INSERT INTO `user_accesses` VALUES (26, 8, 1);
INSERT INTO `user_accesses` VALUES (27, 8, 2);
INSERT INTO `user_accesses` VALUES (32, 9, 1);
INSERT INTO `user_accesses` VALUES (33, 9, 2);
INSERT INTO `user_accesses` VALUES (34, 9, 3);
INSERT INTO `user_accesses` VALUES (35, 9, 4);
INSERT INTO `user_accesses` VALUES (36, 10, 1);
INSERT INTO `user_accesses` VALUES (37, 10, 2);
INSERT INTO `user_accesses` VALUES (38, 10, 3);
INSERT INTO `user_accesses` VALUES (39, 10, 4);
INSERT INTO `user_accesses` VALUES (40, 11, 1);
INSERT INTO `user_accesses` VALUES (41, 11, 2);
INSERT INTO `user_accesses` VALUES (42, 11, 3);
INSERT INTO `user_accesses` VALUES (43, 11, 4);
INSERT INTO `user_accesses` VALUES (44, 12, 1);
INSERT INTO `user_accesses` VALUES (45, 12, 2);
INSERT INTO `user_accesses` VALUES (46, 12, 3);
INSERT INTO `user_accesses` VALUES (47, 12, 4);
INSERT INTO `user_accesses` VALUES (48, 13, 1);
INSERT INTO `user_accesses` VALUES (49, 13, 2);
INSERT INTO `user_accesses` VALUES (50, 13, 3);
INSERT INTO `user_accesses` VALUES (51, 13, 4);
INSERT INTO `user_accesses` VALUES (52, 15, 1);
INSERT INTO `user_accesses` VALUES (53, 15, 2);
INSERT INTO `user_accesses` VALUES (54, 15, 3);
INSERT INTO `user_accesses` VALUES (55, 15, 4);
INSERT INTO `user_accesses` VALUES (56, 16, 1);
INSERT INTO `user_accesses` VALUES (57, 16, 2);
INSERT INTO `user_accesses` VALUES (58, 16, 3);
INSERT INTO `user_accesses` VALUES (59, 16, 4);
INSERT INTO `user_accesses` VALUES (60, 17, 1);
INSERT INTO `user_accesses` VALUES (61, 17, 2);
INSERT INTO `user_accesses` VALUES (62, 17, 3);
INSERT INTO `user_accesses` VALUES (63, 17, 4);
INSERT INTO `user_accesses` VALUES (64, 18, 1);
INSERT INTO `user_accesses` VALUES (65, 18, 2);
INSERT INTO `user_accesses` VALUES (66, 18, 3);
INSERT INTO `user_accesses` VALUES (67, 18, 4);
INSERT INTO `user_accesses` VALUES (68, 20, 1);
INSERT INTO `user_accesses` VALUES (69, 20, 2);
INSERT INTO `user_accesses` VALUES (70, 20, 3);
INSERT INTO `user_accesses` VALUES (71, 20, 4);
INSERT INTO `user_accesses` VALUES (72, 19, 1);
INSERT INTO `user_accesses` VALUES (73, 19, 2);
INSERT INTO `user_accesses` VALUES (74, 19, 3);
INSERT INTO `user_accesses` VALUES (75, 19, 4);
INSERT INTO `user_accesses` VALUES (76, 14, 1);
INSERT INTO `user_accesses` VALUES (77, 14, 2);
INSERT INTO `user_accesses` VALUES (78, 14, 3);
INSERT INTO `user_accesses` VALUES (79, 14, 4);
INSERT INTO `user_accesses` VALUES (80, 11, 1);
INSERT INTO `user_accesses` VALUES (81, 11, 2);
INSERT INTO `user_accesses` VALUES (82, 11, 3);
INSERT INTO `user_accesses` VALUES (83, 11, 4);
INSERT INTO `user_accesses` VALUES (84, 11, 10);

-- ----------------------------
-- Table structure for user_logs
-- ----------------------------
DROP TABLE IF EXISTS `user_logs`;
CREATE TABLE `user_logs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1247 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_logs
-- ----------------------------
INSERT INTO `user_logs` VALUES (1, 1, '2021-12-14 15:16:20', '2021-12-14 15:16:20');
INSERT INTO `user_logs` VALUES (2, 1, '2021-12-14 22:33:12', '2021-12-14 22:33:12');
INSERT INTO `user_logs` VALUES (3, 1, '2021-12-15 08:51:21', '2021-12-15 08:51:21');
INSERT INTO `user_logs` VALUES (4, 1, '2021-12-15 09:09:11', '2021-12-15 09:09:11');
INSERT INTO `user_logs` VALUES (5, 1, '2021-12-15 09:13:51', '2021-12-15 09:13:51');
INSERT INTO `user_logs` VALUES (6, 1, '2021-12-15 09:35:05', '2021-12-15 09:35:05');
INSERT INTO `user_logs` VALUES (7, 1, '2021-12-15 10:00:36', '2021-12-15 10:00:36');
INSERT INTO `user_logs` VALUES (8, 1, '2021-12-15 10:03:19', '2021-12-15 10:03:19');
INSERT INTO `user_logs` VALUES (9, 1, '2021-12-15 10:08:44', '2021-12-15 10:08:44');
INSERT INTO `user_logs` VALUES (10, 1, '2021-12-15 11:07:36', '2021-12-15 11:07:36');
INSERT INTO `user_logs` VALUES (11, 19, '2021-12-15 11:16:13', '2021-12-15 11:16:13');
INSERT INTO `user_logs` VALUES (12, 12, '2021-12-15 11:16:51', '2021-12-15 11:16:51');
INSERT INTO `user_logs` VALUES (13, 20, '2021-12-15 11:17:31', '2021-12-15 11:17:31');
INSERT INTO `user_logs` VALUES (14, 1, '2021-12-15 11:20:29', '2021-12-15 11:20:29');
INSERT INTO `user_logs` VALUES (15, 1, '2021-12-15 11:36:54', '2021-12-15 11:36:54');
INSERT INTO `user_logs` VALUES (16, 17, '2021-12-15 12:53:48', '2021-12-15 12:53:48');
INSERT INTO `user_logs` VALUES (17, 13, '2021-12-15 12:56:05', '2021-12-15 12:56:05');
INSERT INTO `user_logs` VALUES (18, 17, '2021-12-15 12:56:44', '2021-12-15 12:56:44');
INSERT INTO `user_logs` VALUES (19, 17, '2021-12-15 13:13:48', '2021-12-15 13:13:48');
INSERT INTO `user_logs` VALUES (20, 12, '2021-12-15 13:17:57', '2021-12-15 13:17:57');
INSERT INTO `user_logs` VALUES (21, 1, '2021-12-15 13:45:16', '2021-12-15 13:45:16');
INSERT INTO `user_logs` VALUES (22, 12, '2021-12-15 13:45:29', '2021-12-15 13:45:29');
INSERT INTO `user_logs` VALUES (23, 1, '2021-12-15 13:49:19', '2021-12-15 13:49:19');
INSERT INTO `user_logs` VALUES (24, 19, '2021-12-15 15:06:35', '2021-12-15 15:06:35');
INSERT INTO `user_logs` VALUES (25, 1, '2021-12-15 15:20:32', '2021-12-15 15:20:32');
INSERT INTO `user_logs` VALUES (26, 1, '2021-12-15 15:51:41', '2021-12-15 15:51:41');
INSERT INTO `user_logs` VALUES (27, 1, '2021-12-16 08:51:38', '2021-12-16 08:51:38');
INSERT INTO `user_logs` VALUES (28, 15, '2021-12-16 10:05:32', '2021-12-16 10:05:32');
INSERT INTO `user_logs` VALUES (29, 9, '2021-12-16 10:27:02', '2021-12-16 10:27:02');
INSERT INTO `user_logs` VALUES (30, 1, '2021-12-16 10:29:36', '2021-12-16 10:29:36');
INSERT INTO `user_logs` VALUES (31, 12, '2021-12-16 11:13:09', '2021-12-16 11:13:09');
INSERT INTO `user_logs` VALUES (32, 1, '2021-12-16 11:21:29', '2021-12-16 11:21:29');
INSERT INTO `user_logs` VALUES (33, 19, '2021-12-16 13:33:01', '2021-12-16 13:33:01');
INSERT INTO `user_logs` VALUES (34, 1, '2021-12-16 14:05:33', '2021-12-16 14:05:33');
INSERT INTO `user_logs` VALUES (35, 1, '2021-12-16 14:53:40', '2021-12-16 14:53:40');
INSERT INTO `user_logs` VALUES (36, 9, '2021-12-16 14:56:31', '2021-12-16 14:56:31');
INSERT INTO `user_logs` VALUES (37, 15, '2021-12-16 14:57:11', '2021-12-16 14:57:11');
INSERT INTO `user_logs` VALUES (38, 1, '2021-12-16 14:58:58', '2021-12-16 14:58:58');
INSERT INTO `user_logs` VALUES (39, 1, '2021-12-16 17:26:12', '2021-12-16 17:26:12');
INSERT INTO `user_logs` VALUES (40, 1, '2021-12-17 08:32:43', '2021-12-17 08:32:43');
INSERT INTO `user_logs` VALUES (41, 19, '2021-12-17 09:05:08', '2021-12-17 09:05:08');
INSERT INTO `user_logs` VALUES (42, 1, '2021-12-17 09:35:28', '2021-12-17 09:35:28');
INSERT INTO `user_logs` VALUES (43, 12, '2021-12-17 10:04:34', '2021-12-17 10:04:34');
INSERT INTO `user_logs` VALUES (44, 1, '2021-12-17 13:17:32', '2021-12-17 13:17:32');
INSERT INTO `user_logs` VALUES (45, 19, '2021-12-20 13:53:47', '2021-12-20 13:53:47');
INSERT INTO `user_logs` VALUES (46, 1, '2021-12-20 14:40:48', '2021-12-20 14:40:48');
INSERT INTO `user_logs` VALUES (47, 1, '2021-12-20 23:38:15', '2021-12-20 23:38:15');
INSERT INTO `user_logs` VALUES (48, 2, '2021-12-20 23:41:51', '2021-12-20 23:41:51');
INSERT INTO `user_logs` VALUES (49, 2, '2021-12-20 23:42:56', '2021-12-20 23:42:56');
INSERT INTO `user_logs` VALUES (50, 1, '2021-12-20 23:43:40', '2021-12-20 23:43:40');
INSERT INTO `user_logs` VALUES (51, 1, '2021-12-21 07:07:37', '2021-12-21 07:07:37');
INSERT INTO `user_logs` VALUES (52, 10, '2021-12-21 10:46:20', '2021-12-21 10:46:20');
INSERT INTO `user_logs` VALUES (53, 1, '2021-12-21 11:36:16', '2021-12-21 11:36:16');
INSERT INTO `user_logs` VALUES (54, 10, '2021-12-21 11:39:32', '2021-12-21 11:39:32');
INSERT INTO `user_logs` VALUES (55, 10, '2021-12-21 11:42:57', '2021-12-21 11:42:57');
INSERT INTO `user_logs` VALUES (56, 1, '2021-12-21 11:43:27', '2021-12-21 11:43:27');
INSERT INTO `user_logs` VALUES (57, 10, '2021-12-21 11:47:36', '2021-12-21 11:47:36');
INSERT INTO `user_logs` VALUES (58, 10, '2021-12-21 11:47:57', '2021-12-21 11:47:57');
INSERT INTO `user_logs` VALUES (59, 10, '2021-12-21 11:51:32', '2021-12-21 11:51:32');
INSERT INTO `user_logs` VALUES (60, 10, '2021-12-21 11:52:11', '2021-12-21 11:52:11');
INSERT INTO `user_logs` VALUES (61, 10, '2021-12-21 12:07:48', '2021-12-21 12:07:48');
INSERT INTO `user_logs` VALUES (62, 10, '2021-12-21 12:10:20', '2021-12-21 12:10:20');
INSERT INTO `user_logs` VALUES (63, 10, '2021-12-21 14:42:13', '2021-12-21 14:42:13');
INSERT INTO `user_logs` VALUES (64, 1, '2021-12-21 14:49:51', '2021-12-21 14:49:51');
INSERT INTO `user_logs` VALUES (65, 1, '2021-12-21 14:59:07', '2021-12-21 14:59:07');
INSERT INTO `user_logs` VALUES (66, 1, '2021-12-21 15:08:07', '2021-12-21 15:08:07');
INSERT INTO `user_logs` VALUES (67, 1, '2021-12-21 15:08:39', '2021-12-21 15:08:39');
INSERT INTO `user_logs` VALUES (68, 1, '2021-12-21 15:09:57', '2021-12-21 15:09:57');
INSERT INTO `user_logs` VALUES (69, 10, '2021-12-21 15:12:10', '2021-12-21 15:12:10');
INSERT INTO `user_logs` VALUES (70, 1, '2021-12-21 15:19:53', '2021-12-21 15:19:53');
INSERT INTO `user_logs` VALUES (71, 1, '2021-12-21 15:28:26', '2021-12-21 15:28:26');
INSERT INTO `user_logs` VALUES (72, 15, '2021-12-22 09:15:10', '2021-12-22 09:15:10');
INSERT INTO `user_logs` VALUES (73, 10, '2021-12-22 10:55:47', '2021-12-22 10:55:47');
INSERT INTO `user_logs` VALUES (74, 1, '2021-12-22 11:06:37', '2021-12-22 11:06:37');
INSERT INTO `user_logs` VALUES (75, 1, '2021-12-22 11:13:52', '2021-12-22 11:13:52');
INSERT INTO `user_logs` VALUES (76, 15, '2021-12-22 11:18:06', '2021-12-22 11:18:06');
INSERT INTO `user_logs` VALUES (77, 1, '2021-12-22 11:35:55', '2021-12-22 11:35:55');
INSERT INTO `user_logs` VALUES (78, 15, '2021-12-22 13:56:10', '2021-12-22 13:56:10');
INSERT INTO `user_logs` VALUES (79, 1, '2021-12-22 14:05:18', '2021-12-22 14:05:18');
INSERT INTO `user_logs` VALUES (80, 10, '2021-12-22 14:44:50', '2021-12-22 14:44:50');
INSERT INTO `user_logs` VALUES (81, 10, '2021-12-22 14:49:06', '2021-12-22 14:49:06');
INSERT INTO `user_logs` VALUES (82, 19, '2021-12-22 15:04:14', '2021-12-22 15:04:14');
INSERT INTO `user_logs` VALUES (83, 15, '2021-12-23 08:29:03', '2021-12-23 08:29:03');
INSERT INTO `user_logs` VALUES (84, 1, '2021-12-23 09:10:09', '2021-12-23 09:10:09');
INSERT INTO `user_logs` VALUES (85, 10, '2021-12-23 09:17:12', '2021-12-23 09:17:12');
INSERT INTO `user_logs` VALUES (86, 19, '2021-12-23 09:26:13', '2021-12-23 09:26:13');
INSERT INTO `user_logs` VALUES (87, 10, '2021-12-23 10:48:12', '2021-12-23 10:48:12');
INSERT INTO `user_logs` VALUES (88, 1, '2021-12-23 10:49:03', '2021-12-23 10:49:03');
INSERT INTO `user_logs` VALUES (89, 1, '2021-12-23 10:51:50', '2021-12-23 10:51:50');
INSERT INTO `user_logs` VALUES (90, 10, '2021-12-23 10:52:37', '2021-12-23 10:52:37');
INSERT INTO `user_logs` VALUES (91, 1, '2021-12-23 10:56:01', '2021-12-23 10:56:01');
INSERT INTO `user_logs` VALUES (92, 1, '2021-12-23 10:58:58', '2021-12-23 10:58:58');
INSERT INTO `user_logs` VALUES (93, 1, '2021-12-23 11:03:35', '2021-12-23 11:03:35');
INSERT INTO `user_logs` VALUES (94, 10, '2021-12-23 11:10:33', '2021-12-23 11:10:33');
INSERT INTO `user_logs` VALUES (95, 10, '2021-12-23 11:16:31', '2021-12-23 11:16:31');
INSERT INTO `user_logs` VALUES (96, 19, '2021-12-24 08:54:55', '2021-12-24 08:54:55');
INSERT INTO `user_logs` VALUES (97, 1, '2021-12-24 09:01:45', '2021-12-24 09:01:45');
INSERT INTO `user_logs` VALUES (98, 1, '2021-12-24 09:20:36', '2021-12-24 09:20:36');
INSERT INTO `user_logs` VALUES (99, 1, '2021-12-24 09:47:37', '2021-12-24 09:47:37');
INSERT INTO `user_logs` VALUES (100, 1, '2021-12-27 09:25:29', '2021-12-27 09:25:29');
INSERT INTO `user_logs` VALUES (101, 1, '2021-12-27 09:31:29', '2021-12-27 09:31:29');
INSERT INTO `user_logs` VALUES (102, 10, '2021-12-27 09:32:58', '2021-12-27 09:32:58');
INSERT INTO `user_logs` VALUES (103, 1, '2021-12-27 09:42:56', '2021-12-27 09:42:56');
INSERT INTO `user_logs` VALUES (104, 1, '2021-12-27 09:59:24', '2021-12-27 09:59:24');
INSERT INTO `user_logs` VALUES (105, 15, '2021-12-27 09:59:56', '2021-12-27 09:59:56');
INSERT INTO `user_logs` VALUES (106, 10, '2021-12-27 10:10:43', '2021-12-27 10:10:43');
INSERT INTO `user_logs` VALUES (107, 1, '2021-12-27 11:21:33', '2021-12-27 11:21:33');
INSERT INTO `user_logs` VALUES (108, 10, '2021-12-27 14:09:36', '2021-12-27 14:09:36');
INSERT INTO `user_logs` VALUES (109, 10, '2021-12-27 14:16:51', '2021-12-27 14:16:51');
INSERT INTO `user_logs` VALUES (110, 10, '2021-12-27 14:30:23', '2021-12-27 14:30:23');
INSERT INTO `user_logs` VALUES (111, 10, '2021-12-27 14:36:40', '2021-12-27 14:36:40');
INSERT INTO `user_logs` VALUES (112, 10, '2021-12-27 14:38:09', '2021-12-27 14:38:09');
INSERT INTO `user_logs` VALUES (113, 1, '2021-12-27 14:43:59', '2021-12-27 14:43:59');
INSERT INTO `user_logs` VALUES (114, 1, '2021-12-27 15:10:38', '2021-12-27 15:10:38');
INSERT INTO `user_logs` VALUES (115, 1, '2021-12-27 15:24:38', '2021-12-27 15:24:38');
INSERT INTO `user_logs` VALUES (116, 1, '2021-12-28 06:53:23', '2021-12-28 06:53:23');
INSERT INTO `user_logs` VALUES (117, 15, '2021-12-28 08:17:22', '2021-12-28 08:17:22');
INSERT INTO `user_logs` VALUES (118, 1, '2021-12-28 08:39:37', '2021-12-28 08:39:37');
INSERT INTO `user_logs` VALUES (119, 1, '2021-12-28 08:52:38', '2021-12-28 08:52:38');
INSERT INTO `user_logs` VALUES (120, 1, '2021-12-28 09:10:43', '2021-12-28 09:10:43');
INSERT INTO `user_logs` VALUES (121, 15, '2021-12-28 09:19:31', '2021-12-28 09:19:31');
INSERT INTO `user_logs` VALUES (122, 1, '2021-12-28 09:21:34', '2021-12-28 09:21:34');
INSERT INTO `user_logs` VALUES (123, 1, '2021-12-28 09:26:44', '2021-12-28 09:26:44');
INSERT INTO `user_logs` VALUES (124, 15, '2021-12-28 09:28:39', '2021-12-28 09:28:39');
INSERT INTO `user_logs` VALUES (125, 1, '2021-12-28 09:29:49', '2021-12-28 09:29:49');
INSERT INTO `user_logs` VALUES (126, 1, '2021-12-28 09:32:15', '2021-12-28 09:32:15');
INSERT INTO `user_logs` VALUES (127, 18, '2021-12-28 09:40:42', '2021-12-28 09:40:42');
INSERT INTO `user_logs` VALUES (128, 1, '2021-12-28 09:45:44', '2021-12-28 09:45:44');
INSERT INTO `user_logs` VALUES (129, 1, '2021-12-28 10:04:41', '2021-12-28 10:04:41');
INSERT INTO `user_logs` VALUES (130, 18, '2021-12-28 10:34:58', '2021-12-28 10:34:58');
INSERT INTO `user_logs` VALUES (131, 18, '2021-12-28 10:58:01', '2021-12-28 10:58:01');
INSERT INTO `user_logs` VALUES (132, 1, '2021-12-28 11:18:49', '2021-12-28 11:18:49');
INSERT INTO `user_logs` VALUES (133, 13, '2021-12-28 11:20:00', '2021-12-28 11:20:00');
INSERT INTO `user_logs` VALUES (134, 1, '2021-12-28 11:20:37', '2021-12-28 11:20:37');
INSERT INTO `user_logs` VALUES (135, 13, '2021-12-28 11:21:13', '2021-12-28 11:21:13');
INSERT INTO `user_logs` VALUES (136, 12, '2021-12-28 11:21:31', '2021-12-28 11:21:31');
INSERT INTO `user_logs` VALUES (137, 13, '2021-12-28 11:22:22', '2021-12-28 11:22:22');
INSERT INTO `user_logs` VALUES (138, 1, '2021-12-28 11:22:41', '2021-12-28 11:22:41');
INSERT INTO `user_logs` VALUES (139, 10, '2021-12-28 14:00:03', '2021-12-28 14:00:03');
INSERT INTO `user_logs` VALUES (140, 10, '2021-12-28 14:03:01', '2021-12-28 14:03:01');
INSERT INTO `user_logs` VALUES (141, 1, '2021-12-28 14:58:36', '2021-12-28 14:58:36');
INSERT INTO `user_logs` VALUES (142, 1, '2021-12-28 15:18:02', '2021-12-28 15:18:02');
INSERT INTO `user_logs` VALUES (143, 1, '2021-12-28 23:02:46', '2021-12-28 23:02:46');
INSERT INTO `user_logs` VALUES (144, 1, '2021-12-29 08:33:27', '2021-12-29 08:33:27');
INSERT INTO `user_logs` VALUES (145, 15, '2021-12-29 09:27:59', '2021-12-29 09:27:59');
INSERT INTO `user_logs` VALUES (146, 10, '2021-12-29 09:39:57', '2021-12-29 09:39:57');
INSERT INTO `user_logs` VALUES (147, 14, '2021-12-29 09:41:41', '2021-12-29 09:41:41');
INSERT INTO `user_logs` VALUES (148, 1, '2021-12-29 10:14:52', '2021-12-29 10:14:52');
INSERT INTO `user_logs` VALUES (149, 15, '2021-12-29 10:19:23', '2021-12-29 10:19:23');
INSERT INTO `user_logs` VALUES (150, 1, '2021-12-29 10:22:31', '2021-12-29 10:22:31');
INSERT INTO `user_logs` VALUES (151, 15, '2021-12-29 14:21:57', '2021-12-29 14:21:57');
INSERT INTO `user_logs` VALUES (152, 1, '2021-12-29 15:15:48', '2021-12-29 15:15:48');
INSERT INTO `user_logs` VALUES (153, 15, '2021-12-30 08:21:39', '2021-12-30 08:21:39');
INSERT INTO `user_logs` VALUES (154, 10, '2021-12-30 08:39:21', '2021-12-30 08:39:21');
INSERT INTO `user_logs` VALUES (155, 1, '2021-12-30 08:49:51', '2021-12-30 08:49:51');
INSERT INTO `user_logs` VALUES (156, 1, '2021-12-30 11:02:31', '2021-12-30 11:02:31');
INSERT INTO `user_logs` VALUES (157, 18, '2021-12-30 11:46:14', '2021-12-30 11:46:14');
INSERT INTO `user_logs` VALUES (158, 18, '2021-12-30 12:39:34', '2021-12-30 12:39:34');
INSERT INTO `user_logs` VALUES (159, 18, '2021-12-30 13:11:29', '2021-12-30 13:11:29');
INSERT INTO `user_logs` VALUES (160, 18, '2021-12-30 13:25:35', '2021-12-30 13:25:35');
INSERT INTO `user_logs` VALUES (161, 18, '2021-12-30 14:12:04', '2021-12-30 14:12:04');
INSERT INTO `user_logs` VALUES (162, 15, '2021-12-31 08:45:42', '2021-12-31 08:45:42');
INSERT INTO `user_logs` VALUES (163, 18, '2021-12-31 10:17:09', '2021-12-31 10:17:09');
INSERT INTO `user_logs` VALUES (164, 1, '2021-12-31 11:30:24', '2021-12-31 11:30:24');
INSERT INTO `user_logs` VALUES (165, 18, '2022-01-03 09:01:09', '2022-01-03 09:01:09');
INSERT INTO `user_logs` VALUES (166, 18, '2022-01-03 09:13:05', '2022-01-03 09:13:05');
INSERT INTO `user_logs` VALUES (167, 1, '2022-01-03 09:20:19', '2022-01-03 09:20:19');
INSERT INTO `user_logs` VALUES (168, 18, '2022-01-03 10:17:24', '2022-01-03 10:17:24');
INSERT INTO `user_logs` VALUES (169, 10, '2022-01-03 11:29:46', '2022-01-03 11:29:46');
INSERT INTO `user_logs` VALUES (170, 1, '2022-01-03 11:31:38', '2022-01-03 11:31:38');
INSERT INTO `user_logs` VALUES (171, 1, '2022-01-03 11:32:04', '2022-01-03 11:32:04');
INSERT INTO `user_logs` VALUES (172, 1, '2022-01-03 12:02:17', '2022-01-03 12:02:17');
INSERT INTO `user_logs` VALUES (173, 10, '2022-01-03 14:10:42', '2022-01-03 14:10:42');
INSERT INTO `user_logs` VALUES (174, 1, '2022-01-04 07:50:22', '2022-01-04 07:50:22');
INSERT INTO `user_logs` VALUES (175, 1, '2022-01-04 09:00:35', '2022-01-04 09:00:35');
INSERT INTO `user_logs` VALUES (176, 1, '2022-01-04 09:28:15', '2022-01-04 09:28:15');
INSERT INTO `user_logs` VALUES (177, 15, '2022-01-04 09:44:44', '2022-01-04 09:44:44');
INSERT INTO `user_logs` VALUES (178, 1, '2022-01-04 10:10:24', '2022-01-04 10:10:24');
INSERT INTO `user_logs` VALUES (179, 1, '2022-01-04 11:02:10', '2022-01-04 11:02:10');
INSERT INTO `user_logs` VALUES (180, 15, '2022-01-04 13:00:56', '2022-01-04 13:00:56');
INSERT INTO `user_logs` VALUES (181, 18, '2022-01-04 14:29:21', '2022-01-04 14:29:21');
INSERT INTO `user_logs` VALUES (182, 1, '2022-01-04 14:59:54', '2022-01-04 14:59:54');
INSERT INTO `user_logs` VALUES (183, 10, '2022-01-05 08:10:25', '2022-01-05 08:10:25');
INSERT INTO `user_logs` VALUES (184, 1, '2022-01-05 08:18:20', '2022-01-05 08:18:20');
INSERT INTO `user_logs` VALUES (185, 1, '2022-01-05 08:39:53', '2022-01-05 08:39:53');
INSERT INTO `user_logs` VALUES (186, 1, '2022-01-05 08:53:04', '2022-01-05 08:53:04');
INSERT INTO `user_logs` VALUES (187, 18, '2022-01-05 09:03:16', '2022-01-05 09:03:16');
INSERT INTO `user_logs` VALUES (188, 15, '2022-01-05 09:03:16', '2022-01-05 09:03:16');
INSERT INTO `user_logs` VALUES (189, 1, '2022-01-05 09:17:09', '2022-01-05 09:17:09');
INSERT INTO `user_logs` VALUES (190, 15, '2022-01-05 09:19:18', '2022-01-05 09:19:18');
INSERT INTO `user_logs` VALUES (191, 15, '2022-01-05 09:24:30', '2022-01-05 09:24:30');
INSERT INTO `user_logs` VALUES (192, 1, '2022-01-05 09:28:40', '2022-01-05 09:28:40');
INSERT INTO `user_logs` VALUES (193, 10, '2022-01-05 10:03:47', '2022-01-05 10:03:47');
INSERT INTO `user_logs` VALUES (194, 1, '2022-01-05 10:05:59', '2022-01-05 10:05:59');
INSERT INTO `user_logs` VALUES (195, 19, '2022-01-05 10:29:06', '2022-01-05 10:29:06');
INSERT INTO `user_logs` VALUES (196, 14, '2022-01-05 11:23:58', '2022-01-05 11:23:58');
INSERT INTO `user_logs` VALUES (197, 14, '2022-01-05 11:38:32', '2022-01-05 11:38:32');
INSERT INTO `user_logs` VALUES (198, 9, '2022-01-05 11:38:52', '2022-01-05 11:38:52');
INSERT INTO `user_logs` VALUES (199, 18, '2022-01-05 11:54:04', '2022-01-05 11:54:04');
INSERT INTO `user_logs` VALUES (200, 1, '2022-01-05 12:05:23', '2022-01-05 12:05:23');
INSERT INTO `user_logs` VALUES (201, 14, '2022-01-05 12:22:39', '2022-01-05 12:22:39');
INSERT INTO `user_logs` VALUES (202, 18, '2022-01-05 14:03:58', '2022-01-05 14:03:58');
INSERT INTO `user_logs` VALUES (203, 1, '2022-01-05 15:05:39', '2022-01-05 15:05:39');
INSERT INTO `user_logs` VALUES (204, 1, '2022-01-05 15:26:48', '2022-01-05 15:26:48');
INSERT INTO `user_logs` VALUES (205, 1, '2022-01-05 15:28:15', '2022-01-05 15:28:15');
INSERT INTO `user_logs` VALUES (206, 19, '2022-01-06 07:48:50', '2022-01-06 07:48:50');
INSERT INTO `user_logs` VALUES (207, 11, '2022-01-06 09:05:03', '2022-01-06 09:05:03');
INSERT INTO `user_logs` VALUES (208, 1, '2022-01-06 09:20:02', '2022-01-06 09:20:02');
INSERT INTO `user_logs` VALUES (209, 1, '2022-01-06 09:53:35', '2022-01-06 09:53:35');
INSERT INTO `user_logs` VALUES (210, 1, '2022-01-06 10:00:47', '2022-01-06 10:00:47');
INSERT INTO `user_logs` VALUES (211, 1, '2022-01-06 10:36:41', '2022-01-06 10:36:41');
INSERT INTO `user_logs` VALUES (212, 15, '2022-01-06 11:10:21', '2022-01-06 11:10:21');
INSERT INTO `user_logs` VALUES (213, 1, '2022-01-06 11:20:52', '2022-01-06 11:20:52');
INSERT INTO `user_logs` VALUES (214, 1, '2022-01-06 11:21:54', '2022-01-06 11:21:54');
INSERT INTO `user_logs` VALUES (215, 20, '2022-01-06 11:22:42', '2022-01-06 11:22:42');
INSERT INTO `user_logs` VALUES (216, 16, '2022-01-06 11:23:12', '2022-01-06 11:23:12');
INSERT INTO `user_logs` VALUES (217, 1, '2022-01-06 11:36:28', '2022-01-06 11:36:28');
INSERT INTO `user_logs` VALUES (218, 18, '2022-01-06 11:44:30', '2022-01-06 11:44:30');
INSERT INTO `user_logs` VALUES (219, 16, '2022-01-06 13:42:01', '2022-01-06 13:42:01');
INSERT INTO `user_logs` VALUES (220, 11, '2022-01-06 13:44:23', '2022-01-06 13:44:23');
INSERT INTO `user_logs` VALUES (221, 1, '2022-01-06 13:59:12', '2022-01-06 13:59:12');
INSERT INTO `user_logs` VALUES (222, 19, '2022-01-06 14:13:40', '2022-01-06 14:13:40');
INSERT INTO `user_logs` VALUES (223, 11, '2022-01-07 08:09:49', '2022-01-07 08:09:49');
INSERT INTO `user_logs` VALUES (224, 1, '2022-01-07 08:54:44', '2022-01-07 08:54:44');
INSERT INTO `user_logs` VALUES (225, 1, '2022-01-07 09:10:20', '2022-01-07 09:10:20');
INSERT INTO `user_logs` VALUES (226, 20, '2022-01-07 09:26:31', '2022-01-07 09:26:31');
INSERT INTO `user_logs` VALUES (227, 10, '2022-01-07 09:35:02', '2022-01-07 09:35:02');
INSERT INTO `user_logs` VALUES (228, 20, '2022-01-07 09:39:17', '2022-01-07 09:39:17');
INSERT INTO `user_logs` VALUES (229, 18, '2022-01-07 09:51:25', '2022-01-07 09:51:25');
INSERT INTO `user_logs` VALUES (230, 20, '2022-01-07 09:54:43', '2022-01-07 09:54:43');
INSERT INTO `user_logs` VALUES (231, 1, '2022-01-07 10:35:20', '2022-01-07 10:35:20');
INSERT INTO `user_logs` VALUES (232, 1, '2022-01-07 10:48:51', '2022-01-07 10:48:51');
INSERT INTO `user_logs` VALUES (233, 19, '2022-01-07 10:53:52', '2022-01-07 10:53:52');
INSERT INTO `user_logs` VALUES (234, 1, '2022-01-07 11:03:37', '2022-01-07 11:03:37');
INSERT INTO `user_logs` VALUES (235, 18, '2022-01-07 11:20:25', '2022-01-07 11:20:25');
INSERT INTO `user_logs` VALUES (236, 16, '2022-01-07 13:13:52', '2022-01-07 13:13:52');
INSERT INTO `user_logs` VALUES (237, 1, '2022-01-07 14:32:19', '2022-01-07 14:32:19');
INSERT INTO `user_logs` VALUES (238, 20, '2022-01-08 07:45:00', '2022-01-08 07:45:00');
INSERT INTO `user_logs` VALUES (239, 17, '2022-01-08 07:58:07', '2022-01-08 07:58:07');
INSERT INTO `user_logs` VALUES (240, 15, '2022-01-08 07:59:52', '2022-01-08 07:59:52');
INSERT INTO `user_logs` VALUES (241, 20, '2022-01-08 08:05:54', '2022-01-08 08:05:54');
INSERT INTO `user_logs` VALUES (242, 19, '2022-01-10 09:37:27', '2022-01-10 09:37:27');
INSERT INTO `user_logs` VALUES (243, 1, '2022-01-10 09:37:55', '2022-01-10 09:37:55');
INSERT INTO `user_logs` VALUES (244, 20, '2022-01-10 09:39:27', '2022-01-10 09:39:27');
INSERT INTO `user_logs` VALUES (245, 20, '2022-01-10 09:44:25', '2022-01-10 09:44:25');
INSERT INTO `user_logs` VALUES (246, 1, '2022-01-10 09:45:31', '2022-01-10 09:45:31');
INSERT INTO `user_logs` VALUES (247, 15, '2022-01-10 09:48:11', '2022-01-10 09:48:11');
INSERT INTO `user_logs` VALUES (248, 10, '2022-01-10 09:49:15', '2022-01-10 09:49:15');
INSERT INTO `user_logs` VALUES (249, 1, '2022-01-10 09:51:09', '2022-01-10 09:51:09');
INSERT INTO `user_logs` VALUES (250, 1, '2022-01-10 10:01:36', '2022-01-10 10:01:36');
INSERT INTO `user_logs` VALUES (251, 1, '2022-01-10 11:11:42', '2022-01-10 11:11:42');
INSERT INTO `user_logs` VALUES (252, 16, '2022-01-10 11:33:39', '2022-01-10 11:33:39');
INSERT INTO `user_logs` VALUES (253, 1, '2022-01-10 13:38:24', '2022-01-10 13:38:24');
INSERT INTO `user_logs` VALUES (254, 1, '2022-01-10 13:50:49', '2022-01-10 13:50:49');
INSERT INTO `user_logs` VALUES (255, 1, '2022-01-10 14:25:51', '2022-01-10 14:25:51');
INSERT INTO `user_logs` VALUES (256, 20, '2022-01-10 14:36:46', '2022-01-10 14:36:46');
INSERT INTO `user_logs` VALUES (257, 9, '2022-01-10 14:38:53', '2022-01-10 14:38:53');
INSERT INTO `user_logs` VALUES (258, 9, '2022-01-10 14:39:43', '2022-01-10 14:39:43');
INSERT INTO `user_logs` VALUES (259, 1, '2022-01-10 14:41:54', '2022-01-10 14:41:54');
INSERT INTO `user_logs` VALUES (260, 9, '2022-01-10 14:47:57', '2022-01-10 14:47:57');
INSERT INTO `user_logs` VALUES (261, 16, '2022-01-10 15:50:40', '2022-01-10 15:50:40');
INSERT INTO `user_logs` VALUES (262, 16, '2022-01-10 15:54:33', '2022-01-10 15:54:33');
INSERT INTO `user_logs` VALUES (263, 17, '2022-01-11 08:05:31', '2022-01-11 08:05:31');
INSERT INTO `user_logs` VALUES (264, 1, '2022-01-11 08:15:26', '2022-01-11 08:15:26');
INSERT INTO `user_logs` VALUES (265, 1, '2022-01-11 08:23:50', '2022-01-11 08:23:50');
INSERT INTO `user_logs` VALUES (266, 1, '2022-01-11 08:35:56', '2022-01-11 08:35:56');
INSERT INTO `user_logs` VALUES (267, 17, '2022-01-11 08:58:41', '2022-01-11 08:58:41');
INSERT INTO `user_logs` VALUES (268, 15, '2022-01-11 09:06:48', '2022-01-11 09:06:48');
INSERT INTO `user_logs` VALUES (269, 10, '2022-01-11 09:12:49', '2022-01-11 09:12:49');
INSERT INTO `user_logs` VALUES (270, 1, '2022-01-11 09:25:49', '2022-01-11 09:25:49');
INSERT INTO `user_logs` VALUES (271, 15, '2022-01-11 09:51:24', '2022-01-11 09:51:24');
INSERT INTO `user_logs` VALUES (272, 18, '2022-01-11 11:19:29', '2022-01-11 11:19:29');
INSERT INTO `user_logs` VALUES (273, 16, '2022-01-11 11:21:43', '2022-01-11 11:21:43');
INSERT INTO `user_logs` VALUES (274, 20, '2022-01-11 11:43:09', '2022-01-11 11:43:09');
INSERT INTO `user_logs` VALUES (275, 12, '2022-01-11 11:58:33', '2022-01-11 11:58:33');
INSERT INTO `user_logs` VALUES (276, 20, '2022-01-11 14:11:00', '2022-01-11 14:11:00');
INSERT INTO `user_logs` VALUES (277, 13, '2022-01-11 14:19:22', '2022-01-11 14:19:22');
INSERT INTO `user_logs` VALUES (278, 11, '2022-01-12 08:17:05', '2022-01-12 08:17:05');
INSERT INTO `user_logs` VALUES (279, 16, '2022-01-12 08:18:00', '2022-01-12 08:18:00');
INSERT INTO `user_logs` VALUES (280, 17, '2022-01-12 08:18:30', '2022-01-12 08:18:30');
INSERT INTO `user_logs` VALUES (281, 1, '2022-01-12 08:49:25', '2022-01-12 08:49:25');
INSERT INTO `user_logs` VALUES (282, 14, '2022-01-12 08:50:15', '2022-01-12 08:50:15');
INSERT INTO `user_logs` VALUES (283, 14, '2022-01-12 09:31:23', '2022-01-12 09:31:23');
INSERT INTO `user_logs` VALUES (284, 1, '2022-01-12 09:46:37', '2022-01-12 09:46:37');
INSERT INTO `user_logs` VALUES (285, 1, '2022-01-12 09:47:30', '2022-01-12 09:47:30');
INSERT INTO `user_logs` VALUES (286, 1, '2022-01-12 09:50:29', '2022-01-12 09:50:29');
INSERT INTO `user_logs` VALUES (287, 1, '2022-01-12 09:57:44', '2022-01-12 09:57:44');
INSERT INTO `user_logs` VALUES (288, 1, '2022-01-12 10:10:04', '2022-01-12 10:10:04');
INSERT INTO `user_logs` VALUES (289, 15, '2022-01-12 10:20:15', '2022-01-12 10:20:15');
INSERT INTO `user_logs` VALUES (290, 1, '2022-01-12 10:26:37', '2022-01-12 10:26:37');
INSERT INTO `user_logs` VALUES (291, 16, '2022-01-12 10:27:21', '2022-01-12 10:27:21');
INSERT INTO `user_logs` VALUES (292, 9, '2022-01-12 10:31:11', '2022-01-12 10:31:11');
INSERT INTO `user_logs` VALUES (293, 15, '2022-01-12 10:54:40', '2022-01-12 10:54:40');
INSERT INTO `user_logs` VALUES (294, 15, '2022-01-12 11:04:31', '2022-01-12 11:04:31');
INSERT INTO `user_logs` VALUES (295, 1, '2022-01-12 11:33:09', '2022-01-12 11:33:09');
INSERT INTO `user_logs` VALUES (296, 10, '2022-01-12 13:06:00', '2022-01-12 13:06:00');
INSERT INTO `user_logs` VALUES (297, 16, '2022-01-12 13:36:28', '2022-01-12 13:36:28');
INSERT INTO `user_logs` VALUES (298, 13, '2022-01-12 13:49:57', '2022-01-12 13:49:57');
INSERT INTO `user_logs` VALUES (299, 1, '2022-01-12 13:59:16', '2022-01-12 13:59:16');
INSERT INTO `user_logs` VALUES (300, 1, '2022-01-12 14:20:25', '2022-01-12 14:20:25');
INSERT INTO `user_logs` VALUES (301, 16, '2022-01-12 14:20:56', '2022-01-12 14:20:56');
INSERT INTO `user_logs` VALUES (302, 1, '2022-01-12 14:28:27', '2022-01-12 14:28:27');
INSERT INTO `user_logs` VALUES (303, 1, '2022-01-12 14:38:03', '2022-01-12 14:38:03');
INSERT INTO `user_logs` VALUES (304, 16, '2022-01-12 15:02:17', '2022-01-12 15:02:17');
INSERT INTO `user_logs` VALUES (305, 1, '2022-01-12 15:05:15', '2022-01-12 15:05:15');
INSERT INTO `user_logs` VALUES (306, 1, '2022-01-12 15:22:22', '2022-01-12 15:22:22');
INSERT INTO `user_logs` VALUES (307, 16, '2022-01-13 07:35:17', '2022-01-13 07:35:17');
INSERT INTO `user_logs` VALUES (308, 1, '2022-01-13 07:44:07', '2022-01-13 07:44:07');
INSERT INTO `user_logs` VALUES (309, 1, '2022-01-13 08:25:22', '2022-01-13 08:25:22');
INSERT INTO `user_logs` VALUES (310, 20, '2022-01-13 08:33:55', '2022-01-13 08:33:55');
INSERT INTO `user_logs` VALUES (311, 11, '2022-01-13 08:48:32', '2022-01-13 08:48:32');
INSERT INTO `user_logs` VALUES (312, 20, '2022-01-13 08:48:55', '2022-01-13 08:48:55');
INSERT INTO `user_logs` VALUES (313, 14, '2022-01-13 08:51:25', '2022-01-13 08:51:25');
INSERT INTO `user_logs` VALUES (314, 1, '2022-01-13 08:54:22', '2022-01-13 08:54:22');
INSERT INTO `user_logs` VALUES (315, 10, '2022-01-13 09:14:07', '2022-01-13 09:14:07');
INSERT INTO `user_logs` VALUES (316, 1, '2022-01-13 09:29:55', '2022-01-13 09:29:55');
INSERT INTO `user_logs` VALUES (317, 1, '2022-01-13 09:47:35', '2022-01-13 09:47:35');
INSERT INTO `user_logs` VALUES (318, 1, '2022-01-13 11:29:40', '2022-01-13 11:29:40');
INSERT INTO `user_logs` VALUES (319, 1, '2022-01-13 15:25:48', '2022-01-13 15:25:48');
INSERT INTO `user_logs` VALUES (320, 11, '2022-01-14 08:01:11', '2022-01-14 08:01:11');
INSERT INTO `user_logs` VALUES (321, 16, '2022-01-14 08:17:00', '2022-01-14 08:17:00');
INSERT INTO `user_logs` VALUES (322, 14, '2022-01-14 08:26:43', '2022-01-14 08:26:43');
INSERT INTO `user_logs` VALUES (323, 10, '2022-01-14 08:50:08', '2022-01-14 08:50:08');
INSERT INTO `user_logs` VALUES (324, 14, '2022-01-14 08:54:21', '2022-01-14 08:54:21');
INSERT INTO `user_logs` VALUES (325, 1, '2022-01-14 09:14:41', '2022-01-14 09:14:41');
INSERT INTO `user_logs` VALUES (326, 1, '2022-01-14 09:21:00', '2022-01-14 09:21:00');
INSERT INTO `user_logs` VALUES (327, 16, '2022-01-14 09:25:11', '2022-01-14 09:25:11');
INSERT INTO `user_logs` VALUES (328, 16, '2022-01-14 09:30:22', '2022-01-14 09:30:22');
INSERT INTO `user_logs` VALUES (329, 1, '2022-01-14 09:32:53', '2022-01-14 09:32:53');
INSERT INTO `user_logs` VALUES (330, 13, '2022-01-14 09:43:51', '2022-01-14 09:43:51');
INSERT INTO `user_logs` VALUES (331, 1, '2022-01-14 10:54:23', '2022-01-14 10:54:23');
INSERT INTO `user_logs` VALUES (332, 1, '2022-01-14 12:58:55', '2022-01-14 12:58:55');
INSERT INTO `user_logs` VALUES (333, 1, '2022-01-14 14:33:51', '2022-01-14 14:33:51');
INSERT INTO `user_logs` VALUES (334, 14, '2022-01-14 14:49:03', '2022-01-14 14:49:03');
INSERT INTO `user_logs` VALUES (335, 14, '2022-01-17 08:10:55', '2022-01-17 08:10:55');
INSERT INTO `user_logs` VALUES (336, 1, '2022-01-17 08:13:41', '2022-01-17 08:13:41');
INSERT INTO `user_logs` VALUES (337, 1, '2022-01-17 08:16:53', '2022-01-17 08:16:53');
INSERT INTO `user_logs` VALUES (338, 1, '2022-01-17 08:39:47', '2022-01-17 08:39:47');
INSERT INTO `user_logs` VALUES (339, 1, '2022-01-17 08:42:53', '2022-01-17 08:42:53');
INSERT INTO `user_logs` VALUES (340, 14, '2022-01-17 08:53:24', '2022-01-17 08:53:24');
INSERT INTO `user_logs` VALUES (341, 1, '2022-01-17 09:01:04', '2022-01-17 09:01:04');
INSERT INTO `user_logs` VALUES (342, 1, '2022-01-17 09:11:44', '2022-01-17 09:11:44');
INSERT INTO `user_logs` VALUES (343, 1, '2022-01-17 09:29:29', '2022-01-17 09:29:29');
INSERT INTO `user_logs` VALUES (344, 13, '2022-01-17 09:34:23', '2022-01-17 09:34:23');
INSERT INTO `user_logs` VALUES (345, 1, '2022-01-17 09:41:39', '2022-01-17 09:41:39');
INSERT INTO `user_logs` VALUES (346, 17, '2022-01-17 10:07:42', '2022-01-17 10:07:42');
INSERT INTO `user_logs` VALUES (347, 17, '2022-01-17 10:13:01', '2022-01-17 10:13:01');
INSERT INTO `user_logs` VALUES (348, 13, '2022-01-17 10:30:40', '2022-01-17 10:30:40');
INSERT INTO `user_logs` VALUES (349, 1, '2022-01-17 13:59:30', '2022-01-17 13:59:30');
INSERT INTO `user_logs` VALUES (350, 1, '2022-01-17 14:00:13', '2022-01-17 14:00:13');
INSERT INTO `user_logs` VALUES (351, 10, '2022-01-17 14:01:04', '2022-01-17 14:01:04');
INSERT INTO `user_logs` VALUES (352, 14, '2022-01-17 14:30:05', '2022-01-17 14:30:05');
INSERT INTO `user_logs` VALUES (353, 1, '2022-01-17 15:56:41', '2022-01-17 15:56:41');
INSERT INTO `user_logs` VALUES (354, 16, '2022-01-18 07:48:21', '2022-01-18 07:48:21');
INSERT INTO `user_logs` VALUES (355, 13, '2022-01-18 08:39:06', '2022-01-18 08:39:06');
INSERT INTO `user_logs` VALUES (356, 17, '2022-01-18 08:42:15', '2022-01-18 08:42:15');
INSERT INTO `user_logs` VALUES (357, 14, '2022-01-18 08:49:13', '2022-01-18 08:49:13');
INSERT INTO `user_logs` VALUES (358, 1, '2022-01-18 08:53:12', '2022-01-18 08:53:12');
INSERT INTO `user_logs` VALUES (359, 18, '2022-01-18 09:06:34', '2022-01-18 09:06:34');
INSERT INTO `user_logs` VALUES (360, 18, '2022-01-18 09:07:00', '2022-01-18 09:07:00');
INSERT INTO `user_logs` VALUES (361, 19, '2022-01-18 09:26:13', '2022-01-18 09:26:13');
INSERT INTO `user_logs` VALUES (362, 14, '2022-01-18 09:32:31', '2022-01-18 09:32:31');
INSERT INTO `user_logs` VALUES (363, 1, '2022-01-18 09:37:02', '2022-01-18 09:37:02');
INSERT INTO `user_logs` VALUES (364, 9, '2022-01-18 09:40:41', '2022-01-18 09:40:41');
INSERT INTO `user_logs` VALUES (365, 16, '2022-01-18 09:43:10', '2022-01-18 09:43:10');
INSERT INTO `user_logs` VALUES (366, 1, '2022-01-18 10:16:52', '2022-01-18 10:16:52');
INSERT INTO `user_logs` VALUES (367, 15, '2022-01-18 10:22:58', '2022-01-18 10:22:58');
INSERT INTO `user_logs` VALUES (368, 13, '2022-01-18 11:06:22', '2022-01-18 11:06:22');
INSERT INTO `user_logs` VALUES (369, 12, '2022-01-18 11:09:46', '2022-01-18 11:09:46');
INSERT INTO `user_logs` VALUES (370, 18, '2022-01-18 11:16:39', '2022-01-18 11:16:39');
INSERT INTO `user_logs` VALUES (371, 1, '2022-01-18 13:18:58', '2022-01-18 13:18:58');
INSERT INTO `user_logs` VALUES (372, 14, '2022-01-18 14:04:11', '2022-01-18 14:04:11');
INSERT INTO `user_logs` VALUES (373, 12, '2022-01-18 14:30:19', '2022-01-18 14:30:19');
INSERT INTO `user_logs` VALUES (374, 14, '2022-01-18 14:32:31', '2022-01-18 14:32:31');
INSERT INTO `user_logs` VALUES (375, 1, '2022-01-18 15:22:46', '2022-01-18 15:22:46');
INSERT INTO `user_logs` VALUES (376, 9, '2022-01-19 08:32:10', '2022-01-19 08:32:10');
INSERT INTO `user_logs` VALUES (377, 1, '2022-01-19 08:35:02', '2022-01-19 08:35:02');
INSERT INTO `user_logs` VALUES (378, 19, '2022-01-19 08:43:50', '2022-01-19 08:43:50');
INSERT INTO `user_logs` VALUES (379, 9, '2022-01-19 08:57:18', '2022-01-19 08:57:18');
INSERT INTO `user_logs` VALUES (380, 16, '2022-01-19 08:58:23', '2022-01-19 08:58:23');
INSERT INTO `user_logs` VALUES (381, 14, '2022-01-19 09:05:08', '2022-01-19 09:05:08');
INSERT INTO `user_logs` VALUES (382, 13, '2022-01-19 09:20:01', '2022-01-19 09:20:01');
INSERT INTO `user_logs` VALUES (383, 1, '2022-01-19 09:21:19', '2022-01-19 09:21:19');
INSERT INTO `user_logs` VALUES (384, 20, '2022-01-19 09:48:01', '2022-01-19 09:48:01');
INSERT INTO `user_logs` VALUES (385, 18, '2022-01-19 09:50:01', '2022-01-19 09:50:01');
INSERT INTO `user_logs` VALUES (386, 15, '2022-01-19 09:51:06', '2022-01-19 09:51:06');
INSERT INTO `user_logs` VALUES (387, 20, '2022-01-19 09:52:20', '2022-01-19 09:52:20');
INSERT INTO `user_logs` VALUES (388, 1, '2022-01-19 10:19:20', '2022-01-19 10:19:20');
INSERT INTO `user_logs` VALUES (389, 1, '2022-01-19 10:41:17', '2022-01-19 10:41:17');
INSERT INTO `user_logs` VALUES (390, 11, '2022-01-19 13:33:01', '2022-01-19 13:33:01');
INSERT INTO `user_logs` VALUES (391, 14, '2022-01-19 14:01:19', '2022-01-19 14:01:19');
INSERT INTO `user_logs` VALUES (392, 13, '2022-01-19 15:02:08', '2022-01-19 15:02:08');
INSERT INTO `user_logs` VALUES (393, 14, '2022-01-20 08:24:23', '2022-01-20 08:24:23');
INSERT INTO `user_logs` VALUES (394, 1, '2022-01-20 08:29:05', '2022-01-20 08:29:05');
INSERT INTO `user_logs` VALUES (395, 14, '2022-01-20 09:14:09', '2022-01-20 09:14:09');
INSERT INTO `user_logs` VALUES (396, 14, '2022-01-20 09:53:15', '2022-01-20 09:53:15');
INSERT INTO `user_logs` VALUES (397, 13, '2022-01-20 10:39:28', '2022-01-20 10:39:28');
INSERT INTO `user_logs` VALUES (398, 1, '2022-01-20 11:26:33', '2022-01-20 11:26:33');
INSERT INTO `user_logs` VALUES (399, 1, '2022-01-20 13:44:48', '2022-01-20 13:44:48');
INSERT INTO `user_logs` VALUES (400, 14, '2022-01-20 13:58:05', '2022-01-20 13:58:05');
INSERT INTO `user_logs` VALUES (401, 14, '2022-01-20 14:10:52', '2022-01-20 14:10:52');
INSERT INTO `user_logs` VALUES (402, 14, '2022-01-21 08:26:01', '2022-01-21 08:26:01');
INSERT INTO `user_logs` VALUES (403, 11, '2022-01-21 08:36:47', '2022-01-21 08:36:47');
INSERT INTO `user_logs` VALUES (404, 1, '2022-01-21 08:41:38', '2022-01-21 08:41:38');
INSERT INTO `user_logs` VALUES (405, 1, '2022-01-21 08:43:47', '2022-01-21 08:43:47');
INSERT INTO `user_logs` VALUES (406, 1, '2022-01-21 08:54:18', '2022-01-21 08:54:18');
INSERT INTO `user_logs` VALUES (407, 14, '2022-01-21 09:12:49', '2022-01-21 09:12:49');
INSERT INTO `user_logs` VALUES (408, 13, '2022-01-21 10:05:45', '2022-01-21 10:05:45');
INSERT INTO `user_logs` VALUES (409, 1, '2022-01-21 10:24:06', '2022-01-21 10:24:06');
INSERT INTO `user_logs` VALUES (410, 14, '2022-01-21 11:43:35', '2022-01-21 11:43:35');
INSERT INTO `user_logs` VALUES (411, 10, '2022-01-21 11:56:16', '2022-01-21 11:56:16');
INSERT INTO `user_logs` VALUES (412, 14, '2022-01-21 13:24:42', '2022-01-21 13:24:42');
INSERT INTO `user_logs` VALUES (413, 1, '2022-01-24 08:33:11', '2022-01-24 08:33:11');
INSERT INTO `user_logs` VALUES (414, 18, '2022-01-24 08:45:34', '2022-01-24 08:45:34');
INSERT INTO `user_logs` VALUES (415, 1, '2022-01-24 09:10:49', '2022-01-24 09:10:49');
INSERT INTO `user_logs` VALUES (416, 11, '2022-01-24 09:51:42', '2022-01-24 09:51:42');
INSERT INTO `user_logs` VALUES (417, 18, '2022-01-24 09:52:33', '2022-01-24 09:52:33');
INSERT INTO `user_logs` VALUES (418, 1, '2022-01-24 10:04:10', '2022-01-24 10:04:10');
INSERT INTO `user_logs` VALUES (419, 18, '2022-01-24 10:20:23', '2022-01-24 10:20:23');
INSERT INTO `user_logs` VALUES (420, 18, '2022-01-24 10:34:47', '2022-01-24 10:34:47');
INSERT INTO `user_logs` VALUES (421, 10, '2022-01-24 13:29:59', '2022-01-24 13:29:59');
INSERT INTO `user_logs` VALUES (422, 1, '2022-01-25 07:56:44', '2022-01-25 07:56:44');
INSERT INTO `user_logs` VALUES (423, 14, '2022-01-25 08:12:33', '2022-01-25 08:12:33');
INSERT INTO `user_logs` VALUES (424, 1, '2022-01-25 08:32:22', '2022-01-25 08:32:22');
INSERT INTO `user_logs` VALUES (425, 1, '2022-01-25 08:38:26', '2022-01-25 08:38:26');
INSERT INTO `user_logs` VALUES (426, 14, '2022-01-25 08:57:53', '2022-01-25 08:57:53');
INSERT INTO `user_logs` VALUES (427, 1, '2022-01-25 09:00:19', '2022-01-25 09:00:19');
INSERT INTO `user_logs` VALUES (428, 15, '2022-01-25 09:43:22', '2022-01-25 09:43:22');
INSERT INTO `user_logs` VALUES (429, 1, '2022-01-25 09:44:23', '2022-01-25 09:44:23');
INSERT INTO `user_logs` VALUES (430, 13, '2022-01-25 10:02:41', '2022-01-25 10:02:41');
INSERT INTO `user_logs` VALUES (431, 1, '2022-01-25 10:24:49', '2022-01-25 10:24:49');
INSERT INTO `user_logs` VALUES (432, 16, '2022-01-25 10:53:06', '2022-01-25 10:53:06');
INSERT INTO `user_logs` VALUES (433, 16, '2022-01-25 10:56:34', '2022-01-25 10:56:34');
INSERT INTO `user_logs` VALUES (434, 1, '2022-01-25 11:00:42', '2022-01-25 11:00:42');
INSERT INTO `user_logs` VALUES (435, 16, '2022-01-25 11:02:55', '2022-01-25 11:02:55');
INSERT INTO `user_logs` VALUES (436, 1, '2022-01-25 11:10:22', '2022-01-25 11:10:22');
INSERT INTO `user_logs` VALUES (437, 16, '2022-01-25 11:28:51', '2022-01-25 11:28:51');
INSERT INTO `user_logs` VALUES (438, 1, '2022-01-25 11:34:58', '2022-01-25 11:34:58');
INSERT INTO `user_logs` VALUES (439, 1, '2022-01-25 11:46:35', '2022-01-25 11:46:35');
INSERT INTO `user_logs` VALUES (440, 16, '2022-01-25 11:54:04', '2022-01-25 11:54:04');
INSERT INTO `user_logs` VALUES (441, 10, '2022-01-25 12:35:48', '2022-01-25 12:35:48');
INSERT INTO `user_logs` VALUES (442, 10, '2022-01-25 13:40:37', '2022-01-25 13:40:37');
INSERT INTO `user_logs` VALUES (443, 1, '2022-01-25 13:46:01', '2022-01-25 13:46:01');
INSERT INTO `user_logs` VALUES (444, 14, '2022-01-25 14:01:15', '2022-01-25 14:01:15');
INSERT INTO `user_logs` VALUES (445, 1, '2022-01-25 14:41:59', '2022-01-25 14:41:59');
INSERT INTO `user_logs` VALUES (446, 13, '2022-01-25 15:10:37', '2022-01-25 15:10:37');
INSERT INTO `user_logs` VALUES (447, 14, '2022-01-25 15:32:20', '2022-01-25 15:32:20');
INSERT INTO `user_logs` VALUES (448, 1, '2022-01-26 07:08:09', '2022-01-26 07:08:09');
INSERT INTO `user_logs` VALUES (449, 14, '2022-01-26 08:30:25', '2022-01-26 08:30:25');
INSERT INTO `user_logs` VALUES (450, 1, '2022-01-26 08:52:34', '2022-01-26 08:52:34');
INSERT INTO `user_logs` VALUES (451, 13, '2022-01-26 09:24:20', '2022-01-26 09:24:20');
INSERT INTO `user_logs` VALUES (452, 16, '2022-01-26 10:04:16', '2022-01-26 10:04:16');
INSERT INTO `user_logs` VALUES (453, 1, '2022-01-26 11:57:25', '2022-01-26 11:57:25');
INSERT INTO `user_logs` VALUES (454, 14, '2022-01-26 13:31:29', '2022-01-26 13:31:29');
INSERT INTO `user_logs` VALUES (455, 11, '2022-01-26 13:58:00', '2022-01-26 13:58:00');
INSERT INTO `user_logs` VALUES (456, 14, '2022-01-26 14:56:23', '2022-01-26 14:56:23');
INSERT INTO `user_logs` VALUES (457, 11, '2022-01-27 08:21:46', '2022-01-27 08:21:46');
INSERT INTO `user_logs` VALUES (458, 10, '2022-01-27 08:33:18', '2022-01-27 08:33:18');
INSERT INTO `user_logs` VALUES (459, 10, '2022-01-27 08:38:48', '2022-01-27 08:38:48');
INSERT INTO `user_logs` VALUES (460, 14, '2022-01-27 08:49:51', '2022-01-27 08:49:51');
INSERT INTO `user_logs` VALUES (461, 14, '2022-01-27 09:26:40', '2022-01-27 09:26:40');
INSERT INTO `user_logs` VALUES (462, 14, '2022-01-27 11:23:08', '2022-01-27 11:23:08');
INSERT INTO `user_logs` VALUES (463, 1, '2022-01-27 11:26:05', '2022-01-27 11:26:05');
INSERT INTO `user_logs` VALUES (464, 11, '2022-01-27 12:00:51', '2022-01-27 12:00:51');
INSERT INTO `user_logs` VALUES (465, 11, '2022-01-27 14:13:34', '2022-01-27 14:13:34');
INSERT INTO `user_logs` VALUES (466, 1, '2022-01-28 08:25:49', '2022-01-28 08:25:49');
INSERT INTO `user_logs` VALUES (467, 1, '2022-01-28 08:31:00', '2022-01-28 08:31:00');
INSERT INTO `user_logs` VALUES (468, 11, '2022-01-28 09:02:07', '2022-01-28 09:02:07');
INSERT INTO `user_logs` VALUES (469, 14, '2022-01-28 09:06:07', '2022-01-28 09:06:07');
INSERT INTO `user_logs` VALUES (470, 14, '2022-01-28 09:22:25', '2022-01-28 09:22:25');
INSERT INTO `user_logs` VALUES (471, 14, '2022-01-28 10:18:24', '2022-01-28 10:18:24');
INSERT INTO `user_logs` VALUES (472, 1, '2022-01-28 14:02:56', '2022-01-28 14:02:56');
INSERT INTO `user_logs` VALUES (473, 1, '2022-01-28 14:03:53', '2022-01-28 14:03:53');
INSERT INTO `user_logs` VALUES (474, 10, '2022-01-28 14:15:12', '2022-01-28 14:15:12');
INSERT INTO `user_logs` VALUES (475, 20, '2022-01-28 14:41:48', '2022-01-28 14:41:48');
INSERT INTO `user_logs` VALUES (476, 9, '2022-01-31 08:51:26', '2022-01-31 08:51:26');
INSERT INTO `user_logs` VALUES (477, 9, '2022-01-31 09:14:57', '2022-01-31 09:14:57');
INSERT INTO `user_logs` VALUES (478, 1, '2022-01-31 09:20:06', '2022-01-31 09:20:06');
INSERT INTO `user_logs` VALUES (479, 11, '2022-01-31 09:41:44', '2022-01-31 09:41:44');
INSERT INTO `user_logs` VALUES (480, 1, '2022-01-31 10:14:35', '2022-01-31 10:14:35');
INSERT INTO `user_logs` VALUES (481, 1, '2022-01-31 10:17:51', '2022-01-31 10:17:51');
INSERT INTO `user_logs` VALUES (482, 10, '2022-01-31 13:41:04', '2022-01-31 13:41:04');
INSERT INTO `user_logs` VALUES (483, 14, '2022-01-31 13:55:46', '2022-01-31 13:55:46');
INSERT INTO `user_logs` VALUES (484, 11, '2022-01-31 14:39:40', '2022-01-31 14:39:40');
INSERT INTO `user_logs` VALUES (485, 14, '2022-01-31 21:44:19', '2022-01-31 21:44:19');
INSERT INTO `user_logs` VALUES (486, 14, '2022-02-02 08:09:20', '2022-02-02 08:09:20');
INSERT INTO `user_logs` VALUES (487, 14, '2022-02-02 08:33:42', '2022-02-02 08:33:42');
INSERT INTO `user_logs` VALUES (488, 1, '2022-02-02 08:55:39', '2022-02-02 08:55:39');
INSERT INTO `user_logs` VALUES (489, 1, '2022-02-02 08:56:14', '2022-02-02 08:56:14');
INSERT INTO `user_logs` VALUES (490, 1, '2022-02-02 09:02:47', '2022-02-02 09:02:47');
INSERT INTO `user_logs` VALUES (491, 9, '2022-02-02 09:28:40', '2022-02-02 09:28:40');
INSERT INTO `user_logs` VALUES (492, 11, '2022-02-02 10:27:03', '2022-02-02 10:27:03');
INSERT INTO `user_logs` VALUES (493, 20, '2022-02-02 11:50:42', '2022-02-02 11:50:42');
INSERT INTO `user_logs` VALUES (494, 14, '2022-02-02 14:03:19', '2022-02-02 14:03:19');
INSERT INTO `user_logs` VALUES (495, 9, '2022-02-02 14:08:45', '2022-02-02 14:08:45');
INSERT INTO `user_logs` VALUES (496, 1, '2022-02-02 14:20:45', '2022-02-02 14:20:45');
INSERT INTO `user_logs` VALUES (497, 11, '2022-02-02 14:43:41', '2022-02-02 14:43:41');
INSERT INTO `user_logs` VALUES (498, 1, '2022-02-03 08:16:50', '2022-02-03 08:16:50');
INSERT INTO `user_logs` VALUES (499, 15, '2022-02-03 08:17:43', '2022-02-03 08:17:43');
INSERT INTO `user_logs` VALUES (500, 14, '2022-02-03 08:32:23', '2022-02-03 08:32:23');
INSERT INTO `user_logs` VALUES (501, 20, '2022-02-03 08:37:07', '2022-02-03 08:37:07');
INSERT INTO `user_logs` VALUES (502, 1, '2022-02-03 08:40:38', '2022-02-03 08:40:38');
INSERT INTO `user_logs` VALUES (503, 1, '2022-02-03 08:41:15', '2022-02-03 08:41:15');
INSERT INTO `user_logs` VALUES (504, 11, '2022-02-03 08:56:10', '2022-02-03 08:56:10');
INSERT INTO `user_logs` VALUES (505, 14, '2022-02-03 09:47:37', '2022-02-03 09:47:37');
INSERT INTO `user_logs` VALUES (506, 1, '2022-02-03 09:58:46', '2022-02-03 09:58:46');
INSERT INTO `user_logs` VALUES (507, 1, '2022-02-03 10:22:06', '2022-02-03 10:22:06');
INSERT INTO `user_logs` VALUES (508, 1, '2022-02-03 10:55:31', '2022-02-03 10:55:31');
INSERT INTO `user_logs` VALUES (509, 1, '2022-02-03 10:57:06', '2022-02-03 10:57:06');
INSERT INTO `user_logs` VALUES (510, 10, '2022-02-03 11:59:44', '2022-02-03 11:59:44');
INSERT INTO `user_logs` VALUES (511, 1, '2022-02-04 07:18:10', '2022-02-04 07:18:10');
INSERT INTO `user_logs` VALUES (512, 1, '2022-02-04 08:28:24', '2022-02-04 08:28:24');
INSERT INTO `user_logs` VALUES (513, 10, '2022-02-04 08:51:44', '2022-02-04 08:51:44');
INSERT INTO `user_logs` VALUES (514, 14, '2022-02-04 09:21:29', '2022-02-04 09:21:29');
INSERT INTO `user_logs` VALUES (515, 13, '2022-02-04 11:15:54', '2022-02-04 11:15:54');
INSERT INTO `user_logs` VALUES (516, 14, '2022-02-04 14:25:34', '2022-02-04 14:25:34');
INSERT INTO `user_logs` VALUES (517, 1, '2022-02-04 14:28:58', '2022-02-04 14:28:58');
INSERT INTO `user_logs` VALUES (518, 14, '2022-02-04 18:30:16', '2022-02-04 18:30:16');
INSERT INTO `user_logs` VALUES (519, 1, '2022-02-07 07:37:38', '2022-02-07 07:37:38');
INSERT INTO `user_logs` VALUES (520, 1, '2022-02-07 07:44:37', '2022-02-07 07:44:37');
INSERT INTO `user_logs` VALUES (521, 1, '2022-02-07 07:47:29', '2022-02-07 07:47:29');
INSERT INTO `user_logs` VALUES (522, 14, '2022-02-07 08:51:57', '2022-02-07 08:51:57');
INSERT INTO `user_logs` VALUES (523, 1, '2022-02-07 08:52:09', '2022-02-07 08:52:09');
INSERT INTO `user_logs` VALUES (524, 1, '2022-02-07 09:14:20', '2022-02-07 09:14:20');
INSERT INTO `user_logs` VALUES (525, 10, '2022-02-07 09:33:28', '2022-02-07 09:33:28');
INSERT INTO `user_logs` VALUES (526, 10, '2022-02-07 10:18:41', '2022-02-07 10:18:41');
INSERT INTO `user_logs` VALUES (527, 1, '2022-02-07 11:44:49', '2022-02-07 11:44:49');
INSERT INTO `user_logs` VALUES (528, 11, '2022-02-07 14:00:40', '2022-02-07 14:00:40');
INSERT INTO `user_logs` VALUES (529, 11, '2022-02-07 14:07:10', '2022-02-07 14:07:10');
INSERT INTO `user_logs` VALUES (530, 11, '2022-02-08 08:10:59', '2022-02-08 08:10:59');
INSERT INTO `user_logs` VALUES (531, 1, '2022-02-08 08:31:12', '2022-02-08 08:31:12');
INSERT INTO `user_logs` VALUES (532, 11, '2022-02-08 08:37:29', '2022-02-08 08:37:29');
INSERT INTO `user_logs` VALUES (533, 1, '2022-02-08 08:38:07', '2022-02-08 08:38:07');
INSERT INTO `user_logs` VALUES (534, 1, '2022-02-08 08:39:19', '2022-02-08 08:39:19');
INSERT INTO `user_logs` VALUES (535, 10, '2022-02-08 08:44:22', '2022-02-08 08:44:22');
INSERT INTO `user_logs` VALUES (536, 14, '2022-02-08 08:51:50', '2022-02-08 08:51:50');
INSERT INTO `user_logs` VALUES (537, 14, '2022-02-08 10:52:58', '2022-02-08 10:52:58');
INSERT INTO `user_logs` VALUES (538, 14, '2022-02-08 14:04:54', '2022-02-08 14:04:54');
INSERT INTO `user_logs` VALUES (539, 10, '2022-02-08 14:21:13', '2022-02-08 14:21:13');
INSERT INTO `user_logs` VALUES (540, 11, '2022-02-08 14:55:37', '2022-02-08 14:55:37');
INSERT INTO `user_logs` VALUES (541, 1, '2022-02-09 07:24:35', '2022-02-09 07:24:35');
INSERT INTO `user_logs` VALUES (542, 11, '2022-02-09 08:35:50', '2022-02-09 08:35:50');
INSERT INTO `user_logs` VALUES (543, 1, '2022-02-09 08:51:13', '2022-02-09 08:51:13');
INSERT INTO `user_logs` VALUES (544, 10, '2022-02-09 11:08:30', '2022-02-09 11:08:30');
INSERT INTO `user_logs` VALUES (545, 14, '2022-02-09 11:56:42', '2022-02-09 11:56:42');
INSERT INTO `user_logs` VALUES (546, 10, '2022-02-09 14:51:49', '2022-02-09 14:51:49');
INSERT INTO `user_logs` VALUES (547, 1, '2022-02-10 07:42:15', '2022-02-10 07:42:15');
INSERT INTO `user_logs` VALUES (548, 1, '2022-02-10 08:12:19', '2022-02-10 08:12:19');
INSERT INTO `user_logs` VALUES (549, 14, '2022-02-10 08:28:25', '2022-02-10 08:28:25');
INSERT INTO `user_logs` VALUES (550, 1, '2022-02-10 08:33:21', '2022-02-10 08:33:21');
INSERT INTO `user_logs` VALUES (551, 11, '2022-02-10 08:46:14', '2022-02-10 08:46:14');
INSERT INTO `user_logs` VALUES (552, 1, '2022-02-10 09:35:54', '2022-02-10 09:35:54');
INSERT INTO `user_logs` VALUES (553, 18, '2022-02-10 09:54:22', '2022-02-10 09:54:22');
INSERT INTO `user_logs` VALUES (554, 13, '2022-02-10 10:23:58', '2022-02-10 10:23:58');
INSERT INTO `user_logs` VALUES (555, 20, '2022-02-10 10:38:41', '2022-02-10 10:38:41');
INSERT INTO `user_logs` VALUES (556, 17, '2022-02-10 11:05:25', '2022-02-10 11:05:25');
INSERT INTO `user_logs` VALUES (557, 20, '2022-02-10 14:56:04', '2022-02-10 14:56:04');
INSERT INTO `user_logs` VALUES (558, 14, '2022-02-10 15:17:29', '2022-02-10 15:17:29');
INSERT INTO `user_logs` VALUES (559, 14, '2022-02-10 15:24:49', '2022-02-10 15:24:49');
INSERT INTO `user_logs` VALUES (560, 1, '2022-02-11 07:39:16', '2022-02-11 07:39:16');
INSERT INTO `user_logs` VALUES (561, 1, '2022-02-11 08:29:57', '2022-02-11 08:29:57');
INSERT INTO `user_logs` VALUES (562, 1, '2022-02-11 08:37:37', '2022-02-11 08:37:37');
INSERT INTO `user_logs` VALUES (563, 11, '2022-02-11 10:08:25', '2022-02-11 10:08:25');
INSERT INTO `user_logs` VALUES (564, 1, '2022-02-11 10:22:03', '2022-02-11 10:22:03');
INSERT INTO `user_logs` VALUES (565, 1, '2022-02-11 10:22:34', '2022-02-11 10:22:34');
INSERT INTO `user_logs` VALUES (566, 14, '2022-02-11 13:45:54', '2022-02-11 13:45:54');
INSERT INTO `user_logs` VALUES (567, 1, '2022-02-11 14:24:14', '2022-02-11 14:24:14');
INSERT INTO `user_logs` VALUES (568, 1, '2022-02-14 07:59:57', '2022-02-14 07:59:57');
INSERT INTO `user_logs` VALUES (569, 1, '2022-02-14 08:25:09', '2022-02-14 08:25:09');
INSERT INTO `user_logs` VALUES (570, 1, '2022-02-14 08:26:58', '2022-02-14 08:26:58');
INSERT INTO `user_logs` VALUES (571, 1, '2022-02-14 09:10:27', '2022-02-14 09:10:27');
INSERT INTO `user_logs` VALUES (572, 9, '2022-02-14 09:12:56', '2022-02-14 09:12:56');
INSERT INTO `user_logs` VALUES (573, 11, '2022-02-14 11:10:25', '2022-02-14 11:10:25');
INSERT INTO `user_logs` VALUES (574, 13, '2022-02-14 12:08:51', '2022-02-14 12:08:51');
INSERT INTO `user_logs` VALUES (575, 14, '2022-02-14 13:29:55', '2022-02-14 13:29:55');
INSERT INTO `user_logs` VALUES (576, 11, '2022-02-14 15:03:30', '2022-02-14 15:03:30');
INSERT INTO `user_logs` VALUES (577, 1, '2022-02-15 08:02:17', '2022-02-15 08:02:17');
INSERT INTO `user_logs` VALUES (578, 1, '2022-02-15 08:28:28', '2022-02-15 08:28:28');
INSERT INTO `user_logs` VALUES (579, 11, '2022-02-15 09:30:29', '2022-02-15 09:30:29');
INSERT INTO `user_logs` VALUES (580, 18, '2022-02-15 09:38:08', '2022-02-15 09:38:08');
INSERT INTO `user_logs` VALUES (581, 1, '2022-02-15 10:09:41', '2022-02-15 10:09:41');
INSERT INTO `user_logs` VALUES (582, 1, '2022-02-15 11:40:32', '2022-02-15 11:40:32');
INSERT INTO `user_logs` VALUES (583, 1, '2022-02-15 12:55:37', '2022-02-15 12:55:37');
INSERT INTO `user_logs` VALUES (584, 1, '2022-02-15 13:13:05', '2022-02-15 13:13:05');
INSERT INTO `user_logs` VALUES (585, 1, '2022-02-16 08:27:15', '2022-02-16 08:27:15');
INSERT INTO `user_logs` VALUES (586, 11, '2022-02-16 08:41:57', '2022-02-16 08:41:57');
INSERT INTO `user_logs` VALUES (587, 1, '2022-02-16 09:27:58', '2022-02-16 09:27:58');
INSERT INTO `user_logs` VALUES (588, 1, '2022-02-16 10:18:52', '2022-02-16 10:18:52');
INSERT INTO `user_logs` VALUES (589, 1, '2022-02-16 11:53:15', '2022-02-16 11:53:15');
INSERT INTO `user_logs` VALUES (590, 1, '2022-02-16 12:02:29', '2022-02-16 12:02:29');
INSERT INTO `user_logs` VALUES (591, 1, '2022-02-16 14:25:13', '2022-02-16 14:25:13');
INSERT INTO `user_logs` VALUES (592, 1, '2022-02-16 15:01:58', '2022-02-16 15:01:58');
INSERT INTO `user_logs` VALUES (593, 11, '2022-02-17 08:35:06', '2022-02-17 08:35:06');
INSERT INTO `user_logs` VALUES (594, 1, '2022-02-17 11:32:41', '2022-02-17 11:32:41');
INSERT INTO `user_logs` VALUES (595, 1, '2022-02-17 12:28:29', '2022-02-17 12:28:29');
INSERT INTO `user_logs` VALUES (596, 1, '2022-02-17 12:31:22', '2022-02-17 12:31:22');
INSERT INTO `user_logs` VALUES (597, 1, '2022-02-17 12:48:51', '2022-02-17 12:48:51');
INSERT INTO `user_logs` VALUES (598, 1, '2022-02-17 13:04:31', '2022-02-17 13:04:31');
INSERT INTO `user_logs` VALUES (599, 1, '2022-02-17 13:15:44', '2022-02-17 13:15:44');
INSERT INTO `user_logs` VALUES (600, 1, '2022-02-17 16:51:40', '2022-02-17 16:51:40');
INSERT INTO `user_logs` VALUES (601, 1, '2022-02-17 16:52:20', '2022-02-17 16:52:20');
INSERT INTO `user_logs` VALUES (602, 1, '2022-02-17 17:00:32', '2022-02-17 17:00:32');
INSERT INTO `user_logs` VALUES (603, 1, '2022-02-17 17:14:00', '2022-02-17 17:14:00');
INSERT INTO `user_logs` VALUES (604, 1, '2022-02-18 07:55:14', '2022-02-18 07:55:14');
INSERT INTO `user_logs` VALUES (605, 1, '2022-02-18 08:51:59', '2022-02-18 08:51:59');
INSERT INTO `user_logs` VALUES (606, 1, '2022-02-18 09:03:11', '2022-02-18 09:03:11');
INSERT INTO `user_logs` VALUES (607, 11, '2022-02-18 09:03:20', '2022-02-18 09:03:20');
INSERT INTO `user_logs` VALUES (608, 1, '2022-02-18 12:58:56', '2022-02-18 12:58:56');
INSERT INTO `user_logs` VALUES (609, 1, '2022-02-18 14:08:46', '2022-02-18 14:08:46');
INSERT INTO `user_logs` VALUES (610, 1, '2022-02-21 09:47:09', '2022-02-21 09:47:09');
INSERT INTO `user_logs` VALUES (611, 1, '2022-02-22 08:02:19', '2022-02-22 08:02:19');
INSERT INTO `user_logs` VALUES (612, 14, '2022-02-22 08:51:13', '2022-02-22 08:51:13');
INSERT INTO `user_logs` VALUES (613, 1, '2022-02-22 10:03:10', '2022-02-22 10:03:10');
INSERT INTO `user_logs` VALUES (614, 1, '2022-02-22 11:04:33', '2022-02-22 11:04:33');
INSERT INTO `user_logs` VALUES (615, 10, '2022-02-22 14:32:53', '2022-02-22 14:32:53');
INSERT INTO `user_logs` VALUES (616, 14, '2022-02-23 08:37:21', '2022-02-23 08:37:21');
INSERT INTO `user_logs` VALUES (617, 20, '2022-02-23 09:42:41', '2022-02-23 09:42:41');
INSERT INTO `user_logs` VALUES (618, 1, '2022-02-23 11:56:48', '2022-02-23 11:56:48');
INSERT INTO `user_logs` VALUES (619, 11, '2022-02-24 10:39:57', '2022-02-24 10:39:57');
INSERT INTO `user_logs` VALUES (620, 1, '2022-02-24 13:46:12', '2022-02-24 13:46:12');
INSERT INTO `user_logs` VALUES (621, 1, '2022-02-25 09:16:23', '2022-02-25 09:16:23');
INSERT INTO `user_logs` VALUES (622, 14, '2022-02-25 11:00:50', '2022-02-25 11:00:50');
INSERT INTO `user_logs` VALUES (623, 14, '2022-03-01 08:41:07', '2022-03-01 08:41:07');
INSERT INTO `user_logs` VALUES (624, 1, '2022-03-01 10:02:02', '2022-03-01 10:02:02');
INSERT INTO `user_logs` VALUES (625, 1, '2022-03-01 13:30:29', '2022-03-01 13:30:29');
INSERT INTO `user_logs` VALUES (626, 14, '2022-03-02 08:49:33', '2022-03-02 08:49:33');
INSERT INTO `user_logs` VALUES (627, 1, '2022-03-02 10:18:00', '2022-03-02 10:18:00');
INSERT INTO `user_logs` VALUES (628, 1, '2022-03-02 10:55:03', '2022-03-02 10:55:03');
INSERT INTO `user_logs` VALUES (629, 1, '2022-03-02 15:41:13', '2022-03-02 15:41:13');
INSERT INTO `user_logs` VALUES (630, 1, '2022-03-04 08:24:42', '2022-03-04 08:24:42');
INSERT INTO `user_logs` VALUES (631, 19, '2022-03-04 08:36:30', '2022-03-04 08:36:30');
INSERT INTO `user_logs` VALUES (632, 1, '2022-03-07 09:00:18', '2022-03-07 09:00:18');
INSERT INTO `user_logs` VALUES (633, 1, '2022-03-07 09:00:36', '2022-03-07 09:00:36');
INSERT INTO `user_logs` VALUES (634, 1, '2022-03-07 09:47:51', '2022-03-07 09:47:51');
INSERT INTO `user_logs` VALUES (635, 1, '2022-03-07 11:02:45', '2022-03-07 11:02:45');
INSERT INTO `user_logs` VALUES (636, 11, '2022-03-08 09:17:33', '2022-03-08 09:17:33');
INSERT INTO `user_logs` VALUES (637, 1, '2022-03-08 09:18:02', '2022-03-08 09:18:02');
INSERT INTO `user_logs` VALUES (638, 19, '2022-03-08 09:28:06', '2022-03-08 09:28:06');
INSERT INTO `user_logs` VALUES (639, 14, '2022-03-08 09:29:40', '2022-03-08 09:29:40');
INSERT INTO `user_logs` VALUES (640, 10, '2022-03-08 11:20:47', '2022-03-08 11:20:47');
INSERT INTO `user_logs` VALUES (641, 1, '2022-03-08 13:39:21', '2022-03-08 13:39:21');
INSERT INTO `user_logs` VALUES (642, 19, '2022-03-08 14:22:15', '2022-03-08 14:22:15');
INSERT INTO `user_logs` VALUES (643, 1, '2022-03-09 07:39:32', '2022-03-09 07:39:32');
INSERT INTO `user_logs` VALUES (644, 19, '2022-03-09 08:41:54', '2022-03-09 08:41:54');
INSERT INTO `user_logs` VALUES (645, 11, '2022-03-09 10:10:48', '2022-03-09 10:10:48');
INSERT INTO `user_logs` VALUES (646, 10, '2022-03-09 11:06:25', '2022-03-09 11:06:25');
INSERT INTO `user_logs` VALUES (647, 1, '2022-03-09 13:28:37', '2022-03-09 13:28:37');
INSERT INTO `user_logs` VALUES (648, 11, '2022-03-10 08:53:30', '2022-03-10 08:53:30');
INSERT INTO `user_logs` VALUES (649, 1, '2022-03-10 09:02:39', '2022-03-10 09:02:39');
INSERT INTO `user_logs` VALUES (650, 1, '2022-03-10 10:08:32', '2022-03-10 10:08:32');
INSERT INTO `user_logs` VALUES (651, 1, '2022-03-10 11:18:31', '2022-03-10 11:18:31');
INSERT INTO `user_logs` VALUES (652, 1, '2022-03-10 11:37:34', '2022-03-10 11:37:34');
INSERT INTO `user_logs` VALUES (653, 14, '2022-03-10 13:23:19', '2022-03-10 13:23:19');
INSERT INTO `user_logs` VALUES (654, 1, '2022-03-13 17:17:34', '2022-03-13 17:17:34');
INSERT INTO `user_logs` VALUES (655, 1, '2022-03-13 17:29:43', '2022-03-13 17:29:43');
INSERT INTO `user_logs` VALUES (656, 19, '2022-03-14 09:04:30', '2022-03-14 09:04:30');
INSERT INTO `user_logs` VALUES (657, 11, '2022-03-14 09:34:31', '2022-03-14 09:34:31');
INSERT INTO `user_logs` VALUES (658, 10, '2022-03-14 12:34:15', '2022-03-14 12:34:15');
INSERT INTO `user_logs` VALUES (659, 19, '2022-03-14 14:15:08', '2022-03-14 14:15:08');
INSERT INTO `user_logs` VALUES (660, 1, '2022-03-15 08:31:41', '2022-03-15 08:31:41');
INSERT INTO `user_logs` VALUES (661, 11, '2022-03-15 09:35:50', '2022-03-15 09:35:50');
INSERT INTO `user_logs` VALUES (662, 20, '2022-03-15 14:05:52', '2022-03-15 14:05:52');
INSERT INTO `user_logs` VALUES (663, 1, '2022-03-15 14:40:45', '2022-03-15 14:40:45');
INSERT INTO `user_logs` VALUES (664, 14, '2022-03-16 09:01:47', '2022-03-16 09:01:47');
INSERT INTO `user_logs` VALUES (665, 1, '2022-03-16 09:15:27', '2022-03-16 09:15:27');
INSERT INTO `user_logs` VALUES (666, 1, '2022-03-16 12:49:10', '2022-03-16 12:49:10');
INSERT INTO `user_logs` VALUES (667, 1, '2022-03-17 08:47:11', '2022-03-17 08:47:11');
INSERT INTO `user_logs` VALUES (668, 1, '2022-03-17 08:56:25', '2022-03-17 08:56:25');
INSERT INTO `user_logs` VALUES (669, 1, '2022-03-17 09:12:43', '2022-03-17 09:12:43');
INSERT INTO `user_logs` VALUES (670, 1, '2022-03-18 10:11:08', '2022-03-18 10:11:08');
INSERT INTO `user_logs` VALUES (671, 1, '2022-03-18 14:53:24', '2022-03-18 14:53:24');
INSERT INTO `user_logs` VALUES (672, 19, '2022-03-18 15:21:09', '2022-03-18 15:21:09');
INSERT INTO `user_logs` VALUES (673, 18, '2022-03-21 07:36:09', '2022-03-21 07:36:09');
INSERT INTO `user_logs` VALUES (674, 18, '2022-03-21 07:44:41', '2022-03-21 07:44:41');
INSERT INTO `user_logs` VALUES (675, 14, '2022-03-21 08:53:23', '2022-03-21 08:53:23');
INSERT INTO `user_logs` VALUES (676, 14, '2022-03-21 08:56:22', '2022-03-21 08:56:22');
INSERT INTO `user_logs` VALUES (677, 18, '2022-03-21 09:39:16', '2022-03-21 09:39:16');
INSERT INTO `user_logs` VALUES (678, 14, '2022-03-21 10:08:00', '2022-03-21 10:08:00');
INSERT INTO `user_logs` VALUES (679, 1, '2022-03-21 10:23:28', '2022-03-21 10:23:28');
INSERT INTO `user_logs` VALUES (680, 1, '2022-03-21 10:48:38', '2022-03-21 10:48:38');
INSERT INTO `user_logs` VALUES (681, 14, '2022-03-21 10:49:04', '2022-03-21 10:49:04');
INSERT INTO `user_logs` VALUES (682, 10, '2022-03-21 12:28:40', '2022-03-21 12:28:40');
INSERT INTO `user_logs` VALUES (683, 19, '2022-03-21 15:35:22', '2022-03-21 15:35:22');
INSERT INTO `user_logs` VALUES (684, 1, '2022-03-23 14:22:53', '2022-03-23 14:22:53');
INSERT INTO `user_logs` VALUES (685, 10, '2022-03-23 15:09:23', '2022-03-23 15:09:23');
INSERT INTO `user_logs` VALUES (686, 1, '2022-03-24 09:34:13', '2022-03-24 09:34:13');
INSERT INTO `user_logs` VALUES (687, 14, '2022-03-24 09:49:42', '2022-03-24 09:49:42');
INSERT INTO `user_logs` VALUES (688, 1, '2022-03-24 10:18:29', '2022-03-24 10:18:29');
INSERT INTO `user_logs` VALUES (689, 19, '2022-03-24 10:23:33', '2022-03-24 10:23:33');
INSERT INTO `user_logs` VALUES (690, 19, '2022-03-24 10:30:36', '2022-03-24 10:30:36');
INSERT INTO `user_logs` VALUES (691, 1, '2022-03-24 11:11:27', '2022-03-24 11:11:27');
INSERT INTO `user_logs` VALUES (692, 1, '2022-03-24 13:32:14', '2022-03-24 13:32:14');
INSERT INTO `user_logs` VALUES (693, 1, '2022-03-24 14:50:45', '2022-03-24 14:50:45');
INSERT INTO `user_logs` VALUES (694, 1, '2022-03-25 09:31:46', '2022-03-25 09:31:46');
INSERT INTO `user_logs` VALUES (695, 1, '2022-03-25 09:34:09', '2022-03-25 09:34:09');
INSERT INTO `user_logs` VALUES (696, 10, '2022-03-25 12:21:49', '2022-03-25 12:21:49');
INSERT INTO `user_logs` VALUES (697, 1, '2022-03-28 08:44:25', '2022-03-28 08:44:25');
INSERT INTO `user_logs` VALUES (698, 1, '2022-03-28 09:03:26', '2022-03-28 09:03:26');
INSERT INTO `user_logs` VALUES (699, 1, '2022-03-28 09:24:38', '2022-03-28 09:24:38');
INSERT INTO `user_logs` VALUES (700, 14, '2022-03-28 10:29:29', '2022-03-28 10:29:29');
INSERT INTO `user_logs` VALUES (701, 1, '2022-03-28 10:50:47', '2022-03-28 10:50:47');
INSERT INTO `user_logs` VALUES (702, 1, '2022-03-29 08:35:16', '2022-03-29 08:35:16');
INSERT INTO `user_logs` VALUES (703, 1, '2022-03-29 08:44:31', '2022-03-29 08:44:31');
INSERT INTO `user_logs` VALUES (704, 1, '2022-03-29 09:22:58', '2022-03-29 09:22:58');
INSERT INTO `user_logs` VALUES (705, 9, '2022-03-29 15:29:59', '2022-03-29 15:29:59');
INSERT INTO `user_logs` VALUES (706, 11, '2022-03-29 15:45:38', '2022-03-29 15:45:38');
INSERT INTO `user_logs` VALUES (707, 19, '2022-03-29 15:48:04', '2022-03-29 15:48:04');
INSERT INTO `user_logs` VALUES (708, 12, '2022-03-29 15:48:35', '2022-03-29 15:48:35');
INSERT INTO `user_logs` VALUES (709, 10, '2022-03-29 15:49:10', '2022-03-29 15:49:10');
INSERT INTO `user_logs` VALUES (710, 14, '2022-03-29 15:49:41', '2022-03-29 15:49:41');
INSERT INTO `user_logs` VALUES (711, 1, '2022-03-30 08:49:41', '2022-03-30 08:49:41');
INSERT INTO `user_logs` VALUES (712, 1, '2022-03-30 09:44:07', '2022-03-30 09:44:07');
INSERT INTO `user_logs` VALUES (713, 1, '2022-03-30 09:50:13', '2022-03-30 09:50:13');
INSERT INTO `user_logs` VALUES (714, 14, '2022-03-30 11:22:29', '2022-03-30 11:22:29');
INSERT INTO `user_logs` VALUES (715, 1, '2022-03-30 13:58:06', '2022-03-30 13:58:06');
INSERT INTO `user_logs` VALUES (716, 1, '2022-03-31 08:51:10', '2022-03-31 08:51:10');
INSERT INTO `user_logs` VALUES (717, 1, '2022-03-31 09:30:23', '2022-03-31 09:30:23');
INSERT INTO `user_logs` VALUES (718, 14, '2022-03-31 10:12:12', '2022-03-31 10:12:12');
INSERT INTO `user_logs` VALUES (719, 11, '2022-04-01 09:10:53', '2022-04-01 09:10:53');
INSERT INTO `user_logs` VALUES (720, 1, '2022-04-01 09:12:51', '2022-04-01 09:12:51');
INSERT INTO `user_logs` VALUES (721, 18, '2022-04-01 09:35:54', '2022-04-01 09:35:54');
INSERT INTO `user_logs` VALUES (722, 11, '2022-04-01 14:14:30', '2022-04-01 14:14:30');
INSERT INTO `user_logs` VALUES (723, 1, '2022-04-04 07:53:53', '2022-04-04 07:53:53');
INSERT INTO `user_logs` VALUES (724, 9, '2022-04-04 08:05:39', '2022-04-04 08:05:39');
INSERT INTO `user_logs` VALUES (725, 9, '2022-04-04 08:34:31', '2022-04-04 08:34:31');
INSERT INTO `user_logs` VALUES (726, 1, '2022-04-05 07:58:44', '2022-04-05 07:58:44');
INSERT INTO `user_logs` VALUES (727, 9, '2022-04-05 08:29:08', '2022-04-05 08:29:08');
INSERT INTO `user_logs` VALUES (728, 1, '2022-04-05 08:44:12', '2022-04-05 08:44:12');
INSERT INTO `user_logs` VALUES (729, 9, '2022-04-05 10:45:42', '2022-04-05 10:45:42');
INSERT INTO `user_logs` VALUES (730, 1, '2022-04-06 09:20:55', '2022-04-06 09:20:55');
INSERT INTO `user_logs` VALUES (731, 1, '2022-04-06 09:25:49', '2022-04-06 09:25:49');
INSERT INTO `user_logs` VALUES (732, 18, '2022-04-06 09:28:07', '2022-04-06 09:28:07');
INSERT INTO `user_logs` VALUES (733, 1, '2022-04-06 10:17:20', '2022-04-06 10:17:20');
INSERT INTO `user_logs` VALUES (734, 19, '2022-04-06 10:28:05', '2022-04-06 10:28:05');
INSERT INTO `user_logs` VALUES (735, 1, '2022-04-07 07:49:22', '2022-04-07 07:49:22');
INSERT INTO `user_logs` VALUES (736, 13, '2022-04-07 07:51:10', '2022-04-07 07:51:10');
INSERT INTO `user_logs` VALUES (737, 1, '2022-04-07 08:20:13', '2022-04-07 08:20:13');
INSERT INTO `user_logs` VALUES (738, 1, '2022-04-07 08:30:34', '2022-04-07 08:30:34');
INSERT INTO `user_logs` VALUES (739, 1, '2022-04-07 08:44:07', '2022-04-07 08:44:07');
INSERT INTO `user_logs` VALUES (740, 10, '2022-04-07 09:13:47', '2022-04-07 09:13:47');
INSERT INTO `user_logs` VALUES (741, 15, '2022-04-07 09:18:36', '2022-04-07 09:18:36');
INSERT INTO `user_logs` VALUES (742, 1, '2022-04-07 09:40:58', '2022-04-07 09:40:58');
INSERT INTO `user_logs` VALUES (743, 1, '2022-04-07 09:51:45', '2022-04-07 09:51:45');
INSERT INTO `user_logs` VALUES (744, 13, '2022-04-07 11:04:13', '2022-04-07 11:04:13');
INSERT INTO `user_logs` VALUES (745, 1, '2022-04-07 11:15:23', '2022-04-07 11:15:23');
INSERT INTO `user_logs` VALUES (746, 1, '2022-04-07 13:50:19', '2022-04-07 13:50:19');
INSERT INTO `user_logs` VALUES (747, 11, '2022-04-07 14:03:53', '2022-04-07 14:03:53');
INSERT INTO `user_logs` VALUES (748, 1, '2022-04-07 14:23:24', '2022-04-07 14:23:24');
INSERT INTO `user_logs` VALUES (749, 15, '2022-04-07 14:24:21', '2022-04-07 14:24:21');
INSERT INTO `user_logs` VALUES (750, 1, '2022-04-07 14:33:41', '2022-04-07 14:33:41');
INSERT INTO `user_logs` VALUES (751, 15, '2022-04-07 14:39:34', '2022-04-07 14:39:34');
INSERT INTO `user_logs` VALUES (752, 1, '2022-04-07 21:30:55', '2022-04-07 21:30:55');
INSERT INTO `user_logs` VALUES (753, 1, '2022-04-08 08:23:39', '2022-04-08 08:23:39');
INSERT INTO `user_logs` VALUES (754, 11, '2022-04-08 08:39:05', '2022-04-08 08:39:05');
INSERT INTO `user_logs` VALUES (755, 13, '2022-04-08 08:40:48', '2022-04-08 08:40:48');
INSERT INTO `user_logs` VALUES (756, 1, '2022-04-08 13:33:35', '2022-04-08 13:33:35');
INSERT INTO `user_logs` VALUES (757, 1, '2022-04-08 13:39:59', '2022-04-08 13:39:59');
INSERT INTO `user_logs` VALUES (758, 1, '2022-04-08 14:09:10', '2022-04-08 14:09:10');
INSERT INTO `user_logs` VALUES (759, 1, '2022-04-11 07:39:32', '2022-04-11 07:39:32');
INSERT INTO `user_logs` VALUES (760, 11, '2022-04-11 07:42:29', '2022-04-11 07:42:29');
INSERT INTO `user_logs` VALUES (761, 1, '2022-04-11 08:49:28', '2022-04-11 08:49:28');
INSERT INTO `user_logs` VALUES (762, 1, '2022-04-11 08:54:07', '2022-04-11 08:54:07');
INSERT INTO `user_logs` VALUES (763, 1, '2022-04-11 09:51:54', '2022-04-11 09:51:54');
INSERT INTO `user_logs` VALUES (764, 1, '2022-04-11 10:02:30', '2022-04-11 10:02:30');
INSERT INTO `user_logs` VALUES (765, 10, '2022-04-11 10:05:24', '2022-04-11 10:05:24');
INSERT INTO `user_logs` VALUES (766, 17, '2022-04-11 10:05:50', '2022-04-11 10:05:50');
INSERT INTO `user_logs` VALUES (767, 10, '2022-04-11 10:08:21', '2022-04-11 10:08:21');
INSERT INTO `user_logs` VALUES (768, 1, '2022-04-11 10:09:05', '2022-04-11 10:09:05');
INSERT INTO `user_logs` VALUES (769, 10, '2022-04-11 10:10:44', '2022-04-11 10:10:44');
INSERT INTO `user_logs` VALUES (770, 1, '2022-04-11 10:13:19', '2022-04-11 10:13:19');
INSERT INTO `user_logs` VALUES (771, 1, '2022-04-11 11:00:05', '2022-04-11 11:00:05');
INSERT INTO `user_logs` VALUES (772, 1, '2022-04-12 08:13:36', '2022-04-12 08:13:36');
INSERT INTO `user_logs` VALUES (773, 1, '2022-04-12 08:15:25', '2022-04-12 08:15:25');
INSERT INTO `user_logs` VALUES (774, 1, '2022-04-12 08:26:52', '2022-04-12 08:26:52');
INSERT INTO `user_logs` VALUES (775, 14, '2022-04-12 08:28:57', '2022-04-12 08:28:57');
INSERT INTO `user_logs` VALUES (776, 1, '2022-04-12 08:40:24', '2022-04-12 08:40:24');
INSERT INTO `user_logs` VALUES (777, 19, '2022-04-12 09:42:47', '2022-04-12 09:42:47');
INSERT INTO `user_logs` VALUES (778, 10, '2022-04-12 10:35:15', '2022-04-12 10:35:15');
INSERT INTO `user_logs` VALUES (779, 1, '2022-04-12 10:36:59', '2022-04-12 10:36:59');
INSERT INTO `user_logs` VALUES (780, 1, '2022-04-12 11:17:58', '2022-04-12 11:17:58');
INSERT INTO `user_logs` VALUES (781, 1, '2022-04-12 11:18:57', '2022-04-12 11:18:57');
INSERT INTO `user_logs` VALUES (782, 1, '2022-04-12 11:28:01', '2022-04-12 11:28:01');
INSERT INTO `user_logs` VALUES (783, 1, '2022-04-12 13:09:51', '2022-04-12 13:09:51');
INSERT INTO `user_logs` VALUES (784, 1, '2022-04-12 14:34:40', '2022-04-12 14:34:40');
INSERT INTO `user_logs` VALUES (785, 1, '2022-04-12 15:48:21', '2022-04-12 15:48:21');
INSERT INTO `user_logs` VALUES (786, 1, '2022-04-12 15:53:17', '2022-04-12 15:53:17');
INSERT INTO `user_logs` VALUES (787, 1, '2022-04-12 15:56:46', '2022-04-12 15:56:46');
INSERT INTO `user_logs` VALUES (788, 1, '2022-04-12 16:02:55', '2022-04-12 16:02:55');
INSERT INTO `user_logs` VALUES (789, 1, '2022-04-13 07:51:57', '2022-04-13 07:51:57');
INSERT INTO `user_logs` VALUES (790, 1, '2022-04-13 08:08:47', '2022-04-13 08:08:47');
INSERT INTO `user_logs` VALUES (791, 19, '2022-04-13 08:33:44', '2022-04-13 08:33:44');
INSERT INTO `user_logs` VALUES (792, 1, '2022-04-13 08:44:28', '2022-04-13 08:44:28');
INSERT INTO `user_logs` VALUES (793, 11, '2022-04-13 08:51:06', '2022-04-13 08:51:06');
INSERT INTO `user_logs` VALUES (794, 15, '2022-04-13 08:55:21', '2022-04-13 08:55:21');
INSERT INTO `user_logs` VALUES (795, 1, '2022-04-13 09:17:25', '2022-04-13 09:17:25');
INSERT INTO `user_logs` VALUES (796, 16, '2022-04-13 09:58:39', '2022-04-13 09:58:39');
INSERT INTO `user_logs` VALUES (797, 14, '2022-04-13 10:14:24', '2022-04-13 10:14:24');
INSERT INTO `user_logs` VALUES (798, 1, '2022-04-13 12:51:52', '2022-04-13 12:51:52');
INSERT INTO `user_logs` VALUES (799, 1, '2022-04-13 13:25:30', '2022-04-13 13:25:30');
INSERT INTO `user_logs` VALUES (800, 1, '2022-04-13 14:08:19', '2022-04-13 14:08:19');
INSERT INTO `user_logs` VALUES (801, 15, '2022-04-13 21:01:44', '2022-04-13 21:01:44');
INSERT INTO `user_logs` VALUES (802, 1, '2022-04-13 21:02:58', '2022-04-13 21:02:58');
INSERT INTO `user_logs` VALUES (803, 12, '2022-04-13 21:03:25', '2022-04-13 21:03:25');
INSERT INTO `user_logs` VALUES (804, 1, '2022-04-13 21:04:11', '2022-04-13 21:04:11');
INSERT INTO `user_logs` VALUES (805, 1, '2022-04-13 21:10:11', '2022-04-13 21:10:11');
INSERT INTO `user_logs` VALUES (806, 15, '2022-04-13 21:13:06', '2022-04-13 21:13:06');
INSERT INTO `user_logs` VALUES (807, 10, '2022-04-14 05:10:17', '2022-04-14 05:10:17');
INSERT INTO `user_logs` VALUES (808, 1, '2022-04-14 05:18:18', '2022-04-14 05:18:18');
INSERT INTO `user_logs` VALUES (809, 10, '2022-04-14 05:18:40', '2022-04-14 05:18:40');
INSERT INTO `user_logs` VALUES (810, 10, '2022-04-14 05:19:06', '2022-04-14 05:19:06');
INSERT INTO `user_logs` VALUES (811, 1, '2022-04-14 05:19:40', '2022-04-14 05:19:40');
INSERT INTO `user_logs` VALUES (812, 1, '2022-04-14 05:20:22', '2022-04-14 05:20:22');
INSERT INTO `user_logs` VALUES (813, 10, '2022-04-14 05:21:09', '2022-04-14 05:21:09');
INSERT INTO `user_logs` VALUES (814, 15, '2022-04-14 05:55:10', '2022-04-14 05:55:10');
INSERT INTO `user_logs` VALUES (815, 1, '2022-04-14 06:55:22', '2022-04-14 06:55:22');
INSERT INTO `user_logs` VALUES (816, 1, '2022-04-14 07:27:30', '2022-04-14 07:27:30');
INSERT INTO `user_logs` VALUES (817, 1, '2022-04-14 07:29:12', '2022-04-14 07:29:12');
INSERT INTO `user_logs` VALUES (818, 1, '2022-04-14 07:46:17', '2022-04-14 07:46:17');
INSERT INTO `user_logs` VALUES (819, 15, '2022-04-14 07:54:59', '2022-04-14 07:54:59');
INSERT INTO `user_logs` VALUES (820, 1, '2022-04-14 08:09:03', '2022-04-14 08:09:03');
INSERT INTO `user_logs` VALUES (821, 1, '2022-04-14 08:11:58', '2022-04-14 08:11:58');
INSERT INTO `user_logs` VALUES (822, 9, '2022-04-14 08:20:46', '2022-04-14 08:20:46');
INSERT INTO `user_logs` VALUES (823, 1, '2022-04-14 09:02:16', '2022-04-14 09:02:16');
INSERT INTO `user_logs` VALUES (824, 1, '2022-04-14 09:25:07', '2022-04-14 09:25:07');
INSERT INTO `user_logs` VALUES (825, 1, '2022-04-14 09:29:05', '2022-04-14 09:29:05');
INSERT INTO `user_logs` VALUES (826, 16, '2022-04-14 10:29:32', '2022-04-14 10:29:32');
INSERT INTO `user_logs` VALUES (827, 12, '2022-04-14 11:39:36', '2022-04-14 11:39:36');
INSERT INTO `user_logs` VALUES (828, 1, '2022-04-14 13:20:28', '2022-04-14 13:20:28');
INSERT INTO `user_logs` VALUES (829, 1, '2022-04-14 13:23:58', '2022-04-14 13:23:58');
INSERT INTO `user_logs` VALUES (830, 1, '2022-04-14 13:27:00', '2022-04-14 13:27:00');
INSERT INTO `user_logs` VALUES (831, 19, '2022-04-14 13:45:20', '2022-04-14 13:45:20');
INSERT INTO `user_logs` VALUES (832, 1, '2022-04-14 13:46:05', '2022-04-14 13:46:05');
INSERT INTO `user_logs` VALUES (833, 19, '2022-04-14 13:46:46', '2022-04-14 13:46:46');
INSERT INTO `user_logs` VALUES (834, 1, '2022-04-14 13:48:44', '2022-04-14 13:48:44');
INSERT INTO `user_logs` VALUES (835, 12, '2022-04-14 13:56:52', '2022-04-14 13:56:52');
INSERT INTO `user_logs` VALUES (836, 1, '2022-04-14 13:58:30', '2022-04-14 13:58:30');
INSERT INTO `user_logs` VALUES (837, 1, '2022-04-14 14:07:35', '2022-04-14 14:07:35');
INSERT INTO `user_logs` VALUES (838, 1, '2022-04-14 17:30:16', '2022-04-14 17:30:16');
INSERT INTO `user_logs` VALUES (839, 1, '2022-04-15 14:16:49', '2022-04-15 14:16:49');
INSERT INTO `user_logs` VALUES (840, 1, '2022-04-15 22:15:06', '2022-04-15 22:15:06');
INSERT INTO `user_logs` VALUES (841, 1, '2022-04-16 22:43:24', '2022-04-16 22:43:24');
INSERT INTO `user_logs` VALUES (842, 1, '2022-04-16 22:44:28', '2022-04-16 22:44:28');
INSERT INTO `user_logs` VALUES (843, 1, '2022-04-17 03:40:08', '2022-04-17 03:40:08');
INSERT INTO `user_logs` VALUES (844, 1, '2022-04-17 16:05:34', '2022-04-17 16:05:34');
INSERT INTO `user_logs` VALUES (845, 1, '2022-04-18 07:31:13', '2022-04-18 07:31:13');
INSERT INTO `user_logs` VALUES (846, 1, '2022-04-18 07:36:24', '2022-04-18 07:36:24');
INSERT INTO `user_logs` VALUES (847, 1, '2022-04-18 07:36:40', '2022-04-18 07:36:40');
INSERT INTO `user_logs` VALUES (848, 1, '2022-04-18 07:58:16', '2022-04-18 07:58:16');
INSERT INTO `user_logs` VALUES (849, 1, '2022-04-18 08:46:40', '2022-04-18 08:46:40');
INSERT INTO `user_logs` VALUES (850, 11, '2022-04-18 09:06:34', '2022-04-18 09:06:34');
INSERT INTO `user_logs` VALUES (851, 9, '2022-04-18 09:23:52', '2022-04-18 09:23:52');
INSERT INTO `user_logs` VALUES (852, 9, '2022-04-18 10:26:51', '2022-04-18 10:26:51');
INSERT INTO `user_logs` VALUES (853, 10, '2022-04-18 10:29:04', '2022-04-18 10:29:04');
INSERT INTO `user_logs` VALUES (854, 18, '2022-04-18 11:47:43', '2022-04-18 11:47:43');
INSERT INTO `user_logs` VALUES (855, 18, '2022-04-18 11:58:33', '2022-04-18 11:58:33');
INSERT INTO `user_logs` VALUES (856, 18, '2022-04-18 13:42:30', '2022-04-18 13:42:30');
INSERT INTO `user_logs` VALUES (857, 1, '2022-04-18 14:15:47', '2022-04-18 14:15:47');
INSERT INTO `user_logs` VALUES (858, 1, '2022-04-19 07:22:40', '2022-04-19 07:22:40');
INSERT INTO `user_logs` VALUES (859, 1, '2022-04-19 07:42:48', '2022-04-19 07:42:48');
INSERT INTO `user_logs` VALUES (860, 1, '2022-04-19 08:09:15', '2022-04-19 08:09:15');
INSERT INTO `user_logs` VALUES (861, 1, '2022-04-19 08:11:04', '2022-04-19 08:11:04');
INSERT INTO `user_logs` VALUES (862, 1, '2022-04-19 08:23:00', '2022-04-19 08:23:00');
INSERT INTO `user_logs` VALUES (863, 9, '2022-04-19 08:35:50', '2022-04-19 08:35:50');
INSERT INTO `user_logs` VALUES (864, 1, '2022-04-19 09:02:44', '2022-04-19 09:02:44');
INSERT INTO `user_logs` VALUES (865, 17, '2022-04-19 09:04:43', '2022-04-19 09:04:43');
INSERT INTO `user_logs` VALUES (866, 9, '2022-04-19 10:42:56', '2022-04-19 10:42:56');
INSERT INTO `user_logs` VALUES (867, 1, '2022-04-20 07:55:14', '2022-04-20 07:55:14');
INSERT INTO `user_logs` VALUES (868, 9, '2022-04-20 09:21:18', '2022-04-20 09:21:18');
INSERT INTO `user_logs` VALUES (869, 19, '2022-04-21 11:19:59', '2022-04-21 11:19:59');
INSERT INTO `user_logs` VALUES (870, 1, '2022-04-21 11:29:09', '2022-04-21 11:29:09');
INSERT INTO `user_logs` VALUES (871, 19, '2022-04-21 11:39:34', '2022-04-21 11:39:34');
INSERT INTO `user_logs` VALUES (872, 1, '2022-04-21 22:25:24', '2022-04-21 22:25:24');
INSERT INTO `user_logs` VALUES (873, 1, '2022-04-22 06:55:08', '2022-04-22 06:55:08');
INSERT INTO `user_logs` VALUES (874, 19, '2022-04-22 07:31:01', '2022-04-22 07:31:01');
INSERT INTO `user_logs` VALUES (875, 1, '2022-04-22 08:06:29', '2022-04-22 08:06:29');
INSERT INTO `user_logs` VALUES (876, 16, '2022-04-22 10:09:47', '2022-04-22 10:09:47');
INSERT INTO `user_logs` VALUES (877, 1, '2022-04-22 10:52:58', '2022-04-22 10:52:58');
INSERT INTO `user_logs` VALUES (878, 9, '2022-04-25 08:19:21', '2022-04-25 08:19:21');
INSERT INTO `user_logs` VALUES (879, 1, '2022-04-25 08:48:35', '2022-04-25 08:48:35');
INSERT INTO `user_logs` VALUES (880, 1, '2022-04-25 09:25:11', '2022-04-25 09:25:11');
INSERT INTO `user_logs` VALUES (881, 1, '2022-04-25 09:26:31', '2022-04-25 09:26:31');
INSERT INTO `user_logs` VALUES (882, 18, '2022-04-25 09:31:40', '2022-04-25 09:31:40');
INSERT INTO `user_logs` VALUES (883, 16, '2022-04-25 10:43:28', '2022-04-25 10:43:28');
INSERT INTO `user_logs` VALUES (884, 1, '2022-04-25 10:46:28', '2022-04-25 10:46:28');
INSERT INTO `user_logs` VALUES (885, 16, '2022-04-25 11:28:52', '2022-04-25 11:28:52');
INSERT INTO `user_logs` VALUES (886, 1, '2022-04-25 12:51:01', '2022-04-25 12:51:01');
INSERT INTO `user_logs` VALUES (887, 9, '2022-04-26 08:34:05', '2022-04-26 08:34:05');
INSERT INTO `user_logs` VALUES (888, 9, '2022-04-26 08:40:40', '2022-04-26 08:40:40');
INSERT INTO `user_logs` VALUES (889, 16, '2022-04-26 11:06:25', '2022-04-26 11:06:25');
INSERT INTO `user_logs` VALUES (890, 10, '2022-04-26 11:10:28', '2022-04-26 11:10:28');
INSERT INTO `user_logs` VALUES (891, 1, '2022-04-26 11:10:42', '2022-04-26 11:10:42');
INSERT INTO `user_logs` VALUES (892, 1, '2022-04-27 08:05:27', '2022-04-27 08:05:27');
INSERT INTO `user_logs` VALUES (893, 1, '2022-04-27 08:37:38', '2022-04-27 08:37:38');
INSERT INTO `user_logs` VALUES (894, 18, '2022-04-27 10:46:38', '2022-04-27 10:46:38');
INSERT INTO `user_logs` VALUES (895, 18, '2022-04-27 12:11:13', '2022-04-27 12:11:13');
INSERT INTO `user_logs` VALUES (896, 18, '2022-04-27 12:36:04', '2022-04-27 12:36:04');
INSERT INTO `user_logs` VALUES (897, 18, '2022-04-27 12:55:52', '2022-04-27 12:55:52');
INSERT INTO `user_logs` VALUES (898, 14, '2022-04-28 09:31:23', '2022-04-28 09:31:23');
INSERT INTO `user_logs` VALUES (899, 1, '2022-05-09 07:43:43', '2022-05-09 07:43:43');
INSERT INTO `user_logs` VALUES (900, 1, '2022-05-09 07:48:04', '2022-05-09 07:48:04');
INSERT INTO `user_logs` VALUES (901, 1, '2022-05-09 08:42:55', '2022-05-09 08:42:55');
INSERT INTO `user_logs` VALUES (902, 1, '2022-05-09 13:39:00', '2022-05-09 13:39:00');
INSERT INTO `user_logs` VALUES (903, 1, '2022-05-10 07:42:16', '2022-05-10 07:42:16');
INSERT INTO `user_logs` VALUES (904, 1, '2022-05-10 08:21:33', '2022-05-10 08:21:33');
INSERT INTO `user_logs` VALUES (905, 1, '2022-05-10 08:32:19', '2022-05-10 08:32:19');
INSERT INTO `user_logs` VALUES (906, 1, '2022-05-10 08:36:24', '2022-05-10 08:36:24');
INSERT INTO `user_logs` VALUES (907, 16, '2022-05-10 09:38:37', '2022-05-10 09:38:37');
INSERT INTO `user_logs` VALUES (908, 19, '2022-05-10 09:55:38', '2022-05-10 09:55:38');
INSERT INTO `user_logs` VALUES (909, 1, '2022-05-10 10:55:43', '2022-05-10 10:55:43');
INSERT INTO `user_logs` VALUES (910, 1, '2022-05-10 12:35:14', '2022-05-10 12:35:14');
INSERT INTO `user_logs` VALUES (911, 19, '2022-05-10 13:47:07', '2022-05-10 13:47:07');
INSERT INTO `user_logs` VALUES (912, 19, '2022-05-10 14:30:27', '2022-05-10 14:30:27');
INSERT INTO `user_logs` VALUES (913, 1, '2022-05-10 15:37:34', '2022-05-10 15:37:34');
INSERT INTO `user_logs` VALUES (914, 1, '2022-05-10 19:52:58', '2022-05-10 19:52:58');
INSERT INTO `user_logs` VALUES (915, 1, '2022-05-11 07:45:27', '2022-05-11 07:45:27');
INSERT INTO `user_logs` VALUES (916, 19, '2022-05-11 09:42:08', '2022-05-11 09:42:08');
INSERT INTO `user_logs` VALUES (917, 19, '2022-05-11 13:49:52', '2022-05-11 13:49:52');
INSERT INTO `user_logs` VALUES (918, 19, '2022-05-12 07:55:13', '2022-05-12 07:55:13');
INSERT INTO `user_logs` VALUES (919, 1, '2022-05-12 08:55:07', '2022-05-12 08:55:07');
INSERT INTO `user_logs` VALUES (920, 19, '2022-05-12 08:57:57', '2022-05-12 08:57:57');
INSERT INTO `user_logs` VALUES (921, 1, '2022-05-12 08:58:36', '2022-05-12 08:58:36');
INSERT INTO `user_logs` VALUES (922, 19, '2022-05-12 08:59:42', '2022-05-12 08:59:42');
INSERT INTO `user_logs` VALUES (923, 19, '2022-05-12 09:03:24', '2022-05-12 09:03:24');
INSERT INTO `user_logs` VALUES (924, 1, '2022-05-12 09:41:55', '2022-05-12 09:41:55');
INSERT INTO `user_logs` VALUES (925, 19, '2022-05-12 11:57:23', '2022-05-12 11:57:23');
INSERT INTO `user_logs` VALUES (926, 1, '2022-05-17 07:41:06', '2022-05-17 07:41:06');
INSERT INTO `user_logs` VALUES (927, 9, '2022-05-17 08:03:48', '2022-05-17 08:03:48');
INSERT INTO `user_logs` VALUES (928, 1, '2022-05-17 08:44:15', '2022-05-17 08:44:15');
INSERT INTO `user_logs` VALUES (929, 1, '2022-05-17 08:44:40', '2022-05-17 08:44:40');
INSERT INTO `user_logs` VALUES (930, 9, '2022-05-17 08:59:53', '2022-05-17 08:59:53');
INSERT INTO `user_logs` VALUES (931, 19, '2022-05-17 09:02:47', '2022-05-17 09:02:47');
INSERT INTO `user_logs` VALUES (932, 1, '2022-05-17 09:05:31', '2022-05-17 09:05:31');
INSERT INTO `user_logs` VALUES (933, 19, '2022-05-17 09:12:56', '2022-05-17 09:12:56');
INSERT INTO `user_logs` VALUES (934, 1, '2022-05-17 09:16:15', '2022-05-17 09:16:15');
INSERT INTO `user_logs` VALUES (935, 1, '2022-05-17 09:20:15', '2022-05-17 09:20:15');
INSERT INTO `user_logs` VALUES (936, 1, '2022-05-17 09:21:00', '2022-05-17 09:21:00');
INSERT INTO `user_logs` VALUES (937, 19, '2022-05-17 09:23:15', '2022-05-17 09:23:15');
INSERT INTO `user_logs` VALUES (938, 1, '2022-05-17 09:23:38', '2022-05-17 09:23:38');
INSERT INTO `user_logs` VALUES (939, 13, '2022-05-17 09:27:12', '2022-05-17 09:27:12');
INSERT INTO `user_logs` VALUES (940, 1, '2022-05-17 09:28:42', '2022-05-17 09:28:42');
INSERT INTO `user_logs` VALUES (941, 1, '2022-05-17 09:28:45', '2022-05-17 09:28:45');
INSERT INTO `user_logs` VALUES (942, 18, '2022-05-17 09:38:38', '2022-05-17 09:38:38');
INSERT INTO `user_logs` VALUES (943, 9, '2022-05-17 09:41:32', '2022-05-17 09:41:32');
INSERT INTO `user_logs` VALUES (944, 19, '2022-05-17 09:58:33', '2022-05-17 09:58:33');
INSERT INTO `user_logs` VALUES (945, 1, '2022-05-17 10:01:27', '2022-05-17 10:01:27');
INSERT INTO `user_logs` VALUES (946, 19, '2022-05-17 10:20:08', '2022-05-17 10:20:08');
INSERT INTO `user_logs` VALUES (947, 1, '2022-05-17 10:22:32', '2022-05-17 10:22:32');
INSERT INTO `user_logs` VALUES (948, 9, '2022-05-17 10:34:23', '2022-05-17 10:34:23');
INSERT INTO `user_logs` VALUES (949, 19, '2022-05-17 10:47:07', '2022-05-17 10:47:07');
INSERT INTO `user_logs` VALUES (950, 1, '2022-05-17 10:50:22', '2022-05-17 10:50:22');
INSERT INTO `user_logs` VALUES (951, 19, '2022-05-17 12:04:32', '2022-05-17 12:04:32');
INSERT INTO `user_logs` VALUES (952, 19, '2022-05-17 15:41:55', '2022-05-17 15:41:55');
INSERT INTO `user_logs` VALUES (953, 1, '2022-05-17 16:00:02', '2022-05-17 16:00:02');
INSERT INTO `user_logs` VALUES (954, 16, '2022-05-18 07:56:48', '2022-05-18 07:56:48');
INSERT INTO `user_logs` VALUES (955, 1, '2022-05-18 08:57:04', '2022-05-18 08:57:04');
INSERT INTO `user_logs` VALUES (956, 17, '2022-05-18 09:56:57', '2022-05-18 09:56:57');
INSERT INTO `user_logs` VALUES (957, 13, '2022-05-18 09:57:18', '2022-05-18 09:57:18');
INSERT INTO `user_logs` VALUES (958, 19, '2022-05-18 10:17:05', '2022-05-18 10:17:05');
INSERT INTO `user_logs` VALUES (959, 10, '2022-05-18 10:24:31', '2022-05-18 10:24:31');
INSERT INTO `user_logs` VALUES (960, 9, '2022-05-18 11:40:18', '2022-05-18 11:40:18');
INSERT INTO `user_logs` VALUES (961, 18, '2022-05-18 13:27:33', '2022-05-18 13:27:33');
INSERT INTO `user_logs` VALUES (962, 9, '2022-05-18 13:30:23', '2022-05-18 13:30:23');
INSERT INTO `user_logs` VALUES (963, 20, '2022-05-18 14:16:59', '2022-05-18 14:16:59');
INSERT INTO `user_logs` VALUES (964, 13, '2022-05-18 15:29:36', '2022-05-18 15:29:36');
INSERT INTO `user_logs` VALUES (965, 9, '2022-05-19 07:37:53', '2022-05-19 07:37:53');
INSERT INTO `user_logs` VALUES (966, 1, '2022-05-19 08:13:43', '2022-05-19 08:13:43');
INSERT INTO `user_logs` VALUES (967, 1, '2022-05-19 08:34:08', '2022-05-19 08:34:08');
INSERT INTO `user_logs` VALUES (968, 19, '2022-05-19 09:54:30', '2022-05-19 09:54:30');
INSERT INTO `user_logs` VALUES (969, 10, '2022-05-19 10:15:22', '2022-05-19 10:15:22');
INSERT INTO `user_logs` VALUES (970, 1, '2022-05-19 11:47:24', '2022-05-19 11:47:24');
INSERT INTO `user_logs` VALUES (971, 9, '2022-05-20 08:07:35', '2022-05-20 08:07:35');
INSERT INTO `user_logs` VALUES (972, 17, '2022-05-20 08:18:21', '2022-05-20 08:18:21');
INSERT INTO `user_logs` VALUES (973, 1, '2022-05-20 09:21:29', '2022-05-20 09:21:29');
INSERT INTO `user_logs` VALUES (974, 1, '2022-05-20 09:21:41', '2022-05-20 09:21:41');
INSERT INTO `user_logs` VALUES (975, 19, '2022-05-20 09:43:15', '2022-05-20 09:43:15');
INSERT INTO `user_logs` VALUES (976, 18, '2022-05-20 12:52:53', '2022-05-20 12:52:53');
INSERT INTO `user_logs` VALUES (977, 1, '2022-05-23 07:52:00', '2022-05-23 07:52:00');
INSERT INTO `user_logs` VALUES (978, 1, '2022-05-23 07:57:32', '2022-05-23 07:57:32');
INSERT INTO `user_logs` VALUES (979, 17, '2022-05-23 08:06:32', '2022-05-23 08:06:32');
INSERT INTO `user_logs` VALUES (980, 18, '2022-05-23 08:40:51', '2022-05-23 08:40:51');
INSERT INTO `user_logs` VALUES (981, 18, '2022-05-23 09:13:30', '2022-05-23 09:13:30');
INSERT INTO `user_logs` VALUES (982, 14, '2022-05-23 09:20:18', '2022-05-23 09:20:18');
INSERT INTO `user_logs` VALUES (983, 19, '2022-05-23 09:27:45', '2022-05-23 09:27:45');
INSERT INTO `user_logs` VALUES (984, 1, '2022-05-23 09:44:13', '2022-05-23 09:44:13');
INSERT INTO `user_logs` VALUES (985, 9, '2022-05-23 10:47:39', '2022-05-23 10:47:39');
INSERT INTO `user_logs` VALUES (986, 1, '2022-05-23 13:32:49', '2022-05-23 13:32:49');
INSERT INTO `user_logs` VALUES (987, 19, '2022-05-24 07:43:11', '2022-05-24 07:43:11');
INSERT INTO `user_logs` VALUES (988, 1, '2022-05-24 07:45:00', '2022-05-24 07:45:00');
INSERT INTO `user_logs` VALUES (989, 17, '2022-05-24 08:22:58', '2022-05-24 08:22:58');
INSERT INTO `user_logs` VALUES (990, 17, '2022-05-24 08:34:13', '2022-05-24 08:34:13');
INSERT INTO `user_logs` VALUES (991, 9, '2022-05-24 08:36:13', '2022-05-24 08:36:13');
INSERT INTO `user_logs` VALUES (992, 1, '2022-05-24 08:41:28', '2022-05-24 08:41:28');
INSERT INTO `user_logs` VALUES (993, 1, '2022-05-24 09:01:29', '2022-05-24 09:01:29');
INSERT INTO `user_logs` VALUES (994, 18, '2022-05-24 09:53:44', '2022-05-24 09:53:44');
INSERT INTO `user_logs` VALUES (995, 18, '2022-05-24 10:05:10', '2022-05-24 10:05:10');
INSERT INTO `user_logs` VALUES (996, 1, '2022-05-24 10:58:01', '2022-05-24 10:58:01');
INSERT INTO `user_logs` VALUES (997, 10, '2022-05-24 11:10:56', '2022-05-24 11:10:56');
INSERT INTO `user_logs` VALUES (998, 9, '2022-05-24 14:06:31', '2022-05-24 14:06:31');
INSERT INTO `user_logs` VALUES (999, 1, '2022-05-24 14:20:56', '2022-05-24 14:20:56');
INSERT INTO `user_logs` VALUES (1000, 18, '2022-05-24 14:23:43', '2022-05-24 14:23:43');
INSERT INTO `user_logs` VALUES (1001, 1, '2022-05-24 14:47:15', '2022-05-24 14:47:15');
INSERT INTO `user_logs` VALUES (1002, 18, '2022-05-24 15:08:38', '2022-05-24 15:08:38');
INSERT INTO `user_logs` VALUES (1003, 1, '2022-05-25 08:23:54', '2022-05-25 08:23:54');
INSERT INTO `user_logs` VALUES (1004, 18, '2022-05-25 09:50:37', '2022-05-25 09:50:37');
INSERT INTO `user_logs` VALUES (1005, 1, '2022-05-25 10:13:52', '2022-05-25 10:13:52');
INSERT INTO `user_logs` VALUES (1006, 1, '2022-05-25 10:17:39', '2022-05-25 10:17:39');
INSERT INTO `user_logs` VALUES (1007, 1, '2022-05-25 10:24:35', '2022-05-25 10:24:35');
INSERT INTO `user_logs` VALUES (1008, 18, '2022-05-25 12:19:38', '2022-05-25 12:19:38');
INSERT INTO `user_logs` VALUES (1009, 1, '2022-05-25 14:11:45', '2022-05-25 14:11:45');
INSERT INTO `user_logs` VALUES (1010, 9, '2022-05-27 08:31:32', '2022-05-27 08:31:32');
INSERT INTO `user_logs` VALUES (1011, 18, '2022-05-27 09:42:41', '2022-05-27 09:42:41');
INSERT INTO `user_logs` VALUES (1012, 9, '2022-05-27 10:18:20', '2022-05-27 10:18:20');
INSERT INTO `user_logs` VALUES (1013, 9, '2022-05-30 08:13:23', '2022-05-30 08:13:23');
INSERT INTO `user_logs` VALUES (1014, 1, '2022-05-30 08:54:38', '2022-05-30 08:54:38');
INSERT INTO `user_logs` VALUES (1015, 9, '2022-05-30 09:13:31', '2022-05-30 09:13:31');
INSERT INTO `user_logs` VALUES (1016, 1, '2022-05-30 09:48:16', '2022-05-30 09:48:16');
INSERT INTO `user_logs` VALUES (1017, 18, '2022-05-30 11:27:20', '2022-05-30 11:27:20');
INSERT INTO `user_logs` VALUES (1018, 1, '2022-05-30 13:32:29', '2022-05-30 13:32:29');
INSERT INTO `user_logs` VALUES (1019, 9, '2022-05-30 13:58:46', '2022-05-30 13:58:46');
INSERT INTO `user_logs` VALUES (1020, 1, '2022-05-30 14:01:29', '2022-05-30 14:01:29');
INSERT INTO `user_logs` VALUES (1021, 1, '2022-05-30 14:20:36', '2022-05-30 14:20:36');
INSERT INTO `user_logs` VALUES (1022, 1, '2022-05-30 14:22:32', '2022-05-30 14:22:32');
INSERT INTO `user_logs` VALUES (1023, 1, '2022-05-31 07:31:59', '2022-05-31 07:31:59');
INSERT INTO `user_logs` VALUES (1024, 1, '2022-05-31 08:11:55', '2022-05-31 08:11:55');
INSERT INTO `user_logs` VALUES (1025, 1, '2022-05-31 08:13:26', '2022-05-31 08:13:26');
INSERT INTO `user_logs` VALUES (1026, 1, '2022-05-31 08:29:31', '2022-05-31 08:29:31');
INSERT INTO `user_logs` VALUES (1027, 9, '2022-05-31 08:58:00', '2022-05-31 08:58:00');
INSERT INTO `user_logs` VALUES (1028, 9, '2022-05-31 08:58:19', '2022-05-31 08:58:19');
INSERT INTO `user_logs` VALUES (1029, 18, '2022-05-31 09:07:54', '2022-05-31 09:07:54');
INSERT INTO `user_logs` VALUES (1030, 18, '2022-05-31 09:10:45', '2022-05-31 09:10:45');
INSERT INTO `user_logs` VALUES (1031, 18, '2022-05-31 09:35:48', '2022-05-31 09:35:48');
INSERT INTO `user_logs` VALUES (1032, 18, '2022-05-31 09:58:18', '2022-05-31 09:58:18');
INSERT INTO `user_logs` VALUES (1033, 1, '2022-05-31 10:05:27', '2022-05-31 10:05:27');
INSERT INTO `user_logs` VALUES (1034, 18, '2022-05-31 10:06:57', '2022-05-31 10:06:57');
INSERT INTO `user_logs` VALUES (1035, 18, '2022-05-31 10:34:53', '2022-05-31 10:34:53');
INSERT INTO `user_logs` VALUES (1036, 1, '2022-05-31 10:47:25', '2022-05-31 10:47:25');
INSERT INTO `user_logs` VALUES (1037, 1, '2022-05-31 10:53:03', '2022-05-31 10:53:03');
INSERT INTO `user_logs` VALUES (1038, 18, '2022-05-31 11:00:38', '2022-05-31 11:00:38');
INSERT INTO `user_logs` VALUES (1039, 1, '2022-05-31 13:45:30', '2022-05-31 13:45:30');
INSERT INTO `user_logs` VALUES (1040, 18, '2022-05-31 13:56:53', '2022-05-31 13:56:53');
INSERT INTO `user_logs` VALUES (1041, 18, '2022-05-31 14:15:43', '2022-05-31 14:15:43');
INSERT INTO `user_logs` VALUES (1042, 18, '2022-05-31 14:16:08', '2022-05-31 14:16:08');
INSERT INTO `user_logs` VALUES (1043, 1, '2022-05-31 14:21:42', '2022-05-31 14:21:42');
INSERT INTO `user_logs` VALUES (1044, 1, '2022-05-31 14:48:12', '2022-05-31 14:48:12');
INSERT INTO `user_logs` VALUES (1045, 1, '2022-05-31 19:56:27', '2022-05-31 19:56:27');
INSERT INTO `user_logs` VALUES (1046, 1, '2022-06-02 07:55:32', '2022-06-02 07:55:32');
INSERT INTO `user_logs` VALUES (1047, 1, '2022-06-02 08:10:15', '2022-06-02 08:10:15');
INSERT INTO `user_logs` VALUES (1048, 1, '2022-06-02 08:12:04', '2022-06-02 08:12:04');
INSERT INTO `user_logs` VALUES (1049, 1, '2022-06-02 10:16:31', '2022-06-02 10:16:31');
INSERT INTO `user_logs` VALUES (1050, 1, '2022-06-02 11:49:11', '2022-06-02 11:49:11');
INSERT INTO `user_logs` VALUES (1051, 18, '2022-06-02 13:58:36', '2022-06-02 13:58:36');
INSERT INTO `user_logs` VALUES (1052, 1, '2022-06-02 14:15:58', '2022-06-02 14:15:58');
INSERT INTO `user_logs` VALUES (1053, 18, '2022-06-02 14:31:51', '2022-06-02 14:31:51');
INSERT INTO `user_logs` VALUES (1054, 18, '2022-06-02 14:50:44', '2022-06-02 14:50:44');
INSERT INTO `user_logs` VALUES (1055, 1, '2022-06-03 07:51:30', '2022-06-03 07:51:30');
INSERT INTO `user_logs` VALUES (1056, 18, '2022-06-03 08:06:15', '2022-06-03 08:06:15');
INSERT INTO `user_logs` VALUES (1057, 1, '2022-06-03 08:32:50', '2022-06-03 08:32:50');
INSERT INTO `user_logs` VALUES (1058, 1, '2022-06-03 08:39:37', '2022-06-03 08:39:37');
INSERT INTO `user_logs` VALUES (1059, 1, '2022-06-03 09:36:07', '2022-06-03 09:36:07');
INSERT INTO `user_logs` VALUES (1060, 18, '2022-06-03 09:52:50', '2022-06-03 09:52:50');
INSERT INTO `user_logs` VALUES (1061, 18, '2022-06-03 10:22:39', '2022-06-03 10:22:39');
INSERT INTO `user_logs` VALUES (1062, 18, '2022-06-03 13:23:05', '2022-06-03 13:23:05');
INSERT INTO `user_logs` VALUES (1063, 18, '2022-06-03 13:23:22', '2022-06-03 13:23:22');
INSERT INTO `user_logs` VALUES (1064, 1, '2022-06-03 14:31:04', '2022-06-03 14:31:04');
INSERT INTO `user_logs` VALUES (1065, 1, '2022-06-03 14:33:33', '2022-06-03 14:33:33');
INSERT INTO `user_logs` VALUES (1066, 1, '2022-06-03 14:39:51', '2022-06-03 14:39:51');
INSERT INTO `user_logs` VALUES (1067, 1, '2022-06-03 14:45:33', '2022-06-03 14:45:33');
INSERT INTO `user_logs` VALUES (1068, 1, '2022-06-03 15:18:05', '2022-06-03 15:18:05');
INSERT INTO `user_logs` VALUES (1069, 1, '2022-06-03 15:22:43', '2022-06-03 15:22:43');
INSERT INTO `user_logs` VALUES (1070, 17, '2022-06-03 15:31:06', '2022-06-03 15:31:06');
INSERT INTO `user_logs` VALUES (1071, 16, '2022-06-03 15:31:47', '2022-06-03 15:31:47');
INSERT INTO `user_logs` VALUES (1072, 1, '2022-06-06 07:26:59', '2022-06-06 07:26:59');
INSERT INTO `user_logs` VALUES (1073, 1, '2022-06-06 07:46:14', '2022-06-06 07:46:14');
INSERT INTO `user_logs` VALUES (1074, 9, '2022-06-06 07:49:47', '2022-06-06 07:49:47');
INSERT INTO `user_logs` VALUES (1075, 1, '2022-06-06 07:59:48', '2022-06-06 07:59:48');
INSERT INTO `user_logs` VALUES (1076, 16, '2022-06-06 08:19:01', '2022-06-06 08:19:01');
INSERT INTO `user_logs` VALUES (1077, 18, '2022-06-06 09:11:36', '2022-06-06 09:11:36');
INSERT INTO `user_logs` VALUES (1078, 1, '2022-06-06 10:03:38', '2022-06-06 10:03:38');
INSERT INTO `user_logs` VALUES (1079, 1, '2022-06-06 11:10:11', '2022-06-06 11:10:11');
INSERT INTO `user_logs` VALUES (1080, 1, '2022-06-06 11:56:47', '2022-06-06 11:56:47');
INSERT INTO `user_logs` VALUES (1081, 18, '2022-06-06 13:23:20', '2022-06-06 13:23:20');
INSERT INTO `user_logs` VALUES (1082, 1, '2022-06-06 14:31:47', '2022-06-06 14:31:47');
INSERT INTO `user_logs` VALUES (1083, 1, '2022-06-07 07:45:38', '2022-06-07 07:45:38');
INSERT INTO `user_logs` VALUES (1084, 1, '2022-06-07 07:53:09', '2022-06-07 07:53:09');
INSERT INTO `user_logs` VALUES (1085, 1, '2022-06-07 08:15:26', '2022-06-07 08:15:26');
INSERT INTO `user_logs` VALUES (1086, 1, '2022-06-07 08:24:55', '2022-06-07 08:24:55');
INSERT INTO `user_logs` VALUES (1087, 13, '2022-06-07 08:40:34', '2022-06-07 08:40:34');
INSERT INTO `user_logs` VALUES (1088, 9, '2022-06-07 08:57:50', '2022-06-07 08:57:50');
INSERT INTO `user_logs` VALUES (1089, 1, '2022-06-07 08:59:04', '2022-06-07 08:59:04');
INSERT INTO `user_logs` VALUES (1090, 20, '2022-06-07 09:07:15', '2022-06-07 09:07:15');
INSERT INTO `user_logs` VALUES (1091, 1, '2022-06-07 09:21:11', '2022-06-07 09:21:11');
INSERT INTO `user_logs` VALUES (1092, 10, '2022-06-07 11:19:57', '2022-06-07 11:19:57');
INSERT INTO `user_logs` VALUES (1093, 1, '2022-06-07 11:41:39', '2022-06-07 11:41:39');
INSERT INTO `user_logs` VALUES (1094, 1, '2022-06-07 11:52:49', '2022-06-07 11:52:49');
INSERT INTO `user_logs` VALUES (1095, 20, '2022-06-07 13:58:03', '2022-06-07 13:58:03');
INSERT INTO `user_logs` VALUES (1096, 1, '2022-06-07 14:29:09', '2022-06-07 14:29:09');
INSERT INTO `user_logs` VALUES (1097, 1, '2022-06-08 07:56:55', '2022-06-08 07:56:55');
INSERT INTO `user_logs` VALUES (1098, 1, '2022-06-08 07:58:18', '2022-06-08 07:58:18');
INSERT INTO `user_logs` VALUES (1099, 18, '2022-06-08 08:03:57', '2022-06-08 08:03:57');
INSERT INTO `user_logs` VALUES (1100, 11, '2022-06-08 08:42:43', '2022-06-08 08:42:43');
INSERT INTO `user_logs` VALUES (1101, 1, '2022-06-08 09:03:43', '2022-06-08 09:03:43');
INSERT INTO `user_logs` VALUES (1102, 1, '2022-06-08 09:10:51', '2022-06-08 09:10:51');
INSERT INTO `user_logs` VALUES (1103, 18, '2022-06-08 10:55:22', '2022-06-08 10:55:22');
INSERT INTO `user_logs` VALUES (1104, 18, '2022-06-08 11:17:29', '2022-06-08 11:17:29');
INSERT INTO `user_logs` VALUES (1105, 1, '2022-06-08 12:53:57', '2022-06-08 12:53:57');
INSERT INTO `user_logs` VALUES (1106, 1, '2022-06-08 13:50:28', '2022-06-08 13:50:28');
INSERT INTO `user_logs` VALUES (1107, 1, '2022-06-08 14:35:47', '2022-06-08 14:35:47');
INSERT INTO `user_logs` VALUES (1108, 18, '2022-06-08 14:37:51', '2022-06-08 14:37:51');
INSERT INTO `user_logs` VALUES (1109, 18, '2022-06-08 15:10:29', '2022-06-08 15:10:29');
INSERT INTO `user_logs` VALUES (1110, 1, '2022-06-09 08:51:14', '2022-06-09 08:51:14');
INSERT INTO `user_logs` VALUES (1111, 1, '2022-06-09 08:59:26', '2022-06-09 08:59:26');
INSERT INTO `user_logs` VALUES (1112, 1, '2022-06-09 08:59:56', '2022-06-09 08:59:56');
INSERT INTO `user_logs` VALUES (1113, 9, '2022-06-09 09:00:51', '2022-06-09 09:00:51');
INSERT INTO `user_logs` VALUES (1114, 1, '2022-06-09 09:21:56', '2022-06-09 09:21:56');
INSERT INTO `user_logs` VALUES (1115, 18, '2022-06-09 09:24:07', '2022-06-09 09:24:07');
INSERT INTO `user_logs` VALUES (1116, 18, '2022-06-09 12:07:38', '2022-06-09 12:07:38');
INSERT INTO `user_logs` VALUES (1117, 1, '2022-06-09 13:34:14', '2022-06-09 13:34:14');
INSERT INTO `user_logs` VALUES (1118, 9, '2022-06-09 14:01:43', '2022-06-09 14:01:43');
INSERT INTO `user_logs` VALUES (1119, 1, '2022-06-09 14:10:24', '2022-06-09 14:10:24');
INSERT INTO `user_logs` VALUES (1120, 1, '2022-06-09 20:00:42', '2022-06-09 20:00:42');
INSERT INTO `user_logs` VALUES (1121, 1, '2022-06-10 07:20:14', '2022-06-10 07:20:14');
INSERT INTO `user_logs` VALUES (1122, 1, '2022-06-10 07:57:36', '2022-06-10 07:57:36');
INSERT INTO `user_logs` VALUES (1123, 18, '2022-06-10 08:15:06', '2022-06-10 08:15:06');
INSERT INTO `user_logs` VALUES (1124, 18, '2022-06-10 08:26:08', '2022-06-10 08:26:08');
INSERT INTO `user_logs` VALUES (1125, 1, '2022-06-10 08:47:49', '2022-06-10 08:47:49');
INSERT INTO `user_logs` VALUES (1126, 1, '2022-06-10 09:48:05', '2022-06-10 09:48:05');
INSERT INTO `user_logs` VALUES (1127, 18, '2022-06-10 10:51:11', '2022-06-10 10:51:11');
INSERT INTO `user_logs` VALUES (1128, 10, '2022-06-10 13:59:38', '2022-06-10 13:59:38');
INSERT INTO `user_logs` VALUES (1129, 1, '2022-06-10 15:14:17', '2022-06-10 15:14:17');
INSERT INTO `user_logs` VALUES (1130, 10, '2022-06-10 15:33:02', '2022-06-10 15:33:02');
INSERT INTO `user_logs` VALUES (1131, 18, '2022-06-13 07:42:28', '2022-06-13 07:42:28');
INSERT INTO `user_logs` VALUES (1132, 1, '2022-06-13 07:55:11', '2022-06-13 07:55:11');
INSERT INTO `user_logs` VALUES (1133, 1, '2022-06-13 08:15:30', '2022-06-13 08:15:30');
INSERT INTO `user_logs` VALUES (1134, 1, '2022-06-13 09:37:55', '2022-06-13 09:37:55');
INSERT INTO `user_logs` VALUES (1135, 18, '2022-06-13 09:48:35', '2022-06-13 09:48:35');
INSERT INTO `user_logs` VALUES (1136, 18, '2022-06-13 10:33:35', '2022-06-13 10:33:35');
INSERT INTO `user_logs` VALUES (1137, 14, '2022-06-13 10:57:26', '2022-06-13 10:57:26');
INSERT INTO `user_logs` VALUES (1138, 1, '2022-06-13 11:20:15', '2022-06-13 11:20:15');
INSERT INTO `user_logs` VALUES (1139, 1, '2022-06-13 15:24:56', '2022-06-13 15:24:56');
INSERT INTO `user_logs` VALUES (1140, 1, '2022-06-13 15:43:39', '2022-06-13 15:43:39');
INSERT INTO `user_logs` VALUES (1141, 1, '2022-06-14 07:30:43', '2022-06-14 07:30:43');
INSERT INTO `user_logs` VALUES (1142, 1, '2022-06-14 07:57:26', '2022-06-14 07:57:26');
INSERT INTO `user_logs` VALUES (1143, 14, '2022-06-14 08:36:51', '2022-06-14 08:36:51');
INSERT INTO `user_logs` VALUES (1144, 1, '2022-06-14 14:08:58', '2022-06-14 14:08:58');
INSERT INTO `user_logs` VALUES (1145, 1, '2022-06-14 15:19:59', '2022-06-14 15:19:59');
INSERT INTO `user_logs` VALUES (1146, 1, '2022-06-15 08:25:14', '2022-06-15 08:25:14');
INSERT INTO `user_logs` VALUES (1147, 1, '2022-06-15 09:10:32', '2022-06-15 09:10:32');
INSERT INTO `user_logs` VALUES (1148, 11, '2022-06-15 09:14:17', '2022-06-15 09:14:17');
INSERT INTO `user_logs` VALUES (1149, 10, '2022-06-15 09:58:28', '2022-06-15 09:58:28');
INSERT INTO `user_logs` VALUES (1150, 1, '2022-06-15 09:58:37', '2022-06-15 09:58:37');
INSERT INTO `user_logs` VALUES (1151, 1, '2022-06-15 10:04:20', '2022-06-15 10:04:20');
INSERT INTO `user_logs` VALUES (1152, 1, '2022-06-15 10:41:40', '2022-06-15 10:41:40');
INSERT INTO `user_logs` VALUES (1153, 1, '2022-06-16 07:29:37', '2022-06-16 07:29:37');
INSERT INTO `user_logs` VALUES (1154, 1, '2022-06-16 08:31:41', '2022-06-16 08:31:41');
INSERT INTO `user_logs` VALUES (1155, 14, '2022-06-16 08:49:54', '2022-06-16 08:49:54');
INSERT INTO `user_logs` VALUES (1156, 18, '2022-06-16 09:20:58', '2022-06-16 09:20:58');
INSERT INTO `user_logs` VALUES (1157, 18, '2022-06-16 09:23:00', '2022-06-16 09:23:00');
INSERT INTO `user_logs` VALUES (1158, 10, '2022-06-16 10:30:14', '2022-06-16 10:30:14');
INSERT INTO `user_logs` VALUES (1159, 1, '2022-06-16 11:10:29', '2022-06-16 11:10:29');
INSERT INTO `user_logs` VALUES (1160, 20, '2022-06-16 11:17:06', '2022-06-16 11:17:06');
INSERT INTO `user_logs` VALUES (1161, 15, '2022-06-16 11:53:10', '2022-06-16 11:53:10');
INSERT INTO `user_logs` VALUES (1162, 18, '2022-06-16 13:08:55', '2022-06-16 13:08:55');
INSERT INTO `user_logs` VALUES (1163, 18, '2022-06-16 14:52:08', '2022-06-16 14:52:08');
INSERT INTO `user_logs` VALUES (1164, 1, '2022-06-17 08:39:45', '2022-06-17 08:39:45');
INSERT INTO `user_logs` VALUES (1165, 1, '2022-06-17 08:40:54', '2022-06-17 08:40:54');
INSERT INTO `user_logs` VALUES (1166, 18, '2022-06-17 08:53:47', '2022-06-17 08:53:47');
INSERT INTO `user_logs` VALUES (1167, 1, '2022-06-17 09:09:02', '2022-06-17 09:09:02');
INSERT INTO `user_logs` VALUES (1168, 1, '2022-06-17 09:10:28', '2022-06-17 09:10:28');
INSERT INTO `user_logs` VALUES (1169, 18, '2022-06-17 09:33:10', '2022-06-17 09:33:10');
INSERT INTO `user_logs` VALUES (1170, 1, '2022-06-17 09:48:23', '2022-06-17 09:48:23');
INSERT INTO `user_logs` VALUES (1171, 18, '2022-06-17 09:49:06', '2022-06-17 09:49:06');
INSERT INTO `user_logs` VALUES (1172, 10, '2022-06-17 09:51:45', '2022-06-17 09:51:45');
INSERT INTO `user_logs` VALUES (1173, 1, '2022-06-17 10:18:38', '2022-06-17 10:18:38');
INSERT INTO `user_logs` VALUES (1174, 1, '2022-06-20 07:39:58', '2022-06-20 07:39:58');
INSERT INTO `user_logs` VALUES (1175, 1, '2022-06-20 09:09:47', '2022-06-20 09:09:47');
INSERT INTO `user_logs` VALUES (1176, 15, '2022-06-20 09:45:52', '2022-06-20 09:45:52');
INSERT INTO `user_logs` VALUES (1177, 1, '2022-06-20 10:21:12', '2022-06-20 10:21:12');
INSERT INTO `user_logs` VALUES (1178, 1, '2022-06-20 15:54:08', '2022-06-20 15:54:08');
INSERT INTO `user_logs` VALUES (1179, 1, '2022-06-20 15:55:52', '2022-06-20 15:55:52');
INSERT INTO `user_logs` VALUES (1180, 1, '2022-06-20 15:56:29', '2022-06-20 15:56:29');
INSERT INTO `user_logs` VALUES (1181, 1, '2022-06-21 13:35:29', '2022-06-21 13:35:29');
INSERT INTO `user_logs` VALUES (1182, 15, '2022-06-22 07:53:14', '2022-06-22 07:53:14');
INSERT INTO `user_logs` VALUES (1183, 1, '2022-06-22 08:15:45', '2022-06-22 08:15:45');
INSERT INTO `user_logs` VALUES (1184, 1, '2022-06-22 09:32:43', '2022-06-22 09:32:43');
INSERT INTO `user_logs` VALUES (1185, 17, '2022-06-22 09:53:05', '2022-06-22 09:53:05');
INSERT INTO `user_logs` VALUES (1186, 1, '2022-06-23 08:12:53', '2022-06-23 08:12:53');
INSERT INTO `user_logs` VALUES (1187, 1, '2022-06-23 08:46:21', '2022-06-23 08:46:21');
INSERT INTO `user_logs` VALUES (1188, 1, '2022-06-23 08:49:45', '2022-06-23 08:49:45');
INSERT INTO `user_logs` VALUES (1189, 18, '2022-06-23 09:53:13', '2022-06-23 09:53:13');
INSERT INTO `user_logs` VALUES (1190, 15, '2022-06-23 10:50:50', '2022-06-23 10:50:50');
INSERT INTO `user_logs` VALUES (1191, 1, '2022-06-23 11:13:38', '2022-06-23 11:13:38');
INSERT INTO `user_logs` VALUES (1192, 1, '2022-06-23 15:17:23', '2022-06-23 15:17:23');
INSERT INTO `user_logs` VALUES (1193, 1, '2022-06-23 15:25:29', '2022-06-23 15:25:29');
INSERT INTO `user_logs` VALUES (1194, 1, '2022-06-24 08:57:11', '2022-06-24 08:57:11');
INSERT INTO `user_logs` VALUES (1195, 15, '2022-06-24 09:04:35', '2022-06-24 09:04:35');
INSERT INTO `user_logs` VALUES (1196, 1, '2022-06-24 09:08:40', '2022-06-24 09:08:40');
INSERT INTO `user_logs` VALUES (1197, 1, '2022-06-24 09:09:32', '2022-06-24 09:09:32');
INSERT INTO `user_logs` VALUES (1198, 18, '2022-06-24 09:57:03', '2022-06-24 09:57:03');
INSERT INTO `user_logs` VALUES (1199, 15, '2022-06-24 11:03:52', '2022-06-24 11:03:52');
INSERT INTO `user_logs` VALUES (1200, 1, '2022-06-27 08:39:19', '2022-06-27 08:39:19');
INSERT INTO `user_logs` VALUES (1201, 15, '2022-06-27 09:19:09', '2022-06-27 09:19:09');
INSERT INTO `user_logs` VALUES (1202, 1, '2022-06-27 10:12:35', '2022-06-27 10:12:35');
INSERT INTO `user_logs` VALUES (1203, 1, '2022-06-27 10:29:52', '2022-06-27 10:29:52');
INSERT INTO `user_logs` VALUES (1204, 17, '2022-06-27 11:13:25', '2022-06-27 11:13:25');
INSERT INTO `user_logs` VALUES (1205, 1, '2022-06-27 11:44:59', '2022-06-27 11:44:59');
INSERT INTO `user_logs` VALUES (1206, 18, '2022-06-27 12:30:39', '2022-06-27 12:30:39');
INSERT INTO `user_logs` VALUES (1207, 1, '2022-06-28 08:02:40', '2022-06-28 08:02:40');
INSERT INTO `user_logs` VALUES (1208, 18, '2022-06-28 09:21:47', '2022-06-28 09:21:47');
INSERT INTO `user_logs` VALUES (1209, 11, '2022-06-28 10:46:44', '2022-06-28 10:46:44');
INSERT INTO `user_logs` VALUES (1210, 1, '2022-06-29 09:22:31', '2022-06-29 09:22:31');
INSERT INTO `user_logs` VALUES (1211, 18, '2022-06-29 14:43:16', '2022-06-29 14:43:16');
INSERT INTO `user_logs` VALUES (1212, 1, '2022-06-29 15:11:31', '2022-06-29 15:11:31');
INSERT INTO `user_logs` VALUES (1213, 17, '2022-06-30 07:16:27', '2022-06-30 07:16:27');
INSERT INTO `user_logs` VALUES (1214, 17, '2022-06-30 07:59:02', '2022-06-30 07:59:02');
INSERT INTO `user_logs` VALUES (1215, 18, '2022-06-30 08:09:47', '2022-06-30 08:09:47');
INSERT INTO `user_logs` VALUES (1216, 1, '2022-06-30 08:14:47', '2022-06-30 08:14:47');
INSERT INTO `user_logs` VALUES (1217, 18, '2022-06-30 09:02:34', '2022-06-30 09:02:34');
INSERT INTO `user_logs` VALUES (1218, 15, '2022-06-30 10:13:17', '2022-06-30 10:13:17');
INSERT INTO `user_logs` VALUES (1219, 1, '2022-06-30 11:03:31', '2022-06-30 11:03:31');
INSERT INTO `user_logs` VALUES (1220, 1, '2022-06-30 13:58:43', '2022-06-30 13:58:43');
INSERT INTO `user_logs` VALUES (1221, 1, '2022-06-30 15:07:52', '2022-06-30 15:07:52');
INSERT INTO `user_logs` VALUES (1222, 17, '2022-07-11 10:24:20', '2022-07-11 10:24:20');
INSERT INTO `user_logs` VALUES (1223, 15, '2022-07-11 10:25:39', '2022-07-11 10:25:39');
INSERT INTO `user_logs` VALUES (1224, 1, '2022-07-12 09:01:12', '2022-07-12 09:01:12');
INSERT INTO `user_logs` VALUES (1225, 1, '2022-07-12 09:04:26', '2022-07-12 09:04:26');
INSERT INTO `user_logs` VALUES (1226, 1, '2022-07-12 10:00:53', '2022-07-12 10:00:53');
INSERT INTO `user_logs` VALUES (1227, 1, '2022-07-12 10:05:28', '2022-07-12 10:05:28');
INSERT INTO `user_logs` VALUES (1228, 18, '2022-07-12 10:20:34', '2022-07-12 10:20:34');
INSERT INTO `user_logs` VALUES (1229, 1, '2022-07-12 10:46:13', '2022-07-12 10:46:13');
INSERT INTO `user_logs` VALUES (1230, 1, '2022-07-12 11:14:27', '2022-07-12 11:14:27');
INSERT INTO `user_logs` VALUES (1231, 1, '2022-07-12 23:44:45', '2022-07-12 23:44:45');
INSERT INTO `user_logs` VALUES (1232, 1, '2022-07-13 08:18:36', '2022-07-13 08:18:36');
INSERT INTO `user_logs` VALUES (1233, 1, '2022-07-13 08:20:44', '2022-07-13 08:20:44');
INSERT INTO `user_logs` VALUES (1234, 1, '2022-07-13 12:32:06', '2022-07-13 12:32:06');
INSERT INTO `user_logs` VALUES (1235, 1, '2022-07-14 02:29:37', '2022-07-14 02:29:37');
INSERT INTO `user_logs` VALUES (1236, 1, '2022-07-14 06:59:38', '2022-07-14 06:59:38');
INSERT INTO `user_logs` VALUES (1237, 1, '2022-07-15 08:49:17', '2022-07-15 08:49:17');
INSERT INTO `user_logs` VALUES (1238, 1, '2022-07-18 09:11:29', '2022-07-18 09:11:29');
INSERT INTO `user_logs` VALUES (1239, 1, '2022-07-18 10:56:42', '2022-07-18 10:56:42');
INSERT INTO `user_logs` VALUES (1240, 1, '2022-07-18 21:52:12', '2022-07-18 21:52:12');
INSERT INTO `user_logs` VALUES (1241, 1, '2022-07-27 00:32:08', '2022-07-27 00:32:08');
INSERT INTO `user_logs` VALUES (1242, 11, '2022-07-27 05:32:05', '2022-07-27 05:32:05');
INSERT INTO `user_logs` VALUES (1243, 1, '2022-07-27 05:34:15', '2022-07-27 05:34:15');
INSERT INTO `user_logs` VALUES (1244, 11, '2022-07-27 05:35:17', '2022-07-27 05:35:17');
INSERT INTO `user_logs` VALUES (1245, 1, '2022-08-04 01:54:37', '2022-08-04 01:54:37');
INSERT INTO `user_logs` VALUES (1246, 1, '2022-08-05 00:24:51', '2022-08-05 00:24:51');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'User Admin', 'admin', 'admin@gmail.com', NULL, '$2y$10$1XeITtCxz1IJeHmzgYnC2udoPnML2p8oqwz6BtO5/7e3tZlKyM5Iq', 1, NULL, '2021-07-07 21:51:41', '2021-07-07 21:51:41', NULL);
INSERT INTO `users` VALUES (2, 'User Surveyor', 'surveyor', 'surveyor@gmail.com', NULL, '$2y$10$1XeITtCxz1IJeHmzgYnC2udoPnML2p8oqwz6BtO5/7e3tZlKyM5Iq', 2, NULL, '2021-07-07 21:51:41', '2021-07-07 21:51:41', NULL);
INSERT INTO `users` VALUES (3, 'User Pimpinan', 'pimpinan', 'pimpinan@gmail.com', NULL, '$2y$10$1XeITtCxz1IJeHmzgYnC2udoPnML2p8oqwz6BtO5/7e3tZlKyM5Iq', 3, NULL, '2021-07-07 21:51:41', '2021-12-15 11:20:54', '2021-12-15 11:20:54');
INSERT INTO `users` VALUES (4, 'User Surveyor 2', 'surveyor2', 'surveyor2@gmail.com', NULL, '$2y$10$1XeITtCxz1IJeHmzgYnC2udoPnML2p8oqwz6BtO5/7e3tZlKyM5Iq', 2, NULL, '2021-07-07 21:51:41', '2021-07-07 21:51:41', NULL);
INSERT INTO `users` VALUES (5, 'User Pimpinan 2', 'pimpinan2', 'pimpinan2@gmail.com', NULL, '$2y$10$1XeITtCxz1IJeHmzgYnC2udoPnML2p8oqwz6BtO5/7e3tZlKyM5Iq', 3, NULL, '2021-07-07 21:51:41', '2021-12-15 11:20:48', '2021-12-15 11:20:48');
INSERT INTO `users` VALUES (6, 'Muhammad Ilham Hidayat', 'hamayat', 'hamayat123@gmail.com', NULL, '$2y$10$4HCrzr7Bg1PQKfxmW44Ev./M9pq70j2NxkFsWqc/U8zZ37BZkbxCC', 3, NULL, '2021-07-08 19:58:31', '2021-12-15 11:20:41', '2021-12-15 11:20:41');
INSERT INTO `users` VALUES (8, 'surveyor_dani', 'surveyor_dani', 'surveyor_dani@gmail.com', NULL, '$2y$10$B5DSz.PDpOdGnpC3HrG5ZO8hqW3cjbdrs9mVbCtlwOVmOuZZSqxz2', 2, NULL, '2021-10-20 21:42:59', '2021-10-20 21:42:59', NULL);
INSERT INTO `users` VALUES (9, 'adm_selatan', 'adm_selatan', 'adm_selatan@gmail.com', NULL, '$2y$10$vwig12ht2q9qkKdfKLKPLOsi94QTrBo3TqCiS1pF75a2Gk9MNgGuS', 2, NULL, '2021-12-15 11:09:27', '2021-12-15 11:09:27', NULL);
INSERT INTO `users` VALUES (10, 'adm_timur', 'adm_timur', 'adm_timur@gmail.com', NULL, '$2y$10$pV9H8FI881Oi1M88gPsFJu4YPKPKQtQM6zFXqaeTej4k7xIrYXqqa', 2, NULL, '2021-12-15 11:10:50', '2021-12-15 11:10:50', NULL);
INSERT INTO `users` VALUES (11, 'adm_barat', 'adm_barat', 'adm_barat@gmail.com', NULL, '$2y$10$wmLH8DPqv7zpS6SilXDhGeI348eRczS55x2v316o1gYPDueIM.KBO', 2, NULL, '2021-12-15 11:11:25', '2022-07-27 05:31:25', NULL);
INSERT INTO `users` VALUES (12, 'adm_jatisampurna', 'adm_jatisampurna', 'adm_jatisampurna@gmail.com', NULL, '$2y$10$Znd75nAlzOmo0CMJJUu4dunRPRmM1cbc.j0NJ5G4RLuXtPuADTGeW', 2, NULL, '2021-12-15 11:12:07', '2021-12-15 11:12:07', NULL);
INSERT INTO `users` VALUES (13, 'adm_bantargebang', 'adm_bantargebang', 'adm_bantargebang@gmail.com', NULL, '$2y$10$YHkFXTVX2uzflY22/jjqIef1sU0TajocG88CqqUUYnMNvLNcKVPkC', 2, NULL, '2021-12-15 11:12:41', '2021-12-15 11:12:41', NULL);
INSERT INTO `users` VALUES (14, 'adm_utara', 'adm_utara', 'adm_utara@gmail.com', NULL, '$2y$10$VwMkAnBPPaImbKozn7n7JexbxsMRF5EALDpmK3XVVZrlD57h4JwCq', 2, NULL, '2021-12-15 11:13:07', '2021-12-15 11:13:07', NULL);
INSERT INTO `users` VALUES (15, 'adm_jatiasih', 'adm_jatiasih', 'adm_jatiasih@gmail.com', NULL, '$2y$10$WfXLTclT/gejWxWpFRT6I.kV/brv2sX0a9F2ENHqfb6.tz8oEf5FO', 2, NULL, '2021-12-15 11:13:24', '2021-12-15 11:13:24', NULL);
INSERT INTO `users` VALUES (16, 'adm_medansatria', 'adm_medansatria', 'adm_medansatria@gmail.com', NULL, '$2y$10$LX1mLINWFV3zIJ4sVGt67uShr8BDRchsL/LdK7hA2jyNFfSxILWhW', 2, NULL, '2021-12-15 11:13:43', '2021-12-15 11:13:43', NULL);
INSERT INTO `users` VALUES (17, 'adm_mustikajaya', 'adm_mustikajaya', 'adm_mustikajaya@gmail.com', NULL, '$2y$10$3.8vMXOrfeefWL3hhDcyteixygzNT4MjVRGJF/EYsSu4dhhHWBXI2', 2, NULL, '2021-12-15 11:14:00', '2021-12-15 11:14:00', NULL);
INSERT INTO `users` VALUES (18, 'adm_pondokgede', 'adm_pondokgede', 'adm_pondokgede@gmail.com', NULL, '$2y$10$E2zCrt9ei4adKIOFOLK8leI.IAnfp3aruCwUYZWnrKbKwLAXLBdd6', 2, NULL, '2021-12-15 11:14:16', '2021-12-15 11:14:16', NULL);
INSERT INTO `users` VALUES (19, 'adm_rawalumbu', 'adm_rawalumbu', 'adm_rawalumbu@gmail.com', NULL, '$2y$10$/QxDyoiHCcQOn4oqX/.T6uxYmkOAW.VW7JHVHCs6rMlYULZ.jARtm', 2, NULL, '2021-12-15 11:14:34', '2021-12-15 11:14:34', NULL);
INSERT INTO `users` VALUES (20, 'adm_pondokmelati', 'adm_pondokmelati', 'adm_pondokmelati@gmail.com', NULL, '$2y$10$2w3dahzjp84hRcIhcOai1ePuv9Gd.oNsLrixgZZWSbv9kS8.5D2WS', 2, NULL, '2021-12-15 11:14:52', '2021-12-15 11:14:52', NULL);

SET FOREIGN_KEY_CHECKS = 1;
