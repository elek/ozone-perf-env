./bin/spark-submit \
 --master yarn \
 --deploy-mode cluster \
 --jars /opt/ozonefs/hadoop-ozone-filesystem-lib-current-0.5.0-beta.jar \
 --class org.apache.spark.examples.JavaWordCount \
 ./examples/jars/spark-examples_2.11-2.4.4.jar \
 o3fs://bucket1.vol1/test



