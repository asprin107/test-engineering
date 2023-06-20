resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort"
  }
  set {
    name  = "server.service.nodePortHttp"
    value = 30080 # default
  }
  set {
    name  = "server.service.nodePortHttps"
    value = 30443 # default
  }
}


resource "argocd_application" "app-of-apps" {
  metadata {
    name      = "app-of-apps"
    namespace = "argocd"
  }

  spec {
    project = "default"
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "argocd"
    }

    source {
      repo_url        = "https://github.com/asprin107/chaos-engineering.git"
      path            = "helm/app-of-apps"
      target_revision = "HEAD"
    }

    sync_policy {
      automated {
        prune       = false
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
  depends_on = [helm_release.argocd, data.kubernetes_secret.argocd-initial-pwd]
}

data "kubernetes_secret" "argocd-initial-pwd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}