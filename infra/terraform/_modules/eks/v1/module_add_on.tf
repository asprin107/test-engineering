#module "add-on" {
#  source = "../../../_modules/add_on/eks"
#
#  eks_oidc_provider = local.eks_oidc_provider
#
#  tags = var.tags
#}