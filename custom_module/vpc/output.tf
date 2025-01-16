output "vpc_id" {
  description = "The ID of the created VPC"
  value = module.vpc.vpc_id  
}

output "public_subnets" {
  description = "The ID of the created subnet"
  value = module.vpc.public_subnets
}

output "private_subnets" {
  description = "The ID of the created subnet"
  value = module.vpc.private_subnets
}