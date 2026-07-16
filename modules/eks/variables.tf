variable "cluster_name" {
  description = "Назва EKS кластера"
  type        = string
  default     = "example-eks-cluster"
}

variable "subnet_ids" {
  description = "Список ID підмереж для EKS"
  type        = list(string)
}

variable "instance_type" {
  description = "Тип EC2 інстансів для вузлів"
  type        = string
  default     = "t3.small"
}

variable "desired_size" {
  description = "Бажана кількість воркер-нодів"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Максимальна кількість воркер-нодів"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Мінімальна кількість воркер-нодів"
  type        = number
  default     = 1
}