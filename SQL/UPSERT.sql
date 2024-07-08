DROP SCHEMA IF EXISTS Spotify;
CREATE SCHEMA Spotify;
USE Spotify;

DROP TABLE IF EXISTS `Daily`;
CREATE TABLE `Daily` (
  `id` int(11) NOT NULL,
  `user_id` varchar(15) DEFAULT NULL,
  `song_id` varchar(15) DEFAULT NULL,
  `time_stamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Daily` (`id`, `user_id`, `song_id`, `time_stamp`) VALUES
(1, 'shaw', 'rise', '2019-03-01 05:33:08'),
(2, 'shaw', 'rise', '2019-03-01 16:00:00'),
(3, 'shaw', 'goodie', '2019-03-01 10:15:00'),
(4, 'linda', 'lemon', '2019-02-28 00:00:00'),
(5, 'mark', 'game', '2019-03-01 04:00:00');

ALTER TABLE `Daily`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Daily`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


DROP TABLE IF EXISTS `History`;
CREATE TABLE `History` (
  `id` int(11) NOT NULL,
  `user_id` varchar(5) DEFAULT NULL,
  `song_id` varchar(10) DEFAULT NULL,
  `tally` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `History` (`id`, `user_id`, `song_id`, `tally`) VALUES
(1, 'shaw', 'rise', 2),
(2, 'linda', 'lemon', 4);

ALTER TABLE `History`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `History`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
  
SELECT * FROM history;

# Update the record
with cte_ as (
select user_id, song_id , count(1) as tally from Daily 
where DATEDIFF("2019-03-01 00:00:00", time_stamp) = 0
group by user_id, song_id
)
update  History H
join cte_ c 
on H.song_id = c.song_id and H.user_id = c.user_id
set H.tally = H.tally + c.tally;

# Insert new record
Insert into History(`user_id`, `song_id`, `tally`) 
with cte_ as (
select user_id, song_id , count(1) as tally from Daily 
where DATEDIFF("2019-03-01 00:00:00", time_stamp) = 0
group by user_id, song_id
)
SELECT C.USER_ID, C.SONG_ID, C.TALLY FROM CTE_ C 
LEFT JOIN HISTORY H
ON C.SONG_ID = H.SONG_ID AND C.USER_ID = H.USER_ID
WHERE H.USER_ID IS NULL; 


select * from HISTORY;