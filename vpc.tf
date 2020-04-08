resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "vpc-${var.project}-${var.environment}"
    Managed_By = "Terraform"
  }
}

resource "aws_subnet" "pvt" {
  count = length(var.pvt_subnets)
  vpc_id = aws_vpc.main.id

  cidr_block = var.pvt_subnets[count.index]

  availability_zone = random_shuffle.pvt_az.result[count.index]

  tags = {
    Name = "sub-pvt-${var.project}-${var.environment}-${random_shuffle.pvt_az.result[count.index]}"
    Managed_By = "Terraform"
  }
}


resource "aws_subnet" "pub" {
  count = length(var.pub_subnets)
  vpc_id = aws_vpc.main.id

  cidr_block = var.pub_subnets[count.index]

  availability_zone = random_shuffle.pub_az.result[count.index]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "sub-pub-${var.project}-${var.environment}-${random_shuffle.pub_az.result[count.index]}"
    Managed_By = "Terraform"
  }
}


data "aws_availability_zones" "available" {
  state = "available"
}

