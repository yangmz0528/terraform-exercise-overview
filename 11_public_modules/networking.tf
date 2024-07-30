locals {
  vpc_cidr              = "10.0.0.0/16"
  private_subnets_cidrs = ["10.0.0.0/24"]
  public_subnets_cidrs  = ["10.0.128.0/24"]
}

data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  cidr            = local.vpc_cidr
  name            = local.project_name
  azs             = data.aws_availability_zones.azs.names
  private_subnets = local.private_subnets_cidrs
  public_subnets  = local.public_subnets_cidrs

  tags = local.common_tags
}
