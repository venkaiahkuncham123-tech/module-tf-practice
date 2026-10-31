output "public_ec2_id" {
    value = aws_instance.public_ec2.id
  
}
output "private_ec2_id" {
    value = aws_instance.private_ec2.id
  
}
output "subnet_id" {
    value = module.ec2_creation.public_subnet_id
  
}
output "pvt_subnet_id" {
    value = module.ec2_creation.private_subnet
  
}