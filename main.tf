provider "aws" {
  region = "us-east-1" # Specify the AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0" # The AMI ID to use for the instance
  instance_type = "t2.micro"              # The instance type (e.g., t2.micro)

  # Optional: associate a public IP
  associate_public_ip_address = true

  # Optional: Define the security group for the instance
  security_groups = [aws_security_group.sg.id]

  # Optional: Attach a key pair for SSH access
  //key_name = var.key_name

  # Tags to identify the EC2 instance
  tags = {
    Name = "ExampleEC2Instance"
  }
}

# Security group to allow SSH and HTTP access
resource "aws_security_group" "sg" {
  name        = "example_sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (change to your IP for better security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

