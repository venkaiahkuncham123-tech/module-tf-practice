output "name" {
  value = [for user_name in aws_iam_user.iam.name : user_name.name ]
}
