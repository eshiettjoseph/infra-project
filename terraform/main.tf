terraform {
  required_version = "~> 1.3"

  backend "s3" {
    bucket         = "go-rest-tf"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "goRestTf"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = local.bucket_name
  table_name  = local.table_name
}

module "ecrRepo" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name
}

module "ecsCluster" {
  source = "./modules/ecs"

  go_rest_api_cluster_name = local.go_rest_api_cluster_name
  availability_zones    = local.availability_zones

  go_rest_api_task_famliy         = local.go_rest_api_task_famliy
  ecr_repo_url                 = module.ecrRepo.repository_url
  container_port               = local.container_port
  go_rest_api_task_name           = local.go_rest_api_task_name
  ecs_task_execution_role_name = local.ecs_task_execution_role_name

  application_load_balancer_name = local.application_load_balancer_name
  target_group_name              = local.target_group_name
  go_rest_api_service_name          = local.go_rest_api_service_name
}

module "rds" {
    source = "./modules/rds"
    prod_rds_db_name = local.prod_rds_db_name
    prod_rds_username = local.prod_rds_username
    prod_rds_password = local.prod_rds_password
    prod_rds_instance_class = local.prod_rds_instance_class
}
