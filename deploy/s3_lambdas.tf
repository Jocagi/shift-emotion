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
