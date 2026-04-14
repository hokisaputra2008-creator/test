CREATE DATABASE `parkir` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `parkir`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `tb_user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('admin','petugas','owner','') DEFAULT NULL,
  `status_aktif` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_user` (`id_user`, `nama_lengkap`, `username`, `password`, `role`, `status_aktif`) VALUES
(1, 'Administrator Sistem', 'admin', '12345', 'admin', 1),
(2, 'Petugas Lapangan', 'petugas', '12345', 'petugas', 1),
(3, 'Pemilik Parkir', 'owner', '12345', 'owner', 1);

ALTER TABLE `tb_user` MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

CREATE TABLE `tb_area_parkir` (
  `id_area` int NOT NULL AUTO_INCREMENT,
  `nama_area` varchar(50) DEFAULT NULL,
  `kapasitas` int DEFAULT NULL,
  `terisi` int DEFAULT NULL,
  PRIMARY KEY (`id_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_area_parkir` (`id_area`, `nama_area`, `kapasitas`, `terisi`) VALUES
(2, 'Area A1', 10, 0),
(3, 'Area A2', 20, 0),
(4, 'Area A3', 30, 0);

ALTER TABLE `tb_area_parkir` MODIFY `id_area` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

CREATE TABLE `tb_tarif` (
  `id_tarif` int NOT NULL AUTO_INCREMENT,
  `jenis_kendaraan` enum('motor','mobil','lainnya','') DEFAULT NULL,
  `tarif_per_jam` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id_tarif`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_tarif` (`id_tarif`, `jenis_kendaraan`, `tarif_per_jam`) VALUES
(13, 'mobil', 5000),
(14, 'motor', 3000);

ALTER TABLE `tb_tarif` MODIFY `id_tarif` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

CREATE TABLE `tb_kendaraan` (
  `id_kendaraan` int NOT NULL AUTO_INCREMENT,
  `plat_nomor` varchar(15) DEFAULT NULL,
  `jenis_kendaraan` varchar(20) DEFAULT NULL,
  `warna` varchar(20) DEFAULT NULL,
  `pemilik` varchar(100) DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_kendaraan`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `tb_kendaraan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tb_transaksi` (
  `id_parkir` int NOT NULL AUTO_INCREMENT,
  `id_kendaraan` int DEFAULT NULL,
  `waktu_masuk` datetime DEFAULT NULL,
  `waktu_keluar` datetime DEFAULT NULL,
  `id_tarif` int DEFAULT NULL,
  `durasi_jam` int DEFAULT NULL,
  `biaya_total` decimal(10,0) DEFAULT NULL,
  `status` enum('masuk','keluar','') DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `id_area` int DEFAULT NULL,
  PRIMARY KEY (`id_parkir`),
  KEY `id_kendaraan` (`id_kendaraan`),
  KEY `id_tarif` (`id_tarif`),
  KEY `id_user` (`id_user`),
  KEY `id_area` (`id_area`),
  CONSTRAINT `tb_transaksi_ibfk_1` FOREIGN KEY (`id_kendaraan`) REFERENCES `tb_kendaraan` (`id_kendaraan`),
  CONSTRAINT `tb_transaksi_ibfk_2` FOREIGN KEY (`id_tarif`) REFERENCES `tb_tarif` (`id_tarif`),
  CONSTRAINT `tb_transaksi_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`),
  CONSTRAINT `tb_transaksi_ibfk_4` FOREIGN KEY (`id_area`) REFERENCES `tb_area_parkir` (`id_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tb_log_aktivitas` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `aktivitas` varchar(100) DEFAULT NULL,
  `waktu_aktivitas` datetime DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `tb_log_aktivitas_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
