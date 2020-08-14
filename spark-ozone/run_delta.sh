#!/usr/bin/env bash

kubectl delete job --all

flekszible generate --print -t namefilter:include=test-runner -t run:args="bin/spark-shell --jars /opt/ozonefs/hadoop-ozone-filesystem-hadoop3.jar --packages io.delta:delta-core_2.12:0.7.0 --conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog -i /opt/testscripts/deltatest.scala" | kubectl apply -f -

kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job

kubectl logs --tail=30 -l job-name=test-runner | tee -a results/wordcount.txt

