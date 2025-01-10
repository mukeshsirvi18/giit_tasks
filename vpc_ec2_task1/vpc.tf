provider "aws" {
  region = var.region
}

resource "aws_vpc" "nandu-vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "nandu-vpc"
  }
}


resource "aws_subnet" "nandu-pub-subnet-1" {
  vpc_id     = aws_vpc.nandu-vpc.id
  cidr_block = "10.0.0.0/25"
  tags = {
    Name = "nandu-pub-subnet-1"
  }
}

resource "aws_subnet" "nandu-pvt-subnet-1" {
  vpc_id     = aws_vpc.nandu-vpc.id
  cidr_block = "10.0.0.128/25"
  tags = {
    Name = "nandu-pvt-subnet-1"
  }
}


resource "aws_internet_gateway" "nandu-igw" {
  vpc_id = aws_vpc.nandu-vpc.id
  tags = {
    Name = "nandu-igw"
  }
}

resource "aws_eip" "nandu-nat-eip" {
  domain = "vpc"  //Without specifying vpc = true, Terraform will attempt to allocate the EIP for Classic EC2 instances
}
resource "aws_nat_gateway" "nandu-nat-gateway" {
  allocation_id = aws_eip.nandu-nat-eip.id
  subnet_id     = aws_subnet.nandu-pub-subnet-1.id

  tags = {
    Name = "nandu-nat-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.nandu-igw]
}

resource "aws_route_table" "nandu-Pub-route-table" {
  vpc_id = aws_vpc.nandu-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nandu-igw.id
  }

  tags = {
    Name = "nandu-Pub-route-table"
  }
}

resource "aws_route_table" "nandu-pvt-route-table" {
  vpc_id = aws_vpc.nandu-vpc.id

  route {
    cidr_block = "0.0.0.0/0"            //sends all outbound traffic (0.0.0.0/0) from the private subnet to the NAT Gateway
    gateway_id = aws_nat_gateway.nandu-nat-gateway.id
  }

  tags = {
    Name = "nandu-Pvt-route-table"
  }
}

resource "aws_route_table_association" "nandu-Pub-rt-association" {
  subnet_id      = aws_subnet.nandu-pub-subnet-1.id
  route_table_id = aws_route_table.nandu-Pub-route-table.id
}

resource "aws_route_table_association" "nandu-Pvt-rt-association" {
  subnet_id      = aws_subnet.nandu-pvt-subnet-1.id
  route_table_id = aws_route_table.nandu-pvt-route-table.id
}