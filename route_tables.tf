resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt-pub-${var.project}-${var.environment}"
    Managed_By = "Terraform"
  }
}

resource "aws_route_table" "pvt_rt" {
  count = length(aws_subnet.pvt)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt-pvt-${var.project}-${var.environment}-${aws_subnet.pvt.*.availability_zone[count.index]}"
    Managed_By = "Terraform"
  }
}

resource "aws_route_table_association" "rt_pub_association" {
  count = length(aws_subnet.pub)
  subnet_id = aws_subnet.pub.*.id[count.index]
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "rt_pvt_association" {
  count = length(aws_subnet.pvt) 
  subnet_id = aws_subnet.pvt.*.id[count.index]
  route_table_id = aws_route_table.pvt_rt.*.id[count.index]
}



