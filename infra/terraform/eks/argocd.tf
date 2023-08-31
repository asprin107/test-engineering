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
  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "external"
  }
  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-name"
    value = "${var.project}-${var.env}-argocd"
  }
  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
    value = "internet-facing"
  }
  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-nlb-target-type"
    value = "ip"
  }

  dynamic "set" {
    for_each = module.network.subnets_public_ids
    content {
      name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
      value = set.value
    }
  }
}

data "kubernetes_secret" "argocd-initial-pwd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}