resource "aws_security_group" "sg-pub" {
  		name = "eng74-sam-terraform-SG-public"
      vpc_id = var.vpc_id
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
  		vpc_id = var.vpc_id
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