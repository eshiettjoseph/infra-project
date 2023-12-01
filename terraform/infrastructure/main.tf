module "ecs" {
  source                                = "../modules/ecs"
  aws_lb_name                           = local.aws_lb_name
  aws_lb_target_group_name              = local.aws_lb_target_group_name
  go_rest_api_policy_name               = local.go_rest_api_policy_name
  rds_access_policy_name                = local.rds_access_policy_name
  go_rest_api_ssm_parameter_policy_name = local.go_rest_api_ssm_parameter_policy_name
  postgres_password_arn                 = module.rds.db_password_arn
  postgres_endpoint_arn                 = module.rds.rds-pgs_string_arn
  db_user_name                          = module.rds.db_user_name
  secret_manager_policy_name            = local.secret_manager_policy_name
  ecs_cluster_name                      = local.ecs_cluster_name
  ecs_service_name                      = local.ecs_service_name
  container_name                        = local.container_name
  container_port                        = local.container_port
  autoscaling_policy_name               = local.autoscaling_policy_name
  aws_log_group_and_stream              = local.aws_log_group_and_stream
}