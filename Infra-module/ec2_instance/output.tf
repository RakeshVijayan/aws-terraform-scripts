
# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/blob/master/outputs.tf
# Reffer incase if we needed  the output doubts in the above link 


output "instance_id" {
  value = aws_instance.this[*].id
}

output "public_ip" {
  value = aws_instance.this[*].public_ip
}
