-- peak hours
CREATE OR REPLACE VIEW peak_hours_view AS
SELECT
    DATE(start_time) AS ride_date,
    EXTRACT(HOUR FROM start_time) AS hour,
    COUNT(*) AS ride_count
FROM rides
GROUP BY ride_date, hour;

-- top stations
SELECT  
    s.station_name,
    COUNT(r.ride_id) AS total_starts
FROM rides r
JOIN stations s ON r.start_station_id = s.station_id
GROUP BY s.station_name
ORDER BY total_starts DESC
LIMIT 10;

-- station flow
CREATE VIEW station_flow_view AS
WITH departures AS(
    SELECT start_station_id, COUNT(*) AS departures
    FROM rides
    GROUP BY start_station_id
),
arrivals AS (
    SELECT end_station_id, COUNT(*) AS arrivals
    FROM rides
    GROUP BY end_station_id
)
SELECT  
    s.station_name,
    d.departures,
    a.arrivals,
    (a.arrivals - d.departures) AS net_flow
FROM stations s
JOIN departures d ON s.station_id = d.start_station_id
JOIN arrivals a ON s.station_id = a.end_station_id;