resource "aws_kms_key" "go-rest-api-kms" {
  description             = "go-rest-api-kms"
  deletion_window_in_days = 7
}