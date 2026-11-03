output "ids" {
    value = [for user_ids in aws_iam_user.user : user_ids.id]
     
}
