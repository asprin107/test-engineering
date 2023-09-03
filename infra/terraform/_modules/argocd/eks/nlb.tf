resource "aws_lb" "eks" {
  name               = local.naming_rule
  internal           = false
  load_balancer_type = "network"
  security_groups    = var.lb_security_groups
  subnets            = var.lb_subnets
  enable_http2       = true
  ip_address_type    = "ipv4"

  tags = var.tags
}

resource "aws_lb_target_group" "eks" {
  for_each    = { for k, v in yamldecode(file("${path.module}/tg_svc.yaml")) : k => v }
  name        = each.key
  target_type = "ip"
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  port        = each.value.service_port
}

resource "aws_lb_listener" "eks" {
  for_each          = { for k, v in yamldecode(file("${path.module}/tg_svc.yaml")) : k => v }
  load_balancer_arn = aws_lb.eks.id
  port              = each.value.listen_port
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.eks[each.key].arn
    type             = "forward"
  }
}