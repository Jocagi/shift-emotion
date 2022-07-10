resource "aws_cloudwatch_log_group" "lambda_getEmotions" {

  name              = "/aws/lambda/${aws_lambda_function.getEmotion.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getGenres" {

  name              = "/aws/lambda/${aws_lambda_function.getGenres.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getRecommendation" {

  name              = "/aws/lambda/${aws_lambda_function.getRecommendation.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getRecommendations" {

  name              = "/aws/lambda/${aws_lambda_function.getRecommendations.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getTrack" {

  name              = "/aws/lambda/${aws_lambda_function.getTrack.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getTracks" {

  name              = "/aws/lambda/${aws_lambda_function.getTracks.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getValence" {

  name              = "/aws/lambda/${aws_lambda_function.getValence.function_name}"
  retention_in_days = 30
}
