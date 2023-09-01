resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.namespace
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
    for_each = var.lb_subnet_ids
    content {
      name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
      value = set.value
    }
  }
}


#resource "argocd_application" "app-of-apps" {
#  metadata {
#    name      = "app-of-apps"
#    namespace = var.namespace
#  }
#
#  spec {
#    project = "default"
#    destination {
#      server    = "https://kubernetes.default.svc"
#      namespace = var.namespace
#    }
#
#    source {
#      repo_url        = "https://github.com/asprin107/chaos-engineering.git"
#      path            = "helm/eks/app-of-apps"
#      target_revision = "feature/eks"
#    }
#
#    sync_policy {
#      automated {
#        prune       = false
#        self_heal   = true
#        allow_empty = true
#      }
#      retry {
#        limit = "2"
#        backoff {
#          duration     = "30s"
#          max_duration = "1m"
#          factor       = "2"
#        }
#      }
#    }
#  }
#  depends_on = [helm_release.argocd, data.kubernetes_secret.argocd-initial-pwd]
#}

data "kubernetes_secret" "argocd-initial-pwd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}