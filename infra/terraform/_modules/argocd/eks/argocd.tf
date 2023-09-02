resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.namespace
  create_namespace = true

  values = [templatefile("${path.module}/eks_values.yaml.tftpl", {
    lb_name            = "${var.project}-${var.env}"
    lb_subnets         = join(", ", var.lb_subnet_ids)
    lb_security_groups = join(", ", var.lb_sg_ids)
  })]
}

data "kubernetes_secret" "argocd-initial-pwd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
  depends_on = [helm_release.argocd]
}

data "kubernetes_ingress_v1" "ing-argocd-server" {
  metadata {
    name      = "argocd-server"
    namespace = var.namespace
  }
  depends_on = [helm_release.argocd]
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