
#here both the private and public have the same route only with in the VPC 

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id      #nat_gateway_id here using, ensure for public route table gateway_id is used 
  }

  tags = {
    Name = "dev-private-route"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id   #gateway_id must be provide here to allow the internet connection 
  }

  tags = {
    Name = "dev-public-route"
  }
}


resource "aws_route_table_association" "private_eu_central_1a" {
  subnet_id      = aws_subnet.private_eu_central_1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_eu_central_1b" {
  subnet_id      = aws_subnet.private_eu_central_1b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_eu_central_1a" {
  subnet_id      = aws_subnet.public_eu_central_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_eu_central_1b" {
  subnet_id      = aws_subnet.public_eu_central_1b.id
  route_table_id = aws_route_table.public.id
}

