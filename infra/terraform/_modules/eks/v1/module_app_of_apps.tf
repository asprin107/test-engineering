module "argocd" {
  source = "../../../_modules/app_of_apps/eks"

  vpc_id             = var.eks_vpc_id
  lb_security_groups = var.lb_security_groups
  lb_subnets         = var.lb_subnets

  elb_id = aws_lb.eks.id

  tags = var.tags

  depends_on = [helm_release.argocd]
}