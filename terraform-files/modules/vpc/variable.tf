variable "cidr" {
	type = map
	default = {
		"vpc" = "145.13.0.0/16"
		"pub_subnet" = "145.13.0.0/24"
		"priv_subnet" = "145.13.1.0/24"
		"my_ip" = "86.134.12.230/32"
	}
}
