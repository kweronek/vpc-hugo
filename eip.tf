#----------#
#  eip.tf  #
#----------#

resource "aws_eip" "eip1" {
#  instance = aws_instance.hugo-ec2-instance.id
  vpc      = true
  
  tags = { 
    Name = "public-ip1"
    Region = var.aws_region
    Note = "cloud0"
#    Stage = archdev
#    Environment = var.env
  }
}
