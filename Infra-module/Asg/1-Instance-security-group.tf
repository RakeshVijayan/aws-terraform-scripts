resource "aws_security_group" "this" {
  name = "ENV"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
    from_port   = var.ingress_rules.from_port
    to_port     = var.ingress_rules.to_port
    protocol    = var.ingress_rules.protocol
    cidr_blocks = var.ingress_rules.cidr
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port = var.egress_rules.from_port
      to_port = var.egress_rules.to_port
      protocol = var.ingress_rules.protocol
      cidr_blocks = var.ingress_rules.cidr
    }
    
  }
}