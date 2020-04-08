resource "random_shuffle" "pub_az" {
  input = data.aws_availability_zones.available.names
  result_count = length(var.pub_subnets)
}


resource "random_shuffle" "pvt_az" {
  input = data.aws_availability_zones.available.names
  result_count = length(var.pvt_subnets)
}