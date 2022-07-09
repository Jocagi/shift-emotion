// S3 for photos used for rekognition emotions service
resource "aws_s3_bucket" "rekognition_photos" {

  bucket        = "${var.app_name}-rekognition-photos"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "rekognition_photos" {

  bucket = aws_s3_bucket.rekognition_photos.id
  acl    = "private"
}

// S3 for content website
resource "aws_s3_bucket" "content_website" {

  bucket        = "${var.app_name}-content-website"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "content_website" {

  bucket = aws_s3_bucket.content_website.id
  acl    = "private"
}

// S3 for store lambdas zip files
resource "aws_s3_bucket" "s3_lambdas" {

  bucket        = "${var.app_name}-lambdas-src-code"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "ACL_s3_lambdas" {

  bucket = aws_s3_bucket.s3_lambdas.id
  acl    = "private"
}

// S3 Bucket objets for lambdas zip files
resource "aws_s3_object" "getEmotion_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getEmotion.zip"
  source = data.archive_file.getEmotion_zip.output_path

  etag = filemd5(data.archive_file.getEmotion_zip.output_path)
}
