terraform {
  required_version = "~> 1.3"

  backend "remote" {
    organization = "joeshiett"

    workspaces {
      name = "joeshiett"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}