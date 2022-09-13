resource "aws_vpc" "actrafer" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true
  tags = {
    Name = "actrafer"
  }
}

resource "aws_internet_gateway" "actrafer" {
  vpc_id = aws_vpc.actrafer.id

  tags = {
    Name = "actrafer-igw"
  }
}

resource "aws_eip" "actrafer_ngw" {
  vpc      = true
  tags = {
    "Name" = "nat-gateway-actrafer"
  }
}

resource "aws_nat_gateway" "actrafer" {
  allocation_id = aws_eip.actrafer_ngw.id
  subnet_id     = aws_subnet.actrafer_public_1a.id

  tags = {
    Name = "actrafer-nat-gateway"
  }
  depends_on = [aws_internet_gateway.actrafer]
}

resource "aws_route_table" "actrafer_rt_public" {
  vpc_id = aws_vpc.actrafer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.actrafer.id
  }
  tags = {
    Name = "actrafer-route-table-public"
  }
}

resource "aws_route_table" "actrafer_rt_private" {
  vpc_id = aws_vpc.actrafer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.actrafer.id
  }
  tags = {
    Name = "actrafer-route-table-private"
  }
}

resource "aws_subnet" "actrafer_public_1a" {
  vpc_id     = aws_vpc.actrafer.id
  cidr_block = var.cidr_subnet_public_1a
  availability_zone = "eu-west-1a"

  tags = {
    Name = "actrafer-public-eu-west-1a"
  }
}

resource "aws_subnet" "actrafer_public_1b" {
  vpc_id     = aws_vpc.actrafer.id
  cidr_block = var.cidr_subnet_public_1b
  availability_zone = "eu-west-1b"

  tags = {
    Name = "actrafer-public-eu-west-1b"
  }
}

resource "aws_subnet" "actrafer_private_1a" {
  vpc_id     = aws_vpc.actrafer.id
  cidr_block = var.cidr_subnet_private_1a
  availability_zone = "eu-west-1a"

  tags = {
    Name = "actrafer-private-eu-west-1a"
  }
}

resource "aws_subnet" "actrafer_private_1b" {
  vpc_id     = aws_vpc.actrafer.id
  cidr_block = var.cidr_subnet_private_1b
  availability_zone = "eu-west-1b"

  tags = {
    Name = "actrafer-private-eu-west-1b"
  }
}

resource "aws_route_table_association" "actrafer_public_1a" {
  subnet_id      = aws_subnet.actrafer_public_1a.id
  route_table_id = aws_route_table.actrafer_rt_public.id
}

resource "aws_route_table_association" "actrafer_public_1b" {
  subnet_id      = aws_subnet.actrafer_public_1b.id
  route_table_id = aws_route_table.actrafer_rt_public.id
}

resource "aws_route_table_association" "actrafer_private_1a" {
  subnet_id      = aws_subnet.actrafer_private_1a.id
  route_table_id = aws_route_table.actrafer_rt_private.id
}

resource "aws_route_table_association" "actrafer_private_1b" {
  subnet_id      = aws_subnet.actrafer_private_1b.id
  route_table_id = aws_route_table.actrafer_rt_private.id
}