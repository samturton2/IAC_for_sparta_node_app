# assumes to stick with same provider as main_app

resource "aws_instance" "mongodb_instance"{
	
		ami = var.db_ami
		instance_type = "t2.micro"
		associate_public_ip_address = true
		tags = {
			Name = "sam_eng74_mongodb"
		}
		key_name = "eng74.sam.aws.key"
		subnet_id = var.priv_sub
		vpc_security_group_ids = [
			var.priv_sg
		]
}