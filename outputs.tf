output "master_ip" {
  value = aws_instance.ec2_master.public_ip
}

output "master_dns" {
  value = aws_instance.ec2_master.public_dns
}

output "slave_ip" {
  value = aws_instance.ec2_slave.public_ip
}

output "slave_dns" {
  value = aws_instance.ec2_slave.public_dns
}
