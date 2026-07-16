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