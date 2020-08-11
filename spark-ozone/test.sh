#!/usr/bin/env bash
set -ex

export K8S_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$K8S_DIR"
mkdir -p results

# shellcheck source=/dev/null
source "../testlib.sh"

reset_k8s_env

flekszible generate

kubectl apply -f ozone-services

retry grep_log ozone-scm-0 "SCM exiting safe mode."
retry grep_log ozone-om-0 "HTTP server of ozoneManager listening"

kubectl exec ozone-scm-0 -- ozone sh volume create /vol1
kubectl exec ozone-scm-0 -- ozone sh bucket create /vol1/bucket1
kubectl exec ozone-scm-0 -- ozone sh key put /vol1/bucket1/key1 README.md

flekszible generate --print -t namefilter:include=test-runner -t run:args="/opt/spark/bin/run-example --jars /opt/ozonefs/hadoop-ozone-filesystem-hadoop3.jar\,./examples/jars/spark-examples_2.12-3.0.0.jar org.apache.spark.examples.JavaWordCount o3fs://bucket1.vol1/key1" | kubectl apply -f -

kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job

kubectl logs --tail=30 -l job-name=test-runner | tee -a results/wordcount.txt


