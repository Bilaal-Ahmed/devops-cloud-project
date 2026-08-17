terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "devops_demo" {
  bucket = "bilaal-devops-terraform-demo-2026"
}
