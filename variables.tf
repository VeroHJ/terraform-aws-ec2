variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-04d29b6f966df1537"
}

variable "instance_type_master" {
  default = "t3.medium"
}

variable "instance_type_slave" {
  default = "t3.small"
}

variable "ssh_key_path" {
  default = "ssh/id_rsa.pub"
}

variable "ssh_key_name" {
  default = "ec2-ssh-key"
}

variable "security_group_name" {
  default = "ec2-security-group"
}
variable "security_group_name_slave" {
  default = "ec2-security-group-slave"
}


