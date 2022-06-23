// S3 for photos used for rekognition emotions service
resource "aws_s3_bucket" "rekognition_photos" {

  bucket        = "${var.app_name}-rekognition-photos"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "rekognition_photos" {

  bucket = aws_s3_bucket.rekognition_photos.id
  acl    = "private"
}
