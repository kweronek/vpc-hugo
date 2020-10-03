#--------------#
#  network.tf  #
#--------------#

resource "aws_vpc" "cloud0" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = var.vpc_name
    Region = var.aws_region
#    Environment = var.env
    Stage = var.stage
  }
}
