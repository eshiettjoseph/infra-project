variable "availability_zones" {
  description = "us-east-1 AZs"
  type        = list(string)
}

variable "postgres_password_arn" {
  description = "The postgres password arn"
}

variable "postgres_endpoint_arn" {
  description = "The postgres Endpoint arn"
}

variable "db_user_name" {
  description = "the name of the postgres DB user name"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
}


variable "autoscaling_policy_name" {
  description = "AWS App autoscaling policy name"
}

variable "container_port" {
  description = "Port number for go-rest-api container"
}

variable "container_name" {
  description = "Name for go-rest-api container"
}

variable "ecs_service_name" {
  description = "ECS service name"
}

variable "aws_log_group_and_stream" {
  description = "AWS Log Group and Stream"
}

variable "go_rest_api_policy_name" {
  description = "Go Restful API IAM policy name"
}

variable "rds_access_policy_name" {
  description = "RDS IAM Access policy name"
}

variable "go_rest_api_ssm_parameter_policy_name" {
  description = "Go Restful API SSM parameter policy"
}

variable "secret_manager_policy_name" {
  description = "Go Restful API secret manager policy name"
}

variable "aws_lb_name" {
  description = "AWS Loadbalancer"
}

variable "aws_lb_target_group_name" {
  description = "AWS Loadbalancer target group name"
}

variable "ecr_repo_url" {
  description = "ECR Repo URL"
}