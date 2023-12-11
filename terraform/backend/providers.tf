terraform {
  required_version = "~> 1.3"

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
