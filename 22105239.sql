-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 10, 2022 at 01:10 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `22105239`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `custId` int(11) NOT NULL,
  `custName` varchar(255) DEFAULT NULL,
  `custLocation` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`custId`, `custName`, `custLocation`) VALUES
(2000, 'Arthur', 1000),
(2001, 'Emma', 1001),
(2002, 'Louis', 1002),
(2003, 'Jules', 1003),
(2004, 'Paul', 1004),
(2005, 'Gabriel', 1005),
(2006, 'Anna', 1006),
(2007, 'Léo', 1007),
(2008, 'Lucas', 1008),
(2009, 'Gabin', 1009);

-- --------------------------------------------------------

--
-- Table structure for table `located`
--

CREATE TABLE `located` (
  `parcelId` int(10) NOT NULL,
  `LocId` int(10) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `Operation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `LocId` int(10) NOT NULL,
  `locAddress` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`LocId`, `locAddress`, `city`) VALUES
(1000, 'Meudon', 'Paris'),
(1001, 'Grenelle', 'Paris'),
(1002, 'Craponne', 'Lyon'),
(1003, 'Villeurbanne', 'Lyon'),
(1004, 'Le Canet', 'Marseille'),
(1005, 'Les Serens', 'Marseille'),
(1006, 'Purpan', 'Toulouse'),
(1007, 'Arènes', 'Toulouse'),
(1008, 'Balma', 'Toulouse'),
(1009, 'La Benauge', 'Bordeaux');

-- --------------------------------------------------------

--
-- Table structure for table `parcels`
--

CREATE TABLE `parcels` (
  `parcelId` int(10) NOT NULL,
  `weight` int(10) DEFAULT NULL,
  `custId` int(10) DEFAULT NULL,
  `finalLocation` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `parcels`
--

INSERT INTO `parcels` (`parcelId`, `weight`, `custId`, `finalLocation`) VALUES
(21, 10, 2001, 1007);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`custId`),
  ADD KEY `fk_01` (`custLocation`);

--
-- Indexes for table `located`
--
ALTER TABLE `located`
  ADD PRIMARY KEY (`parcelId`,`LocId`),
  ADD KEY `LocId` (`LocId`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`LocId`);

--
-- Indexes for table `parcels`
--
ALTER TABLE `parcels`
  ADD PRIMARY KEY (`parcelId`),
  ADD KEY `custId` (`custId`),
  ADD KEY `finalLocation` (`finalLocation`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `custId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2011;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `LocId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1011;

--
-- AUTO_INCREMENT for table `parcels`
--
ALTER TABLE `parcels`
  MODIFY `parcelId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_01` FOREIGN KEY (`custLocation`) REFERENCES `locations` (`LocId`);

--
-- Constraints for table `located`
--
ALTER TABLE `located`
  ADD CONSTRAINT `located_ibfk_1` FOREIGN KEY (`parcelId`) REFERENCES `parcels` (`parcelId`),
  ADD CONSTRAINT `located_ibfk_2` FOREIGN KEY (`LocId`) REFERENCES `locations` (`LocId`);

--
-- Constraints for table `parcels`
--
ALTER TABLE `parcels`
  ADD CONSTRAINT `parcels_ibfk_1` FOREIGN KEY (`custId`) REFERENCES `customers` (`custId`),
  ADD CONSTRAINT `parcels_ibfk_2` FOREIGN KEY (`finalLocation`) REFERENCES `locations` (`LocId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
