resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "k6"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}

data "kubernetes_secret" "argocd-initial-pwd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}