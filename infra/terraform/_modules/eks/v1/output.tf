output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "eks_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "eks_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}