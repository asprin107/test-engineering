output "argocd-server-endpoint" {
  value = data.kubernetes_ingress_v1.ing-argocd-server.status[0].load_balancer[0].ingress[0].hostname
}