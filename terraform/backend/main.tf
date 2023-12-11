resource "aws_s3_bucket" "go_rest_tf" {
  bucket = "go-rest-tf"
}

resource "aws_dynamodb_table" "go_rest_api_dynamodb_table" {
  name           = "go-rest-api-dynamodb-table"
  read_capacity  = 1
  write_capacity = 1
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}