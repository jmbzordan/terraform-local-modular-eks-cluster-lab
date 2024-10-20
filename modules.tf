module "vpc" {
   source        = "./modules/vpc"
   project_name  = "eks"
   subnet_per_az = {
                      "sa-east-1a" = 2  
                      "sa-east-1b" = 2 
   }
   availability_zones   = ["sa-east-1a", "sa-east-1b"]
   vpc_cidr_block       = "10.0.0.0/16"
   igw_route_cidr_block = "0.0.0.0/0"
}

module "eks_cluster" {
   source         = "./modules/eks-cluster"
   project_name   = "eks"
   public_subnets = module.vpc.public_subnets
}

module "eks_mng" {
   source          = "./modules/eks-managed-node-group"
   project_name    = "eks"
   private_subnets = module.vpc.private_subnets
   cluster_name    = module.eks_cluster.cluster_name
}

module "lb_controller" {
   source       = "./modules/eks-load-balancer-controller"
   project_name = "eks"
   cluster_name = module.eks_cluster.cluster_name
   oidc_issuer  = module.eks_cluster.oidc_issuer
}