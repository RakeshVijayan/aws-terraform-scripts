variable "env" {
  description = "Environmet name"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIDR classless inter-dommain routing"
  type = string
  default = "10.0.0.0/16"
}
  
variable "azs" {
  description = "Availability zone for subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "CIDR range for private subnet"
  type = list(string)
}

variable "public_subnets" {
  description = "CIDR range for the public subnet"
  type = list(string)
}

variable "private_subnet_tag" {
  description = "Tag for private subnet"
  type = map(any)
}

variable "public_subnet_tag" {
  description = "Tag for public subnet"
  type = map(any)
}


# variable "security_group_name" {
#   description = "Name of the security group"
#   type        = string
# }

#This is use to map the security group module 

# variable "ingress_ports" {
#   description = "List of ingress port to allow traffic"
#   type = list(number)
# }


# variable "tags" {
#   description = "Tags for the security group"
#   type        = map(string)
#   default     = {}
# }

# #Instance Variable definition comes here... 

# variable "ami_id" {
#   description = "ID of the AMI"
#   type        = string
# }

# variable "instance_type" {
#   description = "Type of the instance"
#   type        = string
# }

# # We can call this from the vpc section

# # variable "subnet_ids" {
# #   description = "List of subnet IDs"
# #   type        = list(string)
# # }

# variable "security_group_ids" {
#   description = "List of security group IDs"
#   type        = list(string)
# }

# variable "associate_public_ip" {
#   description = "Flag to associate a public IP address"
#   type        = bool
# }

# variable "key_name" {
#   description = "Name of the key pair"
#   type        = string
# }

# variable "user_data" {
#   description = "User data script for instance configuration"
#   type        = string
# }
