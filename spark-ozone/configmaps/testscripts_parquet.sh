#!/usr/bin/env bash

set -ex

: ${SPARK_HOME:=/opt/spark}
: ${SOURCE_PATH:=/tmp/qwex}
: ${DESTINATION_PATH:=/tmp/qwey}
: ${SAMPLES_DIR:=/opt/}

time $SPARK_HOME/bin/spark-submit \
    --conf spark.executor.memory=4g \
    --jars /opt/ozonefs/hadoop-ozone-filesystem-hadoop3.jar \
    $SAMPLES_DIR/spark-samples-1.0-SNAPSHOT.jar \
    generate --records=50 --iteration=200 $SOURCE_PATH

time $SPARK_HOME/bin/spark-submit \
    --jars /opt/ozonefs/hadoop-ozone-filesystem-hadoop3.jar \
    $SAMPLES_DIR/spark-samples-1.0-SNAPSHOT.jar \
    count $SOURCE_PATH
