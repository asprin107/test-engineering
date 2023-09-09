#resource "aws_iam_role" "aws-efs-csi-driver" {
#  name               = "eks-irsa-${local.naming_rule}-aws-efs-csi-driver"
#  assume_role_policy = data.aws_iam_policy_document.eks_trusted.json
#}
#
#resource "aws_iam_role_policy" "aws-efs-csi-driver" {
#  name   = "AllowReadAndWriteEFS"
#  policy = file("${path.module}/resources/iam-policy-aws-efs-csi-driver.json")
#  role   = aws_iam_role.aws-efs-csi-driver.id
#}