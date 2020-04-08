resource "aws_internet_gateway" "gw" { 
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gw-${var.project}-${var.environment}"
    Managed_By = "Terraform"
  }
}

resource "aws_route" "igw" {
  route_table_id = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}
