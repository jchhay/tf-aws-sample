

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "production"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_main" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "my-subnet-1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.my-subnet-1.id
  route_table_id = aws_route_table.route_main.id
}

resource "aws_security_group" "allow_web" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [aws_vpc.my_vpc.ipv6_cidr_block]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [aws_vpc.my_vpc.ipv6_cidr_block]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [aws_vpc.my_vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}
