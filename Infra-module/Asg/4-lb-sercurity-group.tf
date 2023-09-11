resource "aws_security_group" "this" {
  name = "${var.env}-albsg"
  # Allow inbound HTTP requests
  ingress {
    fromalb-protocal_port   = var.alb_ingress_port
    to_port     = var.alb_ingress_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = var.alb_egress_from_port
    to_port     = var.alb_egress_to_port
    protocol    = var.alb_egress_protocol
    cidr_blocks = var.alb_egress_cidr
  }
}