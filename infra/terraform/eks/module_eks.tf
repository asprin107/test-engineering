module "eks" {
  source = "../_modules/eks/v1"

  eks_fargate_namespace   = var.project
  eks_public_access_cidrs = var.eks_public_access_cidrs
  eks_subnet_ids          = module.network.subnets_private_ids
  eks_version             = "1.27"
  eks_vpc_id              = module.network.main_vpc_id
  lb_security_groups      = [module.eks.eks_elb_sg_id]
  lb_subnets              = module.network.subnets_public_ids

  tags = local.tags
}