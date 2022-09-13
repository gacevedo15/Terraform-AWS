module "actrafer_asg_tags" {
  source  = "rhythmictech/asg-tag-transform/aws"
  version = "1.0.0"
  tag_map = merge(
    {
      Name = "ecs-instances-actrafer"
    }
  )
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
    name                      = "asg-actrafer-ecs-instances"
    vpc_zone_identifier       = [aws_subnet.actrafer_private_1a.id,aws_subnet.actrafer_private_1b.id]
    launch_configuration      = aws_launch_configuration.actrafer_ecs_launch_config.name
    desired_capacity          = 2
    min_size                  = 1
    max_size                  = 10
    health_check_grace_period = 300
    health_check_type         = "EC2"
    target_group_arns         = [aws_alb_target_group.actrafer_ecs_80.arn]
    tags                      = module.actrafer_asg_tags.tag_list
}