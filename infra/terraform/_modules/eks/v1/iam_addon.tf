# LoadBalancer Controller
resource "aws_iam_role" "lb_controller" {
  name               = "AmazonEKSLoadBalancerControllerRole-${local.naming_rule}"
  assume_role_policy = data.aws_iam_policy_document.lb_controller_trusted.json
}

resource "aws_iam_policy" "lb_controller" {
  name   = "AWSLoadBalancerControllerIAMPolicy-${local.naming_rule}"
  policy = file("${path.module}/resources/iam_policy/lb_controller_policy.json")
}

resource "aws_iam_role_policy_attachment" "lb_controller" {
  role       = aws_iam_role.lb_controller.name
  policy_arn = aws_iam_policy.lb_controller.arn
}