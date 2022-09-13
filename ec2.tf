data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_eip" "actrafer_bastion" {
  vpc      = true
  tags = {
    "Name" = "bastion-actrafer"
  }
}

resource "aws_eip_association" "actrafer_bastion" {
  instance_id   = aws_instance.actrafer_bastion.id
  allocation_id = aws_eip.actrafer_bastion.id
}

resource "aws_instance" "actrafer_bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  availability_zone = "eu-west-1a"
  subnet_id   = aws_subnet.actrafer_public_1a.id
  key_name = aws_key_pair.actrafer.id
  security_groups = [aws_security_group.actrafer_bastion.id]

  tags = {
    Name = "bastion-actrafer"
  }
}