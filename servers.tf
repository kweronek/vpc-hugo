#--------------#
#  servers.tf  #
#--------------#

# resource "aws_instance" "public1" {
resource "aws_spot_instance_request" "public1" {
#  count=1
  depends_on = [null_resource.ngw1_dependency]
  wait_for_fulfillment = true
  spot_type = "one-time"  
  ami = var.ami_id
  instance_type = var.inst_type_default
  spot_price = "0.01"
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.ssh_all.id]
  root_block_device { volume_size = "8" }

  tags = {
#    Name = "${var.env}-inst-${count.index}"
    Name = "${var.env}-inst-1"
    AMI = var.ami_name
    Inst_purch-opt = "spot" 
  }
  subnet_id = aws_subnet.public1.id

  provisioner "local-exec" {
    command = "echo The IP address is ${self.private_ip}"
  }
}

locals { tags = {
    Name = "public1-srv-1"
    AMI = var.ami_name
    Stage = "archdev"
    Environment = "prod"
    Inst_purch_opt = "spot"
}   }

resource "aws_ec2_tag" "public1" {  
  resource_id = aws_spot_instance_request.public1.spot_instance_id
  for_each = local.tags
  key      = each.key
  value    = each.value
}
#-------------------------------------
# resource "aws_instance" "private2" {
resource "aws_spot_instance_request" "private2" {
#  count = 1
  depends_on = [null_resource.ngw1_dependency]
  wait_for_fulfillment = true
  spot_type = "one-time"
  ami = var.ami_id
  instance_type = var.instance_type
  spot_price    = "0.01"
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.ssh_all.id]
  root_block_device { volume_size = "8" }

  tags = {
    Name = "private2-srv-spot"
    AMI  = var.ami_name  
    Stage = "archdev"
    Environment = "prod"
    Inst_purch_opt = "spot"
  }

  provisioner "local-exec" {
    command = "echo The IP address is ${self.private_ip}"
  }
  subnet_id = aws_subnet.private2.id
}

locals { tags2 = {
    Name = "private2-srv-1"
    AMI = var.ami_name
    Stage = "archdev"
    Environment = "prod"
    Inst_purch_opt = "spot"
}   }

resource "aws_ec2_tag" "private2" {
  resource_id = aws_spot_instance_request.private2.spot_instance_id  
  for_each = local.tags2
  key      = each.key
  value    = each.value
}

######################################
# resource "aws_instance" "data3" {
resource "aws_spot_instance_request" "data3" {
#  count = 1
  depends_on = [null_resource.ngw1_dependency]
  wait_for_fulfillment = true
  spot_type = "one-time"
  ami = var.ami_id
  instance_type = var.instance_type
  spot_price    = "0.01"
  key_name = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.ssh_all.id]
  root_block_device { volume_size = "8" }

  tags = {
    Name = "var.env-inst-3-spot"
    AMI  = var.ami_name
    Instance_type = "on demand"
  }

  provisioner "local-exec" {
    command = "echo The IP address is ${self.private_ip}"
  }
  subnet_id = aws_subnet.data3.id
}

locals { tags3 = {
    Name = "data3-srv-1"
    AMI = var.ami_name
    Stage = "archdev"
    Environment = "prod"
    Inst_purch_opt = "spot"
}   }

resource "aws_ec2_tag" "data3" {
  resource_id = aws_spot_instance_request.data3.spot_instance_id
  for_each = local.tags3
  key      = each.key
  value    = each.value
}
