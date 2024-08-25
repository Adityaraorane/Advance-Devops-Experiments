terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

resource "aws_instance" "raorane" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = var.instance_type
  tags = {
    Name = "44Aditya"
  }
}