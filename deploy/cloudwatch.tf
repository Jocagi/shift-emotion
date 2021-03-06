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

resource "aws_cloudwatch_log_group" "lambda_history-del-id" {

  name              = "/aws/lambda/${aws_lambda_function.history-del-id.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_history-get-all" {

  name              = "/aws/lambda/${aws_lambda_function.history-get-all.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_history-get-my" {

  name              = "/aws/lambda/${aws_lambda_function.history-get-my.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_history-get-user" {

  name              = "/aws/lambda/${aws_lambda_function.history-get-user.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_history-put" {

  name              = "/aws/lambda/${aws_lambda_function.history-put.function_name}"
  retention_in_days = 30
}
