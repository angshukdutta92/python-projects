-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 19, 2016 at 10:44 AM
-- Server version: 5.6.26
-- PHP Version: 5.5.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopsmart`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Mobiles & Tablets'),
(2, 'Computer & Gaming'),
(3, 'Women''s Fashion'),
(4, 'Men''s Fashion'),
(5, 'Kids , Toys & Fashion'),
(6, 'Home & needs'),
(7, 'Daily Needs'),
(8, 'Sports , Fitness & Outdoor'),
(9, 'Books & Media'),
(10, 'Motors and Accessories');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `item_id` varchar(250) NOT NULL,
  `name` varchar(80) NOT NULL,
  `price` int(8) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `cat_id`, `item_id`, `name`, `price`) VALUES
(1, 1, '1A', 'Xolo Era', 2697),
(2, 1, '1B', 'Asus Zenfone5', 10000),
(3, 1, '1C', 'Asus Zenfone 2', 12000),
(4, 1, '1D', 'Xiomi Note 3', 24000),
(5, 1, '1E', 'Xiomi Mi 3', 20000),
(6, 1, '1F', 'Moto X', 18000),
(7, 2, '2A', 'MotherBoard', 5000),
(8, 2, '2B', 'Gaming Console', 3000),
(9, 2, '2C', 'Processor', 5000),
(10, 2, '2D', 'Hard disk', 2000),
(11, 2, '2E', 'Ram', 1000),
(12, 2, '2F', 'Fifa 15', 500),
(13, 2, '2G', 'Call of Duty', 1500);

-- --------------------------------------------------------

--
-- Table structure for table `storeshopper_track`
--

CREATE TABLE IF NOT EXISTS `storeshopper_track` (
  `id` int(11) NOT NULL,
  `sel_item_qty` int(11) DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL,
  `sel_item_id` varchar(50) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `storeshopper_track`
--

INSERT INTO `storeshopper_track` (`id`, `sel_item_qty`, `session_id`, `sel_item_id`, `date_added`) VALUES
(1, 1, '1', '1A', '2016-04-17 18:48:01'),
(2, 1, '1', '2A', '2016-04-17 18:48:10'),
(3, 1, 'sarthak', '2B', '2016-04-17 19:15:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `pwdhash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `firstname`, `lastname`, `email`, `pwdhash`) VALUES
(1, 'A', 'B', 'a@b.com', 'pbkdf2:sha1:1000$Z2gjW8Ew$86812f84cbd87dc7fed17f8fc1d2c5cda039944d'),
(2, 'Sarthak', 'Gupta', 'sarthak937gupta@gmail.com', 'pbkdf2:sha1:1000$LvnXJ146$d4ef9c9a8d0741f57fc47231e7451a07656ffb3d');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indexes for table `storeshopper_track`
--
ALTER TABLE `storeshopper_track`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `storeshopper_track`
--
ALTER TABLE `storeshopper_track`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `category` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
