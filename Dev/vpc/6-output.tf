output "vpc_id" {
  value = aws_vpc.main.id
}


output "instance_id" {
  description = "Collect the instance id "
  value = aws_instance.app_server.id
}
output "instance_ip" {
    description = "Collect instance public ip"
    value = aws_instance.app_server.public_ip

}

output "instance_type" {
  description = "Collect the instance type"
  value = aws_instance.app_server.instance_type

}
