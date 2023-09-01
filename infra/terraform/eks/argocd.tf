module "argocd" {
  source = "../_modules/argocd/eks"

  project       = var.project
  env           = var.env
  namespace     = "k6"
  lb_subnet_ids = module.network.subnets_public_ids
}