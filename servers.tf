// servers.tf

resource "aws_instance" "hugo-ec2-instance" {

  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.ingress-all-hugo.id]
  
  tags = {
    Name = var.ami_name
  }
  
  subnet_id = aws_subnet.subnet-uno.id
}
