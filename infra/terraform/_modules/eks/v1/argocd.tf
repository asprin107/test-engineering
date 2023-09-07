resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = local.argocd_namespace
  create_namespace = true

  values = [templatefile("${path.module}/resources/values.yaml.tftpl", {
    lb_name            = "${local.naming_rule}-argocd"
    lb_subnets         = join(", ", var.lb_subnets)
    lb_security_groups = join(", ", var.lb_security_groups)
  })]
  #  set {
  #    name = "server.service.servicePortHttp"
  #    value = "84"
  #  }
  #  set {
  #    name = "configs.params.server\\.insecure"
  #    value = "true"
  #  }

  depends_on = [aws_eks_fargate_profile.fargate, helm_release.lb_controller, aws_lb.eks]
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