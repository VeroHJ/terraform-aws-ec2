resource "aws_key_pair" "ec2_ssh_key" {
  key_name = var.ssh_key_name
  public_key = file(var.ssh_key_path)
  tags = {
    "Name" = "ec2_ssh_key"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name = var.security_group_name
  description = "Allow SSH and HTTP traffic"
  vpc_id = aws_default_vpc.ec2_vpc.id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ec2_security_group"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_security_group" "ec2_security_group_slave" {
  name = var.security_group_name_slave
  description = "Allow SSH"
  vpc_id = aws_default_vpc.ec2_vpc.id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ec2_security_group_slave"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_instance" "ec2_master" {
  subnet_id = data.aws_subnet.ec2_subnet.id
  ami = var.ami
  instance_type = var.instance_type_master
  key_name = aws_key_pair.ec2_ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  private_ip = "172.31.6.120"
  associate_public_ip_address = true
  tags = {
    "Name" = "ec2_master_jenkins"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
    "Backup_jenkins" = "True"
  }
}

resource "aws_instance" "ec2_slave" {
  subnet_id = data.aws_subnet.ec2_subnet.id
  ami = var.ami
  instance_type = var.instance_type_slave
  key_name = aws_key_pair.ec2_ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_security_group_slave.id]
  private_ip = "172.31.6.121"
  associate_public_ip_address = true
  tags = {
    "Name" = "ec2_slave_jenkins"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
    "Backup_jenkins" = "True"
  }
}

