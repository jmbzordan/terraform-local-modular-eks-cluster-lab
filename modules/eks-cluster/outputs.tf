output "cluster_name" {
   description = "Imprime o nome do Cluster EKS"
   value       = aws_eks_cluster.cluster_eks.id
}

output "oidc_issuer" {
  description = "Imprime o issuer do OIDC criado"
  value = aws_eks_cluster.cluster_eks.identity[0].oidc[0].issuer
}

output "certificate_authority" {
   description = "Imprime a AC para login no cluster EKS"
   value       = aws_eks_cluster.cluster_eks.certificate_authority[0].data
}

output "cluster_endpoint" {
  description = "Imprime o endpoint do cluster EKS"
  value       = aws_eks_cluster.cluster_eks.endpoint
}