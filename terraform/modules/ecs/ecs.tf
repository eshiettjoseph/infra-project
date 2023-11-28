resource "aws_ecs_cluster" "demo_app_cluster" {
  name = var.go_rest_api_cluster_name
}

# Deploy cluster in default VPC
resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = var.availability_zones[0]
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = var.availability_zones[1]
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = var.availability_zones[2]
}

# ECS task definition
resource "aws_ecs_task_definition" "demo_app_task" {
  family                   = var.go_rest_api_task_famliy
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.go_rest_api_task_name}",
      "image": "${var.ecr_repo_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

# AWS IAM role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
