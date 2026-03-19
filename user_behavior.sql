-- membership summary
CREATE OR REPLACE VIEW membership_summary_view AS
SELECT 
    DATE(r.start_time) AS ride_date,
    u.membership_level,
    COUNT(r.ride_id) AS total_rides,
    ROUND(AVG(r.distance_km),2) AS avg_distance,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, r.start_time, r.end_time)),2) AS avg_duration
FROM rides r
JOIN users u ON r.user_id = u.user_id
GROUP BY ride_date, u.membership_level;

-- ride category
CREATE OR REPLACE VIEW ride_category_view AS
SELECT	
    DATE(start_time) AS ride_date,
    CASE 
        WHEN TIMESTAMPDIFF(MINUTE, start_time, end_time) <= 10 THEN 'Short'
        WHEN TIMESTAMPDIFF(MINUTE, start_time, end_time) <= 30 THEN 'Medium'
        ELSE 'Long'
    END AS category,
    COUNT(*) AS total_rides
FROM rides
GROUP BY ride_date, category;