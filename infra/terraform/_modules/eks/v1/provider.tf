terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    argocd = {
      source  = "oboukili/argocd"
      version = "6.0.2"
    }
  }
}

provider "argocd" {
  server_addr = format("%s%s", data.kubernetes_service_v1.svc-argocd-server.status[0].load_balancer[0].ingress[0].hostname, ":80")
  username    = "admin"
  password    = data.kubernetes_secret.argocd-initial-pwd.data.password
  insecure    = true
  plain_text  = true
}