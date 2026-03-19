-- row counts
SELECT
(SELECT COUNT(*) FROM rides) AS total_rides,
(SELECT COUNT(*) FROM stations) AS total_stations,
(SELECT COUNT(*) FROM users) AS total_users;

-- null check
SELECT
SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS null_ride_ids,
SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS null_user_id,
SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END) AS null_start_time,
SUM(CASE WHEN end_time IS NULL THEN 1 ELSE 0 END) AS null_end_time
FROM rides;

-- invalid rides
SELECT  
SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time) < 2) AS short_duration,
SUM(distance_km = 0) AS zero_distance
FROM rides;