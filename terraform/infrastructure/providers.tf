terraform {
  required_version = "~> 1.3"

  backend "s3" {
    bucket         = "go-rest-tf"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "go-rest-api-dynamodb-table"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  cloud {
    organization = "joeshiett"

    workspaces {
      name = "joeshiett"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}