output "public_subnets" {
  description = "Imprime os IDs das subnets publicas"
  value       = local.public_subnet_list
}

output "private_subnets" {
  description = "Imprime os IDs das subnets privadas"
  value       = local.private_subnet_list
}

