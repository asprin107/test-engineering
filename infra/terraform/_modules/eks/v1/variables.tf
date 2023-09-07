variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Environment = string
  })
}

variable "eks_subnet_ids" {
  description = "List subnet ids for eks data plane will be deployed. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (Fargate)"
  type        = list(string)
}

variable "eks_version" {
  description = "EKS kubernetes version."
  type        = string
}

variable "eks_public_access_cidrs" {
  description = "List CIDR where can access the eks cluster."
  type        = list(string)
}

variable "eks_control_plane_log_types" {
  description = "EKS control plane log types. Default value is [] which means not logging. More details. https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html"
  default     = [] # ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  type        = list(string)
}

variable "eks_fargate_namespace" {
  description = "EKS Namespace for fargate nodegroup."
  type        = string
}

variable "eks_vpc_id" {
  description = "VPC id for EKS."
  type        = string
}

variable "lb_security_groups" {
  description = "Security group ids for nlb."
  type        = list(string)
}

variable "lb_subnets" {
  description = "Subnet ids for nlb."
  type        = list(string)
}