data "aws_internet_gateway" "ec2_i_gateway" {
 tags = {
   "Name" = "NVRG-IGW"
 }

}

resource "aws_default_vpc" "ec2_vpc" {
}

/*resource "aws_subnet" "ec2_subnet" {
  vpc_id = aws_default_vpc.ec2_vpc.id
  cidr_block = "172.31.7.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "ec2_subnet"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}*/

data "aws_subnet" "ec2_subnet" {
  cidr_block = "172.31.6.0/24"
}


resource "aws_route_table" "ec_route_table" {
  vpc_id = aws_default_vpc.ec2_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.ec2_i_gateway.id
  }

  tags = {
    "Name" = "ec2_route_table"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_route_table_association" "ec_rt_association" {
  route_table_id = aws_route_table.ec_route_table.id
  subnet_id = data.aws_subnet.ec2_subnet.id
}
