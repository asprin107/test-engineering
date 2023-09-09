# Prometheus EFS
resource "aws_efs_file_system" "prometheus" {
  creation_token = "${local.naming_rule}-prometheus"
  encrypted      = true
}

resource "aws_efs_mount_target" "prometheus" {
  for_each = { for v in var.eks_subnets : v => v }

  file_system_id  = aws_efs_file_system.prometheus.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs-prometheus.id]
}

data "aws_vpc" "eks" {
  id = var.vpc_id
}

resource "aws_security_group" "efs-prometheus" {
  name        = "seg-eks-efs-prometheus"
  description = "EFS sg for prometheus."
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access using SFTP in eks cluster."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.eks.cidr_block]
  }
  ingress {
    description = "Allow access using NFS in eks cluster."
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.eks.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#resource "aws_efs_file_system_policy" "prometheus" {
#  file_system_id = aws_efs_file_system.prometheus.id
#  policy         = data.aws_iam_policy_document.efs-prometheus.json
#}
#
#data "aws_iam_policy_document" "efs-prometheus" {
#  statement {
#    sid = "AllowEFSAccess"
#    principals {
#      type = "AWS"
#      identifiers = [aws_iam_role.irsa-prometheus.arn]
#    }
#    effect  = "Allow"
#    actions = [
#      "elasticfilesystem:ClientMount",
#      "elasticfilesystem:ClientWrite",
#    ]
#    resources = [aws_efs_file_system.prometheus.arn]
#    condition {
#      test     = "Bool"
#      variable = "elasticfilesystem:AccessedViaMountTarget"
#      values   = ["true"]
#    }
#  }
#}


# Prometheus IRSA
resource "aws_iam_role" "irsa-prometheus" {
  name               = "eks-irsa-prometheus"
  assume_role_policy = data.aws_iam_policy_document.irsa_trusted.json
}

resource "aws_iam_role_policy" "irsa-prometheus-efs" {
  role   = aws_iam_role.irsa-prometheus.id
  policy = data.aws_iam_policy_document.prometheus.json
}

data "aws_iam_policy_document" "irsa_trusted" {
  statement {
    principals {
      type        = "Federated"
      identifiers = [var.eks_oidc_provider.name]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:monitoring:prometheus-server"]
      variable = "${var.eks_oidc_provider.name}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${var.eks_oidc_provider.name}:aud"
    }
  }
}

data "aws_iam_policy_document" "prometheus" {
  statement {
    effect = "Allow"
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
    ]
    resources = [aws_efs_file_system.prometheus.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
    }
  }
}