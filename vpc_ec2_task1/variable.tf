variable "region" {
  description = "The region in which the resources will be deployed"
  type        = string
  default     = "us-west-1"

}

variable "instance_count" {
  type = map(string)
  default = {
    "nandu-instance-pub" = 2,
    "nandu-instance-pvt" = 2
  }
  
}

