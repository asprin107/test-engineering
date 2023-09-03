# Change default coreDNS can be deployed fargate. (default can only deploy to ec2. "eks.amazonaws.com/compute-type : ec2")
#kubectl patch deployment coredns \
#  -n kube-system \
#  --type json \
#  -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
resource "aws_eks_addon" "coredns" {
  addon_name                  = "coredns"
  cluster_name                = aws_eks_cluster.main.name
  addon_version               = "v1.10.1-eksbuild.3"
  resolve_conflicts_on_create = "OVERWRITE"
  configuration_values = jsonencode({
    computeType = "Fargate"
  })
}

resource "helm_release" "lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.main.name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.lb_controller.arn
  }

  set {
    name  = "region"
    value = data.aws_region.current.name
  }

  set {
    name  = "vpcId"
    value = var.eks_vpc_id
  }

  depends_on = [aws_eks_fargate_profile.fargate, kubernetes_config_map_v1.fargate_logging]
}