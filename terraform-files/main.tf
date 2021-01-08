# Which cloud provider required
# AWS as we have our AMI's and AWS

provider "aws" {
	
		region = var.region
}

module "vpc" {
	source = "./modules/vpc"
}

module "sg" {
	source = "./modules/sg"

	vpc_id = module.vpc.vpc_id
}

module "app" {
	source = "./modules/app"

	app_ami = var.app_ami
	pub_sub = module.vpc.pub_sub
	pub_sg = module.sg.pub_sg
	db_ip = module.db.db_ip
}

module "db" {
	source = "./modules/db"

	priv_sub = module.vpc.priv_sub 
	priv_sg = module.sg.priv_sg
}

module "loadbalancer" {
	source = "./modules/loadbalancer"

	lb_type = "network"
	subnet = module.vpc.pub_sub
	vpc_id = module.vpc.vpc_id
}

module "launch_config" {
	source = "./modules/launchconfig"

	app_ami = var.app_ami
	db_ip = module.db.db_ip
	pub_sg = module.sg.pub_sg
	pub_sub = module.vpc.pub_sub
	lb_name = module.loadbalancer.lb_name
}