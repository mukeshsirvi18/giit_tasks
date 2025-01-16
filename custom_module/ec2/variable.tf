variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string) 
  
}

variable "instance_info" {
  type = object({
    name        = string
    ami         = string
    instance_type = string
    key_name    = string
    count       = number
    user_data   = string
    env        = string

  })
}
