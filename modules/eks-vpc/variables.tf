variable "project_name" {
   description = "Nome do projeto utilizado para nomear as tags Name dos resources"
   type        = string
}

variable "subnet_per_az" {
   description = "Define o número de subnets por availability zone"
   type        = map(number)
}

variable "availability_zones" {
   description = "Lista de availability zones"
   type        = list(string)
}

variable "vpc_cidr_block" {
   description = "CDIR block de rede informada para criação da VPC" 
   type        = string
}

variable "igw_route_cidr_block" {
   description = "CDIR block de rede informada para criação da VPC" 
   type        = string
}