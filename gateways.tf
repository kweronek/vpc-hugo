// gateways.tf

resource "aws_internet_gateway" "hugo-env-gw" {
  vpc_id = aws_vpc.hugo-env.id
  
  tags = {
    Name = "hugo-env-gw"
  }
}
