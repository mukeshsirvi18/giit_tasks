terraform {
  backend "s3" {
    bucket = "nandu-terraform-bucket353653"
    key    = "tf_statefile/terraform.tfstate"
    region = "us-east-1"
   }
}


provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"

  region = var.region
  vpc_related = {
    name            = "nandu-vpc"
    cidr            = "10.0.0.0/16"
    azs             = 3
    private_subnets = ["10.0.0.0/18", "10.0.64.0/18"]
    public_subnets  = ["10.0.128.0/18"]
  }
}

module "pub_security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
  sub_sg = {
    name = "nandu-pub-sub-sg"
    description = "Security group for public subnet"
    req_ports = [22, 443]
    req_protocol = ["tcp", "tcp"]
    req_cidr = ["0.0.0.0/0", "0.0.0.0/0"]
  }
}

module "pvt_security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
  sub_sg = {
    name = "nandu-pvt-sub-sg"
    description = "Security group for public subnet"
    req_ports = [22, 3306]
    req_protocol = ["tcp", "tcp"]
    req_cidr = ["0.0.0.0/0", "0.0.0.0/0"]
  }
}

module "pub_ec2" {
  source = "./ec2"
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.pub_security_group.sg_id]
  instance_info = {
    name = "nandu-web"
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    key_name = "ubuntupm"
    
    count = 2
    env = "dev"
    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install nginx -y
                echo "<h1>Welcome to Nandu Web Page</h1>" | sudo tee /var/www/html/index.html
                sudo service nginx start
                sudo systemctl enable nginx
                EOF
  }
}


module "pvt_ec2" {
  source = "./ec2"
  subnet_id = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.pvt_security_group.sg_id]
  instance_info = {
    name = "nandu-db"
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    key_name = "ubuntupm"
    
    count = 2
    env = "dev"
    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install nginx -y
                echo "<h1>Welcome to Nandu Web Page</h1>" | sudo tee /var/www/html/index.html
                sudo service nginx start
                sudo systemctl enable nginx
                EOF
  }
}