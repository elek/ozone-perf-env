#!/usr/bin/env bash
#set -ex
kubectl delete -f ozone-datanode-statefulset.yaml
kubectl delete configmap ozone-testscript
sleep 30
kubectl apply -f ozone-datanode-service.yaml
kubectl apply -f ozone-config-configmap.yaml
kubectl create configmap ozone-testscript --from-file=test.sh
kubectl apply -f ozone-datanode-statefulset.yaml
#sleep 5
#kubectl logs -f ozone-datanode-0 -c freon
