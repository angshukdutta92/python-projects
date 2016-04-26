-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2016 at 04:03 PM
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
  `price` int(11) DEFAULT NULL,
  `seller` varchar(120) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `cat_id`, `item_id`, `name`, `price`, `seller`) VALUES
(1, 1, '1B', 'Asus Zenfone5', 10000, NULL),
(2, 1, '1A', 'Xolo Era', 2697, NULL),
(3, 1, '1C', 'ASUS ZENFONE2', 8000, NULL),
(4, 1, '1D', 'ASUS ZENFONE LASER', 5000, NULL),
(5, 1, '1E', 'HONOUR HOLLY', 7999, NULL),
(6, 1, '1F', 'MOTO X', 22000, NULL),
(7, 1, '1G', 'MOTO E', 5000, NULL),
(8, 1, '1H', 'MOTO G', 11000, NULL),
(9, 1, '1I', 'SAMSUNG CHAMP', 2500, NULL),
(10, 1, '1J', 'APPLE 5S', 50000, NULL),
(11, 1, '1K', 'APPLE 6S', 60000, NULL),
(12, 1, '1L', 'IPHONE 5', 21000, NULL),
(13, 1, '1M', 'EUREKA', 7000, NULL),
(14, 2, '2A', 'MOTHERBOARD', 2000, NULL),
(15, 2, '2B', 'Gaming Console', 3000, NULL),
(16, 2, '2C', 'Processor', 5000, NULL),
(17, 2, '2D', 'Hard Disk', 3000, NULL),
(18, 2, '2E', 'Ram', 1000, NULL),
(19, 2, '2F', 'Fifa 15', 500, NULL),
(20, 2, '2G', 'CAll of Duty', 1500, NULL),
(21, 1, '1P', 'Hp Laptop', 50000, 'ameya@gmail.com'),
(22, 2, '2H', 'Fifa 2016', 4000, 'sarthak937gupta@gmail.com'),
(23, 1, '2I', 'dell', 25000, 'ameya@gmail.com'),
(24, 2, '2I', 'abc', 5444, 'sarthak937gupta@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `storeshopper_track`
--

CREATE TABLE IF NOT EXISTS `storeshopper_track` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sel_item_id` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `sel_item_qty` int(11) DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `storeshopper_track`
--

INSERT INTO `storeshopper_track` (`id`, `name`, `sel_item_id`, `price`, `sel_item_qty`, `session_id`, `date_added`) VALUES
(14, 'Asus Zenfone5', '1B', 10000, 14, 'asad@chutiya.com', '2016-04-25 11:26:24'),
(16, 'MOTO X', '1F', 22000, 1, 'asad@chutiya.com', '2016-04-25 11:26:37'),
(19, 'Xolo Era', '1A', 2697, 1, 'ameya@gmail.com', '2016-04-26 11:37:16'),
(20, 'HONOUR HOLLY', '1E', 7999, 1, 'ameya@gmail.com', '2016-04-26 11:37:19');

-- --------------------------------------------------------

--
-- Table structure for table `userdata`
--

CREATE TABLE IF NOT EXISTS `userdata` (
  `id` int(11) NOT NULL,
  `user_email` varchar(120) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userdata`
--

INSERT INTO `userdata` (`id`, `user_email`, `date_added`, `amount`) VALUES
(1, 'sarthak937gupta@gmail.com', '2016-04-24 09:56:15', 33000),
(2, 'sarthak937gupta@gmail.com', '2016-04-24 09:56:15', 33000),
(3, 'sarthak937gupta@gmail.com', '2016-04-24 09:56:15', 33000),
(4, 'sarthak937gupta@gmail.com', '2016-04-24 09:56:15', 33000),
(5, 'sarthak937gupta@gmail.com', '2016-04-24 09:56:15', 33000),
(6, 'mohit@gmail.com', '2016-04-24 10:39:57', 12500),
(7, 'mohit@gmail.com', '2016-04-24 13:57:29', 138000),
(8, 'abc@email.com', '2016-04-24 15:01:33', 17697),
(9, 'pq@email.com', '2016-04-24 21:24:40', 3500),
(10, 'ameya@gmail.com', '2016-04-26 11:35:42', 32364),
(11, 'sarthak937gupta@gmail.com', '2016-04-26 14:31:16', 21000),
(12, 'sarthak937gupta@gmail.com', '2016-04-26 18:58:04', 29999);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `address` text,
  `email` varchar(120) DEFAULT NULL,
  `pwdhash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `firstname`, `lastname`, `address`, `email`, `pwdhash`) VALUES
(1, 'Sarthak', 'Gupta', 'hbti kanpur', 'sarthak937gupta@gmail.com', 'pbkdf2:sha1:1000$2lkxdfdu$fd873967d4bc86e8662064de73ac616d30def105'),
(2, 'Mohit', 'Gupta', 'hbti kanpur', 'mohit@gmail.com', 'pbkdf2:sha1:1000$F7r9I1kF$c77969143f4c87fe780a9914ee6caa8662b15a55'),
(3, 'Sarthak', 'Gupta', 'hbti', 'abc@email.com', 'pbkdf2:sha1:1000$5hPLQOPe$b0df3d5b4ec00c8a42a4121716a1b6ddc587e6d7'),
(4, 'Shubham', 'Gupta', 'as', 'pq@email.com', 'pbkdf2:sha1:1000$8D3UaIH1$e4da6b90ddc3c800fce5d581d8c0cbfc06ed6bb1'),
(5, 'B', 'G', '110091 154b mayur vihar phase 1 pocket 1', 'b@g.com', 'pbkdf2:sha1:1000$0EMhfBVT$3fba559f4455a54f85dd0a866abf7428c8125113'),
(6, 'Asad', 'Chutiya', 'hbti kanpur', 'asad@chutiya.com', 'pbkdf2:sha1:1000$8Rhb2upS$7b5de7b9a02b62b7205d6c8d2adf8a198a6ac996'),
(7, 'Ameya', 'Sinha', 'hbti', 'ameya@gmail.com', 'pbkdf2:sha1:1000$cDhLF54V$5be12012873bfba87676c13b1c0a648b7c4a0be1');

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
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `storeshopper_track`
--
ALTER TABLE `storeshopper_track`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `userdata`
--
ALTER TABLE `userdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
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
