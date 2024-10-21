#VERIFICAR ARQUIVO aws-vpc-reqs.txt PARA REQUISITOS DE VPC PARA EKS DA AWS

resource "aws_vpc" "vpc" {
   cidr_block           = var.vpc_cidr_block
   enable_dns_hostnames = true                #VPC necessita DNS hostname e suporte DNS para os nodes conseguirem se registrar no cluster
   enable_dns_support   = true
   tags                 = { Name = "${var.project_name}-vpc" }
}


resource "aws_subnet" "public_subnets" {
   for_each                   = { for key,value in local.subnets : key => value if value.subnet_num == 0 }
      vpc_id                  = aws_vpc.vpc.id
      cidr_block              = cidrsubnet( var.vpc_cidr_block, 8, (each.value.subnet_num * 2) + index(var.availability_zones, each.value.az) ) 
      availability_zone       = each.value.az
      map_public_ip_on_launch = true
      tags                    = { 
                                   Name = "${var.project_name}-subnet-${each.value.az}-pub-${each.value.subnet_num + 1}",
                                   "kubernetes.io/role/elb" = 1 
                                }
}


resource "aws_subnet" "private_subnets" {
   for_each                   = { for key,value in local.subnets : key => value if value.subnet_num != 0 }
      vpc_id                  = aws_vpc.vpc.id
      cidr_block              = cidrsubnet( var.vpc_cidr_block, 8, (each.value.subnet_num * 2) + index(var.availability_zones, each.value.az) ) 
      availability_zone       = each.value.az
      map_public_ip_on_launch = false
      tags                    = { 
                                   Name = "${var.project_name}-subnet-${each.value.az}-priv-${each.value.subnet_num + 1}",
                                   "kubernetes.io/role/internal-elb" = 1 
                                }
}


resource "aws_internet_gateway" "igateway" {
   vpc_id = aws_vpc.vpc.id
   tags   = { Name = "${var.project_name}-internet-gateway" }
}


resource "aws_eip" "elastic_ips" {
   for_each  = { for idx,az in var.availability_zones : idx => az }
      domain = "vpc"
      tags   = { Name = "${var.project_name}-elastic-ip-${each.value}" }
}


resource "aws_nat_gateway" "ngateway" {
   for_each         = { for idx,az in var.availability_zones : idx => az }
      allocation_id = aws_eip.elastic_ips[each.key].allocation_id
      subnet_id     = values(aws_subnet.public_subnets)[each.key].id 
      tags          = { 
                         Name = "${var.project_name}-nat-gateway-${each.value}",
                         "AZ" = "${each.value}" 
                      }
}


resource "aws_route_table" "public_route_table" {
   vpc_id        = aws_vpc.vpc.id
   route { 
      cidr_block = var.igw_route_cidr_block
      gateway_id = aws_internet_gateway.igateway.id
   }
   tags          = { Name = "${var.project_name}-public-routetable" }
}


resource "aws_route_table" "private_route_table" {
   for_each             = aws_nat_gateway.ngateway
      vpc_id            = aws_vpc.vpc.id
      route {
         cidr_block     = var.igw_route_cidr_block
         nat_gateway_id = each.value.id
      }
      tags              = { 
                            Name = "${var.project_name}-private-routetable-${each.value.tags["AZ"]}" 
                            "AZ" = "${each.value.tags["AZ"]}" 
                          }
}


resource "aws_route_table_association" "public_rta" {
   for_each          = aws_subnet.public_subnets
      route_table_id = aws_route_table.public_route_table.id
      subnet_id      = "${each.value.id}"
}


resource "aws_route_table_association" "private_rta" {
   for_each          = local.rt_subnet_az
      subnet_id      = each.value.subnet
      route_table_id = each.value.rt
}
