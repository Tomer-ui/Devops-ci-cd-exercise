variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "Name for the instance"
  type        = string
  default     = "devops-exercise"
}

variable "environment" {
  description = "Target environment (staging or prod)"
  type        = string
  default     = "staging"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID for us-east-2"
  type        = string
  default     = "ami-06e3c045d79fd65d9" # Replace with valid Ubuntu 22.04 LTS AMI for your region
}
