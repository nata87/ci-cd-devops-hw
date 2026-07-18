resource "aws_db_instance" "this" {
  count = var.use_aurora ? 0 : 1

  identifier           = "${var.name}-db"
  engine               = "postgres"
  
  # Ось тут ми підставляємо вашу змінну:
  instance_class       = var.instance_class 
  
  allocated_storage    = var.allocated_storage
  username             = var.username
  password             = var.password
  
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  skip_final_snapshot  = true
}