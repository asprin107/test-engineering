#!/bin/sh

kubectl delete -f k6-configmap.yaml -n k6
kubectl delete configmap k6-test -n k6
