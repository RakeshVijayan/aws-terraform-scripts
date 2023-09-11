resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}