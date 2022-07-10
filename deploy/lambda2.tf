resource "aws_lambda_function" "hello" {

  function_name = "${var.app_name}-hello"
  handler       = "hello_function.handler"
  runtime       = var.runtime.nodejs
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.hello_zip.key

  source_code_hash = data.archive_file.hello_zip.output_base64sha256

  role = aws_iam_role.hello_service.arn

}

resource "aws_lambda_function" "register" {

  function_name = "${var.app_name}-register"
  handler       = "register.handler"
  runtime       = var.runtime.nodejs
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.register_zip.key

  source_code_hash = data.archive_file.register_zip.output_base64sha256

  role = aws_iam_role.register_service.arn

  environment {
    variables = {
      REGION = var.provider_conf.region
    }
  }
}

resource "aws_lambda_function" "login" {

  function_name = "${var.app_name}-login"
  handler       = "login.handler"
  runtime       = var.runtime.nodejs
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.login_zip.key

  source_code_hash = data.archive_file.login_zip.output_base64sha256

  role = aws_iam_role.login_service.arn

  environment {
    variables = {
      REGION = var.provider_conf.region
      JWT_SECRET = var.jwt_secret
    }
  }

}

resource "aws_lambda_function" "authorize" {

  function_name = "${var.app_name}-authorize"
  handler       = "authorize.handler"
  runtime       = var.runtime.nodejs
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.authorize_zip.key

  source_code_hash = data.archive_file.authorize_zip.output_base64sha256

  role = aws_iam_role.authorize_service.arn

  environment {
    variables = {
      REGION = var.provider_conf.region
      JWT_SECRET = var.jwt_secret
    }
  }
}

resource "aws_lambda_function" "profile" {

  function_name = "${var.app_name}-profile"
  handler       = "profile.handler"
  runtime       = var.runtime.nodejs
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.profile_zip.key

  source_code_hash = data.archive_file.profile_zip.output_base64sha256

  role = aws_iam_role.profile_service.arn

  environment {
    variables = {
      REGION = var.provider_conf.region
      JWT_SECRET = var.jwt_secret
    }
  }
}