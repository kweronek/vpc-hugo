//
// variables.tf
//
variable "aws_region" { default = "us-east-1" } # North Virginia
#  default = "us-east-2" # Ohio

variable "env" { default = "kwer-test" }
variable "vpc_name" { default = "cloud0" }

# variable "gw_name" { default = "var.env-gw" }

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

