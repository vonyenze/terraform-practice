# --- root/main.tf ---

module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr_block
  public_sn_count = 3
  private_sn_count = 5
  max_subnets = 20
  public_cidrs = local.vpc_public_subnet_cidr
  private_cidrs = local.vpc_private_subnet_cidr
  # region_az = var.aws_region_az
}