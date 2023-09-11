variable "env" {
  description = "environment variable"
  type = string
}

variable "image_id" {
  description = "Ami id of the instance"
  type = string
}

variable "instance_type" {
  description = "Instance size "
  type = string
}

variable "server_port" {
  description = "Exposed application from the busybox"
  type =  string
}

variable "key_name" {
  description = "Name of key pair"
  type  = string
}

variable "cbd" {
  description = "Create before destroy"
  type = bool
}

variable "ingress_rules" {
  description = "List of ingress rule for instance sg"
  type = list (object ({
    from_port = number
    to_port   = number
    protocol  = string
    cidr      = string 
  }))
  default = [ {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr = "0.0.0.0/24"
  } 
  ]
}

variable "egress_rules" {
  description = "List of egress rules for the security group"
  type        = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr      = string
  }))
  default = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr      = "0.0.0.0/0"
    }
    
  ]
}

variable "health_check" {
  description = "Health check type of autoscale group"
  type = string 
}

variable "min_size" {
  description = "Instance Minimum Count"
  type = number
}

variable "max_size" {
  description = "Instance Miximum Count"
  type = number
}

variable "lb-type" {
  description = "Aplication or Network "
  type = string 
}

###alb
variable "alb_ingress_port" {
  description = "The port for ingress traffic to the Application Load Balancer"
  type        = number
  default     = 80
}

variable "alb_egress_from_port" {
  description = "The start port for egress traffic from the Application Load Balancer"
  type        = number
  default     = 0
}

variable "alb_egress_to_port" {
  description = "The end port for egress traffic from the Application Load Balancer"
  type        = number
  default     = 0
}

variable "alb_egress_protocol" {
  description = "The protocol for egress traffic from the Application Load Balancer"
  type        = string
  default     = "-1"
}

variable "alb_egress_cidr" {
  description = "The CIDR block for egress traffic from the Application Load Balancer"
  type        = string
  default     = "0.0.0.0/0"
}
