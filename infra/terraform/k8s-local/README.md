# k8s-local

This directory is terraform workspace for kubernetes with k6.
Run terraform command. This will setup argoCD in kubernetes and app-of-apps template.
The app-of-apps template contain some charts for load test with k6.

>⚠️This command use local kubernetes config.
> Please check your local kubernetes config right.
> Kubernetes config file located in `~/.kube/config` by default.
> If your local Kubernetes configuration references the production cluster, 
> running this command may result in unexpected actions.

You can see your kubernetes cluster context :
```shell
kubectl config get-contexts
```

If your config is right, run below

```shell
terraform apply
```

The app-of-apps chart contains 4 main resources :
* k6-operator
* prometheus
* influxdb
* grafana

## Argo CD

ArgoCD initial username is `admin`.

How to get initial password

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Login to argocd and sync all apps. It will take few minutes. 

## Grafana

How to get initial password

```shell
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```