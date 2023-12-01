# IAM policies 
resource "aws_iam_policy" "go-rest-api-policy" {
  name = var.go_rest_api_policy_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "elb:*",
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs-iam-policy-attachment" {
  role       = aws_iam_role.go-rest-api-role.name
  policy_arn = aws_iam_policy.go-rest-api-policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.go-rest-api-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "rds_access_policy" {
  name   = var.rds_access_policy_name
  policy = file("rds-access.json")
}

resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
  role       = aws_iam_role.go-rest-api-role.name
  policy_arn = aws_iam_policy.rds_access_policy.arn
}

#Create a policy to read from the specific parameter store
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "ssm_parameter_policy" {
  name        = var.go_rest_api_ssm_parameter_policy_name
  path        = "/"
  description = "Policy to read the Postgres endpoint from SSM Parameter Store."
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        Resource = [var.postgres_endpoint_arn]
      }
    ]
  })
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "secret_manager_policy" {
  name        = var.secret_manager_policy_name
  path        = "/"
  description = "Policy to read Postgres password stored with AWS Secrets Manager"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [var.postgres_password_arn]
      }
    ]
  })
}

# The ecs role
resource "aws_iam_role" "go-rest-api-role" {
  name = "go-rest-api-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}
