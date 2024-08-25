terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-21e1a7ded39b89a6"
    key = "backend.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "raorane" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = t2.micro
  tags = {
    Name = "Raoraneaditya"
  }
}
