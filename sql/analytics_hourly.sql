-- UrbanFlow
-- Tabla analítica por hora y día de la semana
-- Fuente: hvfhv_external

CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_hourly` AS

SELECT
  year,
  month,
  day_of_week,
  pickup_hour,
  COUNT(*) AS trip_count,
  AVG(base_passenger_fare) AS avg_fare,
  AVG(trip_miles) AS avg_trip_miles,
  AVG(trip_duration_minutes) AS avg_trip_duration_minutes,
  AVG(wait_time_minutes) AS avg_wait_time_minutes,
  AVG(revenue_per_mile) AS avg_revenue_per_mile,
  AVG(revenue_per_minute) AS avg_revenue_per_minute,
  AVG(avg_speed_mph) AS avg_speed_mph,
  AVG(driver_pay_ratio) AS avg_driver_pay_ratio

FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.hvfhv_external`

GROUP BY
  year,
  month,
  day_of_week,
  pickup_hour;
