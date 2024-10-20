variable "project_name" {
   description = "Nome do projeto utilizado para nomear as tags Name dos resources"
   type        = string
}

variable "oidc_issuer" {
   description = "Issuer do OIDC criado no módulo do Cluster EKS"
   type        = string
}

variable "cluster_name" {
   description = "Nome do cluster EKS"
   type        = string
}