resource "aws_kms_key" "db_postgres_key" {
  description = "Example KMS Key"
}

resource "aws_db_instance" "default" {
  allocated_storage             = 10
  db_name                       = "mydb"
  engine                        = "postgres"
  engine_version                = "16.1"
  instance_class                = "db.t3.micro"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.db_postgres_key.key_id
  username                      = var.db_user
}