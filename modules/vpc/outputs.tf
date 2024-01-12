
output "internet_gateway" {
  value = aws_internet_gateway.gw
}

output "security_group_id" {
  value = aws_security_group.allow_web.id
}

output "subnet_id" {
  value = aws_subnet.my-subnet-1.id
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
