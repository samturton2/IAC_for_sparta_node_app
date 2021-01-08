resource "aws_launch_configuration" "l_conf" {
	name = "eng74-sam-launch-config"
	image_id = var.app_ami
	instance_type = "t2.micro"
	user_data = <<-EOF
		export DB_HOST=${var.db_ip}
        printf '\nexport DB_HOST=${var.db_ip}' >> ~/.bashrc
		cd /home/ubuntu/app/
		npm install
		npm start app.js
		EOF

	security_groups = [
		var.pub_sg
	]
	key_name = "eng74.sam.aws.key"
}