locals {
  aws_lb_name                           = "go-rest-api-lb"
  aws_lb_target_group_name              = "go-rest-api-lb-tg"
  go_rest_api_policy_name               = "go-rest-api-policy"
  rds_access_policy_name                = "rds-access-policy"
  go_rest_api_ssm_parameter_policy_name = "go-rest-api-ssm-parameter-policy"
  secret_manager_policy_name            = "go-rest-api-sm-policy"
  ecs_cluster_name                      = "go-rest-api-cluster"
  ecs_service_name                      = "go-rest-api-service"
  container_name                        = "go-rest-api"
  container_port                        = 3000
  autoscaling_policy_name               = "go-rest-api-autoscaling-policy"
  aws_log_group_and_stream              = "go-rest-api"
  availability_zones                    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ecr_repo_name                         = "go-rest-api-ecr"
}
