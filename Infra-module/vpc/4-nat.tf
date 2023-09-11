resource "aws_eip" "this" {     #Resource crate Elastic IP in the resource for nat, VPC =true means it will associate with vpc
  vpc = true

  tags = {
    Name = "${var.env}-nat"
  }
}

#This nat gateway is used in route to give internet access for the private subnete servers. check in route.tf
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.env}-nat"
  }

  depends_on = [aws_internet_gateway.this]
}