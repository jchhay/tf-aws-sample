variable "availability_zone" {
  description = "AZ to be used"
  default     = "us-east-1a"
  type        = string
}

variable "subnet_prefix" {
  description = "cidr block for subnet"
  type        = list(map(string))
}

variable "vpc_cidr" {
  description = "cidr block for vpc"
  type        = string
}