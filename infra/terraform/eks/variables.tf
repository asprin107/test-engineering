variable "aws_profile" {
  description = "AWS profile used aws cli."
  type        = string
}

variable "aws_region" {
  type = string
}

variable "project" {
  description = "Project name."
  type        = string
}

variable "env" {
  description = "System environment."
  type        = string
}

variable "eks_public_access_cidrs" {
  description = "EKS Control plane accessible CIDRs."
  type        = list(string)
}