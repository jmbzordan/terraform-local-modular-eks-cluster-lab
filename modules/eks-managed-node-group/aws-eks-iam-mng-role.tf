# https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html
# DOcumentação para criação de toda estrutura IAM de nodes EKS
# Role para o managed group
resource "aws_iam_role" "iam_mng_role" {
   name               = "${var.project_name}-iam-managed-node-group-role"
   assume_role_policy = jsonencode({ 
                           Version   = "2012-10-17"
                           Statement = [{ 
                              Action    = "sts:AssumeRole"
                              Effect    = "Allow"
                              Sid       = ""
                              Principal = { Service = "ec2.amazonaws.com" }    # É necessário alterar para ec2
                           }]
                        })
   tags               = { Name = "${var.project_name}-iam-managed-node-group-role" }
}