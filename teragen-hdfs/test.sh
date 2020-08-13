#!/usr/bin/env bash
set -ex

export K8S_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$K8S_DIR"
mkdir -p results

# shellcheck source=/dev/null
source "../testlib.sh"

#kubectl delete -f yarn-teragen-deployment.yaml
#kubectl delete -f yarn-services

reset_k8s_env

flekszible generate #-t hdfs/onenode

kubectl apply -f btm-configmap.yaml
kubectl apply -f hdfs-services
kubectl apply -f yarn-services

retry grep_log yarn-resourcemanager-0 "Added node yarn-nodemanager-1.yarn-nodemanager"
retry grep_log hdfs-namenode-0 "Adding new storage ID"

kubectl apply -f .

kubectl apply -f .

TEST_MAPPERS=2 ./run_test.sh

