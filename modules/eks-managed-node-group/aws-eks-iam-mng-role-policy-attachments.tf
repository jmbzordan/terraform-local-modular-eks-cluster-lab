# Policies que serão atreladas a role do managed node group e apontadas como requisitos pela documentação do EKS
# https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html
# Documentação de policies para nós EKS
resource "aws_iam_role_policy_attachment" "mng_worker_role_attachment" {
   role       = aws_iam_role.iam_mng_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"              #hard coded pois é um requisito do EKS e não pode ser mudada.
}


resource "aws_iam_role_policy_attachment" "mng_ecr_role_attachment" {
   role       = aws_iam_role.iam_mng_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"     #hard coded pois é um requisito do EKS e não pode ser mudada.
}


resource "aws_iam_role_policy_attachment" "mng_cni_role_attachment" {
   role       = aws_iam_role.iam_mng_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"                   #hard coded pois é um requisito do EKS e não pode ser mudada.
}