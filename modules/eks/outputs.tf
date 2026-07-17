output "eks_cluster_endpoint" {
  description = "API endpoint для підключення до кластера"
  value       = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_name" {
  description = "Назва EKS кластера"
  value       = aws_eks_cluster.eks.name
}

output "eks_node_role_arn" {
  description = "IAM role ARN для воркер-нодів"
  value       = aws_iam_role.nodes.arn
}

output "eks_cluster_ca_certificate" {
  description = "CA сертифікат кластера для Helm"
  value       = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
}

output "eks_cluster_token" {
  description = "Токен для доступу до кластера"
  value       = data.aws_eks_cluster_auth.eks.token
  sensitive   = true
}