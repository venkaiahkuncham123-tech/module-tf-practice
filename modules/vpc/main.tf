locals {
  prefix = "Test"

  common_tags = {
    Created_On = formatdate("YYYY-MM-DD", timestamp())
  }
}
data "aws_availability_zones" "az" {
    state = "available"    
  
}
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = merge(local.common_tags, {
   Name = "${local.prefix}-VPC"
})

    }
resource "aws_internet_gateway" "ig_name" {
    vpc_id = aws_vpc.vpc.id  
    tags = merge(local.common_tags, {
  Name = "${local.prefix}-IGW"
})

}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr  
    availability_zone = data.aws_availability_zone.az.names[0]
    map_public_ip_on_launch = true
    tags = merge(local.common_tags, {
   Name = "${local.prefix}-subnet"
})
}
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        gateway_id = aws_internet_gateway.ig_name.id
        cidr_block = var.public_route_cidr
    }
    tags = merge(local.common_tags, {
  Name = "${local.prefix}-rt-table"
})

  
}
resource "aws_route_table_association" "rt_association" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet.id  
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = data.aws_availability_zone.az.names[1]
    tags = merge(local.common_tags, {
  Name = "${local.prefix}-pvt-rt"
})

  
}
resource "aws_route_table" "pvt-rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
    }
  
}
resource "aws_route_table_association" "pvt-rt-assoc" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.pvt-rt.id
}
resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = var.sg_from_port
        to_port = var.sg_to_port
        protocol = "tcp"
        cidr_blocks = var.sg_cidr
        description = "Allow SSH"
    }
    ingress {
        from_port = var.sg_http_from
        to_port = var.sg_http_to
        protocol = "tcp"
        cidr_blocks = var.sg_http_cidr
        description = "Allow ports from 80 to 8080"
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SQL Traffic"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "Allow All Outbound Traffic"
    }    
  tags = merge(local.common_tags, {
  Name = "${local.prefix}-public-sg"
})

}

resource "aws_security_group" "pvt-sg" {
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_subnet.public_subnet.cidr_block]
        description = "Allow SSH"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "Allow All Outbound Traffic"
    }    
    tags = merge(local.common_tags, {
  Name = "${local.prefix}-pvt-sg"
})

  
}

