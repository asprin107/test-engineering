module "eks" {
  source = "../_modules/eks/v1"

  eks_fargate_namespace   = "k6"
  eks_public_access_cidrs = var.eks_public_access_cidrs
  eks_subnet_ids          = module.network.subnets_private_ids
  eks_version             = "1.27"
  eks_vpc_id              = module.network.main_vpc_id

  tags = {
    Project     = var.project
    Environment = var.env
  }
}