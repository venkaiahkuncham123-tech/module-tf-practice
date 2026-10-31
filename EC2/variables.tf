variable "vpc_cidr" {
  
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
variable "instance_type_public" {
  
}
variable "it_type_private" {
  
}
variable "common_tags" {
    type = map()
    default = {
        Name = "Test"
        Created_On = formatdate("YYYY-MM-DD", timestamp())
    }
  
}