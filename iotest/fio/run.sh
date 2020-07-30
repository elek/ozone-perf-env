#!/usr/bin/env bash
kubectl delete -f .
kubectl wait pod --for=delete -l component=fio
flekszible generate
kubectl apply -f .
