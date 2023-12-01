#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "db_endpoint" {
  name  = "/rds_db/endpoint"
  type  = "SecureString"
  value = split(":", aws_db_instance.rds-pgs.endpoint)[0]
}

