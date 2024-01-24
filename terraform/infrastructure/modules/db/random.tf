#https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/auth.html#auth-overview
resource "random_password" "db_password" {
  length           = 128
  special          = true
  override_special = "!&#$^<>-"
}
