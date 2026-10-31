output "vpc_id" {
    value = aws_vpc.vpc.id
  
}
output "vpc_region" {
    value = aws_vpc.vpc.region
  
}
output "public_az" {
    value = aws_subnet.public_subnet.availability_zone
  }
  output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
    
  }
  output "sg_id" {
    value = aws_security_group.sg.id
    
  }
  output "private_subnet" {
    value = aws_subnet.private_subnet.id
    
  }
  output "private_sg_id" {
    value = aws_security_group.pvt-sg.id
    
  }