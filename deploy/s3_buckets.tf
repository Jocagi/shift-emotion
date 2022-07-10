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

// Bucket objets of lambdas zip files
resource "aws_s3_object" "getEmotion_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getEmotion.zip"
  source = data.archive_file.getEmotion_zip.output_path

  etag = filemd5(data.archive_file.getEmotion_zip.output_path)
}

resource "aws_s3_object" "getGenres_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getGenres.zip"
  source = data.archive_file.getGenres_zip.output_path

  etag = filemd5(data.archive_file.getGenres_zip.output_path)
}

resource "aws_s3_object" "getRecomendation_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getRecomendation.zip"
  source = data.archive_file.getRecomendation_zip.output_path

  etag = filemd5(data.archive_file.getRecomendation_zip.output_path)
}

resource "aws_s3_object" "getRecomendations_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getRecomendations.zip"
  source = data.archive_file.getRecomendations_zip.output_path

  etag = filemd5(data.archive_file.getRecomendations_zip.output_path)
}

resource "aws_s3_object" "getTrack_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getTrack.zip"
  source = data.archive_file.getTrack_zip.output_path

  etag = filemd5(data.archive_file.getTrack_zip.output_path)
}

resource "aws_s3_object" "getTracks_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getTracks.zip"
  source = data.archive_file.getTracks_zip.output_path

  etag = filemd5(data.archive_file.getTracks_zip.output_path)
}

resource "aws_s3_object" "getValence_zip" {

  bucket = aws_s3_bucket.s3_lambdas.id

  key    = "lambda_getValence.zip"
  source = data.archive_file.getValence_zip.output_path

  etag = filemd5(data.archive_file.getValence_zip.output_path)
}
