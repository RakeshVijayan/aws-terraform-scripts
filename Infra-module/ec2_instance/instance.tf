# resource "aws_instance" "example_instance" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   subnet_id     = var.subnet_ids[0]  # Assuming only one subnet is passed, change this logic if multiple subnets are provided
#   security_group_ids = var.security_group_ids
#   associate_public_ip = var.associate_public_ip
#   key_name      = var.key_name

#   # Add any additional EC2 instance configuration you require
# }

# variable "public_subnet_ids" {
#   description = "List of public subnet IDs"
#   type        = list(string)
# }

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[0]  # Assuming you want to launch the instance in the first public subnet
  associate_public_ip_address = var.associate_public_ip
  key_name = var.key_name

  tags = {
    Name = "${var.env}-Server"
  }
}

# output "instance_id" {
#   value = aws_instance.this.id
# }

# output "public_ip" {
#   value = aws_instance.this.public_ip
# }
