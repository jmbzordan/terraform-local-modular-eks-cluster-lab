# variável que define a quantidade de réplicas de um resource que serão criadas. Esse número é comum a recursos como
# private e public subnets, availability zones, nodes kubernetes
/*variable "availability_zones" {
  description = "Lista de Availability Zones com a quantidade de subnets desejadas para cada zone"
  type = map(number)

  default = {}
}*/

variable "project_name" {
   description = "Nome do projeto utilizado para nomear as tags Name dos resources"
   type        = string
}

variable "public_subnets" {
   description = "Lista de IDs das subnets publicas"
   type        = list(string)
}
