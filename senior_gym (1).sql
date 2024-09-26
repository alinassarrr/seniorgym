-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 26, 2024 at 02:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `senior_gym`
--

-- --------------------------------------------------------

--
-- Table structure for table `arrival`
--

CREATE TABLE `arrival` (
  `arrivalID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assignedexercise`
--

CREATE TABLE `assignedexercise` (
  `aeID` int(11) NOT NULL,
  `exerciseID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `dateAssigned` date NOT NULL DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `assignedexercise`
--

INSERT INTO `assignedexercise` (`aeID`, `exerciseID`, `userID`, `dateAssigned`) VALUES
(84, 3, 10, '2024-08-09'),
(86, 5, 10, '2024-08-09'),
(91, 1, 9, '2024-08-10'),
(93, 2, 9, '2024-08-11'),
(94, 3, 9, '2024-08-11'),
(95, 4, 9, '2024-08-11'),
(96, 5, 9, '2024-08-11');

-- --------------------------------------------------------

--
-- Table structure for table `assignedfood`
--

CREATE TABLE `assignedfood` (
  `afID` int(11) NOT NULL,
  `foodID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `dateAssigned` date NOT NULL DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `assignedfood`
--

INSERT INTO `assignedfood` (`afID`, `foodID`, `userID`, `dateAssigned`) VALUES
(80, 13, 9, '2024-08-09'),
(86, 13, 10, '2024-08-09'),
(87, 14, 10, '2024-08-09'),
(88, 15, 10, '2024-08-09'),
(89, 16, 10, '2024-08-09'),
(90, 17, 10, '2024-08-09'),
(91, 18, 10, '2024-08-09'),
(100, 10, 10, '2024-08-09'),
(101, 11, 10, '2024-08-09'),
(102, 12, 10, '2024-08-09'),
(103, 1, 10, '2024-08-09'),
(105, 3, 10, '2024-08-09'),
(116, 6, 10, '2024-08-09'),
(122, 7, 10, '2024-08-09'),
(124, 9, 10, '2024-08-09'),
(153, 13, 9, '2024-08-11'),
(160, 10, 9, '2024-08-10'),
(165, 21, 10, '2024-08-09'),
(166, 10, 9, '2024-08-12'),
(172, 13, 9, '2024-08-12'),
(174, 18, 9, '2024-08-12'),
(175, 22, 10, '2024-08-09'),
(176, 1, 9, '2024-08-12'),
(177, 2, 9, '2024-08-12'),
(178, 3, 9, '2024-08-12');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE `exercises` (
  `exerciseID` int(11) NOT NULL,
  `exerciseType` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`exerciseID`, `exerciseType`) VALUES
(1, 'biceps'),
(2, 'shoulders'),
(3, 'back'),
(4, 'legs'),
(5, 'tpose'),
(6, 'treepose'),
(7, 'warriorpose');

-- --------------------------------------------------------

--
-- Table structure for table `exercisesdone`
--

CREATE TABLE `exercisesdone` (
  `edID` int(11) NOT NULL,
  `exerciseID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `dateAssigned` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `exercisesdone`
--

INSERT INTO `exercisesdone` (`edID`, `exerciseID`, `userID`, `dateAssigned`) VALUES
(27, 2, 9, '2024-08-11'),
(29, 3, 9, '2024-08-11'),
(30, 4, 9, '2024-08-11'),
(31, 5, 9, '2024-08-11'),
(32, 3, 10, '2024-08-09'),
(34, 1, 9, '2024-08-11'),
(35, 1, 9, '2024-08-10'),
(36, 1, 9, '2024-08-12');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `foodID` int(11) NOT NULL,
  `foodType` varchar(50) NOT NULL,
  `mealTime` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`foodID`, `foodType`, `mealTime`, `name`) VALUES
(1, 'weightloss', 'breakfast', 'banana oatmeal'),
(2, 'weightloss', 'breakfast', 'avocado toast scrambled eggs'),
(3, 'weightloss', 'breakfast', 'apple oatmeal muffins'),
(4, 'weightloss', 'lunch', 'protein salad'),
(5, 'weightloss', 'lunch', 'pasta salad'),
(6, 'weightloss', 'lunch', 'Tuna spinach'),
(7, 'weightloss', 'dinner', 'chicken and mushrooms'),
(8, 'weightloss', 'dinner', 'fish taco wraps'),
(9, 'weightloss', 'dinner', 'sweet potato chilli'),
(10, 'weightgain', 'breakfast', 'avocado toast with eggs'),
(11, 'weightgain', 'breakfast', 'avocado toast'),
(12, 'weightgain', 'breakfast', 'oatmeal peanut porridge'),
(13, 'weightgain', 'lunch', 'salmon'),
(14, 'weightgain', 'lunch', 'baked salmon with roasted vegetables'),
(15, 'weightgain', 'lunch', 'whole grain bread'),
(16, 'weightgain', 'dinner', 'nut butter'),
(17, 'weightgain', 'dinner', 'grilled salmon with sweet potato mash'),
(18, 'weightgain', 'dinner', 'creamy chicken soup with crusty bread'),
(19, 'snacks', 'sweet', 'peanut butter banana smoothie'),
(20, 'snacks', 'sweet', 'chocolate chip oatmeal cookies'),
(21, 'snacks', 'sweet', 'almond butter energy bites'),
(22, 'snacks', 'sour', 'sour gummy worms'),
(23, 'snacks', 'sour', 'sour patch kids'),
(24, 'snacks', 'sour', 'sour watermelon slices');

-- --------------------------------------------------------

--
-- Table structure for table `registeredcoach`
--

CREATE TABLE `registeredcoach` (
  `rcID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `coachID` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `registeredcoach`
--

INSERT INTO `registeredcoach` (`rcID`, `userID`, `coachID`, `date`) VALUES
(1, 2, 12, '2024-08-06 14:01:37'),
(28, 7, 12, '2024-08-06 14:02:04'),
(29, 10, 3, '2024-08-06 13:25:25'),
(30, 9, 3, '2024-08-06 14:00:24'),
(36, 11, 12, '2024-08-06 14:02:04'),
(37, 14, 3, '2024-08-12 09:34:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `role` varchar(10) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `Fname`, `Lname`, `password`, `role`, `image`) VALUES
(1, 'hussein', 'mohammad', 'adminadmin', 'admin', 'img1.png'),
(2, 'ali', 'tfaily', 'alitfaily', 'trainee', ''),
(3, 'hussein', 'rihan', 'husseinrihan', 'coach', ''),
(4, 'ali', 'nassar', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/08fa2272-7e7f-4b8e-83ac-0157f0591dcf6149123324561410739.jpg'),
(5, 'ali', 'nassar', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/08fa2272-7e7f-4b8e-83ac-0157f0591dcf6149123324561410739.jpg'),
(6, 'ali', 'nassar', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/08fa2272-7e7f-4b8e-83ac-0157f0591dcf6149123324561410739.jpg'),
(7, 'hassan', 'h', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/5ad4a26c-4be0-4128-98b4-7ef483c9b7be3682555505920553896.jpg'),
(9, 'hussein', 'mohammad', '123456789', 'trainee', 'D:xampphtdocsphp/uploads/038eedea-ac3b-4cb1-8e17-8a8997ed0e555178919557267230215.jpg'),
(10, 'qqw', 'qwe', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/ca141fc1-0843-4746-859d-b681122128612643145686249006778.jpg'),
(11, 'messi', 'sui', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/ca141fc1-0843-4746-859d-b681122128612643145686249006778.jpg'),
(12, 'sami', 'coach', 'coach123', 'coach', ''),
(14, 'hassan', 'hassan', '1234567890', 'trainee', 'D:xampphtdocsphp/uploads/ff0e3be9-f1ba-47d6-8e00-0ec79dbc3c164915150208296677704.jpg'),
(15, 'ali', 'coach', 'coach123', 'coach', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `arrival`
--
ALTER TABLE `arrival`
  ADD PRIMARY KEY (`arrivalID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `assignedexercise`
--
ALTER TABLE `assignedexercise`
  ADD PRIMARY KEY (`aeID`),
  ADD KEY `exerciseID` (`exerciseID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `assignedfood`
--
ALTER TABLE `assignedfood`
  ADD PRIMARY KEY (`afID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `foodID` (`foodID`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD PRIMARY KEY (`exerciseID`);

--
-- Indexes for table `exercisesdone`
--
ALTER TABLE `exercisesdone`
  ADD PRIMARY KEY (`edID`),
  ADD KEY `exerciseID` (`exerciseID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`foodID`);

--
-- Indexes for table `registeredcoach`
--
ALTER TABLE `registeredcoach`
  ADD PRIMARY KEY (`rcID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `coachID` (`coachID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `arrival`
--
ALTER TABLE `arrival`
  MODIFY `arrivalID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignedexercise`
--
ALTER TABLE `assignedexercise`
  MODIFY `aeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `assignedfood`
--
ALTER TABLE `assignedfood`
  MODIFY `afID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=179;

--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `exerciseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `exercisesdone`
--
ALTER TABLE `exercisesdone`
  MODIFY `edID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `foodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `registeredcoach`
--
ALTER TABLE `registeredcoach`
  MODIFY `rcID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `arrival`
--
ALTER TABLE `arrival`
  ADD CONSTRAINT `arrival_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `assignedexercise`
--
ALTER TABLE `assignedexercise`
  ADD CONSTRAINT `assignedExercise_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercises` (`exerciseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assignedExercise_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `assignedfood`
--
ALTER TABLE `assignedfood`
  ADD CONSTRAINT `assignedFood_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assignedFood_ibfk_2` FOREIGN KEY (`foodID`) REFERENCES `food` (`foodID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exercisesdone`
--
ALTER TABLE `exercisesdone`
  ADD CONSTRAINT `exercisesDone_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercises` (`exerciseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `exercisesDone_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `registeredcoach`
--
ALTER TABLE `registeredcoach`
  ADD CONSTRAINT `registeredCoach_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `registeredCoach_ibfk_2` FOREIGN KEY (`coachID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
