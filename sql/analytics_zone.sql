-- UrbanFlow
-- Tabla analítica por zona de pickup
-- Fuente: hvfhv_external + dim_taxi_zone

CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_zone_summary` AS

SELECT
  z.LocationID,
  z.Borough,
  z.Zone,
  z.service_zone,

  COUNT(*) AS total_trips,

  AVG(h.base_passenger_fare) AS avg_fare,
  AVG(h.trip_miles) AS avg_trip_miles,
  AVG(h.trip_duration_minutes) AS avg_trip_duration_minutes,
  AVG(h.wait_time_minutes) AS avg_wait_time_minutes,
  AVG(h.revenue_per_mile) AS avg_revenue_per_mile,
  AVG(h.revenue_per_minute) AS avg_revenue_per_minute,
  AVG(h.avg_speed_mph) AS avg_speed_mph

FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.hvfhv_external` h

LEFT JOIN
`project-e6d9c504-e176-49d1-acd.urbanflow.dim_taxi_zone` z

ON h.PULocationID = z.LocationID

GROUP BY
  z.LocationID,
  z.Borough,
  z.Zone,
  z.service_zone;
