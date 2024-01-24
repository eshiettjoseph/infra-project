#  ECS cluster, service and task definition
resource "aws_ecs_cluster" "go-rest-api-cluster" {
  name = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.go-rest-api-kms.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.go-rest-api-log-group.name
      }
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "go-rest-api-cp" {
  cluster_name = aws_ecs_cluster.go-rest-api-cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 50
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "go-rest-api-task-definition" {
  family                   = "go-rest-api-td"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.go-rest-api-role.arn
  container_definitions    = <<DEFINITION
    [
      {
          "logConfiguration": {
              "logDriver": "awslogs",
              "secretOptions": null,
              "options": {
                  "awslogs-group": "${aws_cloudwatch_log_group.go-rest-api-log-group.name}",
                  "awslogs-region": "us-east-1",
                  "awslogs-stream-prefix": "ecs",
                  "awslogs-create-group": "true"
              }
          },
          "portMappings": [
              {
                  "hostPort": ${var.container_port},
                  "protocol": "tcp",
                  "containerPort": ${var.container_port}
              }
          ],
          "image": "${data.aws_ecr_repository.go_rest_api_ecr_repo.repository_url}",
          "name": "${var.container_name}",
          "environment": [
              {
                  "name": "PORT",
                  "value": "${var.container_port}"
              }, 
              {
                  "name": "AWS_LOG_GROUP_AND_STREAM",
                  "value": "${var.aws_log_group_and_stream}"
              },
              {
                  "name": "POSTGRES_USER",
                  "value": "${var.db_user_name}"
              },
              {
                  "name": "DB_HOST",
                  "value": "${data.aws_db_instance.rds_pgs.address}"

              },
              {
                  "name": "DB_USER",
                  "value": "${data.aws_db_instance.rds_pgs.master_username}"
              },
              {
                  "name": "DB_NAME",
                  "value": "${data.aws_db_instance.rds_pgs.db_name}"
              },
              {
                  "name": "SSL_MODE",
                  "value": "require"
              }           
          ],
          "secrets": [
              {
                  "name": "DB_PASSWORD",
                  "valueFrom": "${var.postgres_password_arn}"
              }

          ]
      }
    ]
    DEFINITION
}

resource "aws_ecs_service" "go-rest-api-service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.go-rest-api-cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.go-rest-api-task-definition.arn
  desired_count   = 1
  depends_on = [
    aws_iam_policy.go-rest-api-policy
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.go-rest-api-tg.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }
}

# Add autoscaling
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.go-rest-api-cluster.name}/${aws_ecs_service.go-rest-api-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = var.autoscaling_policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}

