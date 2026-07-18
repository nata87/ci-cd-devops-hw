variable "name" {
  description = "Project name"
  type        = string
}

variable "use_aurora" {
  description = "Switch between RDS and Aurora"
  type        = bool
  default     = false
}

variable "aurora_replica_count" {
  type    = number
  default = 1
}

variable "engine_cluster" {
  type    = string
  default = "aurora-postgresql"
}

variable "engine_version_cluster" {
  type    = string
  default = "15.3"
}

variable "parameter_group_family_aurora" {
  type    = string
  default = "aurora-postgresql15"
}

variable "instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "db_name" {
  type    = string
  default = "myapp"
}

variable "username" {
  type    = string
  default = "dbadmin"
}

variable "password" {
  type    = string
  sensitive = true
}

variable "vpc_id" {
  description = "VPC ID where DB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "parameters" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}