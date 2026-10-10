from pyspark.sql import functions as F


def add_quality_flags(df):
    """
    Agrega reglas y banderas de calidad al dataset RAW.
    """

    return (
        df
        .withColumn(
            "flag_invalid_miles",
            F.col("trip_miles") <= 0
        )
        .withColumn(
            "flag_invalid_trip_time",
            F.col("trip_time") <= 0
        )
        .withColumn(
            "flag_pickup_after_dropoff",
            F.col("pickup_datetime") > F.col("dropoff_datetime")
        )
        .withColumn(
            "flag_negative_fare",
            F.col("base_passenger_fare") < 0
        )
        .withColumn(
            "flag_negative_driver_pay",
            F.col("driver_pay") < 0
        )
        .withColumn(
            "flag_request_after_pickup",
            F.col("request_datetime") > F.col("pickup_datetime")
        )
    )


def apply_hard_filters(df):
    """
    Elimina únicamente registros con inconsistencias fundamentales
    del viaje.
    """

    return df.filter(
        (F.col("trip_miles") > 0) &
        (F.col("trip_time") > 0) &
        (F.col("pickup_datetime") <= F.col("dropoff_datetime"))
    )
