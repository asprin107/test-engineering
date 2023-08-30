resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = "${var.project}-igw"
    }
  )
}

resource "aws_nat_gateway" "main" {
  count             = length(aws_subnet.subnets_public)
  subnet_id         = aws_subnet.subnets_public[count.index].id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_ip[count.index].id

  tags = merge(
    {
      Name = "${var.project}-ngw"
    }
  )

  depends_on = [aws_subnet.subnets_public, aws_eip.nat_ip]
}

resource "aws_eip" "nat_ip" {
  count = length(aws_subnet.subnets_public)
  tags = merge(
    {
      Name = "${var.project}-nat-eip"
    }
  )
}