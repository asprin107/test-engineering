variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Environment = string
  })
}

variable "lb_security_groups" {
  description = "Security group ids for nlb."
  type        = list(string)
}

variable "lb_subnets" {
  description = "Subnet ids for nlb."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id for nlb."
  type        = string
}

variable "eks_endpoint" {
  description = "EKS endpoint."
  type        = string
}

variable "eks_kubeconfig_certificate_authority_data" {
  description = "EKS author certificate"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS Cluster name."
  type        = string
}

variable "aws_profile" {
  description = "AWS Profile."
  type        = string
}