resource "aws_eip" "nat" {     #Resource crate Elastic IP in the resource for nat, VPC =true means it will associate with vpc
  vpc = true

  tags = {
    Name = "dev-nat"
  }
}

#This nat gateway is used in route to give internet access for the private subnete servers. check in route.tf
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_eu_central_1a.id

  tags = {
    Name = "dev-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}