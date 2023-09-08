variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Environment = string
  })
}

variable "eks_oidc_provider" {
  description = "EKS OIDC provider."
  type = object({
    arn  = string
    name = string
  })
}