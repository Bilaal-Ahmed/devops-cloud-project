output "ec2_instance_id" {
  description = "ID of the DevOps EC2 instance"
  value       = aws_instance.devops_server.id
}

output "ec2_public_ip" {
  description = "Public IP address of the DevOps EC2 instance"
  value       = aws_instance.devops_server.public_ip
}

output "security_group_id" {
  description = "ID of the DevOps security group"
  value       = aws_security_group.devops_sg.id
}

output "s3_bucket_name" {
  description = "Name of the DevOps S3 bucket"
  value       = aws_s3_bucket.devops_demo.bucket
}
