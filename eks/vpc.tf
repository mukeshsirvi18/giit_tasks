provider "aws" {
  region = var.region 
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_related["name"]
  cidr = var.vpc_related["cidr"]

  azs             = [for i, name in data.aws_availability_zones.available.names: name if i < var.vpc_related["azs"]]
  private_subnets = var.vpc_related["private_subnets"]
  public_subnets  = var.vpc_related["public_subnets"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  tags = {
    Name = "nandu-vpc"
    Env = "Dev"
  }
}
