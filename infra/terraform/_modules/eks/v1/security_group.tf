resource "aws_security_group" "eks" {
  name = "seg-${local.naming_rule}-eks"

  description = "default sg for eks."
  vpc_id      = var.eks_vpc_id

  ingress {
    description = "Allow ingress all from private network."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }

  egress {
    description = "Allow egress to all."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}