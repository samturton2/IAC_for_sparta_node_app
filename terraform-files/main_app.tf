# Which cloud provider required
# AWS as we have our AMI's and AWS

provider "aws" {
	
		region = "eu-west-1"
}

resource "aws_instance" "nodejs_instance"{
	
		ami = var.AMI["app_ami"]
		instance_type = "t2.micro"
		associate_public_ip_address = true
		tags = {
			Name = "sam_eng74_nodeapp"
		}
		key_name = "eng74.sam.aws.key"
		subnet_id = aws_subnet.public_subnet.id
		vpc_security_group_ids = [
			aws_security_group.sg-pub.id
		]
		user_data = <<-EOF

			export DB_HOST=${aws_instance.mongodb_instance.private_ip}
        	sed -i '/export DB_HOST=/d' ~/.bashrc
        	printf '\nexport DB_HOST=${aws_instance.mongodb_instance.private_ip}' >> ~/.bashrc
        	
        	sudo systemctl stop nginx
       		sudo mkdir /etc/systemd/system/nginx.service.d
        	printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /home/ubuntu/override.conf
        	sudo cp /home/ubuntu/override.conf /etc/systemd/system/nginx.service.d/override.conf
        	sudo systemctl daemon-reload
        	sudo systemctl start nginx

        	pm2 delete all
            pm2 start app.js
            EOF
}