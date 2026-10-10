-- UrbanFlow
-- Tendencia mensual de demanda y eficiencia
-- Fuente: hvfhv_external

CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_monthly_trend` AS

SELECT
  year,
  month,
  DATE(year, month, 1) AS month_date,

  COUNT(*) AS trip_count,

  AVG(base_passenger_fare) AS avg_fare,
  AVG(trip_miles) AS avg_trip_miles,
  AVG(trip_duration_minutes) AS avg_trip_duration_minutes,
  AVG(wait_time_minutes) AS avg_wait_time_minutes,
  AVG(revenue_per_mile) AS avg_revenue_per_mile,
  AVG(revenue_per_minute) AS avg_revenue_per_minute,
  AVG(avg_speed_mph) AS avg_speed_mph

FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.hvfhv_external`

GROUP BY
  year,
  month,
  month_date

ORDER BY
  month_date;
