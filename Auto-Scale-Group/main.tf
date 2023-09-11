provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# resource "aws_instance" "project" {
#   ami           = "ami-08e5424edfe926b43"
#   instance_type = "t3.micro"

#   vpc_security_group_ids = [aws_security_group.instance.id]

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World" > index.html
#               nohup busybox httpd -f -p ${var.server_port} &
#               EOF

#   user_data_replace_on_change = true

#   tags = {
#     Name = "my-ubuntu"
#   }
# }

resource "aws_launch_configuration" "project" {
  name_prefix = "project-lc"
  image_id        = "ami-08e5424edfe926b43"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Test success" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Required with an autoscaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instance" {
  name = "ENV"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "project" {
  launch_configuration = aws_launch_configuration.project.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "ENV"
    propagate_at_launch = true
  }
}

resource "aws_lb" "project" {
  name               = "ENV"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.project.arn
  port              = 80
  protocol          = "HTTP"

  # By default, it just shows a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = 404
    }
  }
}

resource "aws_security_group" "alb" {
  name = "ENV-alb"
  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "ENV-project"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

#Scale up policy 

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "project_scale_up"
  autoscaling_group_name = aws_autoscaling_group.project.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = "Monitors CPU utilization for project ASG seems high"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = "Project_scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "50"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.project.name
  }
}

  

#Scaling Down Policy 
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "project_scale_down"
  autoscaling_group_name = aws_autoscaling_group.project.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitors CPU utilization for project ASG is normal now"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "Project_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "10"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.project.name
  }
}
