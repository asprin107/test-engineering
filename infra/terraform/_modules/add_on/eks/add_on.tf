resource "argocd_application" "add-on" {
  metadata {
    name      = "add-on"
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
      path            = "helm/eks/add-on"
      target_revision = "feature/eks"

      helm {
        values = templatefile("${path.module}/resources/values.yaml.tftpl", {
          role_arn_aws_efs_csi_driver = aws_iam_role.aws-efs-csi-driver.arn
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