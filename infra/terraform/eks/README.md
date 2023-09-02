# K6 on EKS fargate

How to access eks cluster using kubectl.
```shell
aws eks update-kubeconfig --region region-code --name my-cluster --profile my-profile
```

## Argo CD

ArgoCD initial username is `admin`.

How to get initial password

```shell
kubectl -n k6 get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

kubectl -n k6 get svc argocd-server -o jsonpath="{}"