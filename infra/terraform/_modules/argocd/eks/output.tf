output "argocd-server-endpoint" {
  value = data.kubernetes_service_v1.svc-argocd-server.status[0].load_balancer[0].ingress[0].hostname
}