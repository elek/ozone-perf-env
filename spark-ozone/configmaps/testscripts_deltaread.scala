import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types.{BinaryType, StringType}
import spark.implicits._

val df: DataFrame = spark.read.format("delta").load("o3fs://bucket1.vol1/location_data")
df.show()

System.out.println(df.count())