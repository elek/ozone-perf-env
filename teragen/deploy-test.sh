#!/usr/bin/env bash
#set -ex
kubectl delete -f .
kubectl delete configmap teragen-testscript
sleep 10
kubectl create configmap teragen-testscript --from-file=teragen.sh
kubectl apply -f .
