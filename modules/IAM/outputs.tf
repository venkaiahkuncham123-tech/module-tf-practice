output "ids" {
    value = for ids in aws_iam_user.user : ids.id
     
}
