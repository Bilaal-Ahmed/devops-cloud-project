variable "aws_region" {
  description = "AWS region for DevOps infrastructure"
  type        = string
  default     = "eu-north-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for the DevOps EC2 instance"
  type        = string
  default     = "ami-0aba19e56f3eaec05"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the DevOps EC2 instance"
  type        = string
  default     = "subnet-0ca3b49616f569adb"
}
