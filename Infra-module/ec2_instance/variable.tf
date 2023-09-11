variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "associate_public_ip" {
  description = "Flag to associate public IP to the EC2 instance"
  type        = bool
}

variable "key_name" {
  description = "Key pair name for SSH access"
}

variable "env" {
  description = "Environmet name"
  type = string
}

# variable "Instance_tags" {
#   description = "Tags for the Instance"
#   type        = map(string)
#   default     = {}
# }