data "aws_ami" "actrafer_ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20220*-x86_64-ebs"]
  }
}


resource "aws_launch_configuration" "actrafer_ecs_launch_config" {
    name                 = "actrafer-launch-template"
    image_id             = data.aws_ami.actrafer_ecs_ami.id
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    security_groups      = [aws_security_group.actrafer_ecs_sg.id]
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=actrafer-cluster >> /etc/ecs/ecs.config"
    instance_type        = "t2.micro"
    key_name             = aws_key_pair.actrafer.id
}