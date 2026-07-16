variable "ecr_name" {
  description = "Ім'я ECR репозиторію"
  type        = string
}

variable "scan_on_push" {
  description = "Автоматичне сканування образів на вразливості при пуші"
  type        = bool
  default     = true
}