module "ec2_creation" {
source = git::https://github.com/venkaiahkuncham123-tech/module-tf-practice.git
vpc_cidr = "192.168.0.0/16"
public_subnet_cidr = "192.168.1.0/20"
public_route_cidr = "0.0.0.0/0"
sg_from_port = 22
sg_to_port = 22
sg_cidr = ["0.0.0.0/0"]
sg_http_from = 80
sg_http_to = 8080
sg_http_cidr = ["0.0.0.0/0"]
private_subnet_cidr = "192.168.2.0/20"  
}
resource "aws_instance" "public_ec2"{
    ami = data.aws_ami.ami.id
    instance_type = var.instance_type_public
    subnet_id = module.ec2_creation.public_subnet_id
    vpc_security_group_ids = [module.ec2_creation.sg_id]
    key_name = aws_key_pair.key.key_name
    tags {
        Name = "Public_Instance"
        Created_On = timestamp()
    }
}
resource "aws_key_pair" "key" {
    key_name = "mykey"
    public_key = file("./mykey.pub")
}
resource "aws_instance" "private_ec2" {
    ami = data.aws_ami.ami.id
    instance_type = var.it_type_private
    key_name = aws_key_pair.key.key_name
    subnet_id = module.ec2_creation.private_subnet
    vpc_security_group_ids = [module.ec2_creation.private_sg_id]
    tags {
        Name = "Private-Instance"
        Created_on = timestamp()
    }
}
data "aws_ami" "ami" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "virtualization_type"
        value = ["hvm"]
    }
}
