#--------------#
#  subnets.tf  #
#--------------#

resource "aws_subnet" "public1" {

  depends_on = [aws_vpc.cloud0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.cloud0.id
  availability_zone = "us-east-1a"

  tags = { 
    Name        = "${var.vpc_name}-public1"
    Environment = var.env
  }
}

resource "aws_route_table" "igw1" {

#  depends_on = [null_resource.dependency_igw1]
  depends_on = [aws_internet_gateway.igw1]
  vpc_id = aws_vpc.cloud0.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = { 
    Name         = "${var.vpc_name}-igw1" 
    Environments = var.env
  }
}

resource "aws_route_table_association" "public1-igw1" {

  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.igw1.id
}

#  *******************************
resource "aws_subnet" "private2" {

  depends_on = [aws_vpc.cloud0]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.cloud0.id
  availability_zone = "us-east-1a"

  tags = { 
    Name        = "private2"
    Environment = var.env
  }
}
#
resource "aws_route_table" "ngw1_2" {

#  depends_on = [null_resouce.dependency_ngw1]
  depends_on = [aws_nat_gateway.ngw1]
  vpc_id = aws_vpc.cloud0.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw1.id
  }

  tags = {
    Name         = "${var.vpc_name}-ngw1_2"
    Environments = var.env
  }
}
#
resource "aws_route_table_association" "private2-ngw1_2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.ngw1_2.id
}

#******************************
resource "aws_subnet" "data3" {
  depends_on = [aws_vpc.cloud0]
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.cloud0.id
  availability_zone = "us-east-1a"

  tags = {
    Name        = "data3"
    Environment = var.env
  }
}
#
resource "aws_route_table" "ngw1_3" {

#  depends_on = [null_resource.dependency_ngw1]
  depends_on = [aws_nat_gateway.ngw1]
  vpc_id = aws_vpc.cloud0.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw1.id
  }

  tags = {
    Name         = "${var.vpc_name}-ngw1_3"
    Environments = var.env
  }
}
#
resource "aws_route_table_association" "data3-ngw1_3" {
  subnet_id      = aws_subnet.data3.id
  route_table_id = aws_route_table.ngw1_3.id
}
