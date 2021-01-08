variable "db_ami" {
	default = "ami-0019119a48c02ae1a"
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