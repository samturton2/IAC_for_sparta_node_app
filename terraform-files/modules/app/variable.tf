variable "app_ami" {
	default = "ami-0d52a6e16bd921132"
}

variable "cidr" {
	type = map
	default = {
		"vpc" = "145.13.0.0/16"
		"pub_subnet" = "145.13.0.0/24"
		"priv_subnet" = "145.13.1.0/24"
		"my_ip" = "109.152.98.234/32"
	}
}

variable "pub_sub" {} 

variable "pub_sg" {}

variable "db_ip" {}