#!/usr/bin/env bash
kubectl delete -f .
kubectl wait pod --for=delete -l component=chunk-manager-write
kubectl wait configmap --for=delete ozone-config
kubectl wait configmap --for=delete cmw-testscript
flekszible generate
kubectl apply -f .
