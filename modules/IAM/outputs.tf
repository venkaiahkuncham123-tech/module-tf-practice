output "name" {
  value = [for user_name in aws_iam_user.iam : user_name.name ]
}
