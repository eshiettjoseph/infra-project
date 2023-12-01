output "rds-pgs_string_arn" {
  value = aws_ssm_parameter.db_endpoint.arn
}

output "db_user_name" {
  value = aws_db_instance.rds-pgs.username
}

output "db_password_arn" {
  value = aws_secretsmanager_secret_version.db.arn
}
