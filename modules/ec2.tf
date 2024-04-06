resource "aws_instance" "ec2wiki" {
  count                  = length(var.subnets_cidr_public)
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.publicSubnet[count.index].id
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = file("modules/user_data.sh")

  tags = {
    Name  = "mediawiki-${count.index + 1}"
  }
}
