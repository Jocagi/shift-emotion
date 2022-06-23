resource "aws_cloudwatch_log_group" "lambda_getEmotions" {

  name              = "/aws/lambda/${aws_lambda_function.getEmotion.function_name}"
  retention_in_days = 30
}