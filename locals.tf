# --- root/locals.tf ---

locals {
  vpc_private_subnet_cidr = [for i in range(1, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
}

locals {
  vpc_public_subnet_cidr = [for i in range(2, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
}