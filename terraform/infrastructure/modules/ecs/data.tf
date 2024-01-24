data "aws_ecr_repository" "go_rest_api_ecr_repo" {
  name = var.ecr_repo_name
}

data "aws_db_instance" "rds_pgs" {
  depends_on             = [var.aws_db_instance]
  db_instance_identifier = "rds-pgs"
}