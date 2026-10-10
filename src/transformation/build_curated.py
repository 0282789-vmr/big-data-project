from pyspark.sql import functions as F

CURATED_PATH = (
    "gs://trip-data-project-e6d9c504-e176-49d1-acd/"
    "urbanflow/curated/hvfhv/"
)


def add_features(df):
    """
    Crea variables analíticas para el dataset CURATED.
    """

    return (
        df
        .withColumn("year", F.year("pickup_datetime"))
        .withColumn("month", F.month("pickup_datetime"))
        .withColumn("day", F.dayofmonth("pickup_datetime"))
        .withColumn("day_of_week", F.dayofweek("pickup_datetime"))
        .withColumn("pickup_hour", F.hour("pickup_datetime"))
        .withColumn(
            "trip_duration_minutes",
            F.col("trip_time") / 60.0
        )
        .withColumn(
            "wait_time_minutes",
            F.when(
                F.col("request_datetime") <= F.col("pickup_datetime"),
                (
                    F.unix_timestamp("pickup_datetime")
                    - F.unix_timestamp("request_datetime")
                ) / 60.0
            )
        )
        .withColumn(
            "revenue_per_mile",
            F.when(
                F.col("trip_miles") > 0,
                F.col("base_passenger_fare") / F.col("trip_miles")
            )
        )
        .withColumn(
            "revenue_per_minute",
            F.when(
                F.col("trip_time") > 0,
                F.col("base_passenger_fare")
                / (F.col("trip_time") / 60.0)
            )
        )
        .withColumn(
            "avg_speed_mph",
            F.when(
                F.col("trip_time") > 0,
                F.col("trip_miles")
                / (F.col("trip_time") / 3600.0)
            )
        )
        .withColumn(
            "driver_pay_ratio",
            F.when(
                F.col("base_passenger_fare") != 0,
                F.col("driver_pay")
                / F.col("base_passenger_fare")
            )
        )
    )


def write_curated(df):
    """
    Escribe el dataset CURATED en Parquet,
    particionado por año y mes.
    """

    (
        df
        .write
        .mode("overwrite")
        .partitionBy("year", "month")
        .parquet(CURATED_PATH)
    )
