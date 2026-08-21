terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "bilaal-devops-terraform-state-2026"
    key    = "devops-project/terraform.tfstate"
    region = "eu-north-1"
  }
}
provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-terraform-sg"
  description = "Security group for Terraform DevOps EC2"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-terraform-sg"
  }
}

resource "aws_instance" "devops_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "DevOps-Terraform-Server"
  }
}

resource "aws_s3_bucket" "devops_demo" {
  bucket = "bilaal-devops-terraform-demo-2026"
}
