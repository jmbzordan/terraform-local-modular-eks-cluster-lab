resource "aws_iam_role_policy_attachment" "lb_controller_role_attachment" {
   role       = aws_iam_role.lb_controller_role.name
   policy_arn = aws_iam_policy.lb_controller_policy.arn         #hard coded pois é um requisito do EKS e não pode ser mudada.
}