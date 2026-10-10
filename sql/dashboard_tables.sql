-- UrbanFlow
-- Tablas optimizadas para el dashboard

CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.dashboard_top_zones` AS

SELECT
  LocationID,
  Borough,
  Zone,
  total_trips,
  avg_wait_time_minutes,
  avg_revenue_per_mile,
  avg_revenue_per_minute,
  avg_speed_mph
FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary`
WHERE Zone IS NOT NULL
ORDER BY total_trips DESC
LIMIT 10;


CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.dashboard_top_efficiency_zones` AS

SELECT
  LocationID,
  Borough,
  Zone,
  total_trips,
  avg_wait_time_minutes,
  avg_revenue_per_mile,
  avg_revenue_per_minute,
  avg_speed_mph
FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary`
WHERE Zone IS NOT NULL
  AND total_trips >= 1000000
ORDER BY avg_revenue_per_minute DESC
LIMIT 10;


CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.dashboard_top_corridors` AS

SELECT
  pickup_zone,
  dropoff_zone,
  CONCAT(pickup_zone, " → ", dropoff_zone) AS corridor,
  trip_count,
  avg_fare,
  avg_trip_miles,
  avg_trip_duration_minutes,
  avg_wait_time_minutes,
  avg_revenue_per_mile,
  avg_revenue_per_minute
FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_corridor_summary`
WHERE pickup_zone IS NOT NULL
  AND dropoff_zone IS NOT NULL
ORDER BY trip_count DESC
LIMIT 10;


CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.dashboard_top_efficiency_corridors` AS

SELECT
  pickup_zone,
  dropoff_zone,
  CONCAT(pickup_zone, " → ", dropoff_zone) AS corridor,
  trip_count,
  avg_fare,
  avg_trip_miles,
  avg_trip_duration_minutes,
  avg_wait_time_minutes,
  avg_revenue_per_mile,
  avg_revenue_per_minute
FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_corridor_summary`
WHERE pickup_zone IS NOT NULL
  AND dropoff_zone IS NOT NULL
  AND trip_count >= 500000
ORDER BY avg_revenue_per_minute DESC
LIMIT 10;
