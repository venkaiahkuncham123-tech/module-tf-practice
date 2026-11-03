resource "aws_iam_user" "user" {
    for_each = var.users_list
    name = each.value
    tags = {
      Name = local.team
      Created_On = local.created_on
    }
}
resource "aws_iam_group" "group" {
    name = var.group_name
     
}
resource "aws_iam_user_group_membership" "group_membership" {
    for_each = var.users_list
    groups = [aws_iam_group.group.name]
    user = each.value
  
}
resource "aws_iam_group_policy_attachment" "policy" {
    group = aws_iam_group.group.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  
}
