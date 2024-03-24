provider "aws" {
  profile = var.profile
  region  = var.region

  default_tags {
    tags = {
      created_by = "terraform"
      workspace  = terraform.workspace
      project    = "terraform-static-website"
    }
  }
}
resource "aws_s3_bucket" "this" {
  bucket              = "tsw-terraform-state-backend"
  object_lock_enabled = true

  tags = {
    name    = "S3 Remote Terraform State Store"
    project = "terraform-static-website"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Action" : [
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : ["${aws_s3_bucket.this.arn}"],
        "Principal" : { "AWS" : "arn:aws:iam::${var.account_id}:root" }
      },
      {
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${aws_s3_bucket.this.arn}/*"
        ],
        "Principal" : { "AWS" : "arn:aws:iam::${var.account_id}:root" }
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.this]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "ObjectWriter"
  }
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
