// ***********
// gateways.tf
// ***********
//
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  
  tags = {
    Name = "igw"
    Environment = var.env
  }
}
//
//
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.public1.id

  tags = {
    Name = "ngw"
    Environment = var.env
  }
}
