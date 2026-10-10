from pyspark.sql import SparkSession

RAW_PATH = "gs://trip-data-project-e6d9c504-e176-49d1-acd/urbanflow/raw/hvfhv/"


def read_hvfhv_data(spark: SparkSession):
    """
    Lee los archivos Parquet RAW de UrbanFlow desde Google Cloud Storage.
    """
    return spark.read.parquet(RAW_PATH)
