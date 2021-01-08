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

	pub_sub = module.vpc.pub_sub
	pub_sg = module.sg.pub_sg
	db_ip = module.db.db_ip
}

module "db" {
	source = "./modules/db"

	priv_sub = module.vpc.priv_sub 
	priv_sg = module.sg.priv_sg
}

