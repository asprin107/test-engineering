terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    #    argocd = {
    #      source  = "oboukili/argocd"
    #      version = "5.3.0"
    #    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

provider "kubernetes" {
  host                   = module.eks.eks_endpoint
  cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name, "--profile", var.aws_profile]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.eks_endpoint
    cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name, "--profile", var.aws_profile]
      command     = "aws"
    }
  }
}