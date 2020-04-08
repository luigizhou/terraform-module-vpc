output "vpc_id" {
  value = aws_vpc.main.id
  description = "vpc_id"
}

output "pvt_subnets" {
  value = aws_subnet.pvt.*.id
}

output "pub_subnets" {
  value = aws_subnet.pub.*.id
}
output "igw" {
  value = aws_internet_gateway.gw.id
}

output "ngw" {
  value = aws_nat_gateway.ngw.*.id
}