#!/usr/bin/env bash
kubectl delete -f .
kubectl wait pod --for=delete -l component=dd
kubectl wait configmap ozone-config
flekszible generate
kubectl apply -f .
