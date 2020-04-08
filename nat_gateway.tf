resource "aws_nat_gateway" "ngw" {
  count = length(aws_subnet.pub)
  allocation_id = aws_eip.ngw.*.id[count.index]
  subnet_id = aws_subnet.pub.*.id[count.index]
}

resource "aws_route" "ngw" {
  count = length(aws_nat_gateway.ngw)
  route_table_id = aws_route_table.pvt_rt.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  ## TODO: Fix as I'm not sure if I get the correct nat gateway per AZ
  nat_gateway_id = aws_nat_gateway.ngw.*.id[count.index % 3]
}

resource "aws_eip" "ngw" {
  count = length(aws_subnet.pub)
  vpc = true
}

