data "aws_iam_policy_document" "eks_trusted" {
  statement {
    principals {
      type        = "Federated"
      identifiers = [var.eks_oidc_provider.name]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
      variable = "${var.eks_oidc_provider.name}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${var.eks_oidc_provider.name}:aud"
    }
  }
}