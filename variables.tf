# --- root/variables.tf ---

variable "aws_region" {
  default = "us-east-1"
}

# variable "aws_region_az" {
#   type = list
#   default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
# }

variable "vpc_cidr_block" {
  type = string
  default = "10.123.0.0/16"
}

# variable "vpc_public_subnet_cidr" {
#   type = list
#   default = ["10.123.2.0/24", "10.123.4.0/24"]
# }

# variable "vpc_private_subnet_cidr" {
#   type = list
#   default = ["10.123.1.0/24", "10.123.3.0/24", "10.123.5.0/24"]
# }

locals {
  vpc_private_subnet_cidr = [for i in range(1, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
}

locals {
  vpc_public_subnet_cidr = [for i in range(2, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
}