# resource "aws_ecs_task_definition" "actrafer_nginx" {
#   family                = "service"
#   container_definitions = file("task-definitions/actrafer-nginx.json")
# }

resource "aws_ecs_task_definition" "actrafer_nginx" {
  family = "actrafer-nginx"

  container_definitions = <<DEFINITION
[
  {
    "image": "nginx:latest",
    "name": "actrafer-nginx",
    "memory": 128,
    "portMappings": [
      {
        "containerPort": 80
      }
    ]
  }
]
DEFINITION

requires_compatibilities = ["EC2"]
network_mode = "bridge"
execution_role_arn = aws_iam_role.actrafer_ecs_tasks_execution_role.arn
}

resource "aws_ecs_service" "actrafer_nginx" {
  name            = "actrafer-nginx"
  cluster         = aws_ecs_cluster.actrafer_cluster.id
  task_definition = aws_ecs_task_definition.actrafer_nginx.arn
  desired_count   = 2
  force_new_deployment = true
  load_balancer {
    target_group_arn = aws_alb_target_group.actrafer_ecs_80.arn
    container_name   = "actrafer-nginx"
    container_port   = 80
  }
}