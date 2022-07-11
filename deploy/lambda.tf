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

resource "aws_lambda_function" "getGenres" {

  function_name = "${var.app_name}-getGenres"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getGenres_zip.key

  source_code_hash = data.archive_file.getGenres_zip.output_base64sha256

  role = aws_iam_role.spotify_service.arn
}

resource "aws_lambda_function" "getRecommendation" {

  function_name = "${var.app_name}-getRecommendation"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getRecomendation_zip.key

  source_code_hash = data.archive_file.getRecomendation_zip.output_base64sha256

  role = aws_iam_role.spotify_service.arn
}

resource "aws_lambda_function" "getRecommendations" {

  function_name = "${var.app_name}-getRecommendations"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getRecomendations_zip.key

  source_code_hash = data.archive_file.getRecomendations_zip.output_base64sha256

  role = aws_iam_role.spotify_service.arn
}

resource "aws_lambda_function" "getTrack" {

  function_name = "${var.app_name}-getTrack"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getTrack_zip.key

  source_code_hash = data.archive_file.getTrack_zip.output_base64sha256

  role = aws_iam_role.spotify_service.arn
}

resource "aws_lambda_function" "getTracks" {

  function_name = "${var.app_name}-getTracks"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getTracks_zip.key

  source_code_hash = data.archive_file.getTracks_zip.output_base64sha256

  role = aws_iam_role.spotify_service.arn
}

resource "aws_lambda_function" "getValence" {

  function_name = "${var.app_name}-getValence"
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getValence_zip.key

  source_code_hash = data.archive_file.getValence_zip.output_base64sha256

  role = aws_iam_role.spotify_service.arn
}
