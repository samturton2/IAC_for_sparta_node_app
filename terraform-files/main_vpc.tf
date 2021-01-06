resource "aws_vpc" "vpc" {
  		cidr_block = var.cidr["vpc"]
  		instance_tenancy = "default"
  		tags = {
  			Name = "eng74-sam-terraform-vpc"
  		}
}

resource "aws_internet_gateway" "igw" {
  		vpc_id = aws_vpc.vpc.id
 		tags = {
    		Name = "eng74-sam-terraform-igw"
  		}
}

resource "aws_subnet" "public_subnet" {
  		vpc_id = aws_vpc.vpc.id
 		cidr_block = var.cidr["pub_subnet"]
  		map_public_ip_on_launch = "true"
  		tags = {
    		Name = "eng74-sam-terraform-public-subnet"
  		}
}

resource "aws_subnet" "private_subnet" {
  		vpc_id = aws_vpc.vpc.id
 		cidr_block = var.cidr["priv_subnet"]
  		map_public_ip_on_launch = "true"
  		tags = {
    		Name = "eng74-sam-terraform-private-subnet"
  		}
}

resource "aws_route_table" "route-table" {
  		vpc_id = aws_vpc.vpc.id
		route {
      		cidr_block = "0.0.0.0/0"
      		gateway_id = aws_internet_gateway.igw.id
  		}
		tags = {
    		Name = "eng74-sam-terraform-rtb"
  		}
}

resource "aws_route_table_association" "rta_public_subnet" {
  		subnet_id      = aws_subnet.public_subnet.id
  		route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "sg-pub" {
  		name = "eng74-sam-terraform-SG-public"
  		vpc_id = aws_vpc.vpc.id
  		ingress {
      		from_port   = 80
      		to_port     = 80
      		protocol    = "tcp"
      		cidr_blocks = ["0.0.0.0/0"]
  		}
  		ingress {
      		from_port   = 443
      		to_port     = 443
      		protocol    = "tcp"
      		cidr_blocks = ["0.0.0.0/0"]
  		}
  		ingress {
      		from_port   = 3000
      		to_port     = 3000
      		protocol    = "tcp"
      		cidr_blocks = ["0.0.0.0/0"]
  		}
  		ingress {
      		from_port   = 22
      		to_port     = 22
      		protocol    = "tcp"
      		cidr_blocks = [var.cidr["my_ip"]]
  		}

    	egress {
    		from_port   = 0
    		to_port     = 0
    		protocol    = "-1"
    		cidr_blocks = ["0.0.0.0/0"]
  		}
  		tags = {
    		Name = "eng74-sam-terraform-SG-public"
  		}
}

resource "aws_security_group" "sg-priv" {
  		name = "eng74-sam-terraform-SG-private"
  		vpc_id = aws_vpc.vpc.id
  		ingress {
      		from_port   = 27017
      		to_port     = 27017
      		protocol    = "tcp"
      		cidr_blocks = [var.cidr["pub_subnet"]]
  		}
  		ingress {
      		from_port   = 22
      		to_port     = 22
      		protocol    = "tcp"
      		cidr_blocks = [var.cidr["my_ip"]]
  		}

    	egress {
    		from_port   = 0
    		to_port     = 0
    		protocol    = "-1"
    		cidr_blocks = ["0.0.0.0/0"]
  		}
  		tags = {
    		Name = "eng74-sam-terraform-SG-private"
  		}
}

resource "aws_network_acl" "puclic_nacl" {
		vpc_id = aws_vpc.vpc.id
		subnet_ids = [aws_subnet.public_subnet.id]
		ingress {
			protocol    = "tcp"
			rule_no = 100
			action = "allow"
      		from_port   = 1024
      		to_port     = 65535
      		cidr_block = "0.0.0.0/0"
  		}
  		ingress {
  		    rule_no = 110
			action = "allow"
      		from_port   = 22
      		to_port     = 22
      		protocol    = "tcp"
      		cidr_block = var.cidr["my_ip"]
  		}
  		ingress {
  		    rule_no = 120
			action = "allow"
      		from_port   = 80
      		to_port     = 80
      		protocol    = "tcp"
      		cidr_block = "0.0.0.0/0"
  		}
  		ingress {
  			rule_no = 130
			action = "allow"
      		from_port   = 443
      		to_port     = 443
      		protocol    = "tcp"
      		cidr_block = "0.0.0.0/0"
  		}

  		egress {
			protocol    = "tcp"
			rule_no = 100
			action = "allow"
      		from_port   = 1024
      		to_port     = 65535
      		cidr_block = "0.0.0.0/0"
        }
  		egress {
  		    rule_no = 110
			action = "allow"
      		from_port   = 22
      		to_port     = 22
      		protocol    = "tcp"
      		cidr_block = "0.0.0.0/0"
  		}
  		egress {
  		    rule_no = 120
			action = "allow"
      		from_port   = 80
      		to_port     = 80
      		protocol    = "tcp"
      		cidr_block = "0.0.0.0/0"
  		}
  		egress {
  			rule_no = 130
			action = "allow"
      		from_port   = 443
      		to_port     = 443
      		protocol    = "tcp"
      		cidr_block = "0.0.0.0/0"
  		}
  		tags = {
    		Name = "eng74-sam-terraform-NACL-public"
  		}
}

resource "aws_network_acl" "private_nacl" {
		vpc_id = aws_vpc.vpc.id
		subnet_ids = [aws_subnet.private_subnet.id]
		ingress {
			protocol    = "tcp"
			rule_no = 100
			action = "allow"
      		from_port   = 27017
      		to_port     = 27017
      		cidr_block = var.cidr["pub_subnet"]
      	}
  		ingress {
  		    rule_no = 110
			action = "allow"
      		from_port   = 22
      		to_port     = 22
      		protocol    = "tcp"
      		cidr_block = var.cidr["my_ip"]
      	}

  		egress {
			protocol    = "tcp"
			rule_no = 100
			action = "allow"
      		from_port   = 1024
      		to_port     = 65535
      		cidr_block = var.cidr["pub_subnet"]
      	}
  		egress {
  		    rule_no = 120
			action = "allow"
      		from_port   = 80
      		to_port     = 80
      		protocol    = "tcp"
      		cidr_block = var.cidr["pub_subnet"]
  		}
  		egress {
  			rule_no = 130
			action = "allow"
      		from_port   = 443
      		to_port     = 443
      		protocol    = "tcp"
      		cidr_block = var.cidr["pub_subnet"]
  		}
  		tags = {
    		Name = "eng74-sam-terraform-NACL-private"
  		}
}