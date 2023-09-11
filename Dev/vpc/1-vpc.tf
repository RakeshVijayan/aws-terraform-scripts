resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true   #This both requires to support the dns naming of the services. example efs requires the dns nameing 
  enable_dns_support   = true

  tags = {
    Name = "dev-main"
  }
}