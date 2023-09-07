#module "argocd" {
#  source = "../_modules/app_of_apps/eks"
#
#  vpc_id             = module.network.main_vpc_id
#  lb_security_groups = [module.eks.eks_elb_sg_id]
#  lb_subnets         = module.network.subnets_public_ids
#
#  eks_endpoint     = module.eks.eks_endpoint
#  eks_cluster_name = module.eks.eks_cluster_name
#  aws_profile      = var.aws_profile
#
#  eks_kubeconfig_certificate_authority_data = module.eks.kubeconfig-certificate-authority-data
#
#  tags = local.tags
#}