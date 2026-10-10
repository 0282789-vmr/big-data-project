-- UrbanFlow
-- Tabla analítica de corredores origen-destino
-- Fuente: hvfhv_external + dim_taxi_zone

CREATE OR REPLACE TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.analytics_corridor_summary` AS

SELECT
  pu.LocationID AS pickup_location_id,
  pu.Borough AS pickup_borough,
  pu.Zone AS pickup_zone,

  do.LocationID AS dropoff_location_id,
  do.Borough AS dropoff_borough,
  do.Zone AS dropoff_zone,

  COUNT(*) AS trip_count,

  AVG(h.base_passenger_fare) AS avg_fare,
  AVG(h.trip_miles) AS avg_trip_miles,
  AVG(h.trip_duration_minutes) AS avg_trip_duration_minutes,
  AVG(h.wait_time_minutes) AS avg_wait_time_minutes,
  AVG(h.revenue_per_mile) AS avg_revenue_per_mile,
  AVG(h.revenue_per_minute) AS avg_revenue_per_minute

FROM
`project-e6d9c504-e176-49d1-acd.urbanflow.hvfhv_external` h

LEFT JOIN
`project-e6d9c504-e176-49d1-acd.urbanflow.dim_taxi_zone` pu
ON h.PULocationID = pu.LocationID

LEFT JOIN
`project-e6d9c504-e176-49d1-acd.urbanflow.dim_taxi_zone` do
ON h.DOLocationID = do.LocationID

GROUP BY
  pickup_location_id,
  pickup_borough,
  pickup_zone,
  dropoff_location_id,
  dropoff_borough,
  dropoff_zone;
