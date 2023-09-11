resource "aws_autoscaling_group" "this" {
  launch_configuration = aws_launch_configuration.this.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.this.arn]
  health_check_type = var.health_check

  min_size = var.min_size
  max_size = var.max_size

  tag {
    Name = "${var.env}-asg"
    propagate_at_launch = true
  }
}