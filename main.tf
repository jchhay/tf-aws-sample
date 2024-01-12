terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

module "my_vpc" {
  source = "./modules/vpc"

  availability_zone = "us-east-1a"
  subnet_prefix     = var.subnet_prefix
}

module "my_ec2" {
  source = "./modules/ec2"

  instance_type     = "t2.micro"
  internet_gateway  = module.my_vpc.internet_gateway
  availability_zone = "us-east-1a"
  security_group_id = module.my_vpc.security_group_id
  subnet_id         = module.my_vpc.subnet_id



}