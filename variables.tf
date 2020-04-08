variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "pvt_subnets" {
  type = list(string)
}

variable "pub_subnets" {
  type = list(string)
}
