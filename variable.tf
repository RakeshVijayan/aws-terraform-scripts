variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EC2 instance"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Flag to associate public IP to the EC2 instance"
  type        = bool
}

variable "ingress_ports" {
  description = "List of ingress ports to allow in the security group"
  type        = list(number)
}

variable "key_name" {
  description = "Key pair name for SSH access"
}