variable "vpc_cidr" {
    type = string
    default = "172.168.0.0/16"
  
}
variable "public_subnet_cidr" {
  
}
variable "public_route_cidr" {
  
}
variable "sg_from_port" {
  
}
variable "sg_to_port" {
  
}
variable "sg_cidr" {
    type = list(string)
  
}
variable "sg_http_from" {
  
}
variable "sg_http_to" {
  
}
variable "sg_http_cidr" {
    type = list(string)
  
}
variable "private_subnet_cidr" {
  
}