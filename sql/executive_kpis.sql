-- UrbanFlow
-- KPIs ejecutivos globales
-- Fuente: hvfhv_external + tablas analíticas

CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.executive_kpis` AS

SELECT
  COUNT(*) AS total_trips,

  AVG(base_passenger_fare) AS avg_fare,
  AVG(trip_miles) AS avg_trip_miles,
  AVG(trip_duration_minutes) AS avg_trip_duration_minutes,
  AVG(wait_time_minutes) AS avg_wait_time_minutes,
  AVG(revenue_per_mile) AS avg_revenue_per_mile,
  AVG(revenue_per_minute) AS avg_revenue_per_minute,
  AVG(avg_speed_mph) AS avg_speed_mph,

  (
    SELECT Zone
    FROM `project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary`
    ORDER BY total_trips DESC
    LIMIT 1
  ) AS top_demand_zone,

  (
    SELECT total_trips
    FROM `project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary`
    ORDER BY total_trips DESC
    LIMIT 1
  ) AS top_demand_zone_trips,

  (
    SELECT Zone
    FROM `project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary`
    WHERE total_trips >= 1000000
    ORDER BY avg_revenue_per_minute DESC
    LIMIT 1
  ) AS top_efficiency_zone,

  (
    SELECT avg_revenue_per_minute
    FROM `project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary`
    WHERE total_trips >= 1000000
    ORDER BY avg_revenue_per_minute DESC
    LIMIT 1
  ) AS top_efficiency_revenue_per_minute

FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.hvfhv_external`;
