variable "prod_rds_db_name" {
  description = "RDS database name"
  default     = "go_rest_api"
}
variable "prod_rds_username" {
  description = "RDS database username"
  default     = "go_rest_api"
}
variable "prod_rds_password" {
  description = "postgres password for production DB"
}
variable "prod_rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t4g.micro"
}