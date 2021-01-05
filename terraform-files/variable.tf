variable "AMI" {
	type = map
	default = {
		"db_ami" = "ami-067b01dc453216ae5"
		"app_ami" = "ami-0b59b3e8cb777d29f"
	}
}

variable "host_sg" {
	type = string
	default = "sg-0f85404c41b28788c"
}