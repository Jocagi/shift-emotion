resource "aws_cloudwatch_log_group" "lambda_getEmotions" {

  name              = "/aws/lambda/${aws_lambda_function.getEmotion.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_hello" {

  name              = "/aws/lambda/${aws_lambda_function.hello.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_register" {

  name              = "/aws/lambda/${aws_lambda_function.register.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_login" {

  name              = "/aws/lambda/${aws_lambda_function.login.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_authorize" {

  name              = "/aws/lambda/${aws_lambda_function.authorize.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_profile" {

  name              = "/aws/lambda/${aws_lambda_function.profile.function_name}"
  retention_in_days = 30
}