
variable "db_user" {
  type      = string
  sensitive = true
}
variable "subnet_prefix" {
  description = "cidr block for subnet"
  type        = list(map(string))
}

