#!/bin/sh

kubectl create -n k6 configmap k6-test --from-file=../sample/test.js
kubectl apply -n k6 -f k6-configmap.yaml
# kubectl delete -f k6-configmap.yaml -n k6
# kubectl delete configmap k6-test -n k6
