// **********
// servers.tf
// **********
resource "aws_instance" "general-purpose" {

#  count=2

  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.ssh_all.id]
  
  tags = {
#    Name = "${var.env}-inst-${count.index}"
     Name = "${var.env}-inst-1"
    AMI = var.ami_name
  }
  
  subnet_id = aws_subnet.public1.id
}

resource "aws_instance" "private-instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.ssh_all.id]

  tags = {
    Name = "${var.env}-inst-2"
    AMI  = var.ami_name  
  }

  subnet_id = aws_subnet.private2.id
}
