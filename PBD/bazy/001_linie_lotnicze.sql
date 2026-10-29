-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Paź 29, 2026 at 02:21 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `linie_lotnicze`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `firmy`
--

CREATE TABLE `firmy` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `kraj` varchar(60) NOT NULL,
  `rodzaj` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `firmy`
--

INSERT INTO `firmy` (`id`, `nazwa`, `kraj`, `rodzaj`) VALUES
(1, 'Boeing', 'USA', 'producent'),
(2, 'Airbus', 'Francja', 'producent'),
(3, 'Embraer', 'Brazylia', 'producent'),
(4, 'ATR', 'Francja', 'producent'),
(5, 'Bombardier', 'Kanada', 'producent'),
(6, 'LOT Polish Airlines', 'Polska', 'linia lotnicza'),
(7, 'Lufthansa', 'Niemcy', 'linia lotnicza'),
(8, 'Ryanair', 'Irlandia', 'linia lotnicza'),
(9, 'Wizz Air', 'Wegry', 'linia lotnicza'),
(10, 'Emirates', 'ZEA', 'linia lotnicza'),
(11, 'Air France', 'Francja', 'linia lotnicza'),
(12, 'British Airways', 'Wielka Brytania', 'linia lotnicza'),
(13, 'KLM', 'Holandia', 'linia lotnicza');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `flota`
--

CREATE TABLE `flota` (
  `id` int(11) NOT NULL,
  `samolot_id` int(11) NOT NULL,
  `linia_lotnicza` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `flota`
--

INSERT INTO `flota` (`id`, `samolot_id`, `linia_lotnicza`, `ilosc`) VALUES
(1, 1, 8, 120),
(2, 4, 9, 140),
(3, 2, 6, 11),
(4, 7, 6, 18),
(5, 8, 6, 6),
(6, 4, 7, 60),
(7, 5, 7, 25),
(8, 3, 10, 120),
(9, 5, 11, 20),
(10, 1, 12, 40),
(11, 6, 13, 15),
(12, 9, 6, 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obsluga_rejsu`
--

CREATE TABLE `obsluga_rejsu` (
  `id` int(11) NOT NULL,
  `rejs_id` int(11) NOT NULL,
  `pracownik_id` int(11) NOT NULL,
  `rola` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `obsluga_rejsu`
--

INSERT INTO `obsluga_rejsu` (`id`, `rejs_id`, `pracownik_id`, `rola`) VALUES
(1, 1, 1, 'Kapitan'),
(2, 1, 2, 'Pierwszy oficer'),
(3, 1, 4, 'Stewardesa'),
(4, 2, 1, 'Kapitan'),
(5, 2, 2, 'Pierwszy oficer'),
(6, 3, 9, 'Kapitan'),
(7, 3, 10, 'Stewardesa'),
(8, 4, 11, 'Kapitan'),
(9, 4, 12, 'Pierwszy oficer'),
(10, 5, 6, 'Kapitan'),
(11, 5, 7, 'Pierwszy oficer'),
(12, 5, 8, 'Steward'),
(13, 6, 6, 'Kapitan'),
(14, 6, 7, 'Pierwszy oficer'),
(15, 7, 13, 'Kapitan'),
(16, 7, 14, 'Stewardesa'),
(17, 8, 15, 'Kapitan'),
(18, 8, 16, 'Stewardesa'),
(19, 9, 17, 'Kapitan'),
(20, 9, 18, 'Pierwszy oficer'),
(21, 10, 1, 'Kapitan'),
(22, 10, 20, 'Pierwszy oficer'),
(23, 10, 3, 'Steward'),
(24, 11, 20, 'Kapitan'),
(25, 11, 2, 'Pierwszy oficer'),
(26, 12, 9, 'Kapitan'),
(27, 13, 11, 'Kapitan'),
(28, 13, 12, 'Pierwszy oficer'),
(29, 14, 19, 'Kapitan'),
(30, 15, 6, 'Kapitan'),
(31, 15, 8, 'Steward');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `id` int(11) NOT NULL,
  `linia_lotnicza` int(11) NOT NULL,
  `imie` varchar(40) NOT NULL,
  `nazwisko` varchar(60) NOT NULL,
  `stanowisko` varchar(40) NOT NULL,
  `data_zatrudnienia` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `pracownicy`
--

INSERT INTO `pracownicy` (`id`, `linia_lotnicza`, `imie`, `nazwisko`, `stanowisko`, `data_zatrudnienia`) VALUES
(1, 6, 'Jan', 'Kowalski', 'Kapitan', '2015-03-01'),
(2, 6, 'Anna', 'Nowak', 'Pierwszy oficer', '2018-06-15'),
(3, 6, 'Piotr', 'Wisniewski', 'Steward', '2019-09-01'),
(4, 6, 'Katarzyna', 'Wojcik', 'Stewardesa', '2020-01-20'),
(5, 6, 'Marek', 'Kaminski', 'Mechanik', '2012-11-05'),
(6, 7, 'Hans', 'Mueller', 'Kapitan', '2010-05-10'),
(7, 7, 'Greta', 'Schmidt', 'Pierwszy oficer', '2016-08-22'),
(8, 7, 'Thomas', 'Fischer', 'Steward', '2017-02-14'),
(9, 8, 'Sean', 'OBrien', 'Kapitan', '2014-07-30'),
(10, 8, 'Mary', 'Walsh', 'Stewardesa', '2019-04-11'),
(11, 9, 'Laszlo', 'Nagy', 'Kapitan', '2016-03-17'),
(12, 9, 'Eszter', 'Kovacs', 'Pierwszy oficer', '2019-10-01'),
(13, 10, 'Ahmed', 'Al-Farsi', 'Kapitan', '2011-09-09'),
(14, 10, 'Fatima', 'Hassan', 'Stewardesa', '2018-12-01'),
(15, 11, 'Pierre', 'Dubois', 'Kapitan', '2013-04-25'),
(16, 11, 'Camille', 'Laurent', 'Stewardesa', '2020-07-07'),
(17, 12, 'James', 'Smith', 'Kapitan', '2012-01-15'),
(18, 12, 'Emily', 'Brown', 'Pierwszy oficer', '2019-05-30'),
(19, 13, 'Daan', 'de Vries', 'Kapitan', '2015-08-19'),
(20, 6, 'Tomasz', 'Lewandowski', 'Pierwszy oficer', '2021-02-01');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rejsy`
--

CREATE TABLE `rejsy` (
  `id` int(11) NOT NULL,
  `samolot` int(11) NOT NULL,
  `lotnisko_start` char(3) NOT NULL,
  `lotnisko_koniec` char(3) NOT NULL,
  `planowana_data_wylotu` datetime NOT NULL,
  `planowana_data_przylotu` datetime NOT NULL,
  `faktyczna_data_wylotu` datetime DEFAULT NULL,
  `faktyczna_data_przylotu` datetime DEFAULT NULL,
  `ilosc_pasazerow` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `rejsy`
--

INSERT INTO `rejsy` (`id`, `samolot`, `lotnisko_start`, `lotnisko_koniec`, `planowana_data_wylotu`, `planowana_data_przylotu`, `faktyczna_data_wylotu`, `faktyczna_data_przylotu`, `ilosc_pasazerow`) VALUES
(1, 3, 'WAW', 'JFK', '2026-09-10 10:00:00', '2026-09-10 19:30:00', '2026-09-10 10:25:00', '2026-09-10 19:50:00', 210),
(2, 4, 'WAW', 'FRA', '2026-09-11 08:00:00', '2026-09-11 09:50:00', '2026-09-11 08:05:00', '2026-09-11 09:45:00', 95),
(3, 1, 'KRK', 'STN', '2026-09-11 14:00:00', '2026-09-11 16:10:00', '2026-09-11 14:00:00', '2026-09-11 16:00:00', 175),
(4, 2, 'GDN', 'LTN', '2026-09-12 06:30:00', '2026-09-12 08:40:00', '2026-09-12 07:10:00', '2026-09-12 09:15:00', 180),
(5, 6, 'FRA', 'WAW', '2026-09-12 12:00:00', '2026-09-12 13:50:00', '2026-09-12 12:00:00', '2026-09-12 13:40:00', 150),
(6, 7, 'FRA', 'JFK', '2026-09-13 09:00:00', '2026-09-13 18:00:00', NULL, NULL, 300),
(7, 8, 'DXB', 'LHR', '2026-09-13 02:00:00', '2026-09-13 06:30:00', '2026-09-13 02:15:00', '2026-09-13 06:55:00', 340),
(8, 9, 'CDG', 'JFK', '2026-09-14 11:00:00', '2026-09-14 20:00:00', '2026-09-14 11:00:00', '2026-09-14 19:40:00', 280),
(9, 10, 'LHR', 'KRK', '2026-09-14 16:00:00', '2026-09-14 19:20:00', NULL, NULL, 160),
(10, 3, 'WAW', 'DXB', '2026-09-15 22:00:00', '2026-09-16 06:00:00', '2026-09-15 22:30:00', '2026-09-16 06:45:00', 220),
(11, 4, 'WAW', 'LHR', '2026-09-15 07:00:00', '2026-09-15 09:30:00', '2026-09-15 07:00:00', '2026-09-15 09:25:00', 98),
(12, 1, 'WRO', 'DUB', '2026-09-16 13:00:00', '2026-09-16 15:30:00', '2026-09-16 13:40:00', '2026-09-16 16:05:00', 178),
(13, 2, 'KTW', 'LTN', '2026-09-16 05:00:00', '2026-09-16 07:10:00', '2026-09-16 05:00:00', '2026-09-16 07:00:00', 185),
(14, 11, 'AMS', 'WAW', '2026-09-17 10:00:00', '2026-09-17 12:10:00', NULL, NULL, 120),
(15, 6, 'FRA', 'LHR', '2026-09-17 15:00:00', '2026-09-17 16:30:00', '2026-09-17 15:20:00', '2026-09-17 16:55:00', 140);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `samoloty`
--

CREATE TABLE `samoloty` (
  `id` int(11) NOT NULL,
  `producent` int(11) NOT NULL,
  `model` varchar(60) NOT NULL,
  `rok_produkcji` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `samoloty`
--

INSERT INTO `samoloty` (`id`, `producent`, `model`, `rok_produkcji`) VALUES
(1, 1, 'Boeing 737-800', 1997),
(2, 1, 'Boeing 787-9 Dreamliner', 2014),
(3, 1, 'Boeing 777-300ER', 2004),
(4, 2, 'Airbus A320neo', 2016),
(5, 2, 'Airbus A350-900', 2015),
(6, 2, 'Airbus A220-300', 2016),
(7, 3, 'Embraer E190', 2005),
(8, 3, 'Embraer E195-E2', 2019),
(9, 4, 'ATR 72-600', 2011),
(10, 5, 'Bombardier CRJ900', 2003);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `firmy`
--
ALTER TABLE `firmy`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `flota`
--
ALTER TABLE `flota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_flota_samolot` (`samolot_id`),
  ADD KEY `fk_flota_linia` (`linia_lotnicza`);

--
-- Indeksy dla tabeli `obsluga_rejsu`
--
ALTER TABLE `obsluga_rejsu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_obsluga_rejs` (`rejs_id`),
  ADD KEY `fk_obsluga_pracownik` (`pracownik_id`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pracownicy_linia` (`linia_lotnicza`);

--
-- Indeksy dla tabeli `rejsy`
--
ALTER TABLE `rejsy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_rejsy_flota` (`samolot`);

--
-- Indeksy dla tabeli `samoloty`
--
ALTER TABLE `samoloty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_samoloty_producent` (`producent`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `firmy`
--
ALTER TABLE `firmy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `flota`
--
ALTER TABLE `flota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `obsluga_rejsu`
--
ALTER TABLE `obsluga_rejsu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `rejsy`
--
ALTER TABLE `rejsy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `samoloty`
--
ALTER TABLE `samoloty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flota`
--
ALTER TABLE `flota`
  ADD CONSTRAINT `fk_flota_linia` FOREIGN KEY (`linia_lotnicza`) REFERENCES `firmy` (`id`),
  ADD CONSTRAINT `fk_flota_samolot` FOREIGN KEY (`samolot_id`) REFERENCES `samoloty` (`id`);

--
-- Constraints for table `obsluga_rejsu`
--
ALTER TABLE `obsluga_rejsu`
  ADD CONSTRAINT `fk_obsluga_pracownik` FOREIGN KEY (`pracownik_id`) REFERENCES `pracownicy` (`id`),
  ADD CONSTRAINT `fk_obsluga_rejs` FOREIGN KEY (`rejs_id`) REFERENCES `rejsy` (`id`);

--
-- Constraints for table `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD CONSTRAINT `fk_pracownicy_linia` FOREIGN KEY (`linia_lotnicza`) REFERENCES `firmy` (`id`);

--
-- Constraints for table `rejsy`
--
ALTER TABLE `rejsy`
  ADD CONSTRAINT `fk_rejsy_flota` FOREIGN KEY (`samolot`) REFERENCES `flota` (`id`);

--
-- Constraints for table `samoloty`
--
ALTER TABLE `samoloty`
  ADD CONSTRAINT `fk_samoloty_producent` FOREIGN KEY (`producent`) REFERENCES `firmy` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
