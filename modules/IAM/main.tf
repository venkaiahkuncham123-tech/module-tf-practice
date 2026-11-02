resource "aws_iam_user" "iam" {
  for_each = var.iam_users_list
  name = each.value
  tags = local.tags
}

