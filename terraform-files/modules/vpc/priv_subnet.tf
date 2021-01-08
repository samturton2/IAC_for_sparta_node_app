resource "aws_subnet" "private_subnet" {
  		vpc_id = aws_vpc.vpc.id
 		cidr_block = var.cidr["priv_subnet"]
  		map_public_ip_on_launch = "true"
  		tags = {
    		Name = "eng74-sam-terraform-private-subnet"
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