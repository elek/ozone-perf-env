

$SPARK_HOME/bin/spark-submit \
    --master k8s://https://vb0933.halxg.cloudera.com:6443 \
    --deploy-mode cluster \
    --name spark-word-count \
    --class org.apache.spark.examples.JavaWordCount \
    --conf spark.executor.instances=1 \
    --conf spark.kubernetes.executor.podTemplateFile=pod/pod.yaml \
    --conf spark.kubernetes.namespace=default \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
    --conf spark.kubernetes.container.image=flokkr/spark-hadoop3:3.0.0 \
    --conf spark.kubernetes.container.image.pullPolicy=Always \
    local:///opt/spark/examples/jars/spark-examples_2.12-3.0.0.jar \
    /opt/spark/README.md
