provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "local" {
    path = "dev/vpc/terraform.tfstate"

  }
}

module "vpc" {
  source = "../../Infra-module/vpc"

  env             = "dev"
  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.31.0/24", "10.0.32.0/24"]
  public_subnets  = ["10.0.61.0/24", "10.0.62.0/24"]
  # ingress_ports   = ["80", "22"]




  private_subnet_tag = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/dev-demo"  = "owned"
  }

  public_subnet_tag = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/dev-demo"  = "owned"
  }

}

# module "instance" {
#   source              = "../../Infra-module/instance"
#   ami_id              = "ami-04e601abe3e1a910f"
#   instance_type       = "t2.micro"
#   subnet_ids          = module.vpc.private_subnets_id
#   security_group_ids  = [module.vpc_security_group_id]
#   associate_public_ip = true
#   ingress_ports   = ["80", "22"]
#   key_name            = "eu-central-1"
#   user_data           = <<-EOF
#     #!/bin/bash -ex

#     apt install nginx -y
#     echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" > /usr/share/nginx/html/index.html
#     systemctl enable nginx
#     systemctl start nginx
#     EOF
#   tags = {
#     Name = "MyInstance-at-eu"
#   }
# }
module "ec2_instance" {
  source              = "../../Infra-module/ec2_instance"
  env                 = "dev"
  public_subnet_ids   = module.vpc.public_subnet_ids
  ami_id              = "ami-08e5424edfe926b43"
  instance_type       = "t3.micro"
  # subnet_ids          = module.vpc.private_subnets
  # security_group_ids  = [module.vpc_security_group]
  associate_public_ip = true
  # ingress_ports       = [80, 22]  # Specify the desired ingress ports here
   key_name            = "rakesh"
}


