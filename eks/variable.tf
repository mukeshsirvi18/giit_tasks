variable "region" {
    default = "us-east-1"
}

variable "vpc_related" {
  type = object({
    name            = string
    cidr            = string
    azs             = number
    private_subnets = list(string)
    public_subnets  = list(string)
  })
  default = {
    name             = "nandu-vpc"
    cidr             = "10.0.0.0/16"
    azs              = 3
    private_subnets  = ["10.0.0.0/18", "10.0.64.0/18"]
    public_subnets   = ["10.0.128.0/18"]
  }
}




