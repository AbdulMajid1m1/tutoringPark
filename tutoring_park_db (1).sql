-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 24, 2022 at 05:11 PM
-- Server version: 10.3.32-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tutoring_park_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `abbreviation` varchar(15) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `title` varchar(1500) NOT NULL,
  `subTitle` varchar(10000) NOT NULL,
  `imageUrl` varchar(300) NOT NULL,
  `small` int(10) NOT NULL DEFAULT 0,
  `small_bonus` int(10) NOT NULL DEFAULT 0,
  `medium` int(10) NOT NULL DEFAULT 0,
  `medium_bonus` int(10) NOT NULL DEFAULT 0,
  `full` int(10) NOT NULL DEFAULT 0,
  `full_bonus` int(10) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_students` int(11) NOT NULL DEFAULT 0,
  `totalTutors` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`, `abbreviation`, `price`, `title`, `subTitle`, `imageUrl`, `small`, `small_bonus`, `medium`, `medium_bonus`, `full`, `full_bonus`, `created_at`, `total_students`, `totalTutors`) VALUES
(1, 'International Baccalaureate', 'IB', 14, 'The future of IB prep', 'The International Baccalaureate (IB) is a global leader in international education—developing inquiring, knowledgeable, confident, and caring young people. Our programmes empower school-aged students to take ownership in their own learning and help them develop future-ready skills to make a difference and thrive in a world that changes fast.', 'images/imgs/img_ (2).png', 14, 3, 24, 5, 36, 3, '2022-07-18 11:56:37', 0, 0),
(2, 'International General Certificate of Secondary Education', 'IGCSE', 14, 'IGCSE is the world’s most popular international curriculum for 14-16 year olds, globally recognised .', 'Make complex subjects manageable with targeted tutoring when it works for you. It’s efficient and convenient.', 'images/imgs/img_ (3).png', 9, 1, 15, 3, 31, 6, '2022-07-18 11:59:10', 0, 0),
(3, 'General Certificate of Secondary Education', 'GCSE', 14, 'Expert GCSE prep, on your terms', 'Knock your graduate test out of the park with customized, digital tutoring.', 'images/imgs/img_ (4).png', 16, 2, 27, 3, 33, 6, '2022-07-18 11:59:10', 0, 0),
(4, 'SABIS', 'SABIS', 14, 'SABIS® believes that an intelligent approach produces better results', 'Schools in the SABIS® Network educate over 70,000 students and implement a proven, proprietary system. SABIS® Network schools provide students with a top-quality education that prepares them to meet the challenges of a changing world.', 'images/imgs/sabis.jpg', 12, 2, 20, 3, 32, 8, '2022-07-22 10:12:59', 0, 0),
(5, 'Advanced Placement', 'AP', 14, 'AP Courses are a great way to prepare for AP exams or catch up on college-level learning. Sign up for an AP Course today and get a head start on your academic goals!', 'AP Courses or Advanced Placement Courses are courses that offer rigorous college-level curricula and assessments to high school students with the opportunity to earn college credit. Pioneered by the Ford Foundation in the early twentieth century, AP courses were a response to growing concern over the gap in education standards between secondary and higher level learning.', 'images/imgs/ap.jpg', 13, 1, 19, 6, 26, 6, '2022-07-22 10:12:59', 0, 0),
(6, 'Central Board of Secondary Education', 'CBSE', 14, 'The Central Board of Secondary Education (CBSE) is a national level board of education in India', 'The Central Board of Secondary Education (CBSE) is a national level board of education in India for public and private schools, controlled and managed by the Government of India. Established in 1929 by a resolution of the government, the Board was indeed a bold experiment towards inter-state integration and cooperation in the sphere of secondary education.', 'images/img/img_ (5).png', 0, 0, 0, 0, 0, 0, '2022-08-06 15:55:50', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `course_discriptions`
--

CREATE TABLE `course_discriptions` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `subTitle` varchar(800) NOT NULL,
  `imgUrl` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_pricings`
--

CREATE TABLE `course_pricings` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `smallDuration` int(11) NOT NULL DEFAULT 0,
  `smallBonus` int(11) NOT NULL DEFAULT 0,
  `mediumDuration` int(11) NOT NULL DEFAULT 0,
  `mediumBonus` int(11) NOT NULL DEFAULT 0,
  `fullDuration` int(11) NOT NULL DEFAULT 0,
  `fullBonus` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_pricings`
--

INSERT INTO `course_pricings` (`id`, `course_id`, `smallDuration`, `smallBonus`, `mediumDuration`, `mediumBonus`, `fullDuration`, `fullBonus`, `price`) VALUES
(1, 1, 15, 2, 29, 3, 38, 7, 300),
(2, 2, 13, 1, 23, 3, 0, 45, 7),
(3, 3, 11, 1, 23, 4, 44, 6, 222);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `email` varchar(120) NOT NULL,
  `im` varchar(80) NOT NULL,
  `heard` varchar(90) NOT NULL,
  `message` varchar(25000) NOT NULL,
  `whatsapp` varchar(20) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course_duration` int(10) NOT NULL,
  `course_duration_left` int(10) NOT NULL,
  `payment_id` varchar(200) NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `plan` varchar(15) DEFAULT NULL COMMENT 'small, medium, full',
  `other` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `user_id`, `course_id`, `course_duration`, `course_duration_left`, `payment_id`, `payment_method`, `plan`, `other`, `created_at`) VALUES
(1, 60, 2, 1, 1, 'PAYID-MLRDLWQ15306919SF428654C', 'paypal', 'custom', '9TJ806451J2397647', '2022-07-28 07:40:24'),
(2, 61, 3, 1, 1, 'PAYID-MLRD4SA3XR81436E2538161U', 'paypal', 'custom', '0P1533452U173780J', '2022-07-28 07:44:36'),
(3, 61, 3, 1, 1, 'PAYID-MLRD4SA3XR81436E2538161U', 'paypal', 'custom', '0P1533452U173780J', '2022-07-28 07:52:21'),
(4, 61, 3, 1, 1, 'PAYID-MLRD4SA3XR81436E2538161U', 'paypal', 'custom', '0P1533452U173780J', '2022-07-28 07:53:16'),
(5, 61, 3, 1, 1, 'PAYID-MLRD4SA3XR81436E2538161U', 'paypal', 'custom', '0P1533452U173780J', '2022-07-28 07:54:27'),
(6, 61, 3, 1, 1, 'PAYID-MLRD4SA3XR81436E2538161U', 'paypal', 'custom', 'undefined', '2022-07-28 08:00:21'),
(7, 61, 3, 1, 1, 'PAYID-MLRD4SA3XR81436E2538161U', 'paypal', 'custom', 'undefined', '2022-07-28 08:01:11'),
(8, 62, 3, 18, 18, 'PAYID-MLREKZI6WF95789T20282302', 'paypal', 'custom', 'undefined', '2022-07-28 08:14:57'),
(9, 65, 3, 39, 39, 'PAYID-MLREQVQ3WA74192PP263460V', 'paypal', 'custom', 'undefined', '2022-07-28 08:27:18');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(300) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `token` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `email`, `verified`, `token`, `created_at`) VALUES
(13, 'm.jan9396@gmail.com', 1, '2889696.3794426327', '2022-07-19 12:12:40'),
(14, 'm.jan9396@gmail.com', 0, '918545.4797165943', '2022-07-24 11:45:34'),
(15, 'm.jan9396@gmail.com', 0, '699980.3137040139', '2022-07-24 11:46:20'),
(16, 'm.jan9396@gmail.com', 0, '2350008.887816843', '2022-08-03 12:49:15'),
(17, 'abdulmajid1m1@gmail.com', 0, '1138640.032375581', '2022-11-07 07:21:23'),
(18, 'abdulmajid1m1@gmail.com', 0, '1320344.6765067612', '2022-11-07 08:22:36');

-- --------------------------------------------------------

--
-- Table structure for table `temp_purchases`
--

CREATE TABLE `temp_purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course_duration` int(5) NOT NULL,
  `course_duration_left` int(5) NOT NULL,
  `payment_id` varchar(200) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `plan` varchar(40) NOT NULL,
  `other` varchar(10000) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp_purchases`
--

INSERT INTO `temp_purchases` (`id`, `user_id`, `course_id`, `course_duration`, `course_duration_left`, `payment_id`, `payment_method`, `plan`, `other`, `created_at`) VALUES
(1, 33, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:11:17'),
(2, 34, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:11:49'),
(3, 35, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:12:47'),
(4, 36, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:16:48'),
(5, 37, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:20:30'),
(6, 38, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:22:30'),
(7, 39, 1, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:26:21'),
(8, 40, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:28:23'),
(9, 41, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:34:55'),
(10, 42, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:36:06'),
(11, 43, 4, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:47:45'),
(12, 44, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:49:31'),
(13, 45, 4, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 14:51:54'),
(14, 46, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 15:03:50'),
(15, 47, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 15:05:05'),
(16, 48, 4, 3, 3, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 15:49:53'),
(17, 49, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 16:06:18'),
(18, 50, 4, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 16:25:50'),
(19, 51, 4, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 16:28:14'),
(20, 52, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-27 17:09:32'),
(21, 53, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 05:47:09'),
(22, 54, 4, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 06:02:59'),
(23, 55, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 06:15:21'),
(24, 56, 4, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 06:29:56'),
(25, 57, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 06:32:05'),
(26, 58, 5, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 06:32:54'),
(27, 59, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 06:37:25'),
(28, 60, 2, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 07:08:05'),
(29, 61, 3, 1, 1, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 07:44:04'),
(30, 62, 3, 18, 18, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 08:14:24'),
(31, 63, 3, 30, 30, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 08:25:14'),
(32, 64, 2, 10, 10, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 08:26:36'),
(33, 65, 3, 39, 39, ' c ', 'paypal', 'custom', ' c ', '2022-07-28 08:27:00'),
(34, 66, 2, 0, 0, ' c ', 'paypal', 'custom', ' c ', '2022-07-29 05:22:00');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `imgUrl` varchar(255) DEFAULT NULL,
  `discription` varchar(300) NOT NULL,
  `value` varchar(1200) NOT NULL,
  `filter` int(11) DEFAULT NULL COMMENT 'filter testimonials by course id',
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `name`, `imgUrl`, `discription`, `value`, `filter`, `date`) VALUES
(3, 'Arwa', '1122.png', 'Cambridge CAIE. Doha', 'The tutor was very encouraging and helped me through the entire process step by step. I would love to go with the same tutor for next year as well', NULL, '2022-08-08 13:00:04'),
(4, 'Jason Chamberlin', '1122.png', 'American International School of Kuwait (AIS)', 'I used smart boards to project all of our materials, and students were always moving closer or asking us to zoom in. The beautiful thing about Tutoring Park\'s conferencing and presentation modes is that suddenly that computer screen, inches from a child\'s face, becomes the smart board for delivering instruction, videos, and other apps.', NULL, '2022-08-08 13:03:52'),
(5, 'Fatima ', '1122.png', 'Al Jahra (KBS)', 'Tutoring Park tutoring sessions for us were a complete package. We had a demo for our four Kids and they fell in love with the teaching methodology & Guidance, then when the demo was up... they almost revolted and said, \"whatever you do, don’t take away these sessions. it does work for us.\"', NULL, '2022-08-08 13:03:52'),
(6, 'Kristen, 12th Grade', '1122.png', ' Abu Dhabi', 'Ms. Hanna\'s Sessions helped me a lot. I had missed school and didn\'t know what was going on, so I am glad I was directed here!', NULL, '2022-08-08 13:06:23'),
(7, 'Parent of GCSE French student', '1122.png', 'Dubai', 'I was worried that It would not work. But my experience with TP Tutor is great. It changed my mind about it. In today\'s digital age, it\'s vital to have a tool that provides insights into our kids\' online behavior.', NULL, '2022-08-08 13:06:23'),
(8, 'AP student', '1122.png', 'Doha', 'I went from a C in year 12 to an A for my A levels. One of my problems with geography was that I wasn’t confident, Mr. Salah helped me overcome this by encouraging me to answer questions as well as make our lessons a comfortable place. Mr. Salah also helped me find a revision technique that worked well. I’m truly grateful to have had him as a tutor; I don’t think I would’ve done as well without her. Thank you, Salah!', NULL, '2022-10-06 16:21:36'),
(9, 'Parent of two boys in Year 7 and Year 11', '1122.png', 'Doha', 'Tutoring park Online Sessions & other Tools allowed us to open up the Internet for our Kids so they may explore it, learn from it, and most importantly, build smart and practical habits when it comes to using it.  ', NULL, '2022-10-06 16:21:36'),
(10, 'Parent of a Y12 English Language and Literature student', '1122.png', 'Hong Kong', 'Well, the lessons with Aisha are going amazingly well. I am enjoying them and learning a lot!', NULL, '2022-10-06 16:25:08'),
(11, 'Parent of IGCSE Year 11 student', '1122.png', 'Hong Kong', 'Mr. Josh is super intelligent and lucid and understands the exam boards in great detail. He was a huge help to my daughter, who hadn’t really learned how to construct an essay at all, in all her school years. With Josh\'s help, she was able to do this. He is empathetic, sympathetic, and encouraging. I would recommend him without reservation. ', NULL, '2022-10-06 16:25:08'),
(12, 'A-Level student', '1122.png', 'Singapore', 'Ms. Maliha is a distinguished tutor. She has tutored me in Literature since L6 when I got a B in boarding school. Finally, I was awarded an A* in the GCE A Level result. Thanks, Maliha! ', NULL, '2022-10-06 16:26:57'),
(13, 'GCSE science student', '1122.png', 'Sharjah', 'I just had a lesson with my new science tutor, Mr. Geroge, I think it went very well', NULL, '2022-10-06 16:26:57');

-- --------------------------------------------------------

--
-- Table structure for table `tutor`
--

CREATE TABLE `tutor` (
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `CvPath` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tutor`
--

INSERT INTO `tutor` (`FirstName`, `LastName`, `Email`, `Phone`, `CvPath`) VALUES
('Adnan', 'majid', 'abdulmajid1m2@gmail.com', '23432542342', 'views/uploads/CV_1667838529446_Node.js_Task.pdf'),
('Abdul ', 'Majid', 'test@gmail.com', '3404700007', 'views/uploads/CV_1667849791649_Node.js_Task.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `tutors`
--

CREATE TABLE `tutors` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `country` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `experience` int(5) NOT NULL,
  `qualification` varchar(120) NOT NULL,
  `imgUrl` varchar(200) NOT NULL,
  `role` varchar(30) NOT NULL DEFAULT 'tutor',
  `hourlyRate` int(80) NOT NULL,
  `paymentCycle` varchar(20) NOT NULL DEFAULT 'monthly',
  `classesCounts` int(11) NOT NULL DEFAULT 0 COMMENT 'Classes count Monthly',
  `token` varchar(1000) DEFAULT NULL,
  `bankAcountNo` varchar(30) DEFAULT NULL,
  `bankBranch` varchar(180) DEFAULT NULL,
  `bankName` varchar(300) DEFAULT NULL,
  `bankAccountHolderName` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `courseAlot` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tutors`
--

INSERT INTO `tutors` (`id`, `name`, `country`, `email`, `experience`, `qualification`, `imgUrl`, `role`, `hourlyRate`, `paymentCycle`, `classesCounts`, `token`, `bankAcountNo`, `bankBranch`, `bankName`, `bankAccountHolderName`, `created_at`, `courseAlot`) VALUES
(2, 'Mariam Zubair', 'pk', '  a ', 4, 'BSc Hons in Economics', '1636536673.png', 'tutor', 0, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:31:19', NULL),
(3, 'Abdul Rehman', 'Pakistan', ' ', 6, 'BSc Electrical Engineering', '1636537708.png', 'tutor', 66, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:31:19', NULL),
(4, 'Maryam Akbar', 'Turkey', 'a', 3, 'PHD Zoology ', '1636537856.png', 'tutor', 34, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:35:19', NULL),
(5, 'Asad Ali', 'India', 'a', 6, 'Masters in Electrical Engineering', '1636538179.png', 'tutor', 67, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:35:19', NULL),
(6, 'Magdalene Williams', 'South Africa', 'a', 10, 'MBBS', '1636538621.png', 'tutor', 45, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:38:20', NULL),
(7, 'Neil Kapp', 'France', 'a', 6, 'Masters in Advanced Education', '1636538962.png', 'tutor', 90, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:38:20', NULL),
(9, 'Daniel S. Bedford', 'United Kingdom', 'a', 7, 'Masters in Mathematical and Theoretical Physics', '1636552648.png', 'tutor', 80, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:42:34', NULL),
(10, 'Josh ChillWell', 'United Kingdom', 'a', 9, 'Masters in Mathematics', '1636555416.png', 'tutor', 56, 'monthly', 0, NULL, NULL, NULL, NULL, NULL, '2022-08-08 10:42:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `whatsapp` varchar(30) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'student',
  `user_name` varchar(300) NOT NULL DEFAULT 'username',
  `im` varchar(60) NOT NULL,
  `password` varchar(70) NOT NULL,
  `course` varchar(100) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_ip` varchar(30) DEFAULT NULL,
  `last_login` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `whatsapp`, `role`, `user_name`, `im`, `password`, `course`, `course_id`, `country`, `city`, `created_at`, `client_ip`, `last_login`) VALUES
(1, 'Mehran Ullah', 'm.jan9396@hotmail.com', 'NaN', 'student', 'userName', 'undefined', 'password', 'default', 0, 'undefined', 'undefined', '2022-08-05 19:50:45', NULL, NULL),
(2, 'Mehran Ullah', 'm.jan9396@hotmail.com', 'NaN', 'student', 'userName', 'undefined', 'password', 'default', 0, 'undefined', 'undefined', '2022-08-05 19:50:49', NULL, NULL),
(3, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:03:14', NULL, NULL),
(4, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:16:00', NULL, NULL),
(5, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:16:04', NULL, NULL),
(6, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:24:35', NULL, NULL),
(7, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:24:40', NULL, NULL),
(8, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:26:20', NULL, NULL),
(9, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:26:23', NULL, NULL),
(10, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:33:09', NULL, NULL),
(11, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:36:57', NULL, NULL),
(12, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-05 20:37:01', NULL, NULL),
(13, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-06 06:12:38', NULL, NULL),
(14, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-06 06:12:43', NULL, NULL),
(15, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-06 06:13:32', NULL, NULL),
(16, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-07 15:36:07', NULL, NULL),
(17, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-07 15:36:10', NULL, NULL),
(18, '', '', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 11:57:45', NULL, NULL),
(19, 'Mehran ullah', 'mehran@metra.dev', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 11:57:53', NULL, NULL),
(20, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 11:58:41', NULL, NULL),
(21, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 12:00:29', NULL, NULL),
(22, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 12:02:19', NULL, NULL),
(23, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 12:02:22', NULL, NULL),
(24, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 12:05:34', NULL, NULL),
(25, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 12:05:36', NULL, NULL),
(26, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-09 15:08:45', NULL, NULL),
(27, '', '', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-10 11:47:52', NULL, NULL),
(28, 'Mehran ullah', 'mehran@metra.dev', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-10 11:48:00', NULL, NULL),
(29, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-10 11:48:59', NULL, NULL),
(30, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-10 11:49:01', NULL, NULL),
(31, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:32:10', NULL, NULL),
(32, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:32:13', NULL, NULL),
(33, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:34:27', NULL, NULL),
(34, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:34:29', NULL, NULL),
(35, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:34:36', NULL, NULL),
(36, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:48:25', NULL, NULL),
(37, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:48:27', NULL, NULL),
(38, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:54:55', NULL, NULL),
(39, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:54:58', NULL, NULL),
(40, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:56:16', NULL, NULL),
(41, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-11 09:56:18', NULL, NULL),
(42, 'Ydyhd', 'shhsh@yahoo.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 04:35:25', NULL, NULL),
(43, ' Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:33:26', NULL, NULL),
(44, ' Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:33:29', NULL, NULL),
(45, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:35:17', NULL, NULL),
(46, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:35:30', NULL, NULL),
(47, 'Mehran ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:35:33', NULL, NULL),
(48, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:37:40', NULL, NULL),
(49, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:37:41', NULL, NULL),
(50, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:37:43', NULL, NULL),
(51, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:38:04', NULL, NULL),
(52, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:38:07', NULL, NULL),
(53, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:44:51', NULL, NULL),
(54, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:44:52', NULL, NULL),
(55, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:54:42', NULL, NULL),
(56, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:54:44', NULL, NULL),
(57, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:59:06', NULL, NULL),
(58, 'Mehran Ullah', 'm.jan9396@hotmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-15 11:59:07', NULL, NULL),
(59, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 11:48:21', NULL, NULL),
(60, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 12:01:37', NULL, NULL),
(61, 'Engineer Mehran Ullah', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 12:04:19', NULL, NULL),
(62, 'Engineer Mehran Ullah', 'mehran@kateintl.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 12:05:16', NULL, NULL),
(63, 'Sindy', 'sindylamlam@yahoo.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 14:03:41', NULL, NULL),
(64, 'Sindy', 'sindylamlam@yahoo.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 14:05:57', NULL, NULL),
(65, 'Khan', 'm.jan9396@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-22 16:11:10', NULL, NULL),
(66, 'Saad Ahmed ', 'saad.psvita@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-23 18:51:51', NULL, NULL),
(67, 'Saad Ahmed ', 'saad.psvita@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-23 18:51:54', NULL, NULL),
(68, 'Saad Ahmed ', 'saad.psvita@gmail.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-08-23 18:53:35', NULL, NULL),
(69, 'Amjad Islam', 'amjad.islam567@outlook.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-09-14 18:57:32', NULL, NULL),
(70, 'Amjad Islam', 'amjad.islam567@outlook.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-09-14 18:57:43', NULL, NULL),
(71, 'Amjad Islam', 'amjad.islam567@outlook.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-09-14 19:00:17', NULL, NULL),
(72, 'Amjad Islam', 'amjad.islam567@outlook.com', '0000000', 'student', 'userName', 'hero', 'password', 'default', 0, 'default', 'default', '2022-09-14 19:00:27', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_discriptions`
--
ALTER TABLE `course_discriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_pricings`
--
ALTER TABLE `course_pricings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `temp_purchases`
--
ALTER TABLE `temp_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tutors`
--
ALTER TABLE `tutors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `course_discriptions`
--
ALTER TABLE `course_discriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_pricings`
--
ALTER TABLE `course_pricings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `temp_purchases`
--
ALTER TABLE `temp_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tutors`
--
ALTER TABLE `tutors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
