# assumes to stick with same provider as main_app

resource "aws_instance" "mongodb_instance"{
	
		ami = var.AMI["db_ami"]
		instance_type = "t2.micro"
		associate_public_ip_address = true
		tags = {
			Name = "sam_eng74_mongodb"
		}
		key_name = "eng74.sam.aws.key"
		subnet_id = aws_subnet.private_subnet.id
		vpc_security_group_ids = [
			aws_security_group.sg-priv.id
		]
}