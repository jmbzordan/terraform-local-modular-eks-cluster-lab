# Primeiramente criamos um IAM Role, que irá ter uma policy atrelada. Posteriormente, serão declaradas no resource Cluster e managed node
# https://docs.aws.amazon.com/eks/latest/userguide/cluster-iam-role.html
# Documentação para criação da estrutura IAM cluster role
resource "aws_iam_role" "iam_cluster_role" {
   name               = "${var.project_name}-iam-cluster-role"
   assume_role_policy = jsonencode({ 
                           Version   = "2012-10-17"
                           Statement = [{ 
                              Action    = "sts:AssumeRole"
                              Effect    = "Allow"
                              Sid       = ""
                              Principal = { Service = "eks.amazonaws.com" }
                           }]
                        })
   tags               = { Name = "${var.project_name}-iam-cluster-role" }
}
