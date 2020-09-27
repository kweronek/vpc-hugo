// eip.tf

resource "aws_eip" "ip-hugo-env" {
  instance = aws_instance.hugo-ec2-instance.id
  vpc      = true
}
