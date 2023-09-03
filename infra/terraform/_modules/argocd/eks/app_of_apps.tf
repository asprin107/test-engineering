resource "argocd_application" "app-of-apps" {
  metadata {
    name      = "app-of-apps"
    namespace = local.argocd_namespace
  }

  spec {
    project = "default"
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = local.argocd_namespace
    }

    source {
      repo_url        = "https://github.com/asprin107/chaos-engineering.git"
      path            = "helm/eks/app-of-apps"
      target_revision = "feature/eks"
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      retry {
        limit = "2"
        backoff {
          duration     = "30s"
          max_duration = "1m"
          factor       = "2"
        }
      }
    }
  }
}

resource "argocd_application" "target_group_binding" {
  metadata {
    name      = "target-group-binding"
    namespace = local.argocd_namespace
  }

  spec {
    project = "default"
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = local.argocd_namespace
    }

    source {
      repo_url        = "https://github.com/asprin107/chaos-engineering.git"
      path            = "helm/charts/targetgroupbinding"
      target_revision = "feature/eks"
      helm {
        values = templatefile("${path.module}/tgb-values.yaml.tftpl", {
          tg_grafana  = aws_lb_target_group.eks["grafana"].arn
          tg_influxdb = aws_lb_target_group.eks["influxdb"].arn
        })
      }
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      retry {
        limit = "2"
        backoff {
          duration     = "30s"
          max_duration = "1m"
          factor       = "2"
        }
      }
    }
  }
}