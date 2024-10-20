# Recurso que atrela a policy já existe e apontada como necessária na documentação de criação do EKS.
# https://docs.aws.amazon.com/pt_br/eks/latest/userguide/using-service-linked-roles-eks.html
# Documentação de policies para cluster EKS
resource "aws_iam_role_policy_attachment" "cluster_role_attachment" {
   role       = aws_iam_role.iam_cluster_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"         #hard coded pois é um requisito do EKS e não pode ser mudada.
}