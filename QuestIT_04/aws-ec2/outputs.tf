output "ec2_public_ip" {
  //value
  value = aws_instance.raorane.public_ip
}

output "ec2_instance_type" {
  //value
  value = aws_instance.raorane.instance_type
}