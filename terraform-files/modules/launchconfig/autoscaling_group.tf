resource "aws_autoscaling_group" "asg" {
	name = "eng74-sam-autoscaling-group"
	max_size = 4
    min_size = 1
	launch_configuration = aws_launch_configuration.l_conf.name
	vpc_zone_identifier = [ var.pub_sub ]
	load_balancers = [
		var.lb_name
	]
	
}