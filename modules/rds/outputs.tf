output "db_endpoint" {
  value = var.use_aurora ? (length(aws_rds_cluster.aurora) > 0 ? aws_rds_cluster.aurora[0].endpoint : "") : (length(aws_db_instance.this) > 0 ? aws_db_instance.this[0].endpoint : "")
}