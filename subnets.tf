// **********
// subnets.tf
// **********
resource "aws_subnet" "public1" {
  cidr_block = "10.0.1.0/24"
#  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 3, 1)
  vpc_id = aws_vpc.this.id
  availability_zone = "us-east-1a"

  tags = { 
    Name = "public1"
    Environment = var.env
  }
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = { 
    Name = "igw" 
    Environments = var.env
  }
}

resource "aws_route_table_association" "public1-igw" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.igw.id
}

//
// *******************************
resource "aws_subnet" "private2" {
#  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 3, 1)
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.this.id
  availability_zone = "us-east-1a"

  tags = { 
    Name = "subnet-private2"
    Environment = var.env
  }
}
