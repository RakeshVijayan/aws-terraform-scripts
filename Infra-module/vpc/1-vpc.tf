resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block      #here I declare the variable name insted of hardcoding  ,= Adjust the variable according to the class 

  enable_dns_hostnames = true           #This both requires to support the dns naming of the services. example efs requires the dns nameing 
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-main"
  }
}