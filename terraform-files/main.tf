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
}

module "db" {
	source = "./modules/db"
}

