import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types.{BinaryType, StringType}


  def randomID: Int = scala.util.Random.nextInt(10) + 1

  def randomDates: Int = 20200101 + scala.util.Random.nextInt((20200131 - 20200101) + 1)

  def randomHour: Int = scala.util.Random.nextInt(24)

  def randomLat: Double = 13.5 + scala.util.Random.nextFloat()

  def randomLong: Double = 100 + scala.util.Random.nextFloat()

    import spark.implicits._

    val df: DataFrame = Seq.fill(100000)
    {(randomID, randomLat, randomLong, randomDates, randomHour)}
      .toDF("msisdn", "latitude", "longitude", "par_day", "par_hour")
      .withColumn("msisdn", $"msisdn".cast(StringType))
      .withColumn("msisdn", sha1($"msisdn".cast(BinaryType)))
      .select("msisdn", "latitude", "longitude", "par_day", "par_hour")

    df
      .repartition(3, $"msisdn")
      .sortWithinPartitions("latitude", "longitude")
      .write
      .partitionBy("par_day", "par_hour")
      .format("delta")
      .save("o3fs://bucket1.vol1/location_data")



