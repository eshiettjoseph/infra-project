locals {
    bucket_name = "go-rest-tf"
    table_name  = "goRestTf"

    ecr_repo_name = "go-rest-api-ecr-repo"
    go_rest_api_cluster_name        = "go-demo-api-cluster"
    availability_zones           = ["us-east-1a", "us-east-1b", "us-east-1c"]
    go_rest_api_task_famliy         = "go-rest-api-task"
    container_port               = 3000
    go_rest_api_task_name           = "go-rest-api-task"
    ecs_task_execution_role_name = "go-rest-api-task-execution-role"

    application_load_balancer_name = "go-rest-api-alb"
    target_group_name              = "go-rest-api-alb-tg"

    go-rest-api_service_name = "go-rest-api-service"

    prod_rds_password = "josepheshiett"
}