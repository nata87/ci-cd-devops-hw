# 1. Группа підмереж для бази даних
resource "aws_db_subnet_group" "this" {
  name       = "main-db-subnet-group"
  subnet_ids = var.subnet_ids 

  tags = {
    Name = "Main DB Subnet Group"
  }
}

# 2. Security Group для бази даних
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound traffic to database"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} # <-- Ось тут має бути кінець файлу!