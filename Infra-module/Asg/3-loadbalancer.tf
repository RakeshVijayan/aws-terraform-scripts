resource "aws_lb" "this" {
  name               = var.env
  load_balancer_type = var.lb-type
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.this.id]
}