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
resource "aws_iam_group_membership" "group_membership" {
    for_each = var.users_list
    name = var.group_membership_name
    group = aws_iam_group.group.name
    users = [each.value.name]
  
}
resource "aws_iam_group_policy_attachment" "policy" {
    group = aws_iam_group.group.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAcces"
  
}