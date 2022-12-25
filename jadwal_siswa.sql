-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Nov 2021 pada 15.51
-- Versi server: 10.4.19-MariaDB
-- Versi PHP: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jadwal_siswa`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Jadwal_Pelajaran` (IN `in_jadwal` VARCHAR(4))  BEGIN 
SELECT mata_pelajaran.nama_mapel, jadwal.jam, jadwal.hari 
FROM mata_pelajaran
INNER JOIN jadwal
ON mata_pelajaran.id_mapel = jadwal.id_mapel
WHERE jadwal.id_mapel = in_jadwal;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal`
--

CREATE TABLE `jadwal` (
  `id_mapel` varchar(9) DEFAULT NULL,
  `jam` varchar(20) DEFAULT NULL,
  `hari` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jadwal`
--

INSERT INTO `jadwal` (`id_mapel`, `jam`, `hari`) VALUES
('mat', '07:15 - 09:00', 'Senin'),
('agm', '09:15 - 10:30', 'Senin'),
('eng', '10:35 - 12:00', 'Senin'),
('ind', '07:15 - 09:00', 'Selasa'),
('ipa', '09:15 - 10:30', 'Selasa'),
('ips', '10:35 - 12:00', 'Selasa'),
('ips', '07:15 - 09:00', 'Rabu'),
('ind', '09:15 - 10:30', 'Rabu'),
('mat', '10:35 - 12:00', 'Rabu'),
('eng', '07:15 - 09:00', 'Kamis'),
('ipa', '09:15 - 10:30', 'Kamis'),
('agm', '10:35 - 12:00', 'Kamis'),
('mat', '07:15 - 09:15', 'Jumat'),
('agm', '09:30 - 11:00', 'Jumat');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `jadwal_sekolah`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `jadwal_sekolah` (
`nama_mapel` varchar(50)
,`jam` varchar(20)
,`hari` varchar(12)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `massage`
--

CREATE TABLE `massage` (
  `id` int(20) NOT NULL,
  `tgl` datetime DEFAULT current_timestamp(),
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `massage`
--

INSERT INTO `massage` (`id`, `tgl`, `catatan`) VALUES
(1, '2021-10-24 21:49:46', 'Nama Tugas kerjakan tugas  pada Mata Pelajaran agm sudah ditambahkan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mata_pelajaran`
--

CREATE TABLE `mata_pelajaran` (
  `id_mapel` varchar(9) NOT NULL,
  `nama_mapel` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `mata_pelajaran`
--

INSERT INTO `mata_pelajaran` (`id_mapel`, `nama_mapel`) VALUES
('agm', 'Agama'),
('eng', 'Bahasa Ingris'),
('ind', 'Bahasa Indonesia'),
('ipa', 'Ilmu Pengetahuan Alam'),
('ips', 'Ilmu Pengetahuan Sosial'),
('jpg', 'Bahasa Jepang'),
('mat', 'Matematika');

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `nis` varchar(10) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `kelas` varchar(15) DEFAULT NULL,
  `updatetimestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`nis`, `password`, `nama`, `kelas`, `updatetimestamp`) VALUES
('1907051009', 'mire123', 'mire', 'A', '2021-11-21 14:17:48'),
('1907051020', 'arif123', 'Muhammad arif', 'A', '2021-11-21 14:27:33'),
('1907051029', '123', 'ridho', 'B', '2021-11-21 13:24:35'),
('1907051039', '', 'Maria Olivia Lestiyaningrum', 'B', '2021-11-21 14:33:58'),
('1907051920', 'user', 'arif', 'A', '2021-11-21 03:54:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tugas`
--

CREATE TABLE `tugas` (
  `id_tugas` varchar(9) NOT NULL,
  `nama_tugas` varchar(15) DEFAULT NULL,
  `id_mapel` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `nama_tugas`, `id_mapel`) VALUES
('tgsagm', 'kerjakan tugas ', 'agm'),
('tgseng', 'introducing mys', 'eng'),
('tgsipa', 'rangkum bab 2', 'ipa'),
('tgsips', 'rangkum bab 1', 'ips'),
('tgsmat', 'LKS hal 15', 'mat');

--
-- Trigger `tugas`
--
DELIMITER $$
CREATE TRIGGER `Tugas` AFTER INSERT ON `tugas` FOR EACH ROW BEGIN
  INSERT INTO massage (catatan) 
  VALUES (CONCAT('Nama Tugas ', NEW.nama_tugas, ' pada Mata Pelajaran ', NEW.id_mapel,' sudah ditambahkan'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `tugas_sekolah`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `tugas_sekolah` (
`nama_mapel` varchar(50)
,`nama_tugas` varchar(15)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `jadwal_sekolah`
--
DROP TABLE IF EXISTS `jadwal_sekolah`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jadwal_sekolah`  AS SELECT `mata_pelajaran`.`nama_mapel` AS `nama_mapel`, `jadwal`.`jam` AS `jam`, `jadwal`.`hari` AS `hari` FROM (`mata_pelajaran` join `jadwal` on(`mata_pelajaran`.`id_mapel` = `jadwal`.`id_mapel`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `tugas_sekolah`
--
DROP TABLE IF EXISTS `tugas_sekolah`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tugas_sekolah`  AS SELECT `a`.`nama_mapel` AS `nama_mapel`, `b`.`nama_tugas` AS `nama_tugas` FROM (`mata_pelajaran` `a` join `tugas` `b`) WHERE `a`.`id_mapel` = `b`.`id_mapel` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `jadwal`
--
ALTER TABLE `jadwal`
  ADD KEY `mata_pelajaran` (`id_mapel`);

--
-- Indeks untuk tabel `massage`
--
ALTER TABLE `massage`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  ADD PRIMARY KEY (`id_mapel`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`nis`);

--
-- Indeks untuk tabel `tugas`
--
ALTER TABLE `tugas`
  ADD PRIMARY KEY (`id_tugas`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `massage`
--
ALTER TABLE `massage`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `mata_pelajaran` FOREIGN KEY (`id_mapel`) REFERENCES `mata_pelajaran` (`id_mapel`);

--
-- Ketidakleluasaan untuk tabel `tugas`
--
ALTER TABLE `tugas`
  ADD CONSTRAINT `tugas_ibfk_1` FOREIGN KEY (`id_mapel`) REFERENCES `mata_pelajaran` (`id_mapel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
