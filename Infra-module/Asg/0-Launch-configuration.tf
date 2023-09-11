resource "aws_launch_configuration" "this" {
  name_prefix = var.env
  image_id        = var.image_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.this.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Test success" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Required with an autoscaling group.
  lifecycle {
    create_before_destroy = var.cbd
  }
}