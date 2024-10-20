provider "aws" {
   region = "sa-east-1"
}

provider "tls" {   
}

provider "kubernetes" {
   host                   = module.eks_cluster.cluster_endpoint                                        # Atributo "endpoint" do resource aws_eks_cluster
   cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)     # Atributo "certificate_authority" do resource aws_eks_cluster
   exec {
      api_version         = "client.authentication.k8s.io/v1beta1"                                     # kubectl api-resources
      args                = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]   # Argumentos internos. Não é necessário alterar
      command             = "aws"                                                                      # Client AWS
   }
}

provider "helm" {
   kubernetes {
      host                   = module.eks_cluster.cluster_endpoint                                        # Atributo "endpoint" do resource aws_eks_cluster
      cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)     # Atributo "certificate_authority" do resource aws_eks_cluster
      exec {
         api_version         = "client.authentication.k8s.io/v1beta1"                                     # kubectl api-resources
         args                = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]   # Argumentos internos. Não é necessário alterar
         command             = "aws"                                                                      # Client AWS
      }
   }
}
