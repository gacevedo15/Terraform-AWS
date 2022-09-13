resource "aws_alb" "actrafer_alb" {
  name            = "actrafer-alb"
  security_groups = [aws_security_group.actrafer_ecs_alb.id]

  subnets = [
    aws_subnet.actrafer_public_1a.id,
    aws_subnet.actrafer_public_1b.id
  ]
}

resource "aws_alb_target_group" "actrafer_ecs_80" {
  name     = "actrafer-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.actrafer.id
  target_type = "instance"
}

resource "aws_lb_listener" "actrafer_alb_listener_80" {
  load_balancer_arn = aws_alb.actrafer_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.actrafer_ecs_80.arn
    type             = "forward"
  }
}