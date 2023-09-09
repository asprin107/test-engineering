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

variable "eks_subnets" {
  description = "Subnet ids for EKS."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id for nlb."
  type        = string
}

variable "elb_id" {
  description = "ELB id for eks service."
  type        = string
}

variable "eks_oidc_provider" {
  description = "EKS OIDC provider."
  type = object({
    arn  = string
    name = string
  })
}