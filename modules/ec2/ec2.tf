
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = var.subnet_id
  private_ips     = ["10.0.1.50"]
  security_groups = [var.security_group_id]

}

# Elastic IP requires explicit depends_on to Internet Gateway
resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [var.internet_gateway]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["99999999999"]
}

resource "aws_instance" "app-server" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = "my-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo your very first web server > /var/www/html/index.html'
                EOF

  tags = {
    Name = "Web Server"
  }
}