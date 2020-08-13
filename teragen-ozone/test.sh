#!/usr/bin/env bash
set -ex

export K8S_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$K8S_DIR"
mkdir -p results

# shellcheck source=/dev/null
source "../testlib.sh"

reset_k8s_env

flekszible generate #-t ozone/onenode

kubectl apply -f btm-configmap.yaml
kubectl apply -f ozone-services
kubectl apply -f yarn-services

retry grep_log ozone-scm-0 "SCM exiting safe mode."
retry grep_log ozone-om-0 "HTTP server of ozoneManager listening"

kubectl exec ozone-scm-0 -- ozone sh volume create /vol1
kubectl exec ozone-scm-0 -- ozone sh bucket create /vol1/bucket1

kubectl apply -f .

TEST_MAPPERS=2 ./run_test.sh
