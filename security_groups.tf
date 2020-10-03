// ******************
// security_groups.tf
// ******************
resource "aws_security_group" "ssh_all" {
  name = "ssh-all"

  vpc_id = aws_vpc.cloud0.id
  
  // opens SSH from all IPs
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  
  // Terraform removes the default rule
  // allow any:any out
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-all"
  }
}
