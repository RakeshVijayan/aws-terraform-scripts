output "vpc_id" {
  value = module.vpc.vpc_id
}

// Print the private subnet IDs
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

// Print the public subnet IDs
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

// Print the Instance details

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}