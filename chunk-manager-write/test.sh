#!/usr/bin/env bash
set -ex

export K8S_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$K8S_DIR"

mkdir -p results
# shellcheck source=/dev/null

source "../testlib.sh"

reset_k8s_env

flekszible generate

kubectl apply -f .

retry grep_pod_list env

kubectl wait pod --for=condition=Ready -l app=ozone,component=env

TEST_POD=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -l component=env)

MAX_RETRY=100 retry grep_log $TEST_POD "Test is Done"

kubectl logs --tail=20 $TEST_POD | tee results/result.txt
