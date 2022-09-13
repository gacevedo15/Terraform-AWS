resource "aws_security_group" "actrafer_bastion" {
  name        = "actrafer-bastion"
  description = "Security Groups de la Bastion de Actrafer"
  vpc_id      = aws_vpc.actrafer.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.actrafer.cidr_block]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["84.79.191.0/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "actrafer-bastion"
  }
}

resource "aws_security_group" "actrafer_ecs_alb" {
    name = "actrfer-ecs-alb"
    vpc_id      = aws_vpc.actrafer.id

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
    Name = "actrafer-ecs-alb"
  }
}

resource "aws_security_group" "actrafer_ecs_sg" {
    name = "actrfer-ecs"
    vpc_id      = aws_vpc.actrafer.id

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 49153
        to_port         = 65535
        protocol        = "tcp"
        security_groups = [aws_security_group.actrafer_ecs_alb.id]
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
    Name = "actrafer-ecs"
  }
}