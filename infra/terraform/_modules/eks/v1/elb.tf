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