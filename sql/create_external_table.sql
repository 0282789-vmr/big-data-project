-- UrbanFlow
-- Creación de tabla externa en BigQuery
-- Fuente: datos CURATED almacenados en Google Cloud Storage

CREATE OR REPLACE EXTERNAL TABLE
`project-e6d9c504-e176-49d1-acd.urbanflow.hvfhv_external`

WITH PARTITION COLUMNS (
  year INT64,
  month INT64
)

OPTIONS (
  format = 'PARQUET',
  uris = [
    'gs://trip-data-project-e6d9c504-e176-49d1-acd/urbanflow/curated/hvfhv/*'
  ],
  hive_partition_uri_prefix =
    'gs://trip-data-project-e6d9c504-e176-49d1-acd/urbanflow/curated/hvfhv/'
);
