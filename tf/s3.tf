#https bucket
resource "aws_s3_bucket" "chitralimbu_bucket" {
  bucket = "www.${var.bucket_name}"

  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "chitralimbu_bucket_acl" {
  bucket = aws_s3_bucket.chitralimbu_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_cors_configuration" "chitralimbu_cors_config" {
  bucket = aws_s3_bucket.chitralimbu_bucket.bucket
  cors_rule {
    allowed_headers = ["Authorization", "Conent-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "chitralimbu_bucket_website" {
  bucket = aws_s3_bucket.chitralimbu_bucket.bucket
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_policy" "chitralimbu_bucket_policy" {
  bucket = aws_s3_bucket.chitralimbu_bucket.bucket
  policy = templatefile("templates/s3Policy.json", {
    bucket = "www.${var.bucket_name}"
  })
}

resource "aws_s3_bucket_versioning" "chitralimbu_bucket_versioning" {
  bucket = aws_s3_bucket.chitralimbu_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

#http bucket redirect to https
resource "aws_s3_bucket" "chitralimbu_root_bucket" {
  bucket = var.bucket_name

  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "chitralimbu_root_bucket_acl" {
  bucket = aws_s3_bucket.chitralimbu_root_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "chitralimbu_root_website_config" {
  bucket = aws_s3_bucket.chitralimbu_root_bucket.bucket
  redirect_all_requests_to {
    host_name = "https://www.${var.domain_name}"
  }
}

resource "aws_s3_bucket_policy" "chitralimbu_root_bucket_policy" {
  bucket = aws_s3_bucket.chitralimbu_root_bucket.bucket
  policy = templatefile("templates/s3Policy.json", {
    bucket = var.bucket_name
  })
}

resource "aws_s3_bucket_versioning" "chitralimbu_root_bucket_versioning" {
  bucket = aws_s3_bucket.chitralimbu_root_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}
