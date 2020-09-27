// security_groups.tf

resource "aws_security_group" "ingress-all-hugo" {
  name = "allow-all-sg"

  vpc_id = aws_vpc.hugo-env.id
  
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
