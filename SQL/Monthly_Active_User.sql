DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `user_id` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL,
  `phone_num` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `User` (`user_id`, `name`, `phone_num`) VALUES
('jkog', 'Jing', '202-555-0176'),
('niceguy', 'Goodman', '202-555-0174'),
('sanhoo', 'Sanjay', '202-555-0100'),
('shaw123', 'Shaw', '202-555-0111');

ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`);


-- --------------------------------------------------------

--
-- Table structure for table `UserHistory`
--

DROP TABLE IF EXISTS `UserHistory`;
CREATE TABLE `UserHistory` (
  `user_id` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `action` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `UserHistory` (`user_id`, `date`, `action`) VALUES
('sanhoo', '2019-01-01', 'logged_on'),
('niceguy', '2019-01-22', 'logged_on'),
('shaw123', '2019-02-20', 'logged_on'),
('sanhoo', '2019-02-27', 'logged_on'),
('shaw123', '2019-03-12', 'signed_up');

ALTER TABLE `UserHistory`
  ADD PRIMARY KEY (`user_id`, `date`);
  
select * from user;
select * from UserHistory;

-- Write a SQL query that returns the name, phone number and most recent date for any user 
-- that has logged in over the last 30 days (you can tell a user has logged in if the action field in UserHistory is set to "logged_on").
SET @today := "2019-03-01";
WITH CTE_ AS (
SELECT U.NAME, U.phone_num, UH.date, ROW_NUMBER() OVER(partition by U.USER_ID ORDER BY UH.DATE) AS RNK FROM USER U JOIN 
UserHistory UH ON U.USER_ID = UH.USER_ID
WHERE UH.DATE >= date_sub(@today, interval 30 DAY) AND UH.ACTION = 'logged_on' )
SELECT NAME,PHONE_NUM, DATE FROM CTE_ WHERE RNK=1;

-- Write a SQL query to determine which user_ids in the User table are not contained in the UserHistory table.
SELECT U.USER_ID FROM USER U 
LEFT JOIN UserHistory UH ON
U.USER_ID = UH.USER_ID 
WHERE UH.USER_ID IS NULL;

