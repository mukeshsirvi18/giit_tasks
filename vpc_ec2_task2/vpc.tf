provider "aws" {
  region = var.region 
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "nandu-vpc"
  cidr = "10.0.0.0/24"

  azs             = ["us-west-1a", "us-west-1b"]
  private_subnets = ["10.0.0.0/25"]
  public_subnets  = ["10.0.0.128/25"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  tags = {
    Name = "nandu-vpc"
    Env = "Dev"
  }
}
