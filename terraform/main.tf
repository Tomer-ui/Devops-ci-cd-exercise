# Security Group: "The Guard"
resource "aws_security_group" "app_sg" {
  name        = "${var.instance_name}-${var.environment}-sg"
  description = "Allow SSH and Flask traffic for ${var.environment}"

  # SSH for Jenkins/Ansible
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In prod, restrict to Jenkins IP
  }

  # Flask App Port
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# The Instance: "The Server"
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = "jenkins-key" # This MUST exist in your AWS account

  tags = {
    Name        = "${var.instance_name}-${var.environment}"
    Environment = var.environment
  }
}
