## [POST] /face-details - Lambda function getEmotion
resource "aws_api_gateway_method" "face_details_post" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.face_details.id
  api_key_required = true
  http_method      = "POST"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "face_details_post_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_post.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getEmotion" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.face_details.id
  http_method             = aws_api_gateway_method.face_details_post.http_method
  integration_http_method = aws_api_gateway_method.face_details_post.http_method

  uri = aws_lambda_function.getEmotion.invoke_arn

  type                 = "AWS"
  content_handling     = "CONVERT_TO_TEXT"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "image/jpeg"       = "{\"content\": \"$input.body\"}",
    "image/png"        = "{\"content\": \"$input.body\"}"
  }
}

resource "aws_api_gateway_integration_response" "lambda_getEmotion" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_post.http_method
  status_code = aws_api_gateway_method_response.face_details_post_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getEmotion
  ]
}

resource "aws_lambda_permission" "getEmotion_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getEmotion.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.face_details_post.http_method}/${aws_api_gateway_resource.face_details.path_part}"
}

## [OPTIONS] /face-details - CORS
resource "aws_api_gateway_method" "face_details_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.face_details.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "face_details_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "face_details_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "face_details_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_cors.http_method
  status_code = aws_api_gateway_method_response.face_details_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.face_details_cors
  ]
}
