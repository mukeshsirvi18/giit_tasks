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

}