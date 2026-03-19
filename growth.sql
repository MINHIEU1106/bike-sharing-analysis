CREATE OR REPLACE VIEW user_growth_view AS
WITH monthly_sign_ups AS ( 
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m-01') AS ride_date,
        COUNT(user_id) AS new_users
    FROM users
    GROUP BY ride_date
)

SELECT  
    ride_date,
    new_users,
    LAG(new_users) OVER (ORDER BY ride_date) AS prev_month,
    ROUND(
        (new_users - LAG(new_users) OVER (ORDER BY ride_date)) 
        / NULLIF(LAG(new_users) OVER (ORDER BY ride_date), 0) * 100
    , 2) AS mom_growth
FROM monthly_sign_ups;