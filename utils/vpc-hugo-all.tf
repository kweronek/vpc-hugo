# This file is a template file
# please replace placeholders by valid keys/key par name respectively
# thereafter please remove the subsequent comment signs /* and */
/*
variable "access_key" {
  default = "ASDFTGSSGSAFG4FGSFDSS"
}

variable "secret_key" {
  default = "ASDfasdFAsda*AfafdfddadfasddEbJZSEDSf$"
}

variable "ami_key_pair_name" {
  default = "Terraform-kp"
}
*/
//
// provider.tf
//
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.aws_region
}
//
// variables.tf
//
variable "aws_region" { default = "us-east-1" } # North Virginia
#  default = "us-east-2" # Ohio

variable "env" { default = "kwer-test" }

variable "gw_name" { default = "var.env-gw" }

variable "ami_name" { default = "Amazon Linux 2" }
#  default = "Ubuntu 20.04 LTS"
#  default = "Ubuntu 18.04 LTS"
#  default = "openSUSE 15.2"
#  default = "SLES 15.2"
#  default = "K3OS-v0.11.0 KW"

variable "instance_type" {default = "t2.micro" }
#  default = "m1.medium"


variable "ami_id" {default = "ami-0947d2ba12ee1ff75" }   # Amazon linux AMI 2
#  default = "ami-0dba2cb6798deb6d8"    # Ubuntu 20.04 LTS
#  default = "ami-0817d428a6fb68645"    # Ubuntu 18,04 LTS
#  default = "ami-0dc3ca5b357a165492    # openSUSE 15.2
#  default = "ami-0a782e324655d1cc0"    # SLES 15.2
#  default = "ami-0a1cfbada2409e7dc"    # K3OS-v0.11.0 KW

//
// locals.tf
//
locals {
   env_name = "hugo-env"
}	

// **********
// network.tf
// **********
resource "aws_vpc" "kwer-test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "vpc-kwer-test"
  }
}
// ***********
// gateways.tf
// ***********
//
resource "aws_internet_gateway" "kwer-test-igw" {
  vpc_id = aws_vpc.kwer-test.id
  
  tags = {
    Name = "${var.env}-igw"
  }
}
//
//
resource "aws_nat_gateway" "kwer-test-ngw" {
  allocation_id = aws_eip.kwer-test-gw.id
  subnet_id = aws_subnet.subnet-uno.id

  tags = {
    "Name" = "kwer-test-ngw"
  }
}
// **********
// subnets.tf
// **********
resource "aws_subnet" "subnet-uno" {
  cidr_block = "10.0.1.0/24"
#  cidr_block = cidrsubnet(aws_vpc.kwer-test.cidr_block, 3, 1)
  vpc_id = aws_vpc.kwer-test.id
  availability_zone = "us-east-1a"
  tags = { Name = "subnet-public"}
}

resource "aws_route_table" "route-table-kwer-test" {
  vpc_id = aws_vpc.kwer-test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kwer-test-igw.id
  }
  tags = { Name = "route-table-kwer-test-uno" }
}

resource "aws_route_table_association" "subnet-association-uno" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-kwer-test.id
}
//
//
//
resource "aws_subnet" "subnet-due" {
#  cidr_block = cidrsubnet(aws_vpc.kwer-test.cidr_block, 3, 1)
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.kwer-test.id
  availability_zone = "us-east-1a"
  tags = { Name = "subnet-due"}
}

/*
resource "aws_route_table" "route-kwer-test-env" {
  vpc_id = aws_vpc.kwer-test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kwer-test-igw.id
  }
  tags = { Name = "route-table-kwer-test-due" }
}

resource "aws_route_table_association" "subnet-association-due" {
  subnet_id      = aws_subnet.subnet-due.id
  route_table_id = aws_route_table.route-table-kwer-test.id
}
*/
// ******************
// security_groups.tf
// ******************
resource "aws_security_group" "sg_ssh_all" {
  name = "allow-ssh-all-sg"

  vpc_id = aws_vpc.kwer-test.id
  
  // opens SSH from all IPs
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  
  // Terraform removes the default rule
  // allow any:any out
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kwer-test-sg"
  }
}
// **********
// servers.tf
// **********
resource "aws_instance" "general-purpose" {

#  count=2

  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.sg_ssh_all.id]
  
  tags = {
#    Name = "${var.env}-inst-${count.index}"
     Name = "${var.env}-inst-1"
    AMI = var.ami_name
  }
  
  subnet_id = aws_subnet.subnet-uno.id
}

resource "aws_instance" "private-instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.sg_ssh_all.id]

  tags = {
    Name = "${var.env}-inst-2"
    AMI  = var.ami_name  
}

  subnet_id = aws_subnet.subnet-due.id
}
// ******
// eip.tf
// ******
resource "aws_eip" "kwer-test-gw" {
#  instance = aws_instance.hugo-ec2-instance.id
  vpc      = true
  
  tags = { 
    Name = "kwer-test-gw"
  }
}
