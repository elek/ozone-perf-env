#!/usr/bin/env bash

kubectl exec ozone-scm-0 -- ozone sh key put /vol1/bucket1/key1 README.md

flekszible generate --print -t namefilter:include=test-runner -t run:args="/opt/spark/bin/run-example --jars /opt/ozonefs/hadoop-ozone-filesystem-hadoop3.jar\,./examples/jars/spark-examples_2.12-3.0.0.jar org.apache.spark.examples.JavaWordCount o3fs://bucket1.vol1/key1" | kubectl apply -f -

kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job

kubectl logs --tail=30 -l job-name=test-runner | tee -a results/wordcount.txt


