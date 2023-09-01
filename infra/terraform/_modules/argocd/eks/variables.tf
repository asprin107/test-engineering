variable "namespace" {
  description = "Kubernetes namespace for argocd."
  type        = string
}

variable "project" {
  description = "Project name."
  type        = string
}

variable "env" {
  description = "System environment."
  type        = string
}

variable "lb_subnet_ids" {
  description = "List subnet ids that target group would be deployed."
  type        = list(string)
}