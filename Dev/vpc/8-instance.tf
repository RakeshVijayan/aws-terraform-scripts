resource "aws_instance" "app_server" {
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_eu_central_1a.id
  vpc_security_group_ids = [ aws_security_group.web_sg.id ]
  associate_public_ip_address = true
  key_name = "eu-central-1"

  user_data = <<-EOF
  #!/bin/bash -ex

  apt install nginx -y
  echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    Name = "MyInstance-at-eu"
  }
}
