# Setting up Infrastructure for sparta node app with ansible, packer and Terraform

- Ansible will configure the environments
- Packer will create the AMI's
- Terraform will create the subnets and Instances

## Instructions
Once packer, ansible and terraform are installed on your machine we can create the AMI's needed using
```bash
packer build
```

We will need the AMI id's in the Terraform files variables, for some of the modules.

To initialise, valdiate and plan the terraform files we can use
```bash
terraform init
terraform validate
terraform plan
```

Then to run the main.tf referencing the modules we can run
```bash
terraform apply
```
## Terraform Instance
- Terraform uses HCL which is a declarative coding language.
- We declare the properties of a resource as so.
```hcl
resource "aws_instance" "nodejs_instance"{
    
        ami = var.app_ami
        instance_type = "t2.micro"
        associate_public_ip_address = true
        tags = {
            Name = "sam_eng74_nodeapp"
        }
        key_name = "eng74.sam.aws.key"
        subnet_id = var.pub_sub
        vpc_security_group_ids = [
            var.pub_sg
        ]
```
- The `aws_instance` refers to the type of resource, and the `nodejs_instance` refers to the name we give this resource in terraform. 
- Some of the properties are hard coded, some use variables ( `var.<variable> ) which are explained in the next paragraph.
- To go into the aws instance once its created and run bash commands we can use the following syntax under the resource properties.
```hcl
user_data = <<-EOF
            export DB_HOST=${var.db_ip}
            printf '\nexport DB_HOST=${var.db_ip}' >> ~/.bashrc

            cd ~/app/ && pm2 start app.js
            EOF
}
```

## Terraform Modules and Variables
The main.tf file essentially calls each module in the module folder.
Each module has an output.tf file which outputs variables that are not defined in some of the variable.tf files. This allows us to abstract some properties untill the final main.tf file.
An example of this is for the db module.
- The main.tf file references private subnet and private security group.
```hcl
        subnet_id = var.priv_sub
        vpc_security_group_ids = [
            var.priv_sg
        ]
}
```
- These variables are kept as blank in the variable.tf file
```hcl
variable "priv_sub" {}

variable "priv_sg" {} 
```
- however in the Security Groups module, we have them declared in the output.tf file.
```hcl
output "priv_sg" {
    value = aws_security_group.sg-priv.id
}

output "pub_sg" {
    value = aws_security_group.sg-pub.id
}
```
- These can be referenced when actually creating the db
```hcl
module "db" {
    source = "./modules/db"

    priv_sub = module.vpc.priv_sub 
    priv_sg = module.sg.priv_sg
}
```

The idea of this is to keep the modules more skeletal, so that we can specify some of the properties later on, so when we want to make a different db instance, we can use the same module.