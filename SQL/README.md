Spotify Listening History
Key Concepts
Update aggregate table with event log.
Temporary table & reusability.
Update with join statement.
Edge case: adding new user-song pair.
Aggregation.
Two Tables
You have a History table where you have date, user_id, song_id and count(tally). It shows at the end of each day how many times in her history a user has listened to a given song. So count is cumulative sum.

You have to update this on a daily basis based on a second Daily table that records in real time when a user listens to a given song.

Basically, at the end of each day, you go to this second table and pull a count of each user/song combination and then add this count to the first table that has the lifetime count.
