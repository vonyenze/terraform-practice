# --- vpc/main.tf ----

resource "random_integer" "random" {
  min = 1
  max = 100
}

data "aws_availability_zones" "available" {}

resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "onyen_vpc-${random_integer.random.id}"
  }
}

resource "aws_subnet" "public_subnet" {
  count = var.public_sn_count
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "onyen_public-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.private_sn_count
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_cidrs[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "onyen_private-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "onyen_igw-${random_integer.random.id}"
  }
}

data "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "igw_route_entry" {
  route_table_id = data.aws_route_table.vpc_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc_igw.id
}
