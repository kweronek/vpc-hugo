// variables.tf

variable "aws_region" {
  default = "us-east-1"
}

variable "ami_name" {
  default = "Hugo-Inst"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0947d2ba12ee1ff75"
}
