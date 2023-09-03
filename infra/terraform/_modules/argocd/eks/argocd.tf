resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = local.argocd_namespace
  create_namespace = true

  timeout = 900

  values = [templatefile("${path.module}/values.yaml.tftpl", {
    lb_name            = "${local.naming_rule}-argocd"
    lb_subnets         = join(", ", var.lb_subnets)
    lb_security_groups = join(", ", var.lb_security_groups)
  })]
}

data "kubernetes_secret" "argocd-initial-pwd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = local.argocd_namespace
  }
  depends_on = [helm_release.argocd]
}

data "kubernetes_service_v1" "svc-argocd-server" {
  metadata {
    name      = "argocd-server"
    namespace = local.argocd_namespace
  }
  depends_on = [helm_release.argocd]
}