resource "aws_s3_bucket" "website" {

  bucket        = "${var.app_name}-website"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "website" {

  bucket = aws_s3_bucket.website.id
  acl    = "private"
}

// AWS IAM data for S3 bucket's website policy
/*
data "aws_iam_policy_document" "website_s3" {

  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.OAI.iam_arn]
    }
    resources = [
      "${aws_s3_bucket.website.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "website" {

  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website_s3.json
  
  depends_on = [
    aws_cloudfront_origin_access_identity.OAI
  ]
  
}
*/
/*
resource "aws_s3_bucket_website_configuration" "website" {

  bucket = aws_s3_bucket.website.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}
*/