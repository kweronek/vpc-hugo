<<<<<<< HEAD
// ***********
// gateways.tf
// ***********
//
resource "aws_internet_gateway" "igw1" {
  depends_on = [aws_vpc.cloud0]
  vpc_id = aws_vpc.cloud0.id
  
  tags = {
    Name = "igw1"
    Environment = var.env
  }
}

resource "null_resource" "igw1_dependency" {
  depends_on = [aws_internet_gateway.igw1]
}

//
resource "aws_nat_gateway" "ngw1" {
  depends_on = [aws_vpc.cloud0]
#  depends_on = [aws_eip.eip1]
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.public1.id

  tags = {
    Name = "ngw1"
    Environment = var.env
  }
}

resource "null_resource" "ngw1_dependency" {
  depends_on = [aws_nat_gateway.ngw1]
}

