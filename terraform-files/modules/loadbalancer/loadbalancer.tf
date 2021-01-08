resource "aws_lb" "load_balancer" {
	name = "eng74-sam-loadbalancer"
	internal = false
	load_balancer_type = var.lb_type
	subnet_mapping {
		subnet_id = var.subnet
	}
	tags = {
		Name = "eng74-sam-loadbalancer"
	}
}

resource "aws_lb_target_group" "tg" {
    name = "eng74-sam-targetgroup"
    protocol = "tcp"
    port = "80"
  	vpc_id   = var.vpc_id
}
