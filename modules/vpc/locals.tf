# Monta um map com n keys para cada availability zone, conforme quantidade informada na variável subnet_per_az
locals {                                                        
   subnets             = { for idx, subnet in flatten(
                            [ for az, count in var.subnet_per_az : 
                               [ for i in range(count) : { az = az, subnet_num  = i }]
                            ]) : "${subnet.az}-${subnet.subnet_num}" => subnet }

   rt_subnet_az        = { for idx,subnet in aws_subnet.private_subnets : idx => 
                            [ for key,rt in aws_route_table.private_route_table : 
                               { rt=rt.id, subnet=subnet.id } if rt.tags["AZ"] == subnet.availability_zone][0] }

   public_subnet_list  = [ for key,value in aws_subnet.public_subnets : value.id ]  

   private_subnet_list = [ for key,value in aws_subnet.private_subnets : value.id ]
}
