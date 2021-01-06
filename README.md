# Setting up Infrastructure for sparta node app with ansible, packer and Terraform

- Ansible will configure the environments
- Packer will create the AMI's
- Terraform will create the subnets and Instances

## Prerequisites
- For this iteration, I previously had an ansible controller set up on AWS, with all files in this repo synced in.
- To download and set up IAC with Ansible, Packer and Terraform on your linux device follow the steps below.

## Ansible
- Download on Linux
```bash
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible --yes
```
- In `/etc/ansible/hosts` The following needs to be added
```
[local]

localhost
```

- The playbooks are found in the playbook folder, and notice how the hosts is set to default. 
- This will ensure that when packer runs, the temporary instance is provisioned before an image is made of the environment.

## Packer
- Download Packer
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update && sudo apt install packer
```
- To check packer is installed you can use the command `packer`

- The packer Json files are a dictionary setting up an AMI for both the app and the database. 
- To check the validity of the files, run
```bash
packer validate <file_name>
```
- To run the scripts and build the AMI, run
```bash
packer build <file_name>
```
- The files set up a temporary instance, provision the instances using ansible, and creates an image of the temporary instance.
- This can be used later to set up an instance.

## Terraform
- Download Terraform in linux using... (dont need to add the repo as added it previously with packer)
```bash
sudo apt-get update && sudo apt-get install terraform
```

- When terraform runs, it will read all of the _.tf_ files in the directory. I have split up the files for ease of readability.
- The variables folder holds the ami id of the AMI's we just created with packer, and a security group i made manually on AWS.
- To check what the terraform files would do, run
```bash
terraform plan
```
- To create the infrastructure and run the _.tf_ files, run
```bash
terraform apply
```
- This should create 2 instances in aws
