resource "aws_lambda_function" "getEmotion" {

  function_name = "${var.app_name}-getEmotion"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getEmotion_zip.key

  source_code_hash = data.archive_file.getEmotion_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.rekognition_photos.bucket
    }
  }

  depends_on = [
    aws_s3_bucket.rekognition_photos
  ]
}