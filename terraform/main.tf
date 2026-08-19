terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for the DevOps EC2 instance"
  type        = string
  default     = "ami-0aba19e56f3eaec05"
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
  instance_type = "t3.micro"

  subnet_id              = "subnet-0ca3b49616f569adb"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "DevOps-Terraform-Server"
  }
}

resource "aws_s3_bucket" "devops_demo" {
  bucket = "bilaal-devops-terraform-demo-2026"
}
