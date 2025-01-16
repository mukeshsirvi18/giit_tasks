variable "vpc_id" {
  type = string
}

variable "sub_sg" {
  type = object({
    name        = string
    description = string
    req_ports   = list(number)
    req_protocol = list(string)
    req_cidr    = list(string)
  })
}

