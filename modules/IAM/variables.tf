variable "users_list" {
    type = set(string)
    default = [ "Venkaiah Kuncham" , "Sarath Musali","Jagadeesh Digavinti","Sumanth Reddy"]
  
}
locals {
  team = "Review Team"
  created_on = formatdate("YYYY-MM-DD", timestamp())
}
variable "group_name" {
    type = string
    default = "admin-group"
}
variable "group_membership_name" {
   type = string
   default = "admin_group_membership"
}