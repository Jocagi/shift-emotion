resource "aws_s3_bucket" "admin_website" {

  bucket        = "${var.app_name}-admin-website"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "admin_website" {

  bucket = aws_s3_bucket.admin_website.id
  acl    = "public-read"
}

// AWS IAM data for S3 bucket's website policy
data "aws_iam_policy_document" "admin_website_s3" {

  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "${aws_s3_bucket.admin_website.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "admin_website" {

  bucket = aws_s3_bucket.admin_website.id
  policy = data.aws_iam_policy_document.admin_website_s3.json
}

resource "aws_s3_bucket_website_configuration" "admin_website" {

  bucket = aws_s3_bucket.admin_website.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}
