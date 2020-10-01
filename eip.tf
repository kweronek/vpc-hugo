// ******
// eip.tf
// ******
resource "aws_eip" "eip1" {
#  instance = aws_instance.hugo-ec2-instance.id
  vpc      = true
  
  tags = { 
    Name = "public-ip1"
    Environment = var.env
  }
}
