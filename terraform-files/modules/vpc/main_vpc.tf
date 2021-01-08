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
