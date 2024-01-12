variable "availability_zone" {
  description = "AZ to be used"
  default     = "us-east-1a"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "internet_gateway" {
  type = any
}

variable "security_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}