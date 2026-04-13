provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://127.0.0.1:4566" # Χρησιμοποιούμε το Ingress που φτιάξαμε
  }
}

# 1. Δημιουργία ενός Security Group (για να ανοίξουμε την πόρτα 80)
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow HTTP inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Δημιουργία της EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-00000000" # Στο LocalStack τα AMI IDs είναι εικονικά
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_web.id]

  tags = {
    Name = "MyManualEC2"
  }
}

# 3. Output για να δούμε το ID της
output "instance_id" {
  value = aws_instance.web_server.id
}