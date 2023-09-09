module "app_of_apps" {
  source = "../../../_modules/app_of_apps/eks"

  vpc_id             = var.eks_vpc_id
  lb_security_groups = var.lb_security_groups
  eks_subnets        = var.lb_subnets
  eks_oidc_provider  = local.eks_oidc_provider

  elb_id = aws_lb.eks.id

  tags = var.tags

  depends_on = [helm_release.argocd]
}