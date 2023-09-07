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

variable "elb_id" {
  description = "ELB id for eks service."
  type        = string
}