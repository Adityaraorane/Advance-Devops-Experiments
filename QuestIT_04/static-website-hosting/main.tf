terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.6.2"
    }
  }
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "raoranewebapp-bucket" {
  bucket = "raoranewebapp-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "index_html"{
  bucket = aws_s3_bucket.raoranewebapp-bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css"{
  bucket = aws_s3_bucket.raoranewebapp-bucket.bucket
  source = "./styles.css"
  key = "styles.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.raoranewebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "raoranenew" {
  bucket = aws_s3_bucket.raoranewebapp-bucket.id
  policy = jsonencode(
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action: "s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.raoranewebapp-bucket.id}/*"
            
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.raoranewebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "website_endpoint" {
    value = "aws_s3_bucket_website_configuration.example.website_endpoint"
  }