variable "project_name" {
   description = "Nome do projeto utilizado para nomear as tags Name dos resources"
   type        = string
}

variable "private_subnets" {
   description = "Lista de IDs das subnets privadas"
   type        = list(string)
}

variable "cluster_name" {
   description = "Nome do cluster EKS"
   type        = string
}